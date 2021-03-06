
Move = Struct.new(:from, :to, :piece, :target, :mx, :castling, :ep, :half_moves, :full_moves)

WHITE, BLACK, EMPTY = 0, 1, 6
MID, LATE = 0, 1
INF = 9999999
MAXPLY = 16
MV_CAPACITY = 64_000

P, N, B, R, Q, K = 0, 1, 2, 3, 4, 5

STEP = [-21,-19,-12, -8,  8, 12, 19, 21].freeze
DIAG = [11, -11, -9, 9].freeze
ORTH = [1, 10, -1, -10].freeze
OCTL = [-9, 9, -11, 11, -10, 10, -1, 1].freeze
DIR = [-10, 10].freeze

CASTLING = {'K' => 8,'Q' => 4,'k' => 2,'q' => 1}.freeze
REMOVE_KSC, REMOVE_QSC = [8, 2].freeze, [4, 1].freeze
KSC, QSC = [3, 1].freeze, [2, 0].freeze
RQSC, RKSC = [91, 21].freeze, [98, 28].freeze
P_RANK = [8, 3].freeze

CONNECT = [12, 6, 5, 3, 1, 0, 0].freeze
DEFEND = [1, 3, 2, 1, 0, 0, 0].freeze
FRONT = [-16, 0, 0, -8, 0, 4, 0].freeze
BEHIND = [-16, -8, -8, -8, -16, -16, 0].freeze
BLOCK = [4, 0, -8, 0,-2, 4, 0].freeze
UNDEV = [0, 4, 0, -8, -16, -16, -8, 0, 4, 0].freeze

SQ = [
  21, 22, 23, 24, 25, 26, 27, 28,
  31, 32, 33, 34, 35, 36, 37, 38,
  41, 42, 43, 44, 45, 46, 47, 48,
  51, 52, 53, 54, 55, 56, 57, 58,
  61, 62, 63, 64, 65, 66, 67, 68,
  71, 72, 73, 74, 75, 76, 77, 78,
  81, 82, 83, 84, 85, 86, 87, 88,
  91, 92, 93, 94, 95, 96, 97, 98
].freeze

SQ64 = [
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 1, 2, 3, 4, 5, 6, 7, 0,
  0, 8, 9,10,11,12,13,14,15, 0,
  0,16,17,18,19,20,21,22,23, 0,
  0,24,25,26,27,28,29,30,31, 0,
  0,32,33,34,35,36,37,38,39, 0,
  0,40,41,42,43,44,45,46,47, 0,
  0,48,49,50,51,52,53,54,55, 0,
  0,56,57,58,59,60,61,62,63, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
].freeze

FLIP = [[
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1, 2, 3, 4, 5, 6, 7, 0,
    0, 8, 9,10,11,12,13,14,15, 0,
    0,16,17,18,19,20,21,22,23, 0,
    0,24,25,26,27,28,29,30,31, 0,
    0,32,33,34,35,36,37,38,39, 0,
    0,40,41,42,43,44,45,46,47, 0,
    0,48,49,50,51,52,53,54,55, 0,
    0,56,57,58,59,60,61,62,63, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  ].freeze,[
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0,56,57,58,59,60,61,62,63, 0,
    0,48,49,50,51,52,53,54,55, 0,
    0,40,41,42,43,44,45,46,47, 0,
    0,32,33,34,35,36,37,38,39, 0,
    0,24,25,26,27,28,29,30,31, 0,
    0,16,17,18,19,20,21,22,23, 0,
    0, 8, 9,10,11,12,13,14,15, 0,
    0, 0, 1, 2, 3, 4, 5, 6, 7, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  ].freeze].freeze

REGION_A = [
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
  -1, 0, 0, 0, 1, 1, 2, 2, 2,-1,
  -1, 0, 0, 0, 1, 1, 2, 2, 2,-1,
  -1, 3, 3, 3, 4, 4, 5, 5, 5,-1,
  -1, 3, 3, 3, 4, 4, 5, 5, 5,-1,
  -1, 6, 6, 6, 7, 7, 8, 8, 8,-1,
  -1, 6, 6, 6, 7, 7, 8, 8, 8,-1,
  -1, 9, 9, 9,10,10,11,11,11,-1,
  -1, 9, 9, 9,10,10,11,11,11,-1,
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1
].freeze

REGION_B = [
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
  -1, 0, 0, 1, 1, 2, 2, 3, 3,-1,
  -1, 0, 0, 1, 1, 2, 2, 3, 3,-1,
  -1, 4, 4, 5, 5, 6, 6, 7, 7,-1,
  -1, 4, 4, 5, 5, 6, 6, 7, 7,-1,
  -1, 8, 8, 9, 9,10,10,11,11,-1,
  -1, 8, 8, 9, 9,10,10,11,11,-1,
  -1,12,12,13,13,14,14,15,15,-1,
  -1,12,12,13,13,14,14,15,15,-1,
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
  -1,-1,-1,-1,-1,-1,-1,-1,-1,-1
].freeze

DIAG_A = [
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 7, 8, 9,10,11,12,13,14, 0,
  0, 6, 7, 8, 9,10,11,12,13, 0,
  0, 5, 6, 7, 8, 9,10,11,12, 0,
  0, 4, 5, 6, 7, 8, 9,10,11, 0,
  0, 3, 4, 5, 6, 7, 8, 9,10, 0,
  0, 2, 3, 4, 5, 6, 7, 8, 9, 0,
  0, 1, 2, 3, 4, 5, 6, 7, 8, 0,
  0, 0, 1, 2, 3, 4, 5, 6, 7, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
].freeze

DIAG_B = [
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0,14,13,12,11,10, 9, 8, 7, 0,
  0,13,12,11,10, 9, 8, 7, 6, 0,
  0,12,11,10, 9, 8, 7, 6, 5, 0,
  0,11,10, 9, 8, 7, 6, 5, 4, 0,
  0,10, 9, 8, 7, 6, 5, 4, 3, 0,
  0, 9, 8, 7, 6, 5, 4, 3, 2, 0,
  0, 8, 7, 6, 5, 4, 3, 2, 1, 0,
  0, 7, 6, 5, 4, 3, 2, 1, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
].freeze

CENTER = [
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 1, 1, 2, 2, 1, 1, 0, 0,
  0, 1, 2, 3, 4, 4, 3, 2, 1, 0,
  0, 1, 2, 3, 4, 4, 3, 2, 1, 0,
  0, 0, 1, 1, 2, 2, 1, 1, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0
].freeze

P_PST = [[
    96, 96, 96, 96, 96, 96, 96, 96,
    72, 80, 80, 88, 88, 80, 80, 72,
    40, 48, 56, 64, 64, 56, 40, 32,
   -16, -4,  8, 16, 16,  8, -4,-16,
   -16, -4, 16, 32, 32, 16, -4,-16,
    -8, -4,  4,  0,  0,  4, -4, -8,
    16, 24,  0,  4,  4,  0, 24, 16,
     0,  0,  0,  0,  0,  0,  0,  0
  ].freeze,[
    96, 96, 96, 96, 96, 96, 96, 96,
    96, 96, 96, 96, 96, 96, 96, 96,
    88, 80, 80, 72, 72, 80, 80, 88,
    24, 16,  8,  4,  4,  8, 16, 24,
    16,  8,  4,  0,  0,  4,  8, 16,
     4,  2, -2, -4, -4, -2,  2,  4,
     4,  2, -2, -4, -4, -2,  2,  4,
     0,  0,  0,  0,  0,  0,  0,  0
  ].freeze].freeze

N_PST = [[
   -96,-24,-16, -8, -8,-16,-24,-96,
   -16, -8,  0,  4,  4,  0, -8,-16,
    -4,  4, 16, 24, 24, 16,  4, -4,
    -4,  4, 16, 24, 24, 16,  4, -4,
    -8,  0,  8, 16, 16,  8,  0, -8,
   -16, -8, -4,  4,  4, -4, -8,-16,
   -32,-24,-16, -8, -8,-16,-24,-32,
   -48,-24,-24,-24,-24,-24,-24,-48
  ].freeze,[
   -40,-32,-24,-16,-16,-24,-32,-40,
   -32,-16, -8, -4, -4, -8,-16,-32,
   -24, -8,  0,  4,  4,  0, -8,-24,
   -16, -4,  4,  8,  8,  4, -4,-16,
   -16, -4,  4,  8,  8,  4, -4,-16,
   -24, -8,  0,  4,  4,  0, -8,-24,
   -32,-16, -8, -4, -4, -8,-16,-32,
   -40,-32,-24,-16,-16,-24,-32,-40
  ].freeze].freeze

B_PST = [[
    -4, -4, -4, -4, -4, -4, -4, -4,
    -4,  0,  0,  0,  0,  0,  0, -4,
    -4,  0,  4,  4,  4,  4,  0, -4,
    -4,  0,  4, 16, 16,  4,  0, -4,
    -4,  0,  8, 16, 16,  8,  0, -4,
    -4,  4,  8,  8,  8,  8,  4, -4,
    -4,  8,  4,  8,  8,  4,  8, -4,
    -4, -4,-16, -4, -4,-16, -4, -4
  ].freeze,[
   -16, -8, -4, -4, -4, -4, -8,-16,
    -8, -8,  0,  4,  4,  0, -8, -8,
    -4,  0,  4,  8,  8,  4,  0, -4,
    -4,  4,  8, 16, 16,  8,  4, -4,
    -4,  4,  8, 16, 16,  8,  4, -4,
    -4,  0,  4,  8,  8,  4,  0, -4,
    -8, -8,  0,  4,  4,  0, -8, -8,
   -16, -8, -4, -4, -4, -4, -8,-16
  ].freeze].freeze

R_PST = [[
     4,  4,  4,  4,  4,  4,  4,  4,
    16, 16, 16, 16, 16, 16, 16, 16,
    -8, -4,  0,  2,  2,  0, -4, -8,
    -8, -4,  0,  2,  2,  0, -4, -8,
    -8, -4,  0,  2,  2,  0, -4, -8,
    -8, -4,  0,  2,  2,  0, -4, -8,
    -8, -4,  0,  2,  2,  0, -4, -8,
     0,  2,  4,  4,  4,  4,  2,  0
  ].freeze,[
     8,  8,  8,  8,  8,  8,  8,  8,
    32, 32, 32, 32, 32, 32, 32, 32,
    -4, -2,  0,  2,  2,  0, -2, -4,
    -4, -2,  0,  2,  2,  0, -2, -4,
    -4, -2,  0,  2,  2,  0, -2, -4,
    -4, -2,  0,  2,  2,  0, -2, -4,
    -4, -2,  0,  2,  2,  0, -2, -4,
     0,  0,  0,  0,  0,  0,  0,  0
  ].freeze].freeze

Q_PST = [[
      0,  0,  0,  0,  0,  0,  0,  0,
      8,  8,  8,  8,  8,  8,  8,  8,
      0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0,  0,  0,
     -4, -4, -4, -4, -4, -4, -4, -4
  ].freeze,[
    -32,-24,-16, -8, -8,-16,-24,-32,
    -24,-16, -4,  0,  0, -4,-16,-24,
    -16, -4,  0,  4,  4,  0, -4,-16,
     -8,  0,  4,  8,  8,  4,  0, -8,
     -8,  0,  4,  8,  8,  4,  0, -8,
    -16, -4,  0,  4,  4,  0, -4,-16,
    -24,-16, -4,  0,  0, -4,-16,-24,
    -32,-24,-16, -8, -8,-16,-24,-32
  ].freeze].freeze

K_PST = [[
    -40,-32,-48,-64,-64,-48,-32,-40,
    -32,-24,-40,-56,-56,-40,-24,-32,
    -24,-16,-32,-48,-48,-32,-16,-24,
     -8,  0,-24,-40,-40,-24,  0, -8,
      0,  8, -8,-24,-24, -8,  8,  0,
      8, 24,  0,-16,-16,  0, 24,  8,
     32, 40, 24,  0,  0, 24, 40, 32,
     40, 48, 32,  8,  8, 32, 48, 40
  ].freeze, [
    -72,-48,-32,-24,-24,-32,-48,-72,
    -48,-24,-16,  0,  0,-16,-24,-48,
    -32,-16,  0, 16, 16,  0,-16,-32,
    -24,  0, 16, 24, 24, 16,  0,-24,
    -24,  0, 16, 24, 24, 16,  0,-24,
    -32,-16,  0, 16, 16,  0,-16,-32,
    -48,-24,-16,  0,  0,-16,-24,-48,
    -72,-48,-32,-24,-24,-32,-48,-72
  ].freeze].freeze

SQ_ID = [
  '-' ,'..','..','..','..','..','..','..','..','..',
  '..','..','..','..','..','..','..','..','..','..',
  '..','a8','b8','c8','d8','e8','f8','g8','h8','..',
  '..','a7','b7','c7','d7','e7','f7','g7','h7','..',
  '..','a6','b6','c6','d6','e6','f6','g6','h6','..',
  '..','a5','b5','c5','d5','e5','f5','g5','h5','..',
  '..','a4','b4','c4','d4','e4','f4','g4','h4','..',
  '..','a3','b3','c3','d3','e3','f3','g3','h3','..',
  '..','a2','b2','c2','d2','e2','f2','g2','h2','..',
  '..','a1','b1','c1','d1','e1','f1','g1','h1','..',
  '..','..','..','..','..','..','..','..','..','..',
  '..','..','..','..','..','..','..','..','..','..'
].freeze

FEN_START = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
FEN = { 'P' => [0, 0], 'N' => [0, 1], 'B' => [0, 2], 'R' => [0, 3], 'Q' => [0, 4], 'K' => [0, 5],
        'p' => [1, 0], 'n' => [1, 1], 'b' => [1, 2], 'r' => [1, 3], 'q' => [1, 4], 'k' => [1, 5],
        '6' => [6, 6] }
TO_FEN = [['P', 'N', 'B', 'R', 'Q', 'K'], ['p', 'n', 'b', 'r', 'q', 'k']]

SAN = ['','N','B','R','Q','K']

CLR = ['w','b']
FILE = ['a','b','c','d','e','f','g','h']
RANK = ['1','2','3','4','5','6','7','8']
UTF8 = [['♙', '♘', '♗', '♖', '♕', '♔'], ['♟', '♞', '♝', '♜', '♛', '♚']]

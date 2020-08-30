Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18BDC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 00:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFED20665
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 00:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgH3Au3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 20:50:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:57758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbgH3Au1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 20:50:27 -0400
IronPort-SDR: 6sb9Dw+5dDvyQ4sGLIvZOeoFJ3SDQhwbSG+y7tBvdQRZzARUdZJ3DSCb9EursYYHOhC0ImLNb7
 Dmq8yvKlNP9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9728"; a="157841722"
X-IronPort-AV: E=Sophos;i="5.76,369,1592895600"; 
   d="gz'50?scan'50,208,50";a="157841722"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 17:50:24 -0700
IronPort-SDR: XktRAc+sx9rbSxRGGenqqO++gI7tedVFNXe4SdUBi06c42iVHi3I1kXNstQ9WUuleH71JtmMFg
 8ki3a96k+QGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,369,1592895600"; 
   d="gz'50?scan'50,208,50";a="337861972"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2020 17:50:21 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCBY5-0000jM-8P; Sun, 30 Aug 2020 00:50:21 +0000
Date:   Sun, 30 Aug 2020 08:50:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258:
 undefined reference to `__ubsan_handle_type_mismatch_v1'
Message-ID: <202008300858.7W4rp9Ir%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1127b219ce9481c84edad9711626d856127d5e51
commit: 8d58f222e85f01da0c0e1fc1e77986c86de889e2 ubsan: disable UBSAN_ALIGNMENT under COMPILE_TEST
date:   4 months ago
config: mips-randconfig-r025-20200829 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8d58f222e85f01da0c0e1fc1e77986c86de889e2
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `zlib_inflate_table':
>> arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:240: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:240: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:240: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:240: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:96: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:96: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:94: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:94: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:101: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:96: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:101: undefined reference to `__ubsan_handle_type_mismatch_v1'
>> mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:133: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:133: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:133: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:113: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:113: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:129: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:129: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:129: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:129: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:129: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:129: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:120: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:120: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:219: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:256: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:265: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:228: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:220: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258: undefined reference to `__ubsan_handle_out_of_bounds'
>> mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c:258: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `inflate_fast':
   arch/mips/boot/compressed/../../../../lib/zlib_inflate/inffast.c:318: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inffast.c:308: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inffast.c:176: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inffast.c:135: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inffast.c:134: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/decompress.o:arch/mips/boot/compressed/../../../../lib/zlib_inflate/inffast.c:149: more undefined references to `__ubsan_handle_shift_out_of_bounds' follow
   mipsel-linux-ld: arch/mips/boot/compressed/decompress.o: in function `zlib_inflate':
   arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:550: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:491: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:491: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:491: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:526: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:515: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:487: undefined reference to `__ubsan_handle_type_mismatch_v1'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:487: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:487: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:514: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:532: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:587: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:641: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:510: undefined reference to `__ubsan_handle_shift_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/decompress.o:arch/mips/boot/compressed/../../../../lib/zlib_inflate/inflate.c:508: more undefined references to `__ubsan_handle_shift_out_of_bounds' follow
   mipsel-linux-ld: arch/mips/boot/compressed/dbg.o: in function `puthex':
   arch/mips/boot/compressed/dbg.c:32: undefined reference to `__ubsan_handle_out_of_bounds'
   mipsel-linux-ld: arch/mips/boot/compressed/dbg.c:32: undefined reference to `__ubsan_handle_type_mismatch_v1'

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d58f222e85f01da0c0e1fc1e77986c86de889e2
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 8d58f222e85f01da0c0e1fc1e77986c86de889e2
vim +258 arch/mips/boot/compressed/../../../../lib/zlib_inflate/inftrees.c

4f3865fb57a04db Richard Purdie 2006-06-22   10  
4f3865fb57a04db Richard Purdie 2006-06-22   11  /*
4f3865fb57a04db Richard Purdie 2006-06-22   12     Build a set of tables to decode the provided canonical Huffman code.
4f3865fb57a04db Richard Purdie 2006-06-22   13     The code lengths are lens[0..codes-1].  The result starts at *table,
4f3865fb57a04db Richard Purdie 2006-06-22   14     whose indices are 0..2^bits-1.  work is a writable array of at least
4f3865fb57a04db Richard Purdie 2006-06-22   15     lens shorts, which is used as a work area.  type is the type of code
4f3865fb57a04db Richard Purdie 2006-06-22   16     to be generated, CODES, LENS, or DISTS.  On return, zero is success,
4f3865fb57a04db Richard Purdie 2006-06-22   17     -1 is an invalid code, and +1 means that ENOUGH isn't enough.  table
4f3865fb57a04db Richard Purdie 2006-06-22   18     on return points to the next available entry's address.  bits is the
4f3865fb57a04db Richard Purdie 2006-06-22   19     requested root table index bits, and on return it is the actual root
4f3865fb57a04db Richard Purdie 2006-06-22   20     table index bits.  It will differ if the request is greater than the
4f3865fb57a04db Richard Purdie 2006-06-22   21     longest code or if it is less than the shortest code.
4f3865fb57a04db Richard Purdie 2006-06-22   22   */
b762450e84e20a1 Randy Dunlap   2006-06-27   23  int zlib_inflate_table(codetype type, unsigned short *lens, unsigned codes,
b762450e84e20a1 Randy Dunlap   2006-06-27   24  			code **table, unsigned *bits, unsigned short *work)
4f3865fb57a04db Richard Purdie 2006-06-22   25  {
4f3865fb57a04db Richard Purdie 2006-06-22   26      unsigned len;               /* a code's length in bits */
4f3865fb57a04db Richard Purdie 2006-06-22   27      unsigned sym;               /* index of code symbols */
4f3865fb57a04db Richard Purdie 2006-06-22   28      unsigned min, max;          /* minimum and maximum code lengths */
4f3865fb57a04db Richard Purdie 2006-06-22   29      unsigned root;              /* number of index bits for root table */
4f3865fb57a04db Richard Purdie 2006-06-22   30      unsigned curr;              /* number of index bits for current table */
4f3865fb57a04db Richard Purdie 2006-06-22   31      unsigned drop;              /* code bits to drop for sub-table */
4f3865fb57a04db Richard Purdie 2006-06-22   32      int left;                   /* number of prefix codes available */
4f3865fb57a04db Richard Purdie 2006-06-22   33      unsigned used;              /* code entries in table used */
4f3865fb57a04db Richard Purdie 2006-06-22   34      unsigned huff;              /* Huffman code */
4f3865fb57a04db Richard Purdie 2006-06-22   35      unsigned incr;              /* for incrementing code, index */
4f3865fb57a04db Richard Purdie 2006-06-22   36      unsigned fill;              /* index for replicating entries */
4f3865fb57a04db Richard Purdie 2006-06-22   37      unsigned low;               /* low bits for current root entry */
4f3865fb57a04db Richard Purdie 2006-06-22   38      unsigned mask;              /* mask for low root bits */
4f3865fb57a04db Richard Purdie 2006-06-22   39      code this;                  /* table entry for duplication */
4f3865fb57a04db Richard Purdie 2006-06-22   40      code *next;             /* next available space in table */
4f3865fb57a04db Richard Purdie 2006-06-22   41      const unsigned short *base;     /* base value table to use */
4f3865fb57a04db Richard Purdie 2006-06-22   42      const unsigned short *extra;    /* extra bits table to use */
4f3865fb57a04db Richard Purdie 2006-06-22   43      int end;                    /* use base and extra for symbol > end */
4f3865fb57a04db Richard Purdie 2006-06-22   44      unsigned short count[MAXBITS+1];    /* number of codes of each length */
4f3865fb57a04db Richard Purdie 2006-06-22   45      unsigned short offs[MAXBITS+1];     /* offsets in table for each length */
4f3865fb57a04db Richard Purdie 2006-06-22   46      static const unsigned short lbase[31] = { /* Length codes 257..285 base */
^1da177e4c3f415 Linus Torvalds 2005-04-16   47          3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
^1da177e4c3f415 Linus Torvalds 2005-04-16   48          35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258, 0, 0};
4f3865fb57a04db Richard Purdie 2006-06-22   49      static const unsigned short lext[31] = { /* Length codes 257..285 extra */
4f3865fb57a04db Richard Purdie 2006-06-22   50          16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18,
4f3865fb57a04db Richard Purdie 2006-06-22   51          19, 19, 19, 19, 20, 20, 20, 20, 21, 21, 21, 21, 16, 201, 196};
4f3865fb57a04db Richard Purdie 2006-06-22   52      static const unsigned short dbase[32] = { /* Distance codes 0..29 base */
^1da177e4c3f415 Linus Torvalds 2005-04-16   53          1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
^1da177e4c3f415 Linus Torvalds 2005-04-16   54          257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
4f3865fb57a04db Richard Purdie 2006-06-22   55          8193, 12289, 16385, 24577, 0, 0};
4f3865fb57a04db Richard Purdie 2006-06-22   56      static const unsigned short dext[32] = { /* Distance codes 0..29 extra */
4f3865fb57a04db Richard Purdie 2006-06-22   57          16, 16, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22,
4f3865fb57a04db Richard Purdie 2006-06-22   58          23, 23, 24, 24, 25, 25, 26, 26, 27, 27,
4f3865fb57a04db Richard Purdie 2006-06-22   59          28, 28, 29, 29, 64, 64};
^1da177e4c3f415 Linus Torvalds 2005-04-16   60  
^1da177e4c3f415 Linus Torvalds 2005-04-16   61      /*
4f3865fb57a04db Richard Purdie 2006-06-22   62         Process a set of code lengths to create a canonical Huffman code.  The
4f3865fb57a04db Richard Purdie 2006-06-22   63         code lengths are lens[0..codes-1].  Each length corresponds to the
4f3865fb57a04db Richard Purdie 2006-06-22   64         symbols 0..codes-1.  The Huffman code is generated by first sorting the
4f3865fb57a04db Richard Purdie 2006-06-22   65         symbols by length from short to long, and retaining the symbol order
4f3865fb57a04db Richard Purdie 2006-06-22   66         for codes with equal lengths.  Then the code starts with all zero bits
4f3865fb57a04db Richard Purdie 2006-06-22   67         for the first code of the shortest length, and the codes are integer
4f3865fb57a04db Richard Purdie 2006-06-22   68         increments for the same length, and zeros are appended as the length
4f3865fb57a04db Richard Purdie 2006-06-22   69         increases.  For the deflate format, these bits are stored backwards
4f3865fb57a04db Richard Purdie 2006-06-22   70         from their more natural integer increment ordering, and so when the
4f3865fb57a04db Richard Purdie 2006-06-22   71         decoding tables are built in the large loop below, the integer codes
4f3865fb57a04db Richard Purdie 2006-06-22   72         are incremented backwards.
4f3865fb57a04db Richard Purdie 2006-06-22   73  
4f3865fb57a04db Richard Purdie 2006-06-22   74         This routine assumes, but does not check, that all of the entries in
4f3865fb57a04db Richard Purdie 2006-06-22   75         lens[] are in the range 0..MAXBITS.  The caller must assure this.
4f3865fb57a04db Richard Purdie 2006-06-22   76         1..MAXBITS is interpreted as that code length.  zero means that that
4f3865fb57a04db Richard Purdie 2006-06-22   77         symbol does not occur in this code.
4f3865fb57a04db Richard Purdie 2006-06-22   78  
4f3865fb57a04db Richard Purdie 2006-06-22   79         The codes are sorted by computing a count of codes for each length,
4f3865fb57a04db Richard Purdie 2006-06-22   80         creating from that a table of starting indices for each length in the
4f3865fb57a04db Richard Purdie 2006-06-22   81         sorted table, and then entering the symbols in order in the sorted
4f3865fb57a04db Richard Purdie 2006-06-22   82         table.  The sorted table is work[], with that space being provided by
4f3865fb57a04db Richard Purdie 2006-06-22   83         the caller.
4f3865fb57a04db Richard Purdie 2006-06-22   84  
4f3865fb57a04db Richard Purdie 2006-06-22   85         The length counts are used for other purposes as well, i.e. finding
4f3865fb57a04db Richard Purdie 2006-06-22   86         the minimum and maximum length codes, determining if there are any
4f3865fb57a04db Richard Purdie 2006-06-22   87         codes at all, checking for a valid set of lengths, and looking ahead
4f3865fb57a04db Richard Purdie 2006-06-22   88         at length counts to determine sub-table sizes when building the
4f3865fb57a04db Richard Purdie 2006-06-22   89         decoding tables.
^1da177e4c3f415 Linus Torvalds 2005-04-16   90       */
^1da177e4c3f415 Linus Torvalds 2005-04-16   91  
4f3865fb57a04db Richard Purdie 2006-06-22   92      /* accumulate lengths for codes (assumes lens[] all in 0..MAXBITS) */
4f3865fb57a04db Richard Purdie 2006-06-22   93      for (len = 0; len <= MAXBITS; len++)
4f3865fb57a04db Richard Purdie 2006-06-22   94          count[len] = 0;
4f3865fb57a04db Richard Purdie 2006-06-22   95      for (sym = 0; sym < codes; sym++)
4f3865fb57a04db Richard Purdie 2006-06-22   96          count[lens[sym]]++;
4f3865fb57a04db Richard Purdie 2006-06-22   97  
4f3865fb57a04db Richard Purdie 2006-06-22   98      /* bound code lengths, force root to be within code lengths */
4f3865fb57a04db Richard Purdie 2006-06-22   99      root = *bits;
4f3865fb57a04db Richard Purdie 2006-06-22  100      for (max = MAXBITS; max >= 1; max--)
4f3865fb57a04db Richard Purdie 2006-06-22  101          if (count[max] != 0) break;
4f3865fb57a04db Richard Purdie 2006-06-22  102      if (root > max) root = max;
4f3865fb57a04db Richard Purdie 2006-06-22  103      if (max == 0) {                     /* no symbols to code at all */
4f3865fb57a04db Richard Purdie 2006-06-22  104          this.op = (unsigned char)64;    /* invalid code marker */
4f3865fb57a04db Richard Purdie 2006-06-22  105          this.bits = (unsigned char)1;
4f3865fb57a04db Richard Purdie 2006-06-22  106          this.val = (unsigned short)0;
4f3865fb57a04db Richard Purdie 2006-06-22  107          *(*table)++ = this;             /* make a table to force an error */
4f3865fb57a04db Richard Purdie 2006-06-22  108          *(*table)++ = this;
4f3865fb57a04db Richard Purdie 2006-06-22  109          *bits = 1;
4f3865fb57a04db Richard Purdie 2006-06-22  110          return 0;     /* no symbols, but wait for decoding to report error */
4f3865fb57a04db Richard Purdie 2006-06-22  111      }
da5e108b0288d39 Guenter Roeck  2017-05-08  112      for (min = 1; min < MAXBITS; min++)
4f3865fb57a04db Richard Purdie 2006-06-22  113          if (count[min] != 0) break;
4f3865fb57a04db Richard Purdie 2006-06-22  114      if (root < min) root = min;
4f3865fb57a04db Richard Purdie 2006-06-22  115  
4f3865fb57a04db Richard Purdie 2006-06-22  116      /* check for an over-subscribed or incomplete set of lengths */
4f3865fb57a04db Richard Purdie 2006-06-22  117      left = 1;
4f3865fb57a04db Richard Purdie 2006-06-22  118      for (len = 1; len <= MAXBITS; len++) {
4f3865fb57a04db Richard Purdie 2006-06-22  119          left <<= 1;
4f3865fb57a04db Richard Purdie 2006-06-22  120          left -= count[len];
4f3865fb57a04db Richard Purdie 2006-06-22  121          if (left < 0) return -1;        /* over-subscribed */
4f3865fb57a04db Richard Purdie 2006-06-22  122      }
4f3865fb57a04db Richard Purdie 2006-06-22  123      if (left > 0 && (type == CODES || max != 1))
4f3865fb57a04db Richard Purdie 2006-06-22  124          return -1;                      /* incomplete set */
^1da177e4c3f415 Linus Torvalds 2005-04-16  125  
4f3865fb57a04db Richard Purdie 2006-06-22  126      /* generate offsets into symbol table for each length for sorting */
4f3865fb57a04db Richard Purdie 2006-06-22  127      offs[1] = 0;
4f3865fb57a04db Richard Purdie 2006-06-22  128      for (len = 1; len < MAXBITS; len++)
4f3865fb57a04db Richard Purdie 2006-06-22  129          offs[len + 1] = offs[len] + count[len];
^1da177e4c3f415 Linus Torvalds 2005-04-16  130  
4f3865fb57a04db Richard Purdie 2006-06-22  131      /* sort symbols by length, by symbol order within each length */
4f3865fb57a04db Richard Purdie 2006-06-22  132      for (sym = 0; sym < codes; sym++)
4f3865fb57a04db Richard Purdie 2006-06-22  133          if (lens[sym] != 0) work[offs[lens[sym]]++] = (unsigned short)sym;
^1da177e4c3f415 Linus Torvalds 2005-04-16  134  
4f3865fb57a04db Richard Purdie 2006-06-22  135      /*
4f3865fb57a04db Richard Purdie 2006-06-22  136         Create and fill in decoding tables.  In this loop, the table being
4f3865fb57a04db Richard Purdie 2006-06-22  137         filled is at next and has curr index bits.  The code being used is huff
4f3865fb57a04db Richard Purdie 2006-06-22  138         with length len.  That code is converted to an index by dropping drop
4f3865fb57a04db Richard Purdie 2006-06-22  139         bits off of the bottom.  For codes where len is less than drop + curr,
4f3865fb57a04db Richard Purdie 2006-06-22  140         those top drop + curr - len bits are incremented through all values to
4f3865fb57a04db Richard Purdie 2006-06-22  141         fill the table with replicated entries.
4f3865fb57a04db Richard Purdie 2006-06-22  142  
4f3865fb57a04db Richard Purdie 2006-06-22  143         root is the number of index bits for the root table.  When len exceeds
4f3865fb57a04db Richard Purdie 2006-06-22  144         root, sub-tables are created pointed to by the root entry with an index
4f3865fb57a04db Richard Purdie 2006-06-22  145         of the low root bits of huff.  This is saved in low to check for when a
4f3865fb57a04db Richard Purdie 2006-06-22  146         new sub-table should be started.  drop is zero when the root table is
4f3865fb57a04db Richard Purdie 2006-06-22  147         being filled, and drop is root when sub-tables are being filled.
4f3865fb57a04db Richard Purdie 2006-06-22  148  
4f3865fb57a04db Richard Purdie 2006-06-22  149         When a new sub-table is needed, it is necessary to look ahead in the
4f3865fb57a04db Richard Purdie 2006-06-22  150         code lengths to determine what size sub-table is needed.  The length
4f3865fb57a04db Richard Purdie 2006-06-22  151         counts are used for this, and so count[] is decremented as codes are
4f3865fb57a04db Richard Purdie 2006-06-22  152         entered in the tables.
4f3865fb57a04db Richard Purdie 2006-06-22  153  
4f3865fb57a04db Richard Purdie 2006-06-22  154         used keeps track of how many table entries have been allocated from the
4f3865fb57a04db Richard Purdie 2006-06-22  155         provided *table space.  It is checked when a LENS table is being made
4f3865fb57a04db Richard Purdie 2006-06-22  156         against the space in *table, ENOUGH, minus the maximum space needed by
4f3865fb57a04db Richard Purdie 2006-06-22  157         the worst case distance code, MAXD.  This should never happen, but the
4f3865fb57a04db Richard Purdie 2006-06-22  158         sufficiency of ENOUGH has not been proven exhaustively, hence the check.
4f3865fb57a04db Richard Purdie 2006-06-22  159         This assumes that when type == LENS, bits == 9.
4f3865fb57a04db Richard Purdie 2006-06-22  160  
4f3865fb57a04db Richard Purdie 2006-06-22  161         sym increments through all symbols, and the loop terminates when
4f3865fb57a04db Richard Purdie 2006-06-22  162         all codes of length max, i.e. all codes, have been processed.  This
4f3865fb57a04db Richard Purdie 2006-06-22  163         routine permits incomplete codes, so another loop after this one fills
4f3865fb57a04db Richard Purdie 2006-06-22  164         in the rest of the decoding tables with invalid code markers.
4f3865fb57a04db Richard Purdie 2006-06-22  165       */
^1da177e4c3f415 Linus Torvalds 2005-04-16  166  
4f3865fb57a04db Richard Purdie 2006-06-22  167      /* set up for code type */
4f3865fb57a04db Richard Purdie 2006-06-22  168      switch (type) {
4f3865fb57a04db Richard Purdie 2006-06-22  169      case CODES:
4f3865fb57a04db Richard Purdie 2006-06-22  170          base = extra = work;    /* dummy value--not used */
4f3865fb57a04db Richard Purdie 2006-06-22  171          end = 19;
^1da177e4c3f415 Linus Torvalds 2005-04-16  172          break;
4f3865fb57a04db Richard Purdie 2006-06-22  173      case LENS:
4f3865fb57a04db Richard Purdie 2006-06-22  174          base = lbase;
4f3865fb57a04db Richard Purdie 2006-06-22  175          base -= 257;
4f3865fb57a04db Richard Purdie 2006-06-22  176          extra = lext;
4f3865fb57a04db Richard Purdie 2006-06-22  177          extra -= 257;
4f3865fb57a04db Richard Purdie 2006-06-22  178          end = 256;
^1da177e4c3f415 Linus Torvalds 2005-04-16  179          break;
4f3865fb57a04db Richard Purdie 2006-06-22  180      default:            /* DISTS */
4f3865fb57a04db Richard Purdie 2006-06-22  181          base = dbase;
4f3865fb57a04db Richard Purdie 2006-06-22  182          extra = dext;
4f3865fb57a04db Richard Purdie 2006-06-22  183          end = -1;
^1da177e4c3f415 Linus Torvalds 2005-04-16  184      }
^1da177e4c3f415 Linus Torvalds 2005-04-16  185  
4f3865fb57a04db Richard Purdie 2006-06-22  186      /* initialize state for loop */
4f3865fb57a04db Richard Purdie 2006-06-22  187      huff = 0;                   /* starting code */
4f3865fb57a04db Richard Purdie 2006-06-22  188      sym = 0;                    /* starting code symbol */
4f3865fb57a04db Richard Purdie 2006-06-22  189      len = min;                  /* starting code length */
4f3865fb57a04db Richard Purdie 2006-06-22  190      next = *table;              /* current table to fill in */
4f3865fb57a04db Richard Purdie 2006-06-22  191      curr = root;                /* current table index bits */
4f3865fb57a04db Richard Purdie 2006-06-22  192      drop = 0;                   /* current bits to drop from code for index */
4f3865fb57a04db Richard Purdie 2006-06-22  193      low = (unsigned)(-1);       /* trigger new sub-table when len > root */
4f3865fb57a04db Richard Purdie 2006-06-22  194      used = 1U << root;          /* use root table entries */
4f3865fb57a04db Richard Purdie 2006-06-22  195      mask = used - 1;            /* mask for comparing low */
4f3865fb57a04db Richard Purdie 2006-06-22  196  
4f3865fb57a04db Richard Purdie 2006-06-22  197      /* check available table space */
4f3865fb57a04db Richard Purdie 2006-06-22  198      if (type == LENS && used >= ENOUGH - MAXD)
4f3865fb57a04db Richard Purdie 2006-06-22  199          return 1;
4f3865fb57a04db Richard Purdie 2006-06-22  200  
4f3865fb57a04db Richard Purdie 2006-06-22  201      /* process all codes and make table entries */
4f3865fb57a04db Richard Purdie 2006-06-22  202      for (;;) {
4f3865fb57a04db Richard Purdie 2006-06-22  203          /* create table entry */
4f3865fb57a04db Richard Purdie 2006-06-22  204          this.bits = (unsigned char)(len - drop);
4f3865fb57a04db Richard Purdie 2006-06-22  205          if ((int)(work[sym]) < end) {
4f3865fb57a04db Richard Purdie 2006-06-22  206              this.op = (unsigned char)0;
4f3865fb57a04db Richard Purdie 2006-06-22  207              this.val = work[sym];
^1da177e4c3f415 Linus Torvalds 2005-04-16  208          }
4f3865fb57a04db Richard Purdie 2006-06-22  209          else if ((int)(work[sym]) > end) {
4f3865fb57a04db Richard Purdie 2006-06-22  210              this.op = (unsigned char)(extra[work[sym]]);
4f3865fb57a04db Richard Purdie 2006-06-22  211              this.val = base[work[sym]];
^1da177e4c3f415 Linus Torvalds 2005-04-16  212          }
4f3865fb57a04db Richard Purdie 2006-06-22  213          else {
4f3865fb57a04db Richard Purdie 2006-06-22  214              this.op = (unsigned char)(32 + 64);         /* end of block */
4f3865fb57a04db Richard Purdie 2006-06-22  215              this.val = 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  216          }
^1da177e4c3f415 Linus Torvalds 2005-04-16  217  
4f3865fb57a04db Richard Purdie 2006-06-22  218          /* replicate for those indices with low len bits equal to huff */
4f3865fb57a04db Richard Purdie 2006-06-22  219          incr = 1U << (len - drop);
4f3865fb57a04db Richard Purdie 2006-06-22  220          fill = 1U << curr;
4f3865fb57a04db Richard Purdie 2006-06-22  221          min = fill;                 /* save offset to next table */
4f3865fb57a04db Richard Purdie 2006-06-22  222          do {
4f3865fb57a04db Richard Purdie 2006-06-22  223              fill -= incr;
4f3865fb57a04db Richard Purdie 2006-06-22  224              next[(huff >> drop) + fill] = this;
4f3865fb57a04db Richard Purdie 2006-06-22  225          } while (fill != 0);
4f3865fb57a04db Richard Purdie 2006-06-22  226  
4f3865fb57a04db Richard Purdie 2006-06-22  227          /* backwards increment the len-bit code huff */
4f3865fb57a04db Richard Purdie 2006-06-22  228          incr = 1U << (len - 1);
4f3865fb57a04db Richard Purdie 2006-06-22  229          while (huff & incr)
4f3865fb57a04db Richard Purdie 2006-06-22  230              incr >>= 1;
4f3865fb57a04db Richard Purdie 2006-06-22  231          if (incr != 0) {
4f3865fb57a04db Richard Purdie 2006-06-22  232              huff &= incr - 1;
4f3865fb57a04db Richard Purdie 2006-06-22  233              huff += incr;
^1da177e4c3f415 Linus Torvalds 2005-04-16  234          }
^1da177e4c3f415 Linus Torvalds 2005-04-16  235          else
4f3865fb57a04db Richard Purdie 2006-06-22  236              huff = 0;
^1da177e4c3f415 Linus Torvalds 2005-04-16  237  
4f3865fb57a04db Richard Purdie 2006-06-22  238          /* go to next symbol, update count, len */
4f3865fb57a04db Richard Purdie 2006-06-22  239          sym++;
4f3865fb57a04db Richard Purdie 2006-06-22  240          if (--(count[len]) == 0) {
4f3865fb57a04db Richard Purdie 2006-06-22  241              if (len == max) break;
4f3865fb57a04db Richard Purdie 2006-06-22  242              len = lens[work[sym]];
^1da177e4c3f415 Linus Torvalds 2005-04-16  243          }
^1da177e4c3f415 Linus Torvalds 2005-04-16  244  
4f3865fb57a04db Richard Purdie 2006-06-22  245          /* create new sub-table if needed */
4f3865fb57a04db Richard Purdie 2006-06-22  246          if (len > root && (huff & mask) != low) {
4f3865fb57a04db Richard Purdie 2006-06-22  247              /* if first time, transition to sub-tables */
4f3865fb57a04db Richard Purdie 2006-06-22  248              if (drop == 0)
4f3865fb57a04db Richard Purdie 2006-06-22  249                  drop = root;
4f3865fb57a04db Richard Purdie 2006-06-22  250  
4f3865fb57a04db Richard Purdie 2006-06-22  251              /* increment past last table */
4f3865fb57a04db Richard Purdie 2006-06-22  252              next += min;            /* here min is 1 << curr */
4f3865fb57a04db Richard Purdie 2006-06-22  253  
4f3865fb57a04db Richard Purdie 2006-06-22  254              /* determine length of next table */
4f3865fb57a04db Richard Purdie 2006-06-22  255              curr = len - drop;
4f3865fb57a04db Richard Purdie 2006-06-22  256              left = (int)(1 << curr);
4f3865fb57a04db Richard Purdie 2006-06-22  257              while (curr + drop < max) {
4f3865fb57a04db Richard Purdie 2006-06-22 @258                  left -= count[curr + drop];

:::::: The code at line 258 was first introduced by commit
:::::: 4f3865fb57a04db7cca068fed1c15badc064a302 [PATCH] zlib_inflate: Upgrade library code to a recent version

:::::: TO: Richard Purdie <rpurdie@rpsys.net>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OgqxwSJOaUobr8KG
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zz3K34PUBnaM/wdRiNdNEZ8BAA==

--OgqxwSJOaUobr8KG--

Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74AE02084C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGFT7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:59:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:63026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGFT67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:58:59 -0400
IronPort-SDR: 6G4o73wvd82MosXGEMo9AUl9TQTXm9vb1G9FDKxCEkRlnw58m+JvkB7gvVQetPNLKc7qimowOD
 8PO99N6DYsGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212472476"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="gz'50?scan'50,208,50";a="212472476"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 12:58:45 -0700
IronPort-SDR: RW0kyM7v9EHWuDmTXJAL4oU0nXelm+ouu5+/TX98EwpkDqLJLErshxdeag04Dj3vrhVE6F2gBc
 zpB4mP8jD0bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="gz'50?scan'50,208,50";a="315275249"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2020 12:58:43 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsXGE-0000Lw-Rv; Mon, 06 Jul 2020 19:58:42 +0000
Date:   Tue, 7 Jul 2020 03:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202007070308.oD5KarCo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c82ec00dd00c7a2b02d4b42cf59ae87592cb75f
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   8 months ago
config: riscv-randconfig-s031-20200706 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-14-g8fce3d7a-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] <asn:2> *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     expected void *
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     got unsigned char [noderef] [usertype] <asn:2> *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '<asn:2>' of expression
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] <asn:2> *screen_base @@
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] <asn:2> *screen_base

vim +156 drivers/video/fbdev/aty/mach64_cursor.c

^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   67  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   68  static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   69  {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   70  	struct atyfb_par *par = (struct atyfb_par *) info->par;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   71  	u16 xoff, yoff;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   72  	int x, y, h;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   73  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   74  #ifdef __sparc__
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   75  	if (par->mmaped)
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   76  		return -EPERM;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   77  #endif
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   78  	if (par->asleep)
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   79  		return -EPERM;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   80  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   81  	wait_for_fifo(1, par);
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   82  	if (cursor->enable)
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   83  		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   84  			    | HWCURSOR_ENABLE, par);
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   85  	else
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   86  		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31   87  				& ~HWCURSOR_ENABLE, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   88  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   89  	/* set position */
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   90  	if (cursor->set & FB_CUR_SETPOS) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   91  		x = cursor->image.dx - cursor->hot.x - info->var.xoffset;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   92  		if (x < 0) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   93  			xoff = -x;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   94  			x = 0;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   95  		} else {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   96  			xoff = 0;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   97  		}
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   98  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16   99  		y = cursor->image.dy - cursor->hot.y - info->var.yoffset;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  100  		if (y < 0) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  101  			yoff = -y;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  102  			y = 0;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  103  		} else {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  104  			yoff = 0;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  105  		}
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  106  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  107  		h = cursor->image.height;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  108  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  109  		/*
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  110  		 * In doublescan mode, the cursor location
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  111  		 * and heigh also needs to be doubled.
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  112  		 */
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  113                  if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  114  			y<<=1;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  115  			h<<=1;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  116  		}
2f682fae611df64 drivers/video/aty/mach64_cursor.c Krzysztof Helt     2009-03-31  117  		wait_for_fifo(3, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  118  		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1), par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  119  		aty_st_le32(CUR_HORZ_VERT_OFF,
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  120  			    ((u32) (64 - h + yoff) << 16) | xoff, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  121  		aty_st_le32(CUR_HORZ_VERT_POSN, ((u32) y << 16) | x, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  122  	}
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  123  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  124  	/* Set color map */
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  125  	if (cursor->set & FB_CUR_SETCMAP) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  126  		u32 fg_idx, bg_idx, fg, bg;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  127  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  128  		fg_idx = cursor->image.fg_color;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  129  		bg_idx = cursor->image.bg_color;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  130  
72c24cc51aef312 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  131  		fg = ((info->cmap.red[fg_idx] & 0xff) << 24) |
72c24cc51aef312 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  132  		     ((info->cmap.green[fg_idx] & 0xff) << 16) |
72c24cc51aef312 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  133  		     ((info->cmap.blue[fg_idx] & 0xff) << 8) | 0xff;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  134  
72c24cc51aef312 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  135  		bg = ((info->cmap.red[bg_idx] & 0xff) << 24) |
72c24cc51aef312 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  136  		     ((info->cmap.green[bg_idx] & 0xff) << 16) |
72c24cc51aef312 drivers/video/aty/mach64_cursor.c Antonino A. Daplas 2006-06-26  137  		     ((info->cmap.blue[bg_idx] & 0xff) << 8);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  138  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  139  		wait_for_fifo(2, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  140  		aty_st_le32(CUR_CLR0, bg, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  141  		aty_st_le32(CUR_CLR1, fg, par);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  142  	}
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  143  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  144  	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  145  	    u8 *src = (u8 *)cursor->image.data;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  146  	    u8 *msk = (u8 *)cursor->mask;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  147  	    u8 __iomem *dst = (u8 __iomem *)info->sprite.addr;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  148  	    unsigned int width = (cursor->image.width + 7) >> 3;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  149  	    unsigned int height = cursor->image.height;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  150  	    unsigned int align = info->sprite.scan_align;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  151  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  152  	    unsigned int i, j, offset;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  153  	    u8 m, b;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  154  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  155  	    // Clear cursor image with 1010101010...
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16 @156  	    fb_memset(dst, 0xaa, 1024);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  157  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  158  	    offset = align - width*2;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  159  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  160  	    for (i = 0; i < height; i++) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  161  		for (j = 0; j < width; j++) {
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  162  			u16 l = 0xaaaa;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  163  			b = *src++;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  164  			m = *msk++;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  165  			switch (cursor->rop) {
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  166  			case ROP_XOR:
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  167  			    // Upper 4 bits of mask data
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  168  			    l = cursor_bits_lookup[(b ^ m) >> 4] |
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  169  			    // Lower 4 bits of mask
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  170  				    (cursor_bits_lookup[(b ^ m) & 0x0f] << 8);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  171  			    break;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  172  			case ROP_COPY:
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  173  			    // Upper 4 bits of mask data
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  174  			    l = cursor_bits_lookup[(b & m) >> 4] |
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  175  			    // Lower 4 bits of mask
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  176  				    (cursor_bits_lookup[(b & m) & 0x0f] << 8);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  177  			    break;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  178  			}
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  179  			/*
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  180  			 * If cursor size is not a multiple of 8 characters
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  181  			 * we must pad it with transparent pattern (0xaaaa).
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  182  			 */
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  183  			if ((j + 1) * 8 > cursor->image.width) {
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  184  				l = comp(l, 0xaaaa,
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  185  				    (1 << ((cursor->image.width & 7) * 2)) - 1);
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  186  			}
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  187  			fb_writeb(l & 0xff, dst++);
43751a1b8ee2e70 drivers/video/aty/mach64_cursor.c Mikulas Patocka    2014-01-23  188  			fb_writeb(l >> 8, dst++);
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  189  		}
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  190  		dst += offset;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  191  	    }
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  192  	}
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  193  
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  194  	return 0;
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  195  }
^1da177e4c3f415 drivers/video/aty/mach64_cursor.c Linus Torvalds     2005-04-16  196  

:::::: The code at line 156 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Rz1C0AEA

--SUOF0GtieIMvvwua--

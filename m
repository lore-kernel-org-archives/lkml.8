Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEA3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E956822B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgHEDDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:03:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:39181 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHEDDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:03:39 -0400
IronPort-SDR: AfYDo08W7rvLaYwNmleaKW6IxB3kRAFruAM8zkyxd6tRSPnNN23B0gTC61BetA3L0aP5sv8En1
 x4yaf0E9g7Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153603141"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="153603141"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 20:03:28 -0700
IronPort-SDR: 4ZVJhIZ1SQztKb8uSVQfzXsiEAEvDROxtqgn2uI/ASpXXPaBOdOy/zGGUDxUCkMD5akT5+QBXp
 A9MWRw3FgFdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="288789334"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2020 20:03:26 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k39i9-0000Y8-M3; Wed, 05 Aug 2020 03:03:25 +0000
Date:   Wed, 5 Aug 2020 11:03:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202008051159.ZEGJEQI0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f30a60aa78410496e5ffe632a371c00f0d83a8d
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: s390-randconfig-s031-20200805 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     expected void *s
   drivers/video/fbdev/aty/mach64_cursor.c:156:13: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:209:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c: note: in included file (through arch/s390/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]

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

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qZe9rE/w/w8bAoItKtMBAA==

--ibTvN161/egqYuK8--

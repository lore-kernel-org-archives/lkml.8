Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9806C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D4322CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGRVKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 17:10:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:37417 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgGRVKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 17:10:35 -0400
IronPort-SDR: S+5ng+rZZFjIqQJhnmFOcTR6pc0S3QPS7KV+9CkLNjKPxxZ3RUNzfMVpsOM7uVGO/i4C55rcb5
 pGsz6/Gr0rig==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="151121130"
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="151121130"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 13:50:27 -0700
IronPort-SDR: JcMD1/aoIykiGOC9xbRg5Z0nmXxFpfsBX0y20VgRGvRt/+ud5B9+WRdbphWOGx7K7gY3/ZsPq9
 bFZ1ZXLxqjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="325720686"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jul 2020 13:50:25 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwtmq-0000up-ON; Sat, 18 Jul 2020 20:50:24 +0000
Date:   Sun, 19 Jul 2020 04:50:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202007190406.nNcQ0WIf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6cf7ccba29dcf39ab27630c383a3844078a6d5cd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: s390-randconfig-s031-20200719 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *p
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '__iomem' of expression
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]

vim +1120 drivers/video/fbdev/tdfxfb.c

^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1040  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1041  static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1042  {
a807f618b62594 drivers/video/tdfxfb.c Antonino A. Daplas 2006-01-09  1043  	struct tdfx_par *par = info->par;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1044  	u32 vidcfg;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1045  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1046  	if (!hwcursor)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1047  		return -EINVAL;	/* just to force soft_cursor() call */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1048  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1049  	/* Too large of a cursor or wrong bpp :-( */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1050  	if (cursor->image.width > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1051  	    cursor->image.height > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1052  	    cursor->image.depth > 1)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1053  		return -EINVAL;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1054  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1055  	vidcfg = tdfx_inl(par, VIDPROCCFG);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1056  	if (cursor->enable)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1057  		tdfx_outl(par, VIDPROCCFG, vidcfg | VIDCFG_HWCURSOR_ENABLE);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1058  	else
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1059  		tdfx_outl(par, VIDPROCCFG, vidcfg & ~VIDCFG_HWCURSOR_ENABLE);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1060  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1061  	/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1062  	 * If the cursor is not be changed this means either we want the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1063  	 * current cursor state (if enable is set) or we want to query what
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1064  	 * we can do with the cursor (if enable is not set)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1065  	 */
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1066  	if (!cursor->set)
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1067  		return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1068  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1069  	/* fix cursor color - XFree86 forgets to restore it properly */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1070  	if (cursor->set & FB_CUR_SETCMAP) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1071  		struct fb_cmap cmap = info->cmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1072  		u32 bg_idx = cursor->image.bg_color;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1073  		u32 fg_idx = cursor->image.fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1074  		unsigned long bg_color, fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1075  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1076  		fg_color = (((u32)cmap.red[fg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1077  			   (((u32)cmap.green[fg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1078  			   (((u32)cmap.blue[fg_idx]  & 0xff00) >> 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1079  		bg_color = (((u32)cmap.red[bg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1080  			   (((u32)cmap.green[bg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1081  			   (((u32)cmap.blue[bg_idx]  & 0xff00) >> 8);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1082  		banshee_make_room(par, 2);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1083  		tdfx_outl(par, HWCURC0, bg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1084  		tdfx_outl(par, HWCURC1, fg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1085  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1086  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1087  	if (cursor->set & FB_CUR_SETPOS) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1088  		int x = cursor->image.dx;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1089  		int y = cursor->image.dy - info->var.yoffset;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1090  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1091  		x += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1092  		y += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1093  		banshee_make_room(par, 1);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1094  		tdfx_outl(par, HWCURLOC, (y << 16) + x);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1095  	}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1096  	if (cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1097  		/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1098  		 * Voodoo 3 and above cards use 2 monochrome cursor patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1099  		 *    The reason is so the card can fetch 8 words at a time
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1100  		 * and are stored on chip for use for the next 8 scanlines.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1101  		 * This reduces the number of times for access to draw the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1102  		 * cursor for each screen refresh.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1103  		 *    Each pattern is a bitmap of 64 bit wide and 64 bit high
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1104  		 * (total of 8192 bits or 1024 bytes). The two patterns are
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1105  		 * stored in such a way that pattern 0 always resides in the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1106  		 * lower half (least significant 64 bits) of a 128 bit word
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1107  		 * and pattern 1 the upper half. If you examine the data of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1108  		 * the cursor image the graphics card uses then from the
25985edcedea63 drivers/video/tdfxfb.c Lucas De Marchi    2011-03-30  1109  		 * beginning you see line one of pattern 0, line one of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1110  		 * pattern 1, line two of pattern 0, line two of pattern 1,
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1111  		 * etc etc. The linear stride for the cursor is always 16 bytes
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1112  		 * (128 bits) which is the maximum cursor width times two for
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1113  		 * the two monochrome patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1114  		 */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1115  		u8 __iomem *cursorbase = info->screen_base + info->fix.smem_len;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1116  		u8 *bitmap = (u8 *)cursor->image.data;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1117  		u8 *mask = (u8 *)cursor->mask;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1118  		int i;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1119  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16 @1120  		fb_memset(cursorbase, 0, 1024);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1121  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1122  		for (i = 0; i < cursor->image.height; i++) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1123  			int h = 0;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1124  			int j = (cursor->image.width + 7) >> 3;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1125  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1126  			for (; j > 0; j--) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1127  				u8 data = *mask ^ *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1128  				if (cursor->rop == ROP_COPY)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1129  					data = *mask & *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1130  				/* Pattern 0. Copy the cursor mask to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1131  				fb_writeb(*mask, cursorbase + h);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1132  				mask++;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1133  				/* Pattern 1. Copy the cursor bitmap to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1134  				fb_writeb(data, cursorbase + h + 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1135  				bitmap++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1136  				h++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1137  			}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1138  			cursorbase += 16;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1139  		}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1140  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1141  	return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1142  }
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1143  

:::::: The code at line 1120 was first introduced by commit
:::::: 90b0f08536531abbbe7b5d4944792da08cadde01 tdfxfb: hardware cursor

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICA9bE18AAy5jb25maWcAlDzJdiSnsnt/RZ32xl7Y1tSy9d7RgiLJKlw5CcgqlTZ5ZHW1
rXM19NHge32//kVADkBGZvfzoq2KCAIIgpiA/P677xfs/e358fbt/u724eGfxZ+Hp8PL7dvh
0+Lz/cPhfxdJuShKsxCJND8DcXb/9P6fX15PL44WH3/+7eejn17ujhebw8vT4WHBn58+3//5
Dq3vn5+++/47XhapXDWcN1uhtCyLxohrc/kBW//0gIx++vPubvHDivMfFxc/n/589MFrI3UD
iMt/OtBq4HN5cXR6dNQhsqSHn5yeHdn/ej4ZK1Y9+shjv2a6YTpvVqUph048hCwyWQgPVRba
qJqbUukBKtVVsyvVZoAsa5klRuaiMWyZiUaXygxYs1aCJcA8LeEfINHYFIT1/WJlJf+weD28
vX8ZxCcLaRpRbBumYK4yl+by9ATI+2HllYRujNBmcf+6eHp+Qw69cErOsm7+Hz5Q4IbVvgjs
+BvNMuPRr9lWNBuhCpE1qxtZDeQ+ZgmYExqV3eSMxlzfTLUopxBnNKIuUBhKaC0SoOhF5I3b
l1CMt6OfI8A5ECL25zFuUs5zPJtD+xMiOk5EyurMWA3x1qoDr0ttCpaLyw8/PD0/HX78MPDX
e72VFSf7rkotr5v8qha1IAl2zPB1M43nqtS6yUVeqn3DjGF8TdLVWmRyScyL1WBsoiVmCvq0
CBg76G424COo3UuwLRev73+8/vP6dngc9tJKFEJJbnctX/tqjJCkzJksQpiWOUXUrKVQOKa9
Z6Ba5rmWSDmJGPWjK6a0aNv04vHHmohlvUp1KMbD06fF8+doqnGf1hBtRzLr0BwMwUZsRWF0
Jzpz/3h4eaWkt75pKmhVJpL7Ay1KxMgko9XBoknMWq7WDWi3HaSiZzcaTTcY2BYirwywt0Z6
UN8Wvi2zujBM7Wkld1SE8nXteQnNO5nwqv7F3L7+a/EGw1ncwtBe327fXhe3d3fP709v909/
DlLaSgWtq7ph3PKQxWqQO4FsCmbkNpiD5muRgKsQKmdZYw1ArWjpLnUCBCUHEuRpSCL0Mtow
o2lZaEmK/hsm3ftGmJHUZQYzKYtOaIrXCz3WIgMCbgDnTxh+NuIalItaEe2I/eYRCKdnebRq
TaBGoDoRFNwoxiMEMgbpZRn62rwsQkwhYKm0WPFlJrWxk2rlF86/tyEb94dnVTa96pXcB68h
UoB9cfk4eG10z2mj1zI1lydHPhyXIGfXHv74ZNBpWZgN+PRURDyOT91a6bu/Dp/eHw4vi8+H
27f3l8OrBbczIbC98UW7rOuqgihHN0Wds2bJIOjigdq3YRWM4vjktwE8Ih+MRoDpXZooMKSi
fCFfqbKutM8DPBBfTZK6TebTp0yqxsORmwW27wRJyL2SiRcltkCV2CBo8JQOnIJK3whFO9MK
3OTExm2bJ2IruZgeCrBAy0B0DBsunW5nnY7npcBT9ChmgolgmAFeDKwQxW4t+KYqYfHR2EP4
TNg6DEEta3Ki4L5SDeMBS8iZmVoZkbE90f0y26CIbJSkEm9/4W+WA2Nd1ooLL4JSSRfkDtyT
mfgQkHFs6OOub4hh2TZehGt/n/ldLssS3RD+TUmVN2UFjlPeiCYtlV3LEvxFwQPxxmQa/qBs
LAQIxosPbMxVy+T43FMASwN2movK2GwObaWXOFTp8MNZ8+F3xCuH3SxBs5XHfiVMDja4GQUr
bvlH4HTNCgg6BoCLXF0w4UGt8Yt/N0Uu/ZzHU/Qlg2AsrYOuashco5+wxSN5OTDPq2u+9viJ
qgxmI1cFy1JPE+2IfYANyHyAXoMx8yJeWfprLMumhklRWsKSrYTZtLLzpAL8lkwp6a/ABkn2
uR5DmkDwPdRKCvddHMCAKnR9UoNCn7FjYA86u470v8vARKFyWGRKWVmIl70A21qqDtZzgBmK
JCGNtF0u3DFNH/sO4RA/PgqyMusJ2xJHdXj5/PzyePt0d1iIvw9PEA4x8JEcAyKIU4coZ4K5
G6lFwgSbLcR3EIGT4dc39thHlrnrzgWuwQ7QWb3srXlQOGAgerWhbW7GqNwMeQXmOytpMrYE
HVMr0a1x2Aiw6PUwZGoUbOMyn2LSk62ZSiC8C3ZFnaYZLCSDbqwgGXiXaN4YF0F+ZSTLfBtQ
pjILQhRrzKyX0n4QFxZl+t2Te/HhDWQgTeKXN7DPJWpgkUjmxYuYbIEX6+Ilb6SQJG9c6DnC
danaeicgXyIQgfHygP3ObOy0QqO40saznGEU1yopSNUKNcq0LbEXw5Vgf7AdRJ9ePl1x2VzV
Um30VC81LMJS+Gp6enHk/bJxQZlDhym46X4S/hxcgS0DvQfT9jHY3BnMu8JCRZeNVC/Pd4fX
1+eXxds/X1w644W6ftPcjvPm4uioSQUzkHn5drNHBqFmC704IvdSh26Ojy7mCI5nmx9fnM+h
BT+mo5Ou+eksli5EddiPxPYcJt2YOkzC8Xe38emMFAlQigTfFndxNOI4I0GHnxBgi5yQn8NO
iq9tTEuvRdLCa5GU7M7Pln6Jy9liT/lzbysVymYBl+dnvZqWpspqa2fCZMrflonQXZIX7imd
m3ib5TyGQPC5iWGJYrsgYnNlCtj9kFTu/dVa38BC0WsBqJOP1LID4jTcVY4LTXvpHQBsxLUI
KlJWMcduJS6vFuWyIphD6Fq2pf8hlmhhTZmmJMueADOZGaZdYOmnLei30JKRYcCc3bKGLT88
Pr/8E58aOFtrC4sQ6rWJc2yKe/Tgo328a9RVclul+xqNgr+2cU8tla4yMOdVnjSVQV/oRdQl
ZGC2foHetARPry4vBkMDwfZ6r3GksG305dm5F66B53T+c6JYrYom2UOCCk6RIGulHAjRVZB/
KYMaaM/xKpHUAqPDg52a1gXH5EhfHp/8NrgVDU4yCOH5WnPcQP5ugtnVQbQoWJIjEV33DQZo
R5i8P34B2Jcvzy9v3vmbYnrdJHVe+YFNQNuPQXA0RX7hZhclOVUhjEw6r7q9f3l7v324/290
5ge+3QgOqbqteNYskze2NtisaqGDWLCadhI8p7cvq6oMKxA2/6DiRggkmvW+gqQx1dHwN9t8
DMEae3gc4GP8RMyHN6qsw+pujx0lcAhkel/wxk+SfWiD/ydYYSyJgdx1Y8MfzL1DBttUjg7K
cIDFFqSewAbYCFcYiym2tg5tu5flOPtHEgjuwuQ1XM1gIJePnoGFtnYVagAYVVJZoMUP6tCq
ZaRQrjh5ePj8dnh98wI1x7zYyQKLr1lqIjZDk+Bo9fbl7q/7t8Mdms+fPh2+ADVkVIvnL9jZ
a7xluCtV+V4mgpUukRBDidaKrgf7B4Iu3CUE8TvszAZSHRH4BazXg8naiL3uZziVyYo0lVxi
8lcXsDirAitqHM8EIjuMOSee74LaNku9YyONj2NyB1XC0AgHbWBfp1ExyOKDGstwjGdJ10GA
YZGQQ2G9y8hVXdZeX11OA1GRPWZqD9GjuaGRBTdiZLrvKnpjAi1M66siJJYjdO8ojK1D2dP+
eAI6b/IyaY/OY4EosdINQ51ET9OuAdirWAxh+WKoRmB7Co7FkJZna8dHQg20aAbr12s6/5rX
zYrhcVN7ZQFzbhKNBx5fIQGT4f4aSd8phDuFGBXJ3FBb3XWStxloRNG2c/cXJnBJWY9jHVtu
khVv3FlrdyOCIGrrIt9EW2aJR08JvvWoDZiDIHmdgrcnJXatWydaqu6Q0+c+e8w46DuICQQK
dFhk/DoL3GsTW7bAcBFtzLpeCWJp3HTL1DQJ8N1HWNgzXdApuEz9MzpA1RlYETROYOisghJT
sSgb08ubkVqU1b67WmOy8a7MpIs/+zKLJ/AMyzdLQEComGjv+gourpYrXcOQi+R0hGA89IGt
IsxjT08ggm3CxcAlgG0zWPF0FLZYKWxzVrk5eA6ZgA2rb8Bsmi7dUTuvhD2Dipu79SGbB6je
dWFo7xcjKafXd+KyE672VX/avuLl9qc/bl8Pnxb/ckXQLy/Pn+8fgmN2JGqHTwzdYlsv3Bav
h4sVEY6MrufGEKwMXkvDvEj6ziAEej134IbvuVWJTFxLQx1bebRgr1GWAiOpak/1YjdG76+o
/gYC/6SInvq3BUvdKLDyhwcffnRgDwY0FreHO3ftNo/3fZv6ZSULDmNbZF0ggio+UT547Jxj
flrx/tZbvPIRZXjqFqO7i1lzNFg93TW51Npd82jPSBuZ2wooMau6ACMI5mOfL8tsJCrtLj9k
EDnVweHkEnfczF2WooSoSIYFYNae4faiK46jfeQuQILBxnuKah8m7FMUzXI9Q/QVHt/GILxc
NUmi2agM4ZOhZs0OxhHMD6elmR/QQDQcfxO0znnNydlSfAN6cswDxeSIA5JpEVqyORF6BPPD
+ZoII6JZEe6UNGJeho7kW/CTw/ZIJkcd0kzL0dHNCdKn+MqQvibKmGoky7r46g7pj2+YKTFT
UrlXILJ+wDUGA1vuCj+yVTsNrn4CaYc0gRviEXeiDPNgVWUpbLgg/nO4e3+7/ePhYK+sL+xx
qV8sWMoizQ0GkKNwjELZ/gaEzcQ9IQEoLAK0pJor6ddmWjCY/6A2jW0xhyNd79RU/EJvfvt0
++fhkaxb9BXdYRj2fpq9bgGxhjsWiENzV7tFdyYK/2hgqB5fY1lXUKgt/IMhaFxgHlGMO7Ve
yxZ2mzE+Zdo0q7qKlmUjRNW39RTPTcG/guhfA/PK11QhylWlbUXanbScBVoSBfL2tFkJ3AVB
zpXLlWJxzI/FjCY6RbUzZkkC2XZ/DjSUiTR1Et7dk7CizmGXYPPLs6OL845iPkGjsDCsHdsH
QRJJlrs7JHSFNhMQRjK+Jq+fRZfdcuZOlmnS7o6zJz0AwliYvvw1WE0vySQHdVOVZMHxZlkH
IeaNHt++GOQtlAorEe6afT86W4iycEwoN4EquAPrrc3d/R7BaGGuN7qK24XrddUsIRda58w+
KPHOiMAHlkWGOW5lr3GlszlVZYTLs5lLfMJDDsKADMbC+JYDnxaslCsjWhNUHN7+/fzyL0iC
xrYHD2Kg+WP4G9aJrQYgeBgvi8RfeO4RQdomg1pmdJh9narclsboe+cC01sqtZI13/riZSlC
KEInj+GiVeUsKWeaPrEAAtgtmFkl9nQgHNpAVBX+0wP7u0nWvIo6QzDeAqRvRbYEiikab9ev
mnjz4pCwuKDreX1NDNNR4CF2EVWm95C+Qg4iBb0sruHWyElsWtZzuKFbugNclobRj0osDvKs
aaSs0KpPrPYwXR9oFTIEGV514JB9nTjE9AAU232FArGwLmB8StrEYe/w56rXNuoaRUfD66Vf
but8SYe//HD3/sf93YeQe5581OS9U1jZ81BNt+etrmMIQZ+OWyJ3D1XjqUbC6Du8OPvzuaU9
n13bc2JxwzHksqIvgViszOg7vBYZKbSP0tKMRAKw5lxRC2PRRQJxoQ3HzL4So9ZODWfm0QV0
tho/sU0soV2aabwWq/Mm232tP0sGfol+MuZ0oMrmGeUVKNbUvsc3lFgUR9c3YYwqU+F7Tq1l
Glw26VpDXGULq+Be84q+DgukccG9B/V7KaisKJmAi++JRvdC+fPLAd0ihOtvh5epJ7BDJ4ND
9cffIuEvSL820w95xqTTz/DGtFlJ25wxZanpfVykaDIKG/FMEeADE+CTiO0UxYzODkO5pqi6
l0lzQg8cpBaTjnqrR4spq/+ZWUt/CvgYwrk5+uoXzrJS5fV+liSBgG8Oj6Kc9O4OPddcid8h
BJ0mASEAFSStczYESWAMM6sxJ7VWrH+f//8FS9vpQLCTJK1gJ/GDZCZJWuFOeYvzadH1Ypmb
tWdiqrFp8eWf8AmrierNJ2JDldDraaJXv10EbPIgIDY5WFpJBUmIylh4OQ5heVXSvhORS3Vy
/hutg9mJobrRphqShlx50bKzyAOytdBylYM4irKsgkysxW5hyO1RK4UOOrC0vx2dHAePCQZo
s9oqasgeRb5VQSifCF4I8nV+xr3XfRk/GX4xw7LN8BNfMOG9JxGCZZUkVfQTj9NY0P/1CXUH
NWPV0kvX1mWU7Zxn5a5iBRXBCCFwph/PvK57WFNk7R/2ERB45ML4h/Uepdvtfq4HIYbDTQQB
3as9azau3g/vB0hGf2kfKAYHhC11w5dXYU6LwLVZEsA0LNV1cFDhyXQF8ZWS9Cv/jsBGa1fT
MwJ7lFAd63Q5y1enc0yNuMqG9emhy3QM5Es9Fge44jHQMJztGL5S/suMDprotpQRweH/Iqdm
nCgqY+7leEV3rjfLFjFiyNflZjI+shRXs0LkEKETUkyvpjCcbYSv0EOLmV7W65QafCWpulqP
xdu4RE9Tz0V7GY/v5Tsn/HD7+nr/+f5uHLyCN4gUBAB4yit5KAEEGy6LRFzHE0KUTUYm4pWW
JN3NouvTkwmRWP56W40HhNDzWFK2L7BwM9zcY1eqIfjsmXbIFlKM0ThyfI+CZ+IBRuTtM5UR
rL3X4X/txUNysojhERTLvRHxKrS4aTG2BDk4mnjmLQo/4jO7RoxTvq7fCDINdmrCqQdkSaHx
tXCJH6kJEjIwxgzr33R2UVai2OqdNOGl6c5FO3/jvajvIFGZsgdnEFDg3SAPJZWRJcUqRHQf
C/DX2uZWcXUzrzKqmIviKvTap1zr6Uqnm/Nk0gUU2SkooMbUKqJqaa6UUX5v+LvROVXBsCjI
9GMFKbimaiTKv36sUvuhCr/Gdu3j2xfmNuEPjL2HcFWAyN8o/PaB3kcXlpdXWUiGm7P9jFJY
1F7gfWEXQQSTqjZmJYpJsSaqrBpYaGnKaHXaPGDEPkL4xfSBNWd0lwySl2s18ekeQG44Havs
ZM6oKq9KN9KXl/vdZCLRI6AsqtqMoKsqdskXVfy73Rwj8PhRKpN05YGLat3QnwsqUq+6CT9g
h60kRpyPPrDgMrCFDoRnzjRLi62Z/xIToWsuQ4BeJxkfVOn2ZZHeHx7wge7j4/tT60wXPwDp
j4tPh7/v79pPa3gsjEp/vfj1iPq2lO1B5uFU8Ojx+OgoBKZ+HtACGnnCo6bFx7MzAkRSnp6G
U7WgptZLgtIyGFGfOAk+hvPNJVel+wzaCZWNWhq1jRYQIW3nITcLZ+SnY3r8aHranBzD/xkN
peitBhGwljYYU4uZUa7ritRIB56Riz5Nd6r4GOmgA7ZrEI3k4uM6nTBM36SsfYKoGV5XjAMK
mVIxalcI9m54tJDwMxEJSMqeHw8gMPOw27M44ASnhe4zOofHo17v3JXJrIwCBmHWBog69zuK
ehM7zUXycv938IDfXb73d3v8o/2Olw6A9l5A9IwLwYw8CrQYXeUjaoDNvp/tiSoMNfF+0Qx3
R4RXdxwp2dvkrVCPsKkmMmGLXFKxNMop15HgRh9C8xlNXhJAnHJP0rsHheGXC5FAm3oZQvBp
1QjITLhsjSy3UTMVDbpiLuQYwrH2FS4gR1qFsLvnp7eX5wf8bNKnXruCmaYG/p16KIsE+Am/
7vnLtOCv8VMG14Rmv97/+bS7fTnY4diiuY4fB1oGyS7UYQDYrsfQKmMT0HEDyCF0exWne3M4
MyJ3xen5DxDU/QOiD/GIh3sM01ROwrefDvi5DIseVuF1/DTSToCzRBT+kwAfSsmhQxHC8FFd
0+HY4qvj6h/90urTq5Z4+vTl+f7pLVYoUST2MwmkvQ8a9qxe/33/dvcXraz+vtq1KYYRztt5
TKdZ+KPjjDwNVaySiR8atoDGaPnryfEYbg9O8ZyvhGD09MirebcErW2AfMBcN1M3rXtuOYMG
q+BLrz0u/ADWwL/O+9rHqHe8vUOH7h2Fvf3d8CgLc5/Mu/1y/0n+H2dP0+Q2ruN9f0Wftt47
pEaSv+RDDrQ+bKZFSS3StpyLqmsmW9O1SSbVydS+/fdLkJREUqD9ag+dWAD4TYIACYDNE9c9
uhgJq282ux4tvuVDjwr6VtJtGkoqeQ12MDCSdL0iWdkzIFDn2e/y7Xezuz41k83QVPhZ+4mc
iqpFd0jZS4K1pRdER8Ok2nX257oh4YLUOQHXHmwj6XShJe3YlXTaJXI6VC7f3r/9D7Cor3/J
9fo+d355VV4K9uXxBFLSSA6B9WYkWE2SqRArvNicSvn16bZjmVpoKdtU1cFx85npRmcEm9n4
zRhTaacEuE4YLVHdroXQL3lHL4HRUOjiomOieMnARdWkHXQYAMwsBYi017EhVU6ks2TNbxyc
t4vuQrkdzWcKWQoOa3Lf18lQ9OVcyQ9ykPuioLa9a1ccHVNT/e3qLgbGK8pAjvvmw21nTgO7
xgsyxhyeZsqxLbPH/LLssEhNV5b6ASyKn0in51fpireALNWWo/zaUMYfWIVqth/+/mmppSZT
1vTCu5Y5UThdQbO3s7AU9kZK+9niUGQcrZpjXJkJ61BHfqjZAmOgt6vX919vSkP58fr+02GM
QEu6nYr0ZI0ZgDOWK5t2BNWUGFR2tAq9dweV00617aZdbz5+iK2u8rNQTtkqyEcgcuEyBSjH
YO+J7+OLblC9c5Y/pWgEcTp1iDDx/vr951et0lWv/+vJn6r9TRsYBR0yC6yZwXpcHRuO/LEj
7LeuYb+VX19/yk3/z7cfy31K9XtJ3c77VORF5q1agMuVOyBgmR6OeZXZmO/MZdB1Az7swT4F
koPk7jcwh/UIPbLKIsNKOhYNK0SHWZMCCazZA6mfhyvNxWmI3ZZ42OQudr3sBRojsMSvZoNe
pE/0tSgqiL6/7GMmlfDcWewGIzdR7ExqRJ8Frdzs5NTwAA1z5wA5KB8DW3wITyetErz++AFH
pAYILhGa6vV3iIvjzTntUQl9CnYA3K2NiiGzHF8DNi4hwdk0kjX4AaVNAkeiykQ/TJlhJ0OA
UQM1XMDnu/MHBbQK2V8oV3jUT1MkjQ8gp7++ff/yx5PM03BufAm3LNts4kV/KShEmCtpH26h
pgop80ACHohlRdQlBwY2DktSRtAWfyiNnPbeespObbJ6TjZbF865SDaVWxSvFlO2PS1A8s+H
ye9BNIJUKqCq44lhsFL+AB9YwEIkIK2Rv/387w/N9w8ZjMvi4MnpvrzJjit0oB+PobPF1VId
qr1d1QBNz+puxinGgNreRBzRIdN0mybpgbsfF/PW4RvXAWiDBFLoWhCoHqtaWGX/qf9PpDbK
nr5pLwd0Qisydwq8qKc4Rhl06uXHGf+HX7/Gy9kAVVyDtTJuNU+HOE07H0KcQAnBjgjaOFYC
Uno511QEAsNI7HNz+DQPqwQAS3KCwkiYI5PKb8cFRH6z3DWskCA4YvViLc96PulAvV0MVH1h
BXaW48A1w3/7+ftSJJXbhtQG+FBRvqouUeKcxJF8k2z6IW8bnH1LLYfdoKWYMngitWic6EWC
lkxpR7jZXcb3q4SvoxjJTUriVQPB+mWFpQKTFdy5wJWSfYUFDyNtzvdplJDKGm3Kq2QfRdYl
jIYkTpC8sWOExG3QwHojxeEU73ZoWlX8PsKZ+Yll29UGOxXIebxNLZM1uTsJ2eRBSnkrE7ja
bj33WMA4ANa5lZL35wz1webA87Kw44XAAZCUknvLeO3Sktq2RckSE0RVe4gWcn2z5fGfhg9E
JJbUNQM3c34GWBVHkt0WtIz023S3JN+vsn67oN6v+n69XRBL6W9I96e24P0iSVHEUbS2+ZPX
pKndh10cjUGqZl1MQYPOdzNWKub8zCaBW78H8uVfrz+f6Pefv97//qbiD//88/Vd7jy/QL+A
0p++yp3o6Q+5bt9+wE/rrQcQIu1q/z8ywziA0sK/oRhHlydg8UlAkG3np2G+//ry9YnRTHL3
9y9f1VNXPy3GZJJemjao8d7LwtJxi/r6gh2BFNmpsbYKmM6kyiCGu3sjOE30kLg44Z072ROR
6gQZiJMXPAGAnw44/FZLiWDGYWSKxZoBJMSjsM+asARz0eUZ4m0sdgQwA32KV/v10z/Kt/cv
V/n3z2VxpdS0r9R2tx4hQ3NSF7JzOSMCt7Wd0Q2/2XPybkXG1NqjQTF0ixHZtgBgl+Ktu0NT
554jirsnBUw1uuJ49k7L5/vMFxV/747ToyhCohbJwEgZ39XaIOrShzAgHV4C79KQrjjnuHR4
DEmNJJNCEm4LJX/xZnH7bKBj3DY8qWsQpEx6GvWYi4pMWDkxCqgygv7mfsM9wiTIu5jOwszy
wxkzmpbQ4aJmiXofy23LpRCowZq2KXPdcivHrEzZmzkQfq6PBQNl1F4dpPNt0GeUYOYsFjsN
KiCYm1MDJRI6NowXuYFL/rWSKvRMJm7tqfEs4EZKkpNW2Ju6AQCr7kpnvdupjoW7wAoRr2Jc
bLGTVSQDFSfwDplDKYoGGzyzkQhe4M1h5LPt+O+gXFGV5WkcxwM+3i2M0SrBy5ALvxaUeEtg
QneB6T8RwDg2drQkUSXOV+x+WU2FT0u6IlWPV/HcNZ0dVEh9D/UhTaMI7Z1D15DcmTWH9dr5
0Nf1Z9HwoirscIwGBzz3Ht4CZAwYlrW8D3Vv9XXmSJCCHpvakr3193C6Mje8BOSB3bfxGxeF
uupzynNO1eFbisW0wewxFVKbEkPUaRMgy0aOdUG7FW6ibXqCEi7uviUPdt53gG+lwZ6uyq8S
E0OApHWMo+wCLvRsM4XTuYYrK9nXTihcG36xPBRs+OHY4wk6G6FLBG9RSzOhL2fqKbIjTBZ3
f+Fkp6LibloDGkSMcpQJjQeNn9C4JfyMvgS8MK26SREQUyhtEhWoxBp+uTnQms583ZqQeWiL
sPLLC9wUxSbxLa0wooKdqyIUeGCk+eyGZdbfQ92CMX0ttwOmA+O5jktWBsemOYbeJZypTmdy
LVBTvZmGpsmm79FFpI5snW0pRqPWAzjy6aLAKcMRd/2R8MCsoH0oiUQECgFMKLt1qGYSEUoT
sB0rWRzh84Ee8cn0iYU8X0yfM9JdCluuYxf/pIo/H9Ho4M+3xDmWkN9L3RibJkwWSOrmwZwF
61bb8PGZp+na2mbgexP73wNzg1Q+888y2ULzQ6sF5rSwLh7XS26SjKJzmN06V/eU33F0DIxn
Qar6QTfURJjC5jprEJaOp6s0iXx/gjGrAvw2UbnMpeqaurHDVNWl671TtsFDEDsju4fo0KsY
SP8Os0lXgfdf7Mwvcs/BPWUtquYZ6yXJse04Uha9ibWjDZmcI+aTFE3l3EALvBVgC1LSsHPD
mH1Rc4i8+4jupWqOIS1sojnDWQezRIKXjOyiyBl8AwoYUI9YY1s+QeGgTLbWUudYeLC6/OE2
Bsamoni4kXVySnAS9rkbycAvKOTdaGg4YaC9zS3gwKFh4FHhihfui2c2qqmkIiX/HvBRTiv7
hSqe7ZNoFQcWIqcPW8kZf9ivUmMF7bkPeYmNZEKxLKtygsnhVb3hBMpX0DFGPl5DQwQXqGDl
jG0LhiLD+aMclhl+Im17Y4Xt1KyVbkuZAA8ll5Oc8TG81U3Lb5Zell+zoa+OzkyeYUbSxvpV
FKczGqTGpnE4sqBg9XdVoVN4gQVNEzA9sHpfXE1Ufg7diaL2doC7wDM3VNwCVb/Sz/ipnUWj
bwPmPjG3A6Snetn71wZVJXvEQZR5bmkpeVH2jg2lAijLLXwOPZf4uZXcelE+xbQRKZwauocn
5p0XB5IxuM1zBl0jqDgQJ86gyWBg5x6HapesbygKWtcVjs+VizeBhXqUVSlSX6VTQFOkm+mJ
ciqFBS9skE3h+c5oWPuyjuJ9MEn7kkbb9aIFkvGAaxHFFrcmuDjH5ArWZHDg47XFqJYetG8z
22fgdPPcUQBgeRnwa2s/Dg9R+EVHj0cweFQIfdlJ6ZP8DFphcFeCITmtITl2QsXyxZGfOTHy
U8wEfZru9ttDIEs5J3d935v6zqcWGUt3Gown0mesXn+MJz2D0y2SerOO15GpulXCOk1jv+SM
ZiRfNGdEaj3XT5PL2WqKxa4wWxA8E7d4AIosjRflK+p1ei+v7c5toAbuXWBJ+yJ3QTRrK7kE
vRHUxkD9ldwCZVYcFPk4iuPMT1v1IjjwRnsKZDpipfzvZ6qVm1C6URHBUmmEiMN1GvWTQO61
Cq5KKrffwGNOfCJxbOapdWSZRqver8nLnQKMuOfmb4Q7DyhFuamd84qXHMifMVxIHb/HNDM4
T5brhGZe3hcqpRheuI0xO9pRsoukg3/t60M1IlKL3O839guAbeuwDvk5HHgeDI8HeLkBwlsD
QfydQEWAZm2Lmtu3JmymxzDbtoG4Q99sQOF8ajtxF6Qsx4WwOodXtLW/TpmLm8zj3SArCgXx
SQIeBIBmTV6oX04YKH1J+htoe9+Nc3eIf1f2npGJzAnMLEwg0nn+HBXkmw/Rj2lYwmV21aEp
7DvYe/UZE8oN0Ditq9se54JYojIisJ0aUM/kquVuC9YWR8LPi1w6UaXxBteEZzxmUAJYKW/u
0t66XwCg/HNuoMZ2wAYWu44wLmo/xLsUM2IdybI8K8xrRYssJG4oCkyesClqJ36tQegTRQuP
Zs4OFL+pncaJ7bcRfsY8kvBuv0NPGy2C1HYWn+CSXe2cI00bs0cxx2qbRATr7hp2ofRePWB/
OyyrwTK+S1dI/ToIkal96JDyoPv4+cBRpWEk+kzOnW0/NyXu02QVR74mOaKfScUCZzQjyYvc
Ra5XNDgWkJx4syxVbuabuI9dBLRjCr1lwWl7Wqw3TosOrtN82ku1dc+Vp3aepDYfXohqmbxk
cRwvuFvxXQWhv75B1Ih/LCNV/PPp11+S+svTrz9HKsTH9RoyNpgjgCH3zrNOyXq4Dg0dJ0jN
iqPSPrTLcgU3Vj8//v4VNGoZI1tYgpcEqCgYSP4aWZYQjLxy7Ck1BswLZOUsSz4F1iHxn8EC
3cMwIlWD3mAmZ46v8NbrG7zy/l+vji2kSdTAWzHFZVntEQMu+2hoZ4+MSwmiqIf+Yxwl6/s0
t4+7beqX96m54SFlNLq46Fp6QO1baQ1OyBNfJ3guboeGdM4WPsKkXoQfOlkE7WaTpv8OEaZ4
ziTi+YBX4UXyv8Cm59DsHtIk8fYBTW4CCXXbdHOfsnqW9b1PApr7Ywo1qQP+SxOhyMh2HeMh
M22idB0/GAq9Ih60jaWrBOcODs3qAY1kXrvVBn9WfCbKcB41E7RdnOBb9URTF1fR4CxxooEI
VmDT8KA4c1L8YOCaKi8pP2n58VGOormSa8Cse6Y61w9nFBesxZWIiYS+8G3yYHwbyQ/xG3Jr
Lq3kgn2Qj2DJIJpzdvJeA0Aor9U6Wj1YfL142AEZaUEhvU90yLC9y2K71vkTfEpuniCggVR2
+KwZfrh5D6qNCLikkf+3ASO8iU5qWqQFBRVT9ZdUUmz04p7MRNlt8VjagkYFlVZW4FhrCqkX
gAXXPdxUg2UlCzhIcR+dnMpVU8ON4D5jS3ho1DcdW+aPFcyLjtpRqDRUB3GFMpcFwmnYfoeF
PtX47EZa4mcIrXetnl24HxXIw6qq35kJF973PcGlYU3hbyBuJ0zTA63GjJYCaXA5SAEDng1w
3kQZYQOpSSiw+UyzwkJPzGj7WmCCZs3BNmab4McyebZVkhnRoXfwDl7uE3jaM5X7K2swdWYi
Ui+Ak0wgleU0L+A1bPvYekIKlmdIGqqeXkToNcIPtuWjEzSG5ER1JV1HXR/GCcfIUdlS3Euv
3kpsugM66Ap58J5wXBDBA012IM65Q640lx9I0z+filoq7wiG8E0Ux2htQAA+o7ZxE0nf2uZ7
DlhqEiGMG4ZvwrVcYZ1QBAgSz7jtO2wylJyS7cHXTFR8c4c1aojSH+UQZOjjnDYNbUXxHMjg
KDJc9LRoTqSWaiRmsmERPR/kh2UbOGOQMyqD1exZTtOsYRjLNR0AnForP1b+MxA8B9uiM2Em
5jIsijRtWboNeFfZhCTnu3SNi88u3S7d7bAe8Yn2eJ01zt00ELzjZOPiswCikypkfCdjwYpq
YK4VLEowiNXDFp6lVkL7jHZ4YYdzEkfxCq+pQiZ7HAln+/AqNM3qdBWnAaJbmglG4nV0D3+M
4yjU2OwmBG/DnoZL2vWCGCHNyT5arfFKgaNEa9tU2MgTYS0/gfF9oMJFgZoXOCRHUpEeL1zj
RrkosFqKPltF6IGmTVWeP1HBz3g5x6bJaR8q4CR3ygKXfW0yWlE5Qx4vWr7lt90W8wV1qnSu
7UfLnQY/izKJk10Aq81z8K6qAtzTolHsbbimEequuqQMLl2pJcdxGsWhykgFefN43BjjcbwO
lFBUJTwITtsQwSg2Y8PF+u25GgQPVJ/WRe+ahzo5P+9iTJhxGH1Rq3hTgbmdi6EUmz7a4nj1
u6PHUyC9+i0FuNDSExCoY7Xa9NDERzXVTBEt55oLdXnvGV44JCz1nGpQov3OtZ7xsRH25oRP
FCf4cCncKjRc6uC8YW3DqXjEDVkWr3ZpYBdQv6lI4lWw33mmGBam4Xh0SRT1CxfAJQ0mayyp
Nni/aOQuVEKboVFubJKODXZUI4eV0apwX2F3sTwQl9ahEnFiOzC5OFYKHurpxakRRnPuQtut
RJVSIF2FpRbep9tNgLWIlm830S6wcX0uxDZJgnPks9KHHlQ9ayp66OhwKTeBFnTNiRm5JDBd
6Qvf2Fej5rDIe2FYQ0epc2jqwCuYikyKevF6kaWGulGQHYzuZK9I0tHPTU3APDJwbGTolJAn
p6rm514JBylT2V1k7gtWfSQ7RwjboXC8Pel3u+1+Zcpd1ksSpPv9zuDDh26aUwzttQsUxEi6
3kTLvlYH5AcpVeDvfc40eQGvhnR+xgp3oc5xw9hVVIXSE0XiJ5KjKrXg2qD9hM+9+LT3k6g4
wIwsqW8FMcYZXssyFkfYhYjGgp9yRQR40OiuX6TvCnGeOzSsZcHyS+LU6Xt/dvVtIqdzW2Dv
A5ps9PlteARHArSvz/oW0O8zUjGw/wll2WZlutmtF+ArMzNi2RLAqRrgl6O6457TaAOl3lu8
at50jSDdDSKPYFMLlIHtSjMBv8F6ox9s+8exTXaQxHHh99Vq3QfArtzoovQxhdc+ymSfZudg
0ySrS7Z7suy8jJGAfmAa3F0SYHuGCS0zUATbzUMupel2U0Ze6zqIDy61tzszlouW0SwOcuCO
Ua3QzYOmQJ5spmC4J4RGscOCvIzwSy+NjPF7KoNM7iBXWMcblGOSq2Eb/P7GIB0BUV0En17f
/1BBS+lvzRNc0TsRgJznQNQn/GtcbGfDLYVoM7jjQCqr0XIv1tcpXrKOYEHMNc74gEO6ZXE8
YV6sdjdtl7n3NwbcHnR2DlTft9rws9f4I2GFCXDjQYaabzbWicUEr9YIccHOcfQcI5iSjbqe
sS/DhmaOh4IYV2hDkD9f319/h+cPFxGdwIbPdiBADXlq2u/lriBs/wgdhCcIlCsKtLRkM0Vk
q1TIaPARN07UJhbe+9vrV8tsRcep+uv7hzTZRLIWCq1C0iDhYczpoRQtVrizp0PQu0NM9IMV
FYRdCyGGulO/+cfYozAqxhIIIS38IBkG/YmjPi8ayWlJL4U/qQGRZTVqvDrh4y3lu75HSpxw
vtIQJvR4nE9o1t8nQY6B5z5cQvfxliUOxkaFB/+4vkN0IOe8A5EpjjdS9QrVStGa/r/XCFr2
2357Z8IYU9+We+5tY3H24f0Mg9mi2xIviuzaEB+UyJJXQ9WiRSkUrcuq6E1X+jl7FFj7/Vla
Fz2phXqiR2pEdsi8cTq0nQ5GOoU7dJapR13LElWo7866XVGedsLlj9ktq0heWJpvdvsMF2q2
m0fTE21yX7lHRQqhTIVDrkG3OgMBGr0DGpHD0RYu7Tcx6sE8IjRy4dFuw7Fzrocjdx9NbD43
uDvtGXyfXGcrFR5aLvUaE59PlzEat50/QMH8ODyeYBnmXfpbmEx0qhp+QMB5A4BXNmphGYXP
MMnRL0X1cWLiJhTOzOLGjpQyFlwS5U4gHwVVjzBApFAfDrHijE01huHCfSVWobQfl76ChYMG
D82tQwcNkFzVEQkBeIUH9PIGu83S5YOC1pSlk9fhTtmnqxRZ6tyNXzgB1TMJUnBgqBHzTGZe
5/q2xPDVPsLgmRzb2nowD6wa/o+yL2uS29jV/Cv9NOETc8+Y+zIR54FFsqqo5iYma2m9VLSl
9nHHSGqF1D7Xml8/QCaXXJBsz4PsLnxg7guQiQTwmY1cDCi1lrEM3dOFAmSauGt1svaQH0u8
tsXqUCMph3+97GUECRXThOuJqsyKiZEWr2cU7ST4oYWRljCwAEpbqm5hZLw9nTta+0Wu84jR
dzCktVl+Nvr+h172TqgjulmFgWs1k94ufNRkM/P1wtj6XiyfVvHfxsoiqHtLxGlAXdpKkeV1
j4lR6wtC59HznElONOnGSnBscBE7a8zdXn6UB/XGELblbGcrWuL18dvT3R+zgGu6vJu/uoE6
q5x5S0iYUpv6uam7w1Aoy+q5sQT0broWHb/TLy+7lrvpHbTKnJuTcsIA4kP9YPNbaErjy5Y5
rRfDiYHI03XjEulCGOiCCGcaTSsqP4xzbteG7nRVsvCrrdGOwKqYSANRPGgV7yL//Pz6/O3z
019QVsyce0wmxHA+M4edUJl4cNWyJb1+TOlr0QpXKuatF+ZWj3ngyzc6M9DnWRoGrpmQAP4i
gKrF7VDZESZoKGnrJcSLUvrYysUf7tbXvK8Lst83W1Mu6RRrRA2rtViJqaSsPnS7NYomprvo
iBgSYu2tKdbQHSQC9D9efry+ERtLJF+5oU/dIS1o5Ks9w4lXndgUcRgZNHTCptanEgqvTGHK
6TRQ+qq6BipTyw//Pb1jhZ8PGFgna6+xClT1lF4aJzwiz1smMI20IYtP8rViAAm2FmMD4PP5
54/Xpy93v2H0jsln/C9foG8+/7x7+vLb06dPT5/ufp24/glaMTqT/4feSzm+G7cYAIrxy6pD
y4PsqGqrBrJaxKWj0dltg51B9tqAWNmUZ08lTTNfKT5fNniUPdjE3xnhSiTOjttk69/DdN/y
KYEsw71/1XuFVc1o8aKFsCWeW/kXrNxfQRcCnl/FXHr89Pjt1T6HiqpDM88TeWvHGerWU8fQ
0O26cX/68OHWoQCrtOCYdQzE5kb9YqzaB9UBrRh46Lx8erDBy9W9/iGWn6ns0sBT9hS0RJMV
QOvCokwHjPCnFIAYUZw0uVTWu0S4P7Y7/V5YcNl7g8XqNljaRZdy+Yr4lmPca6BNMVdo4fli
4ZjlAtksEM0AtThmSFpCusi0slnOxkBobB5/4NDK15XaeJmDX4nzD0UoQuqVRz+dPBLRhTRd
WyBx9kj4Ra3BPNUVVRORC4ZAsmSAoQlzvTEuWmwmTlTmATedZJVeJ3xqjkcd1mMq4LEshSJF
PCzZqRkj0eivTkwqvar9NfPI0G4Izk/S9Y9Y7iawjzjkERDi4uxP+6q5VpYzOwCv6L7Jktzi
o0X54sND+77pb4f3tJrFB0xTKINPklhMeRxLyOW1hb///vL68vHl8zRqtTEK/xRhE2lzZHfN
5TxCY11G3tXR+58vH2TxG0n5PzL1hyIVi0sOJgd3XE6eOfnzMzpFl6LQQgIoK69J9r0aW7Zn
W87rxh45jK0EaVNelFSNieZ1he7O7m06t8TDz9eVEs7I5BVmyfPfGIns8fXluykejj2U6OXj
/yGCdEIl3DBJIFGMtfVFeaEq3Izc4VPJthwv3cD9N/CTAu6vFN1vS09VHz994qGzYBfluf34
X7Z80B9/4vW+JE6aDHkj71RmHZYvJ+l/PeGbotVNwI0/55fdy1St4t5H4kdhf3+CzyYn/VIW
8BedhQCk4xfcpra0irlcGfNjj1o7Fga8lZcMDWY66Liez5xEtSExUMVYR0dNhEF3qvcbC3J1
Q4daHBeGsdlf1eZCsrjel6f6jPAb+M3G6fKytkQcmVlgoBzb7JCRM2iuLmramVm0nAVx7YcW
IJUcKuM0U7aWiQCiLRtB9z7CxtOAqha63szR7TVVeP6kGt7r+4gYLtZ3olyIZg9sT92lc3CO
IqRkJt5dOssy3ojwOl8ev30DzYPnRoi1/Ms42PLTJaJvcbHEjk9ihq3ExSXrJYFS6Akj/s9x
tYZfJ5qhpQh40DUPTj7WF+rpBMe4G8WzYgQgWmyXRCymRrnog6zJwsKDcdLtTlopzH1+IpPu
TOcuzWXbEE40N3jR3E1x2+v+1efTB3vHLsoopz799Q3WcWX3niKp8cfbWkkmqhrAaELa3ijh
AcNUW1tcjEVH63FO9a5GP/BTHt/acMIkyPxs7KvcS1yHbCWiFcS02BdvtI6wujNy2xWxm3iJ
dYQrIi8nvcvaD7dxrI2k6t5PA986Wvsk9q/G5C40tUA0DV9uN5YR69Nh0YLme1+1gVkUpq5n
tvz75ppE1s+EVZgxZKyG0AsaOkZWQE7TgJ4IZlcuYbg3u3g3Jle9gXnQevRL50ZGwXkocg56
lLWxMBsrct9zr4r8YpZjEbCN8hkrshvRxj7zTPLd1BKqQZqB1CMFAee+nyT60ttXrGOD0QfX
AZ/lWAesFN52vmQ2ayjccLDdWzVfDzrIPidS0JfOw2EoDxl99DSVN78/SU5DLu6sSrj//O/n
6VRkVXyW5C/upOdzdwrkQr+yFMwL5Ls+FZHDfMmIe1FupFfIogivDOygnPIQNZFryD4//kc2
HoJ0xGkO+m7SiyAQRl8wLjhWywmVaklAYgV4cF41ErfCIb84Uz+NyHIi5FFjVeZIrCVV1y0V
omaTyqHYtGvQLR/oQwCVj9phZA4Qy+mWiuXprAKurU5J6dCrjMrkxuRkVAfTIlbzEBvZWdGr
uTfpvCflds4/lEz2wyQRJ6VJ0VIk1DIzdBb8c1QsmGSOesy9NPRocPPLRaojCyfQxQ6BMvYs
eZxq9IwnnVqJz1RsPYVAOwAZtFafnfq+fjALJ+gbBx0KG4+LQi2mk6CeFfltl42wCin32JM5
NE7tE31BO3HwzKhRzyUCASsX5Bjy3vbRVJDlvYZkoHTMBnQXi4KuE0l+w+ZP8ovnuJJ+ONNx
CkWOya/POYWuTDkFodT/maEuD92tPCvLyIyxHaUQzrUCVDGx4h72B8tHc5K79x56pKVymyCr
taHOdyyoaKBLxfENrdRUc6mBrjxOkfgV+tJ3/NECVV6BkEWdXzpYRgzCoPfsT2V9O2SnQ2kW
Bx9rxk5AFHRCPAsyS4RaNTafsM9MFesx6U0e/hTHYps+82x54Zl5UOfw4jdZLB6/ZhbLUrwW
lo9Js1fr0Y/kEB5S7dwgjGMTKcqR3y4Klki+kJY+5s+YSAR0isQEYCwHbng1hykHUmI8IuCF
Mf1F7IfkF6ByEVOBNTs/iKnRMr3mobtnHm585Ip9LKCfIyyckzXkJtMwho7F0ddcrGFMg5A+
0ZtZTjlzHfKuZGmOIk3TUHruowXh4j9BKVCeUQridMWoBWoRVuePr8//odx/zwF6i9h3A9VC
e0ECl1LyFAZp7Kz0Bn01qKabMmSx2VJ4KJVa5UgtOfuSrYUMuPLskYAU5Ge6rCM0Db1YyDyB
S9tcyxxkkQCIPKpIAMi2cSoQEkmBVOhQ5DyOPJdI6Frd9lk7x6mkvuzLsiA+HK892a8Fi7zt
lsKIzh6lNcwMVXh/y5qdWZh97IKOsjdLg0Di7Q/UJ6Efh8wEDiynhvr8PtPm7HFJdwQF8zRm
Y0mJEksmdegmrDELDIDnsIYoFghVGVUwAOg3UwuDMDOhPf/NTMfqGLmWbW9p/l2TkVqtxNCX
V7NSFZ44Xxr1ldoCjgm9Vs8M7/Jgu4Igqgyu521Nsbpqy+xQmkVbrkgIiO8OoQ2IqcpMkOWp
us6lvWNWYNKgU+KArZdYMRDwXGL+c8AjlhIO8FpS5Qg8y2sRmYMoB/fX4brkRAIociLKtk5h
cVM62ShKqOUFoZRy2iMx+K7QjEnEJ1d4DK6+vShxDp8ubBQFRJNzICRWbw6kxBYkSphSn+S9
73hkQ495FG7vzbl8rrv0aRP55GhoLM5jJQbqIEmCqbnUxDHV7kCnjnZWOCF2M/S3SlKpCdEk
lowtYdQkhu3lCBi22yENPZ8UpzgUbA02wUHO1j5PYn9ztiJH4BHDqx1zcZRZsbEjVsI2H2HW
kaMCoTjemszAAXq/Z/kYBvXWGG17HgWG6ih+z5VSjdXrrkCXT6zeJmUh0Nuszg4DkOxLKnnY
/m75ft9vbfxVy/oTaKs96xm5Gw5+6G0LQYM/RSAygJ6FgUOuBRWro8QlnZqtQ8sLnSgi5wRu
SDGtzUo8fuK+uaqTJRfLukOIoYB4Tuw7lo0EsPCNtRnWzYRYdxAJgoBYRFDfjeT73mX0XEvY
lYgvQOMMnMAjhzhgoR/FtH/nmemUFyntVUDm8ByyGa5FX7qklczM8aGGYpO7G/qCeEsyZMfR
9oJm5bD4npY4/L/e4si3enIyVzc7smhK2LtJYawEmZ2+iJM4PNAGzS4FIMLzTRPB8BRB3JAq
zoylW70hmHY+tc+z/BhGV/Tj1Ch6vYJTKzgHfHLysnFk2iwhCt5EmxIZyAqulxSJS8pe3HWk
t70+cJ54uxgZtHryxlCq2swjncLIDJRcA3Tfo1TdMY+JNWk8NnlITpqx6V1nWwTgLFsDjzMQ
awzQA2odRLpHjEaghy4xfs9VFiURqS+eR9dzt6baecT4JGaal8SPY/9gFg6BxCXOAhBI3YJO
KvVsX/gWekj1hkBwFbOaE0qsNWwG49b+LHiilq4mzL0jccogkPK4p9rbaschM6gjjctiGeVd
eH7CK11dThTD99sCtN0le+hO1CPohUc8YeZv725liy5qCyILjA7AjVshtX85Bsyt8GbjgMvj
68c/Pr38+67//vT6/OXp5c/Xu8PLf56+f32RzxiXj/uhnFK+HbozkbnKAK0nvYe1MbVd17/N
1eO7a+UujmAsSvFSZ052qzUtn4l89PaxBR5h3X4k+lshSzkpJpPC7dLGe29hLDQnvraQuGKk
gdAhijM5jDCBD1XFnRSZac2+i8xvJrNI+Zu1Tpet+syutaQ0pcu9a+Rfr+TnCxN3FbaRwexN
yaxOVldN7DouOrdcq1JFvuOUbDdR18Kg62CPMxO5FFV2wNs1qRqzjdY/f3v88fRpHTb54/dP
0mhBj0M51W6QkRbFfbYtsqW4fAo8a5pUm6CH646xaic/hAaq8gN9anSNSoISYWgt+usZ1VIp
qk7/Zl1rJQZLQYWDCUybO6uhc1aZSEy1W97lTUakhWTpjhOZRNnziiy/wkHfNC0crLNcMSPH
WgHqelni4MGc86bVqmKv5PyMa30g/fufXz/iawbrA/5mXxi7EtKyfEzSIKTeTXGY+bF8GzLT
VAULp6OwwrXcKvDPstFLYsf+so4zcYeQ+LYKxO43uI51XpDhhPeFiJ/hqIcVnF6kYew2F8qT
CU95vqU3aOrzBaTr1vorzYhwsSK2J2O8f9Can1TbF9QP9XQ5Odn8KHXIj0jNiHclt3kw2g6p
obdZg4nFZnmxsNA67AxHVMEW0FdbXLe34DS0aFa4DtlY4pOg+UpJ7pjc9a/XK0nUbwVkiL5W
4By9F3mp3nzHKgK1gTcw8R2o3CCTsCpXXB0jFfKhzdXrHkDZCzYSlIfqmK2Ir6S2Bjfvzpuu
0JwbAXRfNobvAAnm5h/k6ciKhmpmizmTNlEWAwltmqDtw8YyIhhCWxEEnERGbrNFhZlYEtDW
AhNDkjr0ndiCe7bZN7mbNcrCbTj09WGMfEu0txlON8pRtnvP3TXU0Co/XGc/nuoiYPERjZjy
aFuio2imp9Pn+xCmJd2Ip3znBo656stpLvbnMpFbcehZDXk4hgmlzHP0PuHWuuonbThGLnV/
gSgrc80dAadWQRyZHrw51ISkaTrH7h8SGNSe+Q2j18Nsdw2324a/gph3evjx/PH7y9Pnp4+v
31++Pn/8cSdeSVRzaEhJc1nlMWSxu97jqLGmz9bwfz9HpdTaeyGkKW7rMWyIgop3JeoQEGZb
emNCOnVDeYvlQ1G84VuSRvsj1wnVCBDcwbfFUGT2/m2daIIhoUOzrAzkjfECe26sVhUrNb+d
MWoLQBjZd8zZY/I2QxK9UaeUNIuRYGNYz/SNnXBh0Tz/ThjsJKRl+qxBmjNzRrKTtncBEDnB
5ly61K4X+5onMD7QGj/0tcE3vS/ScuePh1TG8zUJtR1vtWNQ5ebpeRZF1MK2SQDRclx682jz
Sl7RJrQdis6wZfgLGPcsWxs21N4F1MAqFIhzDLVy09kGISZPCO0eYGYIHTO50DHbULzA0nYw
7lsfX8SZ2sGMgQxr2zDWz71E2zTEqYQ6Oua3xmod8yL1A+oYcj6OWXYe2W2TTcdbPp59sMv5
rY7ZDZN5g2NfXUsY0F09onnOT5MBvQOehPNOdmpU0/aVC10U86hsC99mriAfHmB1ovKbRMeY
wlBxTSLpEkqCitCXjWQlZJpUddG5dOFnDuhKfEOwWXJdOVYRVUWWMLu598o0669vsVlfdmo8
qqW8NCi4prf5/aR0Ea0JiOc6VoRsmX3Whn4Ykv02+YggilmxOvUtb/AVrsiLXeosY2UiFmcJ
BDEkJsvNEUuPchP07UbUX8aqSBjSU9Y0XDdZxEZl+R7AKKZMc1ce01JdxUJ5w1OgJAos+XKQ
NH9ReVJVVtZAchPSeRKqTRclkC64oQpqaGLZPHU20uhZYpoOCiaBg0pG2LG+mQqomLYEehek
Teq8RGLqw8CNyHbqkyRMyVYChF6Tm/59nHqOpTygpZL3mSvLIqITn+sKKcWyP30oaT/rEtM5
SZzIUkYOJn8jAfmpgwRdGorMXwmq/n9WcFZMTQCkCbqUG68YVibmNX3mWEI4KFzsjV5hYZPE
EbkILFotWU5WH0DYfKM/DNFIgiBxJ8osUOLJEYlWCC153Mj3qJ5YdD76u8jzI4cefkJ1I1/g
6kwxOTc45vqWRW3zMYzORouHKpPwb2BikxMDsr/O+s28wbHI68TXQtB+63OUueXMc5tWls+n
L6vMXKKvTKSj9KX4becxXE81KxPE5QwQGbKqZces6C6IUsI7T3lOVT4kkgGQgWubt72ZcVcM
Z+4YlZV1mSt3XJP7mk/Pj7OQ/vrzm/xafapf1vC7AL2KAhVhrG/j2caALvNHEMPtHEOGLh8s
ICsGGzQ7rrHh/P3qikmOXYwqS03x8YXypXyuihLjYJ2N3u/4MxfFi3tx3q37qJKpkjjP9Pz8
6eklqJ+//vnX3cs31Jh+6Lmeg1qaOitNVSElOvZ6Cb2uKuOCISvOVuVKcAjFqqlaXNiz9lAy
PZPx1MrPC3me+zpjRwz8fMvhL6ajlxYfV6uV2J32+LaZoBYNdPyBAM5NVoNMLDcs1YBKdy5+
II3m1XsQO84cKEQKPP3i+d/Pr4+f78azlPJqdQBjoGnII2uEWvkRPufNrtA3WQ/zmf3LjdSE
MPwtXnXxTqGMkDgT97nMSu5hDTQHhm9UDmoup7pc7mOXahIVkZcGw7s6mgWs7kiVtsTFbZ1x
wlzl6bePj1+kODrKSigGFB8yRLV4sG0GgtaaD5KaMFLNwnm249mJLDooT6dOSCF/yeO2K9v3
akaCnmP0DxLoq8ylgGLMmaM6qVjBcuyazcre0C1/X5FZvivRbOYdnfK7GiNw7nLq/m3luofU
85FK/L5rqzyj024ycuBJDEOKLxozKuH2kjhkdbpz6KYWQI4FrQG3lC5kn+We5f5LYYp9UgvR
eFyyb1mp2FlKQJtC7l5CF02glJwk8UD7X3dk2oi8IxH4T6jad+sgJUzrPOFWAvT9gc5Fn+lr
XGTEaZXHDa1t+D61HKtoPPTtkcLkv9UX472jPl1WMNclfbzLPLAcJQ7ZZae2r0+MgsbItawa
Y6c5RCd5TrB/UIFyJJ5zEvoelfc5d4TTOBOBVaGhi3WtBh4jKK/IOGgL34fcV0/1uIB8oWTf
aUuAtVUr5ofBjwIzFeiNS7mDEloKwDwvVIa3yACg8WyIw9nXx88v/8atED1gGcHfxKf9eQDU
kMkm8mLNqmU4w7APk/2oceEuXe3pkSxYjwUwWxuQD9LImV8EfCFRs1kOXeyoS6jULr9+WkWF
jfbJTk6izmGZziVCe79fPVDorubHE3DLakadmapMKMh9McQ0tciKhMVlEfogDeFxRIbdqTiU
pPXlwlKoyh5rGE8alDBr2jsv9yYjsh6ZLelnzOVCjyRU/RdW6pdHpWv+sdUxZeMlsvGQTCXV
jAnCNrdAUkuzl99fubf7T0+/P399+nT3/fHT8wtdHmyUrBpY/6DO8WOW3w97fYo3rPJC+s5O
aIIgkGpi5yS7P357/dOuz7Gu7qKrfCswKTiXMIkCcwyOl4je5VZYvbk2i/Lr47LCEB6sp4ld
XqtTA7oRyPvUzaLC1Q2V+jxeoM11a5UpRt8l4phSJf31j5+/fX/+pBZYn3RhIr+PUcjz4NFK
wLIsdn3qBaeEU32Qd7ustp5jrJMdLVkzEWfCmO3ZOXZJCwI+H/ksNw7CV2j7u+xsfCVPcNrA
FtlAJhg7aQZy2ujqBF8ltOgdTCUVxW6oioOFipNJPNRQDP+FTnrqMXaptkNNLOKYZtFRf6r0
sczCOFQv7sS5ThXEthvEhcEljzEXODI2/WbQDPsUtGA78hqXJwiadsX/ko4jRU7HbLgniYay
eV+WZHgIcbiHoc3bTl3YmiyV1Qap0dRBPuUKoz92oqO1EmO5h7XG0xMUViNmekhPKIF33TYD
19gYxrOu5c8HMZ52ErrSiV2E0xtok55RCB72AHGsiAMfTzrxIT80TonEwhFEFvLtrExPKO16
jChM2Oln3sgIVfDQI+AWn5jI9gRnuaAYDLZl52ryX/FJwh1Ow0diBUOhAhmsUgUWlh9+EgXg
Ce2fvz9d0KXkL1VZlneunwb/kBdLqTL7aiiL8ayuJRNRxAsnjlZlN9mC9Pj14/Pnz4/ffxLG
/uIceRwzbh4sxM0/UXL49PTxBV3P/tfdt+8vID78wAAMGDLhy/NfShLzcBWGVua2XWRx4Ntl
TsDTJCCEYQDcNLUY2E0sZRYFbmhXZDiDZ4gYDev9wDHIOfN9+fZtpoa+7E9mpda+Z0hmY332
PSercs/f6dgJauQHhpx3aZI4NjJAqp/q1HPvxazpjdWCde3DbTfubwJbxsTf60ve7UPBFkZD
VsuyCL2pSykr7OtpupyEefqNDp+snSVwX68akoPEqDGSIyewkPnFz08TSszmn8jUF7sxcY0u
AGJorHBAjAziPXNc+dn3NPjqJIIyRgbAV0lTHhZkQinj9hwx6WN9npN96AbEzgLkkJpx5z52
LBYNs5DtJaTnjxlOU8foQE41GgepZmXP/dX3+ISVhhSO1EdlIBPjM3Zjo6ZcCp7WFvnGghy4
T19tA5en7lE2JhKeGDOYj+fYqKIgk9x+4Ju9woGUvuBfOUKXvtyfOVI/SbeUkuw+Scj3zlNv
HVkye7JQWnJpNakln7/AMvOfpy9PX1/vMAKg0V2nvogCx3eN1VMAk88aJR8zzXWv+lWwfHwB
Hljc0PCRzBZXsTj0jsxYIa0pCN26GO5e//z69F1PFiUJ9GciunO1hdf4xVb8/OPjE+zCX59e
MKDl0+dvUnr6NDuy2Ld4PJ0WkdCL6eCxHFZeoM2HTrem6qtiuryZZQZ7qUSxHr88fX+EDL7C
nmE9curHqsUr4docvccqDOkj7KmkDTQfbaAsMVCeI1Y4NPZspMaE/or0rWZrMOIAkZgfGvO1
O3tRYExupIZGCkhNiAWX0+lD9YUhDuzl7c5hRIlOnE4dkUuwsf1058m9GZFYvF0GczVDakpQ
Yy80ziqAGnvG2g1Usn3jyFxSMQW6HZIkpEzvZjgls0gVN28z1fWTkDhXPbMoIiNmTBN1TBtH
9e4kAf7WZoscLmmNteA9+kTV5YsxHW05jq77Ro5nZzvHs+MbEhSSXdcoCBsc3+lz32jLtuta
xyWhJmy6WtdUb8O7MGjN9MP7KDO2EE41ZBCgBmV+IKQoQMJdtt9oFdZUGWnfLeByTMp7YwVi
YR77jbKR0WspX2ZroFGRq+bdO0ws7xznzTv2Sfdn04HjJY1dQ1IGauLEt7Maj04pidBXPz/+
+MO69BdoVmo0N76TiYzOBWrEDweW3NS0l8Ax2u6oJHJgbhQpe5jxhaT6IkYdRObXwksSRwTy
1DV5RZ9WUlDV5tkURyT854/Xly/P//cJzz/57q9kKH2BoXz72vKyXWJDBTjxQsv7G5Uxobc1
g0uNMGXmZnH1pDGmSUI++5G5+Oma/MbFAGMabFjlOJYPm9FzrtYqIGp7GKuzkS9DVSZP1ug0
zPUtJXw/uo7r2Ep45UYKb2R9zUNHPpxQscBxrMk31xo+DalDL5MtJmwbJzwPApaQnrAUNpR8
o3B7QNleG0qM+9xxLNqLwWZ5q6azvVX0qWwe3chlYG3/fQ7SpgVrkmRgEXw6Wkb9KUutI5tV
nhvGtrasxtQlH9/ITANsEpasocd9x1Xv9pRR27iFCw0XkP4UdMYd1DFQdjZi7ZMXxR9P/Dx1
//3l6yt8soSv5Y/VfryCfv/4/dPdLz8eX0EXeX59+sfd7xKrcr7Lxp2TpJQ+MKHcaeIX/aOz
kzp/WT8CVD6KmIiR6zp/UVRXTx8nFBllmYNJUjDf5eciVK0/8pi0//MONhjQPV+/P+M9srX+
xXClbEz4Jfi0gudeURgtUOFUtZWwTZIg1m6/BHEpNJD+yaxdJH2XX73A1VuTEz3t9qwZfVfL
9EMNvedHFDHVeiI8uoFH9rRnieAxDxD6DcLydZoSiUb2K0sxuLQK42brJL5BhJokkZ4+35lJ
4yxEzyVzr+orJP7RtDAUljcVK4/oEbMskOfVTDWLXMvl3tq7lEq1ojHV9/r0gvEoG0PwvBls
jhofzBxHb1uMaJq5EdW2sSuP1/Hul783qVgPAo21fxG8GnXyYr1cgugR49T39HaGaUy7TkGw
Bu08sQ0HUdFAK1B7HSOzoUY/JCaYH2pjoah22MrNjibnBjlGMkntDWrqmOvxVAdKEOIWAvvU
0cdrmVvWdT+iRFHRHyDje86g9xJQA1d9kozAMNZe4ttGgUC11pyIeA5oDu8oUWnchui2N+wa
PhQu7M1oQd7Zh8SkrxiXiTjM82kPsS7JuIIk5lopeoH0Wi3BWj+IJTKep1k2Msi+ffn++sdd
Burt88fHr7/ev3x/evx6N65z79ecb3LFeLYWEkaw5zjasO6GEN2e6iVHskveKXKTjxy0T30H
qg/F6PuOseBNdNvWOMHyszNB9jQDvmWuk15uef+fktDTBpCg3Yw73ol+DmpiNXGXRa5ixfYq
J3+aeq4xORN6cfUcpmShbvz/4/8r3zFHR1+UcBH4Sxzv2U5QSvDu5evnn5Mw+Wtf12qq4qzZ
2OqgSrAJ6HvxCqXLzRIr8/lxyXz+cPf7y3ch56h5wVrtp9eHd9oQaHdHLyRoqUHrPWMEc6pt
AOPrdCXM6EI0ExJkSt/h4yjxUl8fuiw51KE5D4BslWGzcQdirG8KOVEUaiJydfVCJ9TGM1eN
PGOw4ULvG5LNsRtOzKfsTMUymnejp9lXHctaWGKJnf3ly5eXr5LnoV/KNnQ8z/2H/J6IOG6b
V1rHrmD0ytGTTb/hiY4vL59/3L3ibeN/nj6/fLv7+vTfG4L9qWkeYHvYOIoy7Th4Iofvj9/+
QIdLhE1jMTTGnpEBTbbEnS/CJLI4+Pv++OXp7rc/f/8dWqvQz//20FRNgRF61ltzoLXdWO0f
ZJLcvftqaC7ZUN5ApaQeyuzRVE6SNzCTPZq81PWgvJuZgLzrHyC5zACqJjuUu7pSP2EPjE4L
ATItBOS01ppAqbqhrA7trWxBP6Zih845KrZXWMVyXw5DWdxkd53IfD5kdbVTeDGyaF0djmp5
MSAqDvpeMQYEYKxqXtSxahe3n0o//gE6p7AT1k2BsOWqYTipZe0bT/8NTbjvYD1Fz138NdNP
pVnyh105eLRSAjB6o0b7Naa1JnML7gSBFIFwYJ0raGY6zaE6Z1pySLK4m5rR9S2eBixtbitL
RV/KYcfwoNlqX3HSrYFxV7bVqVH6awYf2Fi9P5VaaSaUei66ouKuV6lEVpRkMNs9ruQPrpco
BRQkaaT9VEGd+ZYbLEuY3DovtDpwlNpXJozOlvnqNPT5uqCmzLIzTExbH7GKNhLEoVR2MKUr
+nkH4PcPAxXiExC/2Kudi4RbludlrRSfkzWfVUA+d13RdfRRJ8JjEpFbOU7soSrKVl0FhMWs
nELfWD7PYXWv2lJjn6iwS2TNrTyTvusVnvzExq7R+6Fh+Wlv6eJTUStlxmg7h+sYhLIsAPQ5
YKdCnLxIaaVuShj3bddQNsB7IcF6V20OChp/q3AwBtKMWpcLxlBHi/UVq4n18+j5WovaOfla
vHv8+H8+P//7j1eQomGuzA/hDeN+wMTDXHz2XuWSuINIHexBMwu80VGEJw41DFTSw57UaDjD
ePZD5/1ZTbGqq9STL+Fnoi+fyCBxLDovaFTa+XDwAt/LApU8G9mq1KxhfpTuD7JJ2FTy0HHv
92adjtfEDyktH8FubHzPC2XH3fOKYmnBFZ9WLQrSPf2tCLp1kQq4AqaHLIKJe3+51CWt6q98
1vgTK0tWoOsdhyojh2ISkmKGE9niFa3vUNusxpOSjdYnoexORUHiJCGbM2uLbiC7T/InY2CS
d0yiGsLf2mYtJhdiZknPoefEdU9huyJynZhs8CG/5m1Ll2by1bfdqGUhKxZvrBPz9yAwMgxa
uhbpWDSK44m6O3TkGmVoDXMKrDu1cowX7QePJDKopD5vVELRZGV7wG3DgI6XouxVEivfG5MU
6UN2aUDoU4nvoMnWvXamCGt47iNEDjAAaMdY2ZyonW0q+VQhJUnV54OKobMI2BQL9i/fU7Oa
PcPAVob+P2xZDl1+22uJntGHMis5aMeqdrzX62fzJ8K/bGB46HWD1j5hvA7lAHTpBtRCLakh
jv0BkoIiicgYTb1hD6hQ058Cx72dskFLqetr/6ZoQTIVk1SR89XkzvI0Bn1Ofw+KrWV/FcJH
Q6U3b1a4SUIGrkKwxusJLe+6CoPQ1TPOxqq6UkvACnKtTpst2SlJXD0HoHkETYu3h9QLGdIM
kQ+j78t6ABJ3o3LRsZBuHbRZXnf6xMszx5V3cU5rKmxFtfOuD7DTTt2kTk6OWMqYs8BLXC15
FkSqAchKBbn+civIdZYzjde9VrAiG+rMM5rtwKOVkRs0wnX2UGd03OIlzYBMk4yZuaRofNN0
bWYtRUMqw4iU+bHzD3piVVtUB0qtWUH1+c5KL9698Zk2aOavjH6CZcB17skoZiuqJVa2zPVj
o48E2ZoUc1NfG91Ii0ia9JTKxPgbPks2+yZxjJnOifOTTIzNZdt7jjBW9Y+RRkcz4Q2bl66m
c+ioOYpg0yjr5GobrzOsLTz33XBwFQsZPlC7OlMpsNEzUMd8mkq3bFNdYdm3lKdtvFBbU/r8
etQkjqHqx6oo9boOTUleC01YqiXMSaFWR3T3kp+rnXpCxSUfoYPbNtsqSxS9UyJSSztXbjvW
adSrGu8bSA/NXiypXIM8Fv/kTxakVwh83Gj9AgTRtSZZSGA/9YGX3YZSEKzjTySKgtauLGn/
mzNbjwGoYLxgLBvr+M/EJg0ZZ/VY3ptFFbBwc2dDWXVoMrKiAocusEFcWLZg+lmohqJbqkyX
giQctkZ931ZR39tGcSejOmni4UZZmz0wt47v0PHEJ7ZVB15Ug2WImeUbSrPUUNCpo1XxgA8D
7FqQHKAcH8p/RYGx8vCvBdGQRy3hgxCjXXXw5bcaykulhAGTqKasWBhqR3fdX4xFlOnnwXri
GDJI/2pX7rq3ysl9NCoX3wo6Zkzz/6PATTdSES5mnn2mV47Jz7knwnJ6q6ptP3W2rEHRWlfe
JiD/AKJP7Llpc03xuAb2AB5gSO3SlXkY8Y0K57JKxRi7iyxwU90PHdeWRm393OUNDxtYeex2
OVZsrHVltSihL1t+CwVMVky0wORbJZ8e0uIN8f7709OPj4+fn+7y/rSYMk53jivr5M2P+OR/
K+/JpxrtWX3L2EAdQMosLNNVrAlo3jMayE6wyF1pjDFLaqwvqj0NlfYiVPm+qk2saq68FCfl
ZfJmo2qTD/ryWEWei4EbLJHgl7zsuxcfOOM96DT5mdHnbzMb6/bo9KsGTVeR3jaC64DcgTH+
xDtV+SZ2M0AO+ZXegFO0TmO0Shh/fI83krAVjvqIl/jmjjVqfB33/SHT23di+nC9jUVD9KyH
m3MxxT6bhjXsOtTd+jL9F918sweyIju5scVjtcoUufaYRTojHS1EZsMX0MQKh4jrJnYExKoN
ULukW/D7wCXfU8sMZK73QRDS9DAMSHrk+jQ9oOp7H/qqoaqEhCFlubcw1HkYeUReu8JLaGC8
sbwz6Tnzw1qXk1aASEkARP0FEFIVEhBl0rpyBF5NtRIHQtcK2LpdwJZg5ArPm8VSHc7IEB0Z
XmKIHbrgsaVC8WZ9YmNykWzXa/LmbAU+3/XtBzAzT2BT/xeGlC4tuu54I/mr52iROgweLu6Q
4eJlhtRsTNiQCZmmZOiTi6R7gXHKIJDEJ22xZQb9kG+lq6/ENUws6bqcODaReeDBd4K27W7D
ve9sTqQlosqNUUJdBpKjkxDl5QjIlJkFCh2i3TgiPzJTgNSzIX5MLCwCSYkZI7KhANYkqRth
DCdSg9V5Jl/tJhNIom6kH4TOQJwQA2wC6A7mYGqczUmQ5SJc5yKHCIJJZE0doL+ROnJp8VQl
2Hci5801ZObb3vCRC9qWGFczYm1DgdpLGbreX3+nlJxvu5Qwr3zVpeeCgBK1uQIgg08MHXYY
a/WV4YLMLt8MOj5aBe2tr6t9RYmYrBr2kyA6373oHLRawVjj+bK9qwxElDg2AfQQnEGy5wAM
wiimGpONmU8GZ5IZQuMkWiAVqGa2ayXkAD3eC9XQKApERjKWOWLzDHyC9CCTBEfskjOSQ9ab
jIkD5ENideVuvajNbdxnaRKTG6/kG+vNmSHzbs+OhdN39dNXFfauVD1kmB4yKgs55FYWup0F
XORXN9iWO0bmZ54XU6ZNK4uQo4hSIEJJ/9zxGCVb8PiCPjHzLk0S6ueXM50S4TmdygDoCZ1O
7BLrEtIpiYV7Q7Pw+8ROjvTAwh9ayhPS9YopOZnTSf0IkWRrMgNDQskrgm4TsSd0eypgRB2H
rkVqyTKlRBdOJ5ZdpMeWdGK619KEVLo+1H7ikCEhFg5+qJFGvUcumih2xaHtYp5zjJFP6Wac
Tu6mgEQW/wEzS4svc0jjX5kjccm1mkPkqw+Vg1qm+gz0dydTXx8oZy3KJ2KzRjOV22msav3g
aIVVQOzehyHrjxrKj212p+Vd0LEqTKtFIK6nxvDjtuOnUQ+wPw5lexiPCjpkFylmE377Rf52
vpiYD2G/PX3EZ0GYsWG7jvxZMJZySHtOy/PT2J1M8nC6EqTbfq+WP+uhnTRGJFWDRmQn5fCf
005490F0Nm+Ysr6vWjWRXTl2PRZBpVaHXdkKspJ+fiyHgbLVEWAFvx7U2uTdwDK96Hl3UkJc
Iq3J8qyuH/Qc+6ErqvvygZJzeFL8UkrLs/dc+RaZ06Bhxgpt4nZOKDtg4uBDP5RyDCMkwlg5
dO1QMfX15EKF5rGUqWyY0aRlnbU6pcy7Rq9vWVMX/xz5AM2gD9dmVw2K9Tsn7wcqNgKHanQf
fmJqgx079SpU/BYjU015jBKfultFEIonxr2S9v1DqRJOOail8mEEEi9ZDQNRpZ2r8sIvxtXv
Dw9DNmou0JFe5VlBW+ZzdKTkG0TeZbsh0xMbL1V7JB/YiJq2rIK1xSxEnffdxRKhjeMl9QRJ
IG137tSqYkPxBYak3op3aoMtAPzopcZc6PJSg8Th1Ozqss8KT+trBA9p4NBjHNHLsSxrRgwR
/sqhgSFma+8GunrotMnQZA88oJhKHUox3bSVosqHjnX7UW/8pmth5S8frK3fnOqx4mPUytKO
lLAjkEH2WI2kbhDTRl2xsnaEZRImmq2r+7KFBpIv8gV1zOqH9qpWtoc1VTxwMYk4mrSZ3MMy
g61b5TowVCC+6J014LOGjVkzdHmeUVfQCMK6TlSfZQ07tZR1KEdxg5DFFPQhbF1IWV+W+Nzv
Xm0pNpZZo1YPSDAcYe8utXrPsXf0ijf0sTFfYIaybDNmMXXgiTbZML7rHjBlS9Fhr+nUUsP6
xsqyMFaaI6wktuV6PA4nNuoWtTLVEB9OKOPcevkxEyd7+w/l0Om5XzLYgyyZX6qq6cZS/+Ra
wei1Ng1mojeLyvBQgNyjPhVTGxcW1264HU+UFQMXcupe6+QGdnxveqc8X30SohuX6dCKgxQk
eTSSyuifvqKvbSf2ojRjCs1Z7F6A2n9/eX35iC++dQGSxxXYKRnywAH62rnU6Y10dTYl7CSe
fZDVxvtUIUMvCRi8i5GOnKpU5O6YVzd8AQoC/v+j7Gq6W7d59H5+hZftolN9W545XciSbKuR
LF1RdpxufNJEzfVpvt7EOdPMrx+ClCyAgnLnXdwb6wFJUfwEQBDQN1NpYFQ2WmoXp+iTfj0E
lISFlul7IO/yKutEAlLUdmtcrlDxZmrYCyNx3OAFVFKMsK3KAhvn227l8hyn2rhXXRIYnPUT
57XQ1EwsSB0YaBXJ7eYI12UzMRUsa2T0T8oomzUYlDRpbpQwSrXM1a0O0UzMm65phWrbtVw2
JNCFmsUfDmFjd3LV3YJZSh7d/Ob8BxmZ214UU2Ps5f08i4fL7Qk3wONgfrAs1QPkVQcYMma/
aDRZruOoYgiGqTzG5U62TXlt6JCsvxpGSk77ijyN0LosVXsem8Z8r6I3DYwQIYWiqQCMaV/t
ceErkTPohr3Cpnr5sHNsa1ONGy0TlW0Hh/FHrOTIAAOWUQ7JCbieY49zlEOv0CF2qRsbzYYk
Eeb8KkcfZpS+6xJMzXmwTNRVJdlEHtr2F/nqEFxFLObj74fKLOPCCF05VJ4u8nABEYJrFAan
dJkI+rblLH68fX/nl/koNkaduleDDzQAvE6MVI3yg6Tes5U78X/NdPi7soY7yPftK/h0mIEF
WCyy2Z8f59kyv4IF6yiS2dPtZ28ndvv4/jL7s509t+19e//fsvItKWnTPr4qi6gniFZ8ev7r
pc8JX5c93T6cnh+mAroWSRyy9+4lMau0+eYnxfbc3B/wIyxM4reQIW4lXyA5W5uSNqVojMEh
0alLSmpVSraSQfocQbooYwAUahQkrJ2cWsOvY5d2JCBqq6KvUHD3BtWM1ePtWbb702z9+NF2
6+dMjD1qDJmjiuesLinKFePqlSZyRpV1SK3Wt/cP7fnX5OP28Re5tLdyWNy3s7f2Xx+nt1bv
eTpJzwuAvxE5vNpncLh0z1TcMdeNcYJRb42TNDVcuisyIVIQJFZTi328AZ/zqTG7e7T/VI5U
iGIiU1YcJiij+7z9kjwPrPE6LUF+AVcEWTO56ahAXZfppxqYsW1TE1i+ORobC0I2yqdM5E+L
jD0D7GhOYLAHya7ZHWjdRboX6XrMxa3LZlIRolLE02x1p46Tf+cx6zRXJwIp21gws0Rxz8Y2
2MBtwNxkSpVSNZFtD3wOWj0UfixWcouWEla8ier11GSSjJ38s1+PQijnU3uSHMOSsdxnyzqS
i6+ZLSuvo7rOSk7DpnKno4VOsg0ibfQGtcoOza6eqqw2J19dm311I7NMhcZN/1ANeHCM/XOn
Amg6vn1YmvXZCMnOyh+uzzrzxUk8EktHtRuElpX9ofw1j6dpVAqtAyVvjJqxvyGYAtX3z/fT
nZQB89tP4nsJ78ObG9weWx2R83iI02w/UXuQM477JVW+N9FmX5o3BGjfyknumralSGKbqC0t
ZB1NxCNsbiocSkg9Hpu4KhgMizsarBt7bttI+abhFXQjNoXQ8CZxhVARc8yy4X78IjxgIaH5
fG1/ibX/2dfH9p/27dekRU8z8T+n8913zo+ULhRi3FeZq6rim7ELUPv9uy8yaxg9ntu359tz
OytguxuNFl2bpDpGeQOcIOl9RdPegnr6jyo68T7CwMqt4CiuswZrgIsC9XN1XcN957TADjM7
ULMB6EYFHLPRu88yWz/PUCQ6HYzuh9IdZO7dGSFIJBs8wC7QEWJJxlKSFuR2+0CvzGxyVy03
9HtR6rxZFfRLNEEyQFEdCXzaQolKqThFbBb2BEmyIIXYxBwVDh62+NLLQFrBX+zDbiAVWb5M
pcSNBxJQozwu+X1TdVe2Ko6C216AevFoQ1uMGowBFC/nrHNhoO3lIBYJGVIK3oFrVlrybtQi
O/lxWSBHrpGyu26ntC8kQ/xtQ8V6ADfi20TlmlJssmU0Hi0FdVMwtPMh3U5oG1H/FhF/tXBI
EhUBe6etSAvRZDHRg/fYmKvtwkRIQetTnE93f3PREbu8u62IVqlsOLErLhwhzjo9Q8cVUcOm
4GWHS6Lf1cnK9uiGvBHyJWHtL3in7T2d62xQptEDC6WQUv5yOOzYHwgNp1JAW9bAxmyBP9xc
A0+wXVP1iw5ukjIn9io/8kWD4ShqbAfb2mp0K/c/fxGZsHADzx+h1w64EKafou6GYeuiAfVD
87NrywJXqx45igNKmtu+Y7m8gzuVQvkOsowCFeiMmlD7GWK7uKcHHn9T4EJfTBiqXxJY9hcJ
qjha+OytaUVWqlzjUyp34XlGMwKIr1J3oO8fDoN62aRhl7QDaPYbgAHTdFXoT1wQ6unzkLup
0lPDwOwk1Ra+OR47lGsKIAXuwUC18yawF20oa3qh+pODR3uRMmqQRLHteMKixlS6BtfcmZEi
1el6l3eyDRnxiRNajtnIjesvzJYvYtudYzf2Wm8dR4FvzY20TR77C2KCqYuIDvN5QP3X94Rw
sWDdevUTA/uWVeBVkzhyuBtoJlx7lbv2wuyHjqCNJY21SCnZ/nw8Pf/9k/2zYgbr9XLW2QR8
PN8Dlzo+t5r9NJwT/oxXd92wIDNNdoe4AY+ZZgvnh5rK7AqWgjMneOpy4Njlhh4G6h7IZKvt
utk2lRsEA9vyzaYS68K1PQu3U/N2engYL9rdqYUY1bk/zlD+lCZf3yUq5a6xKRtzZHXUoknM
0dVRNqnkmiWv1kzQGX+phB5Xu8mKR3GT7bOGs6ki6bp1gC+kP2uiPaAa9fR6Bq3c++ysW3YY
adv2/NcJhBBwUPzX6WH2E3TA+fbtoT3/zLe/Ul9ANPnJL41kN0ST9ayibcZpUUmibdpol1p8
CWDcZw7oS2OqcNAXmhY3smWWywbGlcrk/1vJRW45PjopouHMb4SZIg+i7HuSdi9eRGMHxhDB
XN92JyX0TicVO7NNc/pmKX2gb5KMVQ2aynWCzy+S62N0yCA19mQMV6chGfl0cICQSTTguNkq
Pxx1jg5QvgM3kP5YrAvU7wOB1AJqYCj9OxTXok/IHydJamqWCwAkx64FVsdK1/XS4PHjqX0+
owaPxM1WCg3GRyXgvEOgjxn65VhH6jC8L3K5W3EnvKrYVcar2XU28jr5fCzKfTr4qh7aQlNF
mq+gUhNh5nUiuRKZBwCdZsGoKlJn7g6dkpOrKjkyh0s0+K4MAFVS70HHndXfiN4NotFLfr8j
8UUfI3whBwC5w8SlcM2SlItUrUfn9WcyjVwWWC0lZK932HgToGIVYJPm/UpimdyjdkpXY1OK
kW5bqpS4jxQ+dYahiIVhCDJQ5dT+wgUckOnKrhEpTG05Lxv7pEIDGZ5A0TN8QbaK96gL9+pM
ISubfGmCNbjrppiZBOpAqqbQLauB1LS9KKko3MGynnzrKDLY84nOcgTODqL4ZrSRKU8G7y9/
nWebz9f27Zf97OGjfT9zbg9+lHR4/bpOb5YTxkqSk5YLAneCONay9Mixyips7gpOOOMcubCT
D3A+m5fl1a4aJwTfNVWEF0/NWBmFXLCO68cNDuhGJFzALpRPc8hhwBYK9xw8HFsc0eqr0CIX
GRBNZL5xP3oqlc/doqZpcPBQSvE8ttaSgm/NIEqcxOkcOw00aAuH/9ZYhY84Yu8z+H1OUQl8
nwjRLpeO2ZpWUV5EgiddF2yB+5iv4jKZ2yF1Toioq+yQJseiYJ3Jba4lU7/tPCzqve3x5e7v
mXj5eLvjFODAYhNeRCNVXS5TMsJFHauXIgUdKJbgyFROkCbwltjajH3rJWOU5cuS2K32ViTH
YrNjx1rPIsl8vBpLl6k030y76G0iwof3Ghqs2PQxefsMsYdmijirbiXbrAIOifGC9KOk9D2K
jVwRWacndCZlkRDNpi53a86NUbk69vtXv5K5C4vF4vj6gqv61u3Ty7l9fXu5446M6xTsQcFd
LMuCMJl1oa9P7w/j8VRXkonFH6kAYIF57bcmK7Zzrc4J64oTe3UytK32tSO1QMs8uB4Gv1aj
HUduZbOfxOf7uX2alc+z+Pvp9efZO8jnf8m+HLStOsDJ0+PLg4TBxRBuuj7QCUPW+WSB7f1k
tjFVu3R/e7m9v3t5msrH0rUd0aH6dXB89O3lLfs2VciPkmr58j+Lw1QBI5oifvu4fZRVm6w7
S8f9BYcgo846nB5Pz/+MyuwydZ6I9vGOHblc5osh8f9rFKDlqQALrFWdckxxemhipY5RlUv/
OUvRuzcfY9T3OvkxSmLlcHqywGNUZ3+UWyQxdfhKRHInt/As6yigT2CnWUeXPIDt+XNOVTak
cF3fH70TKd9GBFC+DWtQh3fb4dOoDlWz9e2JWNRdkroJF3M2blOXQBS+j/WOHdwf5KMtSi5u
Nbq8lmG5QD4cpXi1wlb4A3aMl1zSI5FhKd4pATgqnGqUWzj0qSn9SsXAAcmSwJ3yQ270XQ0J
Vf9cCTYP/Zj+rQJsli9JkL9xSCR6i2hu59T0Pmcfru/urn1s316e2jNZ/yMpltqBg4MT99AC
Q4fcxXFiO4Deie9Bcpd+WUQOdbQsEY89QlkWsRxoXVCVJw41i0YUUpMkcvDd8yRyjVCCRVQn
FhvMVFFwJDcA6K3eq4NIFux8uDrEv1/ZRhTqgeWJXYcNM1kU0dzDk7gD6Of2IPlSAAMakFBC
oeezR4MFHGfYhjfPDjUBtHQUKvi4T4DAwRUWceQa4T5FcyWloglXV5K2jMxFpd9u6VDVw/f5
Vm7dKqRaFzBQrtlyoTYHs/YJC2bzTYQH5txa2LVPEBurJuB5QQ6aJOIE3AgBwoJMF/nsGM+h
UZQ3nygqsAIjqUSOGbjvlEtyHeV5yt0kJumMSSjX/cB4Do+0wvPQMt46X3DCoCK4JGsYzsnz
wqH0BXW9BciCUxlFycILSFGZUp5GOApcdKgc6zDGwpBiMcSItWwKJtEClod1pdFh8udbB1Jy
29V2n+ZllcoB1KSxYRu4yULP5VyrbQ7Eo4U+faR1yZvY8eZkDVJQyAbrAQr2WK0B1FjAF1iO
Adg2iV2vkJAChjsxgNxgYrGKDouAjaRSxJXr0DAyAHkOP9eBtrB5hURROYGzmOiMbbSbh9jw
TbMo4w5V0oioiuyYGSUxSfY/TiJTsB70EsUDFmVinq2KppBjhnR4o4qxQpvBqDFAj3rCiMhr
pLAd2+XDm3d0K4Q4w5xZYpc/FBY+p+/gwBYBtjFWsCzJ9k1svqA+kDQaup43XS0RBhNB2bv3
qMPtiUoXkrU9jNq1yWPPpwO5uc49y7XkoJ3oXJkggARq7HB601VgW/RN+6yC8CvgSIPgnRRz
6Adhv2t9tUPhPUzFCp2lRiBQ4NrqVG6jOW+zOM7cCbyvj1IEMnbB0MU7wKaIPccndR1y6Tp8
b5+U1aton99fSFlNLmdctenug5KVXZHSP8qOxjJ0aYD5MP1sMnEKM6zj4liE7OKTRd867gXJ
emJusWbOULGszkAAWVdGkJRKsKzY/o9wQbwVj9pGO0E53XfATPZc5wMay898AsyjF6JrONE1
iFZ3iKrPdykUM/aiuuTSKkZDphgSbHZL/B3jgkm2xqgMTyOchkHruoVGdX6Z3eqBS9g1xB34
FnsCKgku9k8EzyF99hybPnuB8UwEGN9fOGAkgO8ldKgBuAZgkcAaEgkcr57wxwTUMDDTh8EX
yRcBbXKJzX3feA7pc2Abzx59nlv0G+YGw+rSUHtyxQgtNhp8VUJ0O8xUCY94hZOsiW3IH8Ct
BKaNeL/hB47LWpxJdsOnMd0ACSd2RMlTeHOH26SBsnDMDVZ+ghU6YEXF7zSS7vvY+63G5q49
xgLs1EbvG7qFhlPgr0a/vgcul4T7j6enPp4zXjlGtC6Ub/uvj/b57nMmPp/P39v30/+CUVKS
iC5EOjo7UIru2/PL26/JCUKq//kBx9F03i18x2U3mi+L0Pflvt++t7/kMll7P8tfXl5nP8kq
QBj4vorvqIr0tSvPnVAlKdqcv5nx775xiMb5ZaORperh8+3l/e7ltZWv7jdBVDlQiVght2No
mu0aEpUGealP6Vfo8naohecbapK1PeGTbHWIhCO5fdadalHtXAt7uusAdmFf39Tl0ZVyl7mN
dCTwS/AFGQzSevLAyjRrKR/wsv10a+tttb19PH9HbEiPvp1ntb6l8Xw6Uw5llXoedn2nAc9Y
SlzLZnVOHYl4V2Pfh4i4irqCH0+n+9P5kx06hePa3LKTbBqqlNoAD29xsvKmEQ7e7fQz7dAO
M/ioTbObWEJFJpkmVsyRhE5h13+y+Xl6DZMrxBmMJJ/a2/ePt/aplZzph2yukXbRs8hQV1DA
TBdvztWno1E+MrOD0bPJVyqMcCyrQynCOVVT9dhUDOCeTAq6Kg54C862e5hlgZplNJYaIbFv
wCk4/ioXRZCIwxTOTuue9kV5x8wlm9YX3YkLgN6goXQwOqjntS2pimP6PhIqkt+ToyB7a5Ts
QKNBB0UOM5MbEbkLTlVR7ioRCxKPUSHEw+VyYxP/n/CMx1RcuI6NfW0DQCV1ibjmrjmQAnY2
ASHAytV15UQViTShEflBlkVc/WXfpGBuQ6hJfgL3/LrInYVl80I2TeRwgrYi2dj44ncR0QBw
dVVbvkPdv3cFj28xXLjA2senCvledqYXo41ELr1yoTZ0VoAgvn1bRjZxEF1WjexoVG4l66ou
ZWCHn5ltkyAR8tnD2urmynWJk9vmuNtnwvEZyHANfIGNlbaJhevZE5oQoM1Z959dMzayE/yA
MOUKCrmmBcocn8ZIwPOxk9yd8O3QQffr9vE2p22tEewBeJ8WSkliItieZ58HNp41f8j+cByL
OH2is16bjd0+PLdnrdFn1oOrzrnsMPUB8Xk+8cpaLPgIz/o4qIjW6NYhAk0Hu5g0FcBCEuU6
NXFHz/Udj6xY3QqrSlRs0Rc9viliP/Rcbk51pCl3+UYq6pa6I9aFS7TBFDeGNKX147o34+O6
TnfqcK13pMoqdgeW/yN5Ojbi7vH0PBoaaF9i6CpBf0th9svs/Xz7fC8lreeWqks2tbaOGg5D
EVH5fql3VcOTG7hLkJdlxZPFjVgJRLpUmK9Wtx8+S9ZSCoX38t/Dx6P8/fryfgLRajwr1PLv
HatS0Mn14yKIXPP6cpY7+Wk4+MWaCYddlBIh5zg+/pOSuIej8SgA75UawOcRUgy3bHIKBpDt
Tsvzvjtx2ODZFj1/barcMjTdIwHD+Gy2SWT3YGY1L6qF3R9iThSns2gx+K19B0aJWc+WlRVY
xRqvQpVDGVh4NhlWhdFz7HwjF2DicympJOfEi4WbitWCZnEFLUgkwtzG6n39bJw2a4weNle5
SzMKP8BsnH42CtIYLUhi2Hl7t3Aa/n8xyrK5mmJuxL7HNsOmcqwAlfFHFUn+LhgB9E09aKyK
o84f+N1ncNM0HhPCXbj+b+Y2SRJ3w+rln9MTSFswx+9PsIbcMYNMsW2Uw8qSqAYHgOlxjyfr
0nbw5K2IxXm9SuZzj0TaqFfEY/xhQVmlg3yrRZMj7SSwFa7lEJbBd3PrcNl9Ly345Xd2hpDv
L49wY++H5/6OWBAZ0xG2Q2fyD8rSO0r79ApqLzqrKUNuReDnpeBijYPicxGSLV0ujFlxVD5y
yrjc8R6hivywsAJsaq0R3GtNIYWGwHhGM6iR+xEeDOrZSYy6uHZIA4sNuxbz6RcmvMEXyJul
nL7ILBeALGloCu0vo8E3TwCGsVeVePwB2pRlbqRL69XolSPHOyov3IUDg2D+YkORHpesd1gw
8UYOPAq9n1PIuGQGEFzmWjVG1m5cUFBdlUabKGDqznDoGy+Gw2NiWi3B5pqz+ugocN3ut+6k
Ba793H0/vTIuRetvYOuNS45k5TNWZwgxfCPIgo11R2Vfiq7ABxhxAKoPSpsqzhzKd4JvLJmh
jEmEK7lwpw3YujV1mefYBk5TlnVcCNm9+kiU2Ccrur5At77mTI9VAgjL09+61evq5mYmPv58
VzakQyv1AXC1C6IxeCyyKpObLiYv4+J4VW4j5X2J5oQcnSMSOazrGi5pskRVIj7ERDSRSb6U
s6YkiaIc+zYGEgzOrDiExTfqXlV/xiHN0ccYr64O0dEJt4XyCsVOJZIKPnyqfnKQV53PCZK5
iKpqU27TY5EUQcAqYyFZGad5CaeKdULjsANR2Who51X/V9mRbDeO4+7zFXl1mkN1v+yVHHKg
JMpWW1u02HEueq7EXfHryvKyTHfN1w8AauECumoO3SkDEHeCAInF87lGoYeDQ1QfE5sab2Ia
AB0dHxnnhbletGZgQLXQF6gkNEJPqYW3fcXognS6ParrZM5dah/ZuLSFHZz21KlOPN2/Pu+M
+H8ij6rCDqA82hUo8lHiNMOTo5sUgDjrHOCtGh+knyMTnVi0AqNVTR2JjB20Ct2u6rKT6NTg
BhGbrw7eXzd3JCi54anqhnM/UOxBzzoyQPo4sNr9bA+fNZwbx4iGpaOJn2NhDV8YE0dxuEt3
ezOUiml4NRlG+c+UVTfE7zSuRi0k+ePwb0WY3DebVeM3tect2iYMl5rH1YgcswknDDIJ5al9
5T7gMN33TXHMYIMqiWbS6XlcSXkrJ6ztRlCix72SqTjbEyq6krNET3JQxDycgFGcupAuziQP
xV7pzTJwqtW+Zg1UvmZ0Im4ZqBHCOK7NH0OY7C7HsGjaFkRcH6Xe626g0fCRqzUCO3QXomor
hwrBAomm8py0gQkgYNpuJvN0PUQc4zmC4edENPtyecw7sPb4+uiUtSVDtBmYHCHkHKffdDFt
GOWYpNDTrsEvFH+sQus0yQI9qwsC1IkUNlVqc4oK/p3LkPN+CzExhX7jBDJnd92KyEiumA1h
cofLCtOFRdkN7L6DQE+HmKYwLQUqi6AoxjVaGde6AIagok5gQMNU99hAIVuXkAdIF6D3Ylfo
6QDQJx/dLxeoa07OHXAQoeHk2oOP0fs4rNYlJZYxlnC3BIGMjc8R14wzvwKx/JwwFGVFq1iM
ZfSQ67ZojIgNBECna3J6o+lD22tOCsGg0j39SlS50UUFthSL6zhruuWRUR2BOBmLSggbbWow
Xnxcn3b65CiYAYpbzJZknM6hk+NgWB/K+50N7lvAVKQCpU19QU9QzBeTVLCuO/iz9/uJUqQr
sYbmgi5QGKFRNeIkjyTvSqoR3cAEU+d/RphJGMWidD3cw83dgxlfOwYVJJzzZpk9tRL03rYf
988Hf8KOczYcumtag0+gBR7e7CIC5DLrQ3iY3yhw7wDURS17F0GUqAHpK4WApZhJTCKQoAmz
iQJ9MY1AZ5nAC1nl+iKytGRQXc1OEWDiH/xrGNHciKbxZGhqZ7DNAnbxgTQZ92nENG/nMcXE
LJmJvElUJ3XXbvwz7IdJ5HYnTDtSklrFFoEuNzLjGgPcYFVUC51KE4it7Ye/l8fW7xNDViaI
PWw60ngjU5COv1CnpAl5zL8c45fIDFSMB+CWbOd6IlwBINQCkdn2KKlFAFy8jUrNJ1uvgwvr
M6vIsQWYeaHHeYKTwP6JvTUqtEPJgS5XlaH9u5vVBl/qof7A5qEs5zyjCxOTxeFviuxWc3yZ
sAL5F3CqWoZtNQywwXGRaiUFxhjAFcunwCKqtsRUfH68s4F05HDCmJ8QlDfMnPDEUTo72Z9F
+JP2FZHoPItP0L5gUZclPxG5HooJfgwu+Fefdm/PFxdnl78dfdJWXlpTFmric6cnnO+sQWJk
kTUxX87MekfMhW5JYmGOvZgzL8bXAhWnkO/axTn3XmaReBtzfuLFmFzGxPFv8hYRZ/RokVx6
ar88OfdhvEN+eXLsmabLU189F19O7YFN6gLXUscpEMa3R8dnh54KAXVklyvqMOGNC/RaeTau
U/D7VqfgTZN0Cs7UXsdbK3QAn5vdHcBfeOpLnloPymrAnfU2YvyrbVEkFx3H/UZka88DRjqr
ioxNJzngQwmaaWi2U8FB4G/NxG0jripEkwg+uPFItK6SNPVcrQ5EMyEtEpugknLhtg7EwBRU
KwaRt0njgmkUVHowpw1NWy2SmrsKQ4q2iY03/Sjlr/TaPAl90dcNjVT5vGzvPl7xJXAK8TaK
n2uN9eMv0BmuW0yzQDK5IRurFF8wU0iIcbW4s6TBpH0yskru1U4HDr+6aA66rVTZTnVJGI94
UEkxAFtNrw5NlYSGDDSQsEY8CqVLiBR+ai6qSObQkJaitJVrkilCoYT1SUa2yTjNGEQy1HXr
oq1CY6hQiKHkD/gsGcm5TEtPkpAkE10vzMAK64pqHMAAJEzOdqSPjjMNj9D2U1pnV5/QweD+
+e+nzz82j5vP35839y+7p89vmz+3UM7u/vPu6X37DdfD568vf35SS2SxfX3afj942Lzeb+nN
3FkqsxCk/rSdJTnmnG5B7wEp68oI2H2we9qhievuvxvbISIBdQiHJVx0eZHzSjFbgy9eK08c
rCtp5GrdQ9b5pCv+myU6K3rUeeodBijBpeSJU2qR4u2rRqmrTZ7BHND+qRpd0ez9PoquuAmL
MRDW64+X9+eDO0yH9fx68LD9/kKeMgYx9GlmRIkywMcuXIqIBbqk9SJMyrl+T2Qh3E9QomeB
LmmlXwtNMJZwFHidhntbInyNX5SlSw1AtwRQuBhSODrEjCm3h7sf0FXbI089apEUc9P5dBYf
HV9kbeog8jblgW71Jf11GkB/mJXQNnM4DAzNSWHsOGXqyufj6/fd3W9/bX8c3NFq/fa6eXn4
4SzSqhZOVZG7UmQYMrBo7rRehlXEFAksdymPz86OLod7dfHx/oCGa3eb9+39gXyiVqKt4N+7
94cD8fb2fLcjVLR53zjNDsPMqXoWZszohHM4jsXxYVmkazTY5vTSYa/Nkhqm1d1V8jpZMt2f
C+BJy6FDAbmnYS60N7e5gTt8YRy4sMZdvmFTM6PsfptWK6b7Rcw9mowrMOAW1E3DXjr0G1Ku
V5UonSbl82GEHZTAuJ1N684YRl9eDkx1vnl78A1fJtzxm3PAG26klyrq8WBpuX17d2uowpNj
biwI4R+NmxuWsQapWMhjd44U3J1PqKU5OoyS2GU0bPneoc6iU5f/RWcuLIHVS2YXoVNGlUXc
LkCw7rYygY/PzjnwiZ4BathKc3HEAbEIBnx2xBx+c3HiVFdnDKwBSSEo3MOsmVVWSJ0esSrP
zLBA6rTfvTwYRn0jv6iZBQPQjs0RP+DzNjC9EgdEFXJK8LhyihXFlLV7OSCGW0hnaYlMgn7H
sGSBuorvo7o5Y9qIcO4OZTg4JNexmP7y13E9T5mLW8Fdyg4zKdJaMKtp4O3u1BvvwCOwKlVo
erv+Otsz8o0UzCfNqogtbVQtlufHF7TA3enxEcbhiVPRSKdh6W3hdO3ilFug6e2ehgJy7u7m
27oZTfKqzdP98+NB/vH4dfs6eFJzLcUo/l1YcpJgVAWzIfAzg5lbkdwNnGDVd52EOwAR4QD/
SDDQv0QrvXLtYFGy60O02i0ZUHvuuC3CQaj2N30kVQPmLQml+T2rHC/wWRkdExLYysf33dfX
DSg7r88f77sn5tBEp0ch3QIJDrzGXYboJakOqDFrKffxcIhxOLUjtaSnzgoeifYsZKQZBca9
bdHkSg6tGJILH85PEH+TWznlC+ZInASuDNHejv6K7InU4zFoFzXnjElFvc4yiTc7dBeEYeu1
Z8cJWbZB2tPUbeAla8qMp7k5O7zsQokXNkmIhhm2VUa5COsLtC1YIhbL6CkMv5hMw3CPwlDI
F2ArdY2X1WMVasGj+++fpCi8UYact923J2UPfvewvfsLNPlp8avXTv0yrTLMHFx8ffXpk4WV
Nw2amU2ddr53KDpaSKeHl+cjpYR/RKJaM42Z7rtUcbClMEVMPV4Q8k/6vzAQQ+1BkmPVZPIR
X41ezz6ekSa5FFVXYbY03dZcWIYwQQJCFaYq0IZksEnOZdO1TaI/iQ2oOMkj+F8FHQz0e9+w
qCJ9Z0NzMwnqchZIPQmkuuIUumUJvqvjI3CYlTfhXL3Mqhusce+EoCXCKWGAjs5NClfqDruk
aTvzq5Nj6+eYjcPcrYSB3SaDNfdWYxCcMp+KagVLyXMoIQUMng/LBisKLT4f6gmykmDUeiYC
zWHG1m1gcURFZna+R4G0gqKk5SWFUDSEtOG3yO3gSEuNnXWrGLYlIilonDb6BQQITFN1BlSr
ToODXMQ0D+AsPUpMDDmBue7c3CJYn04F6W4uztnZ6tFkr13yDy89SWJl4bHxouJfOSZ0M4fN
xKyMnqIGVqsNbA8Nwj8cmDnh0zh0s9ukZBGGWGvAT10Oob8lDBWLqhJrZZOpn1l1ESbAEJay
IwL9maI28/jkEjPBq/Q9qcxnutk14ShtkShJ9LKtdhAnoqjqmu781OBao1FPXFRo5wSEbT4+
1GhnxUolVjGT+eBtBjtpVCF6QdgWIUNxs1QN01SDivuvXkm0bVy2oH8LfVauNd45S4vA/DXt
aO3ZFI04tDLT264R2ndJdY3ij1ZuViYYfmOqNMmM30USkV0x6OXapMVF3oxmOo8G9OIfnV0T
CA3ooLEytKeDXkhWQk+DQqBIlkWjw/B01fureT1ah6P5vDPIGQR9ed09vf+l/AMft2/Mow8d
vAtKgaHPfw9G+xReoSjyuiAL1FkK52w63q9/8VJct4lsrk7HWehlKKeEU22lrXORJYztEYe3
snWByBgUKFHKqgIqPY8XUcN//YPPlfYy4x2wUWnefd/+9r577EWZNyK9U/BXd3hVXb1a5MDQ
fLMNaStq/iIjduBEMuL34URZl6nnxNWIopWoYp5NzyLYW2GVlJ60XTKnN4asxauYuWRD+McV
jDLZ614dH55e6Cu5BG6Iri2ZcRFVgZZJxQKSN2OU6FSHdquwRVLOpk/1DiRYlLvQ4DATRpJx
G0PN64o8XdvToViksivTUh0OEu2vTvy/9Iwq/Z6Mtl8/vn3Dd7zk6e399ePRTO2WiVlChqbk
OugCxzdENQlXh/8caTaWGp3yFPSOkmHcPJwMbVCLHAS6PGlAL0C2PRERTp8wRQwKBWcuq5AB
ZiGp3Y/QFpS3c3AasIdMpMksz2TOPZsjm+ybrDHLX5oKc5yUuaa9PrADV+Zb+FiYxk2Ro4HO
hVFTdUtLVQZih4PR2qAjathq/aRzKijWUaxyaZgzELQskrrI+WRfUz2d9YKuMFURiUb4kgkp
miL4Q4b63Y8BZuRtE48v4m7FA5bijHiyBhqEaDH8C2RV2BIH+QVS2PEoi/Q+Iz/rvjVFV9p2
rNM2GIh5cyaioBs0phqyX+lXYSaz3v7CXJ0/gaN9N6yDIlWK/tH54eGhh9J2BrfQo+lCHO8Z
wpEcJR5MYsB3u2fUZB7S4rnPDw6cLVFPJUET9x01I/tSxS6hx7OGmKM1KsvMXW9AjQ9ttkOC
TVMFbmFQDah9M2cDGA2wqlP5WMgqZM/I9GcOCvnehUG9XgjFlHkE9syUvMOQBkphpxvKsXpC
MDWqD2gqaIGblisT67NO4rlygFdPmEh0UDy/vH0+wMijHy/q0Jxvnr4Z7iElptNFk5miYHtv
4NHzqoVT0EQi8yjaBsDawGICgm6ODsuNqHmWsboGkQAEg6jgbdvpVME7m9ZyVx4dxvb1Udnm
gbxw/4FCAnNgqBXv2JoT2OESk/kPU6Q5ETgeCylLdSmmLtXw2X86AP/99rJ7QlMAaPnjx/v2
ny38Y/t+9/vvv+tZk9ExjYqckT4yuimMegImg5380HQ/myUmoV2pInIYR/5cIjR21d5UVQPy
ZiNvpLPdtHx/5lbjyVcrhQHeW6xKoSvXfU2r2nA8UVBqmLWbyK9Clu4u7xFehiKaAhWVOpWy
5CrCwaU3nCF7rl4FtaSBcUcjQs8BPXWSUxn/j6kf5SnyM4HtbHE8YgmEnGAkVcNQdW2OL5qw
otUdnDtOC3WGOs+Rah/9paS0+8375gDFszu8MzZYRT9iSb2Xmf4EX/N7XSHJjzHxSSLqZO9I
VAJ9E2OfJfZJb7AGT5fsWkPQBEGuTaxQleo1NGxZWVPtsFB74NTXiHYfCoIQhoNhwMYHjzoG
DyPSukbWeqzJOfRtxXtvIk5e6w40Q/wgox/WHr3uNbDKSTOPLZkXDdprqvuvIegJO0F4K5uH
66bg9mJOoeig2ZV1gsZtrhTF/dgZqD5znma4ioitrcEgu1XSzPGGybZc7tEZyaFAgK8OFgn6
I9KkICWI+3njFIJvzWsLiB1XxWqLhSoLTUZKt052hji5RJNwpDfeWHAaQNfpIxU5w6IV1Xt1
1Sv9rq8EbSCD7QOaK9sbp74ewPnKxc5inI5SkZWp5MQKTYqkGBtJ730mx7zpbyeXh9zWM3kj
1yBKS1o2HtdSKaq0f/Na6DvEqk+/2Gu2b+/Iu1G4CJ//s33dfNvqjHHR+gTMgaHhRVhRgSD6
h7oUYYmVyM/S2KO2CAvd2FDJmSA0ArgfoNKUNAHBsQtYlPiY1igJwcnVnS6ihr8eUrIZPkbW
vuhVRJIlOSWc91N4vw+Gs46OVefsnfhhgDZce/B0wV+kBWY09lKRTzyIt93+wnpt1SMIKEnj
/JR9+qPezuWNvS6t4VCXz+q6nnUB6anqsFw7xS8A0XhSFhOBeuv1FRskjXoSMD8CMCzilNfm
1d1Pawfo0bHqkcaPR8f2GDa/n6LCV0ZS8vw0XlsdwiYR/6CiFvJizyqH3luqkYnv1b49g4Om
PR4vF1VDqYWLUxB8658XdNGxNEKT4CM5tKgL4KSdZ8JzG0OFxEmVgXS4Z8iUh/2elkcy3Tdx
vSeO19tWsQCZhQJWnn8tkwFB4m4W+NJW3Xs0YMbtZTpu8Lza8e5QLzX/Aw51RpcSKgIA

--PNTmBPCT7hxwcZjr--

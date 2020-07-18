Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED80C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA662073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgGRUlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:41:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:23273 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgGRUlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:41:06 -0400
IronPort-SDR: lFN7zbxQnSpEPqIO7blqILJ9E8FRmpbzT/KScbakza7+Xrs6FXuIWWN1PHELtXvHrFGsk0H46p
 oL7wH2Zu7gnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="147732703"
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="147732703"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 12:57:04 -0700
IronPort-SDR: P4fJqGU7V0nAZaDi66073SPtmkastNH0G8VLZkRS/k6JmR1etLR98rlfA2y0SxJmiZ63TuIC1o
 9LIk+n2DzyHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="361652641"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2020 12:57:02 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwsxB-0000tx-E7; Sat, 18 Jul 2020 19:57:01 +0000
Date:   Sun, 19 Jul 2020 03:56:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/video/fbdev/tdfxfb.c:1120:27: sparse: expected void
Message-ID: <202007190302.vhfc5bin%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6cf7ccba29dcf39ab27630c383a3844078a6d5cd
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   8 months ago
config: s390-randconfig-s031-20200719 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] <asn:2> *cursorbase @@
>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *p
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] <asn:2> *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '<asn:2>' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '<asn:2>' of expression
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@

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

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--xHFwDpU9dbj6ez1V--

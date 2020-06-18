Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C98C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A994220897
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFRFj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:39:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:45735 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRFj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:39:29 -0400
IronPort-SDR: f/EK/D7Z29mLiwfQguWJhr3uMc/VQxb5sTSyAjOyEXORZ1ozSH6RujSF7vBP7pf3HD9XupYn8u
 0ThsDWt/Foeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="130862330"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="gz'50?scan'50,208,50";a="130862330"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 22:30:16 -0700
IronPort-SDR: RJAU9dIfyDW4H7gDOEqyopbVALQziEJ2TIO2CkHmk3Gh8Dv1arURRYzYiL/OITB/E459VzNdSg
 zhIjUHPBkFJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="gz'50?scan'50,208,50";a="317733277"
Received: from lkp-server02.sh.intel.com (HELO 5ce11009e457) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 22:30:14 -0700
Received: from kbuild by 5ce11009e457 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jln7u-000056-7Y; Thu, 18 Jun 2020 05:30:14 +0000
Date:   Thu, 18 Jun 2020 13:29:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202006181308.DiBABb6W%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b5044021070efa3259f3e9548dc35d1eb6aa844
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   7 months ago
config: s390-randconfig-s032-20200618 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc1-10-gc17b1b06-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=s390 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned char [noderef] [usertype] <asn:2> *cursorbase @@
>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *s
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
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] <asn:2> *screen_base @@
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *s
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] <asn:2> *screen_base

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

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vkogqOf2sHV7VnPd--

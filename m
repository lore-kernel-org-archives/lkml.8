Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E39C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EFB2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 20:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGRUjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:39:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:30145 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGRUjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 16:39:24 -0400
IronPort-SDR: 0pmuQedyNFFg5PHjUguWL9mBrBkBGjmqZEQ5IselZ3EGTjJ/lBJLWEduLPIe8PVkDf3fTr8v6q
 ulHrlUimhc5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="148924204"
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="148924204"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 13:39:21 -0700
IronPort-SDR: NLdjFQOQwO8xcePfWZW7n6C8G0ToXyXvZhtR56YGQirnFeLrix8R/SC+jYZxp7ED8JSDgnU0cS
 L57WfA7Ub41A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="gz'50?scan'50,208,50";a="300904862"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2020 13:39:19 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwtc7-0000ud-7m; Sat, 18 Jul 2020 20:39:19 +0000
Date:   Sun, 19 Jul 2020 04:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/video/fbdev/kyro/fbdev.c:725:9: sparse: expected void certs
 drivers fs samples scripts tools
Message-ID: <202007190447.4iKpN9a9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6cf7ccba29dcf39ab27630c383a3844078a6d5cd
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   8 months ago
config: s390-randconfig-s032-20200719 (attached as .config)
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

   drivers/video/fbdev/kyro/fbdev.c:725:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] <asn:2> *screen_base @@
>> drivers/video/fbdev/kyro/fbdev.c:725:9: sparse:     expected void *s
   drivers/video/fbdev/kyro/fbdev.c:725:9: sparse:     got char [noderef] <asn:2> *screen_base
--
   drivers/video/fbdev/tdfxfb.c:1120:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned char [noderef] [usertype] <asn:2> *cursorbase @@
>> drivers/video/fbdev/tdfxfb.c:1120:17: sparse:     expected void *s
   drivers/video/fbdev/tdfxfb.c:1120:17: sparse:     got unsigned char [noderef] [usertype] <asn:2> *cursorbase
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

vim +725 drivers/video/fbdev/kyro/fbdev.c

^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  661  
48c68c4f1b5424 drivers/video/kyro/fbdev.c       Greg Kroah-Hartman 2012-12-21  662  static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  663  {
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  664  	struct fb_info *info;
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  665  	struct kyrofb_info *currentpar;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  666  	unsigned long size;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  667  	int err;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  668  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  669  	if ((err = pci_enable_device(pdev))) {
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  670  		printk(KERN_WARNING "kyrofb: Can't enable pdev: %d\n", err);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  671  		return err;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  672  	}
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  673  
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  674  	info = framebuffer_alloc(sizeof(struct kyrofb_info), &pdev->dev);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  675  	if (!info)
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  676  		return -ENOMEM;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  677  
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  678  	currentpar = info->par;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  679  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  680  	kyro_fix.smem_start = pci_resource_start(pdev, 0);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  681  	kyro_fix.smem_len   = pci_resource_len(pdev, 0);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  682  	kyro_fix.mmio_start = pci_resource_start(pdev, 1);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  683  	kyro_fix.mmio_len   = pci_resource_len(pdev, 1);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  684  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  685  	currentpar->regbase = deviceInfo.pSTGReg =
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  686  		ioremap_nocache(kyro_fix.mmio_start, kyro_fix.mmio_len);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  687  	if (!currentpar->regbase)
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  688  		goto out_free_fb;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  689  
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  690  	info->screen_base = pci_ioremap_wc_bar(pdev, 0);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  691  	if (!info->screen_base)
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  692  		goto out_unmap_regs;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  693  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  694  	if (!nomtrr)
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  695  		currentpar->wc_cookie = arch_phys_wc_add(kyro_fix.smem_start,
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  696  							 kyro_fix.smem_len);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  697  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  698  	kyro_fix.ypanstep	= nopan ? 0 : 1;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  699  	kyro_fix.ywrapstep	= nowrap ? 0 : 1;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  700  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  701  	info->fbops		= &kyrofb_ops;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  702  	info->fix		= kyro_fix;
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  703  	info->pseudo_palette	= currentpar->palette;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  704  	info->flags		= FBINFO_DEFAULT;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  705  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  706  	SetCoreClockPLL(deviceInfo.pSTGReg, pdev);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  707  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  708  	deviceInfo.ulNextFreeVidMem = 0;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  709  	deviceInfo.ulOverlayOffset = 0;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  710  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  711  	/* This should give a reasonable default video mode */
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  712  	if (!fb_find_mode(&info->var, info, mode_option, kyro_modedb,
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  713  			  NUM_TOTAL_MODES, &kyro_modedb[VMODE_1024_768_75], 32))
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  714  		info->var = kyro_var;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  715  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  716  	fb_alloc_cmap(&info->cmap, 256, 0);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  717  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  718  	kyrofb_set_par(info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  719  	kyrofb_check_var(&info->var, info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  720  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  721  	size = get_line_length(info->var.xres_virtual,
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  722  			       info->var.bits_per_pixel);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  723  	size *= info->var.yres_virtual;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  724  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16 @725  	fb_memset(info->screen_base, 0, size);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  726  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  727  	if (register_framebuffer(info) < 0)
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  728  		goto out_unmap;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  729  
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  730  	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  731  		info->fix.id,
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  732  		info->var.xres, info->var.yres, info->var.bits_per_pixel,
31b6780c15a4e3 drivers/video/kyro/fbdev.c       Joe Perches        2013-09-19  733  		size >> 10, (unsigned long)info->fix.smem_len >> 10);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  734  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  735  	pci_set_drvdata(pdev, info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  736  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  737  	return 0;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  738  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  739  out_unmap:
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  740  	iounmap(info->screen_base);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  741  out_unmap_regs:
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  742  	iounmap(currentpar->regbase);
9e517ac88b2443 drivers/video/fbdev/kyro/fbdev.c Luis R. Rodriguez  2015-08-24  743  out_free_fb:
a26968df0110bc drivers/video/kyro/fbdev.c       Antonino A. Daplas 2006-01-09  744  	framebuffer_release(info);
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  745  
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  746  	return -EINVAL;
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  747  }
^1da177e4c3f41 drivers/video/kyro/fbdev.c       Linus Torvalds     2005-04-16  748  

:::::: The code at line 725 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OpABAA==

--4Ckj6UjgE2iN1+kY--

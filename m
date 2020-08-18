Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531ECC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BEB206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRJ71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:59:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:49333 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRJ7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:59:24 -0400
IronPort-SDR: rhXbL4UPonfBnwg/Yvq2hm02HaEGaPpBlVl3DD3Px91yXas9bBlN++5xNArYki5xalj2MlReFw
 NhWbexS49RLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142700477"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="gz'50?scan'50,208,50";a="142700477"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 02:59:09 -0700
IronPort-SDR: NJNHj3johVAGKAbAe5z6oQIp8A6RBFm88kOZR1iwmzUyCkgdfEwd2Jz8y6eQRFWeIlMAitnlq5
 RDH7v/T1IGBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="gz'50?scan'50,208,50";a="296790824"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2020 02:59:07 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7yOY-00017b-Rm; Tue, 18 Aug 2020 09:59:06 +0000
Date:   Tue, 18 Aug 2020 17:58:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202008181742.aus2S0ud%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: m68k-randconfig-s032-20200818 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/qxl/qxl_kms.c:36:5: sparse: sparse: symbol 'qxl_log_level' was not declared. Should it be static?
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_rom *rom @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse:     expected struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_ram_header *ram_header @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse:     expected struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_ram_header *ram_header @@
>> drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse:     got struct qxl_ram_header *ram_header
>> drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse:     got struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse:     got struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse:     got struct qxl_rom *rom

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +277 drivers/gpu/drm/qxl/qxl_kms.c

f64122c1f6ade3 Dave Airlie             2013-02-25  109  
2b65d5677a797f Gabriel Krisman Bertazi 2017-01-19  110  int qxl_device_init(struct qxl_device *qdev,
aa5b62bac05d4b Gabriel Krisman Bertazi 2017-02-27  111  		    struct pci_dev *pdev)
f64122c1f6ade3 Dave Airlie             2013-02-25  112  {
35541782dcc1e5 Gerd Hoffmann           2013-10-11  113  	int r, sb;
f64122c1f6ade3 Dave Airlie             2013-02-25  114  
cbdded7f8a633e Gabriel Krisman Bertazi 2017-01-26  115  	qdev->ddev.pdev = pdev;
cbdded7f8a633e Gabriel Krisman Bertazi 2017-01-26  116  	pci_set_drvdata(pdev, &qdev->ddev);
cbdded7f8a633e Gabriel Krisman Bertazi 2017-01-26  117  
f64122c1f6ade3 Dave Airlie             2013-02-25  118  	mutex_init(&qdev->gem.mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  119  	mutex_init(&qdev->update_area_mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  120  	mutex_init(&qdev->release_mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  121  	mutex_init(&qdev->surf_evict_mutex);
b3740e88601d69 Christophe Fergeau      2016-11-08  122  	qxl_gem_init(qdev);
f64122c1f6ade3 Dave Airlie             2013-02-25  123  
f64122c1f6ade3 Dave Airlie             2013-02-25  124  	qdev->rom_base = pci_resource_start(pdev, 2);
f64122c1f6ade3 Dave Airlie             2013-02-25  125  	qdev->rom_size = pci_resource_len(pdev, 2);
f64122c1f6ade3 Dave Airlie             2013-02-25  126  	qdev->vram_base = pci_resource_start(pdev, 0);
f64122c1f6ade3 Dave Airlie             2013-02-25  127  	qdev->io_base = pci_resource_start(pdev, 3);
f64122c1f6ade3 Dave Airlie             2013-02-25  128  
f64122c1f6ade3 Dave Airlie             2013-02-25  129  	qdev->vram_mapping = io_mapping_create_wc(qdev->vram_base, pci_resource_len(pdev, 0));
5043348a4969ae Anton Vasilyev          2018-07-27  130  	if (!qdev->vram_mapping) {
5043348a4969ae Anton Vasilyev          2018-07-27  131  		pr_err("Unable to create vram_mapping");
a9b0b24a6fff2d Daniel Vetter           2020-04-15  132  		return -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  133  	}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  134  
35541782dcc1e5 Gerd Hoffmann           2013-10-11  135  	if (pci_resource_len(pdev, 4) > 0) {
35541782dcc1e5 Gerd Hoffmann           2013-10-11  136  		/* 64bit surface bar present */
35541782dcc1e5 Gerd Hoffmann           2013-10-11  137  		sb = 4;
35541782dcc1e5 Gerd Hoffmann           2013-10-11  138  		qdev->surfaceram_base = pci_resource_start(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  139  		qdev->surfaceram_size = pci_resource_len(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  140  		qdev->surface_mapping =
35541782dcc1e5 Gerd Hoffmann           2013-10-11  141  			io_mapping_create_wc(qdev->surfaceram_base,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  142  					     qdev->surfaceram_size);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  143  	}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  144  	if (qdev->surface_mapping == NULL) {
35541782dcc1e5 Gerd Hoffmann           2013-10-11  145  		/* 64bit surface bar not present (or mapping failed) */
35541782dcc1e5 Gerd Hoffmann           2013-10-11  146  		sb = 1;
35541782dcc1e5 Gerd Hoffmann           2013-10-11  147  		qdev->surfaceram_base = pci_resource_start(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  148  		qdev->surfaceram_size = pci_resource_len(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  149  		qdev->surface_mapping =
35541782dcc1e5 Gerd Hoffmann           2013-10-11  150  			io_mapping_create_wc(qdev->surfaceram_base,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  151  					     qdev->surfaceram_size);
5043348a4969ae Anton Vasilyev          2018-07-27  152  		if (!qdev->surface_mapping) {
5043348a4969ae Anton Vasilyev          2018-07-27  153  			pr_err("Unable to create surface_mapping");
5043348a4969ae Anton Vasilyev          2018-07-27  154  			r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  155  			goto vram_mapping_free;
5043348a4969ae Anton Vasilyev          2018-07-27  156  		}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  157  	}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  158  
35541782dcc1e5 Gerd Hoffmann           2013-10-11  159  	DRM_DEBUG_KMS("qxl: vram %llx-%llx(%dM %dk), surface %llx-%llx(%dM %dk, %s)\n",
970fa986fadb11 Dave Airlie             2013-05-31  160  		 (unsigned long long)qdev->vram_base,
970fa986fadb11 Dave Airlie             2013-05-31  161  		 (unsigned long long)pci_resource_end(pdev, 0),
f64122c1f6ade3 Dave Airlie             2013-02-25  162  		 (int)pci_resource_len(pdev, 0) / 1024 / 1024,
f64122c1f6ade3 Dave Airlie             2013-02-25  163  		 (int)pci_resource_len(pdev, 0) / 1024,
970fa986fadb11 Dave Airlie             2013-05-31  164  		 (unsigned long long)qdev->surfaceram_base,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  165  		 (unsigned long long)pci_resource_end(pdev, sb),
f64122c1f6ade3 Dave Airlie             2013-02-25  166  		 (int)qdev->surfaceram_size / 1024 / 1024,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  167  		 (int)qdev->surfaceram_size / 1024,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  168  		 (sb == 4) ? "64bit" : "32bit");
f64122c1f6ade3 Dave Airlie             2013-02-25  169  
f64122c1f6ade3 Dave Airlie             2013-02-25  170  	qdev->rom = ioremap(qdev->rom_base, qdev->rom_size);
f64122c1f6ade3 Dave Airlie             2013-02-25  171  	if (!qdev->rom) {
f64122c1f6ade3 Dave Airlie             2013-02-25  172  		pr_err("Unable to ioremap ROM\n");
5043348a4969ae Anton Vasilyev          2018-07-27  173  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  174  		goto surface_mapping_free;
f64122c1f6ade3 Dave Airlie             2013-02-25  175  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  176  
5043348a4969ae Anton Vasilyev          2018-07-27  177  	if (!qxl_check_device(qdev)) {
5043348a4969ae Anton Vasilyev          2018-07-27  178  		r = -ENODEV;
dbe3ad61dcebc4 Markus Elfring          2019-11-07  179  		goto rom_unmap;
5043348a4969ae Anton Vasilyev          2018-07-27  180  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  181  
f64122c1f6ade3 Dave Airlie             2013-02-25  182  	r = qxl_bo_init(qdev);
f64122c1f6ade3 Dave Airlie             2013-02-25  183  	if (r) {
f64122c1f6ade3 Dave Airlie             2013-02-25  184  		DRM_ERROR("bo init failed %d\n", r);
5043348a4969ae Anton Vasilyev          2018-07-27  185  		goto rom_unmap;
f64122c1f6ade3 Dave Airlie             2013-02-25  186  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  187  
f64122c1f6ade3 Dave Airlie             2013-02-25  188  	qdev->ram_header = ioremap(qdev->vram_base +
f64122c1f6ade3 Dave Airlie             2013-02-25  189  				   qdev->rom->ram_header_offset,
f64122c1f6ade3 Dave Airlie             2013-02-25  190  				   sizeof(*qdev->ram_header));
5043348a4969ae Anton Vasilyev          2018-07-27  191  	if (!qdev->ram_header) {
5043348a4969ae Anton Vasilyev          2018-07-27  192  		DRM_ERROR("Unable to ioremap RAM header\n");
5043348a4969ae Anton Vasilyev          2018-07-27  193  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  194  		goto bo_fini;
5043348a4969ae Anton Vasilyev          2018-07-27  195  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  196  
f64122c1f6ade3 Dave Airlie             2013-02-25  197  	qdev->command_ring = qxl_ring_create(&(qdev->ram_header->cmd_ring_hdr),
f64122c1f6ade3 Dave Airlie             2013-02-25  198  					     sizeof(struct qxl_command),
f64122c1f6ade3 Dave Airlie             2013-02-25  199  					     QXL_COMMAND_RING_SIZE,
f64122c1f6ade3 Dave Airlie             2013-02-25  200  					     qdev->io_base + QXL_IO_NOTIFY_CMD,
f64122c1f6ade3 Dave Airlie             2013-02-25  201  					     false,
f64122c1f6ade3 Dave Airlie             2013-02-25  202  					     &qdev->display_event);
5043348a4969ae Anton Vasilyev          2018-07-27  203  	if (!qdev->command_ring) {
5043348a4969ae Anton Vasilyev          2018-07-27  204  		DRM_ERROR("Unable to create command ring\n");
5043348a4969ae Anton Vasilyev          2018-07-27  205  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  206  		goto ram_header_unmap;
5043348a4969ae Anton Vasilyev          2018-07-27  207  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  208  
f64122c1f6ade3 Dave Airlie             2013-02-25  209  	qdev->cursor_ring = qxl_ring_create(
f64122c1f6ade3 Dave Airlie             2013-02-25  210  				&(qdev->ram_header->cursor_ring_hdr),
f64122c1f6ade3 Dave Airlie             2013-02-25  211  				sizeof(struct qxl_command),
f64122c1f6ade3 Dave Airlie             2013-02-25  212  				QXL_CURSOR_RING_SIZE,
80e5f89da3ab94 Huacai Chen             2020-03-31  213  				qdev->io_base + QXL_IO_NOTIFY_CURSOR,
f64122c1f6ade3 Dave Airlie             2013-02-25  214  				false,
f64122c1f6ade3 Dave Airlie             2013-02-25  215  				&qdev->cursor_event);
f64122c1f6ade3 Dave Airlie             2013-02-25  216  
5043348a4969ae Anton Vasilyev          2018-07-27  217  	if (!qdev->cursor_ring) {
5043348a4969ae Anton Vasilyev          2018-07-27  218  		DRM_ERROR("Unable to create cursor ring\n");
5043348a4969ae Anton Vasilyev          2018-07-27  219  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  220  		goto command_ring_free;
5043348a4969ae Anton Vasilyev          2018-07-27  221  	}
5043348a4969ae Anton Vasilyev          2018-07-27  222  
f64122c1f6ade3 Dave Airlie             2013-02-25  223  	qdev->release_ring = qxl_ring_create(
f64122c1f6ade3 Dave Airlie             2013-02-25  224  				&(qdev->ram_header->release_ring_hdr),
f64122c1f6ade3 Dave Airlie             2013-02-25  225  				sizeof(uint64_t),
f64122c1f6ade3 Dave Airlie             2013-02-25  226  				QXL_RELEASE_RING_SIZE, 0, true,
f64122c1f6ade3 Dave Airlie             2013-02-25  227  				NULL);
f64122c1f6ade3 Dave Airlie             2013-02-25  228  
5043348a4969ae Anton Vasilyev          2018-07-27  229  	if (!qdev->release_ring) {
5043348a4969ae Anton Vasilyev          2018-07-27  230  		DRM_ERROR("Unable to create release ring\n");
5043348a4969ae Anton Vasilyev          2018-07-27  231  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  232  		goto cursor_ring_free;
5043348a4969ae Anton Vasilyev          2018-07-27  233  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  234  
f64122c1f6ade3 Dave Airlie             2013-02-25  235  	idr_init(&qdev->release_idr);
f64122c1f6ade3 Dave Airlie             2013-02-25  236  	spin_lock_init(&qdev->release_idr_lock);
2f453ed4038526 Maarten Lankhorst       2014-04-02  237  	spin_lock_init(&qdev->release_lock);
f64122c1f6ade3 Dave Airlie             2013-02-25  238  
f64122c1f6ade3 Dave Airlie             2013-02-25  239  	idr_init(&qdev->surf_id_idr);
f64122c1f6ade3 Dave Airlie             2013-02-25  240  	spin_lock_init(&qdev->surf_id_idr_lock);
f64122c1f6ade3 Dave Airlie             2013-02-25  241  
f64122c1f6ade3 Dave Airlie             2013-02-25  242  	mutex_init(&qdev->async_io_mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  243  
f64122c1f6ade3 Dave Airlie             2013-02-25  244  	/* reset the device into a known state - no memslots, no primary
f64122c1f6ade3 Dave Airlie             2013-02-25  245  	 * created, no surfaces. */
f64122c1f6ade3 Dave Airlie             2013-02-25  246  	qxl_io_reset(qdev);
f64122c1f6ade3 Dave Airlie             2013-02-25  247  
f64122c1f6ade3 Dave Airlie             2013-02-25  248  	/* must initialize irq before first async io - slot creation */
f64122c1f6ade3 Dave Airlie             2013-02-25  249  	r = qxl_irq_init(qdev);
5043348a4969ae Anton Vasilyev          2018-07-27  250  	if (r) {
5043348a4969ae Anton Vasilyev          2018-07-27  251  		DRM_ERROR("Unable to init qxl irq\n");
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  252  		goto release_ring_free;
5043348a4969ae Anton Vasilyev          2018-07-27  253  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  254  
f64122c1f6ade3 Dave Airlie             2013-02-25  255  	/*
f64122c1f6ade3 Dave Airlie             2013-02-25  256  	 * Note that virtual is surface0. We rely on the single ioremap done
f64122c1f6ade3 Dave Airlie             2013-02-25  257  	 * before.
f64122c1f6ade3 Dave Airlie             2013-02-25  258  	 */
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  259  	setup_slot(qdev, &qdev->main_slot, 0, "main",
f64122c1f6ade3 Dave Airlie             2013-02-25  260  		   (unsigned long)qdev->vram_base,
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  261  		   (unsigned long)qdev->rom->ram_header_offset);
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  262  	setup_slot(qdev, &qdev->surfaces_slot, 1, "surfaces",
d9bbf1895f354c Gerd Hoffmann           2013-10-11  263  		   (unsigned long)qdev->surfaceram_base,
d9bbf1895f354c Gerd Hoffmann           2013-10-11  264  		   (unsigned long)qdev->surfaceram_size);
f64122c1f6ade3 Dave Airlie             2013-02-25  265  
f64122c1f6ade3 Dave Airlie             2013-02-25  266  	INIT_WORK(&qdev->gc_work, qxl_gc_work);
f64122c1f6ade3 Dave Airlie             2013-02-25  267  
f64122c1f6ade3 Dave Airlie             2013-02-25  268  	return 0;
5043348a4969ae Anton Vasilyev          2018-07-27  269  
5043348a4969ae Anton Vasilyev          2018-07-27  270  release_ring_free:
5043348a4969ae Anton Vasilyev          2018-07-27  271  	qxl_ring_free(qdev->release_ring);
5043348a4969ae Anton Vasilyev          2018-07-27  272  cursor_ring_free:
5043348a4969ae Anton Vasilyev          2018-07-27  273  	qxl_ring_free(qdev->cursor_ring);
5043348a4969ae Anton Vasilyev          2018-07-27  274  command_ring_free:
5043348a4969ae Anton Vasilyev          2018-07-27  275  	qxl_ring_free(qdev->command_ring);
5043348a4969ae Anton Vasilyev          2018-07-27  276  ram_header_unmap:
5043348a4969ae Anton Vasilyev          2018-07-27 @277  	iounmap(qdev->ram_header);
5043348a4969ae Anton Vasilyev          2018-07-27  278  bo_fini:
5043348a4969ae Anton Vasilyev          2018-07-27  279  	qxl_bo_fini(qdev);
5043348a4969ae Anton Vasilyev          2018-07-27  280  rom_unmap:
5043348a4969ae Anton Vasilyev          2018-07-27 @281  	iounmap(qdev->rom);
5043348a4969ae Anton Vasilyev          2018-07-27  282  surface_mapping_free:
5043348a4969ae Anton Vasilyev          2018-07-27  283  	io_mapping_free(qdev->surface_mapping);
5043348a4969ae Anton Vasilyev          2018-07-27  284  vram_mapping_free:
5043348a4969ae Anton Vasilyev          2018-07-27  285  	io_mapping_free(qdev->vram_mapping);
5043348a4969ae Anton Vasilyev          2018-07-27  286  	return r;
f64122c1f6ade3 Dave Airlie             2013-02-25  287  }
f64122c1f6ade3 Dave Airlie             2013-02-25  288  

:::::: The code at line 277 was first introduced by commit
:::::: 5043348a4969ae1661c008efe929abd0d76e3792 drm: qxl: Fix error handling at qxl_device_init

:::::: TO: Anton Vasilyev <vasilyev@ispras.ru>
:::::: CC: Gerd Hoffmann <kraxel@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Nq2Wo0NMKNjxTN9z
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Rqy4NWWP/z8ZjxqU2m4BAA==

--Nq2Wo0NMKNjxTN9z--

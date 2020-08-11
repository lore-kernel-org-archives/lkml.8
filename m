Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9420885
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgHKMx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:53:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:35736 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgHKMxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:53:53 -0400
IronPort-SDR: vuvBfptfXL9b13rOUxnEWwd4Y6cdoOOsNS+SwCfPAqN+HHUf8OhAMzfwxt4ziiNY2pZ0YSUpLT
 mI57LpAFJUJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="152943014"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="gz'50?scan'50,208,50";a="152943014"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 05:38:47 -0700
IronPort-SDR: pz9Rknimi03/QwkJQoTiTJvCzYcJIaUKOHeQvqQWp96h0sa6CP7xaxcmxyRaNTzy7GQS5JLGs/
 762aTxcrifmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="gz'50?scan'50,208,50";a="326836749"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2020 05:38:45 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5TYD-0000aD-0s; Tue, 11 Aug 2020 12:38:45 +0000
Date:   Tue, 11 Aug 2020 20:38:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202008112009.LsWXcFPv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00e4db51259a5f936fec1424b884f029479d3981
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: ia64-randconfig-s032-20200811 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-168-g9554805c-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected unsigned int [noderef] __user *__pu_ptr
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c: note: in included file (through arch/ia64/include/asm/io.h, arch/ia64/include/asm/smp.h, arch/ia64/include/asm/topology.h, ...):
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
--
>> drivers/gpu/drm/radeon/radeon_fb.c:264:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *s @@     got void *kptr @@
>> drivers/gpu/drm/radeon/radeon_fb.c:264:22: sparse:     expected void volatile [noderef] __iomem *s
   drivers/gpu/drm/radeon/radeon_fb.c:264:22: sparse:     got void *kptr
   drivers/gpu/drm/radeon/radeon_fb.c:271:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *kptr @@
   drivers/gpu/drm/radeon/radeon_fb.c:271:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/gpu/drm/radeon/radeon_fb.c:271:27: sparse:     got void *kptr

vim +979 drivers/gpu/drm/radeon/radeon_ttm.c

771fe6b912fca54 Jerome Glisse         2009-06-05  782  
771fe6b912fca54 Jerome Glisse         2009-06-05 @783  int radeon_ttm_init(struct radeon_device *rdev)
771fe6b912fca54 Jerome Glisse         2009-06-05  784  {
771fe6b912fca54 Jerome Glisse         2009-06-05  785  	int r;
771fe6b912fca54 Jerome Glisse         2009-06-05  786  
771fe6b912fca54 Jerome Glisse         2009-06-05  787  	/* No others user of address space so set it to 0 */
771fe6b912fca54 Jerome Glisse         2009-06-05  788  	r = ttm_bo_device_init(&rdev->mman.bdev,
44d847b7439bdea David Herrmann        2013-08-13  789  			       &radeon_bo_driver,
44d847b7439bdea David Herrmann        2013-08-13  790  			       rdev->ddev->anon_inode->i_mapping,
8b53e1cb2728b63 Gerd Hoffmann         2019-09-05  791  			       rdev->ddev->vma_offset_manager,
33b3ad3788aba84 Christoph Hellwig     2019-08-15  792  			       dma_addressing_limited(&rdev->pdev->dev));
771fe6b912fca54 Jerome Glisse         2009-06-05  793  	if (r) {
771fe6b912fca54 Jerome Glisse         2009-06-05  794  		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
771fe6b912fca54 Jerome Glisse         2009-06-05  795  		return r;
771fe6b912fca54 Jerome Glisse         2009-06-05  796  	}
0a0c7596c643239 Jerome Glisse         2009-12-11  797  	rdev->mman.initialized = true;
4c7886791264f03 Jerome Glisse         2009-11-20  798  	r = ttm_bo_init_mm(&rdev->mman.bdev, TTM_PL_VRAM,
312ea8da049a183 Jerome Glisse         2009-12-07  799  				rdev->mc.real_vram_size >> PAGE_SHIFT);
771fe6b912fca54 Jerome Glisse         2009-06-05  800  	if (r) {
771fe6b912fca54 Jerome Glisse         2009-06-05  801  		DRM_ERROR("Failed initializing VRAM heap.\n");
771fe6b912fca54 Jerome Glisse         2009-06-05  802  		return r;
771fe6b912fca54 Jerome Glisse         2009-06-05  803  	}
14eedc32a3c0ec9 Lauri Kasanen         2014-02-28  804  	/* Change the size here instead of the init above so only lpfn is affected */
14eedc32a3c0ec9 Lauri Kasanen         2014-02-28  805  	radeon_ttm_set_active_vram_size(rdev, rdev->mc.visible_vram_size);
14eedc32a3c0ec9 Lauri Kasanen         2014-02-28  806  
441921d5309cfe0 Daniel Vetter         2011-02-18  807  	r = radeon_bo_create(rdev, 256 * 1024, PAGE_SIZE, true,
831b6966a60fe72 Maarten Lankhorst     2014-09-18  808  			     RADEON_GEM_DOMAIN_VRAM, 0, NULL,
4aa5b92fd48f88f Kent Russell          2017-08-08  809  			     NULL, &rdev->stolen_vga_memory);
771fe6b912fca54 Jerome Glisse         2009-06-05  810  	if (r) {
771fe6b912fca54 Jerome Glisse         2009-06-05  811  		return r;
771fe6b912fca54 Jerome Glisse         2009-06-05  812  	}
4aa5b92fd48f88f Kent Russell          2017-08-08  813  	r = radeon_bo_reserve(rdev->stolen_vga_memory, false);
4c7886791264f03 Jerome Glisse         2009-11-20  814  	if (r)
4c7886791264f03 Jerome Glisse         2009-11-20  815  		return r;
4aa5b92fd48f88f Kent Russell          2017-08-08  816  	r = radeon_bo_pin(rdev->stolen_vga_memory, RADEON_GEM_DOMAIN_VRAM, NULL);
4aa5b92fd48f88f Kent Russell          2017-08-08  817  	radeon_bo_unreserve(rdev->stolen_vga_memory);
771fe6b912fca54 Jerome Glisse         2009-06-05  818  	if (r) {
4aa5b92fd48f88f Kent Russell          2017-08-08  819  		radeon_bo_unref(&rdev->stolen_vga_memory);
771fe6b912fca54 Jerome Glisse         2009-06-05  820  		return r;
771fe6b912fca54 Jerome Glisse         2009-06-05  821  	}
771fe6b912fca54 Jerome Glisse         2009-06-05  822  	DRM_INFO("radeon: %uM of VRAM memory ready\n",
fc986034540102c Niels Ole Salscheider 2013-05-18  823  		 (unsigned) (rdev->mc.real_vram_size / (1024 * 1024)));
4c7886791264f03 Jerome Glisse         2009-11-20  824  	r = ttm_bo_init_mm(&rdev->mman.bdev, TTM_PL_TT,
312ea8da049a183 Jerome Glisse         2009-12-07  825  				rdev->mc.gtt_size >> PAGE_SHIFT);
771fe6b912fca54 Jerome Glisse         2009-06-05  826  	if (r) {
771fe6b912fca54 Jerome Glisse         2009-06-05  827  		DRM_ERROR("Failed initializing GTT heap.\n");
771fe6b912fca54 Jerome Glisse         2009-06-05  828  		return r;
771fe6b912fca54 Jerome Glisse         2009-06-05  829  	}
771fe6b912fca54 Jerome Glisse         2009-06-05  830  	DRM_INFO("radeon: %uM of GTT memory ready.\n",
3ce0a23d2d25318 Jerome Glisse         2009-09-08  831  		 (unsigned)(rdev->mc.gtt_size / (1024 * 1024)));
fa8a123855e2006 Dave Airlie           2009-08-26  832  
fa8a123855e2006 Dave Airlie           2009-08-26  833  	r = radeon_ttm_debugfs_init(rdev);
fa8a123855e2006 Dave Airlie           2009-08-26  834  	if (r) {
fa8a123855e2006 Dave Airlie           2009-08-26  835  		DRM_ERROR("Failed to init debugfs\n");
fa8a123855e2006 Dave Airlie           2009-08-26  836  		return r;
fa8a123855e2006 Dave Airlie           2009-08-26  837  	}
771fe6b912fca54 Jerome Glisse         2009-06-05  838  	return 0;
771fe6b912fca54 Jerome Glisse         2009-06-05  839  }
771fe6b912fca54 Jerome Glisse         2009-06-05  840  
771fe6b912fca54 Jerome Glisse         2009-06-05  841  void radeon_ttm_fini(struct radeon_device *rdev)
771fe6b912fca54 Jerome Glisse         2009-06-05  842  {
4c7886791264f03 Jerome Glisse         2009-11-20  843  	int r;
4c7886791264f03 Jerome Glisse         2009-11-20  844  
0a0c7596c643239 Jerome Glisse         2009-12-11  845  	if (!rdev->mman.initialized)
0a0c7596c643239 Jerome Glisse         2009-12-11  846  		return;
2014b5694182b54 Christian König       2013-12-18  847  	radeon_ttm_debugfs_fini(rdev);
4aa5b92fd48f88f Kent Russell          2017-08-08  848  	if (rdev->stolen_vga_memory) {
4aa5b92fd48f88f Kent Russell          2017-08-08  849  		r = radeon_bo_reserve(rdev->stolen_vga_memory, false);
4c7886791264f03 Jerome Glisse         2009-11-20  850  		if (r == 0) {
4aa5b92fd48f88f Kent Russell          2017-08-08  851  			radeon_bo_unpin(rdev->stolen_vga_memory);
4aa5b92fd48f88f Kent Russell          2017-08-08  852  			radeon_bo_unreserve(rdev->stolen_vga_memory);
4c7886791264f03 Jerome Glisse         2009-11-20  853  		}
4aa5b92fd48f88f Kent Russell          2017-08-08  854  		radeon_bo_unref(&rdev->stolen_vga_memory);
771fe6b912fca54 Jerome Glisse         2009-06-05  855  	}
771fe6b912fca54 Jerome Glisse         2009-06-05  856  	ttm_bo_clean_mm(&rdev->mman.bdev, TTM_PL_VRAM);
771fe6b912fca54 Jerome Glisse         2009-06-05  857  	ttm_bo_clean_mm(&rdev->mman.bdev, TTM_PL_TT);
771fe6b912fca54 Jerome Glisse         2009-06-05  858  	ttm_bo_device_release(&rdev->mman.bdev);
771fe6b912fca54 Jerome Glisse         2009-06-05  859  	radeon_gart_fini(rdev);
0a0c7596c643239 Jerome Glisse         2009-12-11  860  	rdev->mman.initialized = false;
771fe6b912fca54 Jerome Glisse         2009-06-05  861  	DRM_INFO("radeon: ttm finalized\n");
771fe6b912fca54 Jerome Glisse         2009-06-05  862  }
771fe6b912fca54 Jerome Glisse         2009-06-05  863  
5359533801e3dd3 Dave Airlie           2011-03-14  864  /* this should only be called at bootup or when userspace
5359533801e3dd3 Dave Airlie           2011-03-14  865   * isn't running */
5359533801e3dd3 Dave Airlie           2011-03-14  866  void radeon_ttm_set_active_vram_size(struct radeon_device *rdev, u64 size)
5359533801e3dd3 Dave Airlie           2011-03-14  867  {
5359533801e3dd3 Dave Airlie           2011-03-14  868  	struct ttm_mem_type_manager *man;
5359533801e3dd3 Dave Airlie           2011-03-14  869  
5359533801e3dd3 Dave Airlie           2011-03-14  870  	if (!rdev->mman.initialized)
5359533801e3dd3 Dave Airlie           2011-03-14  871  		return;
5359533801e3dd3 Dave Airlie           2011-03-14  872  
5359533801e3dd3 Dave Airlie           2011-03-14  873  	man = &rdev->mman.bdev.man[TTM_PL_VRAM];
5359533801e3dd3 Dave Airlie           2011-03-14  874  	/* this just adjusts TTM size idea, which sets lpfn to the correct value */
5359533801e3dd3 Dave Airlie           2011-03-14  875  	man->size = size >> PAGE_SHIFT;
5359533801e3dd3 Dave Airlie           2011-03-14  876  }
5359533801e3dd3 Dave Airlie           2011-03-14  877  
2bfb0b678e48dee Souptick Joarder      2018-04-16  878  static vm_fault_t radeon_ttm_fault(struct vm_fault *vmf)
771fe6b912fca54 Jerome Glisse         2009-06-05  879  {
771fe6b912fca54 Jerome Glisse         2009-06-05  880  	struct ttm_buffer_object *bo;
5876dd249e8e47c Matthew Garrett       2010-04-26  881  	struct radeon_device *rdev;
2bfb0b678e48dee Souptick Joarder      2018-04-16  882  	vm_fault_t ret;
771fe6b912fca54 Jerome Glisse         2009-06-05  883  
11bac80004499ea Dave Jiang            2017-02-24  884  	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
165d3448a1a0e86 Christian König       2019-09-27  885  	if (bo == NULL)
771fe6b912fca54 Jerome Glisse         2009-06-05  886  		return VM_FAULT_NOPAGE;
165d3448a1a0e86 Christian König       2019-09-27  887  
5876dd249e8e47c Matthew Garrett       2010-04-26  888  	rdev = radeon_get_rdev(bo->bdev);
db7fce3983ad9b3 Christian König       2012-05-11  889  	down_read(&rdev->pm.mclk_lock);
165d3448a1a0e86 Christian König       2019-09-27  890  	ret = ttm_bo_vm_fault(vmf);
db7fce3983ad9b3 Christian König       2012-05-11  891  	up_read(&rdev->pm.mclk_lock);
2bfb0b678e48dee Souptick Joarder      2018-04-16  892  	return ret;
771fe6b912fca54 Jerome Glisse         2009-06-05  893  }
771fe6b912fca54 Jerome Glisse         2009-06-05  894  
165d3448a1a0e86 Christian König       2019-09-27  895  static struct vm_operations_struct radeon_ttm_vm_ops = {
165d3448a1a0e86 Christian König       2019-09-27  896  	.fault = radeon_ttm_fault,
165d3448a1a0e86 Christian König       2019-09-27  897  	.open = ttm_bo_vm_open,
165d3448a1a0e86 Christian König       2019-09-27  898  	.close = ttm_bo_vm_close,
165d3448a1a0e86 Christian König       2019-09-27  899  	.access = ttm_bo_vm_access
165d3448a1a0e86 Christian König       2019-09-27  900  };
165d3448a1a0e86 Christian König       2019-09-27  901  
771fe6b912fca54 Jerome Glisse         2009-06-05  902  int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
771fe6b912fca54 Jerome Glisse         2009-06-05  903  {
771fe6b912fca54 Jerome Glisse         2009-06-05  904  	int r;
bed2dd84212eb01 Thomas Zimmermann     2019-02-07  905  	struct drm_file *file_priv = filp->private_data;
bed2dd84212eb01 Thomas Zimmermann     2019-02-07  906  	struct radeon_device *rdev = file_priv->minor->dev->dev_private;
771fe6b912fca54 Jerome Glisse         2009-06-05  907  
165d3448a1a0e86 Christian König       2019-09-27  908  	if (rdev == NULL)
771fe6b912fca54 Jerome Glisse         2009-06-05  909  		return -EINVAL;
165d3448a1a0e86 Christian König       2019-09-27  910  
771fe6b912fca54 Jerome Glisse         2009-06-05  911  	r = ttm_bo_mmap(filp, vma, &rdev->mman.bdev);
165d3448a1a0e86 Christian König       2019-09-27  912  	if (unlikely(r != 0))
771fe6b912fca54 Jerome Glisse         2009-06-05  913  		return r;
165d3448a1a0e86 Christian König       2019-09-27  914  
771fe6b912fca54 Jerome Glisse         2009-06-05  915  	vma->vm_ops = &radeon_ttm_vm_ops;
771fe6b912fca54 Jerome Glisse         2009-06-05  916  	return 0;
771fe6b912fca54 Jerome Glisse         2009-06-05  917  }
771fe6b912fca54 Jerome Glisse         2009-06-05  918  
fa8a123855e2006 Dave Airlie           2009-08-26  919  #if defined(CONFIG_DEBUG_FS)
893d6e6e122386d Christian König       2013-12-12  920  
fa8a123855e2006 Dave Airlie           2009-08-26  921  static int radeon_mm_dump_table(struct seq_file *m, void *data)
fa8a123855e2006 Dave Airlie           2009-08-26  922  {
fa8a123855e2006 Dave Airlie           2009-08-26  923  	struct drm_info_node *node = (struct drm_info_node *)m->private;
893d6e6e122386d Christian König       2013-12-12  924  	unsigned ttm_pl = *(int*)node->info_ent->data;
fa8a123855e2006 Dave Airlie           2009-08-26  925  	struct drm_device *dev = node->minor->dev;
fa8a123855e2006 Dave Airlie           2009-08-26  926  	struct radeon_device *rdev = dev->dev_private;
bbbb29efa20d552 Christian König       2017-08-07  927  	struct ttm_mem_type_manager *man = &rdev->mman.bdev.man[ttm_pl];
b5c3714fe878974 Daniel Vetter         2016-12-29  928  	struct drm_printer p = drm_seq_file_printer(m);
fa8a123855e2006 Dave Airlie           2009-08-26  929  
bbbb29efa20d552 Christian König       2017-08-07  930  	man->func->debug(man, &p);
b5c3714fe878974 Daniel Vetter         2016-12-29  931  	return 0;
fa8a123855e2006 Dave Airlie           2009-08-26  932  }
893d6e6e122386d Christian König       2013-12-12  933  
bbbb29efa20d552 Christian König       2017-08-07  934  
893d6e6e122386d Christian König       2013-12-12  935  static int ttm_pl_vram = TTM_PL_VRAM;
893d6e6e122386d Christian König       2013-12-12  936  static int ttm_pl_tt = TTM_PL_TT;
893d6e6e122386d Christian König       2013-12-12  937  
893d6e6e122386d Christian König       2013-12-12  938  static struct drm_info_list radeon_ttm_debugfs_list[] = {
893d6e6e122386d Christian König       2013-12-12  939  	{"radeon_vram_mm", radeon_mm_dump_table, 0, &ttm_pl_vram},
893d6e6e122386d Christian König       2013-12-12  940  	{"radeon_gtt_mm", radeon_mm_dump_table, 0, &ttm_pl_tt},
893d6e6e122386d Christian König       2013-12-12  941  	{"ttm_page_pool", ttm_page_alloc_debugfs, 0, NULL},
893d6e6e122386d Christian König       2013-12-12  942  #ifdef CONFIG_SWIOTLB
893d6e6e122386d Christian König       2013-12-12  943  	{"ttm_dma_page_pool", ttm_dma_page_alloc_debugfs, 0, NULL}
893d6e6e122386d Christian König       2013-12-12  944  #endif
893d6e6e122386d Christian König       2013-12-12  945  };
893d6e6e122386d Christian König       2013-12-12  946  
2014b5694182b54 Christian König       2013-12-18  947  static int radeon_ttm_vram_open(struct inode *inode, struct file *filep)
2014b5694182b54 Christian König       2013-12-18  948  {
2014b5694182b54 Christian König       2013-12-18  949  	struct radeon_device *rdev = inode->i_private;
2014b5694182b54 Christian König       2013-12-18  950  	i_size_write(inode, rdev->mc.mc_vram_size);
2014b5694182b54 Christian König       2013-12-18  951  	filep->private_data = inode->i_private;
2014b5694182b54 Christian König       2013-12-18  952  	return 0;
2014b5694182b54 Christian König       2013-12-18  953  }
2014b5694182b54 Christian König       2013-12-18  954  
2014b5694182b54 Christian König       2013-12-18  955  static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
2014b5694182b54 Christian König       2013-12-18  956  				    size_t size, loff_t *pos)
2014b5694182b54 Christian König       2013-12-18  957  {
2014b5694182b54 Christian König       2013-12-18  958  	struct radeon_device *rdev = f->private_data;
2014b5694182b54 Christian König       2013-12-18  959  	ssize_t result = 0;
2014b5694182b54 Christian König       2013-12-18  960  	int r;
2014b5694182b54 Christian König       2013-12-18  961  
2014b5694182b54 Christian König       2013-12-18  962  	if (size & 0x3 || *pos & 0x3)
2014b5694182b54 Christian König       2013-12-18  963  		return -EINVAL;
2014b5694182b54 Christian König       2013-12-18  964  
2014b5694182b54 Christian König       2013-12-18  965  	while (size) {
2014b5694182b54 Christian König       2013-12-18  966  		unsigned long flags;
2014b5694182b54 Christian König       2013-12-18  967  		uint32_t value;
2014b5694182b54 Christian König       2013-12-18  968  
2014b5694182b54 Christian König       2013-12-18  969  		if (*pos >= rdev->mc.mc_vram_size)
2014b5694182b54 Christian König       2013-12-18  970  			return result;
2014b5694182b54 Christian König       2013-12-18  971  
2014b5694182b54 Christian König       2013-12-18  972  		spin_lock_irqsave(&rdev->mmio_idx_lock, flags);
2014b5694182b54 Christian König       2013-12-18  973  		WREG32(RADEON_MM_INDEX, ((uint32_t)*pos) | 0x80000000);
2014b5694182b54 Christian König       2013-12-18  974  		if (rdev->family >= CHIP_CEDAR)
2014b5694182b54 Christian König       2013-12-18  975  			WREG32(EVERGREEN_MM_INDEX_HI, *pos >> 31);
2014b5694182b54 Christian König       2013-12-18  976  		value = RREG32(RADEON_MM_DATA);
2014b5694182b54 Christian König       2013-12-18  977  		spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
2014b5694182b54 Christian König       2013-12-18  978  
2014b5694182b54 Christian König       2013-12-18 @979  		r = put_user(value, (uint32_t *)buf);
2014b5694182b54 Christian König       2013-12-18  980  		if (r)
2014b5694182b54 Christian König       2013-12-18  981  			return r;
2014b5694182b54 Christian König       2013-12-18  982  
2014b5694182b54 Christian König       2013-12-18  983  		result += 4;
2014b5694182b54 Christian König       2013-12-18  984  		buf += 4;
2014b5694182b54 Christian König       2013-12-18  985  		*pos += 4;
2014b5694182b54 Christian König       2013-12-18  986  		size -= 4;
2014b5694182b54 Christian König       2013-12-18  987  	}
2014b5694182b54 Christian König       2013-12-18  988  
2014b5694182b54 Christian König       2013-12-18  989  	return result;
2014b5694182b54 Christian König       2013-12-18  990  }
2014b5694182b54 Christian König       2013-12-18  991  

:::::: The code at line 979 was first introduced by commit
:::::: 2014b5694182b54c781b93d26ec993f8a12bca01 drm/radeon: add VRAM debugfs access v3

:::::: TO: Christian König <christian.koenig@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2fHTh5uZTiUOsy+g--

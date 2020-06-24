Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024F2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0AC20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405377AbgFXROS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:14:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:62122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404431AbgFXROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:14:17 -0400
IronPort-SDR: SR/d0SES7KXHlHSvnDizb/+0HyHdGPsmeALpdAx/Z14l0PfiTw1hUC0NtgFDtYyJCJGAY+HtDJ
 tnMTAjDHjCQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142782193"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="142782193"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 10:09:26 -0700
IronPort-SDR: 7qu9h1TDxxGLnQB+RkIksGHtxjlfr9yydGjUH/Z9UxxgTwrfIqFJuToWfi2dHmel+80dqwKx2F
 ZCUKMB+iDK5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="301697658"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jun 2020 10:09:24 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jo8tn-00012u-PC; Wed, 24 Jun 2020 17:09:23 +0000
Date:   Thu, 25 Jun 2020 01:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/tty/synclinkmp.c:3642:29: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202006250102.XFGoduAO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 days ago
config: arm-randconfig-s032-20200624 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/tty/synclinkmp.c:3562:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] memory_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3562:27: sparse:     expected unsigned char *[usertype] memory_base
   drivers/tty/synclinkmp.c:3562:27: sparse:     got void [noderef] __iomem *
   drivers/tty/synclinkmp.c:3571:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] lcr_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3571:24: sparse:     expected unsigned char *[usertype] lcr_base
   drivers/tty/synclinkmp.c:3571:24: sparse:     got void [noderef] __iomem *
   drivers/tty/synclinkmp.c:3580:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] sca_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3580:24: sparse:     expected unsigned char *[usertype] sca_base
   drivers/tty/synclinkmp.c:3580:24: sparse:     got void [noderef] __iomem *
   drivers/tty/synclinkmp.c:3589:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] statctrl_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3589:29: sparse:     expected unsigned char *[usertype] statctrl_base
   drivers/tty/synclinkmp.c:3589:29: sparse:     got void [noderef] __iomem *
>> drivers/tty/synclinkmp.c:3642:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got unsigned char *[usertype] memory_base @@
>> drivers/tty/synclinkmp.c:3642:29: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/tty/synclinkmp.c:3642:29: sparse:     got unsigned char *[usertype] memory_base
>> drivers/tty/synclinkmp.c:3647:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3647:40: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/tty/synclinkmp.c:3647:40: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:3652:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3652:45: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/tty/synclinkmp.c:3652:45: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:3657:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3657:40: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/tty/synclinkmp.c:3657:40: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:5383:15: sparse: sparse: memset with byte count of 262144

vim +3642 drivers/tty/synclinkmp.c

^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3523  
ce9f9f73af0338a drivers/char/synclinkmp.c Harvey Harrison   2008-04-28  3524  static int claim_resources(SLMP_INFO *info)
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3525  {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3526  	if (request_mem_region(info->phys_memory_base,SCA_MEM_SIZE,"synclinkmp") == NULL) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3527  		printk( "%s(%d):%s mem addr conflict, Addr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3528  			__FILE__,__LINE__,info->device_name, info->phys_memory_base);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3529  		info->init_error = DiagStatus_AddressConflict;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3530  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3531  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3532  	else
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3533  		info->shared_mem_requested = true;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3534  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3535  	if (request_mem_region(info->phys_lcr_base + info->lcr_offset,128,"synclinkmp") == NULL) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3536  		printk( "%s(%d):%s lcr mem addr conflict, Addr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3537  			__FILE__,__LINE__,info->device_name, info->phys_lcr_base);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3538  		info->init_error = DiagStatus_AddressConflict;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3539  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3540  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3541  	else
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3542  		info->lcr_mem_requested = true;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3543  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3544  	if (request_mem_region(info->phys_sca_base + info->sca_offset,SCA_BASE_SIZE,"synclinkmp") == NULL) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3545  		printk( "%s(%d):%s sca mem addr conflict, Addr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3546  			__FILE__,__LINE__,info->device_name, info->phys_sca_base);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3547  		info->init_error = DiagStatus_AddressConflict;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3548  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3549  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3550  	else
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3551  		info->sca_base_requested = true;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3552  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3553  	if (request_mem_region(info->phys_statctrl_base + info->statctrl_offset,SCA_REG_SIZE,"synclinkmp") == NULL) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3554  		printk( "%s(%d):%s stat/ctrl mem addr conflict, Addr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3555  			__FILE__,__LINE__,info->device_name, info->phys_statctrl_base);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3556  		info->init_error = DiagStatus_AddressConflict;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3557  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3558  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3559  	else
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3560  		info->sca_statctrl_requested = true;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3561  
4bdc0d676a64314 drivers/tty/synclinkmp.c  Christoph Hellwig 2020-01-06  3562  	info->memory_base = ioremap(info->phys_memory_base,
24cb233520f0197 drivers/char/synclinkmp.c Alan Cox          2008-04-30  3563  								SCA_MEM_SIZE);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3564  	if (!info->memory_base) {
25985edcedea639 drivers/tty/synclinkmp.c  Lucas De Marchi   2011-03-30  3565  		printk( "%s(%d):%s Can't map shared memory, MemAddr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3566  			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3567  		info->init_error = DiagStatus_CantAssignPciResources;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3568  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3569  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3570  
4bdc0d676a64314 drivers/tty/synclinkmp.c  Christoph Hellwig 2020-01-06 @3571  	info->lcr_base = ioremap(info->phys_lcr_base, PAGE_SIZE);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3572  	if (!info->lcr_base) {
25985edcedea639 drivers/tty/synclinkmp.c  Lucas De Marchi   2011-03-30  3573  		printk( "%s(%d):%s Can't map LCR memory, MemAddr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3574  			__FILE__,__LINE__,info->device_name, info->phys_lcr_base );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3575  		info->init_error = DiagStatus_CantAssignPciResources;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3576  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3577  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3578  	info->lcr_base += info->lcr_offset;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3579  
4bdc0d676a64314 drivers/tty/synclinkmp.c  Christoph Hellwig 2020-01-06 @3580  	info->sca_base = ioremap(info->phys_sca_base, PAGE_SIZE);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3581  	if (!info->sca_base) {
25985edcedea639 drivers/tty/synclinkmp.c  Lucas De Marchi   2011-03-30  3582  		printk( "%s(%d):%s Can't map SCA memory, MemAddr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3583  			__FILE__,__LINE__,info->device_name, info->phys_sca_base );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3584  		info->init_error = DiagStatus_CantAssignPciResources;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3585  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3586  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3587  	info->sca_base += info->sca_offset;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3588  
4bdc0d676a64314 drivers/tty/synclinkmp.c  Christoph Hellwig 2020-01-06  3589  	info->statctrl_base = ioremap(info->phys_statctrl_base,
24cb233520f0197 drivers/char/synclinkmp.c Alan Cox          2008-04-30  3590  								PAGE_SIZE);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3591  	if (!info->statctrl_base) {
25985edcedea639 drivers/tty/synclinkmp.c  Lucas De Marchi   2011-03-30  3592  		printk( "%s(%d):%s Can't map SCA Status/Control memory, MemAddr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3593  			__FILE__,__LINE__,info->device_name, info->phys_statctrl_base );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3594  		info->init_error = DiagStatus_CantAssignPciResources;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3595  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3596  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3597  	info->statctrl_base += info->statctrl_offset;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3598  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3599  	if ( !memory_test(info) ) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3600  		printk( "%s(%d):Shared Memory Test failed for device %s MemAddr=%08X\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3601  			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3602  		info->init_error = DiagStatus_MemoryError;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3603  		goto errout;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3604  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3605  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3606  	return 0;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3607  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3608  errout:
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3609  	release_resources( info );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3610  	return -ENODEV;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3611  }
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3612  
ce9f9f73af0338a drivers/char/synclinkmp.c Harvey Harrison   2008-04-28  3613  static void release_resources(SLMP_INFO *info)
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3614  {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3615  	if ( debug_level >= DEBUG_LEVEL_INFO )
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3616  		printk( "%s(%d):%s release_resources() entry\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3617  			__FILE__,__LINE__,info->device_name );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3618  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3619  	if ( info->irq_requested ) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3620  		free_irq(info->irq_level, info);
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3621  		info->irq_requested = false;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3622  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3623  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3624  	if ( info->shared_mem_requested ) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3625  		release_mem_region(info->phys_memory_base,SCA_MEM_SIZE);
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3626  		info->shared_mem_requested = false;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3627  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3628  	if ( info->lcr_mem_requested ) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3629  		release_mem_region(info->phys_lcr_base + info->lcr_offset,128);
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3630  		info->lcr_mem_requested = false;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3631  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3632  	if ( info->sca_base_requested ) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3633  		release_mem_region(info->phys_sca_base + info->sca_offset,SCA_BASE_SIZE);
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3634  		info->sca_base_requested = false;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3635  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3636  	if ( info->sca_statctrl_requested ) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3637  		release_mem_region(info->phys_statctrl_base + info->statctrl_offset,SCA_REG_SIZE);
0fab6de09c71a97 drivers/char/synclinkmp.c Joe Perches       2008-04-28  3638  		info->sca_statctrl_requested = false;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3639  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3640  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3641  	if (info->memory_base){
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16 @3642  		iounmap(info->memory_base);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3643  		info->memory_base = NULL;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3644  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3645  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3646  	if (info->sca_base) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16 @3647  		iounmap(info->sca_base - info->sca_offset);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3648  		info->sca_base=NULL;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3649  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3650  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3651  	if (info->statctrl_base) {
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3652  		iounmap(info->statctrl_base - info->statctrl_offset);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3653  		info->statctrl_base=NULL;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3654  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3655  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3656  	if (info->lcr_base){
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3657  		iounmap(info->lcr_base - info->lcr_offset);
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3658  		info->lcr_base = NULL;
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3659  	}
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3660  
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3661  	if ( debug_level >= DEBUG_LEVEL_INFO )
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3662  		printk( "%s(%d):%s release_resources() exit\n",
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3663  			__FILE__,__LINE__,info->device_name );
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3664  }
^1da177e4c3f415 drivers/char/synclinkmp.c Linus Torvalds    2005-04-16  3665  

:::::: The code at line 3642 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tThc/1wpZn/ma/RB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tThc/1wpZn/ma/RB--

Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 04:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5AB20709
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 04:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgHIEAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 00:00:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:32713 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHIEAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 00:00:20 -0400
IronPort-SDR: D2ZvGic2qsQBXc8+A9KcugldRjnvBy5ojnV+55UVIWudUXEbloLr5Rma+MAFIoCSAys24kLwbE
 7RE3Q93yAJFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9707"; a="133434271"
X-IronPort-AV: E=Sophos;i="5.75,452,1589266800"; 
   d="gz'50?scan'50,208,50";a="133434271"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2020 19:21:34 -0700
IronPort-SDR: qUf3h3N2OzcUe2mbyd47nJncE/zQRbIOOP2QoMCCxbq05uqEL6bK89IIb9nTxvKzZ+5BiXFbk6
 WAqFHBmQ5Gtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,452,1589266800"; 
   d="gz'50?scan'50,208,50";a="438290776"
Received: from lkp-server02.sh.intel.com (HELO 5ad9e2f13e37) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2020 19:21:32 -0700
Received: from kbuild by 5ad9e2f13e37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4axn-00000t-Q3; Sun, 09 Aug 2020 02:21:31 +0000
Date:   Sun, 9 Aug 2020 10:21:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202008091057.Fvbeljdc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06a81c1c7db9bd5de0bd38cd5acc44bb22b99150
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: arm-randconfig-s031-20200809 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     got void *virtual
>> drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:17: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *[assigned] src @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:9: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:9: sparse:     got void *[assigned] src
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] dst @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:9: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:9: sparse:     got void *[assigned] dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *[addressable] new_iomap @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:17: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:17: sparse:     got void *[addressable] new_iomap
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     got void *virtual
--
>> drivers/input/misc/ixp4xx-beeper.c:39:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/misc/ixp4xx-beeper.c:43:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/misc/ixp4xx-beeper.c:80:10: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/gpu/drm/armada/armada_fbdev.c:85:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/armada/armada_fbdev.c:85:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/gpu/drm/armada/armada_fbdev.c:85:27: sparse:     got void *[assigned] ptr
--
>> drivers/gpu/drm/armada/armada_gem.c:61:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *addr @@
>> drivers/gpu/drm/armada/armada_gem.c:61:37: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/armada/armada_gem.c:61:37: sparse:     got void *addr
>> drivers/gpu/drm/armada/armada_gem.c:183:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/armada/armada_gem.c:183:28: sparse:     expected void *addr
>> drivers/gpu/drm/armada/armada_gem.c:183:28: sparse:     got void [noderef] __iomem *
--
   drivers/gpu/drm/qxl/qxl_kms.c:36:5: sparse: sparse: symbol 'qxl_log_level' was not declared. Should it be static?
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_rom *rom @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse:     expected struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_ram_header *ram_header @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse:     expected struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_ram_header *ram_header @@
>> drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse:     got struct qxl_ram_header *ram_header
>> drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse:     got struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse:     got struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse:     got struct qxl_rom *rom
--
   drivers/pci/switch/switchtec.c:943:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got void * @@
   drivers/pci/switch/switchtec.c:943:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/pci/switch/switchtec.c:943:31: sparse:     got void *
   drivers/pci/switch/switchtec.c:951:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got void * @@
   drivers/pci/switch/switchtec.c:951:39: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/pci/switch/switchtec.c:951:39: sparse:     got void *
   drivers/pci/switch/switchtec.c:954:39: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got void * @@
   drivers/pci/switch/switchtec.c:954:39: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/pci/switch/switchtec.c:954:39: sparse:     got void *
   drivers/pci/switch/switchtec.c:1067:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct switchtec_ioctl_pff_port *up @@
   drivers/pci/switch/switchtec.c:1067:32: sparse:     expected void const [noderef] __user *from
   drivers/pci/switch/switchtec.c:1067:32: sparse:     got struct switchtec_ioctl_pff_port *up
   drivers/pci/switch/switchtec.c:1072:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct part_cfg_regs *pcfg @@     got struct part_cfg_regs [noderef] __iomem * @@
   drivers/pci/switch/switchtec.c:1072:22: sparse:     expected struct part_cfg_regs *pcfg
   drivers/pci/switch/switchtec.c:1072:22: sparse:     got struct part_cfg_regs [noderef] __iomem *
>> drivers/pci/switch/switchtec.c:1075:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/pci/switch/switchtec.c:1075:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1075:23: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1081:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1081:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1081:23: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1088:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1088:31: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1088:31: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1100:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct switchtec_ioctl_pff_port *up @@
   drivers/pci/switch/switchtec.c:1100:26: sparse:     expected void [noderef] __user *to
   drivers/pci/switch/switchtec.c:1100:26: sparse:     got struct switchtec_ioctl_pff_port *up
   drivers/pci/switch/switchtec.c:1112:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct switchtec_ioctl_pff_port *up @@
   drivers/pci/switch/switchtec.c:1112:32: sparse:     expected void const [noderef] __user *from
   drivers/pci/switch/switchtec.c:1112:32: sparse:     got struct switchtec_ioctl_pff_port *up
   drivers/pci/switch/switchtec.c:1116:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct part_cfg_regs *pcfg @@     got struct part_cfg_regs [noderef] __iomem *mmio_part_cfg @@
   drivers/pci/switch/switchtec.c:1116:22: sparse:     expected struct part_cfg_regs *pcfg
   drivers/pci/switch/switchtec.c:1116:22: sparse:     got struct part_cfg_regs [noderef] __iomem *mmio_part_cfg
   drivers/pci/switch/switchtec.c:1118:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct part_cfg_regs *pcfg @@     got struct part_cfg_regs [noderef] __iomem * @@
   drivers/pci/switch/switchtec.c:1118:22: sparse:     expected struct part_cfg_regs *pcfg
   drivers/pci/switch/switchtec.c:1118:22: sparse:     got struct part_cfg_regs [noderef] __iomem *
   drivers/pci/switch/switchtec.c:1124:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1124:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1124:25: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1127:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1127:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1127:25: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1134:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1134:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1134:25: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1138:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct switchtec_ioctl_pff_port *up @@
   drivers/pci/switch/switchtec.c:1138:26: sparse:     expected void [noderef] __user *to
   drivers/pci/switch/switchtec.c:1138:26: sparse:     got struct switchtec_ioctl_pff_port *up
   drivers/pci/switch/switchtec.c:1171:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct switchtec_ioctl_pff_port *up @@     got void [noderef] __user *argp @@
   drivers/pci/switch/switchtec.c:1171:47: sparse:     expected struct switchtec_ioctl_pff_port *up
   drivers/pci/switch/switchtec.c:1171:47: sparse:     got void [noderef] __user *argp
   drivers/pci/switch/switchtec.c:1174:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct switchtec_ioctl_pff_port *up @@     got void [noderef] __user *argp @@
   drivers/pci/switch/switchtec.c:1174:47: sparse:     expected struct switchtec_ioctl_pff_port *up
   drivers/pci/switch/switchtec.c:1174:47: sparse:     got void [noderef] __user *argp
   drivers/pci/switch/switchtec.c:1487:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct part_cfg_regs *pcfg @@     got struct part_cfg_regs [noderef] __iomem *mmio_part_cfg @@
   drivers/pci/switch/switchtec.c:1487:43: sparse:     expected struct part_cfg_regs *pcfg
   drivers/pci/switch/switchtec.c:1487:43: sparse:     got struct part_cfg_regs [noderef] __iomem *mmio_part_cfg
   drivers/pci/switch/switchtec.c:1497:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1497:15: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1497:15: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1501:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1501:15: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1501:15: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1506:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1506:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1506:23: sparse:     got unsigned int *
--
   drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:81:52: sparse:     got void *
   drivers/scsi/mvumi.c:90:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/scsi/mvumi.c:90:39: sparse:     expected void *
   drivers/scsi/mvumi.c:90:39: sparse:     got void [noderef] __iomem *
   drivers/scsi/mvumi.c:210:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:210:34: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:210:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:211:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:211:34: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:211:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:213:17: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:213:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:213:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:213:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:213:17: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:213:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:242:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:242:26: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:242:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:243:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:243:26: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:243:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:245:9: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:245:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:245:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:245:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:245:9: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:245:9: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/mvumi.c:407:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *inb_read_pointer @@
>> drivers/scsi/mvumi.c:407:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:407:21: sparse:     got void *inb_read_pointer
>> drivers/scsi/mvumi.c:429:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:429:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:429:17: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:458:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:458:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:458:9: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:459:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_write_pointer @@
   drivers/scsi/mvumi.c:459:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:459:9: sparse:     got void *inb_write_pointer
>> drivers/scsi/mvumi.c:496:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:496:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:496:28: sparse:     got void *outb_copy_pointer
>> drivers/scsi/mvumi.c:497:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:497:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:497:35: sparse:     got void *ob_shadow
>> drivers/scsi/mvumi.c:516:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:516:20: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:516:20: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:517:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:517:20: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:517:20: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:578:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:578:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:578:9: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:585:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:585:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:585:9: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:586:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:586:13: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:586:13: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:589:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:589:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:589:9: sparse:     got void *pciea_to_arm_drbl_reg
>> drivers/scsi/mvumi.c:1281:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1281:15: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1281:15: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1282:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1282:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1282:9: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1284:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1284:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1284:9: sparse:     got void *arm_to_pciea_mask_reg
>> drivers/scsi/mvumi.c:1285:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1285:15: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1285:15: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1286:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1286:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1286:9: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:612:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:612:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:612:9: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:613:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:613:15: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:613:15: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:615:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:615:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:615:17: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:624:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:624:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:624:23: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:670:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:670:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:670:9: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:671:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:671:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:671:9: sparse:     got void *reset_request
   drivers/scsi/mvumi.c:673:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:673:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:673:9: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:674:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:674:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:674:9: sparse:     got void *reset_request
>> drivers/scsi/mvumi.c:1100:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg0 @@
   drivers/scsi/mvumi.c:1100:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1100:23: sparse:     got void *arm_to_pciea_msg0
   drivers/scsi/mvumi.c:1115:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1115:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1115:17: sparse:     got void *pciea_to_arm_msg1
   drivers/scsi/mvumi.c:1116:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1116:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1116:17: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1117:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1117:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1117:17: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1121:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg1 @@
   drivers/scsi/mvumi.c:1121:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1121:17: sparse:     got void *pciea_to_arm_msg1
   drivers/scsi/mvumi.c:1123:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1123:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1123:17: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1127:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1127:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1127:17: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1128:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1128:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1128:17: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1168:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_msg0 @@
   drivers/scsi/mvumi.c:1168:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1168:17: sparse:     got void *pciea_to_arm_msg0
   drivers/scsi/mvumi.c:1169:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1169:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1169:17: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1174:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1174:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1174:23: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1176:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1176:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1176:17: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1177:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:1177:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1177:17: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:1179:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_aval_count_basel @@
   drivers/scsi/mvumi.c:1179:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1179:17: sparse:     got void *inb_aval_count_basel
   drivers/scsi/mvumi.c:1181:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *inb_aval_count_baseh @@
   drivers/scsi/mvumi.c:1181:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1181:17: sparse:     got void *inb_aval_count_baseh
   drivers/scsi/mvumi.c:1186:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:1186:25: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1186:25: sparse:     got void *ob_shadow
   drivers/scsi/mvumi.c:1189:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_copy_basel @@
   drivers/scsi/mvumi.c:1189:25: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1189:25: sparse:     got void *outb_copy_basel
   drivers/scsi/mvumi.c:1191:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_copy_baseh @@
   drivers/scsi/mvumi.c:1191:25: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1191:25: sparse:     got void *outb_copy_baseh
   drivers/scsi/mvumi.c:1244:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1244:15: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1244:15: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1247:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:1247:25: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1247:25: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1256:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:1256:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1256:23: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:1849:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_low_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1849:35: sparse:     expected unsigned int [usertype] src_low_addr
   drivers/scsi/mvumi.c:1849:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1851:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] src_high_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:1851:36: sparse:     expected unsigned int [usertype] src_high_addr
   drivers/scsi/mvumi.c:1851:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:1903:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1903:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1903:9: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1904:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1904:16: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1904:16: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1906:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1906:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1906:9: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1918:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1918:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1918:9: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1919:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1919:16: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1919:16: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1922:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1922:9: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1922:9: sparse:     got void *enpointa_mask_reg
>> drivers/scsi/mvumi.c:1931:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *main_int_cause_reg @@
   drivers/scsi/mvumi.c:1931:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1931:18: sparse:     got void *main_int_cause_reg
>> drivers/scsi/mvumi.c:1935:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1935:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1935:23: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1938:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1938:33: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1938:33: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1943:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1943:33: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1943:33: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1951:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1951:23: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1951:23: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1953:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *outb_isr_cause @@
   drivers/scsi/mvumi.c:1953:25: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1953:25: sparse:     got void *outb_isr_cause
   drivers/scsi/mvumi.c:1956:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1956:30: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1956:30: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1958:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1958:25: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1958:25: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1975:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1975:18: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1975:18: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1977:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1977:17: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1977:17: sparse:     got void *arm_to_pciea_drbl_reg

vim +256 drivers/gpu/drm/ttm/ttm_bo_util.c

82c5da6bf8b55a Jerome Glisse     2010-04-09  200  
dcbff15a601b54 Rashika Kheria    2014-01-06  201  static int ttm_mem_reg_ioremap(struct ttm_bo_device *bdev, struct ttm_mem_reg *mem,
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  202  			void **virtual)
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  203  {
eba67093f53532 Thomas Hellstrom  2010-11-11  204  	struct ttm_mem_type_manager *man = &bdev->man[mem->mem_type];
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  205  	int ret;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  206  	void *addr;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  207  
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  208  	*virtual = NULL;
eba67093f53532 Thomas Hellstrom  2010-11-11  209  	(void) ttm_mem_io_lock(man, false);
82c5da6bf8b55a Jerome Glisse     2010-04-09  210  	ret = ttm_mem_io_reserve(bdev, mem);
eba67093f53532 Thomas Hellstrom  2010-11-11  211  	ttm_mem_io_unlock(man);
9e51159c14c29e Jerome Glisse     2010-05-05  212  	if (ret || !mem->bus.is_iomem)
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  213  		return ret;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  214  
82c5da6bf8b55a Jerome Glisse     2010-04-09  215  	if (mem->bus.addr) {
82c5da6bf8b55a Jerome Glisse     2010-04-09  216  		addr = mem->bus.addr;
82c5da6bf8b55a Jerome Glisse     2010-04-09  217  	} else {
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  218  		if (mem->placement & TTM_PL_FLAG_WC)
82c5da6bf8b55a Jerome Glisse     2010-04-09 @219  			addr = ioremap_wc(mem->bus.base + mem->bus.offset, mem->bus.size);
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  220  		else
4bdc0d676a6431 Christoph Hellwig 2020-01-06  221  			addr = ioremap(mem->bus.base + mem->bus.offset, mem->bus.size);
82c5da6bf8b55a Jerome Glisse     2010-04-09  222  		if (!addr) {
eba67093f53532 Thomas Hellstrom  2010-11-11  223  			(void) ttm_mem_io_lock(man, false);
82c5da6bf8b55a Jerome Glisse     2010-04-09  224  			ttm_mem_io_free(bdev, mem);
eba67093f53532 Thomas Hellstrom  2010-11-11  225  			ttm_mem_io_unlock(man);
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  226  			return -ENOMEM;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  227  		}
82c5da6bf8b55a Jerome Glisse     2010-04-09  228  	}
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  229  	*virtual = addr;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  230  	return 0;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  231  }
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  232  
dcbff15a601b54 Rashika Kheria    2014-01-06  233  static void ttm_mem_reg_iounmap(struct ttm_bo_device *bdev, struct ttm_mem_reg *mem,
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  234  			 void *virtual)
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  235  {
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  236  	struct ttm_mem_type_manager *man;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  237  
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  238  	man = &bdev->man[mem->mem_type];
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  239  
0c321c79627189 Jerome Glisse     2010-04-07  240  	if (virtual && mem->bus.addr == NULL)
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  241  		iounmap(virtual);
eba67093f53532 Thomas Hellstrom  2010-11-11  242  	(void) ttm_mem_io_lock(man, false);
82c5da6bf8b55a Jerome Glisse     2010-04-09  243  	ttm_mem_io_free(bdev, mem);
eba67093f53532 Thomas Hellstrom  2010-11-11  244  	ttm_mem_io_unlock(man);
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  245  }
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  246  
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  247  static int ttm_copy_io_page(void *dst, void *src, unsigned long page)
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  248  {
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  249  	uint32_t *dstP =
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  250  	    (uint32_t *) ((unsigned long)dst + (page << PAGE_SHIFT));
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  251  	uint32_t *srcP =
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  252  	    (uint32_t *) ((unsigned long)src + (page << PAGE_SHIFT));
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  253  
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  254  	int i;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  255  	for (i = 0; i < PAGE_SIZE / sizeof(uint32_t); ++i)
ba4e7d973dd09b Thomas Hellstrom  2009-06-10 @256  		iowrite32(ioread32(srcP++), dstP++);
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  257  	return 0;
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  258  }
ba4e7d973dd09b Thomas Hellstrom  2009-06-10  259  

:::::: The code at line 256 was first introduced by commit
:::::: ba4e7d973dd09b66912ac4c0856add8b0703a997 drm: Add the TTM GPU memory manager subsystem.

:::::: TO: Thomas Hellstrom <thellstrom@vmware.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pf9I7BMVVzbSWLtt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--pf9I7BMVVzbSWLtt--

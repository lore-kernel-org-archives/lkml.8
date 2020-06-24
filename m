Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E7C2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404634AbgFXQCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:02:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:26263 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404235AbgFXQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:02:52 -0400
IronPort-SDR: l6v6ZguFzlza8TY3lzH5g1zbFtxHdMkQeRK5+oG8uznUAqSherBcNVLttbJedcQmUNyK2UvJ7V
 0+7j9rczJc/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="141999401"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="gz'50?scan'50,208,50";a="141999401"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 09:02:34 -0700
IronPort-SDR: zfrKWByoSam4IijwB5mFvAGh+840viKPuxg4N5SbIK+9ADMek/DB6VRQWFyNqXugidnqESbEOq
 PehvO0yuFKMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="gz'50?scan'50,208,50";a="479310314"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2020 09:02:32 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jo7r5-00011D-Mu; Wed, 24 Jun 2020 16:02:31 +0000
Date:   Thu, 25 Jun 2020 00:01:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/pci/switch/switchtec.c:1075:23: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202006250052.xW4q8bH1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 days ago
config: arm-randconfig-s031-20200624 (attached as .config)
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
>> fs/pstore/ram_core.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got unsigned char * @@
>> fs/pstore/ram_core.c:278:9: sparse:     expected void volatile [noderef] __iomem *to
   fs/pstore/ram_core.c:278:9: sparse:     got unsigned char *
>> fs/pstore/ram_core.c:311:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
>> fs/pstore/ram_core.c:311:9: sparse:     expected void const volatile [noderef] __iomem *from
   fs/pstore/ram_core.c:311:9: sparse:     got unsigned char *
   fs/pstore/ram_core.c:312:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
   fs/pstore/ram_core.c:312:9: sparse:     expected void const volatile [noderef] __iomem *from
   fs/pstore/ram_core.c:312:9: sparse:     got unsigned char *
   fs/pstore/ram_core.c:452:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:452:20: sparse:     expected void *va
   fs/pstore/ram_core.c:452:20: sparse:     got void [noderef] __iomem *
   fs/pstore/ram_core.c:454:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   fs/pstore/ram_core.c:454:20: sparse:     expected void *va
   fs/pstore/ram_core.c:454:20: sparse:     got void [noderef] __iomem *
>> fs/pstore/ram_core.c:542:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *vaddr @@
>> fs/pstore/ram_core.c:542:36: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   fs/pstore/ram_core.c:542:36: sparse:     got void *vaddr
   fs/pstore/ram_core.c:69:17: sparse: sparse: context imbalance in 'buffer_start_add' - unexpected unlock
   fs/pstore/ram_core.c:95:17: sparse: sparse: context imbalance in 'buffer_size_add' - unexpected unlock
--
   drivers/video/fbdev/aty/atyfb_base.c:475:9: sparse: sparse: switch with no cases
>> drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got unsigned char [usertype] *addr @@
>> drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse:     got unsigned char [usertype] *addr
--
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
>> drivers/watchdog/ixp4xx_wdt.c:45:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:46:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:47:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:48:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:49:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:56:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:57:10: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/ixp4xx_wdt.c:58:10: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/watchdog/ixp4xx_wdt.c:84:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *register __p @@     got char const * @@
>> drivers/watchdog/ixp4xx_wdt.c:84:37: sparse:     expected char const [noderef] __user *register __p
   drivers/watchdog/ixp4xx_wdt.c:84:37: sparse:     got char const *
>> drivers/watchdog/ixp4xx_wdt.c:110:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct watchdog_info * @@
>> drivers/watchdog/ixp4xx_wdt.c:110:37: sparse:     expected void [noderef] __user *to
   drivers/watchdog/ixp4xx_wdt.c:110:37: sparse:     got struct watchdog_info *
>> drivers/watchdog/ixp4xx_wdt.c:115:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__pu_ptr @@     got int * @@
>> drivers/watchdog/ixp4xx_wdt.c:115:23: sparse:     expected int const [noderef] __user *__pu_ptr
   drivers/watchdog/ixp4xx_wdt.c:115:23: sparse:     got int *
   drivers/watchdog/ixp4xx_wdt.c:119:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__pu_ptr @@     got int * @@
   drivers/watchdog/ixp4xx_wdt.c:119:23: sparse:     expected int const [noderef] __user *__pu_ptr
   drivers/watchdog/ixp4xx_wdt.c:119:23: sparse:     got int *
>> drivers/watchdog/ixp4xx_wdt.c:128:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *register __p @@     got int * @@
>> drivers/watchdog/ixp4xx_wdt.c:128:23: sparse:     expected int [noderef] __user *register __p
   drivers/watchdog/ixp4xx_wdt.c:128:23: sparse:     got int *
   drivers/watchdog/ixp4xx_wdt.c:142:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__pu_ptr @@     got int * @@
   drivers/watchdog/ixp4xx_wdt.c:142:23: sparse:     expected int const [noderef] __user *__pu_ptr
   drivers/watchdog/ixp4xx_wdt.c:142:23: sparse:     got int *
   drivers/watchdog/ixp4xx_wdt.c:164:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ixp4xx_wdt.c:164:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ixp4xx_wdt.c:164:27: sparse:     got int ( * )( ... )
   drivers/watchdog/ixp4xx_wdt.c:194:25: sparse: sparse: cast removes address space '__iomem' of expression
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
>> drivers/leds/leds-fsg.c:147:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/leds/leds-fsg.c:147:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected short [noderef] __iomem *static [toplevel] latch_address @@     got unsigned short * @@
>> drivers/leds/leds-fsg.c:147:23: sparse:     expected short [noderef] __iomem *static [toplevel] latch_address
   drivers/leds/leds-fsg.c:147:23: sparse:     got unsigned short *
   drivers/leds/leds-fsg.c:37:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:40:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:49:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:52:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:61:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:64:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:73:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:76:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:85:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:88:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:97:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:100:18: sparse: sparse: dereference of noderef expression
   drivers/leds/leds-fsg.c:153:10: sparse: sparse: dereference of noderef expression

vim +1075 drivers/pci/switch/switchtec.c

52eabba5bcdb28 Logan Gunthorpe 2017-03-02   936  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   937  static u32 __iomem *event_hdr_addr(struct switchtec_dev *stdev,
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   938  				   int event_id, int index)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   939  {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   940  	size_t off;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   941  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   942  	if (event_id < 0 || event_id >= SWITCHTEC_IOCTL_MAX_EVENTS)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   943  		return ERR_PTR(-EINVAL);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   944  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   945  	off = event_regs[event_id].offset;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   946  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   947  	if (event_regs[event_id].map_reg == part_ev_reg) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   948  		if (index == SWITCHTEC_IOCTL_EVENT_LOCAL_PART_IDX)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   949  			index = stdev->partition;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   950  		else if (index < 0 || index >= stdev->partition_count)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   951  			return ERR_PTR(-EINVAL);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   952  	} else if (event_regs[event_id].map_reg == pff_ev_reg) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   953  		if (index < 0 || index >= stdev->pff_csr_count)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  @954  			return ERR_PTR(-EINVAL);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   955  	}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   956  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   957  	return event_regs[event_id].map_reg(stdev, off, index);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   958  }
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   959  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   960  static int event_ctl(struct switchtec_dev *stdev,
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   961  		     struct switchtec_ioctl_event_ctl *ctl)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   962  {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   963  	int i;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   964  	u32 __iomem *reg;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   965  	u32 hdr;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   966  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   967  	reg = event_hdr_addr(stdev, ctl->event_id, ctl->index);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   968  	if (IS_ERR(reg))
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   969  		return PTR_ERR(reg);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   970  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   971  	hdr = ioread32(reg);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   972  	for (i = 0; i < ARRAY_SIZE(ctl->data); i++)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   973  		ctl->data[i] = ioread32(&reg[i + 1]);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   974  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   975  	ctl->occurred = hdr & SWITCHTEC_EVENT_OCCURRED;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   976  	ctl->count = (hdr >> 5) & 0xFF;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   977  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   978  	if (!(ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_CLEAR))
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   979  		hdr &= ~SWITCHTEC_EVENT_CLEAR;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   980  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_POLL)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   981  		hdr |= SWITCHTEC_EVENT_EN_IRQ;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   982  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_POLL)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   983  		hdr &= ~SWITCHTEC_EVENT_EN_IRQ;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   984  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_LOG)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   985  		hdr |= SWITCHTEC_EVENT_EN_LOG;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   986  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_LOG)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   987  		hdr &= ~SWITCHTEC_EVENT_EN_LOG;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   988  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_CLI)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   989  		hdr |= SWITCHTEC_EVENT_EN_CLI;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   990  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_CLI)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   991  		hdr &= ~SWITCHTEC_EVENT_EN_CLI;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   992  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_EN_FATAL)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   993  		hdr |= SWITCHTEC_EVENT_FATAL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   994  	if (ctl->flags & SWITCHTEC_IOCTL_EVENT_FLAG_DIS_FATAL)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   995  		hdr &= ~SWITCHTEC_EVENT_FATAL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   996  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   997  	if (ctl->flags)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   998  		iowrite32(hdr, reg);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02   999  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1000  	ctl->flags = 0;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1001  	if (hdr & SWITCHTEC_EVENT_EN_IRQ)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1002  		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_POLL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1003  	if (hdr & SWITCHTEC_EVENT_EN_LOG)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1004  		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_LOG;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1005  	if (hdr & SWITCHTEC_EVENT_EN_CLI)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1006  		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_CLI;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1007  	if (hdr & SWITCHTEC_EVENT_FATAL)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1008  		ctl->flags |= SWITCHTEC_IOCTL_EVENT_FLAG_EN_FATAL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1009  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1010  	return 0;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1011  }
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1012  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1013  static int ioctl_event_ctl(struct switchtec_dev *stdev,
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1014  	struct switchtec_ioctl_event_ctl __user *uctl)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1015  {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1016  	int ret;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1017  	int nr_idxs;
e4a7dca5de6250 Joey Zhang      2018-12-10  1018  	unsigned int event_flags;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1019  	struct switchtec_ioctl_event_ctl ctl;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1020  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1021  	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1022  		return -EFAULT;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1023  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1024  	if (ctl.event_id >= SWITCHTEC_IOCTL_MAX_EVENTS)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1025  		return -EINVAL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1026  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1027  	if (ctl.flags & SWITCHTEC_IOCTL_EVENT_FLAG_UNUSED)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1028  		return -EINVAL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1029  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1030  	if (ctl.index == SWITCHTEC_IOCTL_EVENT_IDX_ALL) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1031  		if (event_regs[ctl.event_id].map_reg == global_ev_reg)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1032  			nr_idxs = 1;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1033  		else if (event_regs[ctl.event_id].map_reg == part_ev_reg)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1034  			nr_idxs = stdev->partition_count;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1035  		else if (event_regs[ctl.event_id].map_reg == pff_ev_reg)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1036  			nr_idxs = stdev->pff_csr_count;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1037  		else
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1038  			return -EINVAL;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1039  
e4a7dca5de6250 Joey Zhang      2018-12-10  1040  		event_flags = ctl.flags;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1041  		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
e4a7dca5de6250 Joey Zhang      2018-12-10  1042  			ctl.flags = event_flags;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1043  			ret = event_ctl(stdev, &ctl);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1044  			if (ret < 0)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1045  				return ret;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1046  		}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1047  	} else {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1048  		ret = event_ctl(stdev, &ctl);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1049  		if (ret < 0)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1050  			return ret;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1051  	}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1052  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1053  	if (copy_to_user(uctl, &ctl, sizeof(ctl)))
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1054  		return -EFAULT;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1055  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1056  	return 0;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1057  }
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1058  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1059  static int ioctl_pff_to_port(struct switchtec_dev *stdev,
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1060  			     struct switchtec_ioctl_pff_port *up)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1061  {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1062  	int i, part;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1063  	u32 reg;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1064  	struct part_cfg_regs *pcfg;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1065  	struct switchtec_ioctl_pff_port p;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1066  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1067  	if (copy_from_user(&p, up, sizeof(p)))
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1068  		return -EFAULT;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1069  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1070  	p.port = -1;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1071  	for (part = 0; part < stdev->partition_count; part++) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1072  		pcfg = &stdev->mmio_part_cfg_all[part];
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1073  		p.partition = part;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1074  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02 @1075  		reg = ioread32(&pcfg->usp_pff_inst_id);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1076  		if (reg == p.pff) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1077  			p.port = 0;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1078  			break;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1079  		}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1080  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1081  		reg = ioread32(&pcfg->vep_pff_inst_id);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1082  		if (reg == p.pff) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1083  			p.port = SWITCHTEC_IOCTL_PFF_VEP;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1084  			break;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1085  		}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1086  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1087  		for (i = 0; i < ARRAY_SIZE(pcfg->dsp_pff_inst_id); i++) {
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1088  			reg = ioread32(&pcfg->dsp_pff_inst_id[i]);
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1089  			if (reg != p.pff)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1090  				continue;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1091  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1092  			p.port = i + 1;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1093  			break;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1094  		}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1095  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1096  		if (p.port != -1)
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1097  			break;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1098  	}
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1099  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1100  	if (copy_to_user(up, &p, sizeof(p)))
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1101  		return -EFAULT;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1102  
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1103  	return 0;
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1104  }
52eabba5bcdb28 Logan Gunthorpe 2017-03-02  1105  

:::::: The code at line 1075 was first introduced by commit
:::::: 52eabba5bcdb2853dec6ef007ba427b092034738 switchtec: Add IOCTLs to the Switchtec driver

:::::: TO: Logan Gunthorpe <logang@deltatee.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--

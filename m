Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FB5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A74C206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGLQWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:22:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:23749 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgGLQWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 12:22:37 -0400
IronPort-SDR: 8BscQTjIUu+1lu46H9ROaIR2NRyu8gp5c1xNSQYSn7OJGzvLV9pSP+la95p8Ry2BaftnN0iy5N
 BzBdbABpG4ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="210052364"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="gz'50?scan'50,208,50";a="210052364"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:22:16 -0700
IronPort-SDR: 7ddP1OaYcNBeRJaHaDObBrRYE2dhwOWbk3lBDmYeDg8OjE+ibDi2mda1wyVKiPP2B6p4tHEY3F
 wWvog8JkDG0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="gz'50?scan'50,208,50";a="359830680"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2020 09:22:14 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1juek1-0000BU-DG; Sun, 12 Jul 2020 16:22:13 +0000
Date:   Mon, 13 Jul 2020 00:22:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/pci/switch/switchtec.c:1075:33: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202007130001.YwRogR7e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0aea6d5c5be33ce94c16f9ab2f64de1f481f424b
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: alpha-randconfig-s032-20200712 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

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
>> drivers/pci/switch/switchtec.c:1075:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/pci/switch/switchtec.c:1075:33: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1075:33: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1081:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1081:33: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1081:33: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1088:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1088:62: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1088:62: sparse:     got unsigned int *
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
   drivers/pci/switch/switchtec.c:1124:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1124:35: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1124:35: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1127:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1127:35: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1127:35: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1134:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1134:56: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1134:56: sparse:     got unsigned int *
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
   drivers/pci/switch/switchtec.c:1497:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1497:25: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1497:25: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1501:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1501:25: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1501:25: sparse:     got unsigned int *
   drivers/pci/switch/switchtec.c:1506:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/pci/switch/switchtec.c:1506:54: sparse:     expected void [noderef] __iomem *addr
   drivers/pci/switch/switchtec.c:1506:54: sparse:     got unsigned int *
--
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     got void *virtual
>> drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got void *[assigned] src @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:28: sparse:     expected void const volatile [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:28: sparse:     got void *[assigned] src
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got void *[assigned] dst @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:21: sparse:     expected void volatile [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:21: sparse:     got void *[assigned] dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[addressable] new_iomap @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:27: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:27: sparse:     got void *[addressable] new_iomap
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     got void *virtual

vim +1075 drivers/pci/switch/switchtec.c

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

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
UPAyr73z4FgiKv32f9LijRs9uQEA

--C7zPtVaVf+AK4Oqc--

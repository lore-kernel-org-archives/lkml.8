Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C147420838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgG3MgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:36:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:11956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgG3MgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:36:09 -0400
IronPort-SDR: uBXI760VUFmyqjRFrWMfDLnRGifXHMPgF70TE10iPR6Ml4vnReRFpN63fZT2H66XjRXDmyI573
 O7AwXprGa14w==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="131650678"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="gz'50?scan'50,208,50";a="131650678"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 05:02:57 -0700
IronPort-SDR: m3oOBl6NTbJrwd1VAdc4A+Wf+IWg3wnIDmY5qLG5aiVG1s67XlAJAP+a8S0um9+wXoCGjASkz6
 44cC6jVJ734w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="gz'50?scan'50,208,50";a="328941990"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2020 05:02:55 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k17Gw-00004T-SZ; Thu, 30 Jul 2020 12:02:54 +0000
Date:   Thu, 30 Jul 2020 20:02:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/nvidia/nvidia.c:1411:20: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <202007302058.iObdNZnF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   83bdc7275e6206f560d247be856bceba3e1ed8f2
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: arc-randconfig-s032-20200730 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-98-g4932334a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/nvidia/nvidia.c:1411:20: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *REGS @@
>> drivers/video/fbdev/nvidia/nvidia.c:1411:20: sparse:     expected void const [noderef] __iomem *addr
   drivers/video/fbdev/nvidia/nvidia.c:1411:20: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *REGS
   drivers/video/fbdev/nvidia/nvidia.c:1436:20: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *REGS @@
   drivers/video/fbdev/nvidia/nvidia.c:1436:20: sparse:     expected void const [noderef] __iomem *addr
   drivers/video/fbdev/nvidia/nvidia.c:1436:20: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *REGS
--
   drivers/uio/uio_aec.c:44:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *int_flag @@     got void * @@
   drivers/uio/uio_aec.c:44:49: sparse:     expected void [noderef] __iomem *int_flag
   drivers/uio/uio_aec.c:44:49: sparse:     got void *
   drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:50:49: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:50:49: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:88:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/uio/uio_aec.c:88:20: sparse:     expected void *priv
   drivers/uio/uio_aec.c:88:20: sparse:     got void [noderef] __iomem *
   drivers/uio/uio_aec.c:104:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:104:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:104:42: sparse:     got void *
   drivers/uio/uio_aec.c:105:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:105:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:105:43: sparse:     got void *
   drivers/uio/uio_aec.c:106:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:106:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:106:34: sparse:     got void *
   drivers/uio/uio_aec.c:115:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *p @@     got void *priv @@
   drivers/uio/uio_aec.c:115:31: sparse:     expected void [noderef] __iomem *p
   drivers/uio/uio_aec.c:115:31: sparse:     got void *priv
   drivers/uio/uio_aec.c:130:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:130:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:130:42: sparse:     got void *
   drivers/uio/uio_aec.c:131:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:131:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:131:43: sparse:     got void *
   drivers/uio/uio_aec.c:133:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:133:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:133:28: sparse:     got void *
>> drivers/uio/uio_aec.c:138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void *priv @@
>> drivers/uio/uio_aec.c:138:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:138:21: sparse:     got void *priv
--
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
>> drivers/video/fbdev/riva/fbdev.c:2064:42: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN @@
>> drivers/video/fbdev/riva/fbdev.c:2064:42: sparse:     expected void const [noderef] __iomem *addr
   drivers/video/fbdev/riva/fbdev.c:2064:42: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN @@
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN

vim +1411 drivers/video/fbdev/nvidia/nvidia.c

^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1270  
48c68c4f1b5424 drivers/video/nvidia/nvidia.c       Greg Kroah-Hartman     2012-12-21  1271  static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1272  {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1273  	struct nvidia_par *par;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1274  	struct fb_info *info;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1275  	unsigned short cmd;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1276  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1277  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1278  	NVTRACE_ENTER();
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1279  	assert(pd != NULL);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1280  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1281  	info = framebuffer_alloc(sizeof(struct nvidia_par), &pd->dev);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1282  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1283  	if (!info)
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1284  		goto err_out;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1285  
c439e345425434 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1286  	par = info->par;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1287  	par->pci_dev = pd;
f5610b9c3a2896 drivers/video/nvidia/nvidia.c       Jiri Slaby             2007-02-12  1288  	info->pixmap.addr = kzalloc(8 * 1024, GFP_KERNEL);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1289  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1290  	if (info->pixmap.addr == NULL)
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1291  		goto err_out_kfree;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1292  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1293  	if (pci_enable_device(pd)) {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1294  		printk(KERN_ERR PFX "cannot enable PCI device\n");
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1295  		goto err_out_enable;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1296  	}
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1297  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1298  	if (pci_request_regions(pd, "nvidiafb")) {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1299  		printk(KERN_ERR PFX "cannot request PCI regions\n");
a06630f3e7fb29 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-06-26  1300  		goto err_out_enable;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1301  	}
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1302  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1303  	par->FlatPanel = flatpanel;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1304  	if (flatpanel == 1)
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1305  		printk(KERN_INFO PFX "flatpanel support enabled\n");
b8c49ef6aeef66 drivers/video/nvidia/nvidia.c       Benjamin Herrenschmidt 2005-11-07  1306  	par->FPDither = fpdither;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1307  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1308  	par->CRTCnumber = forceCRTC;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1309  	par->FpScale = (!noscale);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1310  	par->paneltweak = paneltweak;
3c03ec209af1dd drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2007-10-16  1311  	par->reverse_i2c = reverse_i2c;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1312  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1313  	/* enable IO and mem if not already done */
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1314  	pci_read_config_word(pd, PCI_COMMAND, &cmd);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1315  	cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1316  	pci_write_config_word(pd, PCI_COMMAND, cmd);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1317  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1318  	nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1319  	nvidiafb_fix.smem_start = pci_resource_start(pd, 1);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1320  	nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1321  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1322  	par->REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1323  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1324  	if (!par->REGS) {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1325  		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1326  		goto err_out_free_base0;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1327  	}
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1328  
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1329  	par->Chipset = nvidia_get_chipset(info);
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1330  	par->Architecture = nvidia_get_arch(info);
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1331  
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1332  	if (par->Architecture == 0) {
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1333  		printk(KERN_ERR PFX "unknown NV_ARCH\n");
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1334  		goto err_out_arch;
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1335  	}
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1336  
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1337  	sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1338  
918799ab6f2788 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1339  	if (NVCommonSetup(info))
918799ab6f2788 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1340  		goto err_out_arch;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1341  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1342  	par->FbAddress = nvidiafb_fix.smem_start;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1343  	par->FbMapSize = par->RamAmountKBytes * 1024;
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1344  	if (vram && vram * 1024 * 1024 < par->FbMapSize)
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1345  		par->FbMapSize = vram * 1024 * 1024;
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1346  
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1347  	/* Limit amount of vram to 64 MB */
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1348  	if (par->FbMapSize > 64 * 1024 * 1024)
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1349  		par->FbMapSize = 64 * 1024 * 1024;
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1350  
0137ecfdc3453f drivers/video/nvidia/nvidia.c       Benjamin Herrenschmidt 2006-01-09  1351  	if(par->Architecture >= NV_ARCH_40)
0137ecfdc3453f drivers/video/nvidia/nvidia.c       Benjamin Herrenschmidt 2006-01-09  1352    	        par->FbUsableSize = par->FbMapSize - (560 * 1024);
0137ecfdc3453f drivers/video/nvidia/nvidia.c       Benjamin Herrenschmidt 2006-01-09  1353  	else
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1354  		par->FbUsableSize = par->FbMapSize - (128 * 1024);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1355  	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1356  	    16 * 1024;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1357  	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
0137ecfdc3453f drivers/video/nvidia/nvidia.c       Benjamin Herrenschmidt 2006-01-09  1358  	par->CursorStart = par->FbUsableSize + (32 * 1024);
0137ecfdc3453f drivers/video/nvidia/nvidia.c       Benjamin Herrenschmidt 2006-01-09  1359  
3b213c2f6f563b drivers/video/fbdev/nvidia/nvidia.c Luis R. Rodriguez      2015-04-21  1360  	info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
3b213c2f6f563b drivers/video/fbdev/nvidia/nvidia.c Luis R. Rodriguez      2015-04-21  1361  				       par->FbMapSize);
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1362  	info->screen_size = par->FbUsableSize;
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1363  	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1364  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1365  	if (!info->screen_base) {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1366  		printk(KERN_ERR PFX "cannot ioremap FB base\n");
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1367  		goto err_out_free_base1;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1368  	}
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1369  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1370  	par->FbStart = info->screen_base;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1371  
3b213c2f6f563b drivers/video/fbdev/nvidia/nvidia.c Luis R. Rodriguez      2015-04-21  1372  	if (!nomtrr)
3b213c2f6f563b drivers/video/fbdev/nvidia/nvidia.c Luis R. Rodriguez      2015-04-21  1373  		par->wc_cookie = arch_phys_wc_add(nvidiafb_fix.smem_start,
3b213c2f6f563b drivers/video/fbdev/nvidia/nvidia.c Luis R. Rodriguez      2015-04-21  1374  						  par->RamAmountKBytes * 1024);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1375  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1376  	info->fbops = &nvidia_fb_ops;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1377  	info->fix = nvidiafb_fix;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1378  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1379  	if (nvidia_set_fbinfo(info) < 0) {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1380  		printk(KERN_ERR PFX "error setting initial video mode\n");
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1381  		goto err_out_iounmap_fb;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1382  	}
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1383  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1384  	nvidia_save_vga(par, &par->SavedReg);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1385  
ce38cac48209d2 drivers/video/nvidia/nvidia.c       Guido Guenther         2006-07-30  1386  	pci_set_drvdata(pd, info);
202d4e602555e6 drivers/video/nvidia/nvidia.c       Richard Purdie         2007-03-03  1387  
202d4e602555e6 drivers/video/nvidia/nvidia.c       Richard Purdie         2007-03-03  1388  	if (backlight)
ce38cac48209d2 drivers/video/nvidia/nvidia.c       Guido Guenther         2006-07-30  1389  		nvidia_bl_init(par);
202d4e602555e6 drivers/video/nvidia/nvidia.c       Richard Purdie         2007-03-03  1390  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1391  	if (register_framebuffer(info) < 0) {
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1392  		printk(KERN_ERR PFX "error registering nVidia framebuffer\n");
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1393  		goto err_out_iounmap_fb;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1394  	}
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1395  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1396  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1397  	printk(KERN_INFO PFX
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1398  	       "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1399  	       info->fix.id,
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1400  	       par->FbMapSize / (1024 * 1024), info->fix.smem_start);
5474c120aafe78 drivers/video/nvidia/nvidia.c       Michael Hanselmann     2006-06-25  1401  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1402  	NVTRACE_LEAVE();
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1403  	return 0;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1404  
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1405  err_out_iounmap_fb:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1406  	iounmap(info->screen_base);
917bb0771aa077 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2005-05-01  1407  err_out_free_base1:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1408  	fb_destroy_modedb(info->monspecs.modedb);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1409  	nvidia_delete_i2c_busses(par);
c549dc6422e4b7 drivers/video/nvidia/nvidia.c       Antonino A. Daplas     2006-01-09  1410  err_out_arch:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16 @1411  	iounmap(par->REGS);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1412   err_out_free_base0:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1413  	pci_release_regions(pd);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1414  err_out_enable:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1415  	kfree(info->pixmap.addr);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1416  err_out_kfree:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1417  	framebuffer_release(info);
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1418  err_out:
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1419  	return -ENODEV;
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1420  }
^1da177e4c3f41 drivers/video/nvidia/nvidia.c       Linus Torvalds         2005-04-16  1421  

:::::: The code at line 1411 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qDbXVdCdHGoSgWSk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qDbXVdCdHGoSgWSk--

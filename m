Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1129C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748EF20639
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIIQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:01:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:24781 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgIIP7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:59:15 -0400
IronPort-SDR: RiNfIIVmxd5aIFFnnNVRxpJSHQEdu4NGWsFJ4noB2kChW6V6YoN49RPmXkuacbjxtzdP1tKBOf
 yxCRCsMFV5ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219895111"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="gz'50?scan'50,208,50";a="219895111"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 07:33:45 -0700
IronPort-SDR: mpE6UWCEnYi1dMT1Jwaa5KKCsKwsMnPgzK32sbnMWU8ecoTGviIS3dSJO2IbEHE6I4YSMlr+vm
 iOEavzWN8UOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="gz'50?scan'50,208,50";a="300165738"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2020 07:33:42 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kG1AM-0000Su-7l; Wed, 09 Sep 2020 14:33:42 +0000
Date:   Wed, 9 Sep 2020 22:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/pci-mvebu.c:368:17: sparse: sparse:
 restricted __le16 degrades to integer
Message-ID: <202009092209.3NgHE9YO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
commit: e0d9d30b73548fbfe5c024ed630169bdc9a08aee PCI: pci-bridge-emul: Fix big-endian support
date:   11 months ago
config: arm-randconfig-s032-20200909 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout e0d9d30b73548fbfe5c024ed630169bdc9a08aee
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pci-mvebu.c:368:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:368:38: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:369:19: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:389:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:392:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:406:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:406:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:407:19: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:419:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/pci/controller/pci-mvebu.c:420:31: sparse: sparse: restricted __le16 degrades to integer
>> drivers/pci/controller/pci-mvebu.c:483:39: sparse: sparse: invalid assignment: &=
>> drivers/pci/controller/pci-mvebu.c:483:39: sparse:    left side has type restricted __le16
>> drivers/pci/controller/pci-mvebu.c:483:39: sparse:    right side has type int
   drivers/pci/controller/pci-mvebu.c:557:28: sparse: sparse: symbol 'mvebu_pci_bridge_emul_ops' was not declared. Should it be static?
>> drivers/pci/controller/pci-mvebu.c:571:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] vendor @@     got int @@
>> drivers/pci/controller/pci-mvebu.c:571:29: sparse:     expected restricted __le16 [usertype] vendor
>> drivers/pci/controller/pci-mvebu.c:571:29: sparse:     got int
>> drivers/pci/controller/pci-mvebu.c:572:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] device @@     got unsigned int @@
>> drivers/pci/controller/pci-mvebu.c:572:29: sparse:     expected restricted __le16 [usertype] device
>> drivers/pci/controller/pci-mvebu.c:572:29: sparse:     got unsigned int
>> drivers/pci/controller/pci-mvebu.c:573:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] class_revision @@     got unsigned int @@
>> drivers/pci/controller/pci-mvebu.c:573:37: sparse:     expected restricted __le32 [usertype] class_revision
   drivers/pci/controller/pci-mvebu.c:573:37: sparse:     got unsigned int
   drivers/pci/controller/pci-mvebu.c:716:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] <asn:2> * @@     got void * @@
   drivers/pci/controller/pci-mvebu.c:716:31: sparse:     expected void [noderef] <asn:2> *
   drivers/pci/controller/pci-mvebu.c:716:31: sparse:     got void *

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0d9d30b73548fbfe5c024ed630169bdc9a08aee
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout e0d9d30b73548fbfe5c024ed630169bdc9a08aee
vim +368 drivers/pci/controller/pci-mvebu.c

d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  360  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  361  static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  362  {
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  363  	struct mvebu_pcie_window desired = {};
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  364  	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  365  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  366  	/* Are the new iobase/iolimit values invalid? */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  367  	if (conf->iolimit < conf->iobase ||
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @368  	    conf->iolimitupper < conf->iobaseupper ||
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @369  	    !(conf->command & PCI_COMMAND_IO)) {
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  370  		mvebu_pcie_set_window(port, port->io_target, port->io_attr,
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  371  				      &desired, &port->iowin);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  372  		return;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  373  	}
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  374  
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  375  	if (!mvebu_has_ioport(port)) {
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  376  		dev_WARN(&port->pcie->pdev->dev,
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  377  			 "Attempt to set IO when IO is disabled\n");
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  378  		return;
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  379  	}
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  380  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  381  	/*
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  382  	 * We read the PCI-to-PCI bridge emulated registers, and
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  383  	 * calculate the base address and size of the address decoding
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  384  	 * window to setup, according to the PCI-to-PCI bridge
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  385  	 * specifications. iobase is the bus address, port->iowin_base
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  386  	 * is the CPU address.
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  387  	 */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  388  	desired.remap = ((conf->iobase & 0xF0) << 8) |
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @389  			(conf->iobaseupper << 16);
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  390  	desired.base = port->pcie->io.start + desired.remap;
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  391  	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  392  			 (conf->iolimitupper << 16)) -
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  393  			desired.remap) +
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  394  		       1;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  395  
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  396  	mvebu_pcie_set_window(port, port->io_target, port->io_attr, &desired,
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  397  			      &port->iowin);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  398  }
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  399  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  400  static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  401  {
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  402  	struct mvebu_pcie_window desired = {.remap = MVEBU_MBUS_NO_REMAP};
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  403  	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  404  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  405  	/* Are the new membase/memlimit values invalid? */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @406  	if (conf->memlimit < conf->membase ||
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @407  	    !(conf->command & PCI_COMMAND_MEMORY)) {
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  408  		mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  409  				      &desired, &port->memwin);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  410  		return;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  411  	}
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  412  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  413  	/*
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  414  	 * We read the PCI-to-PCI bridge emulated registers, and
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  415  	 * calculate the base address and size of the address decoding
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  416  	 * window to setup, according to the PCI-to-PCI bridge
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  417  	 * specifications.
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  418  	 */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @419  	desired.base = ((conf->membase & 0xFFF0) << 16);
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @420  	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  421  		       desired.base + 1;
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  422  
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  423  	mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
d9bf28e2650fe3 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2016-12-12  424  			      &port->memwin);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  425  }
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  426  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  427  static pci_bridge_emul_read_status_t
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  428  mvebu_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  429  				     int reg, u32 *value)
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  430  {
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  431  	struct mvebu_pcie_port *port = bridge->data;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  432  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  433  	switch (reg) {
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  434  	case PCI_EXP_DEVCAP:
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  435  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCAP);
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  436  		break;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  437  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  438  	case PCI_EXP_DEVCTL:
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  439  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  440  				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  441  				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  442  		break;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  443  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  444  	case PCI_EXP_LNKCAP:
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  445  		/*
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  446  		 * PCIe requires the clock power management capability to be
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  447  		 * hard-wired to zero for downstream ports
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  448  		 */
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  449  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP) &
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  450  			 ~PCI_EXP_LNKCAP_CLKPM;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  451  		break;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  452  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  453  	case PCI_EXP_LNKCTL:
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  454  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCTL);
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  455  		break;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  456  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  457  	case PCI_EXP_SLTCTL:
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  458  		*value = PCI_EXP_SLTSTA_PDS << 16;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  459  		break;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  460  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  461  	case PCI_EXP_RTSTA:
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  462  		*value = mvebu_readl(port, PCIE_RC_RTSTA);
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  463  		break;
dc0352ab0b2a0c drivers/pci/host/pci-mvebu.c       Russell King     2015-10-03  464  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  465  	default:
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  466  		return PCI_BRIDGE_EMUL_NOT_HANDLED;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  467  	}
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  468  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  469  	return PCI_BRIDGE_EMUL_HANDLED;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  470  }
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  471  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  472  static void
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  473  mvebu_pci_bridge_emul_base_conf_write(struct pci_bridge_emul *bridge,
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  474  				      int reg, u32 old, u32 new, u32 mask)
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  475  {
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  476  	struct mvebu_pcie_port *port = bridge->data;
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  477  	struct pci_bridge_emul_conf *conf = &bridge->conf;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  478  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  479  	switch (reg) {
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  480  	case PCI_COMMAND:
43a16f94445310 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  481  	{
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  482  		if (!mvebu_has_ioport(port))
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18 @483  			conf->command &= ~PCI_COMMAND_IO;
641e674d6c0f97 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  484  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  485  		if ((old ^ new) & PCI_COMMAND_IO)
43a16f94445310 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  486  			mvebu_pcie_handle_iobase_change(port);
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  487  		if ((old ^ new) & PCI_COMMAND_MEMORY)
43a16f94445310 drivers/pci/host/pci-mvebu.c       Jason Gunthorpe  2013-11-26  488  			mvebu_pcie_handle_membase_change(port);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  489  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  490  		break;
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  491  	}
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  492  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  493  	case PCI_IO_BASE:
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  494  		/*
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  495  		 * We keep bit 1 set, it is a read-only bit that
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  496  		 * indicates we support 32 bits addressing for the
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  497  		 * I/O
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  498  		 */
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  499  		conf->iobase |= PCI_IO_RANGE_TYPE_32;
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  500  		conf->iolimit |= PCI_IO_RANGE_TYPE_32;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  501  		mvebu_pcie_handle_iobase_change(port);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  502  		break;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  503  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  504  	case PCI_MEMORY_BASE:
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  505  		mvebu_pcie_handle_membase_change(port);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  506  		break;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  507  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  508  	case PCI_IO_BASE_UPPER16:
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  509  		mvebu_pcie_handle_iobase_change(port);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  510  		break;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  511  
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  512  	case PCI_PRIMARY_BUS:
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  513  		mvebu_pcie_set_local_bus_nr(port, conf->secondary_bus);
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  514  		break;
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  515  
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  516  	default:
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  517  		break;
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  518  	}
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  519  }
45361a4fe44641 drivers/pci/host/pci-mvebu.c       Thomas Petazzoni 2013-05-16  520  

:::::: The code at line 368 was first introduced by commit
:::::: 1f08673eef1236f7d02d93fcf596bb8531ef0d12 PCI: mvebu: Convert to PCI emulated bridge config space

:::::: TO: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--

Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D90C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861C7206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgFPFVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:21:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:3348 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgFPFVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:21:12 -0400
IronPort-SDR: Zz1tUF6ncUeg7mROrovWh6wzmWT5VSGreBI0PoxakhsMFLm7rxMClwO6rp75hL4N5jYVt5i7h0
 HqSnXIoA+oog==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 22:19:59 -0700
IronPort-SDR: MgXT46Mm4t5bsu6M2y+jiQOKXoIod2swdhVmnDpVlnSQFX+vKQ74pUrSIgH/8dGWDpATNEmHcp
 7Fb1eAE3XHPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="gz'50?scan'50,208,50";a="476301439"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2020 22:19:56 -0700
Date:   Tue, 16 Jun 2020 13:31:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/pci-mvebu.c:368:17: sparse: sparse:
 restricted __le16 degrades to integer
Message-ID: <20200616053121.GE23105@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f82e7b57b5fc48199e2f26ffafe2f96f7338ad3d
commit: e0d9d30b73548fbfe5c024ed630169bdc9a08aee PCI: pci-bridge-emul: Fix big-endian support
date:   8 months ago
:::::: branch date: 2 hours ago
:::::: commit date: 8 months ago
config: arm-randconfig-s032-20200613 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-250-g42323db3-dirty
        git checkout e0d9d30b73548fbfe5c024ed630169bdc9a08aee
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

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
git remote update linus
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
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  369  	    !(conf->command & PCI_COMMAND_IO)) {
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
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  389  			(conf->iobaseupper << 16);
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
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  406  	if (conf->memlimit < conf->membase ||
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  407  	    !(conf->command & PCI_COMMAND_MEMORY)) {
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
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  419  	desired.base = ((conf->membase & 0xFFF0) << 16);
1f08673eef1236 drivers/pci/controller/pci-mvebu.c Thomas Petazzoni 2018-10-18  420  	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
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

--kVXhAStRUZ/+rrGn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--kVXhAStRUZ/+rrGn--

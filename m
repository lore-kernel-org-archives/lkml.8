Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C3C22CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgHEJMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:12:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:33444 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgHEJLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:11:37 -0400
IronPort-SDR: 33T/d80uLFmPLSZg1zGQR0T4cm6RC4oXQau+jYRPyDvLaoi3xprGmtgqkpeiylUJIKtJS+HVOc
 J+X2u6GV2zlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132572227"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="132572227"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 01:56:32 -0700
IronPort-SDR: o82v6hZ/1WVR3PsaXHbNAzCpnLnvhWJ3/bVzo+KbOnAG2KghRPxAFLCHIGt2fN7z7+mEdzedho
 g1SOshPUopLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="276046438"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 05 Aug 2020 01:56:31 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3FDq-0000gb-Ln; Wed, 05 Aug 2020 08:56:30 +0000
Date:   Wed, 5 Aug 2020 16:55:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/usb/host/ohci-sm501.c:177:20: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202008051652.ODRiqcKY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da9f3302615f4191814f826054846bf843e24fa
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: openrisc-randconfig-s031-20200805 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/host/ohci-hcd.c: note: in included file:
>> drivers/usb/host/ohci-sm501.c:177:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *regs @@
   drivers/usb/host/ohci-sm501.c:177:20: sparse:     expected void *addr
>> drivers/usb/host/ohci-sm501.c:177:20: sparse:     got void [noderef] __iomem *regs
   drivers/usb/host/ohci-hcd.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
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
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]

vim +177 drivers/usb/host/ohci-sm501.c

f54aab6ebcecd9 Magnus Damm     2008-01-23   87  
f54aab6ebcecd9 Magnus Damm     2008-01-23   88  static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
f54aab6ebcecd9 Magnus Damm     2008-01-23   89  {
f54aab6ebcecd9 Magnus Damm     2008-01-23   90  	const struct hc_driver *driver = &ohci_sm501_hc_driver;
f54aab6ebcecd9 Magnus Damm     2008-01-23   91  	struct device *dev = &pdev->dev;
f54aab6ebcecd9 Magnus Damm     2008-01-23   92  	struct resource	*res, *mem;
f54aab6ebcecd9 Magnus Damm     2008-01-23   93  	int retval, irq;
af3d305ca71fea Harvey Harrison 2008-04-30   94  	struct usb_hcd *hcd = NULL;
f54aab6ebcecd9 Magnus Damm     2008-01-23   95  
f54aab6ebcecd9 Magnus Damm     2008-01-23   96  	irq = retval = platform_get_irq(pdev, 0);
f54aab6ebcecd9 Magnus Damm     2008-01-23   97  	if (retval < 0)
f54aab6ebcecd9 Magnus Damm     2008-01-23   98  		goto err0;
f54aab6ebcecd9 Magnus Damm     2008-01-23   99  
f54aab6ebcecd9 Magnus Damm     2008-01-23  100  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
f54aab6ebcecd9 Magnus Damm     2008-01-23  101  	if (mem == NULL) {
f54aab6ebcecd9 Magnus Damm     2008-01-23  102  		dev_err(dev, "no resource definition for memory\n");
f54aab6ebcecd9 Magnus Damm     2008-01-23  103  		retval = -ENOENT;
f54aab6ebcecd9 Magnus Damm     2008-01-23  104  		goto err0;
f54aab6ebcecd9 Magnus Damm     2008-01-23  105  	}
f54aab6ebcecd9 Magnus Damm     2008-01-23  106  
28f65c11f2ffb3 Joe Perches     2011-06-09  107  	if (!request_mem_region(mem->start, resource_size(mem), pdev->name)) {
f54aab6ebcecd9 Magnus Damm     2008-01-23  108  		dev_err(dev, "request_mem_region failed\n");
f54aab6ebcecd9 Magnus Damm     2008-01-23  109  		retval = -EBUSY;
f54aab6ebcecd9 Magnus Damm     2008-01-23  110  		goto err0;
f54aab6ebcecd9 Magnus Damm     2008-01-23  111  	}
f54aab6ebcecd9 Magnus Damm     2008-01-23  112  
f54aab6ebcecd9 Magnus Damm     2008-01-23  113  	/* allocate, reserve and remap resources for registers */
f54aab6ebcecd9 Magnus Damm     2008-01-23  114  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
f54aab6ebcecd9 Magnus Damm     2008-01-23  115  	if (res == NULL) {
f54aab6ebcecd9 Magnus Damm     2008-01-23  116  		dev_err(dev, "no resource definition for registers\n");
f54aab6ebcecd9 Magnus Damm     2008-01-23  117  		retval = -ENOENT;
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  118  		goto err1;
f54aab6ebcecd9 Magnus Damm     2008-01-23  119  	}
f54aab6ebcecd9 Magnus Damm     2008-01-23  120  
7071a3ce0ca058 Kay Sievers     2008-05-02  121  	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
f54aab6ebcecd9 Magnus Damm     2008-01-23  122  	if (!hcd) {
f54aab6ebcecd9 Magnus Damm     2008-01-23  123  		retval = -ENOMEM;
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  124  		goto err1;
f54aab6ebcecd9 Magnus Damm     2008-01-23  125  	}
f54aab6ebcecd9 Magnus Damm     2008-01-23  126  
f54aab6ebcecd9 Magnus Damm     2008-01-23  127  	hcd->rsrc_start = res->start;
28f65c11f2ffb3 Joe Perches     2011-06-09  128  	hcd->rsrc_len = resource_size(res);
f54aab6ebcecd9 Magnus Damm     2008-01-23  129  
f54aab6ebcecd9 Magnus Damm     2008-01-23  130  	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,	pdev->name)) {
f54aab6ebcecd9 Magnus Damm     2008-01-23  131  		dev_err(dev, "request_mem_region failed\n");
f54aab6ebcecd9 Magnus Damm     2008-01-23  132  		retval = -EBUSY;
f54aab6ebcecd9 Magnus Damm     2008-01-23  133  		goto err3;
f54aab6ebcecd9 Magnus Damm     2008-01-23  134  	}
f54aab6ebcecd9 Magnus Damm     2008-01-23  135  
f54aab6ebcecd9 Magnus Damm     2008-01-23  136  	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
f54aab6ebcecd9 Magnus Damm     2008-01-23  137  	if (hcd->regs == NULL) {
f54aab6ebcecd9 Magnus Damm     2008-01-23  138  		dev_err(dev, "cannot remap registers\n");
f54aab6ebcecd9 Magnus Damm     2008-01-23  139  		retval = -ENXIO;
f54aab6ebcecd9 Magnus Damm     2008-01-23  140  		goto err4;
f54aab6ebcecd9 Magnus Damm     2008-01-23  141  	}
f54aab6ebcecd9 Magnus Damm     2008-01-23  142  
f54aab6ebcecd9 Magnus Damm     2008-01-23  143  	ohci_hcd_init(hcd_to_ohci(hcd));
f54aab6ebcecd9 Magnus Damm     2008-01-23  144  
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  145  	/* The sm501 chip is equipped with local memory that may be used
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  146  	 * by on-chip devices such as the video controller and the usb host.
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  147  	 * This driver uses genalloc so that usb allocations with
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  148  	 * gen_pool_dma_alloc() allocate from this local memory. The dma_handle
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  149  	 * returned by gen_pool_dma_alloc() will be an offset starting from 0
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  150  	 * for the first local memory byte.
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  151  	 *
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  152  	 * So as long as data is allocated using gen_pool_dma_alloc() all is
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  153  	 * fine. This is however not always the case - buffers may be allocated
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  154  	 * using kmalloc() - so the usb core needs to be told that it must copy
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  155  	 * data into our local memory if the buffers happen to be placed in
2d7a3dc3e24f43 Laurentiu Tudor 2019-05-29  156  	 * regular memory. A non-null hcd->localmem_pool initialized by the
2d7a3dc3e24f43 Laurentiu Tudor 2019-05-29  157  	 * the call to usb_hcd_setup_local_mem() below does just that.
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  158  	 */
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  159  
b919e077cccfbb Wei Yongjun     2020-05-06  160  	retval = usb_hcd_setup_local_mem(hcd, mem->start,
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  161  					 mem->start - mem->parent->start,
b919e077cccfbb Wei Yongjun     2020-05-06  162  					 resource_size(mem));
b919e077cccfbb Wei Yongjun     2020-05-06  163  	if (retval < 0)
7d9e6f5aebe8c0 Laurentiu Tudor 2019-05-29  164  		goto err5;
b5dd18d8747010 Yong Zhang      2011-09-07  165  	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
f54aab6ebcecd9 Magnus Damm     2008-01-23  166  	if (retval)
637ed74ff9e86d Dan Carpenter   2010-09-10  167  		goto err5;
3c9740a117d40a Peter Chen      2013-11-05  168  	device_wakeup_enable(hcd->self.controller);
f54aab6ebcecd9 Magnus Damm     2008-01-23  169  
f54aab6ebcecd9 Magnus Damm     2008-01-23  170  	/* enable power and unmask interrupts */
f54aab6ebcecd9 Magnus Damm     2008-01-23  171  
f54aab6ebcecd9 Magnus Damm     2008-01-23  172  	sm501_unit_power(dev->parent, SM501_GATE_USB_HOST, 1);
f54aab6ebcecd9 Magnus Damm     2008-01-23  173  	sm501_modify_reg(dev->parent, SM501_IRQ_MASK, 1 << 6, 0);
f54aab6ebcecd9 Magnus Damm     2008-01-23  174  
f54aab6ebcecd9 Magnus Damm     2008-01-23  175  	return 0;
637ed74ff9e86d Dan Carpenter   2010-09-10  176  err5:
637ed74ff9e86d Dan Carpenter   2010-09-10 @177  	iounmap(hcd->regs);
f54aab6ebcecd9 Magnus Damm     2008-01-23  178  err4:
f54aab6ebcecd9 Magnus Damm     2008-01-23  179  	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
f54aab6ebcecd9 Magnus Damm     2008-01-23  180  err3:
f54aab6ebcecd9 Magnus Damm     2008-01-23  181  	usb_put_hcd(hcd);
f54aab6ebcecd9 Magnus Damm     2008-01-23  182  err1:
28f65c11f2ffb3 Joe Perches     2011-06-09  183  	release_mem_region(mem->start, resource_size(mem));
f54aab6ebcecd9 Magnus Damm     2008-01-23  184  err0:
f54aab6ebcecd9 Magnus Damm     2008-01-23  185  	return retval;
f54aab6ebcecd9 Magnus Damm     2008-01-23  186  }
f54aab6ebcecd9 Magnus Damm     2008-01-23  187  

:::::: The code at line 177 was first introduced by commit
:::::: 637ed74ff9e86d8c2979e430309a1fd28c921de9 USB: ohci-sm501: add iounmap on error path

:::::: TO: Dan Carpenter <error27@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tcFWhY/3mEDf9vwHSx2tmeQ2AQA=

--azLHFNyN32YCQGCU--

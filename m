Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939772086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHGVVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:21:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:1230 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGVVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:21:20 -0400
IronPort-SDR: H90B1hc3g5B/P0+bPo3sKT+L3ow+SbPmAQipZ3/97SnPv1Y8D5vwxRtizU+nLoVNAo/fuEVZd+
 nFWwEONcDUHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="214739789"
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="gz'50?scan'50,208,50";a="214739789"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 14:20:08 -0700
IronPort-SDR: oFeweXKvOXh1Pz1fZYsqxTR8Zo8+NlLgJ6BmIUiL/2Xsw++iD7Qxh7CoTNbiYKcWdgtL3IGcjC
 phB3hksZhoGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="gz'50?scan'50,208,50";a="333663311"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2020 14:20:05 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k49mW-0000Uk-Hf; Fri, 07 Aug 2020 21:20:04 +0000
Date:   Sat, 8 Aug 2020 05:19:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/udc/s3c-hsudc.c:783:47: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202008080536.5sKvDI0W%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5631c5e0eb9035d92ceb20fcd9cdb7779a3f5cc7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: arm-randconfig-s032-20200808 (attached as .config)
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

   drivers/usb/gadget/udc/s3c-hsudc.c:563:25: sparse: sparse: restricted __le16 degrades to integer
>> drivers/usb/gadget/udc/s3c-hsudc.c:783:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long volatile *addr @@     got void [noderef] __iomem * @@
   drivers/usb/gadget/udc/s3c-hsudc.c:783:47: sparse:     expected unsigned long volatile *addr
>> drivers/usb/gadget/udc/s3c-hsudc.c:783:47: sparse:     got void [noderef] __iomem *
   drivers/usb/gadget/udc/s3c-hsudc.c:808:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned long volatile *addr @@     got void [noderef] __iomem * @@
   drivers/usb/gadget/udc/s3c-hsudc.c:808:49: sparse:     expected unsigned long volatile *addr
   drivers/usb/gadget/udc/s3c-hsudc.c:808:49: sparse:     got void [noderef] __iomem *
--
   drivers/irqchip/irq-s3c24xx.c:359:39: sparse: sparse: symbol 's3c24xx_handle_irq' was not declared. Should it be static?
>> drivers/irqchip/irq-s3c24xx.c:522:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
>> drivers/irqchip/irq-s3c24xx.c:522:31: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-s3c24xx.c:522:31: sparse:     got void *
>> drivers/irqchip/irq-s3c24xx.c:566:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   drivers/irqchip/irq-s3c24xx.c:566:22: sparse:     expected void [noderef] __iomem *base
   drivers/irqchip/irq-s3c24xx.c:566:22: sparse:     got void *
   drivers/irqchip/irq-s3c24xx.c:1301:12: sparse: sparse: symbol 's3c2410_init_intc_of' was not declared. Should it be static?
   drivers/irqchip/irq-s3c24xx.c:1323:12: sparse: sparse: symbol 's3c2416_init_intc_of' was not declared. Should it be static?
--
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
>> drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:286:6: sparse: sparse: symbol 'qe_uart_set_mctrl' was not declared. Should it be static?
   drivers/tty/serial/ucc_uart.c:347:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:382:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const volatile [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const volatile [noderef] __iomem *

vim +783 drivers/usb/gadget/udc/s3c-hsudc.c

a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  738  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  739  /**
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  740   * s3c_hsudc_ep_enable - Enable a endpoint.
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  741   * @_ep: The endpoint to be enabled.
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  742   * @desc: Endpoint descriptor.
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  743   *
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  744   * Enables a endpoint when called from the gadget driver. Endpoint stall if
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  745   * any is cleared, transfer type is configured and endpoint interrupt is
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  746   * enabled.
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  747   */
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  748  static int s3c_hsudc_ep_enable(struct usb_ep *_ep,
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  749  				const struct usb_endpoint_descriptor *desc)
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  750  {
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  751  	struct s3c_hsudc_ep *hsep;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  752  	struct s3c_hsudc *hsudc;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  753  	unsigned long flags;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  754  	u32 ecr = 0;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  755  
2d4172c938745c drivers/usb/gadget/s3c-hsudc.c Heiko Stübner     2012-01-08  756  	hsep = our_ep(_ep);
109f0f718375e1 drivers/usb/gadget/s3c-hsudc.c Ido Shayevitz     2012-06-04  757  	if (!_ep || !desc || _ep->name == ep0name
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  758  		|| desc->bDescriptorType != USB_DT_ENDPOINT
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  759  		|| hsep->bEndpointAddress != desc->bEndpointAddress
29cc88979a8818 drivers/usb/gadget/s3c-hsudc.c Kuninori Morimoto 2011-08-23  760  		|| ep_maxpacket(hsep) < usb_endpoint_maxp(desc))
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  761  		return -EINVAL;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  762  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  763  	if ((desc->bmAttributes == USB_ENDPOINT_XFER_BULK
29cc88979a8818 drivers/usb/gadget/s3c-hsudc.c Kuninori Morimoto 2011-08-23  764  		&& usb_endpoint_maxp(desc) != ep_maxpacket(hsep))
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  765  		|| !desc->wMaxPacketSize)
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  766  		return -ERANGE;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  767  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  768  	hsudc = hsep->dev;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  769  	if (!hsudc->driver || hsudc->gadget.speed == USB_SPEED_UNKNOWN)
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  770  		return -ESHUTDOWN;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  771  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  772  	spin_lock_irqsave(&hsudc->lock, flags);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  773  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  774  	set_index(hsudc, hsep->bEndpointAddress);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  775  	ecr |= ((usb_endpoint_xfer_int(desc)) ? S3C_ECR_IEMS : S3C_ECR_DUEN);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  776  	writel(ecr, hsudc->regs + S3C_ECR);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  777  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  778  	hsep->stopped = hsep->wedge = 0;
955846a60a9db8 drivers/usb/gadget/s3c-hsudc.c Ido Shayevitz     2012-03-12  779  	hsep->ep.desc = desc;
29cc88979a8818 drivers/usb/gadget/s3c-hsudc.c Kuninori Morimoto 2011-08-23  780  	hsep->ep.maxpacket = usb_endpoint_maxp(desc);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  781  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  782  	s3c_hsudc_set_halt(_ep, 0);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07 @783  	__set_bit(ep_index(hsep), hsudc->regs + S3C_EIER);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  784  
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  785  	spin_unlock_irqrestore(&hsudc->lock, flags);
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  786  	return 0;
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  787  }
a9df304cf78d76 drivers/usb/gadget/s3c-hsudc.c Thomas Abraham    2011-05-07  788  

:::::: The code at line 783 was first introduced by commit
:::::: a9df304cf78d76108196da1ff1dad4d9a5737c2e USB: Gadget: Add Samsung S3C24XX USB High-Speed controller driver

:::::: TO: Thomas Abraham <thomas.ab@samsung.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
hIEBAA==

--PEIAKu/WMn1b1Hv9--

Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D387EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9322A20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGHORC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:17:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:21153 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbgGHORB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:17:01 -0400
IronPort-SDR: QH1Aux4CAMsH9y5nAzKwFJvNw0soupD+dQMkDKXhz9izGYlQ8qdYO1RPHQu50E3AWdOMtbG3fA
 /9AnLZGBQ9cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135260824"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="gz'50?scan'50,208,50";a="135260824"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 07:16:17 -0700
IronPort-SDR: 3TC6j4ubH49xsP1zB6Qu2jcVYnWWX58Dn/YFI/yt0740dmJ3AaEXiM8eGHjuFBcVnOaML4tuq3
 4etHSXisezmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="gz'50?scan'50,208,50";a="457518286"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 07:16:15 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtAru-00009M-Ut; Wed, 08 Jul 2020 14:16:14 +0000
Date:   Wed, 8 Jul 2020 22:15:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/pci/controller/pci-xgene.c:512:26: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202007082213.gT8ON0Sf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcde237b9b0eb1d19306e6f48c0a4e058907619f
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: arm64-randconfig-s031-20200708 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pci-xgene.c:512:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *bar_addr @@     got void [noderef] __iomem * @@
   drivers/pci/controller/pci-xgene.c:512:26: sparse:     expected void *bar_addr
>> drivers/pci/controller/pci-xgene.c:512:26: sparse:     got void [noderef] __iomem *
>> drivers/pci/controller/pci-xgene.c:513:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *bar_addr @@
>> drivers/pci/controller/pci-xgene.c:513:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/pci/controller/pci-xgene.c:513:17: sparse:     got void *bar_addr
>> drivers/pci/controller/pci-xgene.c:514:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/pci/controller/pci-xgene.c:514:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/pci/controller/pci-xgene.c:514:17: sparse:     got void *
--
   drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:286:6: sparse: sparse: symbol 'qe_uart_set_mctrl' was not declared. Should it be static?
   drivers/tty/serial/ucc_uart.c:347:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:382:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:604:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:605:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:606:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:612:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:613:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:614:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:625:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:626:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:627:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:637:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:638:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:639:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:653:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] __iomem *uccup @@
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     got struct ucc_uart_pram [noderef] __iomem *uccup
>> drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:662:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:663:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:664:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:665:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:665:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:666:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:666:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:667:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:667:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:667:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:668:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:668:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:668:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:669:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:669:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:669:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:670:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:670:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:670:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:671:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:671:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:671:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:672:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:672:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:672:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:674:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:674:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:674:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:675:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:675:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:713:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:713:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:713:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:714:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:714:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:714:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:715:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:715:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:715:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:716:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:716:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:716:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:717:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:717:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:718:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:718:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:719:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:719:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:720:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:720:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:721:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:721:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:721:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:722:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:722:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:722:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:724:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:724:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:724:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:726:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:726:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:726:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:727:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:727:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:727:17: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:728:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:728:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:728:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:1000:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ucc_uart.c:1000:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ucc_uart_pram [noderef] __iomem *uccup @@     got struct ucc_uart_pram * @@
   drivers/tty/serial/ucc_uart.c:1000:24: sparse:     expected struct ucc_uart_pram [noderef] __iomem *uccup
   drivers/tty/serial/ucc_uart.c:1000:24: sparse:     got struct ucc_uart_pram *
   drivers/tty/serial/ucc_uart.c:1001:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd *rx_bd_base @@     got struct qe_bd [noderef] __iomem *rx_bd @@
   drivers/tty/serial/ucc_uart.c:1001:29: sparse:     expected struct qe_bd *rx_bd_base
   drivers/tty/serial/ucc_uart.c:1001:29: sparse:     got struct qe_bd [noderef] __iomem *rx_bd
   drivers/tty/serial/ucc_uart.c:1002:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd *tx_bd_base @@     got struct qe_bd [noderef] __iomem *tx_bd @@
   drivers/tty/serial/ucc_uart.c:1002:29: sparse:     expected struct qe_bd *tx_bd_base
   drivers/tty/serial/ucc_uart.c:1002:29: sparse:     got struct qe_bd [noderef] __iomem *tx_bd

vim +512 drivers/pci/controller/pci-xgene.c

5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  482  
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  483  static void xgene_pcie_setup_ib_reg(struct xgene_pcie_port *port,
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  484  				    struct resource_entry *entry,
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  485  				    u8 *ib_reg_mask)
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  486  {
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  487  	void __iomem *cfg_base = port->cfg_base;
d963ab22ad32da drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  488  	struct device *dev = port->dev;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  489  	void *bar_addr;
4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  490  	u32 pim_reg;
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  491  	u64 cpu_addr = entry->res->start;
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  492  	u64 pci_addr = cpu_addr - entry->offset;
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  493  	u64 size = resource_size(entry->res);
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  494  	u64 mask = ~(size - 1) | EN_REG;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  495  	u32 flags = PCI_BASE_ADDRESS_MEM_TYPE_64;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  496  	u32 bar_low;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  497  	int region;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  498  
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  499  	region = xgene_pcie_select_ib_reg(ib_reg_mask, size);
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  500  	if (region < 0) {
d963ab22ad32da drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  501  		dev_warn(dev, "invalid pcie dma-range config\n");
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  502  		return;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  503  	}
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  504  
6dce5aa59e0bf2 drivers/pci/controller/pci-xgene.c Rob Herring    2019-10-28  505  	if (entry->res->flags & IORESOURCE_PREFETCH)
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  506  		flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  507  
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  508  	bar_low = pcie_bar_low_val((u32)cpu_addr, flags);
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  509  	switch (region) {
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  510  	case 0:
4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  511  		xgene_pcie_set_ib_mask(port, BRIDGE_CFG_4, flags, size);
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01 @512  		bar_addr = cfg_base + PCI_BASE_ADDRESS_0;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01 @513  		writel(bar_low, bar_addr);
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01 @514  		writel(upper_32_bits(cpu_addr), bar_addr + 0x4);
4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  515  		pim_reg = PIM1_1L;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  516  		break;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  517  	case 1:
8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  518  		xgene_pcie_writel(port, IBAR2, bar_low);
8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  519  		xgene_pcie_writel(port, IR2MSK, lower_32_bits(mask));
4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  520  		pim_reg = PIM2_1L;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  521  		break;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  522  	case 2:
8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  523  		xgene_pcie_writel(port, IBAR3L, bar_low);
8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  524  		xgene_pcie_writel(port, IBAR3L + 0x4, upper_32_bits(cpu_addr));
8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  525  		xgene_pcie_writel(port, IR3MSKL, lower_32_bits(mask));
8e93c5132ca2e5 drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  526  		xgene_pcie_writel(port, IR3MSKL + 0x4, upper_32_bits(mask));
4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  527  		pim_reg = PIM3_1L;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  528  		break;
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  529  	}
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  530  
4ecf6b0f83523f drivers/pci/host/pci-xgene.c       Bjorn Helgaas  2016-10-06  531  	xgene_pcie_setup_pims(port, pim_reg, pci_addr, ~(size - 1));
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  532  }
5f6b6ccdbe1cdf drivers/pci/host/pci-xgene.c       Tanmay Inamdar 2014-10-01  533  

:::::: The code at line 512 was first introduced by commit
:::::: 5f6b6ccdbe1cdfa5aa4347ec5412509b8995db27 PCI: xgene: Add APM X-Gene PCIe driver

:::::: TO: Tanmay Inamdar <tinamdar@apm.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
q0mhFeW0sXvuP+kYPYGzBwIA

--NzB8fVQJ5HfG6fxh--

Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732AC2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 15:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHVPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 11:03:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:64686 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHVPDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 11:03:03 -0400
IronPort-SDR: bfpu5dr1AhywsIN93EDvo3gOVDO51iMxuXRPG9QCLN8+pqRAWTi4PxCsG/gwmDFPieT3N+tiUc
 hQMve1GNduvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="219984488"
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="gz'50?scan'50,208,50";a="219984488"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 08:01:56 -0700
IronPort-SDR: JqpsWka0L3MXTbQsP8MIbn4P9oKnITY7RqeDzUrf5H3tTFr+87DwaWxxamHhRi4hqBsQCfHUIH
 pWuR3AQGs0Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="gz'50?scan'50,208,50";a="498273272"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2020 08:01:54 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9V1l-0001n9-IP; Sat, 22 Aug 2020 15:01:53 +0000
Date:   Sat, 22 Aug 2020 23:01:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/staging/comedi/drivers/addi_apci_3120.c:164:9: sparse:
 sparse: cast removes address space '__iomem' of expression
Message-ID: <202008222356.zLxgCD2G%lkp@intel.com>
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
head:   f873db9acd3c92d4741bc3676c9eb511b2f9a6f6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: riscv-randconfig-s032-20200822 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/comedi/drivers/addi_apci_3120.c:164:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_3120.c:164:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_3120.c:164:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:164:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:165:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:165:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:165:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:165:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:167:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:168:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:168:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:168:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:168:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:177:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:177:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:177:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:185:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:185:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:185:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:185:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:195:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:195:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:195:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:195:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:199:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:199:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:199:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:199:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:310:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_3120.c:310:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_3120.c:310:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:310:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:319:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:319:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:319:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:319:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:322:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:322:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:322:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:322:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:326:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:326:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:326:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:326:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:329:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:329:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:329:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:329:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:340:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:340:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:340:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:340:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:343:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:343:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:343:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:343:15: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:347:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:347:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:347:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:347:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:350:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:350:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:350:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:350:25: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:363:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:363:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:363:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:375:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:375:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:375:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:375:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:386:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:386:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:386:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:386:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:409:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:409:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:409:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:409:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:413:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:413:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:413:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:413:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:417:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:417:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:417:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:417:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:436:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:436:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:436:37: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:436:37: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:479:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:479:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:479:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:479:18: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:480:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:480:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:480:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:480:20: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:488:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:488:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:488:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:488:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:504:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:504:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:504:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:504:31: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:509:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:509:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:509:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:509:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:522:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:522:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:522:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:522:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:548:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:548:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:548:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:548:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:583:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:583:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:583:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:583:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:668:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:668:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:668:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3120.c:668:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3120.c:674:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3120.c:674:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3120.c:674:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/ke_counter.c:54:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ke_counter.c:54:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ke_counter.c:54:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:54:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:55:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:55:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:55:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:55:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:56:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:56:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:56:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:56:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:57:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:57:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:57:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:57:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:74:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ke_counter.c:74:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ke_counter.c:74:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:74:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:76:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:76:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:76:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:76:23: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:77:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:77:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:77:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:77:25: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:78:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:78:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:78:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:78:25: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:79:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:79:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:79:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:79:25: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:92:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:92:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:92:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:92:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:117:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:117:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:117:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:117:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:120:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:120:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:120:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:120:23: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:154:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:154:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:154:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:154:17: sparse:     got void *
   drivers/staging/comedi/drivers/ke_counter.c:195:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ke_counter.c:195:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ke_counter.c:195:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ke_counter.c:195:9: sparse:     got void *

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +/__iomem +164 drivers/staging/comedi/drivers/addi_apci_3120.c

4e068bec48c6c2 H Hartley Sweeten 2014-10-14  156  
0b7defa70227f7 H Hartley Sweeten 2014-11-04  157  static void apci3120_addon_write(struct comedi_device *dev,
0b7defa70227f7 H Hartley Sweeten 2014-11-04  158  				 unsigned int val, unsigned int reg)
0b7defa70227f7 H Hartley Sweeten 2014-11-04  159  {
0b7defa70227f7 H Hartley Sweeten 2014-11-04  160  	struct apci3120_private *devpriv = dev->private;
0b7defa70227f7 H Hartley Sweeten 2014-11-04  161  
0b7defa70227f7 H Hartley Sweeten 2014-11-04  162  	/* 16-bit interface for AMCC add-on registers */
0b7defa70227f7 H Hartley Sweeten 2014-11-04  163  
0b7defa70227f7 H Hartley Sweeten 2014-11-04 @164  	outw(reg, devpriv->addon + APCI3120_ADDON_ADDR_REG);
0b7defa70227f7 H Hartley Sweeten 2014-11-04  165  	outw(val & 0xffff, devpriv->addon + APCI3120_ADDON_DATA_REG);
0b7defa70227f7 H Hartley Sweeten 2014-11-04  166  
0b7defa70227f7 H Hartley Sweeten 2014-11-04  167  	outw(reg + 2, devpriv->addon + APCI3120_ADDON_ADDR_REG);
0b7defa70227f7 H Hartley Sweeten 2014-11-04  168  	outw((val >> 16) & 0xffff, devpriv->addon + APCI3120_ADDON_DATA_REG);
0b7defa70227f7 H Hartley Sweeten 2014-11-04  169  }
0b7defa70227f7 H Hartley Sweeten 2014-11-04  170  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  171  static void apci3120_init_dma(struct comedi_device *dev,
ee844c51ef0451 H Hartley Sweeten 2014-11-04  172  			      struct apci3120_dmabuf *dmabuf)
ee844c51ef0451 H Hartley Sweeten 2014-11-04  173  {
ee844c51ef0451 H Hartley Sweeten 2014-11-04  174  	struct apci3120_private *devpriv = dev->private;
ee844c51ef0451 H Hartley Sweeten 2014-11-04  175  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  176  	/* AMCC - enable transfer count and reset A2P FIFO */
ee844c51ef0451 H Hartley Sweeten 2014-11-04  177  	outl(AGCSTS_TC_ENABLE | AGCSTS_RESET_A2P_FIFO,
ee844c51ef0451 H Hartley Sweeten 2014-11-04  178  	     devpriv->amcc + AMCC_OP_REG_AGCSTS);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  179  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  180  	/* Add-On - enable transfer count and reset A2P FIFO */
ee844c51ef0451 H Hartley Sweeten 2014-11-04  181  	apci3120_addon_write(dev, AGCSTS_TC_ENABLE | AGCSTS_RESET_A2P_FIFO,
ee844c51ef0451 H Hartley Sweeten 2014-11-04  182  			     AMCC_OP_REG_AGCSTS);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  183  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  184  	/* AMCC - enable transfers and reset A2P flags */
ee844c51ef0451 H Hartley Sweeten 2014-11-04  185  	outl(RESET_A2P_FLAGS | EN_A2P_TRANSFERS,
ee844c51ef0451 H Hartley Sweeten 2014-11-04  186  	     devpriv->amcc + AMCC_OP_REG_MCSR);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  187  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  188  	/* Add-On - DMA start address */
ee844c51ef0451 H Hartley Sweeten 2014-11-04  189  	apci3120_addon_write(dev, dmabuf->hw, AMCC_OP_REG_AMWAR);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  190  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  191  	/* Add-On - Number of acquisitions */
ee844c51ef0451 H Hartley Sweeten 2014-11-04  192  	apci3120_addon_write(dev, dmabuf->use_size, AMCC_OP_REG_AMWTC);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  193  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  194  	/* AMCC - enable write complete (DMA) and set FIFO advance */
ee844c51ef0451 H Hartley Sweeten 2014-11-04 @195  	outl(APCI3120_FIFO_ADVANCE_ON_BYTE_2 | AINT_WRITE_COMPL,
ee844c51ef0451 H Hartley Sweeten 2014-11-04  196  	     devpriv->amcc + AMCC_OP_REG_INTCSR);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  197  
ee844c51ef0451 H Hartley Sweeten 2014-11-04  198  	/* Add-On - enable DMA */
ee844c51ef0451 H Hartley Sweeten 2014-11-04  199  	outw(APCI3120_ADDON_CTRL_AMWEN_ENA | APCI3120_ADDON_CTRL_A2P_FIFO_ENA,
ee844c51ef0451 H Hartley Sweeten 2014-11-04  200  	     devpriv->addon + APCI3120_ADDON_CTRL_REG);
ee844c51ef0451 H Hartley Sweeten 2014-11-04  201  }
ee844c51ef0451 H Hartley Sweeten 2014-11-04  202  
45062492281d2c H Hartley Sweeten 2014-11-04  203  static void apci3120_setup_dma(struct comedi_device *dev,
45062492281d2c H Hartley Sweeten 2014-11-04  204  			       struct comedi_subdevice *s)
45062492281d2c H Hartley Sweeten 2014-11-04  205  {
45062492281d2c H Hartley Sweeten 2014-11-04  206  	struct apci3120_private *devpriv = dev->private;
45062492281d2c H Hartley Sweeten 2014-11-04  207  	struct comedi_cmd *cmd = &s->async->cmd;
45062492281d2c H Hartley Sweeten 2014-11-04  208  	struct apci3120_dmabuf *dmabuf0 = &devpriv->dmabuf[0];
45062492281d2c H Hartley Sweeten 2014-11-04  209  	struct apci3120_dmabuf *dmabuf1 = &devpriv->dmabuf[1];
45062492281d2c H Hartley Sweeten 2014-11-04  210  	unsigned int dmalen0 = dmabuf0->size;
45062492281d2c H Hartley Sweeten 2014-11-04  211  	unsigned int dmalen1 = dmabuf1->size;
45062492281d2c H Hartley Sweeten 2014-11-04  212  	unsigned int scan_bytes;
45062492281d2c H Hartley Sweeten 2014-11-04  213  
45062492281d2c H Hartley Sweeten 2014-11-04  214  	scan_bytes = comedi_samples_to_bytes(s, cmd->scan_end_arg);
45062492281d2c H Hartley Sweeten 2014-11-04  215  
45062492281d2c H Hartley Sweeten 2014-11-04  216  	if (cmd->stop_src == TRIG_COUNT) {
45062492281d2c H Hartley Sweeten 2014-11-04  217  		/*
45062492281d2c H Hartley Sweeten 2014-11-04  218  		 * Must we fill full first buffer? And must we fill
45062492281d2c H Hartley Sweeten 2014-11-04  219  		 * full second buffer when first is once filled?
45062492281d2c H Hartley Sweeten 2014-11-04  220  		 */
45062492281d2c H Hartley Sweeten 2014-11-04  221  		if (dmalen0 > (cmd->stop_arg * scan_bytes))
45062492281d2c H Hartley Sweeten 2014-11-04  222  			dmalen0 = cmd->stop_arg * scan_bytes;
45062492281d2c H Hartley Sweeten 2014-11-04  223  		else if (dmalen1 > (cmd->stop_arg * scan_bytes - dmalen0))
45062492281d2c H Hartley Sweeten 2014-11-04  224  			dmalen1 = cmd->stop_arg * scan_bytes - dmalen0;
45062492281d2c H Hartley Sweeten 2014-11-04  225  	}
45062492281d2c H Hartley Sweeten 2014-11-04  226  
45062492281d2c H Hartley Sweeten 2014-11-04  227  	if (cmd->flags & CMDF_WAKE_EOS) {
45062492281d2c H Hartley Sweeten 2014-11-04  228  		/* don't we want wake up every scan? */
45062492281d2c H Hartley Sweeten 2014-11-04  229  		if (dmalen0 > scan_bytes) {
45062492281d2c H Hartley Sweeten 2014-11-04  230  			dmalen0 = scan_bytes;
45062492281d2c H Hartley Sweeten 2014-11-04  231  			if (cmd->scan_end_arg & 1)
45062492281d2c H Hartley Sweeten 2014-11-04  232  				dmalen0 += 2;
45062492281d2c H Hartley Sweeten 2014-11-04  233  		}
45062492281d2c H Hartley Sweeten 2014-11-04  234  		if (dmalen1 > scan_bytes) {
45062492281d2c H Hartley Sweeten 2014-11-04  235  			dmalen1 = scan_bytes;
45062492281d2c H Hartley Sweeten 2014-11-04  236  			if (cmd->scan_end_arg & 1)
45062492281d2c H Hartley Sweeten 2014-11-04  237  				dmalen1 -= 2;
45062492281d2c H Hartley Sweeten 2014-11-04  238  			if (dmalen1 < 4)
45062492281d2c H Hartley Sweeten 2014-11-04  239  				dmalen1 = 4;
45062492281d2c H Hartley Sweeten 2014-11-04  240  		}
45062492281d2c H Hartley Sweeten 2014-11-04  241  	} else {
45062492281d2c H Hartley Sweeten 2014-11-04  242  		/* isn't output buff smaller that our DMA buff? */
45062492281d2c H Hartley Sweeten 2014-11-04  243  		if (dmalen0 > s->async->prealloc_bufsz)
45062492281d2c H Hartley Sweeten 2014-11-04  244  			dmalen0 = s->async->prealloc_bufsz;
45062492281d2c H Hartley Sweeten 2014-11-04  245  		if (dmalen1 > s->async->prealloc_bufsz)
45062492281d2c H Hartley Sweeten 2014-11-04  246  			dmalen1 = s->async->prealloc_bufsz;
45062492281d2c H Hartley Sweeten 2014-11-04  247  	}
45062492281d2c H Hartley Sweeten 2014-11-04  248  	dmabuf0->use_size = dmalen0;
45062492281d2c H Hartley Sweeten 2014-11-04  249  	dmabuf1->use_size = dmalen1;
45062492281d2c H Hartley Sweeten 2014-11-04  250  
45062492281d2c H Hartley Sweeten 2014-11-04  251  	apci3120_init_dma(dev, dmabuf0);
45062492281d2c H Hartley Sweeten 2014-11-04  252  }
45062492281d2c H Hartley Sweeten 2014-11-04  253  
546bf3382e41b8 H Hartley Sweeten 2014-11-04  254  /*
546bf3382e41b8 H Hartley Sweeten 2014-11-04  255   * There are three timers on the board. They all use the same base
546bf3382e41b8 H Hartley Sweeten 2014-11-04  256   * clock with a fixed prescaler for each timer. The base clock used
546bf3382e41b8 H Hartley Sweeten 2014-11-04  257   * depends on the board version and type.
546bf3382e41b8 H Hartley Sweeten 2014-11-04  258   *
546bf3382e41b8 H Hartley Sweeten 2014-11-04  259   * APCI-3120 Rev A boards OSC = 14.29MHz base clock (~70ns)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  260   * APCI-3120 Rev B boards OSC = 20MHz base clock (50ns)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  261   * APCI-3001 boards OSC = 20MHz base clock (50ns)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  262   *
546bf3382e41b8 H Hartley Sweeten 2014-11-04  263   * The prescalers for each timer are:
546bf3382e41b8 H Hartley Sweeten 2014-11-04  264   * Timer 0 CLK = OSC/10
546bf3382e41b8 H Hartley Sweeten 2014-11-04  265   * Timer 1 CLK = OSC/1000
546bf3382e41b8 H Hartley Sweeten 2014-11-04  266   * Timer 2 CLK = OSC/1000
546bf3382e41b8 H Hartley Sweeten 2014-11-04  267   */
546bf3382e41b8 H Hartley Sweeten 2014-11-04  268  static unsigned int apci3120_ns_to_timer(struct comedi_device *dev,
546bf3382e41b8 H Hartley Sweeten 2014-11-04  269  					 unsigned int timer,
546bf3382e41b8 H Hartley Sweeten 2014-11-04  270  					 unsigned int ns,
546bf3382e41b8 H Hartley Sweeten 2014-11-04  271  					 unsigned int flags)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  272  {
546bf3382e41b8 H Hartley Sweeten 2014-11-04  273  	struct apci3120_private *devpriv = dev->private;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  274  	unsigned int prescale = (timer == 0) ? 10 : 1000;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  275  	unsigned int timer_base = devpriv->osc_base * prescale;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  276  	unsigned int divisor;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  277  
546bf3382e41b8 H Hartley Sweeten 2014-11-04  278  	switch (flags & CMDF_ROUND_MASK) {
546bf3382e41b8 H Hartley Sweeten 2014-11-04  279  	case CMDF_ROUND_UP:
546bf3382e41b8 H Hartley Sweeten 2014-11-04  280  		divisor = DIV_ROUND_UP(ns, timer_base);
546bf3382e41b8 H Hartley Sweeten 2014-11-04  281  		break;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  282  	case CMDF_ROUND_DOWN:
546bf3382e41b8 H Hartley Sweeten 2014-11-04  283  		divisor = ns / timer_base;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  284  		break;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  285  	case CMDF_ROUND_NEAREST:
546bf3382e41b8 H Hartley Sweeten 2014-11-04  286  	default:
546bf3382e41b8 H Hartley Sweeten 2014-11-04  287  		divisor = DIV_ROUND_CLOSEST(ns, timer_base);
546bf3382e41b8 H Hartley Sweeten 2014-11-04  288  		break;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  289  	}
546bf3382e41b8 H Hartley Sweeten 2014-11-04  290  
546bf3382e41b8 H Hartley Sweeten 2014-11-04  291  	if (timer == 2) {
546bf3382e41b8 H Hartley Sweeten 2014-11-04  292  		/* timer 2 is 24-bits */
546bf3382e41b8 H Hartley Sweeten 2014-11-04  293  		if (divisor > 0x00ffffff)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  294  			divisor = 0x00ffffff;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  295  	} else {
546bf3382e41b8 H Hartley Sweeten 2014-11-04  296  		/* timers 0 and 1 are 16-bits */
546bf3382e41b8 H Hartley Sweeten 2014-11-04  297  		if (divisor > 0xffff)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  298  			divisor = 0xffff;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  299  	}
546bf3382e41b8 H Hartley Sweeten 2014-11-04  300  	/* the timers require a minimum divisor of 2 */
546bf3382e41b8 H Hartley Sweeten 2014-11-04  301  	if (divisor < 2)
546bf3382e41b8 H Hartley Sweeten 2014-11-04  302  		divisor = 2;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  303  
546bf3382e41b8 H Hartley Sweeten 2014-11-04  304  	return divisor;
546bf3382e41b8 H Hartley Sweeten 2014-11-04  305  }
546bf3382e41b8 H Hartley Sweeten 2014-11-04  306  
24e18c85e57255 H Hartley Sweeten 2014-11-04  307  static void apci3120_clr_timer2_interrupt(struct comedi_device *dev)
24e18c85e57255 H Hartley Sweeten 2014-11-04  308  {
24e18c85e57255 H Hartley Sweeten 2014-11-04  309  	/* a dummy read of APCI3120_CTR0_REG clears the timer 2 interrupt */
24e18c85e57255 H Hartley Sweeten 2014-11-04 @310  	inb(dev->iobase + APCI3120_CTR0_REG);
24e18c85e57255 H Hartley Sweeten 2014-11-04  311  }
24e18c85e57255 H Hartley Sweeten 2014-11-04  312  

:::::: The code at line 164 was first introduced by commit
:::::: 0b7defa70227f7c7f313e0ea4f0eeb88c5de79a3 staging: comedi: addi_apci_3120: move apci3120_addon_write() to driver

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--

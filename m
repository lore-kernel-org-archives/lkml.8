Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F0CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EDF2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHEJa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:30:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:11767 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgHEJ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:29:26 -0400
IronPort-SDR: wS6kFqPttC5+XEbk0jrL1RSeNoaPCV6kelflVE7ET7rm+dfLIATF9iOIBhlqdqG5AQnaO/q1ru
 m6X5aMIRTyUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153645632"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="153645632"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 02:01:43 -0700
IronPort-SDR: 6gkL9QGOflUVkXlcD0gyWi9npz7qEjT+JrfkODnBOPvqwL8sebnOCB3bP4RdiHuik92JUaWfM1
 hBwasMfzjKcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="292876425"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2020 02:01:41 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3FIq-0000gq-Hw; Wed, 05 Aug 2020 09:01:40 +0000
Date:   Wed, 5 Aug 2020 17:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/hwmon/pc87427.c:188:9: sparse: sparse: cast removes address
 space '__iomem' of expression
Message-ID: <202008051700.I1pIeGva%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da9f3302615f4191814f826054846bf843e24fa
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: riscv-randconfig-s032-20200805 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/hwmon/pc87427.c:188:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/pc87427.c:188:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/pc87427.c:188:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:188:9: sparse:     got void *
   drivers/hwmon/pc87427.c:189:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/pc87427.c:189:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/pc87427.c:189:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:189:25: sparse:     got void *
   drivers/hwmon/pc87427.c:190:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:190:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:190:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:190:29: sparse:     got void *
   drivers/hwmon/pc87427.c:191:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:191:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:191:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:191:32: sparse:     got void *
   drivers/hwmon/pc87427.c:193:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:193:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:193:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:193:9: sparse:     got void *
   drivers/hwmon/pc87427.c:243:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:243:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:243:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:243:9: sparse:     got void *
   drivers/hwmon/pc87427.c:244:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:244:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:244:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:244:32: sparse:     got void *
   drivers/hwmon/pc87427.c:245:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:245:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:245:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:245:25: sparse:     got void *
   drivers/hwmon/pc87427.c:307:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:307:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:307:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:307:9: sparse:     got void *
   drivers/hwmon/pc87427.c:308:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:308:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:308:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:308:26: sparse:     got void *
   drivers/hwmon/pc87427.c:308:26: sparse: sparse: cast to restricted __le16
   drivers/hwmon/pc87427.c:309:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:309:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:309:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:309:30: sparse:     got void *
   drivers/hwmon/pc87427.c:310:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:310:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:310:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:310:30: sparse:     got void *
   drivers/hwmon/pc87427.c:311:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:311:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:311:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:311:31: sparse:     got void *
   drivers/hwmon/pc87427.c:312:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:312:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:312:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:312:31: sparse:     got void *
   drivers/hwmon/pc87427.c:313:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:313:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:313:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:313:33: sparse:     got void *
   drivers/hwmon/pc87427.c:315:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:315:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:315:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:315:9: sparse:     got void *
   drivers/hwmon/pc87427.c:438:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:438:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:438:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:438:9: sparse:     got void *
   drivers/hwmon/pc87427.c:444:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:444:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:444:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:444:9: sparse:     got void *
   drivers/hwmon/pc87427.c:446:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:446:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:446:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:446:9: sparse:     got void *
   drivers/hwmon/pc87427.c:447:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:447:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:447:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:447:9: sparse:     got void *
   drivers/hwmon/pc87427.c:561:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:561:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:561:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:561:9: sparse:     got void *
   drivers/hwmon/pc87427.c:648:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:648:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:648:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:648:17: sparse:     got void *
   drivers/hwmon/pc87427.c:146:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:146:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:146:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:146:16: sparse:     got void *
   drivers/hwmon/pc87427.c:153:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:153:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:153:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:153:9: sparse:     got void *
   drivers/hwmon/pc87427.c:154:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:154:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:154:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:154:16: sparse:     got void *
   drivers/hwmon/pc87427.c:161:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:161:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/pc87427.c:161:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/pc87427.c:161:9: sparse:     got void *
   drivers/hwmon/pc87427.c:162:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/pc87427.c:162:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
--
>> drivers/net/can/sja1000/sja1000_isa.c:82:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/can/sja1000/sja1000_isa.c:82:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/can/sja1000/sja1000_isa.c:82:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/can/sja1000/sja1000_isa.c:82:16: sparse:     got void *
   drivers/net/can/sja1000/sja1000_isa.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/can/sja1000/sja1000_isa.c:88:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/can/sja1000/sja1000_isa.c:88:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/sja1000/sja1000_isa.c:88:9: sparse:     got void *
   drivers/net/can/sja1000/sja1000_isa.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/sja1000/sja1000_isa.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/sja1000/sja1000_isa.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/sja1000/sja1000_isa.c:98:9: sparse:     got void *
   drivers/net/can/sja1000/sja1000_isa.c:99:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/sja1000/sja1000_isa.c:99:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/sja1000/sja1000_isa.c:99:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/can/sja1000/sja1000_isa.c:99:19: sparse:     got void *
   drivers/net/can/sja1000/sja1000_isa.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/sja1000/sja1000_isa.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/sja1000/sja1000_isa.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/sja1000/sja1000_isa.c:111:9: sparse:     got void *
   drivers/net/can/sja1000/sja1000_isa.c:112:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/can/sja1000/sja1000_isa.c:112:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/can/sja1000/sja1000_isa.c:112:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/can/sja1000/sja1000_isa.c:112:9: sparse:     got void *
--
>> drivers/bluetooth/dtl1_cs.c:115:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/dtl1_cs.c:115:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/dtl1_cs.c:115:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:115:15: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:121:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/dtl1_cs.c:121:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/dtl1_cs.c:121:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:121:17: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:285:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:285:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:285:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:285:18: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:229:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:229:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:229:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:229:42: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:306:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:306:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:306:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:306:15: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:311:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:311:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:311:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:311:23: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:336:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:336:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:336:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:336:23: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:340:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:340:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:340:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:340:15: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:472:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:472:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:472:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:472:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:475:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:475:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:475:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:475:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:478:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:478:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:478:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:478:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:479:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:479:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:479:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:479:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:481:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:481:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:481:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:481:26: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:485:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:485:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:485:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:485:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:518:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:518:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:518:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:521:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:521:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:521:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:521:9: sparse:     got void *
--
>> drivers/bluetooth/bt3c_cs.c:249:58: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/bt3c_cs.c:249:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/bt3c_cs.c:249:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:249:58: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:250:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:250:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:250:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:250:25: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:283:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:283:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:283:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:283:34: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:286:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:286:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:286:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:286:25: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:349:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:349:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:349:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:349:15: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:370:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/bt3c_cs.c:370:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/bt3c_cs.c:370:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:370:25: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/bluetooth/bluecard_cs.c:171:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/bluecard_cs.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/bluecard_cs.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:171:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:187:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:187:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:187:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:187:17: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:190:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:190:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:190:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:190:17: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:266:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:266:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:266:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:266:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:310:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:310:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:310:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:310:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:314:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:314:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:314:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:314:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:342:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:342:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:342:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:344:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/bluecard_cs.c:344:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/bluecard_cs.c:344:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:344:15: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:351:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:351:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:351:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:351:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:355:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:355:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:355:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:355:26: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:514:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:514:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:514:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:514:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:516:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:516:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:516:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:516:15: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:522:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:522:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:522:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:522:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:523:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:523:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:523:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:523:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:528:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:528:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:528:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:528:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:529:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:529:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:529:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:529:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:534:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:534:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:534:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:534:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:540:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:540:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:540:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:540:25: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:548:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:548:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:548:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:548:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:629:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:629:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:629:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:629:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:646:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:646:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:646:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:646:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:716:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:716:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:716:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:716:14: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:729:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:729:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:729:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:729:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:732:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:732:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:732:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:732:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:738:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:738:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:738:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:738:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:742:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:742:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:742:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:742:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:745:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:745:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:745:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:745:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:747:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:747:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:747:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:747:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:752:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:752:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:752:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:752:17: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:756:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:756:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:756:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:756:17: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:760:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:760:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:760:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:760:17: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:768:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:768:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:768:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bluecard_cs.c:768:9: sparse:     got void *
   drivers/bluetooth/bluecard_cs.c:769:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bluecard_cs.c:769:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bluecard_cs.c:769:9: sparse:     expected void volatile [noderef] __iomem *addr

vim +/__iomem +188 drivers/hwmon/pc87427.c

ba224e2c4f0a706 Jean Delvare  2006-12-12  177  
36564efaddb7c1a Guenter Roeck 2012-01-19  178  /*
36564efaddb7c1a Guenter Roeck 2012-01-19  179   * Dedicated function to read all registers related to a given fan input.
36564efaddb7c1a Guenter Roeck 2012-01-19  180   * This saves us quite a few locks and bank selections.
36564efaddb7c1a Guenter Roeck 2012-01-19  181   * Must be called with data->lock held.
36564efaddb7c1a Guenter Roeck 2012-01-19  182   * nr is from 0 to 7
36564efaddb7c1a Guenter Roeck 2012-01-19  183   */
ba224e2c4f0a706 Jean Delvare  2006-12-12  184  static void pc87427_readall_fan(struct pc87427_data *data, u8 nr)
ba224e2c4f0a706 Jean Delvare  2006-12-12  185  {
ba224e2c4f0a706 Jean Delvare  2006-12-12  186  	int iobase = data->address[LD_FAN];
ba224e2c4f0a706 Jean Delvare  2006-12-12  187  
ba224e2c4f0a706 Jean Delvare  2006-12-12 @188  	outb(BANK_FM(nr), iobase + PC87427_REG_BANK);
ba224e2c4f0a706 Jean Delvare  2006-12-12 @189  	data->fan[nr] = inw(iobase + PC87427_REG_FAN);
ba224e2c4f0a706 Jean Delvare  2006-12-12  190  	data->fan_min[nr] = inw(iobase + PC87427_REG_FAN_MIN);
ba224e2c4f0a706 Jean Delvare  2006-12-12  191  	data->fan_status[nr] = inb(iobase + PC87427_REG_FAN_STATUS);
ba224e2c4f0a706 Jean Delvare  2006-12-12  192  	/* Clear fan alarm bits */
ba224e2c4f0a706 Jean Delvare  2006-12-12  193  	outb(data->fan_status[nr], iobase + PC87427_REG_FAN_STATUS);
ba224e2c4f0a706 Jean Delvare  2006-12-12  194  }
ba224e2c4f0a706 Jean Delvare  2006-12-12  195  

:::::: The code at line 188 was first introduced by commit
:::::: ba224e2c4f0a706714ccb483b0c21d32f5994f67 hwmon: New PC87427 hardware monitoring driver

:::::: TO: Jean Delvare <khali@linux-fr.org>
:::::: CC: Jean Delvare <khali@arrakis.delvare>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
jtCEv8MBAA==

--2oS5YaxWCcQjTEyO--

Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FEDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9095206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 20:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHHUUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 16:20:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:55118 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHUUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 16:20:14 -0400
IronPort-SDR: bt79nE0C1DXLoz43Y3Xp/rI7NGIng1XqX2QK6rowmwTUYyYcI0rRpD6dcWSj0pAtVMIWEhRHTD
 2clm5OZAzbfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9707"; a="238167210"
X-IronPort-AV: E=Sophos;i="5.75,450,1589266800"; 
   d="gz'50?scan'50,208,50";a="238167210"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2020 12:25:01 -0700
IronPort-SDR: vNO1BiQehod4A9V3qLVqUbtGWT6m53MXn52Vr4c6dv+sVHAPEZ0Ea3nCEciE+sgHxvhuiJn+p+
 BIAMxt4H1BgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,450,1589266800"; 
   d="gz'50?scan'50,208,50";a="326088999"
Received: from lkp-server02.sh.intel.com (HELO 65e25449d42f) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2020 12:24:59 -0700
Received: from kbuild by 65e25449d42f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4USg-0000GE-JV; Sat, 08 Aug 2020 19:24:58 +0000
Date:   Sun, 9 Aug 2020 03:24:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/hwmon/smsc47b397.c:111:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202008090308.RwyhuElP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11030fe96b57ad843518b0e9430f3cd4b3610ce2
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: riscv-randconfig-s031-20200809 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/hwmon/smsc47b397.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/smsc47b397.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/smsc47b397.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:111:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   drivers/hwmon/smsc47b397.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:67:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:67:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:67:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:52:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:52:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/smsc47b397.c:53:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:53:16: sparse:     got void *
   drivers/hwmon/smsc47b397.c:73:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:73:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:73:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:73:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:52:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:52:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/smsc47b397.c:53:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:53:16: sparse:     got void *
   drivers/hwmon/smsc47b397.c:46:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:46:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:46:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:46:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:47:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:47:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:47:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:47:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:52:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:52:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/smsc47b397.c:53:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:53:16: sparse:     got void *
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:52:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:52:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:52:9: sparse:     got void *
   drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/smsc47b397.c:53:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/smsc47b397.c:53:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:53:16: sparse:     got void *
   drivers/hwmon/smsc47b397.c:73:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/smsc47b397.c:73:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/smsc47b397.c:73:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/smsc47b397.c:73:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/cb_das16_cs.c:133:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/cb_das16_cs.c:133:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/cb_das16_cs.c:133:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:133:18: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:151:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/cb_das16_cs.c:151:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/cb_das16_cs.c:151:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:151:9: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:161:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:161:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:161:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:161:9: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:178:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:178:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:178:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:178:9: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:181:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:181:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:181:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:181:17: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:187:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:187:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:187:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:187:27: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:208:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:208:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:208:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:208:17: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:218:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:218:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:218:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:218:17: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:226:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:226:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:226:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:226:25: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:228:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:228:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:228:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:228:25: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:236:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:236:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:236:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:236:17: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:250:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:250:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:250:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:250:17: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:252:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:252:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:252:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:252:19: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:284:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:284:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:284:9: sparse:     got void *
   drivers/staging/comedi/drivers/cb_das16_cs.c:308:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_das16_cs.c:308:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_das16_cs.c:308:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_das16_cs.c:308:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/ni_daq_700.c:85:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_daq_700.c:85:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_daq_700.c:85:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:85:25: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:89:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_daq_700.c:89:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_daq_700.c:89:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:89:16: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:120:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:120:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:120:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:120:18: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:123:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:123:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:123:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:123:18: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:149:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:149:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:149:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:149:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:153:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:153:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:153:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:153:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:160:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:160:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:160:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:160:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:161:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:161:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:161:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:161:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:162:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:162:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:162:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:162:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:164:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:164:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:164:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:164:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:166:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:166:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:166:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:166:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:174:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:174:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:174:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:174:21: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:200:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:200:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:200:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:200:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:201:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:201:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:201:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:201:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:202:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:202:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:202:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:202:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:203:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:203:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:203:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:203:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:204:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:204:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:204:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:204:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:205:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:205:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:205:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_daq_700.c:206:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_daq_700.c:206:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_daq_700.c:206:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_daq_700.c:206:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/quatech_daqp_cs.c:170:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/quatech_daqp_cs.c:170:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/quatech_daqp_cs.c:170:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:170:26: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:190:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/quatech_daqp_cs.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/quatech_daqp_cs.c:190:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:190:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:191:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:191:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:191:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:191:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:192:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:192:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:192:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:192:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:206:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:206:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:206:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:206:15: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:207:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:207:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:207:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:207:16: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:222:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:222:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:222:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:222:18: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:247:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:247:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:247:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:247:26: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:278:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:278:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:278:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:278:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:279:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:279:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:279:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:279:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:289:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:289:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:289:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:289:18: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:307:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:307:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:307:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:307:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:310:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:310:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:310:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:310:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:316:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:316:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:316:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:316:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:319:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:319:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:319:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:319:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:327:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:327:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:327:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:327:17: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:335:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:335:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:335:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:335:17: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:341:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:341:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:341:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:341:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:342:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:342:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:342:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:342:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:366:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:366:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:366:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:367:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:367:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:367:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:367:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:368:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:368:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:368:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:368:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:474:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:474:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:474:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:474:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:477:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:477:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:477:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:477:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:587:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:587:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:587:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:587:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:597:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:597:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:597:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:597:9: sparse:     got void *
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:598:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:598:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/quatech_daqp_cs.c:598:9: sparse:     expected void volatile [noderef] __iomem *addr

vim +/__iomem +111 drivers/hwmon/smsc47b397.c

^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   49  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   50  static inline int superio_inb(int reg)
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   51  {
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   52  	outb(reg, REG);
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  @53  	return inb(VAL);
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   54  }
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   55  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   56  /* select superio logical device */
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   57  static inline void superio_select(int ld)
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   58  {
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   59  	superio_outb(0x07, ld);
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   60  }
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   61  
8c0826756744c0 drivers/hwmon/smsc47b397.c     Guenter Roeck  2019-04-04   62  static inline int superio_enter(void)
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   63  {
8c0826756744c0 drivers/hwmon/smsc47b397.c     Guenter Roeck  2019-04-04   64  	if (!request_muxed_region(REG, 2, DRVNAME))
8c0826756744c0 drivers/hwmon/smsc47b397.c     Guenter Roeck  2019-04-04   65  		return -EBUSY;
8c0826756744c0 drivers/hwmon/smsc47b397.c     Guenter Roeck  2019-04-04   66  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   67  	outb(0x55, REG);
8c0826756744c0 drivers/hwmon/smsc47b397.c     Guenter Roeck  2019-04-04   68  	return 0;
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   69  }
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   70  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   71  static inline void superio_exit(void)
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   72  {
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   73  	outb(0xAA, REG);
8c0826756744c0 drivers/hwmon/smsc47b397.c     Guenter Roeck  2019-04-04   74  	release_region(REG, 2);
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   75  }
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   76  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   77  #define SUPERIO_REG_DEVID	0x20
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   78  #define SUPERIO_REG_DEVREV	0x21
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   79  #define SUPERIO_REG_BASE_MSB	0x60
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   80  #define SUPERIO_REG_BASE_LSB	0x61
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   81  #define SUPERIO_REG_LD8		0x08
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   82  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   83  #define SMSC_EXTENT		0x02
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   84  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   85  /* 0 <= nr <= 3 */
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   86  static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   87  #define SMSC47B397_REG_TEMP(nr)	(smsc47b397_reg_temp[(nr)])
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   88  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   89  /* 0 <= nr <= 3 */
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   90  #define SMSC47B397_REG_FAN_LSB(nr) (0x28 + 2 * (nr))
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   91  #define SMSC47B397_REG_FAN_MSB(nr) (0x29 + 2 * (nr))
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   92  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   93  struct smsc47b397_data {
292fc1a5ff44d4 drivers/hwmon/smsc47b397.c     Jean Delvare   2007-05-08   94  	unsigned short addr;
9a61bf6300533d drivers/hwmon/smsc47b397.c     Ingo Molnar    2006-01-18   95  	struct mutex lock;
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   96  
9a61bf6300533d drivers/hwmon/smsc47b397.c     Ingo Molnar    2006-01-18   97  	struct mutex update_lock;
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   98  	unsigned long last_updated; /* in jiffies */
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16   99  	int valid;
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  100  
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  101  	/* register values */
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  102  	u16 fan[4];
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  103  	u8 temp[4];
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  104  };
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  105  
292fc1a5ff44d4 drivers/hwmon/smsc47b397.c     Jean Delvare   2007-05-08  106  static int smsc47b397_read_value(struct smsc47b397_data *data, u8 reg)
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  107  {
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  108  	int res;
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  109  
9a61bf6300533d drivers/hwmon/smsc47b397.c     Ingo Molnar    2006-01-18  110  	mutex_lock(&data->lock);
292fc1a5ff44d4 drivers/hwmon/smsc47b397.c     Jean Delvare   2007-05-08 @111  	outb(reg, data->addr);
292fc1a5ff44d4 drivers/hwmon/smsc47b397.c     Jean Delvare   2007-05-08  112  	res = inb_p(data->addr + 1);
9a61bf6300533d drivers/hwmon/smsc47b397.c     Ingo Molnar    2006-01-18  113  	mutex_unlock(&data->lock);
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  114  	return res;
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  115  }
^1da177e4c3f41 drivers/i2c/chips/smsc47b397.c Linus Torvalds 2005-04-16  116  

:::::: The code at line 111 was first introduced by commit
:::::: 292fc1a5ff44d477ff335a343a48d2b67bbc70e3 hwmon/smsc47b397: Convert to a platform driver

:::::: TO: Jean Delvare <khali@linux-fr.org>
:::::: CC: Jean Delvare <khali@hyperion.delvare>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6TrnltStXW4iwmi0--

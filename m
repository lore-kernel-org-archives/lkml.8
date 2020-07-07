Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF9EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7686C206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGGKD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:03:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:26425 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGKD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:03:26 -0400
IronPort-SDR: scYueElTtFcLSwv6dnOkctL76u1zvEwx06ZuAgvU7ydGJoAOZzqLdGVnUPI5rG2qSmJSWF8Poe
 ea+WL0y3yGrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="232428791"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="gz'50?scan'50,208,50";a="232428791"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 03:03:15 -0700
IronPort-SDR: 6i0hp0LiPkl9gPVAxO9YOiiodUYvnGSPMlz4LFB2KqY/MYHWdZcuPfmUHZ2z+yf0Cn184sXvMY
 siQJfPkMxccg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
   d="gz'50?scan'50,208,50";a="323495923"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2020 03:03:13 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jskRU-0000AW-Ek; Tue, 07 Jul 2020 10:03:12 +0000
Date:   Tue, 7 Jul 2020 18:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpio/gpio-menz127.c:69:17: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007071859.kqYWt4Jg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfe91da29bfad9941d5d703d45e29f0812a20724
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: m68k-randconfig-s031-20200707 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-31-gabbfd661-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/gpio/gpio-menz127.c:69:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:80:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:95:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpio/gpio-menz127.c:103:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:177:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:167:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/spi/spi-dw.h:162:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/spi/spi-dw.h:172:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/68328fb.c:438:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *static [toplevel] screen_base @@     got void * @@
>> drivers/video/fbdev/68328fb.c:438:29: sparse:     expected char [noderef] __iomem *static [toplevel] screen_base
   drivers/video/fbdev/68328fb.c:438:29: sparse:     got void *
--
>> drivers/watchdog/dw_wdt.c:78:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:114:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:132:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:138:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:174:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:189:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:63:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/dw_wdt.c:63:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/watchdog/menz69_wdt.c:39:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:41:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:51:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:53:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:64:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:66:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:80:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/menz69_wdt.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/soc/hisilicon/hi6210-i2s.c:88:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/hisilicon/hi6210-i2s.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/crypto/amlogic/amlogic-gxl-core.c:31:29: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:299:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:299:9: sparse:     expected unsigned int volatile
   include/asm-generic/io.h:299:9: sparse:     got restricted __le32 [usertype]
--
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] v @@     got unsigned long @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse:     expected restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:171:19: sparse:     got unsigned long
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] v @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse:     expected unsigned int [usertype] val
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse:     got restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:172:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:215:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] v @@     got unsigned long @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:215:19: sparse:     expected restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:215:19: sparse:     got unsigned long
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:217:27: sparse: sparse: invalid assignment: |=
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:217:27: sparse:    left side has type restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:217:27: sparse:    right side has type unsigned long
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:221:27: sparse: sparse: invalid assignment: |=
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:221:27: sparse:    left side has type restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:221:27: sparse:    right side has type unsigned long
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] v @@
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse:     expected unsigned int [usertype] val
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse:     got restricted __le32 [usertype] v
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
   drivers/crypto/amlogic/amlogic-gxl-cipher.c:222:34: sparse: sparse: cast from restricted __le32
>> drivers/crypto/amlogic/amlogic-gxl-cipher.c:230:9: sparse: sparse: cast removes address space '__iomem' of expression
--
   sound/soc/xilinx/xlnx_i2s.c:28:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   sound/soc/xilinx/xlnx_i2s.c:28:53: sparse:     expected void [noderef] __iomem *base
   sound/soc/xilinx/xlnx_i2s.c:28:53: sparse:     got void *
>> sound/soc/xilinx/xlnx_i2s.c:33:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/xilinx/xlnx_i2s.c:43:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   sound/soc/xilinx/xlnx_i2s.c:43:53: sparse:     expected void [noderef] __iomem *base
   sound/soc/xilinx/xlnx_i2s.c:43:53: sparse:     got void *
   sound/soc/xilinx/xlnx_i2s.c:49:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/xilinx/xlnx_i2s.c:59:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   sound/soc/xilinx/xlnx_i2s.c:59:53: sparse:     expected void [noderef] __iomem *base
   sound/soc/xilinx/xlnx_i2s.c:59:53: sparse:     got void *
   sound/soc/xilinx/xlnx_i2s.c:65:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/xilinx/xlnx_i2s.c:70:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/soc/xilinx/xlnx_i2s.c:156:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got void [noderef] __iomem *[assigned] base @@
   sound/soc/xilinx/xlnx_i2s.c:156:37: sparse:     expected void *data
   sound/soc/xilinx/xlnx_i2s.c:156:37: sparse:     got void [noderef] __iomem *[assigned] base

vim +/__iomem +69 drivers/gpio/gpio-menz127.c

f436bc2726c645 Andreas Werner 2016-02-29  37  
f436bc2726c645 Andreas Werner 2016-02-29  38  static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
f436bc2726c645 Andreas Werner 2016-02-29  39  			     unsigned debounce)
f436bc2726c645 Andreas Werner 2016-02-29  40  {
f436bc2726c645 Andreas Werner 2016-02-29  41  	struct men_z127_gpio *priv = gpiochip_get_data(gc);
86d3f367686852 Axel Lin       2016-03-09  42  	struct device *dev = gc->parent;
f436bc2726c645 Andreas Werner 2016-02-29  43  	unsigned int rnd;
f436bc2726c645 Andreas Werner 2016-02-29  44  	u32 db_en, db_cnt;
f436bc2726c645 Andreas Werner 2016-02-29  45  
f436bc2726c645 Andreas Werner 2016-02-29  46  	if (!MEN_Z127_DB_IN_RANGE(debounce)) {
f436bc2726c645 Andreas Werner 2016-02-29  47  		dev_err(dev, "debounce value %u out of range", debounce);
f436bc2726c645 Andreas Werner 2016-02-29  48  		return -EINVAL;
f436bc2726c645 Andreas Werner 2016-02-29  49  	}
f436bc2726c645 Andreas Werner 2016-02-29  50  
f436bc2726c645 Andreas Werner 2016-02-29  51  	if (debounce > 0) {
f436bc2726c645 Andreas Werner 2016-02-29  52  		/* round up or down depending on MSB-1 */
f436bc2726c645 Andreas Werner 2016-02-29  53  		rnd = fls(debounce) - 1;
f436bc2726c645 Andreas Werner 2016-02-29  54  
f436bc2726c645 Andreas Werner 2016-02-29  55  		if (rnd && (debounce & BIT(rnd - 1)))
7279d9917560bb Nadav Amit     2018-06-04  56  			debounce = roundup(debounce, MEN_Z127_DB_MIN_US);
f436bc2726c645 Andreas Werner 2016-02-29  57  		else
7279d9917560bb Nadav Amit     2018-06-04  58  			debounce = rounddown(debounce, MEN_Z127_DB_MIN_US);
f436bc2726c645 Andreas Werner 2016-02-29  59  
f436bc2726c645 Andreas Werner 2016-02-29  60  		if (debounce > MEN_Z127_DB_MAX_US)
f436bc2726c645 Andreas Werner 2016-02-29  61  			debounce = MEN_Z127_DB_MAX_US;
f436bc2726c645 Andreas Werner 2016-02-29  62  
f436bc2726c645 Andreas Werner 2016-02-29  63  		/* 50us per register unit */
f436bc2726c645 Andreas Werner 2016-02-29  64  		debounce /= 50;
f436bc2726c645 Andreas Werner 2016-02-29  65  	}
f436bc2726c645 Andreas Werner 2016-02-29  66  
fd975a7b180c9a Axel Lin       2016-03-09  67  	spin_lock(&gc->bgpio_lock);
f436bc2726c645 Andreas Werner 2016-02-29  68  
f436bc2726c645 Andreas Werner 2016-02-29 @69  	db_en = readl(priv->reg_base + MEN_Z127_DBER);
f436bc2726c645 Andreas Werner 2016-02-29  70  
f436bc2726c645 Andreas Werner 2016-02-29  71  	if (debounce == 0) {
f436bc2726c645 Andreas Werner 2016-02-29  72  		db_en &= ~BIT(gpio);
f436bc2726c645 Andreas Werner 2016-02-29  73  		db_cnt = 0;
f436bc2726c645 Andreas Werner 2016-02-29  74  	} else {
f436bc2726c645 Andreas Werner 2016-02-29  75  		db_en |= BIT(gpio);
f436bc2726c645 Andreas Werner 2016-02-29  76  		db_cnt = debounce;
f436bc2726c645 Andreas Werner 2016-02-29  77  	}
f436bc2726c645 Andreas Werner 2016-02-29  78  
f436bc2726c645 Andreas Werner 2016-02-29  79  	writel(db_en, priv->reg_base + MEN_Z127_DBER);
f436bc2726c645 Andreas Werner 2016-02-29  80  	writel(db_cnt, priv->reg_base + GPIO_TO_DBCNT_REG(gpio));
f436bc2726c645 Andreas Werner 2016-02-29  81  
fd975a7b180c9a Axel Lin       2016-03-09  82  	spin_unlock(&gc->bgpio_lock);
f436bc2726c645 Andreas Werner 2016-02-29  83  
f436bc2726c645 Andreas Werner 2016-02-29  84  	return 0;
f436bc2726c645 Andreas Werner 2016-02-29  85  }
f436bc2726c645 Andreas Werner 2016-02-29  86  

:::::: The code at line 69 was first introduced by commit
:::::: f436bc2726c6451bd15b63f100f00dcee52ba103 gpio: add driver for MEN 16Z127 GPIO controller

:::::: TO: Andreas Werner <andy@wernerandy.de>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qMm9M+Fa2AknHoGS--

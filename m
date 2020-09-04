Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1005F206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgIDKKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:10:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:18525 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIDKKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:10:01 -0400
IronPort-SDR: ubG9Sxz7xG2hxd90J5pHuFmKULV1ou8CAj1JpfPbkjZahFUATOhU+2OwwJSgsREX9/jZieb465
 SVCnEV2yC29w==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="155116510"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="gz'50?scan'50,208,50";a="155116510"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 02:52:38 -0700
IronPort-SDR: Tk2E+OZeho4qG0WfnFycBEnK/9tkL4VLiDLFIaw7CWjsSOBv+nQShYdyU3Womny/WuBSVwODhO
 ZHTcPRvmPFDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="gz'50?scan'50,208,50";a="315800615"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2020 02:52:35 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kE8OZ-00002y-8U; Fri, 04 Sep 2020 09:52:35 +0000
Date:   Fri, 4 Sep 2020 17:52:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202009041709.YuTAULlP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59126901f200f5fc907153468b03c64e0081b6e6
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   10 months ago
config: microblaze-randconfig-s031-20200904 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/atm/horizon.c: note: in included file (through arch/microblaze/include/uapi/asm/unistd.h, arch/microblaze/include/asm/unistd.h, include/uapi/linux/unistd.h, ...):
   ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45: sparse: sparse: no newline at end of file
   drivers/atm/horizon.c:1135:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] tx_addr @@     got void [noderef] <asn:1> *iov_base @@
   drivers/atm/horizon.c:1135:22: sparse:     expected void *[usertype] tx_addr
   drivers/atm/horizon.c:1135:22: sparse:     got void [noderef] <asn:1> *iov_base
   drivers/atm/horizon.c:1173:49: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] @@
   drivers/atm/horizon.c:1173:49: sparse:     expected unsigned int [usertype] data
   drivers/atm/horizon.c:1173:49: sparse:     got restricted __be32 [usertype]
   drivers/atm/horizon.c:1177:48: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] @@
   drivers/atm/horizon.c:1177:48: sparse:     expected unsigned int [usertype] data
   drivers/atm/horizon.c:1177:48: sparse:     got restricted __be32 [usertype]
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c: note: in included file (through arch/microblaze/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:479:15: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:479:15: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:513:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:513:22: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:492:15: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] value
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:523:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:523:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:523:22: sparse:     got restricted __le32 [usertype]
>> drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
>> drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] value
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:513:22: sparse: sparse: too many warnings

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80591e61a0f7e88deaada69844e4a31280c4a38f
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
vim +365 drivers/atm/horizon.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  354  
^1da177e4c3f41 Linus Torvalds 2005-04-16  355  /* Read / Write Horizon registers */
^1da177e4c3f41 Linus Torvalds 2005-04-16  356  static inline void wr_regl (const hrz_dev * dev, unsigned char reg, u32 data) {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @357    outl (cpu_to_le32 (data), dev->iobase + reg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  358  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  359  
^1da177e4c3f41 Linus Torvalds 2005-04-16  360  static inline u32 rd_regl (const hrz_dev * dev, unsigned char reg) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  361    return le32_to_cpu (inl (dev->iobase + reg));
^1da177e4c3f41 Linus Torvalds 2005-04-16  362  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  363  
^1da177e4c3f41 Linus Torvalds 2005-04-16  364  static inline void wr_regw (const hrz_dev * dev, unsigned char reg, u16 data) {
^1da177e4c3f41 Linus Torvalds 2005-04-16 @365    outw (cpu_to_le16 (data), dev->iobase + reg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  366  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  367  

:::::: The code at line 365 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZGiS0Q5IWpPtfppv--

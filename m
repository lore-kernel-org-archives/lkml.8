Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA1A2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGIMxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:53:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:47887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIMxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:53:06 -0400
IronPort-SDR: 32nYd6+aGGjUKU5HwIK/OyX31oSvY7CHQY0hohwVdZvpuSyzneBSIJL5eb44+5Y9oQ1VTxwMFd
 zp1YBw/C6zkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212901073"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="212901073"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 05:51:51 -0700
IronPort-SDR: FzCZVNxulj/hWF/mgzn9yqVImoVueCpZ05p7HvSVVulGWSFpcdft1o2yddunlVC7WPE970yM7p
 csbzsnTRSlwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="358431577"
Received: from lkp-server01.sh.intel.com (HELO 5019aad283e6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2020 05:51:48 -0700
Received: from kbuild by 5019aad283e6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtW1k-00002j-9S; Thu, 09 Jul 2020 12:51:48 +0000
Date:   Thu, 9 Jul 2020 20:51:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/aeroflex/greth.c:362:9: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202007092001.hIoc1tHy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: sparc-randconfig-s032-20200709 (attached as .config)
compiler: sparc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/aeroflex/greth.c:362:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:406:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/net/ethernet/aeroflex/greth.c:406:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:406:24: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:406:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:1128:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *bd @@     got unsigned int [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/aeroflex/greth.c:1128:52: sparse:     expected unsigned int [usertype] *bd
>> drivers/net/ethernet/aeroflex/greth.c:1128:52: sparse:     got unsigned int [noderef] [usertype] __iomem *
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:1367:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct greth_regs *regs @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/aeroflex/greth.c:1367:21: sparse:     expected struct greth_regs *regs
>> drivers/net/ethernet/aeroflex/greth.c:1367:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:1521:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct greth_regs *regs @@
>> drivers/net/ethernet/aeroflex/greth.c:1521:46: sparse:     expected void [noderef] __iomem *base
   drivers/net/ethernet/aeroflex/greth.c:1521:46: sparse:     got struct greth_regs *regs
   drivers/net/ethernet/aeroflex/greth.c:1544:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct greth_regs *regs @@
   drivers/net/ethernet/aeroflex/greth.c:1544:47: sparse:     expected void [noderef] __iomem *base
   drivers/net/ethernet/aeroflex/greth.c:1544:47: sparse:     got struct greth_regs *regs
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/aeroflex/greth.c:157:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse: sparse: too many warnings

vim +362 drivers/net/ethernet/aeroflex/greth.c

d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  337  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  338  static int greth_open(struct net_device *dev)
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  339  {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  340  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  341  	int err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  342  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  343  	err = greth_init_rings(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  344  	if (err) {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  345  		if (netif_msg_ifup(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  346  			dev_err(&dev->dev, "Could not allocate memory for DMA rings\n");
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  347  		return err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  348  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  349  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  350  	err = request_irq(greth->irq, greth_interrupt, 0, "eth", (void *) dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  351  	if (err) {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  352  		if (netif_msg_ifup(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  353  			dev_err(&dev->dev, "Could not allocate interrupt %d\n", dev->irq);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  354  		greth_clean_rings(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  355  		return err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  356  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  357  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  358  	if (netif_msg_ifup(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  359  		dev_dbg(&dev->dev, " starting queue\n");
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  360  	netif_start_queue(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  361  
bbe9e637330abe drivers/net/greth.c Daniel Hellstrom   2011-01-14 @362  	GRETH_REGSAVE(greth->regs->status, 0xFF);
bbe9e637330abe drivers/net/greth.c Daniel Hellstrom   2011-01-14  363  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  364  	napi_enable(&greth->napi);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  365  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  366  	greth_enable_irqs(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  367  	greth_enable_tx(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  368  	greth_enable_rx(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  369  	return 0;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  370  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  371  }
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  372  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  373  static int greth_close(struct net_device *dev)
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  374  {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  375  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  376  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  377  	napi_disable(&greth->napi);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  378  
bbe9e637330abe drivers/net/greth.c Daniel Hellstrom   2011-01-14  379  	greth_disable_irqs(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  380  	greth_disable_tx(greth);
bbe9e637330abe drivers/net/greth.c Daniel Hellstrom   2011-01-14  381  	greth_disable_rx(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  382  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  383  	netif_stop_queue(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  384  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  385  	free_irq(greth->irq, (void *) dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  386  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  387  	greth_clean_rings(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  388  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  389  	return 0;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  390  }
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  391  
41a655ba5654e4 drivers/net/greth.c kirjanov@gmail.com 2010-02-24  392  static netdev_tx_t
41a655ba5654e4 drivers/net/greth.c kirjanov@gmail.com 2010-02-24  393  greth_start_xmit(struct sk_buff *skb, struct net_device *dev)
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  394  {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  395  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  396  	struct greth_bd *bdp;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  397  	int err = NETDEV_TX_OK;
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  398  	u32 status, dma_addr, ctrl;
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  399  	unsigned long flags;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  400  
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  401  	/* Clean TX Ring */
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  402  	greth_clean_tx(greth->netdev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  403  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  404  	if (unlikely(greth->tx_free <= 0)) {
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  405  		spin_lock_irqsave(&greth->devlock, flags);/*save from poll/irq*/
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14 @406  		ctrl = GRETH_REGLOAD(greth->regs->control);
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  407  		/* Enable TX IRQ only if not already in poll() routine */
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  408  		if (ctrl & GRETH_RXI)
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  409  			GRETH_REGSAVE(greth->regs->control, ctrl | GRETH_TXI);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  410  		netif_stop_queue(dev);
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  411  		spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  412  		return NETDEV_TX_BUSY;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  413  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  414  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  415  	if (netif_msg_pktdata(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  416  		greth_print_tx_packet(skb);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  417  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  418  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  419  	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  420  		dev->stats.tx_errors++;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  421  		goto out;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  422  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  423  
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  424  	bdp = greth->tx_bd_base + greth->tx_next;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  425  	dma_addr = greth_read_bd(&bdp->addr);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  426  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  427  	memcpy((unsigned char *) phys_to_virt(dma_addr), skb->data, skb->len);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  428  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  429  	dma_sync_single_for_device(greth->dev, dma_addr, skb->len, DMA_TO_DEVICE);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  430  
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  431  	status = GRETH_BD_EN | GRETH_BD_IE | (skb->len & GRETH_BD_LEN);
6af29a963cecf4 drivers/net/greth.c Daniel Hellstrom   2011-09-08  432  	greth->tx_bufs_length[greth->tx_next] = skb->len & GRETH_BD_LEN;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  433  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  434  	/* Wrap around descriptor ring */
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  435  	if (greth->tx_next == GRETH_TXBD_NUM_MASK) {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  436  		status |= GRETH_BD_WR;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  437  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  438  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  439  	greth->tx_next = NEXT_TX(greth->tx_next);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  440  	greth->tx_free--;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  441  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  442  	/* Write descriptor control word and enable transmission */
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  443  	greth_write_bd(&bdp->stat, status);
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  444  	spin_lock_irqsave(&greth->devlock, flags); /*save from poll/irq*/
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  445  	greth_enable_tx(greth);
0f73f2c5a3ebb9 drivers/net/greth.c Daniel Hellstrom   2011-01-14  446  	spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  447  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  448  out:
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  449  	dev_kfree_skb(skb);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  450  	return err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  451  }
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo  2010-02-15  452  

:::::: The code at line 362 was first introduced by commit
:::::: bbe9e637330abe55442aebe799425e224086959f GRETH: fix opening/closing

:::::: TO: Daniel Hellstrom <daniel@gaisler.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2dYBAA==

--7JfCtLOvnd9MIVvH--

Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07586C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC73E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391408AbgFXU0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:26:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:35169 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391326AbgFXU0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:26:45 -0400
IronPort-SDR: bAJH+5KhheDF52zqTtuO6gw9zfcrpOrBuGE1rjVPAr4GD+WJyntrJUU8tso0WzomWvjnhmblQU
 ul5XJ+xxc6sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124269641"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="124269641"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 12:45:42 -0700
IronPort-SDR: hbPPVX1z37DHGOoKCS/pNhWEUqyMVyrV9Ny4bEz9F5xZZDjDA+axzFmrbTCa3Hz5hAEORZ50eT
 FEObeAoZI7Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="479385194"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jun 2020 12:45:40 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joBL2-00016y-4t; Wed, 24 Jun 2020 19:45:40 +0000
Date:   Thu, 25 Jun 2020 03:44:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202006250351.kESOoE7V%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   7 months ago
config: alpha-randconfig-s031-20200624 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=alpha CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/spi/spi-fsl-spi.c:93:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:93:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:93:44: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:94:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *mode @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:94:33: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *mode
   drivers/spi/spi-fsl-spi.c:94:33: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:294:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:294:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:294:44: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:299:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:299:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:299:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:303:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:303:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:303:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:317:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:317:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:317:18: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:350:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:350:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:350:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:460:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:460:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:460:18: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:463:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:463:45: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:463:45: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:499:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:499:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:499:44: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:503:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:503:53: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:503:53: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:512:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:512:47: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:512:47: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:517:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:517:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:517:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:523:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:523:40: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:523:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:534:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:534:44: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:534:44: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:537:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:537:40: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:537:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:554:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:554:51: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:554:51: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:561:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:561:48: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:561:48: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:563:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:563:40: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:563:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:572:51: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:572:51: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:572:51: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:576:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:576:46: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:576:46: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:586:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:586:40: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:586:40: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:652:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct fsl_spi_reg *reg_base @@     got void [noderef] <asn:2> *reg_base @@
   drivers/spi/spi-fsl-spi.c:652:18: sparse:     expected struct fsl_spi_reg *reg_base
   drivers/spi/spi-fsl-spi.c:652:18: sparse:     got void [noderef] <asn:2> *reg_base
   drivers/spi/spi-fsl-spi.c:655:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:655:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:655:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:656:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:656:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:656:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:657:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:657:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:657:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:658:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:658:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:658:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:669:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected restricted __be32 [noderef] [usertype] <asn:2> *reg @@     got restricted __be32 * @@
   drivers/spi/spi-fsl-spi.c:669:32: sparse:     expected restricted __be32 [noderef] [usertype] <asn:2> *reg
   drivers/spi/spi-fsl-spi.c:669:32: sparse:     got restricted __be32 *
   drivers/spi/spi-fsl-spi.c:699:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
   drivers/spi/spi-fsl-spi.c:699:17: sparse:     expected unsigned int [usertype] b
   drivers/spi/spi-fsl-spi.c:699:17: sparse:     got restricted __be32 [usertype]
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
   drivers/spi/spi-fsl-lib.h:89:16: sparse: sparse: cast to restricted __be32
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]
>> drivers/spi/spi-fsl-lib.h:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] b @@     got restricted __be32 [usertype] @@
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     expected unsigned int [usertype] b
>> drivers/spi/spi-fsl-lib.h:84:9: sparse:     got restricted __be32 [usertype]

vim +84 drivers/spi/spi-fsl-lib.h

b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  81  
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  82  static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  83  {
e8beacbb85a5c1 drivers/spi/spi-fsl-lib.h Andreas Larsson 2013-02-15 @84  	iowrite32be(val, reg);
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  85  }
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  86  
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  87  static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *reg)
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  88  {
e8beacbb85a5c1 drivers/spi/spi-fsl-lib.h Andreas Larsson 2013-02-15 @89  	return ioread32be(reg);
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  90  }
b36ece832512c1 drivers/spi/spi_fsl_lib.h Mingkai Hu      2010-10-12  91  

:::::: The code at line 84 was first introduced by commit
:::::: e8beacbb85a5c1de1117400c5ddb450514a8372c spi/spi-fsl-spi: Make driver usable in CPU mode outside of an FSL_SOC environment

:::::: TO: Andreas Larsson <andreas@gaisler.com>
:::::: CC: Grant Likely <grant.likely@secretlab.ca>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Qxx1br4bt0+wmkIi--

Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27E320707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgHZLqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:46:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:45187 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgHZLpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:45:45 -0400
IronPort-SDR: GhzlmyFYeZYtq0HO1zFemZ4Zo49RRNCCzChxwuodVHuNP+4z0OzGKMtImRWagIer6XjMFSc+f8
 M2hGr5NmLIeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="174322404"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="gz'50?scan'50,208,50";a="174322404"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 04:38:19 -0700
IronPort-SDR: xtAtTB20pQEJrVunoyNuvc0tVwXVuM9nCboxgvUr9EsaT6Oh11uDszdLOU/3pS12utkoeck3GL
 rzQMjOFVejiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="gz'50?scan'50,208,50";a="323156321"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 04:38:17 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAtku-0001Pb-Hs; Wed, 26 Aug 2020 11:38:16 +0000
Date:   Wed, 26 Aug 2020 19:37:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Timur Tabi <timur@kernel.org>
Subject: drivers/usb/gadget/udc/fsl_qe_udc.c:837:33: sparse: sparse: non
 size-preserving integer to pointer cast
Message-ID: <202008261908.zlfjrtAl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rasmus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ac69819ba9e3d8d550bb5d2d2df74848e556812
commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE
date:   9 months ago
config: powerpc-randconfig-s032-20200826 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     expected unsigned int volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be32 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     expected unsigned int const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     got restricted __be32 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     expected unsigned short const volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 const [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     expected unsigned int [usertype] offset
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     got restricted __be32 const [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     got restricted __be16 [noderef] <asn:2> *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr @@     got restricted __be16 [noderef] <asn:2> * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     expected unsigned short volatile [noderef] [usertype] <asn:2> *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     got restricted __be16 [noderef] <asn:2> *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:837:33: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:965:33: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c:1491:25: sparse: sparse: non size-preserving integer to pointer cast
   drivers/usb/gadget/udc/fsl_qe_udc.c: note: in included file (through include/linux/seqlock.h, include/linux/time.h, include/linux/stat.h, ...):
>> include/linux/spinlock.h:378:9: sparse: sparse: context imbalance in 'setup_received_handle' - unexpected unlock

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5
vim +837 drivers/usb/gadget/udc/fsl_qe_udc.c

3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  807  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  808  static int qe_ep0_rx(struct qe_udc *udc)
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  809  {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  810  	struct qe_ep *ep = &udc->eps[0];
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  811  	struct qe_frame *pframe;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  812  	struct qe_bd __iomem *bd;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  813  	u32 bdstatus, length;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  814  	u32 vaddr;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  815  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  816  	pframe = ep->rxframe;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  817  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  818  	if (ep->dir == USB_DIR_IN) {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  819  		dev_err(udc->dev, "ep0 not a control endpoint\n");
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  820  		return -EINVAL;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  821  	}
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  822  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  823  	bd = ep->n_rxbd;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  824  	bdstatus = in_be32((u32 __iomem *)bd);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  825  	length = bdstatus & BD_LENGTH_MASK;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  826  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  827  	while (!(bdstatus & R_E) && length) {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  828  		if ((bdstatus & R_F) && (bdstatus & R_L)
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  829  			&& !(bdstatus & R_ERROR)) {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  830  			if (length == USB_CRC_SIZE) {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  831  				udc->ep0_state = WAIT_FOR_SETUP;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  832  				dev_vdbg(udc->dev,
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  833  					"receive a ZLP in status phase\n");
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  834  			} else {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  835  				qe_frame_clean(pframe);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  836  				vaddr = (u32)phys_to_virt(in_be32(&bd->buf));
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02 @837  				frame_set_data(pframe, (u8 *)vaddr);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  838  				frame_set_length(pframe,
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  839  						(length - USB_CRC_SIZE));
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  840  				frame_set_status(pframe, FRAME_OK);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  841  				switch (bdstatus & R_PID) {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  842  				case R_PID_SETUP:
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  843  					frame_set_info(pframe, PID_SETUP);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  844  					break;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  845  				case R_PID_DATA1:
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  846  					frame_set_info(pframe, PID_DATA1);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  847  					break;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  848  				default:
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  849  					frame_set_info(pframe, PID_DATA0);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  850  					break;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  851  				}
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  852  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  853  				if ((bdstatus & R_PID) == R_PID_SETUP)
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  854  					ep0_setup_handle(udc);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  855  				else
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  856  					qe_ep_rxframe_handle(ep);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  857  			}
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  858  		} else {
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  859  			dev_err(udc->dev, "The receive frame with error!\n");
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  860  		}
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  861  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  862  		/* note: don't clear the rxbd's buffer address */
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  863  		recycle_one_rxbd(ep);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  864  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  865  		/* Get next BD */
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  866  		if (bdstatus & R_W)
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  867  			bd = ep->rxbase;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  868  		else
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  869  			bd++;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  870  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  871  		bdstatus = in_be32((u32 __iomem *)bd);
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  872  		length = bdstatus & BD_LENGTH_MASK;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  873  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  874  	}
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  875  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  876  	ep->n_rxbd = bd;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  877  
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  878  	return 0;
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  879  }
3948f0e0c999a62 drivers/usb/gadget/fsl_qe_udc.c Li Yang 2008-09-02  880  

:::::: The code at line 837 was first introduced by commit
:::::: 3948f0e0c999a6201e9898bb8fbe3c6cc1199276 usb: add Freescale QE/CPM USB peripheral controller driver

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
yepWVegl2MXqjv0PctU9VYQDAgA=

--sm4nu43k4a2Rpi4c--

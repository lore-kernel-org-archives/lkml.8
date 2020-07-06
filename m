Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52485C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C5E20786
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgGFShd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:37:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:46892 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbgGFShc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:37:32 -0400
IronPort-SDR: yBli0jfOw9r5+TBak7Dx1X1HSc340XmJbkfM7z4vnmuft1V7vI+WoOQr0dvTOwav2pIJ+lnTfu
 iL8yGDTq/pKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="144974859"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="gz'50?scan'50,208,50";a="144974859"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 11:13:10 -0700
IronPort-SDR: /0FlD1JgE3S/qzVyrpZTqC5gWqImim74jWfk+hMlLA3CidPNbFbyNRNL33pwgHK5Ck1s1+BmAs
 1kelJFMKlVlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="gz'50?scan'50,208,50";a="279352881"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2020 11:13:06 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsVc2-0000Jo-5Y; Mon, 06 Jul 2020 18:13:06 +0000
Date:   Tue, 7 Jul 2020 02:12:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202007070229.KF9wvJxi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: riscv-randconfig-s031-20200706 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-14-g8fce3d7a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse:     got void *
   drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse:     got void *
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     expected unsigned int [usertype] len
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     got restricted __le32 [usertype]
--
   drivers/scsi/aic7xxx/aic79xx_osm.c:2266:16: sparse: sparse: cast to restricted __le16
   drivers/scsi/aic7xxx/aic79xx_osm.c:2285:37: sparse: sparse: cast to restricted __le16
>> drivers/scsi/aic7xxx/aic79xx_osm.c:408:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/aic7xxx/aic79xx_osm.c:408:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/aic7xxx/aic79xx_osm.c:408:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic79xx_osm.c:408:21: sparse:     got void *
   drivers/scsi/aic7xxx/aic79xx_osm.c:436:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/aic7xxx/aic79xx_osm.c:436:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/aic7xxx/aic79xx_osm.c:436:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic79xx_osm.c:436:17: sparse:     got void *
   drivers/scsi/aic7xxx/aic79xx_osm.c:447:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic7xxx/aic79xx_osm.c:447:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic7xxx/aic79xx_osm.c:447:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic79xx_osm.c:447:17: sparse:     got void *
   drivers/scsi/aic7xxx/aic79xx_osm.c:1773:49: sparse: sparse: cast to restricted __le16
--
   drivers/scsi/mvsas/mv_64xx.c:326:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned long long [usertype] sas_addr @@     got restricted __be64 [usertype] @@
   drivers/scsi/mvsas/mv_64xx.c:326:33: sparse:     expected unsigned long long [usertype] sas_addr
   drivers/scsi/mvsas/mv_64xx.c:326:33: sparse:     got restricted __be64 [usertype]
>> drivers/scsi/mvsas/mv_64xx.c:659:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/mvsas/mv_64xx.c:659:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/mvsas/mv_64xx.c:659:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvsas/mv_64xx.c:659:16: sparse:     got void *
   drivers/scsi/mvsas/mv_64xx.c:666:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/mvsas/mv_64xx.c:666:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/mvsas/mv_64xx.c:666:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvsas/mv_64xx.c:666:9: sparse:     got void *
   drivers/scsi/mvsas/mv_64xx.c:700:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/mvsas/mv_64xx.c:700:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvsas/mv_64xx.c:700:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvsas/mv_64xx.c:700:17: sparse:     got void *
   drivers/scsi/mvsas/mv_64xx.c:701:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/mvsas/mv_64xx.c:701:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvsas/mv_64xx.c:701:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvsas/mv_64xx.c:701:17: sparse:     got void *
   drivers/scsi/mvsas/mv_64xx.c:702:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/mvsas/mv_64xx.c:702:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvsas/mv_64xx.c:702:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvsas/mv_64xx.c:702:17: sparse:     got void *
   drivers/scsi/mvsas/mv_64xx.c:715:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/mvsas/mv_64xx.c:715:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvsas/mv_64xx.c:715:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvsas/mv_64xx.c:715:25: sparse:     got void *
--
>> drivers/staging/comedi/drivers/comedi_8254.c:135:31: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/comedi_8254.c:135:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/comedi_8254.c:135:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_8254.c:135:31: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_8254.c:141:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_8254.c:141:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_8254.c:141:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_8254.c:141:31: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_8254.c:147:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_8254.c:147:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_8254.c:147:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_8254.c:147:31: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_8254.c:164:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/comedi_8254.c:164:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/comedi_8254.c:164:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_8254.c:164:25: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_8254.c:170:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_8254.c:170:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_8254.c:170:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_8254.c:170:25: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_8254.c:176:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_8254.c:176:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_8254.c:176:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_8254.c:176:25: sparse:     got void *
--
>> drivers/staging/comedi/drivers/amplc_pc263.c:50:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pc263.c:50:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pc263.c:50:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pc263.c:50:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pc263.c:51:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pc263.c:51:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pc263.c:51:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pc263.c:51:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pc263.c:82:20: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pc263.c:82:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pc263.c:82:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pc263.c:82:20: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pc263.c:83:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pc263.c:83:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pc263.c:83:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pc263.c:83:21: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl711.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl711.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl711.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:160:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:168:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl711.c:168:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl711.c:168:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:168:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:169:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:169:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:169:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:169:16: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:177:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:177:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:177:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:196:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:196:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:196:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:196:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:218:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:218:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:218:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:218:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:232:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:232:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:232:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:232:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:242:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:242:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:242:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:242:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:261:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:261:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:261:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:261:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:348:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:348:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:348:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:348:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:360:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:360:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:360:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:361:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:361:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:361:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:361:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:389:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:389:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:389:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:389:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:390:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:390:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:390:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:390:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:407:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:407:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:407:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:407:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl711.c:409:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl711.c:409:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl711.c:409:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl711.c:409:25: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl724.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl724.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl724.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl724.c:87:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl724.c:92:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl724.c:92:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl724.c:92:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl724.c:92:16: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl730.c:223:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl730.c:223:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl730.c:223:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:223:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:243:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl730.c:243:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl730.c:243:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:243:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl812.c:578:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl812.c:578:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl812.c:578:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:578:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:606:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl812.c:606:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl812.c:606:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:606:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl816.c:140:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl816.c:140:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl816.c:140:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:140:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:141:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:141:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:141:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:148:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:148:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:148:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:177:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:177:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:177:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:183:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:183:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:183:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:183:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:191:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl816.c:191:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl816.c:191:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:191:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:192:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:192:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:192:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:192:16: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:204:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:204:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:204:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:204:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:443:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:443:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:443:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:443:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:444:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:444:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:444:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:444:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:491:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:491:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:491:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:491:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:512:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:512:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:512:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:512:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:527:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:527:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:527:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:527:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:538:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:538:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:538:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:538:19: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:539:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:539:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:539:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:539:20: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:550:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:550:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:550:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:550:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:551:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:551:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:551:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:551:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:561:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:561:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:561:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:561:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:566:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:566:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:566:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:566:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl816.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl816.c:567:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl816.c:567:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl816.c:567:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl818.c:329:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl818.c:329:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl818.c:329:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:329:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:330:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:330:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:330:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:330:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:337:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:337:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:337:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:337:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:372:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:372:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:372:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:378:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:378:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:378:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:378:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:387:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl818.c:387:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl818.c:387:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:387:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:388:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:388:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:388:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:388:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:402:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:402:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:402:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:402:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:403:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:403:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:403:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:403:16: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:418:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:418:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:418:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:418:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:507:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:507:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:507:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:507:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:629:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:629:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:629:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:629:13: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:734:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:734:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:734:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:734:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:745:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:745:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:745:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:745:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:749:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:749:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:749:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:749:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:785:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:785:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:785:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:785:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:790:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:790:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:790:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:790:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:791:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:791:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:791:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:791:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:792:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:792:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:792:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:792:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:810:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:810:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:810:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:810:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:841:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:841:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:841:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:841:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:843:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:843:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:843:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:843:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:856:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:856:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:856:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:856:19: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:857:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:857:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:857:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:857:20: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:868:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:868:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:868:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:868:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:869:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:869:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:869:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:869:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:884:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:884:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:884:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:884:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:885:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:885:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:885:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:885:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:886:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:886:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:886:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:886:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:890:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:890:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:890:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl818.c:890:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl818.c:896:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl818.c:896:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl818.c:896:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/pcm3724.c:117:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcm3724.c:117:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcm3724.c:117:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcm3724.c:117:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcm3724.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcm3724.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcm3724.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcm3724.c:119:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcm3724.c:156:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcm3724.c:156:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcm3724.c:156:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcm3724.c:156:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/rti800.c:140:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/rti800.c:140:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/rti800.c:140:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:140:18: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:142:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/rti800.c:142:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/rti800.c:142:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:142:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:162:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:162:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:162:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:162:9: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:163:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:163:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:163:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:163:9: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:168:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:168:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:168:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:185:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:185:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:185:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:185:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:191:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:191:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:191:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:191:23: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:192:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:192:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:192:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:192:25: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:222:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:222:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:222:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:222:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:223:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:223:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:223:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:223:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:234:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:234:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:234:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:234:19: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:245:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:245:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:245:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:245:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:264:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:264:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:264:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:264:9: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:265:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:265:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:265:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:265:9: sparse:     got void *
   drivers/staging/comedi/drivers/rti800.c:266:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti800.c:266:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti800.c:266:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti800.c:266:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/rti802.c:50:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/rti802.c:50:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/rti802.c:50:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti802.c:50:9: sparse:     got void *
   drivers/staging/comedi/drivers/rti802.c:61:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti802.c:61:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti802.c:61:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti802.c:61:17: sparse:     got void *
   drivers/staging/comedi/drivers/rti802.c:62:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/rti802.c:62:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/rti802.c:62:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/rti802.c:62:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/dac02.c:95:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dac02.c:95:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dac02.c:95:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dac02.c:95:17: sparse:     got void *
   drivers/staging/comedi/drivers/dac02.c:96:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dac02.c:96:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dac02.c:96:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dac02.c:96:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/das16m1.c:115:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das16m1.c:115:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das16m1.c:115:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:115:17: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:116:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:116:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:116:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:116:17: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:285:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:285:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:285:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:285:9: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:288:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:288:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:288:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:288:9: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:291:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:291:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:291:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:291:9: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:304:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:304:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:304:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:304:9: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:316:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das16m1.c:316:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das16m1.c:316:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:316:18: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:336:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:336:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:336:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:336:17: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:338:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:338:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:338:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:338:17: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:344:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:344:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:344:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:344:23: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:356:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:356:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:356:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:356:19: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:367:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:367:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:367:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:367:17: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:444:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:444:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:444:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:444:18: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:463:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:463:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:463:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:463:18: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:474:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:474:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:474:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:474:9: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:591:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:591:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:591:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:591:9: sparse:     got void *
   drivers/staging/comedi/drivers/das16m1.c:595:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das16m1.c:595:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das16m1.c:595:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das16m1.c:595:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/das800.c:218:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das800.c:218:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das800.c:218:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:218:9: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:219:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:219:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:219:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:219:9: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:228:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:228:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:228:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:228:9: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:229:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das800.c:229:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das800.c:229:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:229:16: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:241:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:241:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:241:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:241:17: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:390:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:390:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:390:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:390:9: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:415:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:415:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:415:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:415:28: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:416:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:416:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:416:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:416:28: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:435:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:435:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:435:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:435:18: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:465:44: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:465:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:465:44: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:465:44: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:515:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:515:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:515:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:515:18: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:545:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:545:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:545:9: sparse:     got void *
   drivers/staging/comedi/drivers/das800.c:571:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das800.c:571:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das800.c:571:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das800.c:571:20: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/das1800.c:355:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das1800.c:355:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das1800.c:355:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:355:16: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:416:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das1800.c:416:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das1800.c:416:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:416:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:964:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:964:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:964:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/dt2811.c:187:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2811.c:187:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2811.c:187:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:187:15: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:209:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2811.c:209:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2811.c:209:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:209:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/dt2814.c:62:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2814.c:62:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2814.c:62:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:62:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:79:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2814.c:79:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2814.c:79:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:79:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:85:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:85:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:85:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:85:22: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:86:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:86:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:86:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:86:22: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:182:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:182:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:182:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:182:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:200:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:200:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:200:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:200:14: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:201:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:201:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:201:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:201:14: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:208:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:208:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:208:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:208:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:215:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:215:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:215:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:215:29: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:218:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:218:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:218:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:218:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:219:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:219:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:219:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:219:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:238:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:238:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:238:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:238:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:240:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:240:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:240:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:240:13: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:244:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:244:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:244:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:244:13: sparse:     got void *
   drivers/staging/comedi/drivers/dt2814.c:245:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2814.c:245:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2814.c:245:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2814.c:245:13: sparse:     got void *
--
>> drivers/staging/comedi/drivers/dt2817.c:65:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2817.c:65:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2817.c:65:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:65:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:82:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:82:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:82:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:82:25: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:84:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:84:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:84:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:84:25: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:86:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:86:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:86:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:86:25: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:88:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:88:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:88:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:88:25: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:91:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2817.c:91:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2817.c:91:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:91:15: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:92:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:92:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:92:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:92:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:93:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:93:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:93:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:93:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:94:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:94:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:94:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:94:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2817.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2817.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2817.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2817.c:125:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/dt282x.c:448:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt282x.c:448:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt282x.c:448:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:448:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:508:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt282x.c:508:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt282x.c:508:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:508:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:899:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:899:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:899:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/dmm32at.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dmm32at.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dmm32at.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:167:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:170:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:170:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:170:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:170:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:173:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:173:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:173:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:173:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:174:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:174:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:174:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:174:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:175:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:175:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:175:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:175:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:183:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dmm32at.c:183:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dmm32at.c:183:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:183:15: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:184:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:184:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:184:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:184:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:197:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:197:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:197:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:197:18: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:220:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:220:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:220:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:220:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:344:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:344:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:344:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:344:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:347:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:347:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:347:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:347:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:350:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:350:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:350:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:350:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:351:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:351:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:351:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:351:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:354:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:354:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:354:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:354:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:355:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:355:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:355:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:355:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:356:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:356:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:356:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:356:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:359:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:359:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:359:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:359:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:372:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:372:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:372:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:388:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:388:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:388:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:388:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:389:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:389:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:389:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:389:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:399:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:399:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:399:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:399:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:415:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:415:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:415:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:415:19: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:434:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:434:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:434:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:434:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:445:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:445:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:445:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:445:18: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:464:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:464:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:464:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:464:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:465:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:465:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:465:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:465:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:474:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:474:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:474:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:474:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:486:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:486:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:486:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:486:9: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:489:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:489:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:489:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:489:17: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:492:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:492:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:492:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dmm32at.c:492:16: sparse:     got void *
   drivers/staging/comedi/drivers/dmm32at.c:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dmm32at.c:501:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dmm32at.c:501:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/fl512.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/fl512.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/fl512.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:59:9: sparse:     got void *
   drivers/staging/comedi/drivers/fl512.c:62:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/fl512.c:62:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/fl512.c:62:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:62:17: sparse:     got void *
   drivers/staging/comedi/drivers/fl512.c:67:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/fl512.c:67:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/fl512.c:67:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:67:23: sparse:     got void *
   drivers/staging/comedi/drivers/fl512.c:68:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/fl512.c:68:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/fl512.c:68:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:68:25: sparse:     got void *
   drivers/staging/comedi/drivers/fl512.c:90:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/fl512.c:90:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/fl512.c:90:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:90:17: sparse:     got void *
   drivers/staging/comedi/drivers/fl512.c:91:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/fl512.c:91:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/fl512.c:91:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:91:17: sparse:     got void *
   drivers/staging/comedi/drivers/fl512.c:92:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/fl512.c:92:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/fl512.c:92:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/fl512.c:92:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse:     got void *
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/mpc624.c:122:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/mpc624.c:122:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/mpc624.c:122:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:122:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:136:29: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/mpc624.c:136:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/mpc624.c:136:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:136:29: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adq12b.c:100:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adq12b.c:100:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adq12b.c:100:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:100:18: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:121:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adq12b.c:121:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adq12b.c:121:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:121:17: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse:     got void *
--
>> drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcmad.c:61:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmad.c:61:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmad.c:61:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmad.c:61:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcmad.c:79:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmad.c:79:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmad.c:79:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmad.c:79:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmad.c:85:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmad.c:85:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmad.c:85:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmad.c:85:23: sparse:     got void *
   drivers/staging/comedi/drivers/pcmad.c:86:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmad.c:86:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmad.c:86:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmad.c:86:24: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcmda12.c:71:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmda12.c:71:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmda12.c:71:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:71:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmda12.c:72:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmda12.c:72:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmda12.c:72:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:72:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmda12.c:79:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmda12.c:79:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmda12.c:79:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:79:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmda12.c:98:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmda12.c:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmda12.c:98:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:98:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmda12.c:109:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmda12.c:109:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmda12.c:109:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:109:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmda12.c:110:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmda12.c:110:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmda12.c:110:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:110:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmda12.c:113:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmda12.c:113:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmda12.c:113:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmda12.c:113:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcmuio.c:164:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmuio.c:164:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmuio.c:164:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:164:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:165:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:165:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:165:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:165:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:166:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:166:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:166:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:166:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:168:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:168:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:168:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:169:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:169:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:169:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:169:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:170:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:170:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:170:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:170:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:171:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:171:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:188:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmuio.c:188:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmuio.c:188:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:188:23: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:189:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:189:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:189:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:189:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:190:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:190:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:190:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:190:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:192:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:192:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:192:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:192:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:193:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:193:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:193:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:193:23: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:194:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:194:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:194:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:194:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:195:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:195:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:195:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:195:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmuio.c:346:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmuio.c:346:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmuio.c:346:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmuio.c:346:15: sparse:     got void *
--
>> drivers/staging/comedi/drivers/multiq3.c:77:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/multiq3.c:77:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/multiq3.c:77:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:77:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:88:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/multiq3.c:88:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/multiq3.c:88:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:88:18: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/das08.c:162:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das08.c:162:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das08.c:162:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:162:18: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:184:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:184:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:184:9: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:185:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:185:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:185:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:185:9: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:192:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das08.c:192:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das08.c:192:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:192:9: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:198:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:198:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:198:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:198:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:205:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:205:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:205:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:205:29: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:215:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:215:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:215:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:215:23: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:216:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:216:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:216:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:216:23: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:256:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:256:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:256:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:256:19: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:272:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:272:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:272:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:272:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:286:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:286:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:286:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:286:19: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:296:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:296:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:296:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:296:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:313:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:313:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:313:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:313:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:314:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:314:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:314:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:314:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:316:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:316:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:316:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:316:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:318:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:318:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:318:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:318:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:319:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:319:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:319:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:319:17: sparse:     got void *
   drivers/staging/comedi/drivers/das08.c:321:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das08.c:321:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das08.c:321:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das08.c:321:17: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
>> drivers/staging/speakup/serialio.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/speakup/serialio.c:139:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/speakup/serialio.c:139:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:139:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:142:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:142:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:142:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:142:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/speakup/serialio.c:144:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/speakup/serialio.c:144:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:144:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:145:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:145:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:146:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:146:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:146:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:146:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:147:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:147:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:148:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:148:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:148:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:155:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:155:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:155:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:155:16: sparse:     got void *
   drivers/staging/speakup/serialio.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:160:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:165:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:165:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:165:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:165:19: sparse:     got void *
   drivers/staging/speakup/serialio.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:167:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:87:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:88:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:88:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:88:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:89:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:89:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:89:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:89:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:90:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:90:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:90:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:90:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:93:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:93:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:93:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:94:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:94:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:94:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:94:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:97:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:97:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:97:13: sparse:     got void *
   drivers/staging/speakup/serialio.c:208:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:208:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:208:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:208:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:230:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:230:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:230:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:230:16: sparse:     got void *
   drivers/staging/speakup/serialio.c:299:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:299:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:299:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:299:25: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/media/radio/radio-maxiradio.c:94:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/media/radio/radio-maxiradio.c:94:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/media/radio/radio-maxiradio.c:94:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/media/radio/radio-maxiradio.c:94:9: sparse:     got void *
   drivers/media/radio/radio-maxiradio.c:102:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/media/radio/radio-maxiradio.c:102:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/media/radio/radio-maxiradio.c:102:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/media/radio/radio-maxiradio.c:102:19: sparse:     got void *
   drivers/media/radio/radio-maxiradio.c:184:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/media/radio/radio-maxiradio.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/media/radio/radio-maxiradio.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/media/radio/radio-maxiradio.c:184:9: sparse:     got void *
--
>> drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse:     got void *
--
>> drivers/scsi/advansys.c:3660:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/advansys.c:3660:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/advansys.c:3660:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3660:15: sparse:     got void *
   drivers/scsi/advansys.c:3671:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/advansys.c:3671:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/advansys.c:3671:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3671:9: sparse:     got void *
   drivers/scsi/advansys.c:3677:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3677:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3677:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3677:9: sparse:     got void *
   drivers/scsi/advansys.c:3683:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3683:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3683:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3683:9: sparse:     got void *
   drivers/scsi/advansys.c:3684:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3684:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3684:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3684:14: sparse:     got void *
   drivers/scsi/advansys.c:3695:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3695:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3695:13: sparse:     got void *
   drivers/scsi/advansys.c:3697:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3697:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3697:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3697:9: sparse:     got void *
   drivers/scsi/advansys.c:3700:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3700:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3700:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3700:14: sparse:     got void *
   drivers/scsi/advansys.c:3708:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3708:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3708:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3708:14: sparse:     got void *
   drivers/scsi/advansys.c:3709:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3709:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3709:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3709:22: sparse:     got void *
   drivers/scsi/advansys.c:3722:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3722:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3722:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3722:17: sparse:     got void *
   drivers/scsi/advansys.c:3727:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3727:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3727:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3727:9: sparse:     got void *
   drivers/scsi/advansys.c:3731:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3731:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3731:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3731:9: sparse:     got void *
   drivers/scsi/advansys.c:3732:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3732:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3732:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3732:9: sparse:     got void *
   drivers/scsi/advansys.c:3734:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3734:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3734:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3734:9: sparse:     got void *
   drivers/scsi/advansys.c:3735:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3735:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3735:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3735:9: sparse:     got void *
   drivers/scsi/advansys.c:3745:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3745:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3745:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3745:13: sparse:     got void *
   drivers/scsi/advansys.c:3748:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3748:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3748:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3748:28: sparse:     got void *
   drivers/scsi/advansys.c:3761:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3761:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3761:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3761:15: sparse:     got void *
   drivers/scsi/advansys.c:3762:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3762:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3762:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3762:9: sparse:     got void *
   drivers/scsi/advansys.c:3769:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3769:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3769:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3769:15: sparse:     got void *
   drivers/scsi/advansys.c:3770:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3770:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3770:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3770:9: sparse:     got void *
   drivers/scsi/advansys.c:3779:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3779:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3779:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3779:17: sparse:     got void *
   drivers/scsi/advansys.c:3780:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3780:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3780:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3780:29: sparse:     got void *
   drivers/scsi/advansys.c:3783:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3783:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3783:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3783:17: sparse:     got void *
   drivers/scsi/advansys.c:3784:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3784:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3784:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/advansys.c:3784:29: sparse:     got void *
   drivers/scsi/advansys.c:3794:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/advansys.c:3794:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/advansys.c:3794:9: sparse:     expected void volatile [noderef] __iomem *addr
--
   drivers/scsi/ips.c:2469:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:3557:59: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3557:59: sparse:     expected unsigned int [usertype] sg_addr
   drivers/scsi/ips.c:3557:59: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3566:59: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3566:59: sparse:     expected unsigned int [usertype] sg_addr
   drivers/scsi/ips.c:3566:59: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3576:47: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 [usertype] *var @@     got unsigned int * @@
   drivers/scsi/ips.c:3576:47: sparse:     expected restricted __le32 [usertype] *var
   drivers/scsi/ips.c:3576:47: sparse:     got unsigned int *
   drivers/scsi/ips.c:3577:49: sparse: sparse: cast to restricted __le16
   drivers/scsi/ips.c:3586:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] sector_count @@     got restricted __le16 [usertype] @@
   drivers/scsi/ips.c:3586:56: sparse:     expected unsigned short [usertype] sector_count
   drivers/scsi/ips.c:3586:56: sparse:     got restricted __le16 [usertype]
   drivers/scsi/ips.c:3589:29: sparse: sparse: cast to restricted __le16
   drivers/scsi/ips.c:3590:64: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] sector_count @@     got restricted __le16 [usertype] @@
   drivers/scsi/ips.c:3590:64: sparse:     expected unsigned short [usertype] sector_count
   drivers/scsi/ips.c:3590:64: sparse:     got restricted __le16 [usertype]
   drivers/scsi/ips.c:3603:59: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3603:59: sparse:     expected unsigned int [usertype] sg_addr
   drivers/scsi/ips.c:3603:59: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3612:59: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg_addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3612:59: sparse:     expected unsigned int [usertype] sg_addr
   drivers/scsi/ips.c:3612:59: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3622:47: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 [usertype] *var @@     got unsigned int * @@
   drivers/scsi/ips.c:3622:47: sparse:     expected restricted __le32 [usertype] *var
   drivers/scsi/ips.c:3622:47: sparse:     got unsigned int *
   drivers/scsi/ips.c:3623:49: sparse: sparse: cast to restricted __le16
   drivers/scsi/ips.c:3634:56: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] sector_count @@     got restricted __le16 [usertype] @@
   drivers/scsi/ips.c:3634:56: sparse:     expected unsigned short [usertype] sector_count
   drivers/scsi/ips.c:3634:56: sparse:     got restricted __le16 [usertype]
   drivers/scsi/ips.c:3721:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dcdb_address @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3721:44: sparse:     expected unsigned int [usertype] dcdb_address
   drivers/scsi/ips.c:3721:44: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3762:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buffer_pointer @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3762:58: sparse:     expected unsigned int [usertype] buffer_pointer
   drivers/scsi/ips.c:3762:58: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3765:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buffer_pointer @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3765:58: sparse:     expected unsigned int [usertype] buffer_pointer
   drivers/scsi/ips.c:3765:58: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3799:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buffer_pointer @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3799:58: sparse:     expected unsigned int [usertype] buffer_pointer
   drivers/scsi/ips.c:3799:58: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:3802:58: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buffer_pointer @@     got restricted __le32 [usertype] @@
   drivers/scsi/ips.c:3802:58: sparse:     expected unsigned int [usertype] buffer_pointer
   drivers/scsi/ips.c:3802:58: sparse:     got restricted __le32 [usertype]
   drivers/scsi/ips.c:4068:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4068:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4068:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4068:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4068:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4068:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4067:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lba @@     got restricted __be32 [usertype] @@
   drivers/scsi/ips.c:4067:17: sparse:     expected unsigned int [usertype] lba
   drivers/scsi/ips.c:4067:17: sparse:     got restricted __be32 [usertype]
   drivers/scsi/ips.c:4071:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __be32 [usertype] @@
   drivers/scsi/ips.c:4071:17: sparse:     expected unsigned int [usertype] len
   drivers/scsi/ips.c:4071:17: sparse:     got restricted __be32 [usertype]
   drivers/scsi/ips.c:4097:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4107:14: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4124:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] SectorsPerTrack @@     got restricted __be16 [usertype] @@
   drivers/scsi/ips.c:4124:49: sparse:     expected unsigned short [addressable] [assigned] [usertype] SectorsPerTrack
   drivers/scsi/ips.c:4124:49: sparse:     got restricted __be16 [usertype]
   drivers/scsi/ips.c:4125:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] BytesPerSector @@     got restricted __be16 [usertype] @@
   drivers/scsi/ips.c:4125:48: sparse:     expected unsigned short [addressable] [assigned] [usertype] BytesPerSector
   drivers/scsi/ips.c:4125:48: sparse:     got restricted __be16 [usertype]
   drivers/scsi/ips.c:4126:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] Interleave @@     got restricted __be16 [usertype] @@
   drivers/scsi/ips.c:4126:44: sparse:     expected unsigned short [addressable] [assigned] [usertype] Interleave
   drivers/scsi/ips.c:4126:44: sparse:     got restricted __be16 [usertype]
   drivers/scsi/ips.c:4137:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] CylindersHigh @@     got restricted __be16 [usertype] @@
   drivers/scsi/ips.c:4137:47: sparse:     expected unsigned short [addressable] [assigned] [usertype] CylindersHigh
   drivers/scsi/ips.c:4137:47: sparse:     got restricted __be16 [usertype]
   drivers/scsi/ips.c:4145:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] StepRate @@     got restricted __be16 [usertype] @@
   drivers/scsi/ips.c:4145:42: sparse:     expected unsigned short [addressable] [assigned] [usertype] StepRate
   drivers/scsi/ips.c:4145:42: sparse:     got restricted __be16 [usertype]
>> drivers/scsi/ips.c:5015:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/ips.c:5015:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/ips.c:5015:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5015:17: sparse:     got void *
   drivers/scsi/ips.c:5020:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:5020:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:5020:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5020:17: sparse:     got void *
   drivers/scsi/ips.c:5294:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/ips.c:5294:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/ips.c:5294:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5294:17: sparse:     got void *
   drivers/scsi/ips.c:5294:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:5310:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:5310:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:5310:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5310:9: sparse:     got void *
   drivers/scsi/ips.c:5311:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:5311:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:5311:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5311:9: sparse:     got void *
   drivers/scsi/ips.c:5396:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:5396:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:5396:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5396:9: sparse:     got void *
   drivers/scsi/ips.c:5449:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:5449:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:5449:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5449:15: sparse:     got void *
   drivers/scsi/ips.c:5460:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:5460:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:5460:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:5460:17: sparse:     got void *
   drivers/scsi/ips.c:5604:13: sparse: sparse: cast to restricted __le32
   drivers/scsi/ips.c:4707:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4707:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4707:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4707:31: sparse:     got void *
   drivers/scsi/ips.c:4719:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4719:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4719:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4719:31: sparse:     got void *
   drivers/scsi/ips.c:4720:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4720:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4720:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4720:17: sparse:     got void *
   drivers/scsi/ips.c:4733:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4733:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4733:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4733:31: sparse:     got void *
   drivers/scsi/ips.c:4745:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4745:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4745:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4745:33: sparse:     got void *
   drivers/scsi/ips.c:4746:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4746:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4746:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4746:17: sparse:     got void *
   drivers/scsi/ips.c:4750:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4750:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4750:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4750:24: sparse:     got void *
   drivers/scsi/ips.c:4764:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4764:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4764:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4764:9: sparse:     got void *
   drivers/scsi/ips.c:4767:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4767:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4767:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4767:9: sparse:     got void *
   drivers/scsi/ips.c:4771:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4771:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4771:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4771:17: sparse:     got void *
   drivers/scsi/ips.c:4774:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4774:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4774:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4774:9: sparse:     got void *
   drivers/scsi/ips.c:4475:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4475:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4475:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4475:15: sparse:     got void *
   drivers/scsi/ips.c:4476:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:4476:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:4476:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:4476:16: sparse:     got void *
   drivers/scsi/ips.c:6023:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:6023:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:6023:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:6023:9: sparse:     got void *
   drivers/scsi/ips.c:6027:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:6027:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:6027:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:6027:9: sparse:     got void *
   drivers/scsi/ips.c:6032:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:6032:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:6032:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:6032:9: sparse:     got void *
   drivers/scsi/ips.c:6037:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:6037:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:6037:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:6037:9: sparse:     got void *
   drivers/scsi/ips.c:6042:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:6042:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:6042:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:6042:9: sparse:     got void *
   drivers/scsi/ips.c:6050:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/ips.c:6050:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/ips.c:6050:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/ips.c:6050:25: sparse:     got void *
   drivers/scsi/ips.c:6054:26: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/scsi/fdomain.c:132:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/fdomain.c:132:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/fdomain.c:132:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:132:18: sparse:     got void *
   drivers/scsi/fdomain.c:132:43: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:132:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:132:43: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:132:43: sparse:     got void *
   drivers/scsi/fdomain.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/fdomain.c:144:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/fdomain.c:144:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:144:9: sparse:     got void *
   drivers/scsi/fdomain.c:145:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:145:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:145:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:145:14: sparse:     got void *
   drivers/scsi/fdomain.c:146:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:146:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:146:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:146:17: sparse:     got void *
   drivers/scsi/fdomain.c:147:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:147:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:147:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:147:22: sparse:     got void *
   drivers/scsi/fdomain.c:159:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:159:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:159:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:159:17: sparse:     got void *
   drivers/scsi/fdomain.c:160:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:160:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:160:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:160:21: sparse:     got void *
   drivers/scsi/fdomain.c:169:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:169:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:169:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:169:9: sparse:     got void *
   drivers/scsi/fdomain.c:171:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:171:9: sparse:     got void *
   drivers/scsi/fdomain.c:173:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:173:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:173:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:173:9: sparse:     got void *
   drivers/scsi/fdomain.c:174:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:174:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:174:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:174:9: sparse:     got void *
   drivers/scsi/fdomain.c:183:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:183:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:183:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:183:9: sparse:     got void *
   drivers/scsi/fdomain.c:184:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:184:9: sparse:     got void *
   drivers/scsi/fdomain.c:187:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:187:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:187:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:187:9: sparse:     got void *
   drivers/scsi/fdomain.c:192:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:192:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:192:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:192:26: sparse:     got void *
   drivers/scsi/fdomain.c:196:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:196:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:196:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:196:25: sparse:     got void *
   drivers/scsi/fdomain.c:207:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:207:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:207:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:207:9: sparse:     got void *
   drivers/scsi/fdomain.c:220:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:220:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:220:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:220:23: sparse:     got void *
   drivers/scsi/fdomain.c:226:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:226:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:226:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:226:34: sparse:     got void *
   drivers/scsi/fdomain.c:242:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:242:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:242:35: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:242:35: sparse:     got void *
   drivers/scsi/fdomain.c:253:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:253:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:253:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:253:25: sparse:     got void *
   drivers/scsi/fdomain.c:274:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:274:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:274:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:274:26: sparse:     got void *
   drivers/scsi/fdomain.c:281:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:281:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:281:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:281:17: sparse:     got void *
   drivers/scsi/fdomain.c:282:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:282:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:282:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:282:17: sparse:     got void *
   drivers/scsi/fdomain.c:283:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:283:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:283:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:283:17: sparse:     got void *
   drivers/scsi/fdomain.c:286:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:286:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:286:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/fdomain.c:286:17: sparse:     got void *
   drivers/scsi/fdomain.c:289:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/fdomain.c:289:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/fdomain.c:289:26: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/scsi/NCR5380.c:436:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/NCR5380.c:436:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/NCR5380.c:436:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:436:9: sparse:     got void *
   drivers/scsi/NCR5380.c:437:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:437:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:437:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:437:9: sparse:     got void *
   drivers/scsi/NCR5380.c:438:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:438:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:438:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:438:9: sparse:     got void *
   drivers/scsi/NCR5380.c:439:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:439:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:439:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:439:9: sparse:     got void *
   drivers/scsi/NCR5380.c:449:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/NCR5380.c:449:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/NCR5380.c:449:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:449:17: sparse:     got void *
   drivers/scsi/NCR5380.c:478:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:478:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:478:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:478:25: sparse:     got void *
   drivers/scsi/NCR5380.c:1686:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1686:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1686:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1686:23: sparse:     got void *
   drivers/scsi/NCR5380.c:1719:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1719:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1719:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1719:33: sparse:     got void *
   drivers/scsi/NCR5380.c:1721:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1721:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1721:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1721:33: sparse:     got void *
   drivers/scsi/NCR5380.c:1723:40: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1723:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1723:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1723:40: sparse:     got void *
   drivers/scsi/NCR5380.c:1725:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1725:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1725:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1725:33: sparse:     got void *
   drivers/scsi/NCR5380.c:1811:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1811:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1811:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1811:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1842:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1842:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1842:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1842:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1848:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1848:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1848:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1848:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1862:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1862:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1862:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1862:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1873:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1873:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1873:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1873:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1892:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1892:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1892:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1892:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1901:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1901:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1901:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1901:41: sparse:     got void *
   drivers/scsi/NCR5380.c:1918:49: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1918:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1918:49: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1918:49: sparse:     got void *
   drivers/scsi/NCR5380.c:1962:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:1962:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:1962:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:1962:41: sparse:     got void *
   drivers/scsi/NCR5380.c:872:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:872:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:872:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:872:16: sparse:     got void *
   drivers/scsi/NCR5380.c:874:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:874:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:874:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:874:36: sparse:     got void *
   drivers/scsi/NCR5380.c:875:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:875:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:875:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:875:36: sparse:     got void *
   drivers/scsi/NCR5380.c:892:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:892:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:892:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:892:33: sparse:     got void *
   drivers/scsi/NCR5380.c:893:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:893:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:893:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:893:33: sparse:     got void *
   drivers/scsi/NCR5380.c:895:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:895:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:895:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:895:29: sparse:     got void *
   drivers/scsi/NCR5380.c:898:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:898:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:898:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:898:25: sparse:     got void *
   drivers/scsi/NCR5380.c:899:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:899:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:899:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:899:25: sparse:     got void *
   drivers/scsi/NCR5380.c:908:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:908:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:908:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/NCR5380.c:908:33: sparse:     got void *
   drivers/scsi/NCR5380.c:911:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/NCR5380.c:911:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/NCR5380.c:911:25: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/scsi/dc395x.c:1931:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/dc395x.c:1931:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/dc395x.c:1931:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1931:9: sparse:     got void *
   drivers/scsi/dc395x.c:1949:35: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/dc395x.c:1949:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/dc395x.c:1949:35: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1949:35: sparse:     got void *
   drivers/scsi/dc395x.c:1976:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1976:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1976:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1976:29: sparse:     got void *
   drivers/scsi/dc395x.c:2081:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2081:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2081:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2081:23: sparse:     got void *
   drivers/scsi/dc395x.c:2106:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2106:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2106:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2106:22: sparse:     got void *
   drivers/scsi/dc395x.c:2107:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2107:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2107:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2107:22: sparse:     got void *
   drivers/scsi/dc395x.c:2137:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2137:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2137:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2137:33: sparse:     got void *
   drivers/scsi/dc395x.c:2156:48: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2156:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2156:48: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2156:48: sparse:     got void *
   drivers/scsi/dc395x.c:2167:46: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2167:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2167:46: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2167:46: sparse:     got void *
   drivers/scsi/dc395x.c:2180:59: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2180:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2180:59: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2180:59: sparse:     got void *
   drivers/scsi/dc395x.c:2188:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2188:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2188:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2188:41: sparse:     got void *
   drivers/scsi/dc395x.c:1755:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1755:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1755:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1755:9: sparse:     got void *
   drivers/scsi/dc395x.c:2448:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2448:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2448:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2448:30: sparse:     got void *
   drivers/scsi/dc395x.c:2449:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2449:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2449:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2449:28: sparse:     got void *
   drivers/scsi/dc395x.c:2452:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2452:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2452:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2452:9: sparse:     got void *
   drivers/scsi/dc395x.c:2453:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2453:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2453:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2453:9: sparse:     got void *
   drivers/scsi/dc395x.c:1713:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1713:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1713:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1713:9: sparse:     got void *
   drivers/scsi/dc395x.c:2734:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2734:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2734:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2734:42: sparse:     got void *
   drivers/scsi/dc395x.c:2751:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2751:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2751:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2751:25: sparse:     got void *
   drivers/scsi/dc395x.c:2822:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2822:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2822:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2822:33: sparse:     got void *
   drivers/scsi/dc395x.c:2834:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2834:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2834:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2834:9: sparse:     got void *
   drivers/scsi/dc395x.c:2835:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:2835:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:2835:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:2835:9: sparse:     got void *
   drivers/scsi/dc395x.c:1768:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1768:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1768:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1768:9: sparse:     got void *
   drivers/scsi/dc395x.c:1772:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1772:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1772:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1772:25: sparse:     got void *
   drivers/scsi/dc395x.c:1776:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1776:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1776:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1776:17: sparse:     got void *
   drivers/scsi/dc395x.c:1779:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1779:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1779:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/dc395x.c:1779:17: sparse:     got void *
   drivers/scsi/dc395x.c:1780:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/dc395x.c:1780:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/dc395x.c:1780:17: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/scsi/megaraid.c:157:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid.c:157:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:157:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:157:17: sparse:     got void *
   drivers/scsi/megaraid.c:160:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid.c:160:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:160:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:160:17: sparse:     got void *
   drivers/scsi/megaraid.c:163:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid.c:163:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:163:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:163:17: sparse:     got void *
   drivers/scsi/megaraid.c:166:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid.c:166:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:166:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:166:17: sparse:     got void *
   drivers/scsi/megaraid.c:169:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid.c:169:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:169:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:169:17: sparse:     got void *
   drivers/scsi/megaraid.c:3533:29: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/megaraid.c:3550:29: sparse: sparse: Using plain integer as NULL pointer
   drivers/scsi/megaraid.c:4489:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4489:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4489:26: sparse:     got void *
   drivers/scsi/megaraid.c:4548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4548:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4548:26: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
   drivers/scsi/atp870u.c:863:59: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/atp870u.c:863:59: sparse:     expected unsigned int [usertype]
   drivers/scsi/atp870u.c:863:59: sparse:     got restricted __le32 [usertype]
   drivers/scsi/atp870u.c:868:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/atp870u.c:868:51: sparse:     expected unsigned int [usertype]
   drivers/scsi/atp870u.c:868:51: sparse:     got restricted __le32 [usertype]
   drivers/scsi/atp870u.c:869:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/scsi/atp870u.c:869:50: sparse:     expected unsigned short [usertype]
   drivers/scsi/atp870u.c:869:50: sparse:     got restricted __le16 [usertype]
   drivers/scsi/atp870u.c:873:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/scsi/atp870u.c:873:42: sparse:     expected unsigned short [usertype]
   drivers/scsi/atp870u.c:873:42: sparse:     got restricted __le16 [usertype]
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:104:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:104:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:104:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:104:16: sparse:     got void *
   drivers/scsi/atp870u.c:104:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:104:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:104:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:104:16: sparse:     got void *
   drivers/scsi/atp870u.c:104:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:104:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:104:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:104:16: sparse:     got void *
   drivers/scsi/atp870u.c:69:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:69:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:69:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:69:9: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:69:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:69:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:69:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:69:9: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:79:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:79:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:79:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:79:16: sparse:     got void *
   drivers/scsi/atp870u.c:49:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:49:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:49:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:49:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:94:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:94:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:94:16: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:59:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/atp870u.c:59:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/atp870u.c:59:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:59:9: sparse:     got void *
   drivers/scsi/atp870u.c:104:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:104:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:104:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:104:16: sparse:     got void *
   drivers/scsi/atp870u.c:69:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:69:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/atp870u.c:69:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/atp870u.c:69:9: sparse:     got void *
   drivers/scsi/atp870u.c:79:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/atp870u.c:79:16: sparse: sparse: too many warnings
--
   drivers/scsi/nsp32.c:874:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:874:37: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/nsp32.c:874:37: sparse:     got restricted __le32 [usertype]
   drivers/scsi/nsp32.c:875:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:875:37: sparse:     expected unsigned int [usertype] len
   drivers/scsi/nsp32.c:875:37: sparse:     got restricted __le32 [usertype]
   drivers/scsi/nsp32.c:877:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:878:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:890:21: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:891:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:891:32: sparse:     expected unsigned int [usertype] len
   drivers/scsi/nsp32.c:891:32: sparse:     got restricted __le32 [usertype]
   drivers/scsi/nsp32.c:510:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] msgout @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:510:23: sparse:     expected unsigned int [usertype] msgout
   drivers/scsi/nsp32.c:510:23: sparse:     got restricted __le32 [usertype]
   drivers/scsi/nsp32.c:521:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] command_control @@     got restricted __le16 [usertype] @@
   drivers/scsi/nsp32.c:521:32: sparse:     expected unsigned short [usertype] command_control
   drivers/scsi/nsp32.c:521:32: sparse:     got restricted __le16 [usertype]
   drivers/scsi/nsp32.c:549:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] transfer_control @@     got restricted __le16 [usertype] @@
   drivers/scsi/nsp32.c:549:33: sparse:     expected unsigned short [usertype] transfer_control
   drivers/scsi/nsp32.c:549:33: sparse:     got restricted __le16 [usertype]
   drivers/scsi/nsp32.c:552:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgt_pointer @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:552:28: sparse:     expected unsigned int [usertype] sgt_pointer
   drivers/scsi/nsp32.c:552:28: sparse:     got restricted __le32 [usertype]
   drivers/scsi/nsp32.c:1719:22: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:1727:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:1748:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:1749:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/nsp32.c:1751:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:1751:29: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/nsp32.c:1751:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/nsp32.c:1752:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/nsp32.c:1752:29: sparse:     expected unsigned int [usertype] len
   drivers/scsi/nsp32.c:1752:29: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:22:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:22:16: sparse:     got void *
   drivers/scsi/nsp32_io.h:42:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:42:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:42:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:42:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:22:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:22:16: sparse:     got void *
   drivers/scsi/nsp32_io.h:35:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:35:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:35:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:35:16: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:42:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:42:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:42:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:42:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:42:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:42:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:42:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:42:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:42:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:42:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:42:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:42:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:22:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:22:16: sparse:     got void *
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:129:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:130:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:16:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:16:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:16:9: sparse:     got void *
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:22:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:22:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:22:16: sparse:     got void *
   drivers/scsi/nsp32_io.h:42:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:42:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:42:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:42:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:153:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:153:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:153:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:153:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:154:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:154:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:154:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:154:13: sparse:     got void *
   drivers/scsi/nsp32_io.h:155:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:155:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:155:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:155:13: sparse:     got void *
   drivers/scsi/nsp32_io.h:144:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:144:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:144:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:144:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:145:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:145:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:145:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:42:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/nsp32_io.h:42:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/nsp32_io.h:42:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:42:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:29:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:29:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:29:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:35:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:35:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:35:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:35:16: sparse:     got void *
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:129:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:130:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:129:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:130:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:129:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/nsp32_io.h:129:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/nsp32_io.h:129:9: sparse:     got void *
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/nsp32_io.h:130:9: sparse: sparse: too many warnings
--
>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:161:16: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:161:16: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:161:16: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:161:16: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:161:16: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:161:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:161:16: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
   drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tdfxfb.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tdfxfb.c:166:9: sparse:     got void *
--
   drivers/video/fbdev/vt8623fb.c:161:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:182:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:217:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:527:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/vt8623fb.c:527:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/vt8623fb.c:527:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:527:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:528:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:528:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:528:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:528:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:529:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:529:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:529:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:529:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:530:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:530:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:530:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:530:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:531:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:531:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:531:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:531:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:537:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:537:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:537:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:537:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:538:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:538:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:538:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:538:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:539:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:539:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:539:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:539:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:540:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:540:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:540:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:540:17: sparse:     got void *
   drivers/video/fbdev/vt8623fb.c:541:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:541:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/vt8623fb.c:541:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/vt8623fb.c:541:17: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/video/fbdev/cyber2000fb.c:1683:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/cyber2000fb.c:1683:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/cyber2000fb.c:1683:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/cyber2000fb.c:1683:9: sparse:     got void *
   drivers/video/fbdev/cyber2000fb.c:1684:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cyber2000fb.c:1684:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/cyber2000fb.c:1684:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/cyber2000fb.c:1684:9: sparse:     got void *
   drivers/video/fbdev/cyber2000fb.c:1685:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cyber2000fb.c:1685:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/cyber2000fb.c:1685:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/cyber2000fb.c:1685:9: sparse:     got void *
   drivers/video/fbdev/cyber2000fb.c:1686:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cyber2000fb.c:1686:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/cyber2000fb.c:1686:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/cyber2000fb.c:1686:9: sparse:     got void *
   drivers/video/fbdev/cyber2000fb.c:1687:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/cyber2000fb.c:1687:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/cyber2000fb.c:1687:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/cyber2000fb.c:1687:9: sparse:     got void *
--
>> drivers/gpu/drm/bochs/bochs_hw.c:23:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpu/drm/bochs/bochs_hw.c:23:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/gpu/drm/bochs/bochs_hw.c:23:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/bochs/bochs_hw.c:23:17: sparse:     got void *
   drivers/gpu/drm/bochs/bochs_hw.c:35:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/bochs/bochs_hw.c:35:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/bochs/bochs_hw.c:35:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/bochs/bochs_hw.c:35:17: sparse:     got void *
   drivers/gpu/drm/bochs/bochs_hw.c:36:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpu/drm/bochs/bochs_hw.c:36:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/gpu/drm/bochs/bochs_hw.c:36:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/bochs/bochs_hw.c:36:23: sparse:     got void *
   drivers/gpu/drm/bochs/bochs_hw.c:47:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/bochs/bochs_hw.c:47:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/bochs/bochs_hw.c:47:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/bochs/bochs_hw.c:47:17: sparse:     got void *
   drivers/gpu/drm/bochs/bochs_hw.c:48:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/bochs/bochs_hw.c:48:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/bochs/bochs_hw.c:48:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/bochs/bochs_hw.c:48:17: sparse:     got void *
--
>> sound/pci/ens1370.c:2321:18: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ens1370.c:2321:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ens1370.c:2321:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:2321:18: sparse:     got void *
   sound/pci/ens1370.c:2333:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ens1370.c:2333:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ens1370.c:2333:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:2333:9: sparse:     got void *
   sound/pci/ens1370.c:2334:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:2334:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:2334:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:2334:9: sparse:     got void *
   sound/pci/ens1370.c:509:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:509:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:509:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:509:21: sparse:     got void *
   sound/pci/ens1370.c:530:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:530:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:530:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:530:9: sparse:     got void *
   sound/pci/ens1370.c:538:32: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:538:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:538:32: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:538:32: sparse:     got void *
   sound/pci/ens1370.c:548:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:548:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:548:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:548:9: sparse:     got void *
   sound/pci/ens1370.c:562:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:562:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:562:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:562:9: sparse:     got void *
   sound/pci/ens1370.c:609:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:609:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:609:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:609:23: sparse:     got void *
   sound/pci/ens1370.c:612:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:612:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:612:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:612:25: sparse:     got void *
   sound/pci/ens1370.c:618:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:618:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:618:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:618:38: sparse:     got void *
   sound/pci/ens1370.c:624:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:624:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:624:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:624:38: sparse:     got void *
   sound/pci/ens1370.c:628:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:628:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:628:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:628:25: sparse:     got void *
   sound/pci/ens1370.c:632:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:632:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:632:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:632:25: sparse:     got void *
   sound/pci/ens1370.c:638:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:638:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:638:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:638:9: sparse:     got void *
   sound/pci/ens1370.c:652:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:652:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:652:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:652:23: sparse:     got void *
   sound/pci/ens1370.c:655:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:655:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:655:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:655:25: sparse:     got void *
   sound/pci/ens1370.c:661:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:661:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:661:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:661:38: sparse:     got void *
   sound/pci/ens1370.c:667:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:667:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:667:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:667:38: sparse:     got void *
   sound/pci/ens1370.c:671:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:671:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:671:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:671:25: sparse:     got void *
   sound/pci/ens1370.c:675:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:675:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:675:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:675:25: sparse:     got void *
   sound/pci/ens1370.c:678:39: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:678:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:678:39: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:678:39: sparse:     got void *
   sound/pci/ens1370.c:683:42: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:683:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:683:42: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:683:42: sparse:     got void *
   sound/pci/ens1370.c:686:57: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:686:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:686:57: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:686:57: sparse:     got void *
   sound/pci/ens1370.c:687:53: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:687:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:687:53: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:687:53: sparse:     got void *
   sound/pci/ens1370.c:695:33: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:695:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:695:33: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:695:33: sparse:     got void *
   sound/pci/ens1370.c:705:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:705:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:705:9: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pci/via82xx.c:599:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/via82xx.c:599:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/via82xx.c:599:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:599:9: sparse:     got void *
   sound/pci/via82xx.c:601:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/via82xx.c:601:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/via82xx.c:601:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:601:9: sparse:     got void *
   sound/pci/via82xx.c:604:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:604:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:604:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:604:9: sparse:     got void *
   sound/pci/via82xx.c:606:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:606:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:606:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:606:9: sparse:     got void *
   sound/pci/via82xx.c:607:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:607:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:607:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:607:9: sparse:     got void *
   sound/pci/via82xx.c:624:18: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:624:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:624:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:624:18: sparse:     got void *
   sound/pci/via82xx.c:636:42: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:636:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:636:42: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:636:42: sparse:     got void *
   sound/pci/via82xx.c:655:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:655:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:655:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:655:17: sparse:     got void *
   sound/pci/via82xx.c:673:18: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:673:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:673:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:673:18: sparse:     got void *
   sound/pci/via82xx.c:708:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:708:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:708:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:708:17: sparse:     got void *
   sound/pci/via82xx.c:753:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:753:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:753:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:753:9: sparse:     got void *
   sound/pci/via82xx.c:835:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:835:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:835:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:835:15: sparse:     got void *
   sound/pci/via82xx.c:839:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:839:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:839:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:839:17: sparse:     got void *
   sound/pci/via82xx.c:843:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:843:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:843:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:843:15: sparse:     got void *
   sound/pci/via82xx.c:869:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:869:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:869:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:869:17: sparse:     got void *
   sound/pci/via82xx.c:872:26: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:872:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:872:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:872:26: sparse:     got void *
   sound/pci/via82xx.c:950:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:950:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:950:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:950:9: sparse:     got void *
   sound/pci/via82xx.c:964:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:964:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:964:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:964:9: sparse:     got void *
   sound/pci/via82xx.c:1043:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1043:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1043:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1043:9: sparse:     got void *
   sound/pci/via82xx.c:1045:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1045:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1045:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1045:9: sparse:     got void *
   sound/pci/via82xx.c:1047:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1047:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1047:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1047:9: sparse:     got void *
   sound/pci/via82xx.c:1080:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1080:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1080:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1080:9: sparse:     got void *
   sound/pci/via82xx.c:1100:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1100:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1100:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1100:9: sparse:     got void *
   sound/pci/via82xx.c:1120:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1120:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1120:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1120:9: sparse:     got void *
   sound/pci/via82xx.c:1121:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1121:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1121:9: sparse:     got void *
   sound/pci/via82xx.c:1595:46: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1595:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1595:46: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx.c:1595:46: sparse:     got void *
   sound/pci/via82xx.c:1607:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx.c:1607:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx.c:1607:16: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pci/via82xx_modem.c:414:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/via82xx_modem.c:414:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/via82xx_modem.c:414:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:414:17: sparse:     got void *
   sound/pci/via82xx_modem.c:455:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:455:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:455:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:455:9: sparse:     got void *
   sound/pci/via82xx_modem.c:457:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/via82xx_modem.c:457:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/via82xx_modem.c:457:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:457:9: sparse:     got void *
   sound/pci/via82xx_modem.c:460:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:460:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:460:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:460:9: sparse:     got void *
   sound/pci/via82xx_modem.c:462:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:462:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:462:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:462:9: sparse:     got void *
   sound/pci/via82xx_modem.c:463:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:463:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:463:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:463:9: sparse:     got void *
   sound/pci/via82xx_modem.c:479:18: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:479:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:479:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:479:18: sparse:     got void *
   sound/pci/via82xx_modem.c:489:42: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:489:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:489:42: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:489:42: sparse:     got void *
   sound/pci/via82xx_modem.c:498:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:498:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:498:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:498:17: sparse:     got void *
   sound/pci/via82xx_modem.c:537:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:537:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:537:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:537:9: sparse:     got void *
   sound/pci/via82xx_modem.c:616:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:616:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:616:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:616:15: sparse:     got void *
   sound/pci/via82xx_modem.c:620:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:620:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:620:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:620:17: sparse:     got void *
   sound/pci/via82xx_modem.c:624:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:624:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:624:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:624:15: sparse:     got void *
   sound/pci/via82xx_modem.c:679:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:679:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:679:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:679:9: sparse:     got void *
   sound/pci/via82xx_modem.c:695:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:695:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:695:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:695:9: sparse:     got void *
   sound/pci/via82xx_modem.c:911:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:911:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:911:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:911:17: sparse:     got void *
   sound/pci/via82xx_modem.c:1000:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:1000:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:1000:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:1000:9: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:358:16: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:358:16: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:358:16: sparse:     got void *
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:363:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:363:9: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:358:16: sparse:     got void *
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:363:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:363:9: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:358:16: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:358:16: sparse:     got void *
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:363:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:363:9: sparse:     got void *
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:363:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:363:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/via82xx_modem.c:363:9: sparse:     got void *
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/via82xx_modem.c:358:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/via82xx_modem.c:358:16: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pci/ens1370.c:2321:18: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ens1370.c:2321:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ens1370.c:2321:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:2321:18: sparse:     got void *
   sound/pci/ens1370.c:2333:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ens1370.c:2333:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ens1370.c:2333:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:2333:9: sparse:     got void *
   sound/pci/ens1370.c:2334:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:2334:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:2334:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:2334:9: sparse:     got void *
   sound/pci/ens1370.c:581:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:581:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:581:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:581:23: sparse:     got void *
   sound/pci/ens1370.c:582:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:582:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:582:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:582:25: sparse:     got void *
   sound/pci/ens1370.c:587:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:587:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:587:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:587:9: sparse:     got void *
   sound/pci/ens1370.c:819:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:819:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:819:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:819:17: sparse:     got void *
   sound/pci/ens1370.c:845:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:845:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:845:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:845:17: sparse:     got void *
   sound/pci/ens1370.c:880:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:880:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:880:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:880:9: sparse:     got void *
   sound/pci/ens1370.c:881:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:881:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:881:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:881:9: sparse:     got void *
   sound/pci/ens1370.c:882:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:882:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:882:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:882:9: sparse:     got void *
   sound/pci/ens1370.c:883:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:883:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:883:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:883:9: sparse:     got void *
   sound/pci/ens1370.c:886:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:886:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:886:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:886:9: sparse:     got void *
   sound/pci/ens1370.c:887:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:887:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:887:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:887:9: sparse:     got void *
   sound/pci/ens1370.c:899:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:899:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:899:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:899:9: sparse:     got void *
   sound/pci/ens1370.c:921:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:921:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:921:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:921:9: sparse:     got void *
   sound/pci/ens1370.c:922:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:922:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:922:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:922:9: sparse:     got void *
   sound/pci/ens1370.c:923:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:923:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:923:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:923:9: sparse:     got void *
   sound/pci/ens1370.c:924:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:924:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:924:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:924:9: sparse:     got void *
   sound/pci/ens1370.c:929:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:929:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:929:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:929:9: sparse:     got void *
   sound/pci/ens1370.c:930:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:930:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:930:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:930:9: sparse:     got void *
   sound/pci/ens1370.c:939:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:939:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:939:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:939:9: sparse:     got void *
   sound/pci/ens1370.c:961:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:961:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:961:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:961:9: sparse:     got void *
   sound/pci/ens1370.c:962:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:962:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:962:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:962:9: sparse:     got void *
   sound/pci/ens1370.c:963:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:963:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:963:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:963:9: sparse:     got void *
   sound/pci/ens1370.c:964:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:964:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:964:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ens1370.c:964:9: sparse:     got void *
   sound/pci/ens1370.c:967:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ens1370.c:967:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ens1370.c:967:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] __iomem *screen_base
--
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected unsigned int [noderef] __user *__p
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
--
>> sound/pci/pcxhr/pcxhr_core.c:120:25: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_core.c:120:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_core.c:120:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:120:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:559:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:559:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:559:25: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:689:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:689:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:689:9: sparse:     expected void volatile [noderef] __iomem *addr

vim +/__iomem +406 drivers/scsi/aic7xxx/aic7xxx_osm.c

be0d67680d5249 Denys Vlasenko 2008-03-23  396  
be0d67680d5249 Denys Vlasenko 2008-03-23  397  /***************************** Low Level I/O **********************************/
be0d67680d5249 Denys Vlasenko 2008-03-23  398  uint8_t
be0d67680d5249 Denys Vlasenko 2008-03-23  399  ahc_inb(struct ahc_softc * ahc, long port)
be0d67680d5249 Denys Vlasenko 2008-03-23  400  {
be0d67680d5249 Denys Vlasenko 2008-03-23  401  	uint8_t x;
be0d67680d5249 Denys Vlasenko 2008-03-23  402  
be0d67680d5249 Denys Vlasenko 2008-03-23  403  	if (ahc->tag == BUS_SPACE_MEMIO) {
be0d67680d5249 Denys Vlasenko 2008-03-23  404  		x = readb(ahc->bsh.maddr + port);
be0d67680d5249 Denys Vlasenko 2008-03-23  405  	} else {
be0d67680d5249 Denys Vlasenko 2008-03-23 @406  		x = inb(ahc->bsh.ioport + port);
be0d67680d5249 Denys Vlasenko 2008-03-23  407  	}
be0d67680d5249 Denys Vlasenko 2008-03-23  408  	mb();
be0d67680d5249 Denys Vlasenko 2008-03-23  409  	return (x);
be0d67680d5249 Denys Vlasenko 2008-03-23  410  }
be0d67680d5249 Denys Vlasenko 2008-03-23  411  
be0d67680d5249 Denys Vlasenko 2008-03-23  412  void
be0d67680d5249 Denys Vlasenko 2008-03-23  413  ahc_outb(struct ahc_softc * ahc, long port, uint8_t val)
be0d67680d5249 Denys Vlasenko 2008-03-23  414  {
be0d67680d5249 Denys Vlasenko 2008-03-23  415  	if (ahc->tag == BUS_SPACE_MEMIO) {
be0d67680d5249 Denys Vlasenko 2008-03-23  416  		writeb(val, ahc->bsh.maddr + port);
be0d67680d5249 Denys Vlasenko 2008-03-23  417  	} else {
be0d67680d5249 Denys Vlasenko 2008-03-23 @418  		outb(val, ahc->bsh.ioport + port);
be0d67680d5249 Denys Vlasenko 2008-03-23  419  	}
be0d67680d5249 Denys Vlasenko 2008-03-23  420  	mb();
be0d67680d5249 Denys Vlasenko 2008-03-23  421  }
be0d67680d5249 Denys Vlasenko 2008-03-23  422  

:::::: The code at line 406 was first introduced by commit
:::::: be0d67680d524981dd65c661efe3c9cbd52a684f [SCSI] aic7xxx, aic79xx: deinline functions

:::::: TO: Denys Vlasenko <vda.linux@googlemail.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dDRMvlgZJXvWKvBx--

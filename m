Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B35C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC182067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRLCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:02:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:11938 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHRLCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:02:23 -0400
IronPort-SDR: /watt1GCk/hnlLeKi+154YnHn8KC46XSfWzzDT4IDUxc0LYINTgGyVDWk3AM9eTr0nkTO1b792
 SBRxMx+/gSbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155960555"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="gz'50?scan'50,208,50";a="155960555"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 04:01:47 -0700
IronPort-SDR: BLhsVFNw/a0apY4ls1Eci08L/0dH0Vla4pJG3l20DexZaygNXPPeLS3s0ZXbulNv2EY2CQfiFY
 djK/pr79mTNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="gz'50?scan'50,208,50";a="278020530"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2020 04:01:45 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7zNA-00018u-Vf; Tue, 18 Aug 2020 11:01:44 +0000
Date:   Tue, 18 Aug 2020 19:00:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/udc/fsl_udc_core.c:2423:33: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202008181938.T4NjA7OW%lkp@intel.com>
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
head:   06a4ec1d9dc652e17ee3ac2ceb6c7cf6c2b75cdd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: powerpc-randconfig-s031-20200818 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/gadget/udc/fsl_udc_core.c:70:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/fsl_udc_core.c:70:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/fsl_udc_core.c:70:33: sparse:     got int
   drivers/usb/gadget/udc/fsl_udc_core.c:1365:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/fsl_udc_core.c:1365:33: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/fsl_udc_core.c:1365:33: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/fsl_udc_core.c:1581:32: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1581:32: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1581:32: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1581:32: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1581:32: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1581:32: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1582:30: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1582:30: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1582:30: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1582:30: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1582:30: sparse: sparse: cast to restricted __le32
   drivers/usb/gadget/udc/fsl_udc_core.c:1582:30: sparse: sparse: cast to restricted __le32
>> drivers/usb/gadget/udc/fsl_udc_core.c:2423:33: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/usb/gadget/udc/fsl_udc_core.c:2423:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct usb_sys_interface [noderef] __iomem *static [toplevel] usb_sys_regs @@     got void * @@
>> drivers/usb/gadget/udc/fsl_udc_core.c:2423:30: sparse:     expected struct usb_sys_interface [noderef] __iomem *static [toplevel] usb_sys_regs
   drivers/usb/gadget/udc/fsl_udc_core.c:2423:30: sparse:     got void *
   drivers/usb/gadget/udc/fsl_udc_core.c:1781:20: sparse: sparse: context imbalance in 'reset_queues' - unexpected unlock
--
   drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse:     got int
>> drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
>> drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 const [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     expected unsigned int [usertype] offset
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     got restricted __be32 const [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2071:28: sparse: sparse: context imbalance in 'setup_received_handle' - unexpected unlock
--
>> arch/powerpc/platforms/8xx/micropatch.c:328:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned char * @@
>> arch/powerpc/platforms/8xx/micropatch.c:328:34: sparse:     expected void volatile [noderef] __iomem *d
   arch/powerpc/platforms/8xx/micropatch.c:328:34: sparse:     got unsigned char *
>> arch/powerpc/platforms/8xx/micropatch.c:333:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
>> arch/powerpc/platforms/8xx/micropatch.c:333:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:333:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:346:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:346:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:346:27: sparse:     got unsigned short *
>> arch/powerpc/platforms/8xx/micropatch.c:350:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 * @@
   arch/powerpc/platforms/8xx/micropatch.c:350:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:350:27: sparse:     got restricted __be16 *
   arch/powerpc/platforms/8xx/micropatch.c:356:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:356:35: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:356:35: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:364:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:364:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:364:27: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:366:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:366:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:366:27: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:369:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:369:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:369:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:370:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:370:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:370:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:371:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:371:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:371:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:372:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:372:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:372:19: sparse:     got unsigned short *
   arch/powerpc/platforms/8xx/micropatch.c:374:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short * @@
   arch/powerpc/platforms/8xx/micropatch.c:374:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/micropatch.c:374:19: sparse:     got unsigned short *

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +/__iomem +2423 drivers/usb/gadget/udc/fsl_udc_core.c

83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2386  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2387  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2388  	if (!res) {
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2389  		ret = -ENXIO;
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2390  		goto err_kfree;
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2391  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2392  
83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2393  	if (pdata->operating_mode == FSL_USB2_DR_DEVICE) {
28f65c11f2ffb39 drivers/usb/gadget/fsl_udc_core.c     Joe Perches                2011-06-09  2394  		if (!request_mem_region(res->start, resource_size(res),
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2395  					driver_name)) {
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2396  			ERR("request mem region for %s failed\n", pdev->name);
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2397  			ret = -EBUSY;
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2398  			goto err_kfree;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2399  		}
83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2400  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2401  
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2402  	dr_regs = ioremap(res->start, resource_size(res));
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2403  	if (!dr_regs) {
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2404  		ret = -ENOMEM;
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2405  		goto err_release_mem_region;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2406  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2407  
bbb9f94cf9e9e1c drivers/usb/gadget/udc/fsl_udc_core.c Felipe Balbi               2014-07-16  2408  	pdata->regs = (void __iomem *)dr_regs;
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2409  
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2410  	/*
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2411  	 * do platform specific init: check the clock, grab/config pins, etc.
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2412  	 */
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2413  	if (pdata->init && pdata->init(pdev)) {
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2414  		ret = -ENODEV;
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2415  		goto err_iounmap_noclk;
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2416  	}
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2417  
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2418  	/* Set accessors only after pdata->init() ! */
3140d5b26643092 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-06-25  2419  	fsl_set_accessors(pdata);
09ba0def9aefc16 drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2420  
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2421  #ifndef CONFIG_ARCH_MXC
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2422  	if (pdata->have_sysif_regs)
8981d76a2cf4c46 drivers/usb/gadget/fsl_udc_core.c     Shaohui Xie                2011-11-07 @2423  		usb_sys_regs = (void *)dr_regs + USB_DR_SYS_OFFSET;
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2424  #endif
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2425  
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2426  	/* Initialize USB clocks */
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2427  	ret = fsl_udc_clk_init(pdev);
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2428  	if (ret < 0)
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2429  		goto err_iounmap_noclk;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2430  
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2431  	/* Read Device Controller Capability Parameters register */
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2432  	dccparams = fsl_readl(&dr_regs->dccparams);
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2433  	if (!(dccparams & DCCPARAMS_DC)) {
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2434  		ERR("This SOC doesn't support device role\n");
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2435  		ret = -ENODEV;
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2436  		goto err_iounmap;
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2437  	}
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2438  	/* Get max device endpoints */
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2439  	/* DEN is bidirectional ep number, max_ep doubles the number */
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2440  	udc_controller->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2441  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2442  	udc_controller->irq = platform_get_irq(pdev, 0);
4cda340a455b425 drivers/usb/gadget/udc/fsl_udc_core.c Tang Bin                   2020-04-10  2443  	if (udc_controller->irq <= 0) {
4cda340a455b425 drivers/usb/gadget/udc/fsl_udc_core.c Tang Bin                   2020-04-10  2444  		ret = udc_controller->irq ? : -ENODEV;
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2445  		goto err_iounmap;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2446  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2447  
37b5453dd4dafcc drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-07  2448  	ret = request_irq(udc_controller->irq, fsl_udc_irq, IRQF_SHARED,
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2449  			driver_name, udc_controller);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2450  	if (ret != 0) {
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2451  		ERR("cannot request irq %d err %d\n",
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2452  				udc_controller->irq, ret);
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2453  		goto err_iounmap;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2454  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2455  
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2456  	/* Initialize the udc structure including QH member and other member */
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2457  	if (struct_udc_setup(udc_controller, pdev)) {
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2458  		ERR("Can't initialize udc data structure\n");
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2459  		ret = -ENOMEM;
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2460  		goto err_free_irq;
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2461  	}
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2462  
ded017ee6c7b90f drivers/usb/gadget/fsl_udc_core.c     Kishon Vijay Abraham I     2012-06-26  2463  	if (IS_ERR_OR_NULL(udc_controller->transceiver)) {
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2464  		/* initialize usb hw reg except for regs for EP,
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2465  		 * leave usbintr reg untouched */
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2466  		dr_controller_setup(udc_controller);
83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2467  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2468  
c2c9caa94748657 drivers/usb/gadget/fsl_udc_core.c     Peter Chen                 2013-01-17  2469  	ret = fsl_udc_clk_finalize(pdev);
c2c9caa94748657 drivers/usb/gadget/fsl_udc_core.c     Peter Chen                 2013-01-17  2470  	if (ret)
c2c9caa94748657 drivers/usb/gadget/fsl_udc_core.c     Peter Chen                 2013-01-17  2471  		goto err_free_irq;
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2472  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2473  	/* Setup gadget structure */
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2474  	udc_controller->gadget.ops = &fsl_gadget_ops;
d327ab5b6d660d6 drivers/usb/gadget/fsl_udc_core.c     Michal Nazarewicz          2011-11-19  2475  	udc_controller->gadget.max_speed = USB_SPEED_HIGH;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2476  	udc_controller->gadget.ep0 = &udc_controller->eps[0].ep;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2477  	INIT_LIST_HEAD(&udc_controller->gadget.ep_list);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2478  	udc_controller->gadget.speed = USB_SPEED_UNKNOWN;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2479  	udc_controller->gadget.name = driver_name;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2480  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2481  	/* Setup gadget.dev and register with kernel */
0031a06e2f07ab0 drivers/usb/gadget/fsl_usb2_udc.c     Kay Sievers                2008-05-02  2482  	dev_set_name(&udc_controller->gadget.dev, "gadget");
cb4baf104b11458 drivers/usb/gadget/fsl_udc_core.c     Alexandre Pereira da Silva 2012-06-26  2483  	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2484  
ded017ee6c7b90f drivers/usb/gadget/fsl_udc_core.c     Kishon Vijay Abraham I     2012-06-26  2485  	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2486  		udc_controller->gadget.is_otg = 1;
83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2487  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2488  	/* setup QH and epctrl for ep0 */
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2489  	ep0_setup(udc_controller);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2490  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2491  	/* setup udc->eps[] for ep0 */
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2492  	struct_ep_setup(udc_controller, 0, "ep0", 0);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2493  	/* for ep0: the desc defined here;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2494  	 * for other eps, gadget layer called ep_enable with defined desc
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2495  	 */
80e91fd59bc5291 drivers/usb/gadget/fsl_udc_core.c     Christoph Fritz            2012-06-04  2496  	udc_controller->eps[0].ep.desc = &fsl_ep0_desc;
e117e742d310683 drivers/usb/gadget/fsl_udc_core.c     Robert Baldyga             2013-12-13  2497  	usb_ep_set_maxpacket_limit(&udc_controller->eps[0].ep,
e117e742d310683 drivers/usb/gadget/fsl_udc_core.c     Robert Baldyga             2013-12-13  2498  				   USB_MAX_CTRL_PAYLOAD);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2499  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2500  	/* setup the udc->eps[] for non-control endpoints and link
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2501  	 * to gadget.ep_list */
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2502  	for (i = 1; i < (int)(udc_controller->max_ep / 2); i++) {
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2503  		char name[14];
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2504  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2505  		sprintf(name, "ep%dout", i);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2506  		struct_ep_setup(udc_controller, i * 2, name, 1);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2507  		sprintf(name, "ep%din", i);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2508  		struct_ep_setup(udc_controller, i * 2 + 1, name, 1);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2509  	}
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2510  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2511  	/* use dma_pool for TD management */
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2512  	udc_controller->td_pool = dma_pool_create("udc_td", &pdev->dev,
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2513  			sizeof(struct ep_td_struct),
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2514  			DTD_ALIGNMENT, UDC_DMA_BOUNDARY);
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2515  	if (udc_controller->td_pool == NULL) {
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2516  		ret = -ENOMEM;
eab35c4e6d952c9 drivers/usb/gadget/fsl_udc_core.c     Felipe Balbi               2013-01-24  2517  		goto err_free_irq;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2518  	}
0f91349b89f37df drivers/usb/gadget/fsl_udc_core.c     Sebastian Andrzej Siewior  2011-06-28  2519  
0e4d65e5292ed76 drivers/usb/gadget/fsl_udc_core.c     Felipe Balbi               2013-02-26  2520  	ret = usb_add_gadget_udc_release(&pdev->dev, &udc_controller->gadget,
0e4d65e5292ed76 drivers/usb/gadget/fsl_udc_core.c     Felipe Balbi               2013-02-26  2521  			fsl_udc_release);
0f91349b89f37df drivers/usb/gadget/fsl_udc_core.c     Sebastian Andrzej Siewior  2011-06-28  2522  	if (ret)
0f91349b89f37df drivers/usb/gadget/fsl_udc_core.c     Sebastian Andrzej Siewior  2011-06-28  2523  		goto err_del_udc;
0f91349b89f37df drivers/usb/gadget/fsl_udc_core.c     Sebastian Andrzej Siewior  2011-06-28  2524  
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2525  	create_proc_file();
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2526  	return 0;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2527  
0f91349b89f37df drivers/usb/gadget/fsl_udc_core.c     Sebastian Andrzej Siewior  2011-06-28  2528  err_del_udc:
0f91349b89f37df drivers/usb/gadget/fsl_udc_core.c     Sebastian Andrzej Siewior  2011-06-28  2529  	dma_pool_destroy(udc_controller->td_pool);
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2530  err_free_irq:
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2531  	free_irq(udc_controller->irq, udc_controller);
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2532  err_iounmap:
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2533  	if (pdata->exit)
2ea6698d7b9266d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2534  		pdata->exit(pdev);
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2535  	fsl_udc_clk_release();
54e4026b64a9703 drivers/usb/gadget/fsl_udc_core.c     Guennadi Liakhovetski      2009-04-15  2536  err_iounmap_noclk:
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2537  	iounmap(dr_regs);
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2538  err_release_mem_region:
83722bc9430424d drivers/usb/gadget/fsl_udc_core.c     Anatolij Gustschin         2011-04-18  2539  	if (pdata->operating_mode == FSL_USB2_DR_DEVICE)
28f65c11f2ffb39 drivers/usb/gadget/fsl_udc_core.c     Joe Perches                2011-06-09  2540  		release_mem_region(res->start, resource_size(res));
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2541  err_kfree:
4365831dadfeeeb drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-06-06  2542  	kfree(udc_controller);
23d7cd040e1f431 drivers/usb/gadget/fsl_usb2_udc.c     Will Newton                2008-08-12  2543  	udc_controller = NULL;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2544  	return ret;
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2545  }
b504882da539c17 drivers/usb/gadget/fsl_usb2_udc.c     Li Yang                    2007-04-23  2546  

:::::: The code at line 2423 was first introduced by commit
:::::: 8981d76a2cf4c46333d9a18176a6eee337a71146 powerpc/usb: fix type cast for address of ioremap to compatible with 64-bit

:::::: TO: Shaohui Xie <Shaohui.Xie@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
XeP34yKimTin+z8Z5T1RDP4BAA==

--6TrnltStXW4iwmi0--

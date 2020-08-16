Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1137C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA8D206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgHPUAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 16:00:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:36900 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbgHPUAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 16:00:32 -0400
IronPort-SDR: lpXOH0mHgUUA5elqg5sbRis5Qa6RsIwScETRc9WIGi8M4j9nyrdKlGssPa+5SGvVaWlVyDQ2sB
 aJTB79B3hG7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134664916"
X-IronPort-AV: E=Sophos;i="5.76,321,1592895600"; 
   d="gz'50?scan'50,208,50";a="134664916"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 12:35:19 -0700
IronPort-SDR: BywKwciq7GQr9sk7UAy7pjBCSM6YsvQQ1GEwkuMj+oqHVsJ+acqamM7XaXUiFDU2tOSagJ26yg
 2VrjkWA5waxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,321,1592895600"; 
   d="gz'50?scan'50,208,50";a="278870136"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Aug 2020 12:35:17 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7OR2-0000DQ-K4; Sun, 16 Aug 2020 19:35:16 +0000
Date:   Mon, 17 Aug 2020 03:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202008170350.rxLoIzbu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cc3c4b3c2e9c99e90aaf19cd801ff2c160f283c
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: mips-randconfig-s032-20200817 (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:140:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] inst_cnt_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:38: sparse:     expected void [noderef] __iomem *[assigned] inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:38: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:31: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:57: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:57: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:51: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:51: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:51: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:51: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:51: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:51: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:603:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:602:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *doorbell_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:602:26: sparse:     expected void [noderef] __iomem *doorbell_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:602:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:605:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:604:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *inst_cnt_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:604:26: sparse:     expected void [noderef] __iomem *inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:604:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:647:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:646:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_sent_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:646:29: sparse:     expected void [noderef] __iomem *pkts_sent_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:646:29: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:649:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:648:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_credit_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:648:31: sparse:     expected void [noderef] __iomem *pkts_credit_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:648:31: sparse:     got unsigned char [usertype] *
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:688:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:688:42: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:688:42: sparse:     got void *mbox_int_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:689:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:689:42: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:689:42: sparse:     got void *mbox_int_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:694:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:694:54: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:694:54: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:737:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:741:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:745:40: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:755:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:755:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:755:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:990:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:990:42: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:990:42: sparse:     got void *mbox_int_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:997:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:997:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:997:44: sparse:     got void *mbox_int_reg
--
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] inst_cnt_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:38: sparse:     expected void [noderef] __iomem *[assigned] inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:38: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:226:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:225:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *doorbell_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:225:26: sparse:     expected void [noderef] __iomem *doorbell_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:225:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:228:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:227:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *inst_cnt_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:227:26: sparse:     expected void [noderef] __iomem *inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:227:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:258:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:257:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_sent_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:257:29: sparse:     expected void [noderef] __iomem *pkts_sent_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:257:29: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:260:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:259:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_credit_reg @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:259:31: sparse:     expected void [noderef] __iomem *pkts_credit_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:259:31: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:298:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:301:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:304:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:313:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:313:36: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:313:36: sparse:     got void *mbox_read_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:479:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_int_reg @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:479:50: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:479:50: sparse:     got void *mbox_int_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:480:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:480:50: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:480:50: sparse:     got void *mbox_int_reg
--
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:43:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:43:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:43:29: sparse:     got void *mbox_read_reg
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:81:52: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:81:52: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:115:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:115:36: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:115:36: sparse:     got void *mbox_read_reg
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:163:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:163:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:163:26: sparse:     got void *mbox_write_reg
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:172:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:172:47: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:172:47: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:175:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:175:42: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:175:42: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:184:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:184:63: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:184:63: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:193:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:193:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:193:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:305:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:305:52: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:305:52: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:315:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:315:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:315:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:324:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:324:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:324:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:340:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:340:52: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:340:52: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:370:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:370:36: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:370:36: sparse:     got void *mbox_read_reg

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +543 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c

3451b97cce2d78 Raghu Vatsavayi   2016-08-31  474  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  475  static void cn23xx_pf_setup_global_output_regs(struct octeon_device *oct)
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  476  {
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  477  	u32 reg_val;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  478  	u32 q_no, ern, srn;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  479  	u64 time_threshold;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  480  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  481  	struct octeon_cn23xx_pf *cn23xx = (struct octeon_cn23xx_pf *)oct->chip;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  482  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  483  	srn = oct->sriov_info.pf_srn;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  484  	ern = srn + oct->sriov_info.num_pf_rings;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  485  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  486  	if (CFG_GET_IS_SLI_BP_ON(cn23xx->conf)) {
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  487  		octeon_write_csr64(oct, CN23XX_SLI_OQ_WMARK, 32);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  488  	} else {
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  489  		/** Set Output queue watermark to 0 to disable backpressure */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  490  		octeon_write_csr64(oct, CN23XX_SLI_OQ_WMARK, 0);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  491  	}
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  492  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  493  	for (q_no = srn; q_no < ern; q_no++) {
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  494  		reg_val = octeon_read_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no));
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  495  
ac13d6d8eaded1 Rick Farrington   2018-07-13  496  		/* clear IPTR */
ac13d6d8eaded1 Rick Farrington   2018-07-13  497  		reg_val &= ~CN23XX_PKT_OUTPUT_CTL_IPTR;
ac13d6d8eaded1 Rick Farrington   2018-07-13  498  
c4ee5d8103ed78 Prasad Kanneganti 2017-06-18  499  		/* set DPTR */
c4ee5d8103ed78 Prasad Kanneganti 2017-06-18  500  		reg_val |= CN23XX_PKT_OUTPUT_CTL_DPTR;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  501  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  502  		/* reset BMODE */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  503  		reg_val &= ~(CN23XX_PKT_OUTPUT_CTL_BMODE);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  504  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  505  		/* No Relaxed Ordering, No Snoop, 64-bit Byte swap
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  506  		 * for Output Queue ScatterList
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  507  		 * reset ROR_P, NSR_P
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  508  		 */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  509  		reg_val &= ~(CN23XX_PKT_OUTPUT_CTL_ROR_P);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  510  		reg_val &= ~(CN23XX_PKT_OUTPUT_CTL_NSR_P);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  511  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  512  #ifdef __LITTLE_ENDIAN_BITFIELD
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  513  		reg_val &= ~(CN23XX_PKT_OUTPUT_CTL_ES_P);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  514  #else
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  515  		reg_val |= (CN23XX_PKT_OUTPUT_CTL_ES_P);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  516  #endif
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  517  		/* No Relaxed Ordering, No Snoop, 64-bit Byte swap
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  518  		 * for Output Queue Data
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  519  		 * reset ROR, NSR
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  520  		 */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  521  		reg_val &= ~(CN23XX_PKT_OUTPUT_CTL_ROR);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  522  		reg_val &= ~(CN23XX_PKT_OUTPUT_CTL_NSR);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  523  		/* set the ES bit */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  524  		reg_val |= (CN23XX_PKT_OUTPUT_CTL_ES);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  525  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  526  		/* write all the selected settings */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  527  		octeon_write_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(q_no), reg_val);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  528  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  529  		/* Enabling these interrupt in oct->fn_list.enable_interrupt()
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  530  		 * routine which called after IOQ init.
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  531  		 * Set up interrupt packet and time thresholds
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  532  		 * for all the OQs
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  533  		 */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  534  		time_threshold = cn23xx_pf_get_oq_ticks(
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  535  		    oct, (u32)CFG_GET_OQ_INTR_TIME(cn23xx->conf));
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  536  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  537  		octeon_write_csr64(oct, CN23XX_SLI_OQ_PKT_INT_LEVELS(q_no),
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  538  				   (CFG_GET_OQ_INTR_PKT(cn23xx->conf) |
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  539  				    (time_threshold << 32)));
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  540  	}
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  541  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  542  	/** Setting the water mark level for pko back pressure **/
3451b97cce2d78 Raghu Vatsavayi   2016-08-31 @543  	writeq(0x40, (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OQ_WMARK);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  544  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  545  	/** Disabling setting OQs in reset when ring has no dorebells
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  546  	 * enabling this will cause of head of line blocking
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  547  	 */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  548  	/* Do it only for pass1.1. and pass1.2 */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  549  	if ((oct->rev_id == OCTEON_CN23XX_REV_1_0) ||
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  550  	    (oct->rev_id == OCTEON_CN23XX_REV_1_1))
3451b97cce2d78 Raghu Vatsavayi   2016-08-31 @551  		writeq(readq((u8 *)oct->mmio[0].hw_addr +
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  552  				     CN23XX_SLI_GBL_CONTROL) | 0x2,
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  553  		       (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_GBL_CONTROL);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  554  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  555  	/** Enable channel-level backpressure */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  556  	if (oct->pf_num)
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  557  		writeq(0xffffffffffffffffULL,
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  558  		       (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OUT_BP_EN2_W1S);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  559  	else
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  560  		writeq(0xffffffffffffffffULL,
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  561  		       (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OUT_BP_EN_W1S);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  562  }
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  563  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  564  static int cn23xx_setup_pf_device_regs(struct octeon_device *oct)
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  565  {
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  566  	cn23xx_enable_error_reporting(oct);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  567  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  568  	/* program the MAC(0..3)_RINFO before setting up input/output regs */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  569  	cn23xx_setup_global_mac_regs(oct);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  570  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  571  	if (cn23xx_pf_setup_global_input_regs(oct))
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  572  		return -1;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  573  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  574  	cn23xx_pf_setup_global_output_regs(oct);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  575  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  576  	/* Default error timeout value should be 0x200000 to avoid host hang
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  577  	 * when reads invalid register
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  578  	 */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  579  	octeon_write_csr64(oct, CN23XX_SLI_WINDOW_CTL,
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  580  			   CN23XX_SLI_WINDOW_CTL_DEFAULT);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  581  
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  582  	/* set SLI_PKT_IN_JABBER to handle large VXLAN packets */
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  583  	octeon_write_csr64(oct, CN23XX_SLI_PKT_IN_JABBER, CN23XX_INPUT_JABBER);
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  584  	return 0;
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  585  }
3451b97cce2d78 Raghu Vatsavayi   2016-08-31  586  
72c0091293c008 Raghu Vatsavayi   2016-08-31  587  static void cn23xx_setup_iq_regs(struct octeon_device *oct, u32 iq_no)
72c0091293c008 Raghu Vatsavayi   2016-08-31  588  {
72c0091293c008 Raghu Vatsavayi   2016-08-31  589  	struct octeon_instr_queue *iq = oct->instr_queue[iq_no];
72c0091293c008 Raghu Vatsavayi   2016-08-31  590  	u64 pkt_in_done;
72c0091293c008 Raghu Vatsavayi   2016-08-31  591  
72c0091293c008 Raghu Vatsavayi   2016-08-31  592  	iq_no += oct->sriov_info.pf_srn;
72c0091293c008 Raghu Vatsavayi   2016-08-31  593  
72c0091293c008 Raghu Vatsavayi   2016-08-31  594  	/* Write the start of the input queue's ring and its size  */
72c0091293c008 Raghu Vatsavayi   2016-08-31  595  	octeon_write_csr64(oct, CN23XX_SLI_IQ_BASE_ADDR64(iq_no),
72c0091293c008 Raghu Vatsavayi   2016-08-31  596  			   iq->base_addr_dma);
72c0091293c008 Raghu Vatsavayi   2016-08-31  597  	octeon_write_csr(oct, CN23XX_SLI_IQ_SIZE(iq_no), iq->max_count);
72c0091293c008 Raghu Vatsavayi   2016-08-31  598  
72c0091293c008 Raghu Vatsavayi   2016-08-31  599  	/* Remember the doorbell & instruction count register addr
72c0091293c008 Raghu Vatsavayi   2016-08-31  600  	 * for this queue
72c0091293c008 Raghu Vatsavayi   2016-08-31  601  	 */
72c0091293c008 Raghu Vatsavayi   2016-08-31  602  	iq->doorbell_reg =
72c0091293c008 Raghu Vatsavayi   2016-08-31  603  	    (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_IQ_DOORBELL(iq_no);
72c0091293c008 Raghu Vatsavayi   2016-08-31  604  	iq->inst_cnt_reg =
72c0091293c008 Raghu Vatsavayi   2016-08-31  605  	    (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_IQ_INSTR_COUNT64(iq_no);
72c0091293c008 Raghu Vatsavayi   2016-08-31  606  	dev_dbg(&oct->pci_dev->dev, "InstQ[%d]:dbell reg @ 0x%p instcnt_reg @ 0x%p\n",
72c0091293c008 Raghu Vatsavayi   2016-08-31  607  		iq_no, iq->doorbell_reg, iq->inst_cnt_reg);
72c0091293c008 Raghu Vatsavayi   2016-08-31  608  
72c0091293c008 Raghu Vatsavayi   2016-08-31  609  	/* Store the current instruction counter (used in flush_iq
72c0091293c008 Raghu Vatsavayi   2016-08-31  610  	 * calculation)
72c0091293c008 Raghu Vatsavayi   2016-08-31  611  	 */
72c0091293c008 Raghu Vatsavayi   2016-08-31  612  	pkt_in_done = readq(iq->inst_cnt_reg);
72c0091293c008 Raghu Vatsavayi   2016-08-31  613  
5b07aee11227fa Raghu Vatsavayi   2016-08-31  614  	if (oct->msix_on) {
5b07aee11227fa Raghu Vatsavayi   2016-08-31  615  		/* Set CINT_ENB to enable IQ interrupt   */
5b07aee11227fa Raghu Vatsavayi   2016-08-31  616  		writeq((pkt_in_done | CN23XX_INTR_CINT_ENB),
5b07aee11227fa Raghu Vatsavayi   2016-08-31  617  		       iq->inst_cnt_reg);
5b07aee11227fa Raghu Vatsavayi   2016-08-31  618  	} else {
72c0091293c008 Raghu Vatsavayi   2016-08-31  619  		/* Clear the count by writing back what we read, but don't
72c0091293c008 Raghu Vatsavayi   2016-08-31  620  		 * enable interrupts
72c0091293c008 Raghu Vatsavayi   2016-08-31  621  		 */
72c0091293c008 Raghu Vatsavayi   2016-08-31  622  		writeq(pkt_in_done, iq->inst_cnt_reg);
5b07aee11227fa Raghu Vatsavayi   2016-08-31  623  	}
72c0091293c008 Raghu Vatsavayi   2016-08-31  624  
72c0091293c008 Raghu Vatsavayi   2016-08-31  625  	iq->reset_instr_cnt = 0;
72c0091293c008 Raghu Vatsavayi   2016-08-31  626  }
72c0091293c008 Raghu Vatsavayi   2016-08-31  627  
72c0091293c008 Raghu Vatsavayi   2016-08-31  628  static void cn23xx_setup_oq_regs(struct octeon_device *oct, u32 oq_no)
72c0091293c008 Raghu Vatsavayi   2016-08-31  629  {
72c0091293c008 Raghu Vatsavayi   2016-08-31  630  	u32 reg_val;
72c0091293c008 Raghu Vatsavayi   2016-08-31  631  	struct octeon_droq *droq = oct->droq[oq_no];
5b07aee11227fa Raghu Vatsavayi   2016-08-31  632  	struct octeon_cn23xx_pf *cn23xx = (struct octeon_cn23xx_pf *)oct->chip;
5b07aee11227fa Raghu Vatsavayi   2016-08-31  633  	u64 time_threshold;
5b07aee11227fa Raghu Vatsavayi   2016-08-31  634  	u64 cnt_threshold;
72c0091293c008 Raghu Vatsavayi   2016-08-31  635  
72c0091293c008 Raghu Vatsavayi   2016-08-31  636  	oq_no += oct->sriov_info.pf_srn;
72c0091293c008 Raghu Vatsavayi   2016-08-31  637  
72c0091293c008 Raghu Vatsavayi   2016-08-31  638  	octeon_write_csr64(oct, CN23XX_SLI_OQ_BASE_ADDR64(oq_no),
72c0091293c008 Raghu Vatsavayi   2016-08-31  639  			   droq->desc_ring_dma);
72c0091293c008 Raghu Vatsavayi   2016-08-31  640  	octeon_write_csr(oct, CN23XX_SLI_OQ_SIZE(oq_no), droq->max_count);
72c0091293c008 Raghu Vatsavayi   2016-08-31  641  
72c0091293c008 Raghu Vatsavayi   2016-08-31  642  	octeon_write_csr(oct, CN23XX_SLI_OQ_BUFF_INFO_SIZE(oq_no),
c4ee5d8103ed78 Prasad Kanneganti 2017-06-18  643  			 droq->buffer_size);
72c0091293c008 Raghu Vatsavayi   2016-08-31  644  
72c0091293c008 Raghu Vatsavayi   2016-08-31  645  	/* Get the mapped address of the pkt_sent and pkts_credit regs */
72c0091293c008 Raghu Vatsavayi   2016-08-31  646  	droq->pkts_sent_reg =
72c0091293c008 Raghu Vatsavayi   2016-08-31  647  	    (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OQ_PKTS_SENT(oq_no);
72c0091293c008 Raghu Vatsavayi   2016-08-31  648  	droq->pkts_credit_reg =
72c0091293c008 Raghu Vatsavayi   2016-08-31  649  	    (u8 *)oct->mmio[0].hw_addr + CN23XX_SLI_OQ_PKTS_CREDIT(oq_no);
72c0091293c008 Raghu Vatsavayi   2016-08-31  650  
5b07aee11227fa Raghu Vatsavayi   2016-08-31  651  	if (!oct->msix_on) {
72c0091293c008 Raghu Vatsavayi   2016-08-31  652  		/* Enable this output queue to generate Packet Timer Interrupt
72c0091293c008 Raghu Vatsavayi   2016-08-31  653  		 */
5b07aee11227fa Raghu Vatsavayi   2016-08-31  654  		reg_val =
5b07aee11227fa Raghu Vatsavayi   2016-08-31  655  		    octeon_read_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(oq_no));
72c0091293c008 Raghu Vatsavayi   2016-08-31  656  		reg_val |= CN23XX_PKT_OUTPUT_CTL_TENB;
72c0091293c008 Raghu Vatsavayi   2016-08-31  657  		octeon_write_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(oq_no),
72c0091293c008 Raghu Vatsavayi   2016-08-31  658  				 reg_val);
72c0091293c008 Raghu Vatsavayi   2016-08-31  659  
72c0091293c008 Raghu Vatsavayi   2016-08-31  660  		/* Enable this output queue to generate Packet Count Interrupt
72c0091293c008 Raghu Vatsavayi   2016-08-31  661  		 */
5b07aee11227fa Raghu Vatsavayi   2016-08-31  662  		reg_val =
5b07aee11227fa Raghu Vatsavayi   2016-08-31  663  		    octeon_read_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(oq_no));
72c0091293c008 Raghu Vatsavayi   2016-08-31  664  		reg_val |= CN23XX_PKT_OUTPUT_CTL_CENB;
72c0091293c008 Raghu Vatsavayi   2016-08-31  665  		octeon_write_csr(oct, CN23XX_SLI_OQ_PKT_CONTROL(oq_no),
72c0091293c008 Raghu Vatsavayi   2016-08-31  666  				 reg_val);
5b07aee11227fa Raghu Vatsavayi   2016-08-31  667  	} else {
5b07aee11227fa Raghu Vatsavayi   2016-08-31  668  		time_threshold = cn23xx_pf_get_oq_ticks(
5b07aee11227fa Raghu Vatsavayi   2016-08-31  669  		    oct, (u32)CFG_GET_OQ_INTR_TIME(cn23xx->conf));
5b07aee11227fa Raghu Vatsavayi   2016-08-31  670  		cnt_threshold = (u32)CFG_GET_OQ_INTR_PKT(cn23xx->conf);
5b07aee11227fa Raghu Vatsavayi   2016-08-31  671  
5b07aee11227fa Raghu Vatsavayi   2016-08-31  672  		octeon_write_csr64(
5b07aee11227fa Raghu Vatsavayi   2016-08-31  673  		    oct, CN23XX_SLI_OQ_PKT_INT_LEVELS(oq_no),
5b07aee11227fa Raghu Vatsavayi   2016-08-31  674  		    ((time_threshold << 32 | cnt_threshold)));
5b07aee11227fa Raghu Vatsavayi   2016-08-31  675  	}
72c0091293c008 Raghu Vatsavayi   2016-08-31  676  }
72c0091293c008 Raghu Vatsavayi   2016-08-31  677  
5d65556beb3668 Raghu Vatsavayi   2016-11-14  678  static void cn23xx_pf_mbox_thread(struct work_struct *work)
5d65556beb3668 Raghu Vatsavayi   2016-11-14  679  {
5d65556beb3668 Raghu Vatsavayi   2016-11-14  680  	struct cavium_wk *wk = (struct cavium_wk *)work;
5d65556beb3668 Raghu Vatsavayi   2016-11-14  681  	struct octeon_mbox *mbox = (struct octeon_mbox *)wk->ctxptr;
5d65556beb3668 Raghu Vatsavayi   2016-11-14  682  	struct octeon_device *oct = mbox->oct_dev;
5d65556beb3668 Raghu Vatsavayi   2016-11-14  683  	u64 mbox_int_val, val64;
5d65556beb3668 Raghu Vatsavayi   2016-11-14  684  	u32 q_no, i;
5d65556beb3668 Raghu Vatsavayi   2016-11-14  685  
5d65556beb3668 Raghu Vatsavayi   2016-11-14  686  	if (oct->rev_id < OCTEON_CN23XX_REV_1_1) {
5d65556beb3668 Raghu Vatsavayi   2016-11-14  687  		/*read and clear by writing 1*/
5d65556beb3668 Raghu Vatsavayi   2016-11-14 @688  		mbox_int_val = readq(mbox->mbox_int_reg);
5d65556beb3668 Raghu Vatsavayi   2016-11-14 @689  		writeq(mbox_int_val, mbox->mbox_int_reg);
5d65556beb3668 Raghu Vatsavayi   2016-11-14  690  
5d65556beb3668 Raghu Vatsavayi   2016-11-14  691  		for (i = 0; i < oct->sriov_info.num_vfs_alloced; i++) {
5d65556beb3668 Raghu Vatsavayi   2016-11-14  692  			q_no = i * oct->sriov_info.rings_per_vf;
5d65556beb3668 Raghu Vatsavayi   2016-11-14  693  
5d65556beb3668 Raghu Vatsavayi   2016-11-14 @694  			val64 = readq(oct->mbox[q_no]->mbox_write_reg);
5d65556beb3668 Raghu Vatsavayi   2016-11-14  695  
5d65556beb3668 Raghu Vatsavayi   2016-11-14  696  			if (val64 && (val64 != OCTEON_PFVFACK)) {
5d65556beb3668 Raghu Vatsavayi   2016-11-14  697  				if (octeon_mbox_read(oct->mbox[q_no]))
5d65556beb3668 Raghu Vatsavayi   2016-11-14  698  					octeon_mbox_process_message(
5d65556beb3668 Raghu Vatsavayi   2016-11-14  699  					    oct->mbox[q_no]);
5d65556beb3668 Raghu Vatsavayi   2016-11-14  700  			}
5d65556beb3668 Raghu Vatsavayi   2016-11-14  701  		}
5d65556beb3668 Raghu Vatsavayi   2016-11-14  702  
5d65556beb3668 Raghu Vatsavayi   2016-11-14  703  		schedule_delayed_work(&wk->work, msecs_to_jiffies(10));
5d65556beb3668 Raghu Vatsavayi   2016-11-14  704  	} else {
5d65556beb3668 Raghu Vatsavayi   2016-11-14  705  		octeon_mbox_process_message(mbox);
5d65556beb3668 Raghu Vatsavayi   2016-11-14  706  	}
5d65556beb3668 Raghu Vatsavayi   2016-11-14  707  }
5d65556beb3668 Raghu Vatsavayi   2016-11-14  708  

:::::: The code at line 543 was first introduced by commit
:::::: 3451b97cce2d7827bd76378ae6e9aeb7e8fc463d liquidio: CN23XX register setup

:::::: TO: Raghu Vatsavayi <rvatsavayi@caviumnetworks.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rqzd1BVJ3OAff1RarnTsAQA=

--xHFwDpU9dbj6ez1V--

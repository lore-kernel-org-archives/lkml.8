Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A312A2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgGFHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:55:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:42177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgGFHzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:55:49 -0400
IronPort-SDR: uaM5CFolUjkbrlNTIhYrN6QNFBhH2vjka8qYo9Ct+aINWODFHeRC+y9/m6tFgTcevAWYca4eDC
 fyLLKKQ9Bwjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="134829941"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="gz'50?scan'50,208,50";a="134829941"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 00:51:36 -0700
IronPort-SDR: 9cTAAN3OgCuHnPgacafQgdcZbkBdYlvJboIN6oIm00Lo+zxx8k/2JdITGLqhzyVDpgnKFbPqiT
 zNEUdQd8D7XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="gz'50?scan'50,208,50";a="323125163"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 00:51:34 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsLuX-00008F-AK; Mon, 06 Jul 2020 07:51:33 +0000
Date:   Mon, 6 Jul 2020 15:50:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202007061537.OnJJRTM3%lkp@intel.com>
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
head:   dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: arm-randconfig-s032-20200706 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-14-g8fce3d7a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/hptiop.c:150:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:171:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:18: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:557:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:557:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:557:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct hpt_iopmv_regs *regs @@
>> drivers/scsi/hptiop.c:643:34: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:934:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:940:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:945:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:945:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:945:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:950:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:950:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:950:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:950:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:951:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:976:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:978:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:981:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:983:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:986:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:988:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:991:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:991:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:992:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:993:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:993:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:993:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1536:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1536:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1536:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1537:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1537:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1537:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
--
>> drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:81:52: sparse:     got void *
   drivers/scsi/mvumi.c:90:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/scsi/mvumi.c:90:39: sparse:     expected void *
   drivers/scsi/mvumi.c:90:39: sparse:     got void [noderef] __iomem *
   drivers/scsi/mvumi.c:210:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:210:34: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:210:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:211:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:211:34: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:211:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:213:17: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:213:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:213:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:213:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:213:17: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:213:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:242:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:242:26: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:242:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:243:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:243:26: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:243:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:245:9: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:245:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:245:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:245:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:245:9: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:245:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *inb_read_pointer @@
   drivers/scsi/mvumi.c:407:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:407:40: sparse:     got void *inb_read_pointer
   drivers/scsi/mvumi.c:429:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:429:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:429:30: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:458:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:458:31: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:459:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *inb_write_pointer @@
   drivers/scsi/mvumi.c:459:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:459:48: sparse:     got void *inb_write_pointer
   drivers/scsi/mvumi.c:496:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:496:41: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:496:41: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:497:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:497:48: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:497:48: sparse:     got void *ob_shadow
   drivers/scsi/mvumi.c:516:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:516:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:516:33: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:517:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:517:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:517:33: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:578:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:578:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:578:42: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:585:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:585:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:585:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:586:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:586:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:586:26: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:589:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:589:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:589:40: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1281:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1281:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1281:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1282:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1282:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1282:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1284:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1284:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1284:48: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1285:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1285:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1285:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1286:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1286:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1286:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:612:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:612:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:612:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:613:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:613:28: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:615:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:615:46: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:615:46: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:624:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:624:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:624:36: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:670:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:670:32: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:670:32: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:671:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:671:34: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:671:34: sparse:     got void *reset_request
   drivers/scsi/mvumi.c:673:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:673:35: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/gpio/gpio-sa1100.c:104:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpio/gpio-sa1100.c:104:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *membase @@     got void * @@
>> drivers/gpio/gpio-sa1100.c:104:21: sparse:     expected void [noderef] __iomem *membase
   drivers/gpio/gpio-sa1100.c:104:21: sparse:     got void *
>> drivers/gpio/gpio-sa1100.c:115:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *base @@     got void [noderef] __iomem *membase @@
   drivers/gpio/gpio-sa1100.c:115:25: sparse:     expected void *base
>> drivers/gpio/gpio-sa1100.c:115:25: sparse:     got void [noderef] __iomem *membase
>> drivers/gpio/gpio-sa1100.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/gpio/gpio-sa1100.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpio/gpio-sa1100.c:121:9: sparse:     got void *
   drivers/gpio/gpio-sa1100.c:122:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpio/gpio-sa1100.c:122:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpio/gpio-sa1100.c:122:9: sparse:     got void *
--
   drivers/uio/uio_aec.c:44:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *int_flag @@     got void * @@
   drivers/uio/uio_aec.c:44:49: sparse:     expected void [noderef] __iomem *int_flag
   drivers/uio/uio_aec.c:44:49: sparse:     got void *
   drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:50:49: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:50:49: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:88:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/uio/uio_aec.c:88:20: sparse:     expected void *priv
   drivers/uio/uio_aec.c:88:20: sparse:     got void [noderef] __iomem *
   drivers/uio/uio_aec.c:104:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:104:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:104:42: sparse:     got void *
   drivers/uio/uio_aec.c:105:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:105:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:105:43: sparse:     got void *
   drivers/uio/uio_aec.c:106:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:106:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:106:34: sparse:     got void *
>> drivers/uio/uio_aec.c:115:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *priv @@
   drivers/uio/uio_aec.c:115:31: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:115:31: sparse:     got void *priv
   drivers/uio/uio_aec.c:130:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:130:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:130:42: sparse:     got void *
   drivers/uio/uio_aec.c:131:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:131:43: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:131:43: sparse:     got void *
   drivers/uio/uio_aec.c:133:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:133:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:133:28: sparse:     got void *
>> drivers/uio/uio_aec.c:138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *priv @@
>> drivers/uio/uio_aec.c:138:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/uio/uio_aec.c:138:21: sparse:     got void *priv

vim +643 drivers/scsi/hptiop.c

00f5970193e22c HighPoint Linux Team 2007-12-13  634  
00f5970193e22c HighPoint Linux Team 2007-12-13  635  static int hptiop_map_pci_bar_mv(struct hptiop_hba *hba)
00f5970193e22c HighPoint Linux Team 2007-12-13  636  {
00f5970193e22c HighPoint Linux Team 2007-12-13  637  	hba->u.mv.regs = hptiop_map_pci_bar(hba, 0);
9bcf091083065c Harvey Harrison      2008-05-22  638  	if (hba->u.mv.regs == NULL)
00f5970193e22c HighPoint Linux Team 2007-12-13  639  		return -1;
00f5970193e22c HighPoint Linux Team 2007-12-13  640  
00f5970193e22c HighPoint Linux Team 2007-12-13  641  	hba->u.mv.mu = hptiop_map_pci_bar(hba, 2);
9bcf091083065c Harvey Harrison      2008-05-22  642  	if (hba->u.mv.mu == NULL) {
00f5970193e22c HighPoint Linux Team 2007-12-13 @643  		iounmap(hba->u.mv.regs);
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  644  		return -1;
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  645  	}
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  646  
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  647  	return 0;
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  648  }
ede1e6f8b43246 HighPoint Linux Team 2006-05-16  649  

:::::: The code at line 643 was first introduced by commit
:::::: 00f5970193e22c48f399a2430635d6416b51befe [SCSI] hptiop: add more adapter models and other fixes

:::::: TO: HighPoint Linux Team <linux@highpoint-tech.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4zRzwnfG1/8AwFtU+n71AQA=

--6TrnltStXW4iwmi0--

Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F602C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE1420738
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgGHByE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:54:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:13901 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGHByD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:54:03 -0400
IronPort-SDR: l7XKe3HZDFabRoXT/Wq+JKlT9jDpqP5v6NhA9TEWQPfeG0crVwlNG1HjkBRWmk7fBzn0hr/zaG
 ytuHlkOfZJ5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127322270"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="gz'50?scan'50,208,50";a="127322270"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 18:51:42 -0700
IronPort-SDR: /TIdbel8hG4jk32vmBTrWbdsEMzTaZcCjqDSwrHwrWFZM/weGznUDGFpIBoHNmSs4CFLRf7mWE
 xGDT8uMtONjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="gz'50?scan'50,208,50";a="322814540"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2020 18:51:40 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jszFL-0000Tj-HV; Wed, 08 Jul 2020 01:51:39 +0000
Date:   Wed, 8 Jul 2020 09:50:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:3255:28: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <202007080937.TP0XSsuQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aa27b32b76d0b1b242d43977da0e5358da1c825f
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: arc-randconfig-s031-20200707 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-31-gabbfd661-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/mpt3sas/mpt3sas_base.c:1632:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1632:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:1632:33: sparse:     got unsigned int [usertype] *
   drivers/scsi/mpt3sas/mpt3sas_base.c:1687:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1687:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:1687:17: sparse:     got unsigned int [usertype] *
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3255:28: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got struct _MPI2_SYSTEM_INTERFACE_REGS volatile [noderef] [usertype] __iomem *chip @@
>> drivers/scsi/mpt3sas/mpt3sas_base.c:3255:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:3255:28: sparse:     got struct _MPI2_SYSTEM_INTERFACE_REGS volatile [noderef] [usertype] __iomem *chip
   drivers/scsi/mpt3sas/mpt3sas_base.c:4021:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:4043:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:4066:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:4087:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:5917:17: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:5936:20: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5944:20: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5957:36: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:7088:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:7088:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mpt3sas/mpt3sas_base.c:7088:25: sparse:     got unsigned int [usertype] *
--
>> drivers/scsi/megaraid.c:4489:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/megaraid.c:4489:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4489:26: sparse:     got void *
   drivers/scsi/megaraid.c:4548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/megaraid.c:4548:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/megaraid.c:4548:26: sparse:     got void *
--
   drivers/scsi/hptiop.c:150:53: sparse: sparse: restricted __le32 degrades to integer
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
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got struct hpt_iopmv_regs *regs @@
>> drivers/scsi/hptiop.c:643:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void const [noderef] __iomem *addr
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
   drivers/scsi/hptiop.c:150:51: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:51: sparse: sparse: dereference of noderef expression
--
>> drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *p @@     got void * @@
>> drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *p
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
   drivers/scsi/mvumi.c:673:35: sparse:     got void *reset_enable
--
   drivers/scsi/aic7xxx/aic79xx_osm.c:2266:16: sparse: sparse: cast to restricted __le16
   drivers/scsi/aic7xxx/aic79xx_osm.c:2285:37: sparse: sparse: cast to restricted __le16
>> drivers/scsi/aic7xxx/aic79xx_osm.c:1354:45: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned char volatile [noderef] [usertype] __iomem *maddr @@
>> drivers/scsi/aic7xxx/aic79xx_osm.c:1354:45: sparse:     expected void const [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic79xx_osm.c:1354:45: sparse:     got unsigned char volatile [noderef] [usertype] __iomem *maddr
   drivers/scsi/aic7xxx/aic79xx_osm.c:1773:49: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
--
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     expected unsigned int [usertype] len
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void const [noderef] __iomem *addr @@     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr @@
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse:     expected void const [noderef] __iomem *addr
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse:     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr

vim +3255 drivers/scsi/mpt3sas/mpt3sas_base.c

f92363d12359498 Sreekanth Reddy 2012-11-30  3235  
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3236  /**
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3237   * mpt3sas_base_unmap_resources - free controller resources
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3238   * @ioc: per adapter object
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3239   */
8bbb1cf63f5e345 Calvin Owens    2016-07-28  3240  static void
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3241  mpt3sas_base_unmap_resources(struct MPT3SAS_ADAPTER *ioc)
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3242  {
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3243  	struct pci_dev *pdev = ioc->pdev;
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3244  
1f95a47eec979e4 Joe Perches     2018-09-17  3245  	dexitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3246  
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3247  	_base_free_irq(ioc);
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3248  	_base_disable_msix(ioc);
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3249  
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3250  	kfree(ioc->replyPostRegisterIndex);
5f985d88bac34e7 Tomas Henzl     2015-12-23  3251  	ioc->replyPostRegisterIndex = NULL;
2b48be65685a23f Chaitra P B     2018-05-31  3252  
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3253  
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3254  	if (ioc->chip_phys) {
580d4e3153f0d7a Sreekanth Reddy 2015-06-30 @3255  		iounmap(ioc->chip);
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3256  		ioc->chip_phys = 0;
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3257  	}
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3258  
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3259  	if (pci_is_enabled(pdev)) {
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3260  		pci_release_selected_regions(ioc->pdev, ioc->bars);
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3261  		pci_disable_pcie_error_reporting(pdev);
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3262  		pci_disable_device(pdev);
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3263  	}
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3264  }
580d4e3153f0d7a Sreekanth Reddy 2015-06-30  3265  

:::::: The code at line 3255 was first introduced by commit
:::::: 580d4e3153f0d7a9a9235b675b0b7b13e2185a8b mpt3sas: Remove redundancy code while freeing the controller resources.

:::::: TO: Sreekanth Reddy <sreekanth.reddy@avagotech.com>
:::::: CC: James Bottomley <JBottomley@Odin.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--d6Gm4EdcadzBjdND
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/RlxP9aw0qeR2+c9iUgnnu9YyiNywr05ozRUb6c4n3sfTUmmY3ZoURwl0zE/bMTNXduwI+GO
MRAOF19Ib9p0xERgE5PEUvOlJKYameGlqmGuIzZdSE/QRLJgR934TeX6UbO+AV1og2a01lYU
yRy74vTxxkXJkzqGEqwIBHjRQlvAYRUpBJH9pB0N84rsy7QOfN7qybav1RGm2aJgk9LDSLea
KVo90Tq8Ht6ODyOJHJX3ILzL1MRieFL8jlRj5rIlKb7S5KzKy+Pwcjof0A1kOH1VgpcQMFmR
/gCCKaFq+vny/sTZnqsSpNjmSGYnkZbs5Dp8TXGTypNGPVs4ga5zg7nIeolbIYpo9Fn8ej8f
XkbF6yj6cfz5x+gdNfTvMEMxtZeHL8+nJwCLU0Q62z5ZY9CqHFR4eLQWG2LV+7S30/3jw+nF
Vo7Fqyw2u/LL8u1weH+4h8/67fSWfrNV8jtSpTv+d76zVTDASeS3j/tn6Jq17yxeY0gy5ftg
we2Oz8fXf4w6myIqqyycG1t9wXElusumf/XpO8Eub6PBtmuq+TlanYDw9aR3po0bKwPbyrfj
IEfGSQ7apaaSaERlUuErvJDkHyYEeMsvQpqEVyfoYs5wCqpeEeiwKpcvGcTguqAf7z65RkW/
61ayq6M+l2Xyz/nh9Npsq2E1iliGpv0aypuUrvcNailC4Mz8i+qGxPpWrMG34TyYofcUnjch
kVV6zCAaBkMx0/PY9ggZZWM4prLeWDylGoKqns2nXjioUuSTCfWgahDtFRt/S1VUmkCc6j6U
mE0GtLllUhGCBraPFhzpnujhFN4YJzgsXse0cZEI/mqZLiUVBTfWGmDVTQ8JVv25FGwZOpi2
VYH7qCNxNT6G6s9NI8ZzHFXh25KWXqp90NgKwoeHw/Ph7fRyOBs8KwQ12Qlc1kuixWlOg2G8
yzyae6IBWQKFtVgVJI0WmtrDt7Z4m5/PIg8dNt4IIFzdRxZ+E+dY9bsJlKdVF8EOkIY3W1hr
17Lr45CPqgKrr4rHxItSgTgfV4nRXTzkN65Vh/ZeuEuFBYcPCi7h0aZu4K92Ip4bP2kQOwUy
5uhqF329cgzviHZXR56rX9fleTj1afykBmSLJ9dgaSw9AJJIQwCYkWgpAJhPJo4ZklNBTYDu
ciI9Xmj/dlHgTizp1aLQvKzU1NErUPv4OyfELUIzdGwrSdE9qfbp6z1IZaPzafR4fDqe75/R
yg08imZdDjEU6UoG1s7qUN+c0/HcqYzdOXVcTltDhJ7aA367QUB/00wrEsJdQEnEjBT1p7Sq
gO4EBdmnSww7B0p2mGUJFyye0JG1AZhpYNYJCvWeP8imU90DG3/PHeO3R34TfzT4PXcpfu7P
6W/94i2M535AyqfShI2hVnu9NMLoPk4D7NVKvEk3U8tppw2GmgbmyueeSzbXSVaUSZcVtG9u
nYJUoN2trndTXUtWSU5oDzEhmT+lV9EImrEuIoiZBwNi9m4OZaCxS/32ZA4xm7OaRLLRZwFD
siQhwAs8ApgH+lAxQ5arv61AgE9ThSFo7vAh5jbhdmq7Ze4CVu1T2yfsSa5/TwIU3GQ30avM
tSNiKbvmRazux/m3R7LW8czhFlCL1J9ZtDBfjPWMaArsuI5H3A8b8HgmjGCnRrGZGE8GjTiB
IwI9F6gEQ03OZNCGmM5ZoVUhZ57vD4vMAjaEcdOKfH5A21ZRksmuAHCdRf6E2tfaqLg5vzGl
AcprNq5mYl0GzphW36iGu/bTttziEmfQecfy7fR6HiWvj0TMQ5mgSoCPmfc5tHqtcGND+PkM
CqbBfWYePXnXeeS7E77evgLVnR+HF/lwThxe34kWGtZZCCLxunmSSU52iUruigbHin1JMCNi
Hv42sl8rGGEjUSRm5BgMv1FZoszFdGzmXkqrFNWfVanLPKIUNHf09d1svmNnZTALyn/m+NgA
RvC5RtHp5eX0qtsheAJd7MtFn5tKDl2ZjUTZltMq1aVFUXbllGWSuw+hlOvtQl+fwzYMcZT2
i8eRT2Pgms+i7ADNFjhjsAy5cHkxaTIOtOdYGCOWBjBEiEWsBxSfHQsRPhFu4DeRBSaTuYsP
KURitIVwvsbJ3KtoFWPa8cD1K1MAmuD1AW0BIKZKpSHnAZ19gE31INny98yochrwXFCieMFy
Mp2O6XBMacuj/qdwpMxYDTQuC/SA1C/Qhe/TWzyQMpzAkvMQJZDA8pwvD1zP4zgUCAwTR/eV
ht9G7jgQD/wpn5ABMHMqSwDDgCGMZy4+brOxZKCYTKZsLHaJnHoO5b0ICxw9wJvkJWqy+uvx
SztFPVaHk+Tx4+WldaLWD5wBrvFtPvzvx+H14ddI/Ho9/zi8H/+Dr8LiWHwps6w1P6sLA2m9
vz+f3r7Ex/fz2/HvD7yn1/copsHUe3yxnKy5/HH/fvgzA7LD4yg7nX6OPkO7f4y+d/161/ql
t7UECZioAQBo5Num9f9v3b3j9sU5IafW06+30/vD6ecBvnLLBA17DB9LVeEcjwxBgQIT5AaE
alcJf0L448oJBr9Nfilh5NRZ7kLhgpSu0/UwWl6DU7W+3HpjvTMNwDQ4NAxgdVsVyoTB8aR6
BbL8mFvyw2lWXPZw/3z+ockfLfTtPKruz4dRfno9nqloskx8X5cBFICcQmizHTt8rAeFIgFj
2PY0pN5F1cGPl+Pj8fxLWzNtZ3LXo+JxvK4tqssaJfMxd023roWrS/fqN/2gDYx8zHW9JWmS
0+lYT8KDv13yeQYDUacQbPczvjN9Ody/f7yp6EYfMDFk/+LCJta8BmRydQm0RJtrsBbjYWrs
ipTZFWm/K/o3aLtCzKZje86DjsBm8bzKdwF3/Keba9wggdwg9D0OQbFmNZ2CE64ykQex2Nng
rLDW4i7Ut089woUufF29Avw0+yw1rPwttL8ZUE9ypUf7cDfEX+O9IMwyjLdobaBrBCOXsGds
5mHAQ610GYu5RxYdQuZknayd6cT4rWsjUe65zsyhAF3Fht+ebmCK0E9hQn8HukVzVbphOdZz
xSoIdH081m8uMNeWA6OiT2haWVxk7nzM2lUoCY0wJGEOK/58FaHj6lJJVVbjiX5CZHVFnRKu
4UP4ke7hE+58DJszgJDoEJsiBE7I9aEoa48EwimhT9LdhBxUjqMH+cbfemBMUV95nm6Rh9W9
vU6FO2FAdJ/0YLJF6kh4vuMbgCmbob6GGZ4EvNukxLFpzREzpRUCyJ94PDPYiokzc7lnj9fR
JqNfQEE8wmauk1waNbgKJIpEAMwCEgTzDr6S2yanbo4JuqXVk7L7p9fDWdnImc1+NZvTx/0S
Yjn4r8bzOXtV09z+5OFK88XRgCYD6BEGFwCYx4e5zPPIm7j0BVJzZsqKbPJNuyAwYTS51TUQ
xgo0kGQdtsgq9xz9E1O4KYwZ2AEXa9/1cd/rv7p0nz+fDzSYrjRabEnkVkLYCAcPz8fXwSLQ
2AuDlwStz8boz9H7+f71ETSg14Np/VhX6rFUc3fKPyOXTzPrpKq2Zc1RanQ1uk9kRVHyV7Ti
ViyFhuqGwXe2YXavIDCqyKCvTx/P8PfP0/tR5hQa7Ap55vuYLZZurt9XQdSUn6czsOljf2fc
sdOJO9VO+Fg4NJwbqMu+ztwkYEb1ZwmyZLOKMHU5a+sHjOMNFPEJH0APiUnYvLrMTDHcMlZ2
HuCb6NJolpdzZ8yrHrSIUloxmiaIPswhtijHwThf6SdM6VJjJv42TyEJIzs7ztZw6mrvt+NS
EB62LqndJY1Kx6a0lJlDtQoFsd3fKqR5HpYZnIf8cZyLSWDRUhDlcddGzYkpY88MZE8JZSVW
hTH6Vk+An3GKUOmOA62OuzIEUS0YAGhLLbBtpDUnmF+9F11fj69PzGIQ3rzhsjpTJMTNejr9
c3xBPQp39OMRT4wHZnVJWY0KXGkcVhg2INlf67t04RCRtEz1PPXVMp5OffrYR1RLSzxqsZt7
LBsExIQmCMNKuL2OAodnCO3X2cTLhpmPtdm+OCfNM9D30zO6Pv72jt0Vc0OtdIVjiwb8m2oV
Mzq8/ESjFnsKyEN7HAJvSXLdkbqO3DlNSYQx+XOVOr2Iiq0l1Gu2m48DXdpUEHKvl4MGQSzI
EsKfyjWwrTG/XSWKlSPR8uGo+OI9l2NmQZPqa0uY+TwxI1K06/RGS/YOPxR/pSAjhR6C0Gls
Wef6GzsEN5+Bb4fJjIpQ6Qttsewivr7h3xQ1ODPqkRJ5qm8ykvAwoBpg8K02daHbL1PuVEbP
uXIBx3ydaTkvmzzg1TftleTdphT7VUrePw/60HWhDKOrveGWsSjCCnOKRulgj3QiZJVCV9Oy
iOqQe+0Bx3RS01wnBBPuhDM2cmAhfFFFuagXzQUn27YiVM6Aqxtr2+r567CFOm3y6A4+VLm+
HYmPv9/ly9z+KzVeSntA96PQgDI+NfBnie7nMMr3V5hSdCsWLpLx6waKY4yvTZTs66Kqkg3n
MKRTyXZeOIxIQaTVPA8JLsyuC4rCXZPmu1n+DbtIq8zTHUxuPy6CLHfh3p1t8v1apCS9MUHi
sO1Dlg9jBlFZ9B6EZbkuNsk+j/MgsKxCJCyiJCvwarGKTT+plpWQz6qVxpfNRo5rTRjlwttU
IfG2gAH4g1UUvj6+nY6P5CJgE1eFJVJQS97t81BzLdnAWZkbP81DsQHiCxMRh5q/fpvGNEFv
CIQr4/PN6Px2/yCFEPM8ErXWGPxAn5MaPdxEShXIDgV92fNhcZAm3ub5LSc6AE4U26rJU1pk
umdsj+sc3bVHt3LX1+shRLrtvQygK0mrmVkbuLDEquwIcrFlet63VhMJtIMPPK57Y/lw4jWT
crniGNVSkPRN8FOGskFXN0yrxFungUjF8rI/X9dojHBZQ4JQRlgjBnJACiOio45aJPjsuv8Y
CCwiPZs1xr2Dw3nXm4A1SwETyWiL73ZW07kb6pVIoHB8/aEPQmV4AgLpXC2HdomBC0+Z74uS
8GSRst5QIktzxTg1gHrvJfPEGcujgr83Rrq1Bg2i36bWeSRIM/tv2zCOE33WClHrgzA8H9R9
7vEZRDF50umpDkJUFEBJWAp8oSlIUwKdrWiK22RXu/slJ6EBxtsvibDQgNBGkcIXiThpoKUR
SbStMK6E7tPhDyv00atkvywq2RV2CTcFf9esf6FZQ5SUsKvtJq1l4jftw35dxC79ZZaFRvJF
FEZr8k6kSlKYa8Cxc/lVIvo6vuqj0T/HV20Ilnra7tAydVinGB6La33Xtt4VQci3bVHzwRd2
trkmFGxuNEQUG+nPLKJquzAbbXDooptyhjikuQmrjVnOlsNutRSusaaKSME4i3FdGR+ihZCv
YeLgU4PgjBt71SytXvRraartBiQvWFC3e3tYBEXN8A2CDwWsJG5y+8aS5f4aZNIl6csmzawj
X7rGwCUAV80QCv/swrom+SRbxKUt2NIMt6DEqFmk61AVkVFk0s1XODFtEXLbuuHElWYhG90d
yJG2TYhTr0tc/FdPdujxSrvZwlSIPOAZbPVplqBP8hVaYDS1bRPjm95bCx4qBam9ui1x6BYw
aIorQXD48elC7IDWrdJTLLYpMOUNeiNswnpbJaRyFftD8xA0AakCqFBQehfCC2FDBqeNDsdA
EBiBSjFP9BroW5MERBPGdKZL4ZOFq2B0LUu+oh3t0VZowmcTgsE4O2CGsvB2zzgiR/cPP/Qg
OkuheMAvAyA3lRiC13A8F6sqzIeowYneIooF7ol9lgpe8JZUuK54bajpsup+/CdoBl/i61gK
DgO5IRXFHJQvY39+LbI04Y6iO6DXJ3sbL9uibeN8g8pGX4gvy7D+kuzwv6AH0y5pFmWgND5G
b1taysOLlQWWxrmmIG3AqrTAkCkiqf/69HH+PtPCtmzqweHRy2CXOq2MCu+Hj8cTZh8dzi96
qRuTK0FXlnzBEonGizoblClDjEhTALOx+ApIqmidZnGVcKFlrpJqo0+PoWbWeUl7KgG/EQkU
jWQcnEkxyZfxPqpAwyOROfB/vXTSavHDeezqSYUKbwRdrpNc63Qhk9caZ0AYD0SfBrSv+CwF
4ZJZAe0qkgeyDbu28R1AYLRj46hZWPnUYinIuZUMxvB1aWX0EZwwlFhBFOsCbZI/SBRNXnPm
YAHqiVjrPWohiqe152CvRBF0nFaGKjQkjDFrQLnHQPSWyFUmqdQrL3SW0KHLLomA11G1go4J
v8P3TNyQsjvu8bSGLthiu7tLpe5EHTOd8DEE8PVCBma5SxiCJF8koDhyZZdVuMqTTb1vmBJW
4HW8b6gR5OkGNje7pIp8QL0ubYv322bnD8gBGNgKVG31LxSCEQ3Ra/tWrVxi3DUIjGVrpVsU
NRdiSJGBmNU21J6iwLCJT4n8jVwkQwW7FUUHBLAGLiH9i8h1ZEfPfLdHGt2Ua8iO1RA9l+DH
07JJnrMMh/jv6P2L9JemoaVnuq5PyL/pBpmj3/dj0INPz//xfzx8GtQbKcumvSaMMDP4JpVu
wW17WGyGKw5OAA6G/2Icy0+fGNwVxrSRuz7wGTRmTgNmLEDncBl0yZQGjntNmOvWYLbq9/4G
dAzCDrYX9PekKganRQv7bSHz9O7grGmlw16wr3Q0d2nJ1BsBG69lhFAQwLI0T+u/HE14TOqb
orrSxROmiY0eVxN+9Ivr+H6azSbzPx1dIM1Q540T2aLPvq4gJFNvSmvvMVPyLITgZqavO0/E
W+cMIv5C1SD67ThIrGsD49jHEXCOQQaJd6E4x9sNkollfjH1tg0zt4xl7gXEgENwrJesUdy1
F/e5gBW0X1Of9hh0OlyA+5llII6ReNZEcu+5kEaG6qRT0Dbl8D1webDHg32zUy2Ce2as4wO+
vinf1zlP7Vh6pb/iIHBjBV0V6WxfmUOQ0K11L2EwWpBbQk67a/FRAqJvRBtT8E2dbKuCwVTF
/1V2LMtt48j7fIUrp92qzJTlJB7PIQeIhCSO+DJIWpIvLMXW2KpEskuSdyb79dvdIEiAaCrZ
Sxx1N/FGo9Hohyh1PhKvtmClojhm7RUMyVTImKsQ8+LMfXAEDcRgVTsPkVZRybWBehyd7XRZ
qXlk53NARFVObuzywph70KrSCFezdaBpQJ1i1Kw4uqcEXm3kW+sFMqsXt/YF1nma0b68m4e3
A5o4dSF7m4/ncuWcfvgbjubbCqrQwjsnVkhVRHDCgHwP9Bjr072vY5IfSSnPBm6yWrfIkHSt
qMNZnUFF1GvrzEIUKfqioEVZxiL6bMXosQWZYZQqYh/CfC2xgTiaCVNec7iydeVi4IWXXkUC
UlQmMJEzGecDhsJtWQUsIj5DSktSZkm24h9bWxqR5wLq5FQhLU2ciTCPUrZLDQ4mapKpYOBK
bIhXYiCKdtcrMUGDmL5dgl9rMA+zRYoOQQMv4t4LSAvs1Mncp3ac7AhDc4PwWaFkHKg6Cpef
R5dWkYBHezq8lvBl1em0pXAaA6gimv7oa6MIbIt4t92tf90/vXNLMmQzuFLXxUzwdnQc5dWn
6x9UbSg/ja76HXBJEs7atU/2+d3xeQ1FvbMJSBAHWRh48qpfB8j+YYMaKB5WsBJRId1pM1CK
fI0RgBJ+WkWxShKJe98wOIsIeFslaylUvNIRtPs8UN5xy890uOMxwo7wXyRwP3t5+Pr48vf+
/ff1bv3+28v68XW7f39c/7WBcraP77f70+YJ+fD7L69/vdOseb457DffLp7Xh8cNGex2LPqX
LgHSxXa/RV+47X/Xrit0hI/IwGiCOXBFO6I+IejxBraVnSzBo5jA+egSWBmz2coNerjtbYCH
/sFjKl9mSis8rMmhQwHlAq2EP3x/Pb1cPLwcNhcvh4vnzbdX8jN3iPFtSuRRv4wGfOXDYeGx
QJ+0mAdRPrMNGHoI/5OZEyfdAvqkyn6F62AsoaWC6DV8sCViqPHzPPep53nul4DqB58UJCAx
Zcpt4P4HVTFMjQlKxDiWjRVEn2o6GV3dJJUda14j0iqOPWoE+tXn9Ncrgf4wK6EqZyCcuPpr
wrB5EPK3L9+2D79+3Xy/eKDV+oTZj797i1QVwqsq9FeKDAIGxhKqsBBMK4Ez3cmrT59Gf3ht
FW+nZ3QveVifNo8Xck8NRjeev7en5wtxPL48bAkVrk9rrwdBkPjTE7iRrRvKGQiN4uoSuPtq
wNWy3XbTqBi5TqJmi8nbgTx87QjMBPCvO6+bYwoEsXt5tB9LTdPG3MwGE84szSBLf/EGzFKV
wdiDxWrhrbtsMma6m0PLhtuwZOqDI2uhhL9r05kZd69qgakeyyrxEGjPcGe47mx9fB4aPicn
ieFuieAGdXm2R3f6I+MwtTme/MpU8OHK3w4E9qDLJct5x7GYyyt/YjS84BavCsrRZchmqzCr
fubk6zMz2I16v8wkZMPeG+QnnzlGsLjJKNofbpWEuGO8QwLA15ccGERBDvzBjnZqNh2ImP5h
R9IkB9aiowf+4JebfPAJSxA6xtmU47RTNRrIwdhQLPJPbuhMLS9sX58dW86WzRRMLQCt2Rc8
g0+rceTvO6GCj14HQY5ZTCJmVRiEl7LPLDeRyDiO/MMhEHj71h9xOH/RIPSa6adnqu6iJ/T3
HMV8Ju4F9y5rZlLEhWBWkzkHWO4+kEG4xaucd09oV5Q/CaX0hxHu7Oy8NPBuWvQCetm9oued
I1+3w0ivVF5J+sHVhd3YiSVbOr/F9M7kQZvHWO12tt4/vuwu0rfdl83BRDfimoeZyuogV7bz
nWm5Gk972WdsTMO/OQzHUgnDHYqI8IB/RpjKTKJnTr7ysCgZ1lp4768Ag6JGnFsqLaERyocX
TUvKid4tki4IHgdzbaoswR5zqvVvLN+2Xw5ruDUdXt5O2z1zkGJYEiH9AgnOMRiKY6IPLSuT
UX8sLKrhUUAivTX9nEgeCY9qZczzJbRkLNocmCAb4zvf6BzJuWrOHLxdP35GGkXq9rDrFzXj
nL9cJQNlZ+6m1ELm1ThuaIpq7JItP13+UQdSNfpM6RnN5/OguMHE9neIxTIaip1N8bvJAsZ+
/zvdXvBjR9kXTVMZ1rnUdjJk0NvoVP2zFSPx/EV3hyOl/zxun/baG/PhefPwFe7+lm8PPT7a
WmDl2Jz6+MJ6RG6wclkqYY+M971HoV+MP17+ce3oFrM0FGrVbw6vidQlwybCdJZFyRMbC8Of
GBPT5HGUYhtgGtNy8rmNRTTEJ5SIwus6v7Wny8DqMVxQgWsrNrNnlEqharJFc40tBBn+cuZe
EYhimMvMGmHjcpjKsq7KyH4yNqhJlIbwj4JBGke2ZiJTof0IA11OJNzNk7HOH9T2BteZiP2C
Mf+ZcRNpN2EAF1A4SxzQqLdRg/qM6B7UUVnVbgHu8yUB2teVgTOHSGAzy/Hq5sckvJt7QyLU
gtcQa7w7qCq4dk6F4GOv6Wwq22js36ICy4Opf22CZRNmiTUKHcqx/dnZUG3o5sLRfA1PxtjZ
twQ1glSnOLXNlRyoVbIF5+yXhgyXkJorZcBYicAc/fIewf3f9fLGWYINlJw9cz6eW0MSDaUV
bfBCcQroDlnOYD95zSmA9/uNHAd/ejB3brse11PH8MRCjAFxxWLieycHaYdY3g/QZwPwjz4z
IOU15ezuFilcHuoiizPnQmVD8Xnxhv8AKzyDGlkX3XFg3RvGeF21D/ciCyJgYXcSpkM56UIF
ebnZvrQIchK1plgtJYgVOcmWvUS40JJYkF3XjKRnq2IVzKi8QpZVrvPi5gWHxzysiEbPNp0T
5kdUjoVqS0IJZZXMmcYgKs1Sg8B8GbmLbVF5lsUuSkmPWlvqtpjuuZwefqJBe6xiGuuFYvE5
cvZpXwQtRF7Vyq351j6E4mzs/mJ4YRq7dl/tYi2zJEJG3dUW39elsEqM1C1KrHZchTzStr6m
OVHi/IYfk9CqPItCzGQPwomdD6mY9oa4gPPD6SY+hKdTuzdWrJieHOK+SxnpjqCvh+3+9FVH
Stltjk++QQHJOHNKGOgIIBocYM4OPmMi2TDWcTaNQRyJ2zeP3wcpbqtIlp9bA0EjAXsltBT0
2Nc0JJQ6y2+3ylapgOk74x7nUNR9xwlLiEzG+LJZS6XgAz5y/uA4tpqI7bfNr6ftrhEmj0T6
oOEHf9R1m5rLqAeDFRNWgXQSvVtYw4MHtDIWZZHHES8bWUThQqgJf75NwzE6ZkZ5yTrOpPQY
lFSo/MId3PVlomAktWvm6PLqo21jAaUBQ8ZgBQmv6sLHZipYsGYFM4mhTYBrp8CK7a2pu1Ro
t0B0/UhEGVjiUh9DzUMX01W/DDKiqBdSzCl7l+a03UXiZ2f7FzsJZrM/w82Xt6cnfHuN9sfT
4W3nZvZOxDQiRx47bosFbN999dh/vvxnxFHpICx8CU2AlgJthjC3X3eVazpvnU+UJZfOljks
BXs54m/OKGpcuPZgBIDLnOASumrkGDNj2obBBEXXHb8gEcMZkfSUjZ0hE16biZDdxD81Fe5g
oOuT9NZY0zb7vb8tzOKsyN3g1oupJGy9sC4Dsb1TsIcw+4szaMeis0XKsmZC5llUZKlzj3fh
IAo0HsiDFPdSZT4LIiIlB7LCE4l2RGSdm3BBNUMLQlcMW6zf/x/B0TmMTk+tPxhdX15eDlC6
dnc9ZGtBMZn4nWyp0FMUM4NxRoQNwyFjjsrN914APwwblISbd489duIaFXEHHZqWtKF7nb5L
fAg9x/WdqFqk4ralVQ1c51zrv34TzsyrTutIhihnqBqWidIyz+A12SyazqDA84uERhDdbCdx
tvBb7aA5KSWgUZ4L5B1GLdkOqAZTGWSY7xrRdDvaq3WGQbP6Ojeiv8heXo/vLzC1wNurPhZm
6/2T46aaw64L0JAn4z3DHTxG6KiAz7tIlNayquzAaJmDFwyTEKxbiNmk9JFtW1q7LJuQ6uBU
T4PEbSutkcLK6lmFpnei4JRfi1s4geEcDjOLSREL10Xb8eTOD662mYWj+PENz1+GF+v92AvN
oYGuEEYw837QmUUxZbt7C2dkLmWuOa7WF6JlQ3fI/Ov4ut2jtQN0Yfd22vyzgf9sTg+//fbb
v62AoxgxgIqckvzfZtRu5XJY7lZcAEtgR4QSC11ECuM4pDYlAuzjIKdQcDusSrm0Hz2atd9l
LHdZA0++WGhMXcAGRcPbPoFaFI5froZSC3uno3ZIzX0m0CAGO6PvedACKXOuIhxnepJq7loO
d6SWwKbBa6lnVNRSdd1k9ZHm4vZ/LIh2PyhMigj8xvDtVo4GrkXIDkbyLIxaXaX4ZAtrW2sI
meNNn9ADPOyrlo8e16f1BQpGD6gk9y4vqHBnpIN+9AF39Uz9L7RxOEj07MiSOJHWoShRPUGB
mb1gHg6PGGh8v9YArlggRoIkzCSRDypWntM7rMnm3Qd6YRfMBFprx9J/wQeYYJsBD3+Ahyrd
eVr+fzVyvmyWQ3eTAqC8ZUPImIimTlf7gwQcWl+FFJ3oZw5zHekEhF1UXnHDgErkNFiVmbUF
UwqeDW22ziv9mxwOe6tb74TAZT6kJOknk6akyETvyL/wp8QWFosIb3/9mq2iiPUsgNDWyMCV
Wyaw+uAKRZ+CnJzar8xefUbPxHWR5e0TbwLxxMW5Nt9wxtfqFk7jiVeLPtz60NkiFuXQoBcp
SGyzrBxEtKKdOzJ6ZsbAbGBYYUNMMLmhs9MdnCTLZ97xtiEQKXAFgc9/+kvJykmGGDaEIfNH
2cc0jekPAjqyYvg8yq/trDyjSKJ15cTBSMtZB7X8aXA89CrUcYo4vtCuoe6FkF+MHXrn1wE3
edRK40CwI6rXFLINhRrowRPMrvCHxNZWIL2cR+kPEO6GutVkGrzAQKw+A14fHjgGPLqe07Hn
iGYura0KLTfHE56zKCcGL//ZHNZPG8uRCsO5dfxVR3cjZua6F3dh3zi/J0LKJfWjx7E1jri1
GzPOHHiocMxUF8nKrjWbwBX7HD3n0yZLHf6RIXeCNA4H0HKvTXA7CrK7ZqnlliimqlRzJS1k
GnOlTmiah2XCrhwt3uNTfZGpM0qcJEpR0cdHYCWKwe/HRjAiYezMiqdHojN4+7FpkIpCUOEu
PF+YjigytIzMS4Sr7rd7O5PLsErODYd+L9A+axy3NFRFkK+84mFfqZINZUno1g7C/Uq/WQy3
CfCwEGNeS611ddWAjxlhl/RWN4znLv4uhcIH82Gthh7aIZM1wkYhF4ZML+O5ZZttOozPe7te
GXcJXWXODANaswVZzjlX6YLzSb8qtHmZZaQevHN2Nxp6QEPO2p1QEZNIJXBlsEUsWiMmilTL
xPG3xQftJAO4dliEZddicL0+08kxvFDJFZNsjfpfJjIJQIg5uxnIfGZAS2UK6RM0aMD0X9zO
Hiiec5V+gPsf3WNRLYG7AQA=

--d6Gm4EdcadzBjdND--

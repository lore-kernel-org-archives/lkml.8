Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2385C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707DB2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgF2Spo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:45:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:29706 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgF2Sox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:53 -0400
IronPort-SDR: 2AyJla2vpiiXJI02HeXcKMenVwMZF0qiMso/M4E9vfrWOJHS0uvcYrehHJV040Nj0e4Qg5Q0M2
 tl0RkDPYzM2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133369255"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="133369255"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 03:15:37 -0700
IronPort-SDR: B61XpFg7fobl8FMN542xae065ix3Gfrn2nyyFFX/FoKIyREUW8bveEw0EIR9INWyhPU8CgyWp6
 jS06IJSPsMGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="gz'50?scan'50,208,50";a="303015344"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2020 03:15:33 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpqp2-0000vh-NG; Mon, 29 Jun 2020 10:15:32 +0000
Date:   Mon, 29 Jun 2020 18:15:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202006291815.k6Y78vA7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   11 days ago
config: s390-randconfig-s031-20200629 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C= CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/megaraid/megaraid_sas_base.c:4534:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4534:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4534:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4785:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4785:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4785:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6594:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6594:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6594:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4441:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4441:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4441:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:281:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] flags @@
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse:     expected unsigned short [usertype] val
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse:     got restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:287:31: sparse: sparse: cast from restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:413:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1206:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] opcode @@     got restricted __le32 [usertype] opcode @@
   drivers/scsi/megaraid/megaraid_sas_base.c:1206:32: sparse:     expected unsigned int [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:1206:32: sparse:     got restricted __le32 [usertype] opcode
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:1984:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:2025:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:4665:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4665:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4665:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:4904:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:4904:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:4904:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5089:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5089:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5089:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:5171:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:5171:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:5171:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6147:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6146:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6146:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6146:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6151:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/megaraid/megaraid_sas_base.c:6150:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] [usertype] __iomem * @@     got unsigned int [usertype] * @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6150:57: sparse:     expected unsigned int [noderef] [usertype] __iomem *
   drivers/scsi/megaraid/megaraid_sas_base.c:6150:57: sparse:     got unsigned int [usertype] *
   drivers/scsi/megaraid/megaraid_sas_base.c:6458:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6458:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6458:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:6672:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] flags @@     got int @@
   drivers/scsi/megaraid/megaraid_sas_base.c:6672:21: sparse:     expected restricted __le16 [usertype] flags
   drivers/scsi/megaraid/megaraid_sas_base.c:6672:21: sparse:     got int
   drivers/scsi/megaraid/megaraid_sas_base.c:7407:44: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/megaraid/megaraid_sas_base.c:8031:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected int crash_support @@     got restricted __le32 @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8031:23: sparse:     expected int crash_support
   drivers/scsi/megaraid/megaraid_sas_base.c:8031:23: sparse:     got restricted __le32
   drivers/scsi/megaraid/megaraid_sas_base.c:8114:31: sparse: sparse: invalid assignment: &=
   drivers/scsi/megaraid/megaraid_sas_base.c:8114:31: sparse:    left side has type restricted __le16
   drivers/scsi/megaraid/megaraid_sas_base.c:8114:31: sparse:    right side has type int
   drivers/scsi/megaraid/megaraid_sas_base.c:8208:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __le64 [usertype] @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8208:36: sparse:     expected unsigned long
   drivers/scsi/megaraid/megaraid_sas_base.c:8208:36: sparse:     got restricted __le64 [usertype]
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long @@     got restricted __le32 [usertype] @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:36: sparse:     expected unsigned long
   drivers/scsi/megaraid/megaraid_sas_base.c:8210:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] *sense_cioc_ptr @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const volatile [noderef] __user *
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got void [noderef] __user **sense_ioc_ptr @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     expected void const volatile [noderef] __user *
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     got void [noderef] __user **sense_ioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got void [noderef] __user **sense_ioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     expected void [noderef] __user *ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     got void [noderef] __user **sense_ioc_ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8665:46: sparse: sparse: restricted __le32 degrades to integer
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: too many warnings
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *p
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] __iomem *screen_base

vim +8458 drivers/scsi/megaraid/megaraid_sas_base.c

c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8414  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8415  #ifdef CONFIG_COMPAT
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8416  static int megasas_mgmt_compat_ioctl_fw(struct file *file, unsigned long arg)
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8417  {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8418  	struct compat_megasas_iocpacket __user *cioc =
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8419  	    (struct compat_megasas_iocpacket __user *)arg;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8420  	struct megasas_iocpacket __user *ioc =
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8421  	    compat_alloc_user_space(sizeof(struct megasas_iocpacket));
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8422  	int i;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8423  	int error = 0;
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8424  	compat_uptr_t ptr;
323c4a02c631d0 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  8425  	u32 local_sense_off;
323c4a02c631d0 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  8426  	u32 local_sense_len;
ea1c928bb6051e drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8427  	u32 user_sense_off;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8428  
83aabc1be551dd drivers/scsi/megaraid/megaraid_sas.c      Jeff Garzik                2006-10-04  8429  	if (clear_user(ioc, sizeof(*ioc)))
83aabc1be551dd drivers/scsi/megaraid/megaraid_sas.c      Jeff Garzik                2006-10-04  8430  		return -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8431  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8432  	if (copy_in_user(&ioc->host_no, &cioc->host_no, sizeof(u16)) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8433  	    copy_in_user(&ioc->sgl_off, &cioc->sgl_off, sizeof(u32)) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8434  	    copy_in_user(&ioc->sense_off, &cioc->sense_off, sizeof(u32)) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8435  	    copy_in_user(&ioc->sense_len, &cioc->sense_len, sizeof(u32)) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8436  	    copy_in_user(ioc->frame.raw, cioc->frame.raw, 128) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8437  	    copy_in_user(&ioc->sge_count, &cioc->sge_count, sizeof(u32)))
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8438  		return -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8439  
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8440  	/*
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8441  	 * The sense_ptr is used in megasas_mgmt_fw_ioctl only when
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8442  	 * sense_len is not null, so prepare the 64bit value under
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8443  	 * the same condition.
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8444  	 */
ea1c928bb6051e drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8445  	if (get_user(local_sense_off, &ioc->sense_off) ||
ea1c928bb6051e drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8446  		get_user(local_sense_len, &ioc->sense_len) ||
ea1c928bb6051e drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8447  		get_user(user_sense_off, &cioc->sense_off))
323c4a02c631d0 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  8448  		return -EFAULT;
323c4a02c631d0 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  8449  
47db7873136a9c drivers/scsi/megaraid/megaraid_sas_base.c Wenwen Wang                2018-10-06  8450  	if (local_sense_off != user_sense_off)
47db7873136a9c drivers/scsi/megaraid/megaraid_sas_base.c Wenwen Wang                2018-10-06  8451  		return -EINVAL;
47db7873136a9c drivers/scsi/megaraid/megaraid_sas_base.c Wenwen Wang                2018-10-06  8452  
323c4a02c631d0 drivers/scsi/megaraid/megaraid_sas_base.c sumit.saxena@avagotech.com 2015-10-15  8453  	if (local_sense_len) {
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8454  		void __user **sense_ioc_ptr =
ea1c928bb6051e drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8455  			(void __user **)((u8 *)((unsigned long)&ioc->frame.raw) + local_sense_off);
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8456  		compat_uptr_t *sense_cioc_ptr =
ea1c928bb6051e drivers/scsi/megaraid/megaraid_sas_base.c Sumit Saxena               2016-01-28  8457  			(compat_uptr_t *)(((unsigned long)&cioc->frame.raw) + user_sense_off);
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11 @8458  		if (get_user(ptr, sense_cioc_ptr) ||
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11 @8459  		    put_user(compat_ptr(ptr), sense_ioc_ptr))
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8460  			return -EFAULT;
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8461  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8462  
b3dc1a212e5167 drivers/scsi/megaraid/megaraid_sas.c      Tomas Henzl                2010-02-11  8463  	for (i = 0; i < MAX_IOCTL_SGE; i++) {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8464  		if (get_user(ptr, &cioc->sgl[i].iov_base) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8465  		    put_user(compat_ptr(ptr), &ioc->sgl[i].iov_base) ||
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8466  		    copy_in_user(&ioc->sgl[i].iov_len,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8467  				 &cioc->sgl[i].iov_len, sizeof(compat_size_t)))
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8468  			return -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8469  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8470  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8471  	error = megasas_mgmt_ioctl_fw(file, (unsigned long)ioc);
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8472  
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8473  	if (copy_in_user(&cioc->frame.hdr.cmd_status,
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8474  			 &ioc->frame.hdr.cmd_status, sizeof(u8))) {
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8475  		printk(KERN_DEBUG "megasas: error copy_in_user cmd_status\n");
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8476  		return -EFAULT;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8477  	}
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8478  	return error;
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8479  }
c4a3e0a529ab3e drivers/scsi/megaraid/megaraid_sas.c      Bagalkote, Sreenivas       2005-09-20  8480  

:::::: The code at line 8458 was first introduced by commit
:::::: b3dc1a212e5167984616445990c76056034f8eeb [SCSI] megaraid_sas: fix for 32bit apps

:::::: TO: Tomas Henzl <thenzl@redhat.com>
:::::: CC: James Bottomley <James.Bottomley@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--XsQoSWH+UP9D9v3l--

Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C059AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A0320789
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390698AbgFXMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:40:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:9927 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389336AbgFXMkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:40:09 -0400
IronPort-SDR: MkDjde31IUD6Z7OSl5vE7JrLm8dOeiPcAbs9Xi4BWdm4yWEmIV/Id36W7DQlbY9jzy+zUJ9Uyy
 aQlYvlxjgycA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="145948944"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="gz'50?scan'50,208,50";a="145948944"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 05:39:35 -0700
IronPort-SDR: cIg9x84LHdamZZcii3et47WwRE7BUIbSi+kKfk+GXa7z8y3ot3RzvmV3O9XbY7ePP4kZaCwTCA
 LtP+/xYqd0LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="gz'50?scan'50,208,50";a="293527618"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jun 2020 05:39:34 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jo4gf-0000vA-Fm; Wed, 24 Jun 2020 12:39:33 +0000
Date:   Wed, 24 Jun 2020 20:39:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202006242051.lMjQbC9f%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 days ago
config: sparc64-randconfig-s031-20200624 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=sparc64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

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
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] *sense_cioc_ptr @@
>> drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     expected void const volatile [noderef] __user *
   drivers/scsi/megaraid/megaraid_sas_base.c:8458:21: sparse:     got unsigned int [usertype] *sense_cioc_ptr
>> drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got void [noderef] __user **sense_ioc_ptr @@
   drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     expected void const volatile [noderef] __user *
>> drivers/scsi/megaraid/megaraid_sas_base.c:8459:21: sparse:     got void [noderef] __user **sense_ioc_ptr
   drivers/scsi/megaraid/megaraid_sas_base.c:8665:46: sparse: sparse: restricted __le32 degrades to integer
--
   drivers/video/fbdev/aty/atyfb_base.c:475:9: sparse: sparse: switch with no cases
>> drivers/video/fbdev/aty/atyfb_base.c:2930:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *ati_regbase @@     got void * @@
>> drivers/video/fbdev/aty/atyfb_base.c:2930:26: sparse:     expected void [noderef] __iomem *ati_regbase
   drivers/video/fbdev/aty/atyfb_base.c:2930:26: sparse:     got void *
>> drivers/video/fbdev/aty/atyfb_base.c:2936:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got char * @@
>> drivers/video/fbdev/aty/atyfb_base.c:2936:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/aty/atyfb_base.c:2936:27: sparse:     got char *
   drivers/video/fbdev/aty/atyfb_base.c:3573:34: sparse: sparse: cast removes address space '__iomem' of expression

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

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lrZ03NoBR/3+SXJZ--

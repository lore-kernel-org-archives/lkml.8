Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDEDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0220855
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgHPTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:33:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:4884 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbgHPTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:33:26 -0400
IronPort-SDR: HAfz1953hwzgo1H5OcIk/in3EIlCywrpgSjmQujDGMtnOG01nNP0c+0GGXBblvBnvT3bkGlxsR
 byfm2DL5Tj+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="142226070"
X-IronPort-AV: E=Sophos;i="5.76,321,1592895600"; 
   d="gz'50?scan'50,208,50";a="142226070"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 12:31:19 -0700
IronPort-SDR: zvSgUBropc/mvYJSW3ttDz31a2pfYiF22eCkFXjBAZw0vsSPQ1ECSu/qobjZ2xfwkDvLD7Br33
 2O6YG/I9EHXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,321,1592895600"; 
   d="gz'50?scan'50,208,50";a="277546689"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2020 12:31:17 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7ONA-0000DK-Dj; Sun, 16 Aug 2020 19:31:16 +0000
Date:   Mon, 17 Aug 2020 03:30:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: drivers/iommu/amd/init.c:3073:19: warning: no previous prototype for
 'get_amd_iommu'
Message-ID: <202008170325.VuQyqAE3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cc3c4b3c2e9c99e90aaf19cd801ff2c160f283c
commit: ad8694bac410e5d72ad610dfb146f58bf2fe0365 iommu/amd: Move AMD IOMMU driver into subdirectory
date:   10 weeks ago
config: x86_64-randconfig-r034-20200817 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        git checkout ad8694bac410e5d72ad610dfb146f58bf2fe0365
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/amd/init.c:3073:19: warning: no previous prototype for 'get_amd_iommu' [-Wmissing-prototypes]
    3073 | struct amd_iommu *get_amd_iommu(unsigned int idx)
         |                   ^~~~~~~~~~~~~
>> drivers/iommu/amd/init.c:3092:4: warning: no previous prototype for 'amd_iommu_pc_get_max_banks' [-Wmissing-prototypes]
    3092 | u8 amd_iommu_pc_get_max_banks(unsigned int idx)
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/amd/init.c:3103:6: warning: no previous prototype for 'amd_iommu_pc_supported' [-Wmissing-prototypes]
    3103 | bool amd_iommu_pc_supported(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/amd/init.c:3109:4: warning: no previous prototype for 'amd_iommu_pc_get_max_counters' [-Wmissing-prototypes]
    3109 | u8 amd_iommu_pc_get_max_counters(unsigned int idx)
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/amd/init.c:3158:5: warning: no previous prototype for 'amd_iommu_pc_get_reg' [-Wmissing-prototypes]
    3158 | int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
         |     ^~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/amd/init.c:3167:5: warning: no previous prototype for 'amd_iommu_pc_set_reg' [-Wmissing-prototypes]
    3167 | int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
         |     ^~~~~~~~~~~~~~~~~~~~

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad8694bac410e5d72ad610dfb146f58bf2fe0365
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout ad8694bac410e5d72ad610dfb146f58bf2fe0365
vim +/get_amd_iommu +3073 drivers/iommu/amd/init.c

30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3072  
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24 @3073  struct amd_iommu *get_amd_iommu(unsigned int idx)
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3074  {
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3075  	unsigned int i = 0;
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3076  	struct amd_iommu *iommu;
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3077  
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3078  	for_each_iommu(iommu)
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3079  		if (i++ == idx)
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3080  			return iommu;
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3081  	return NULL;
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3082  }
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3083  EXPORT_SYMBOL(get_amd_iommu);
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3084  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3085  /****************************************************************************
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3086   *
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3087   * IOMMU EFR Performance Counter support functionality. This code allows
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3088   * access to the IOMMU PC functionality.
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3089   *
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3090   ****************************************************************************/
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3091  
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24 @3092  u8 amd_iommu_pc_get_max_banks(unsigned int idx)
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3093  {
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3094  	struct amd_iommu *iommu = get_amd_iommu(idx);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3095  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3096  	if (iommu)
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3097  		return iommu->max_banks;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3098  
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3099  	return 0;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3100  }
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3101  EXPORT_SYMBOL(amd_iommu_pc_get_max_banks);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3102  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05 @3103  bool amd_iommu_pc_supported(void)
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3104  {
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3105  	return amd_iommu_pc_present;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3106  }
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3107  EXPORT_SYMBOL(amd_iommu_pc_supported);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3108  
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24 @3109  u8 amd_iommu_pc_get_max_counters(unsigned int idx)
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3110  {
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3111  	struct amd_iommu *iommu = get_amd_iommu(idx);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3112  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3113  	if (iommu)
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3114  		return iommu->max_counters;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3115  
f5863a00e73c432 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3116  	return 0;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3117  }
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3118  EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3119  
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3120  static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3121  				u8 fxn, u64 *value, bool is_write)
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3122  {
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3123  	u32 offset;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3124  	u32 max_offset_lim;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3125  
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3126  	/* Make sure the IOMMU PC resource is available */
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3127  	if (!amd_iommu_pc_present)
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3128  		return -ENODEV;
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3129  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3130  	/* Check for valid iommu and pc register indexing */
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3131  	if (WARN_ON(!iommu || (fxn > 0x28) || (fxn & 7)))
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3132  		return -ENODEV;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3133  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3134  	offset = (u32)(((0x40 | bank) << 12) | (cntr << 8) | fxn);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3135  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3136  	/* Limit the offset to the hw defined mmio region aperture */
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3137  	max_offset_lim = (u32)(((0x40 | iommu->max_banks) << 12) |
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3138  				(iommu->max_counters << 8) | 0x28);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3139  	if ((offset < MMIO_CNTR_REG_OFFSET) ||
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3140  	    (offset > max_offset_lim))
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3141  		return -EINVAL;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3142  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3143  	if (is_write) {
0a6d80c70b9150d drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3144  		u64 val = *value & GENMASK_ULL(47, 0);
0a6d80c70b9150d drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3145  
0a6d80c70b9150d drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3146  		writel((u32)val, iommu->mmio_base + offset);
0a6d80c70b9150d drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3147  		writel((val >> 32), iommu->mmio_base + offset + 4);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3148  	} else {
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3149  		*value = readl(iommu->mmio_base + offset + 4);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3150  		*value <<= 32;
0a6d80c70b9150d drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3151  		*value |= readl(iommu->mmio_base + offset);
0a6d80c70b9150d drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3152  		*value &= GENMASK_ULL(47, 0);
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3153  	}
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3154  
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3155  	return 0;
30861ddc9cca479 drivers/iommu/amd_iommu_init.c Steven L Kinney       2013-06-05  3156  }
38e45d02ea9f194 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-02-23  3157  
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24 @3158  int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)
38e45d02ea9f194 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-02-23  3159  {
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3160  	if (!iommu)
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3161  		return -EINVAL;
38e45d02ea9f194 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2016-02-23  3162  
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3163  	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, false);
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3164  }
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3165  EXPORT_SYMBOL(amd_iommu_pc_get_reg);
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24  3166  
1650dfd1a9bcde8 drivers/iommu/amd_iommu_init.c Suravee Suthikulpanit 2017-02-24 @3167  int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64 *value)

:::::: The code at line 3073 was first introduced by commit
:::::: f5863a00e73c432b91e4efe1d68778b4ace6a892 x86/events/amd/iommu.c: Modify functions to query max banks and counters

:::::: TO: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Q68bSM7Ycu6FN28Q--

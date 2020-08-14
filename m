Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F9422BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNCNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:13:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:59814 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgHNCNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:13:32 -0400
IronPort-SDR: LArwLOmjHn66xIfFAcfKshc8Y6IJZDYBtplckE8GysQZcJY/saJUOcrjQLIAf8NCnVJzenkHCZ
 Ltrgn21OWDRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239179376"
X-IronPort-AV: E=Sophos;i="5.76,310,1592895600"; 
   d="scan'208";a="239179376"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 19:13:25 -0700
IronPort-SDR: I0YPn46lxh4MOJPgapN7kyRYFy7cKnvhCYISW6Km4bFeJCOKWdEEtQsJnQKadkwRLnIxfjPoCT
 2vRMihvpcgcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,310,1592895600"; 
   d="scan'208";a="369780011"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Aug 2020 19:13:23 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k6PDe-0000vt-RR; Fri, 14 Aug 2020 02:13:22 +0000
Date:   Fri, 14 Aug 2020 10:13:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: warning: Identical
 condition 'ret', second condition is always false
Message-ID: <202008141056.pH1iGiVe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dddcbc139e96bd18d8c65ef7b7e440f0d32457c2
commit: caad2613dc4bd7396f1f0d32f5f0e650f9d8ebc4 drm/amd/powerplay: move table setting common code to smu_cmn.c
date:   3 weeks ago
compiler: alpha-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smu_cmn.c:
>> drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_cmn.c:477:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/smu_cmn.c:336:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%02d. %-20s (%2d) : %sn",
             ^

vim +/ret +485 drivers/gpu/drm/amd/powerplay/smu_cmn.c

   304	
   305	size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
   306					   char *buf)
   307	{
   308		uint32_t feature_mask[2] = { 0 };
   309		int32_t feature_index = 0;
   310		uint32_t count = 0;
   311		uint32_t sort_feature[SMU_FEATURE_COUNT];
   312		uint64_t hw_feature_count = 0;
   313		size_t size = 0;
   314		int ret = 0, i;
   315	
   316		ret = smu_cmn_get_enabled_mask(smu,
   317					       feature_mask,
   318					       2);
   319		if (ret)
   320			return 0;
   321	
   322		size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
   323				feature_mask[1], feature_mask[0]);
   324	
   325		for (i = 0; i < SMU_FEATURE_COUNT; i++) {
   326			feature_index = smu_cmn_to_asic_specific_index(smu,
   327								       CMN2ASIC_MAPPING_FEATURE,
   328								       i);
   329			if (feature_index < 0)
   330				continue;
   331			sort_feature[feature_index] = i;
   332			hw_feature_count++;
   333		}
   334	
   335		for (i = 0; i < hw_feature_count; i++) {
 > 336			size += sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
   337				       count++,
   338				       smu_get_feature_name(smu, sort_feature[i]),
   339				       i,
   340				       !!smu_cmn_feature_is_enabled(smu, sort_feature[i]) ?
   341				       "enabled" : "disabled");
   342		}
   343	
   344		return size;
   345	}
   346	
   347	int smu_cmn_set_pp_feature_mask(struct smu_context *smu,
   348					uint64_t new_mask)
   349	{
   350		int ret = 0;
   351		uint32_t feature_mask[2] = { 0 };
   352		uint64_t feature_2_enabled = 0;
   353		uint64_t feature_2_disabled = 0;
   354		uint64_t feature_enables = 0;
   355	
   356		ret = smu_cmn_get_enabled_mask(smu,
   357					       feature_mask,
   358					       2);
   359		if (ret)
   360			return ret;
   361	
   362		feature_enables = ((uint64_t)feature_mask[1] << 32 |
   363				   (uint64_t)feature_mask[0]);
   364	
   365		feature_2_enabled  = ~feature_enables & new_mask;
   366		feature_2_disabled = feature_enables & ~new_mask;
   367	
   368		if (feature_2_enabled) {
   369			ret = smu_cmn_feature_update_enable_state(smu,
   370								  feature_2_enabled,
   371								  true);
   372			if (ret)
   373				return ret;
   374		}
   375		if (feature_2_disabled) {
   376			ret = smu_cmn_feature_update_enable_state(smu,
   377								  feature_2_disabled,
   378								  false);
   379			if (ret)
   380				return ret;
   381		}
   382	
   383		return ret;
   384	}
   385	
   386	int smu_cmn_disable_all_features_with_exception(struct smu_context *smu,
   387							enum smu_feature_mask mask)
   388	{
   389		uint64_t features_to_disable = U64_MAX;
   390		int skipped_feature_id;
   391	
   392		skipped_feature_id = smu_cmn_to_asic_specific_index(smu,
   393								    CMN2ASIC_MAPPING_FEATURE,
   394								    mask);
   395		if (skipped_feature_id < 0)
   396			return -EINVAL;
   397	
   398		features_to_disable &= ~(1ULL << skipped_feature_id);
   399	
   400		return smu_cmn_feature_update_enable_state(smu,
   401							   features_to_disable,
   402							   0);
   403	}
   404	
   405	int smu_cmn_get_smc_version(struct smu_context *smu,
   406				    uint32_t *if_version,
   407				    uint32_t *smu_version)
   408	{
   409		int ret = 0;
   410	
   411		if (!if_version && !smu_version)
   412			return -EINVAL;
   413	
   414		if (smu->smc_fw_if_version && smu->smc_fw_version)
   415		{
   416			if (if_version)
   417				*if_version = smu->smc_fw_if_version;
   418	
   419			if (smu_version)
   420				*smu_version = smu->smc_fw_version;
   421	
   422			return 0;
   423		}
   424	
   425		if (if_version) {
   426			ret = smu_send_smc_msg(smu, SMU_MSG_GetDriverIfVersion, if_version);
   427			if (ret)
   428				return ret;
   429	
   430			smu->smc_fw_if_version = *if_version;
   431		}
   432	
   433		if (smu_version) {
   434			ret = smu_send_smc_msg(smu, SMU_MSG_GetSmuVersion, smu_version);
   435			if (ret)
   436				return ret;
   437	
   438			smu->smc_fw_version = *smu_version;
   439		}
   440	
   441		return ret;
   442	}
   443	
   444	int smu_cmn_update_table(struct smu_context *smu,
   445				 enum smu_table_id table_index,
   446				 int argument,
   447				 void *table_data,
   448				 bool drv2smu)
   449	{
   450		struct smu_table_context *smu_table = &smu->smu_table;
   451		struct amdgpu_device *adev = smu->adev;
   452		struct smu_table *table = &smu_table->driver_table;
   453		int table_id = smu_cmn_to_asic_specific_index(smu,
   454							      CMN2ASIC_MAPPING_TABLE,
   455							      table_index);
   456		uint32_t table_size;
   457		int ret = 0;
   458		if (!table_data || table_id >= SMU_TABLE_COUNT || table_id < 0)
   459			return -EINVAL;
   460	
   461		table_size = smu_table->tables[table_index].size;
   462	
   463		if (drv2smu) {
   464			memcpy(table->cpu_addr, table_data, table_size);
   465			/*
   466			 * Flush hdp cache: to guard the content seen by
   467			 * GPU is consitent with CPU.
   468			 */
   469			amdgpu_asic_flush_hdp(adev, NULL);
   470		}
   471	
   472		ret = smu_send_smc_msg_with_param(smu, drv2smu ?
   473						  SMU_MSG_TransferTableDram2Smu :
   474						  SMU_MSG_TransferTableSmu2Dram,
   475						  table_id | ((argument & 0xFFFF) << 16),
   476						  NULL);
   477		if (ret)
   478			return ret;
   479	
   480		if (!drv2smu) {
   481			amdgpu_asic_flush_hdp(adev, NULL);
   482			memcpy(table_data, table->cpu_addr, table_size);
   483		}
   484	
 > 485		return ret;
   486	}
   487	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

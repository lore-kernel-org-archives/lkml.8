Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776FDC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5972220784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgCTSR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:17:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:6726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCTSR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:17:57 -0400
IronPort-SDR: Fi4+DyjGKZt7f2T8v7Uw/VxUf31/CtlRgrJIwwfDeO63l8oh1aOxwdWXWkW8YmY8mrW/17bkG+
 5UmncybjrIhQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 11:17:57 -0700
IronPort-SDR: HPoo2BfGTeZXfc2JvSXi6Z+H8E5VFos3SyAL5VyFs45GdE0BcEUeHr4+yMjje42acXjshnw6Wy
 KrQAsIKwXA1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392230366"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12]) ([10.255.34.12])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:17:55 -0700
Subject: Re: [PATCH 4/7] soundwire: intel: add definitions for shim_mask
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-5-pierre-louis.bossart@linux.intel.com>
 <20200320134257.GD4885@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <deeb3af8-e950-651c-50d6-6223e75801e9@linux.intel.com>
Date:   Fri, 20 Mar 2020 09:13:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320134257.GD4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
>> index 568c84a80d79..cfc83120b8f9 100644
>> --- a/drivers/soundwire/intel.h
>> +++ b/drivers/soundwire/intel.h
>> @@ -16,6 +16,7 @@
>>    * @ops: Shim callback ops
>>    * @dev: device implementing hw_params and free callbacks
>>    * @shim_lock: mutex to handle access to shared SHIM registers
>> + * @shim_mask: global pointer to check SHIM register initialization
>>    */
>>   struct sdw_intel_link_res {
>>   	struct platform_device *pdev;
>> @@ -27,6 +28,7 @@ struct sdw_intel_link_res {
>>   	const struct sdw_intel_ops *ops;
>>   	struct device *dev;
>>   	struct mutex *shim_lock; /* protect shared registers */
>> +	u32 *shim_mask;
> 
> You have a pointer, okay where is it initialized

same answer as shim_lock, it's initialized at the higher level

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L252


>>   };
>>   
>>   #endif /* __SDW_INTEL_LOCAL_H */
>> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
>> index 979b41b5dcb4..120ffddc03d2 100644
>> --- a/include/linux/soundwire/sdw_intel.h
>> +++ b/include/linux/soundwire/sdw_intel.h
>> @@ -115,6 +115,7 @@ struct sdw_intel_slave_id {
>>    * links
>>    * @link_list: list to handle interrupts across all links
>>    * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
>> + * @shim_mask: flags to track initialization of SHIM shared registers
>>    */
>>   struct sdw_intel_ctx {
>>   	int count;
>> @@ -126,6 +127,7 @@ struct sdw_intel_ctx {
>>   	struct sdw_intel_slave_id *ids;
>>   	struct list_head link_list;
>>   	struct mutex shim_lock; /* lock for access to shared SHIM registers */
>> +	u32 shim_mask;
> 
> And a integer, question: why do you need pointer and integer, why not
> use only one..?

You may have missed that the structures are different.

the sdw_intel_ctx is global for all links, so that the shim_mask integer 
value.
the sdw_intel_link_res is link-specific and use a pointer to the same 
shim_mask value, protected by shim_lock.






Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5784C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08620777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCTSSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:18:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:6726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCTSSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:18:01 -0400
IronPort-SDR: RG2d+qlaxf6aRrOmPL5RwICBjp+2zw7ctyvHme+pGOe6j9ltTBDwTtchFB4QFVpJS7/U+pSYqR
 BbkbAF+Vvd3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 11:18:00 -0700
IronPort-SDR: 60736Tivxkr00AO1Q8sv87clYrGQ565iZ/n1qn3PCCOTxxkhk/5j16AJsFYlz18g1uiouX9+8j
 b9NRogoM4O5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392230378"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12]) ([10.255.34.12])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:17:58 -0700
Subject: Re: [PATCH 5/7] soundwire: intel: follow documentation sequences for
 SHIM registers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Rander Wang <rander.wang@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-6-pierre-louis.bossart@linux.intel.com>
 <20200320135145.GE4885@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9e280e1b-178a-0ce8-be5b-03532c5507fe@linux.intel.com>
Date:   Fri, 20 Mar 2020 09:20:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320135145.GE4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 8:51 AM, Vinod Koul wrote:
> On 11-03-20, 17:10, Pierre-Louis Bossart wrote:
>> From: Rander Wang <rander.wang@intel.com>
>>
>> Somehow the existing code is not aligned with the steps described in
>> the documentation, refactor code and make sure the register
> 
> Is the documentation available public space so that we can correct

No, so you'll have to trust us blindly on this one.


>> @@ -283,11 +284,48 @@ static int intel_link_power_up(struct sdw_intel *sdw)
>>   {
>>   	unsigned int link_id = sdw->instance;
>>   	void __iomem *shim = sdw->link_res->shim;
>> +	u32 *shim_mask = sdw->link_res->shim_mask;
> 
> this is a local pointer, so the one defined previously is not used.

No idea what you are saying, it's the same address so changes to 
*shim_mask will be the same as in *sdw->link_res->shim_mask.

> 
>> +	struct sdw_bus *bus = &sdw->cdns.bus;
>> +	struct sdw_master_prop *prop = &bus->prop;
>>   	int spa_mask, cpa_mask;
>> -	int link_control, ret;
>> +	int link_control;
>> +	int ret = 0;
>> +	u32 syncprd;
>> +	u32 sync_reg;
>>   
>>   	mutex_lock(sdw->link_res->shim_lock);
>>   
>> +	/*
>> +	 * The hardware relies on an internal counter,
>> +	 * typically 4kHz, to generate the SoundWire SSP -
>> +	 * which defines a 'safe' synchronization point
>> +	 * between commands and audio transport and allows for
>> +	 * multi link synchronization. The SYNCPRD value is
>> +	 * only dependent on the oscillator clock provided to
>> +	 * the IP, so adjust based on _DSD properties reported
>> +	 * in DSDT tables. The values reported are based on
>> +	 * either 24MHz (CNL/CML) or 38.4 MHz (ICL/TGL+).
> 
> Sorry this looks quite bad to read, we have 80 chars, so please use
> like below:
> 
> 	/*
>           * The hardware relies on an internal counter, typically 4kHz,
>           * to generate the SoundWire SSP - which defines a 'safe'
>           * synchronization point between commands and audio transport
>           * and allows for multi link synchronization. The SYNCPRD value
>           * is only dependent on the oscillator clock provided to
>           * the IP, so adjust based on _DSD properties reported in DSDT
>           * tables. The values reported are based on either 24MHz
>           * (CNL/CML) or 38.4 MHz (ICL/TGL+).
> 	 */

Are we really going to have an emacs vs vi discussion here?

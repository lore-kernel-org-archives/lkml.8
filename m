Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC77CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50754206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgELRBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:01:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:41681 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELRBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:01:08 -0400
IronPort-SDR: YQWIaLTDdyz+jnwOs9Uek989OA9YKuqgHxhym/a/tR7sjgJ0sMYFhVcss6UHwNIJbt2FbbYYvV
 i9y64EqtAmcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 10:01:07 -0700
IronPort-SDR: Db+r0AcSc4+ThFSgLvogNxTh85ziDyrWydS9TnmqFaUWvjWYYVYlI8AICp5miq0ISGU+OqX1/u
 /dUoFeYTtoWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="297371105"
Received: from bbian-mobl3.amr.corp.intel.com (HELO [10.254.96.32]) ([10.254.96.32])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2020 10:01:05 -0700
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
 <e214d308-1b92-a7a5-3c76-da05dca99cc5@linux.intel.com>
 <20200512033035.GV1375924@vkoul-mobl>
 <84f09843-3245-5fa4-530f-c915b28e9bc5@linux.intel.com>
 <20200512155927.GA4297@vkoul-mobl>
 <79ee2b4a-c2e3-aba7-8b67-b1a01922d089@linux.intel.com>
Message-ID: <86d45af8-93db-d284-64d4-efa22ccc0908@linux.intel.com>
Date:   Tue, 12 May 2020 12:01:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <79ee2b4a-c2e3-aba7-8b67-b1a01922d089@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/20 11:08 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 5/12/20 10:59 AM, Vinod Koul wrote:
>> On 12-05-20, 09:36, Pierre-Louis Bossart wrote:
>>> On 5/11/20 10:30 PM, Vinod Koul wrote:
>>>> On 11-05-20, 14:00, Pierre-Louis Bossart wrote:
>>>>>>> +    md = &bus->md;
>>>>>>> +    md->dev.bus = &sdw_bus_type;
>>>>>>> +    md->dev.type = &sdw_master_type;
>>>>>>> +    md->dev.parent = parent;
>>>>>>> +    md->dev.of_node = parent->of_node;
>>>>>>> +    md->dev.fwnode = fwnode;
>>>>>>> +    md->dev.dma_mask = parent->dma_mask;
>>>>>>> +
>>>>>>> +    dev_set_name(&md->dev, "sdw-master-%d", bus->link_id);
>>>>>>
>>>>>> This give nice sdw-master-0. In DT this comes from reg property. I 
>>>>>> dont
>>>>>> seem to recall if the ACPI/Disco spec treats link_id as unique across
>>>>>> the system, can you check that please, if not we would need to update
>>>>>> this.
>>>>> Table 3 in the Disco for Soundwire 1.0 spec: "all LinkID values are 
>>>>> relative
>>>>> to the immediate parent Device."
>>>>>
>>>>> There isn't any known implementation with more than one controller.
>>>>
>>>> But then it can come in "future" right. So lets try to make it future
>>>> proof by not using the link_id (we can expose that as a sysfs if people
>>>> want to know). So a global unique id needs to allocated (hint: idr or
>>>> equivalent) and used as master_id
>>>
>>> Can you clarify if you are asking for a global ID for Intel/ACPI 
>>> platforms,
>>> or for DT as well? I can't figure out from the soundwire-controller.yaml
>>> definitions if there is already a notion of unique ID.
>>
>> If ACPI was unique, then I was planning to update the definition below
>> to include that. Given that it is not the case, let's make it agnostic to
>> underlying firmware.
> 
> I am not sure I understand how this would be done.
> 
> The call sequence is
> 
> sdw_bus_master_add(bus)
>      sdw_master_device_add(bus, parent, fw_node)
> 
> At the bus level, we don't have any information on which controller the 
> bus is related to.
> 
> We'd need to add an argument to sdw_bus_master_add() and have the 
> controller unique ID be allocated outside of the SoundWire core, hence 
> my question on whether the DT definition should not be extended.

And btw I don't think it makes sense to add a new definition for Intel. 
We already have a notion of HDaudio bus->idx that's set to zero since we 
don't have a case for multiple HDaudio controllers.

if we ever do have more than once controller, then we should rely on 
HDaudio bus->idx as the identifier and not create one specifically for 
SoundWire - which means as I mentioned above passing an argument and not 
defining a controller ID in the SoundWire core.

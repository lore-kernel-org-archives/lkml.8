Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECABC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F130D2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGOOWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:22:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:27565 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgGOOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:22:34 -0400
IronPort-SDR: qhl1A9ke0D2uwj8Iup3cMrkOU/yIzW2ch506eHNya3L6vIuZLNcYfirnsBEHMrIzhYCRUzmNP5
 +yB2ZVFNooBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="136608590"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="136608590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 07:22:33 -0700
IronPort-SDR: 80v3gF12OrUgc3oIBjWlwM2wEEYcTwJALfOy+mW5YqBibu2SxXytSH25abnfa12TbAfIiwqCna
 9SiWcSQ/Gm+Q==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="460106447"
Received: from sjeong-mobl.amr.corp.intel.com (HELO [10.255.231.101]) ([10.255.231.101])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 07:22:32 -0700
Subject: Re: [PATCH 8/9] soundwire: intel: add wake interrupt support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
 <20200623173546.21870-9-yung-chuan.liao@linux.intel.com>
 <20200630165126.GT2599@vkoul-mobl>
 <a69aa5d0-613a-6ef6-9263-378b1e99770a@linux.intel.com>
 <20200701055654.GW2599@vkoul-mobl>
 <81a33798-0667-9a4f-9916-eb157ad5514d@linux.intel.com>
 <20200715045011.GO34333@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2832a0d0-dd19-9532-2c6e-814b796b4e20@linux.intel.com>
Date:   Wed, 15 Jul 2020 09:22:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715045011.GO34333@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/20 11:50 PM, Vinod Koul wrote:
> On 01-07-20, 10:25, Pierre-Louis Bossart wrote:
>>
>>>>>> +	 * wake up master and slave so that slave can notify master
>>>>>> +	 * the wakeen event and let codec driver check codec status
>>>>>> +	 */
>>>>>> +	list_for_each_entry(slave, &bus->slaves, node) {
>>>>>> +		/*
>>>>>> +		 * discard devices that are defined in ACPI tables but
>>>>>> +		 * not physically present and devices that cannot
>>>>>> +		 * generate wakes
>>>>>> +		 */
>>>>>> +		if (slave->dev_num_sticky && slave->prop.wake_capable)
>>>>>> +			pm_request_resume(&slave->dev);
>>>>>
>>>>> Hmmm, shouldn't slave do this? would it not make sense to notify the
>>>>> slave thru callback and then slave decides to resume or not..?
>>>>
>>>> In this mode, the bus is clock-stop mode, and events are detected with level
>>>> detector tied to PCI events. The master and slave devices are all in
>>>> pm_runtime suspended states. The codec cannot make any decisions on its own
>>>> since the bus is stopped, it needs to first resume, which assumes that the
>>>> master resumes first and the enumeration re-done before it can access any of
>>>> its registers.
>>>>
>>>> By looping through the list of devices that can generate events, you end-up
>>>> first forcing the master to resume, and then each slave resumes and can
>>>> check who generated the event and what happened while suspended. if the
>>>> codec didn't generate the event it will go back to suspended mode after the
>>>> usual timeout.
>>>>
>>>> We can add a callback but that callback would only be used for Intel
>>>> solutions, but internally it would only do a pm_request_resume() since the
>>>> codec cannot make any decisions before first resuming. In other words, it
>>>> would be an Intel-specific callback that is implemented using generic resume
>>>> operations. It's probably better to keep this in Intel-specific code, no?
>>>
>>> I do not like the idea that a device would be woken up, that kind of
>>> defeats the whole idea behind the runtime pm. Waking up a device to
>>> check the events is a generic sdw concept, I don't see that as Intel
>>> specific one.
>>
>> In this case, this in an Intel-specific mode that's beyond what MIPI
>> defined. This is not the traditional in-band SoundWire wake defined in the
>> SoundWire specification. The bus is completely down, the master IP is
>> powered-off and all context lost. There is still the ability for a Slave
>> device to throw a wake as defined by MIPI in clock-stop-mode1, but this is
>> handled with a separate level detector and the wake detection is handled by
>> the PCI subsystem. On a wake, the master IP needs to be powered-up, the
>> entire bus needs to be restarted and the Slave devices re-enumerated.
> 
> Right and I would expect that Slave device would do runtime_get_sync()
> first thing in the callback. That would ensure that the Master is
> powered up, Slave is powered up, all enumeration is complete. This is
> more standard way to deal with this, we expect devices to be so we
> low powered or off so cannot do read/write unless we resume.

As shared privately with you, we don't need to deal with device PM or 
add a callback, it's enough to resume the master, which will indirectly 
restart the bus and result in devices being resumed when they report 
their interrupt status. We'll share the update from [1] in the v2.

[1] https://github.com/thesofproject/linux/pull/2247


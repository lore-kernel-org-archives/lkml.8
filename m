Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47854C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DFA20771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgGAQwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:52:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:64226 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732497AbgGAQw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:52:28 -0400
IronPort-SDR: fs9bGL6a//xrClxslbSTvxcBQNNwRejdLyRd1CZzQb0SjHPD++LsHkPxzurkKyzL4FxHUHXnv7
 sFf5qAQGYFng==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144812976"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="144812976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:52:26 -0700
IronPort-SDR: yvrYmqKRmgb3daAF8TA4Yd1Pyh0ktR/XLawZUDQRuasQUP5ETGvw2mwW/Op5/gk3LlUuo1VtIg
 uL7Fxozk2f4w==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="455168903"
Received: from dsapozni-mobl1.amr.corp.intel.com (HELO [10.251.16.243]) ([10.251.16.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:52:25 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <81a33798-0667-9a4f-9916-eb157ad5514d@linux.intel.com>
Date:   Wed, 1 Jul 2020 10:25:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701055654.GW2599@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +	 * wake up master and slave so that slave can notify master
>>>> +	 * the wakeen event and let codec driver check codec status
>>>> +	 */
>>>> +	list_for_each_entry(slave, &bus->slaves, node) {
>>>> +		/*
>>>> +		 * discard devices that are defined in ACPI tables but
>>>> +		 * not physically present and devices that cannot
>>>> +		 * generate wakes
>>>> +		 */
>>>> +		if (slave->dev_num_sticky && slave->prop.wake_capable)
>>>> +			pm_request_resume(&slave->dev);
>>>
>>> Hmmm, shouldn't slave do this? would it not make sense to notify the
>>> slave thru callback and then slave decides to resume or not..?
>>
>> In this mode, the bus is clock-stop mode, and events are detected with level
>> detector tied to PCI events. The master and slave devices are all in
>> pm_runtime suspended states. The codec cannot make any decisions on its own
>> since the bus is stopped, it needs to first resume, which assumes that the
>> master resumes first and the enumeration re-done before it can access any of
>> its registers.
>>
>> By looping through the list of devices that can generate events, you end-up
>> first forcing the master to resume, and then each slave resumes and can
>> check who generated the event and what happened while suspended. if the
>> codec didn't generate the event it will go back to suspended mode after the
>> usual timeout.
>>
>> We can add a callback but that callback would only be used for Intel
>> solutions, but internally it would only do a pm_request_resume() since the
>> codec cannot make any decisions before first resuming. In other words, it
>> would be an Intel-specific callback that is implemented using generic resume
>> operations. It's probably better to keep this in Intel-specific code, no?
> 
> I do not like the idea that a device would be woken up, that kind of
> defeats the whole idea behind the runtime pm. Waking up a device to
> check the events is a generic sdw concept, I don't see that as Intel
> specific one.

In this case, this in an Intel-specific mode that's beyond what MIPI 
defined. This is not the traditional in-band SoundWire wake defined in 
the SoundWire specification. The bus is completely down, the master IP 
is powered-off and all context lost. There is still the ability for a 
Slave device to throw a wake as defined by MIPI in clock-stop-mode1, but 
this is handled with a separate level detector and the wake detection is 
handled by the PCI subsystem. On a wake, the master IP needs to be 
powered-up, the entire bus needs to be restarted and the Slave devices 
re-enumerated.

We trigger that sequence with a loop that calls pm_request_resume() for 
all Slave devices that are present and exposed in their properties that 
they are wake-capable. As you rightly said in your comments, this will 
result a nice wake-up handled by the pm_runtime framework in the right 
sequence (DSP first, then SoundWire master then Slave devices).

You will see in follow-up patches that the master IP can be configured 
in different clock stop modes, depending on the needs (power/latency 
compromise typically). When the more traditional SoundWire wake is used, 
we do not use this sequence at all.

> I would like to see a generic callback for the devices and let devices
> do the resume part, that is standard operating principle when we deal
> with suspended devices. If the device thinks they need to resume, they
> will do the runtime resume, check the status and sleep if not
> applicable. Since we have set the parents correctly, any resume
> operation for slaves would wake master up as well...
> 
> I do not see a need for intel driver to resume slave devices here, or
> did I miss something?

Yes, the part "If the device thinks they need to resume" is not quite 
right. The Slave device cannot access its registers before fully 
resuming, which in this case means a re-enumeration, so cannot "think" 
or make a decision on its own. That's the reason why we force them to 
resume, since it's the first step they would need to do anyways, and 
then if they don't have anything to do they go back to idle after a 
timeout. I invite you to see the suspend/resume sequences in codec 
drivers where you will see regmap access moves to cache-only on suspend 
and full access restored on resume, along with a hardware sync.

I see your point and I really think we are talking about a similar 
sequence, but we simplified your idea since there's no possibility of 
making a decision before Slave devices resume.

The only optimization we did here is that we only resume Slave devices 
than can generate a wake, and filter out the 'ghost' devices that are 
described in ACPI tables but don't physically exist.

Does this help?



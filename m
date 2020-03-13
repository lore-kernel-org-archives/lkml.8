Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76279C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5366320409
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCMR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:29:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:24214 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMR3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:29:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 10:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="237017256"
Received: from sblancoa-mobl.amr.corp.intel.com (HELO [10.251.232.239]) ([10.251.232.239])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2020 10:28:49 -0700
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200303054136.GP4148@vkoul-mobl>
 <8a04eda6-cbcf-582f-c229-5d6e4557344b@linux.intel.com>
 <20200304095312.GT4148@vkoul-mobl>
 <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
 <20200305063646.GW4148@vkoul-mobl>
 <eb30ac49-788f-b856-6fcf-84ae580eb3c8@linux.intel.com>
 <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
 <20200313115011.GD4885@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
Date:   Fri, 13 Mar 2020 11:54:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313115011.GD4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> the ASoC layer does require a driver with a 'name' for the components
>>>> registered with the master device. So if you don't have a driver for the
>>>> master device, the DAIs will be associated with the PCI device.
>>>>
>>>> But the ASoC core does make pm_runtime calls on its own,
>>>>
>>>> soc_pcm_open(struct snd_pcm_substream *substream)
>>>> {
>>>> ...
>>>> 	for_each_rtd_components(rtd, i, component)
>>>> 		pm_runtime_get_sync(component->dev);
>>>>
>>>> and if the device that's associated with the DAI is the PCI device, then
>>>> that will not result in the relevant master IP being activated, only the PCI
>>>> device refcount will be increased - meaning there is no hook that would tell
>>>> the PCI layer to turn on a specific link.
>>>>
>>>> What you are recommending would be an all-or-nothing solution with all links
>>>> on or all links off, which beats the purpose of having independent
>>>> link-level power management.
>>>
>>> Why can't you use dai .startup callback for this?
>>>
>>> The ASoC core will do pm_runtime calls that will ensure PCI device is
>>> up, DSP firmware downloaded and running.
>>>
>>> You can use .startup() to turn on your link and .shutdown to turn off
>>> the link.
>>
>> There are multiple dais per link, and multiple Slave per link, so we would
>> have to refcount and track active dais to understand when the link needs to
>> be turned on/off. It's a duplication of what the pm framework can do at the
>> device/link level, and will likely introduce race conditions.
>>
>> Not to mention that we'd need to introduce workqueues to turn the link off
>> with a delay, with pm_runtime_put_autosuspend() does for free.
> 
> Yes sure, that seems to be the cost unfortunately. While it might feel I
> am blocking but the real block here is the hw design which gives you a
> monolith whereas it should have been different devices. If you have a
> 'device' for sdw or a standalone controller we would not be debating
> this..

The hardware is what it is. The ACPI spec is what it is.

I am just pragmatic and making platforms work with that's available 
*today*, and I don't have time or interest in revisiting what might have 
been.

>> Linux is all about frameworks. For power management, we shall use the power
>> management framework, not reinvent it.
> 
> This reminds me, please talk to Mika and Rafael, they had similar
> problems with lpss etc and IIRC they were working on splices to solve
> this.. Its been some time (few years now) so maybe they have a
> solution..

We've been discussing this since October, I don't really have any 
appetite for looking into new concepts when the existing framework just 
does what we need.

It's really down to your objection to the use of 'struct driver'... For 
ASoC support we only need the .name and .pm_ops, so there's really no 
possible path forward otherwise.

Like I said, we have 3 options

a) stay with platform devices for now. You will need to have a 
conversation with Greg on this.

b) use a minimal sdw_master_device with a minimal 'struct driver' use.

c) use a more elaborate solution suggested in this patchset and yes that 
means the Qualcomm driver would need to change a bit.

Pick one or suggest something that is implementable. The first version 
of the patches was provided in October, the last RFC was provided on 
January 31, time's up. At the moment you are preventing ASoC integration 
from moving forward.

Thanks
-Pierre

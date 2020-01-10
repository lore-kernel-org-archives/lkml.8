Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C44320673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAJQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:08:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:30930 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbgAJQIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:08:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 08:08:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="224235858"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164]) ([10.251.145.164])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:08:52 -0800
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
 <20191227090826.GM3006@vkoul-mobl>
 <5be4d9df-0f46-d36f-471c-aae9e1f55cc0@linux.intel.com>
 <20200106054221.GN2818@vkoul-mobl>
 <32ae46a7-59ee-4815-270a-a519ff462345@linux.intel.com>
 <20200110064303.GX2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <39000dd7-3f77-bc33-0ad3-aa47ba2360f7@linux.intel.com>
Date:   Fri, 10 Jan 2020 10:08:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110064303.GX2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> The "big" difference is that probe is called by core (asoc) and not by
>>> driver onto themselves.. IMO that needs to go away.
>>
>> What I did is not different from what existed already with platform devices.
>> They were manually created, weren't they?
> 
> Manual creation of device based on a requirement is different, did I ask
> you why you are creating device :)
> 
> I am simple asking you not to call probe in the driver. If you need
> that, move it to core! We do not want these kind of things in the
> drivers...

What core are you talking about?

The SOF intel driver needs to create a device, which will then be bound 
with a SoundWire master driver.

What I am doing is no different from what your team did with 
platform_register_device, I am really lost on what you are asking.


>>>> FWIW, the implementation here follows what was suggested for Greybus 'Host
>>>> Devices' [1] [2], so it's not like I am creating any sort of dangerous
>>>> precedent.
>>>>
>>>> [1]
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/greybus/es2.c#L1275
>>>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/greybus/hd.c#L124
>>>
>>> And if you look closely all this work is done by core not by drivers!
>>> Drivers _should_ never do all this, it is the job of core to do that for
>>> you.
>>
>> Please look at the code again, you have a USB probe that will manually call
>> the GreyBus device creation.
>>
>> static int ap_probe(struct usb_interface *interface,
>> 		    const struct usb_device_id *id)
>> {
>> 	hd = gb_hd_create(&es2_driver, &udev->dev, 	
>>
>>
>> static struct usb_driver es2_ap_driver = {
>> 	.name =		"es2_ap_driver",
>> 	.probe =	ap_probe, <<< code above
>> 	.disconnect =	ap_disconnect,
>> 	.id_table =	id_table,
>> 	.soft_unbind =	1,
>> };
> 
> Look closely the driver es2 calls into greybus core hd.c and gets the
> work done, subtle but a big differances in the approaches..

I am sorry, I have absolutely no idea what you are referring to.

The code I copy/pasted here makes no call to the greybus core, it's 
ap_probe -> gb_hd_create. No core involved. If I am mistaken, please 
show me what I got wrong.


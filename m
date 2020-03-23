Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47CC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF6420787
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0+1VVVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgCWLGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:06:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgCWLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:06:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so16508697wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Er8BkFvrkbutAIsxZ2qgsGDlEnEu7wRCnc9YCCFbbUc=;
        b=X0+1VVVMtV2hIegOag7zAPIk8/+C8rPhAgxFufcXS7+NMtf/lxcFpKfW7BZKk++De9
         gHWudTy6UFihNkvnw7wDLwuAxko0QUCwWDcoCdPbxpwMjgGCd2E764AYEIKIe5Do97s8
         9MiN2jX8BhoIqbBraxVaXoVZVYf+ejVbhv4hKeqhu7n5H7VKkIDmupwW+Q2QYAdlm1fz
         /tdGSA496wBJab+1T0+zYqtfMtbMyfcUyJmlG8gwNOCCJP/Aznhm81Avmn1YygDVjx7W
         hapU3tjsHKxRYQ6MV71L71Nd0OcFciVTLiOn+i2iIeM+KWbLjWExEx2JY2xjPoLvHDlg
         GEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Er8BkFvrkbutAIsxZ2qgsGDlEnEu7wRCnc9YCCFbbUc=;
        b=eckj3EyNsHPNW1U+7tgyw93HSRcqxrJWoCpXc6Ppmi9ocf1i4aD+5sgWqWh+Fe/O0k
         nGSMJlhZilaGVgo6mgqFnGNg88yUjRta1k12DHEY06B3Ik2eE8TTQfkOV9ajOoeUR3fd
         RXI1akz/KDQvk0QJbUKFmCbuKc54czF5Q2eOjijBf4hIWKnGHraXWtwkglmDCBcxBPX1
         5rCYVFwyMSrcnePu0IHqKbdarC3vBaNVk2jaXJYjd59oIG00T1i3EsvZErU/Pv9PJZxx
         B1lod8QddNPp10zRdZTGopNN60IvGQmEWs0WgGBV3fZkQ48rKu7XMsGQ3MlS7RY0a10D
         QElQ==
X-Gm-Message-State: ANhLgQ2jZd+1ROjGrCeLeTD5PD4VDgjSj54V37h1GCBLXFKFsUa3kfU+
        mdVtX8pmHQyuVs/75KzCGqRhQqy9ZF8=
X-Google-Smtp-Source: ADFU+vuyYane3dXBPxqNCHWzuraJqqQhIXW6GbtYUlNjab8YXXbUDUWBPwjYHZXpgEgCDDNc4sg6vQ==
X-Received: by 2002:adf:e650:: with SMTP id b16mr12659383wrn.328.1584961606042;
        Mon, 23 Mar 2020 04:06:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h26sm19401729wmb.19.2020.03.23.04.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 04:06:45 -0700 (PDT)
Subject: Re: [PATCH 1/5] soundwire: bus_type: add master_device/driver support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
 <20200320162947.17663-2-pierre-louis.bossart@linux.intel.com>
 <5d78f0f8-7418-e50e-6f0b-dd6988224744@linaro.org>
 <626a074b-06a9-01a0-334f-3aaed1f7ed76@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <286e7ae2-6677-1d92-5ae2-9250d3ff7a9d@linaro.org>
Date:   Mon, 23 Mar 2020 11:06:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <626a074b-06a9-01a0-334f-3aaed1f7ed76@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/2020 18:17, Pierre-Louis Bossart wrote:
> Thanks for the quick review Srinivas,
> 
>> This patch in general is missing device tree support for both matching 
>> and uevent so this will not clearly work for Qualcomm controller 
>> unless we do via platform bus, which does not sound right!
> 
> see other email, the platform bus is handled by a platform 
> device/driver. There was no intention to change that, it's by design 
> rather than an omission/error.

I understand this partly now!

This can be probably made better/clear by:
renaming sdw_master_device_add to sdw_master_alloc and do a 
device_initialize() as part of this function in subsequent call to 
sdw_add_bus_master() we can do a device_add(). Doing this way will avoid 
a bit of unnecessary call to device_unregister by the controller driver, 
tbh which is confusing.

If the intended call sequence for controller is this (by keeping the 
parent bus type intact):

sdw_master_alloc/sdw_master_device_add()
sdw_add_bus_master()

Then we should also remove sdw_unregister_master_driver() and 
module_sdw_master_driver() all together. Having them makes the reader 
think that they can use module_sdw_master_driver directly without any 
parent bus like platform bus in this case.


>>> +
>>> +/**
>>> + * sdw_master_device_startup() - startup hardware
>>> + * @md: Linux Soundwire master device
>>> + *
>>> + * This use of this function is optional. It is only needed if the
>>> + * hardware cannot be started during a driver probe, e.g. due to power
>>> + * rail dependencies. The implementation is platform-specific but the
>>> + * bus will typically go through a hardware-reset sequence and devices
>>> + * will be enumerated once they report as ATTACHED.
>>> + */
>>> +int sdw_master_device_startup(struct sdw_master_device *md)
>>> +{
>>> +    struct sdw_master_driver *mdrv;
>>> +    struct device *dev;
>>> +    int ret = 0;
>>> +
>>> +    if (IS_ERR_OR_NULL(md))
>>> +        return -EINVAL;
>>> +
>>> +    dev = &md->dev;
>>> +    mdrv = drv_to_sdw_master_driver(dev->driver);
>>> +
>>> +    if (mdrv && mdrv->startup)
>>> +        ret = mdrv->startup(md);
>>> +
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdw_master_device_startup);
>>
>> Who would call this function? and How would it get hold of master 
>> device instance ?
> 
> sdw_master_device_add() returns a struct_master_device *md, so the 
> parent has a handle to that device. See the device creation here:
> 
> https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L238 
> 
> 
> This startup() would be called by the parent when all 
> requirements/dependencies are met. Put differently, it allows the probe 
> to run much earlier and check for platform firmware information (which 
> links are enabled, what devices are exposed by platform firmware), while 
> the startup is really when the bus clk/data lines will start toggling.

Why would this even need to be in the SoundWire core layer, if parent 
can call its local startup function whenever its necessary?
Unless we have some kinda state-machine in the core which can really 
deal with this, i see no point in this callback.


--srini

> 
> https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L341 
> 
> 
> and the call from the SOF layer is here:
> 
> https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/sound/soc/sof/intel/hda-loader.c#L418 
> 
> 
> Again, if everything is ready at probe time there's no need to delay the 
> actual bus startup. This is not needed for Qualcomm platforms where the 
> Master device is part of a codec. It's actually irrelevant since there 
> is no driver, so the startup callback does not even exist :-)
> 
>> How would soundwire core also ensure that we do not actively use this 
>> master if it is not ready. Similar comment for shutdown callback.
> 
> That's a fair point, we could add a state variable and a check that the 
> probe happened before.
> 
> In practice the two cases of device creation and startup are different 
> phases so it'd more of a paranoia check.
> 
> Thanks,
> -Pierre

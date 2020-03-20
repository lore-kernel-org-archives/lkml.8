Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B1C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88A520777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCTSSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:18:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:6726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgCTSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:18:08 -0400
IronPort-SDR: xneJKLRiolunKGCh5rkyLx9Te8fwvr34DXjUQEknJ/K+05PAwAcBpWZW/scKI6mhMfqJ0sL00W
 pOHEVOVV5R5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 11:18:07 -0700
IronPort-SDR: VtCyRH7bjNAmArGFncj1B8AoQW96uMjhZVPrMEmv3GkjXZDFJReGQSZT0Z7J+YUtWfU0Ks9LNs
 4duYCbg0jIIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392230443"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12]) ([10.255.34.12])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:18:05 -0700
Subject: Re: [PATCH 1/5] soundwire: bus_type: add master_device/driver support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <626a074b-06a9-01a0-334f-3aaed1f7ed76@linux.intel.com>
Date:   Fri, 20 Mar 2020 13:17:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5d78f0f8-7418-e50e-6f0b-dd6988224744@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick review Srinivas,

> This patch in general is missing device tree support for both matching 
> and uevent so this will not clearly work for Qualcomm controller unless 
> we do via platform bus, which does not sound right!

see other email, the platform bus is handled by a platform 
device/driver. There was no intention to change that, it's by design 
rather than an omission/error.
>> +
>> +/**
>> + * sdw_master_device_startup() - startup hardware
>> + * @md: Linux Soundwire master device
>> + *
>> + * This use of this function is optional. It is only needed if the
>> + * hardware cannot be started during a driver probe, e.g. due to power
>> + * rail dependencies. The implementation is platform-specific but the
>> + * bus will typically go through a hardware-reset sequence and devices
>> + * will be enumerated once they report as ATTACHED.
>> + */
>> +int sdw_master_device_startup(struct sdw_master_device *md)
>> +{
>> +    struct sdw_master_driver *mdrv;
>> +    struct device *dev;
>> +    int ret = 0;
>> +
>> +    if (IS_ERR_OR_NULL(md))
>> +        return -EINVAL;
>> +
>> +    dev = &md->dev;
>> +    mdrv = drv_to_sdw_master_driver(dev->driver);
>> +
>> +    if (mdrv && mdrv->startup)
>> +        ret = mdrv->startup(md);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(sdw_master_device_startup);
> 
> Who would call this function? and How would it get hold of master device 
> instance ?

sdw_master_device_add() returns a struct_master_device *md, so the 
parent has a handle to that device. See the device creation here:

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L238

This startup() would be called by the parent when all 
requirements/dependencies are met. Put differently, it allows the probe 
to run much earlier and check for platform firmware information (which 
links are enabled, what devices are exposed by platform firmware), while 
the startup is really when the bus clk/data lines will start toggling.

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/drivers/soundwire/intel_init.c#L341

and the call from the SOF layer is here:

https://github.com/thesofproject/linux/blob/9c7487b33072040ab755d32ca173b75151c0160c/sound/soc/sof/intel/hda-loader.c#L418

Again, if everything is ready at probe time there's no need to delay the 
actual bus startup. This is not needed for Qualcomm platforms where the 
Master device is part of a codec. It's actually irrelevant since there 
is no driver, so the startup callback does not even exist :-)

> How would soundwire core also ensure that we do not actively use this 
> master if it is not ready. Similar comment for shutdown callback.

That's a fair point, we could add a state variable and a check that the 
probe happened before.

In practice the two cases of device creation and startup are different 
phases so it'd more of a paranoia check.

Thanks,
-Pierre

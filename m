Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A2C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C35624672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgANRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:48:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:37596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:48:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 09:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="225285555"
Received: from snathamg-mobl.amr.corp.intel.com (HELO [10.252.136.159]) ([10.252.136.159])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 09:48:20 -0800
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200114060959.GA2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6635bf0b-c20a-7561-bcbf-4a480a077ae4@linux.intel.com>
Date:   Tue, 14 Jan 2020 10:01:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114060959.GA2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I am quoting the code in patch, which i pointed in my first reply!
> 
> On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> 
>> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
>> index 4b769409f6f8..42f7ae034bea 100644
>> --- a/drivers/soundwire/intel_init.c
> 
> This is intel specific file...
> 
>> +++ b/drivers/soundwire/intel_init.c
> 
> snip ...
> 
>> +static struct sdw_intel_ctx
>> +*sdw_intel_probe_controller(struct sdw_intel_res *res)
> 
> this is intel driver, intel function!
> 
>> -
>> -		link->pdev = pdev;
>> -		link++;
>> +		/* let the SoundWire master driver to its probe */
>> +		md->driver->probe(md, link);
>                              ^^^^^^
> which does this... calls a probe()!
> 
> And my first reply was:
> 
>>> +             /* let the SoundWire master driver to its probe */
>>> +             md->driver->probe(md, link);
>>
>> So you are invoking driver probe here.. That is typically role of driver
>> core to do that.. If we need that, make driver core do that for you!
> 
> I rest my case!

I think you are too focused on the probe case and not realizing the 
extensions suggested by this patchset. A "driver" is not limited to 
'probe' and 'remove' cases.

As mentioned since mid-September, there is a need for an initialization 
of software/kernel structures (which I called probe but should have been 
called init really), and a second step where the hardware is actually 
configured - after all power rail dependencies are under control.

Can you please look at the .startup callback and let me know how a 
'driver core' would handle this?

To the best of my knowledge, there is no .startup in any device model 
functionality, so the only thing I could do to avoid a direct call is 
add a wrapper to avoid a direct call, e.g.

static inline sdw_master_device_startup(struct sdw_master_device *md)
{
     if (md && md->driver && md->driver->startup)
         md->driver->startup(md);
}



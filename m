Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C305C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FC206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbgF3R1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:27:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:3228 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390317AbgF3R07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:26:59 -0400
IronPort-SDR: Z49gx/cuGn+9GqJgWA1GrBNwaKk47bVqNPUNQq886ewPM3CkElcCVTGqdwJKQ/Ah8q5C3b1lXH
 CBYw6LKjHJsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="207832985"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="207832985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:26:58 -0700
IronPort-SDR: +/Du3clL+kH8j47dZMptzCZN9CWuzz08ZNLzFF6N/wHXdhzwOhFNUNkIIvEMqSe5Ny45BzUyyt
 pphR8thsCiPA==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="281307459"
Received: from dnoeunx-mobl.amr.corp.intel.com (HELO [10.254.77.113]) ([10.254.77.113])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:26:57 -0700
Subject: Re: [PATCH 2/5] soundwire: stream: add helper to startup/shutdown
 streams
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
 <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
 <20200630160349.GR2599@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5123471d-92f3-8f49-7a2c-d7b70bf442af@linux.intel.com>
Date:   Tue, 30 Jun 2020 11:58:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630160349.GR2599@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for the review.

>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -13,6 +13,9 @@
>>   #include <linux/slab.h>
>>   #include <linux/soundwire/sdw_registers.h>
>>   #include <linux/soundwire/sdw.h>
>> +#include <sound/core.h>
> 
> Do we really need core header?

No we don't, the only thing needed in sound/soc.h it seems.

>> +#include <sound/pcm.h>
>> +#include <sound/soc.h>
>>   #include "bus.h"
>>   
>>   /*
>> @@ -1826,3 +1829,90 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(sdw_deprepare_stream);
>> +
>> +static int set_stream(struct snd_pcm_substream *substream,
>> +		      struct sdw_stream_runtime *sdw_stream)
> 
> sdw_set_stream() please

it's an internal helper not exported, the choice of not adding a prefix 
was intentional to avoid confusion with exported ones.

>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_dai *dai;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	/* Set stream pointer on all DAIs */
>> +	for_each_rtd_dais(rtd, i, dai) {
>> +		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream,
>> +						 substream->stream);
>> +		if (ret < 0) {
>> +			dev_err(rtd->dev,
>> +				"failed to set stream pointer on dai %s",
>> +				dai->name);
> 
> lets use one line and shiny new 100 char limit, would make code read
> better!

yes

>> +			break;
> 
> So on error should unset of stream pointer be done?

it's already done below, see [1]

>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int sdw_startup_stream(void *sdw_substream)
> 
> Can we have kernel doc style Documentation for exported APIs?

yes, that's a miss indeed.

Though if we follow the existing examples it's not going to be very 
informative, e.g.

/**
  * sdw_disable_stream() - Disable SoundWire stream
  *
  * @stream: Soundwire stream
  *
  * Documentation/driver-api/soundwire/stream.rst explains this API in 
detail
  */

>> +{
>> +	struct snd_pcm_substream *substream = sdw_substream;
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct sdw_stream_runtime *sdw_stream;
>> +	char *name;
>> +	int ret;
>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		name = kasprintf(GFP_KERNEL, "%s-Playback", substream->name);
>> +	else
>> +		name = kasprintf(GFP_KERNEL, "%s-Capture", substream->name);
>> +
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	sdw_stream = sdw_alloc_stream(name);
>> +	if (!sdw_stream) {
>> +		dev_err(rtd->dev, "alloc stream failed for substream DAI %s",
>> +			substream->name);
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +
>> +	ret = set_stream(substream, sdw_stream);
>> +	if (ret < 0)
>> +		goto release_stream;

[1]

>> +	return 0;
>> +
>> +release_stream:
>> +	sdw_release_stream(sdw_stream);
>> +	set_stream(substream, NULL);
>> +error:
>> +	kfree(name);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(sdw_startup_stream);

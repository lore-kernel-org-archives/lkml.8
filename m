Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D2CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7561921569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBLQDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:03:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:17620 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLQDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:03:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 08:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="313442343"
Received: from gmoralez-mobl.amr.corp.intel.com (HELO [10.252.135.232]) ([10.252.135.232])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2020 08:03:38 -0800
Subject: Re: [alsa-devel] [PATCH v2 5/5] soundwire: intel: free all resources
 on hw_free()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
 <20200114234257.14336-6-pierre-louis.bossart@linux.intel.com>
 <20200212101554.GB2618@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8219635-30be-9695-a3f5-cd649aa6fab7@linux.intel.com>
Date:   Wed, 12 Feb 2020 09:37:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212101554.GB2618@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

>> +static int intel_free_stream(struct sdw_intel *sdw,
>> +			     struct snd_pcm_substream *substream,
>> +			     struct snd_soc_dai *dai,
>> +			     int link_id)
>> +{
>> +	struct sdw_intel_link_res *res = sdw->link_res;
>> +	struct sdw_intel_stream_free_data free_data;
> 
> where is this struct sdw_intel_stream_free_data defined. I dont see it
> in this patch or this series..

the definition is already upstream :-)

It was added in December with

4b206d34b92224 ('soundwire: intel: update stream callbacks for 
hwparams/free stream operations')

>> -	return ret;
>> +	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
>> +	if (ret < 0) {
>> +		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	sdw_release_stream(dma->stream);
> 
> I think, free the 'name' here would be apt

Right, this is something we discussed with Rander shortly before Chinese 
New Year and we wanted to handle this with a follow-up patch, would that 
work for you? if not I can send a v3, your choice.

Thanks
-Pierre

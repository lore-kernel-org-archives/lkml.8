Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF93C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983352075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgH1PHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:07:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:57782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgH1PHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:07:42 -0400
IronPort-SDR: UDMcF1IBjSbeVvBlcSTVrP0XEhstyDZgsrRnJxbv68wp9UEYViKAH+Fi+PKi+zRd17AneCZWEO
 lSmgM+bvW2iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="241493878"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="241493878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:07:41 -0700
IronPort-SDR: 3221SinK08aDM3DBF4iZ1zeOb2Dw1HuzNYvFcqfiP5278XKel9wUEhTOKsl79dqCj69wLyapBb
 TRFE+iC8pR/w==
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300263904"
Received: from lilymao-mobl.amr.corp.intel.com (HELO [10.209.185.175]) ([10.209.185.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:07:39 -0700
Subject: Re: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for the
 first cpu_dai
To:     Vinod Koul <vkoul@kernel.org>, "Liao, Bard" <bard.liao@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
 <20200826094636.GB2639@vkoul-mobl>
 <DM6PR11MB407494AEF6D05EFF627CFAFBFF520@DM6PR11MB4074.namprd11.prod.outlook.com>
 <20200828074544.GM2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9eac0f85-1b0f-d2c2-6d1b-15b77707c9b7@linux.intel.com>
Date:   Fri, 28 Aug 2020 10:07:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828074544.GM2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/20 2:45 AM, Vinod Koul wrote:
> On 28-08-20, 01:47, Liao, Bard wrote:
>>> snd_pcm_substream *substream,
>>>>   			goto err;
>>>>   	}
>>>>
>>>> -	ret = sdw_prepare_stream(dma->stream);
>>>> +	/*
>>>> +	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
>>>> +	 * is called once per stream, we should call it only when
>>>> +	 * dai = first_cpu_dai.
>>>> +	 */
>>>> +	if (first_cpu_dai == dai)
>>>> +		ret = sdw_prepare_stream(dma->stream);
>>>
>>> Hmmm why not use the one place which is unique in the card to call this,
>>> hint machine dais are only called once.
>>
>> Yes, we can call it in machine driver. But, shouldn't it belong to platform
>> level? The point is that if we move the stuff to machine driver, it will
>> force people to implement these stuff on their own Intel machine driver.
> 
> nothing stops anyone from doing that right! machine driver is another
> component so it can be moved there as well

What Bard is saying is that there is nothing board-specific here. This 
is platform-driver code that is independent of the actual machine 
configuration.

Machine drivers can be board-specific, so we would have to add the code 
for prepare/deprepare/trigger to every machine driver.

Today it's true that we worked to have a single machine driver for all 
SoundWire-based devices, so the change is a 1:1 move, but we can't 
guarantee that this would be the case moving forward. In fact, we *know* 
we will need a different machine driver when we parse platform firmware 
to create the card for SDCA support. So in the end there would be 
duplication of code.

See the code we worked on at 
https://github.com/thesofproject/linux/commit/7322e1d25ce2ec9bb78c6e861919f61e0be7cc0b.patch

it'd really a bit silly to have this generic code in the machine driver.

it would be fine to call a set of helpers called from the machine driver 
dailink, but where would we put these helpers? on the ASoC or SoundWire 
sides?



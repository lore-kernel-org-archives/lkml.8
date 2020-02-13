Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BDEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA336218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBMPFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:05:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:51588 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgBMPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:05:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 07:05:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="227112418"
Received: from lmbraun-mobl.amr.corp.intel.com (HELO [10.255.84.93]) ([10.255.84.93])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2020 07:05:18 -0800
Subject: Re: [alsa-devel] [PATCH v2 5/5] soundwire: intel: free all resources
 on hw_free()
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
 <20200114234257.14336-6-pierre-louis.bossart@linux.intel.com>
 <20200212101554.GB2618@vkoul-mobl>
 <c8219635-30be-9695-a3f5-cd649aa6fab7@linux.intel.com>
 <20200213042344.GC2618@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7c84be84-1507-c132-abf5-d85fe96fe029@linux.intel.com>
Date:   Thu, 13 Feb 2020 09:05:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213042344.GC2618@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	sdw_release_stream(dma->stream);
>>>
>>> I think, free the 'name' here would be apt
>>
>> Right, this is something we discussed with Rander shortly before Chinese New
>> Year and we wanted to handle this with a follow-up patch, would that work
>> for you? if not I can send a v3, your choice.
> 
> It would be better if we fix this up in this series :)

ok, I will fix this later today.

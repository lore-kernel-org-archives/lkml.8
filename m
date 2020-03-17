Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ABCC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C3520735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCQMWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:22:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:63790 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgCQMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:22:50 -0400
IronPort-SDR: 5UABjp4m0z6dUNdnZJxVotbqVICCpjXQY4bOLrfzgazrmmvjli9DmT8KC3Vn8Y2BA423q9TJKV
 46WIzv+Fqjdw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 05:22:49 -0700
IronPort-SDR: XdqzQsl1uPlDaP+NqkKStWnVn0XxYradtpWoKzUMeBatCJSEp3HS/E4eXGhBOGb/rYDjgj2Sgc
 9Z8qsBE5mvrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="290978968"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO [10.255.35.148]) ([10.255.35.148])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Mar 2020 05:22:48 -0700
Subject: Re: [PATCH] soundwire: stream: only change state if needed
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
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
Date:   Tue, 17 Mar 2020 07:22:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

> This patch did not work for me as it is as wsa881x codec does prepare 
> and enable in one function, which breaks some of the assumptions in this 
> patch.

Ah yes, if two transitions happen in the same DAI callback that wouldn't 
work indeed. We should probably add this restriction to the state 
machine documentation, the suggested mapping from ASoC DAI states to 
stream states did not account for compound cases.

> However with below change I could get it working without moving stream 
> handling to machine driver.

The change below would be an error case for Intel, so it's probably 
better if we go with your suggestion. You have a very specific state 
handling due to your power amps and it's probably better to keep it 
platform-specific.

Can you confirm though that this patch works fine if you move all the 
stream transitions to the machine driver? That should be a no-op but 
better make sure there's no misunderstanding.

Thanks
-Pierre

> ---------------------------->cut<-------------------------------
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index be71af4671a4..4a94ea64c1c5 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1574,7 +1574,8 @@ int sdw_prepare_stream(struct sdw_stream_runtime 
> *stream)
> 
>          sdw_acquire_bus_lock(stream);
> 
> -       if (stream->state == SDW_STREAM_PREPARED) {
> +       if (stream->state == SDW_STREAM_PREPARED ||
> +           stream->state == SDW_STREAM_ENABLED) {
>                  /* nothing to do */
>                  ret = 0;
>                  goto state_err;
> @@ -1754,7 +1755,8 @@ int sdw_disable_stream(struct sdw_stream_runtime 
> *stream)
> 
>          sdw_acquire_bus_lock(stream);
> 
> -       if (stream->state == SDW_STREAM_DISABLED) {
> +       if (stream->state == SDW_STREAM_DISABLED ||
> +           stream->state == SDW_STREAM_DEPREPARED) {
>                  /* nothing to do */
>                  ret = 0;
>                  goto state_err;
> ---------------------------->cut<-------------------------------
> 
> --srini
> 
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index 1b43d03c79ea..3319121cd706 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -1572,6 +1572,7 @@ int sdw_prepare_stream(struct sdw_stream_runtime 
>> *stream)
>>       sdw_acquire_bus_lock(stream);
>>       if (stream->state == SDW_STREAM_PREPARED) {
>> +        /* nothing to do */
>>           ret = 0;
>>           goto state_err;
>>       }
>> @@ -1661,6 +1662,12 @@ int sdw_enable_stream(struct sdw_stream_runtime 
>> *stream)
>>       sdw_acquire_bus_lock(stream);
>> +    if (stream->state == SDW_STREAM_ENABLED) {
>> +        /* nothing to do */
>> +        ret = 0;
>> +        goto state_err;
>> +    }
>> +
>>       if (stream->state != SDW_STREAM_PREPARED &&
>>           stream->state != SDW_STREAM_DISABLED) {
>>           pr_err("%s: %s: inconsistent state state %d\n",
>> @@ -1744,6 +1751,12 @@ int sdw_disable_stream(struct 
>> sdw_stream_runtime *stream)
>>       sdw_acquire_bus_lock(stream);
>> +    if (stream->state == SDW_STREAM_DISABLED) {
>> +        /* nothing to do */
>> +        ret = 0;
>> +        goto state_err;
>> +    }
>> +
>>       if (stream->state != SDW_STREAM_ENABLED) {
>>           pr_err("%s: %s: inconsistent state state %d\n",
>>                  __func__, stream->name, stream->state);
>> @@ -1809,6 +1822,12 @@ int sdw_deprepare_stream(struct 
>> sdw_stream_runtime *stream)
>>       sdw_acquire_bus_lock(stream);
>> +    if (stream->state == SDW_STREAM_DEPREPARED) {
>> +        /* nothing to do */
>> +        ret = 0;
>> +        goto state_err;
>> +    }
>> +
>>       if (stream->state != SDW_STREAM_PREPARED &&
>>           stream->state != SDW_STREAM_DISABLED) {
>>           pr_err("%s: %s: inconsistent state state %d\n",
>>

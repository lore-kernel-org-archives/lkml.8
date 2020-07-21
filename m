Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFF520771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgGUXqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:46:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:44145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUXqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:46:03 -0400
IronPort-SDR: XB/U6r6bmZTLQRJGwF4MJVwGDoooqinCtF2whOJcqucGykxBcK8Iud9XLNqzZI1Q5RInInMHeE
 Dr8GWHV3HMJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129815365"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="129815365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:03 -0700
IronPort-SDR: iz40N4/yb9B5d6SJZ7L8QhpD0FXcHb8KUoqwc5Y4Vocc8cfpIZzsN8mQTjG3yVvkQzYTfkyk7z
 wqYdOdJ4zEDw==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="362539360"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6]) ([10.255.231.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:01 -0700
Subject: Re: [PATCH v2 2/9] ASoC: q6asm: make commands specific to streams
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
 <20200721165306.29082-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <52075b51-2053-573a-4cd0-685d3d469bdf@linux.intel.com>
Date:   Tue, 21 Jul 2020 14:31:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721165306.29082-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 941f3216399c..fb0488e7beb9 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -67,6 +67,8 @@ struct q6asm_dai_rtd {
>   	uint16_t bits_per_sample;
>   	uint16_t source; /* Encoding source bit mask */
>   	struct audio_client *audio_client;
> +	/* Active */

nit-pick: what does this 'Active' comment try to say? the stream_id 
seems to be used for RUN/EOS/CLOSE operations.

> +	uint32_t stream_id;
>   	uint16_t session_id;
>   	enum stream_state state;
>   };
> @@ -184,8 +186,8 @@ static void event_handler(uint32_t opcode, uint32_t token,
>   	switch (opcode) {
>   	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -			q6asm_write_async(prtd->audio_client,
> -				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +				   prtd->pcm_count, 0, 0, 0);

In the V1 review we discussed this

"
 > sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP    0xFF00
 >
 > is the change on the previous line intentional?

May be not!

Plan is that the users of these apis will send flags directly instead of 
boiler plating this!

This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: 
use flags directly from asm-dai") which would make it much clear!
"

doesn't look like there was a change here?



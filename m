Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01937C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A13206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgGUXqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:46:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:44150 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbgGUXqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:46:11 -0400
IronPort-SDR: QofjuauXwdeRD+lvoHRO6ObQNubHBJ++pcLx5uSlSjaxNGA8JnOdmoxYk7g8Qjye6fGtqdVUmz
 dUAWyJIpHmGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129815373"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="129815373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:11 -0700
IronPort-SDR: O+Zbmqj3QdWHOWpt1LnUKLcLzu7x9zcOB2XDaVewCuA3B352SntT5b+n2dzMbRz84RDYXShJYy
 g9EQedM6yeEw==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="362539392"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6]) ([10.255.231.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:10 -0700
Subject: Re: [RFC PATCH v2 6/6] ASoC: q6asm-dai: add support to
 set_codec_params
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <970e7065-4731-e553-f07f-896aaa57c5dc@linux.intel.com>
Date:   Tue, 21 Jul 2020 15:09:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
> Make use of new set_codec_params callback to allow decoder switching
> during gapless playback.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 33 ++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index b5c719682919..a8cfb1996614 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -876,6 +876,37 @@ static int __q6asm_dai_compr_set_codec_params(struct snd_soc_component *componen
>   	return 0;
>   }
>   
> +static int q6asm_dai_compr_set_codec_params(struct snd_soc_component *component,
> +					    struct snd_compr_stream *stream,
> +					    struct snd_codec *codec)
> +{
> +	struct snd_compr_runtime *runtime = stream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +	int ret;
> +
> +	ret = q6asm_open_write(prtd->audio_client, prtd->next_track_stream_id,
> +			       codec->id, codec->profile, prtd->bits_per_sample,
> +			       true);
> +	if (ret < 0) {
> +		pr_err("q6asm_open_write failed\n");
> +		return ret;
> +	}
> +
> +	ret = __q6asm_dai_compr_set_codec_params(component, stream, codec,
> +						 prtd->next_track_stream_id);
> +	if (ret < 0) {
> +		pr_err("q6asm_open_write failed\n");
> +		return ret;
> +	}
> +
> +	ret = q6asm_stream_remove_initial_silence(prtd->audio_client,
> +						   prtd->next_track_stream_id,
> +						   prtd->initial_samples_drop);
> +	prtd->next_track_stream_id = 0;

same comment as in the other patchset, the stream_id toggles between 1 
and 2, it's not clear to me what 0 means.

off-by-one bug or feature?

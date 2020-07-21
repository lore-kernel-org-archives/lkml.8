Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFC9206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgGUXqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:46:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:44145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbgGUXqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:46:10 -0400
IronPort-SDR: Ji/SN+dvMF3kjoT5Fpalzth5d4lgS78a/1bnzTE9nnqtqQBvTRd5w8NP2M6bYxUBfe2YjPr7lM
 pt3b9VLK5ZAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129815371"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="129815371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:09 -0700
IronPort-SDR: wc+uY8YHF6cpWC1QeyVMOkBN9R/+J1/fj5PVm9xD0XLfPMqH1FhcWst+5zBoliY0UJx0mTrZJ7
 dZW4AaGDOKMQ==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="362539385"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6]) ([10.255.231.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:08 -0700
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
Date:   Tue, 21 Jul 2020 15:05:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
> For gapless playback it is possible that each track can have different
> codec profile with same decoder, for example we have WMA album,
> we may have different tracks as WMA v9, WMA v10 and so on
> 
> Or if DSP's like QDSP have abililty to switch decoders on single stream

ability

> for each track, then this call could be used to set new codec parameters.
> 
> Existing code does not allow to change this profile while doing gapless
> playback.
> 
> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
> userspace to set this new parameters required for new codec profile.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../sound/designs/compress-offload.rst        |  6 ++++
>   include/sound/compress_driver.h               |  5 +++
>   include/uapi/sound/compress_offload.h         |  1 +
>   sound/core/compress_offload.c                 | 34 +++++++++++++++++++
>   4 files changed, 46 insertions(+)
> 
> diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> index 935f325dbc77..305ccc7bfdd9 100644
> --- a/Documentation/sound/designs/compress-offload.rst
> +++ b/Documentation/sound/designs/compress-offload.rst
> @@ -128,6 +128,12 @@ set_params
>     cases decoders will ignore other fields, while encoders will strictly
>     comply to the settings
>   
> +set_codec_params
> +  This routine is very much simillar to set_params but exculding stream

typos: similar, excluding

> +  information. Only codec related information is set as part of this.
> +  It is used in gapless playback where its required to change decoder
> +  or its parameters for next track. This is optional.
> +
>   get_params
>     This routines returns the actual settings used by the DSP. Changes to
>     the settings should remain the exception.
> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> index 70cbc5095e72..d9c00bcfce9b 100644
> --- a/include/sound/compress_driver.h
> +++ b/include/sound/compress_driver.h
> @@ -93,6 +93,9 @@ struct snd_compr_stream {
>    * @set_params: Sets the compressed stream parameters, mandatory
>    * This can be called in during stream creation only to set codec params
>    * and the stream properties
> + * @set_codec_params: Sets the compressed stream codec parameters, Optional
> + * This can be called in during gapless next track codec change only to set
> + * codec params

Would it be clearer if this was called set_next_codec_params()? or 
set_next_track_codec_params()?

Having set_params() and set_codec_params() is a bit confusing since the 
semantic difference is not captured in the callback name.


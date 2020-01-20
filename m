Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915FC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7881C207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Uo5RfD6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATGYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:24:36 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19908 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:24:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e2547950000>; Sun, 19 Jan 2020 22:24:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 19 Jan 2020 22:24:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 19 Jan 2020 22:24:35 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jan
 2020 06:24:33 +0000
Subject: Re: [PATCH] ASoC: rt5659: add S32_LE format
To:     <oder_chiou@realtek.com>, <tiwai@suse.com>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1579501059-27936-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <74a42452-f19c-1175-9928-da12ccad621d@nvidia.com>
Date:   Mon, 20 Jan 2020 11:54:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579501059-27936-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579501461; bh=OnCPnZ18bhGbUj+/reh1GSCR+rCNXuxYQcZqRDc01EU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Uo5RfD6pOFX74niOwMzdIl95ZiS3KibGo8gUB/AyRE27VCavZNn+eGcWbfIsPhVYN
         ItMplFTFeW3eLsHSdh7QYnovMMroGhgvE9qLCb7XNWNdEISQ8/qNux5FcDXoj1zlk4
         WhGkqsZBrH2xNULxH8KD3T6FTQ2TOIzy3wNwsU1IgtOi4aqSHqbMrjPUcqebN+s+rz
         kXyigzNORq96W+/XfgDPXkP0eg5vFzfbSTMCDh7naMRwaEAiLpbY0DVuIMLTSJPtth
         anENEwTTG31Yk+SA+QvPt9OvsoLQJkwGYl9zPA7SByl8X+p4aOOQnZk28JUM4sYAGa
         PjJLTqUMXlt8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing Bard(bardliao@realtek.com) from "to" list since I am getting 
undelivered message.

Oder,
Please add right folks as you feel necessary. Thanks.

On 1/20/2020 11:47 AM, Sameer Pujar wrote:
> ALC5659 supports maximum data length of 24-bit. Currently driver supports
> S24_LE which is a 32-bit container with valid data in [23:0] and 0s in MSB.
> S24_3LE is not commonly used and is hard to find audio streams with this
> format. Also many SoC HW do not support S24_LE and S32_LE is used in
> general. The 24-bit data can be represented in S32_LE [31:8] and 0s are
> padded in LSB.
>
> This patch adds S32_LE to ALC5659 driver and data length for this is set
> to 24 as per codec's maximum data length support. This helps to play
> 24-bit audio, packed in S32_LE, on HW which do not support S24_LE.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   sound/soc/codecs/rt5659.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
> index fc74dd63..f910ddf 100644
> --- a/sound/soc/codecs/rt5659.c
> +++ b/sound/soc/codecs/rt5659.c
> @@ -3339,6 +3339,7 @@ static int rt5659_hw_params(struct snd_pcm_substream *substream,
>   		val_len |= RT5659_I2S_DL_20;
>   		break;
>   	case 24:
> +	case 32:
>   		val_len |= RT5659_I2S_DL_24;
>   		break;
>   	case 8:
> @@ -3733,7 +3734,8 @@ static int rt5659_resume(struct snd_soc_component *component)
>   
>   #define RT5659_STEREO_RATES SNDRV_PCM_RATE_8000_192000
>   #define RT5659_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
> -		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
> +		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE | \
> +		SNDRV_PCM_FMTBIT_S8)
>   
>   static const struct snd_soc_dai_ops rt5659_aif_dai_ops = {
>   	.hw_params = rt5659_hw_params,

Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5308C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CC524673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XNAb6nBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWJzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:55:12 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15211 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgAWJzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:55:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e296d710000>; Thu, 23 Jan 2020 01:54:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 23 Jan 2020 01:55:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 23 Jan 2020 01:55:11 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jan
 2020 09:55:09 +0000
CC:     <spujar@nvidia.com>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
To:     <tiwai@suse.com>, <perex@perex.cz>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <32021032-6b3c-9056-d194-ce7902e5fcbf@nvidia.com>
Date:   Thu, 23 Jan 2020 15:25:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579773297; bh=L8ghlLd5KcxfJQc3HDcCUJatTjhdcq6Wmqdd0ONIYxo=;
        h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=XNAb6nBbKf5/i4gyAoNdzynBl+amoQPmeQjq+tnRLJ7mjUT9ew64H0CLFclgL8W8x
         n2M/vySLqN6SF5dBkmHqNFuoxXpCXfLavtZOKCo7yYjhRqlbzlPKwxNBuivEZgNLBv
         fvFGyPLeax2+JAdQ7ObYJGxIGJKWNG1/p+o9cz54D2VA0jVdscBBM6us7dhYrpvdAc
         6KYaqhbIBB6dUuIGi2ee45LByp6nIQdOysKYget5FF2y1q528DCFgnD4rJXWuHFPSY
         6cibZrDpE5BVb4LEI8GnAL2FotDFkIAaqJCF2JfDGQr5uUlLqygok4p3xyyvOPM0Yt
         Y9A968P000Fag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,
Request for comments if my understanding is right here. Thanks.

On 1/19/2020 7:49 PM, Sameer Pujar wrote:
> Crash happens in snd_soc_dapm_new_dai() when substream->private_data
> access is made and substream is NULL here. This is seen for DAIs where
> only playback or capture stream is defined. This seems to be happening
> for codec2codec DAI link.
>
> Both playback and capture are 0 during soc_new_pcm(). This is probably
> happening because cpu_dai and codec_dai are both validated either for
> SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE.
>
> Shouldn't be playback = 1 when,
>   - playback stream is available for codec_dai AND
>   - capture stream is available for cpu_dai
>
> and vice-versa for capture = 1?
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   sound/soc/soc-pcm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 74d340d..5aa9c0b 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2855,10 +2855,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>   
>   		for_each_rtd_codec_dai(rtd, i, codec_dai) {
>   			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
> -			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
> +			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
>   				playback = 1;
>   			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
> -			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
> +			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
>   				capture = 1;
>   		}
>   


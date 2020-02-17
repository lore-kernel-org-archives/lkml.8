Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E9C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE3820718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="BFXYKB4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBQOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:41:29 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:10124 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgBQOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581950487;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=cFRtptfsaUlKo1DNByJ5pB2rNEq/gwFCmQzD67nfBms=;
        b=BFXYKB4LTlfpoEfyGwFIJmh24xdbFHQHe/Wyc5vsVN/Pfnnpw1O5YLM1mVA+SdPHRW
        mWVgl4vEQKuDFW2V/65x3zVQu5QDDmd5wrQPsI8CBR5yUI583Ozd0fTPK0wGN36LUbQF
        pcgBPLu9ZlUPkZs/QrMpIGEV1fqeSlgmRHRQAnRf1GIbN9SufZreh2pCb40aCGY1lgG2
        SLj/XIwzS2MxavDlATdn7pRZzu1iScFJaxT1Do05XAhFoyZLx0Qqrx1k2/RgGxT3KiWy
        /5hHakGZMV66MO2/g5RYEmo8Z2477VHTih4kvUhULEDVcOlJbWEvIgBzaNHZFstu4Olw
        Llig==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJKBk/pyQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id a01fe9w1HEfPcdV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 17 Feb 2020 15:41:25 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:41:20 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
Message-ID: <20200217144120.GA243254@gerhold.net>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 07:49:23PM +0530, Sameer Pujar wrote:
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
>  - playback stream is available for codec_dai AND
>  - capture stream is available for cpu_dai
> 
> and vice-versa for capture = 1?
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/soc-pcm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 74d340d..5aa9c0b 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2855,10 +2855,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>  
>  		for_each_rtd_codec_dai(rtd, i, codec_dai) {
>  			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
> -			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
> +			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
>  				playback = 1;
>  			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
> -			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
> +			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
>  				capture = 1;
>  		}
>  

There are no longer any playback/capture PCMs registered on
qcom/apq8016_sbc with this patch. :(

With this patch:
  $ ls /dev/snd
  controlC0  timer

Without this patch:
  $ ls /dev/snd
  controlC0  pcmC0D0p   pcmC0D1c   timer

(There is exactly one playback-only and capture-only PCM normally...)

The routing looks like this:
  qcom-apq8016-sbc 7702000.sound: ASoC: registered pcm #0 WCD multicodec-0
  qcom-apq8016-sbc 7702000.sound: multicodec <-> Primary MI2S mapping ok
  qcom-apq8016-sbc 7702000.sound: ASoC: registered pcm #1 WCD-Capture multicodec-1
  qcom-apq8016-sbc 7702000.sound: multicodec <-> Tertiary MI2S mapping ok
  WCD: connected DAI link 7708000.lpass:Primary Playback -> 771c000.codec:AIF1 Playback
  WCD: connected DAI link 7708000.lpass:Primary Playback -> 200f000.spmi:pm8916@1:codec@f00:PDM Playback
  WCD-Capture: connected DAI link 771c000.codec:AIF1 Capture -> 7708000.lpass:Tertiary Capture
  WCD-Capture: connected DAI link 200f000.spmi:pm8916@1:codec@f00:PDM Capture -> 7708000.lpass:Tertiary Capture

For the playback stream, codec_dai and cpu_dai (lpass) only support SNDRV_PCM_STREAM_PLAYBACK.
The same applies to the capture stream.

I'm a bit confused about this patch, isn't SNDRV_PCM_STREAM_PLAYBACK
used for both cpu_dai and codec_dai in the playback case?

Thanks,
Stephan

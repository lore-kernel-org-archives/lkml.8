Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C990C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8951120656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="EQKtyMof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgBQRM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:12:56 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:18313 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbgBQRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581959573;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Ss3ccvJK1W2R8MPluJRGBjaq4okSpK5gZTbpzzImiiA=;
        b=EQKtyMofNphEWf5RuzxUzpz7DBZ7XLc1Kl+J5LD0SpDFlts31tu1Ik1x4JeQ/9UNhx
        TfVVofA/B/3ubcAXH1XwoqwgWISvaAx3/Qu13aNDR76QRNWlbBHVuYs+kcGZ8kAwKNqM
        UGPr/OqXEUcDuuPKtWrW3W7fLXADmvzPkk5RNehMQJsTVG0K/S31F2/dvdWslq5Zc23B
        rkOuAgZJBDhVT4ZZClEDG/Q5OYwz5AqgspHJMntZ7GJTjdIDwuEgzIep1Dywzh6AnFxO
        2j8+wwEa18u3tXkK20BNVWmnvBupicqaI9ZTl/BtFjB9GHrTspljftVhzkdKP1TS80L8
        te3g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJKBk/pyQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id a01fe9w1HHCqeWy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 17 Feb 2020 18:12:52 +0100 (CET)
Date:   Mon, 17 Feb 2020 18:12:45 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [RFC] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai
Message-ID: <20200217171245.GA881@gerhold.net>
References: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
 <20200217144120.GA243254@gerhold.net>
 <20200217154301.GN9304@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217154301.GN9304@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 03:43:01PM +0000, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 03:41:20PM +0100, Stephan Gerhold wrote:
> 
> > I'm a bit confused about this patch, isn't SNDRV_PCM_STREAM_PLAYBACK
> > used for both cpu_dai and codec_dai in the playback case?
> 
> It is in the normal case, but with a CODEC<->CODEC link (which was what
> this was targeting) we need to bodge things by swapping playback and
> capture on one end of the link.

I see. Looking at the code again I'm guessing the cause of the crash
"fixed" by this patch is commit a342031cdd08 ("ASoC: create pcm for
codec2codec links as well") where the codec2codec case was sort of
patched in. This is what we had before this patch:

		/* Adapt stream for codec2codec links */
		struct snd_soc_pcm_stream *cpu_capture = rtd->dai_link->params ?
			&cpu_dai->driver->playback : &cpu_dai->driver->capture;
		struct snd_soc_pcm_stream *cpu_playback = rtd->dai_link->params ?
			&cpu_dai->driver->capture : &cpu_dai->driver->playback;

This does the swapping you mentioned, so I guess rtd->dai_link->params
is only set for the codec2codec case?

		for_each_rtd_codec_dai(rtd, i, codec_dai) {
			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
				playback = 1;
			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
				capture = 1;
		}

		capture = capture && cpu_capture->channels_min;
		playback = playback && cpu_playback->channels_min;

And this does a part of the check in snd_soc_dai_stream_valid(),
but without the NULL check of cpu_capture/cpu_playback.
(Maybe that is the cause of the crash.)

From my limited understanding, I would say that a much simpler way to
implement this would be:

	/* Adapt stream for codec2codec links */
	int cpu_capture = rtd->dai_link->params ?
		SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
	int cpu_playback = rtd->dai_link->params ?
		SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;

	for_each_rtd_codec_dai(rtd, i, codec_dai) {
		if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
		    snd_soc_dai_stream_valid(cpu_dai,   cpu_playback))
			playback = 1;
		if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
		    snd_soc_dai_stream_valid(cpu_dai,   cpu_capture))
			capture = 1;
	}

since snd_soc_dai_stream_valid() does both the NULL-check and the 
"channels_min" check.

But I'm really not familar with the codec2codec case and am unable to
test it :) What do you think?

Thanks,
Stephan

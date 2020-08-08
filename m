Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF6BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B432320866
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIf44nbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHHAXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHHAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 20:23:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC61C061A28
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 17:23:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s189so3624317iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTDGTiIacJbp80sJvWFI+4i26J3I7Pjj49muNpJiHT0=;
        b=rIf44nbp0cYaA6k+R/H/rPD8A/tm9+Pduu37WBVATPHFReK07/92Tj08WMfz2FVfa9
         tnAtcofY/E4+l21piiZdvVXlE0u22EqkJlH7WHAF9erTc03wLkiDP9bHkECoEckRBoaY
         Mql3AHLLcU7uNeCVwOSo3GFPbBC4MdxDmasdzFdYxra9YGV6U2l6ZCVGQSmGvfne0YwT
         WWtJe703lLCPFwroY7lo/vEFyDn2We1wzpGR4CrGb74qb9lxu5NIpeISpWNOR/u4g49L
         wlh8VyFhI6EdgMx0eCK5ePlTVyrvrw9HzmSV6lLdAlAFFyRSB4XOdQ5JoNNIfJusvu6u
         3DMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTDGTiIacJbp80sJvWFI+4i26J3I7Pjj49muNpJiHT0=;
        b=AUcFZfkIkVcUjReJvXcY/64xjqC8KNwH8AiuJbRkZfUMyy1zOlyGYR2T3+BRQUWNxj
         aysK0uDUwqhUoL66AR+b/ym4KuWQGeumR7mZBlk5JrytHJLxosE6oAJ+lSxv9e2arlx5
         /u3acB4O4EOhn2OSRQtB+6d85oqSh6AFR7bXfM3vbggMVsKM0pnHwR7f0Zs2+erdjIfm
         /ZUZvNWrb4++U1bOch9Q23d8RUois6Bv7dZurAcczgOFbLfG6gtgq4zrIXrp4r5zoFfz
         Uiqiqu0c4/bPv7UKGn9918REAFP3eUHFSjhd96QMf4nXByz/vKNpACKxwaLUUaaJxTRq
         9yDQ==
X-Gm-Message-State: AOAM530ys1xkJX6IRlzICUNC8zq5Hml2y26k+aqZWFxpFZZcqRWeQj53
        Ms2cTtLPkAuV6sayD+sNBJH5i6utMQDWqMgaxro=
X-Google-Smtp-Source: ABdhPJzSDmjDvsAXdtCHfJuPZFkiDHSmbZRtQPOnsaTcaByUnjH8dmEn8++rNHuqTLmeL+dpoLmgg3P/7txeXbYYfDE=
X-Received: by 2002:a5d:8f09:: with SMTP id f9mr7093264iof.187.1596846215379;
 Fri, 07 Aug 2020 17:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <s5hbljocbxl.wl-tiwai@suse.de>
In-Reply-To: <s5hbljocbxl.wl-tiwai@suse.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 7 Aug 2020 17:23:24 -0700
Message-ID: <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 5.9
To:     Takashi Iwai <tiwai@suse.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:33 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> Linus,
>
> please pull sound updates for v5.9 from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc1
>
> The topmost commit is c7fabbc51352f50cc58242a6dc3b9c1a3599849b
>
> ----------------------------------------------------------------
>
> sound updates for 5.9
>
> This became wide and scattered updates all over the sound tree as
> diffstat shows: lots of (still ongoing) refactoring works in ASoC,
> fixes and cleanups caught by static analysis, inclusive term
> conversions as well as lots of new drivers.  Below are highlights:
>
> ASoC core:
> * API cleanups and conversions to the unified mute_stream() call
> * Simplify I/O helper functions
> * Use helper macros to retrieve RTD from substreams
...
> Kuninori Morimoto (90):
>       ASoC: soc-component: add soc_component_pin() and share code
>       ASoC: soc-component: move snd_soc_component_xxx_regmap() to soc-component
>       ASoC: soc-component: move snd_soc_component_initialize() to soc-component.c
>       ASoC: soc-component: add soc_component_err()
>       ASoC: soc-component: add snd_soc_pcm_component_prepare()
>       ASoC: soc-component: add snd_soc_pcm_component_hw_params()
>       ASoC: soc-component: add snd_soc_pcm_component_hw_free()
>       ASoC: soc-component: add snd_soc_pcm_component_trigger()
>       ASoC: soc-component: add snd_soc_component_init()
>       ASoC: soc-component: merge soc-io.c into soc-component.c

So oddly, today I bisected down the change "ASoC: soc-component: merge
soc-io.c into soc-component.c":
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=460b42d162e3cf634586999e6a84e74ca52e626d

as causing audio regressions on Dragonboard 845c running AOSP.

On boot I was seeing tons of:
q6routing remoteproc-adsp:glink-edge:apr:apr-service@8:routing: ASoC:
error at soc_component_read_no_lock on
remoteproc-adsp:glink-edge:apr:: -5

And when audio was supposed to play I'd see:
[  227.462986] qcom-q6afe aprsvc:apr-service:4:4: cmd = 0x100e5
returned error = 0x9
[  227.470720] qcom-q6afe aprsvc:apr-service:4:4: DSP returned error[9]
[  227.477168] qcom-q6afe aprsvc:apr-service:4:4: AFE enable for port
0x4000 failed -22
[  227.485038] q6afe-dai
remoteproc-adsp:glink-edge:apr:apr-service@4:dais: fail to start AFE
port 2
[  227.494013] q6afe-dai
remoteproc-adsp:glink-edge:apr:apr-service@4:dais: ASoC: error at
snd_soc_pcm_dai_prepare on SLIMBUS_0_RX: -22
[  227.506034]  SLIM Playback: ASoC: DAI prepare error: -22
[  227.511415]  SLIM Playback: ASoC: backend prepare failed -22

Its strange, as the bisected patch is really just moving code around
and there's very little in the way of logic changes. After minimizing
the code movement and just focusing on what changed I forward ported a
revert to mainline and minimized it until things were working.

The resulting patch is a twoliner here:
https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=a3527193f39b1224d59bf1519fce3ef8c57d0f5e

I'm a bit baffled as to why this patch works. Logically we are
returning the same value. I suspect when we hit the error, all the
extra error print messages on the console slow things down and end up
causing some timing related initialization failure?

Anyway, I wanted to raise the issue in case anyone had ideas what
might be going wrong.

thanks
-john

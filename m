Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC5AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFC6206CD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYl75+YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHHVcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:32:21 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9455C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 14:32:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so5378300oiv.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbiruEThZwwBNNbqYU9VCvLYRkhuc+0AzXoKgsDR8KY=;
        b=XYl75+YK3Y28AwXMLh9zP+v4x8ZIKq2G8zrxQsCP/0JOVHyris5bWIGLrNXawnLztH
         eH1Eo5ZWwNBWWqPSothyde2NJPHwtYKz40VFZCnVCNJjoZ8s2C3VQMhgc1RH8u/fP+4z
         r0MnQrISYfS0/k99bpZke0k98N30gN+zFFm+C2QMdWohgsDPaKRAI06K/7mpjrZtmTjt
         fwVF0eW1Eiw4OmdFaBh0NjHVPT28lE5CIcPswGdV9bjU1aFJXrSnuDmZa5vpUWxAJ7QF
         1VAVgEKpfY1+rsKhVXDQttRRGJVma1h3Rvl/+xEy/i7wW0qjZ7NJherm1ff8P6wMEAlN
         2uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbiruEThZwwBNNbqYU9VCvLYRkhuc+0AzXoKgsDR8KY=;
        b=dk4y8mjfsxmxrQ2nLiFrP8mGaj3Ft+5NR7iLsPtM9I+V1q8I6Zkh5PVaRrmA9fZZwL
         NfEgndBgbaBv9Y73NBHFUurGKFI2+jyLAqL0kGKFwMVkz79yK5dDko2760wJyUpvHZ3m
         Qy29tCljaoE8e0E/eQUZFD0Cput4m9b1JReq1/OInF1Ml2yR+t/AN3mv85XvbMveHdC8
         k6ozdRlnMPV+N3tYcxu2yz7vg/gUsgPEWDmOxPXRBDUnnWgBsdhIE/hxlJF69V770BrO
         gyk/Tqx5Ra+JLZO5m1925b84jVNG2B8XsRc2gcPFR0v7LYVFedQnk06AOvSN01Tt0pvr
         qY6g==
X-Gm-Message-State: AOAM530k1C39x4DJumTqtlRp9oQWbKdTL3UdDMfix5HNus3Np4FmR4va
        vgwQbElgzcg/uyiVmlcws/gUysd+9oVipfIGrE3Utg==
X-Google-Smtp-Source: ABdhPJxbFaEWUkYXoWuv4s6cPdBCYGiAhkAq4GGBkZiCJsULVGQBlqD0ChK8oYzlCMRfIwT9d26rYuHaOLrdvi01pv0=
X-Received: by 2002:aca:1117:: with SMTP id 23mr16930520oir.97.1596922340984;
 Sat, 08 Aug 2020 14:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <s5hbljocbxl.wl-tiwai@suse.de> <CANcMJZCPPOOmKyRMKYRe5sRsqf-rrO6wXK5BPVwFrAPLZOEyMg@mail.gmail.com>
 <s5hv9ht7hz9.wl-tiwai@suse.de>
In-Reply-To: <s5hv9ht7hz9.wl-tiwai@suse.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Sat, 8 Aug 2020 14:32:09 -0700
Message-ID: <CALAqxLUkT0r-mrR5pKx4vXAHubS87oeEEN53C_q5fSKoh-=M3w@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 5.9
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, Aug 7, 2020 at 11:46 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 08 Aug 2020 02:23:24 +0200,
> John Stultz wrote:
> >
> > On Thu, Aug 6, 2020 at 3:33 AM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > Linus,
> > >
> > > please pull sound updates for v5.9 from:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc1
> > >
> > > The topmost commit is c7fabbc51352f50cc58242a6dc3b9c1a3599849b
> > >
> > > ----------------------------------------------------------------
> > >
> > > sound updates for 5.9
> > >
> > > This became wide and scattered updates all over the sound tree as
> > > diffstat shows: lots of (still ongoing) refactoring works in ASoC,
> > > fixes and cleanups caught by static analysis, inclusive term
> > > conversions as well as lots of new drivers.  Below are highlights:
> > >
> > > ASoC core:
> > > * API cleanups and conversions to the unified mute_stream() call
> > > * Simplify I/O helper functions
> > > * Use helper macros to retrieve RTD from substreams
> > ...
> > > Kuninori Morimoto (90):
> > >       ASoC: soc-component: add soc_component_pin() and share code
> > >       ASoC: soc-component: move snd_soc_component_xxx_regmap() to soc-component
> > >       ASoC: soc-component: move snd_soc_component_initialize() to soc-component.c
> > >       ASoC: soc-component: add soc_component_err()
> > >       ASoC: soc-component: add snd_soc_pcm_component_prepare()
> > >       ASoC: soc-component: add snd_soc_pcm_component_hw_params()
> > >       ASoC: soc-component: add snd_soc_pcm_component_hw_free()
> > >       ASoC: soc-component: add snd_soc_pcm_component_trigger()
> > >       ASoC: soc-component: add snd_soc_component_init()
> > >       ASoC: soc-component: merge soc-io.c into soc-component.c
> >
> > So oddly, today I bisected down the change "ASoC: soc-component: merge
> > soc-io.c into soc-component.c":
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=460b42d162e3cf634586999e6a84e74ca52e626d
> >
> > as causing audio regressions on Dragonboard 845c running AOSP.
> >
> > On boot I was seeing tons of:
> > q6routing remoteproc-adsp:glink-edge:apr:apr-service@8:routing: ASoC:
> > error at soc_component_read_no_lock on
> > remoteproc-adsp:glink-edge:apr:: -5
> >
> > And when audio was supposed to play I'd see:
> > [  227.462986] qcom-q6afe aprsvc:apr-service:4:4: cmd = 0x100e5
> > returned error = 0x9
> > [  227.470720] qcom-q6afe aprsvc:apr-service:4:4: DSP returned error[9]
> > [  227.477168] qcom-q6afe aprsvc:apr-service:4:4: AFE enable for port
> > 0x4000 failed -22
> > [  227.485038] q6afe-dai
> > remoteproc-adsp:glink-edge:apr:apr-service@4:dais: fail to start AFE
> > port 2
> > [  227.494013] q6afe-dai
> > remoteproc-adsp:glink-edge:apr:apr-service@4:dais: ASoC: error at
> > snd_soc_pcm_dai_prepare on SLIMBUS_0_RX: -22
> > [  227.506034]  SLIM Playback: ASoC: DAI prepare error: -22
> > [  227.511415]  SLIM Playback: ASoC: backend prepare failed -22
> >
> > Its strange, as the bisected patch is really just moving code around
> > and there's very little in the way of logic changes. After minimizing
> > the code movement and just focusing on what changed I forward ported a
> > revert to mainline and minimized it until things were working.
> >
> > The resulting patch is a twoliner here:
> > https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=a3527193f39b1224d59bf1519fce3ef8c57d0f5e
> >
> > I'm a bit baffled as to why this patch works. Logically we are
> > returning the same value. I suspect when we hit the error, all the
> > extra error print messages on the console slow things down and end up
> > causing some timing related initialization failure?
>
> Does the patch below fix the bug?  If so, it's rather a bug in the
> commit cf6e26c71bfd ("ASoC: soc-component: merge
> snd_soc_component_read() and snd_soc_component_read32()").
>
>
> thanks,
>
> Takashi
>
> --- a/sound/soc/soc-component.c
> +++ b/sound/soc/soc-component.c
> @@ -406,7 +406,7 @@ static unsigned int soc_component_read_no_lock(
>                 ret = -EIO;
>
>         if (ret < 0)
> -               soc_component_ret(component, ret);
> +               return soc_component_ret(component, ret);

Oh, that's so obvious now! I can't believe I was staring at that code
and just didn't see it!
Thanks so much for pointing this out!

I'm sure this will fix it, but will validate on monday when I am
working with the board.

thanks!
-john

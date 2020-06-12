Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54424C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBF820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwJo2Bcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLAtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLAtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:49:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F14C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:49:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so7234417oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYO/56jAlSJmEKKEC3sDbINPjtiMSsfklDTiY6BNZzs=;
        b=QwJo2BcgHjI7iLhRJeSZg3J1BZLiuq1MVSI9inNjtXpuiOdHMPL1H9FuCPXUGaAIBw
         qx4c+vbw/HjgU6OiLoUk05Pk1goSzEZc6FsKsWvtjdYEhhsI9xyrSB+tuZu0pyIbhFGX
         UmvNVX0/8+2ljEl4Uv0d+HLjeRH9gGiKb0U5KNKbHkj3JH7Q1RQHZt1kp9zlIGZmeJEg
         d3/rhv83qDlNHu5de0AmSMfPMLSPsyMN6rhTAchyA5so30AJPkdbwQWuhVJw0SFNo6GR
         p3DpwQxJjE8RMRrx1uCuxUTbNo7x6tCW6mM1AZ+QoqLNvBMR2AG8LjpG2MPb5mADivBE
         T0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYO/56jAlSJmEKKEC3sDbINPjtiMSsfklDTiY6BNZzs=;
        b=ktN9OjFXh7KkHVtmiyTpf4b2LwIrhtX7GEu4ZIcGC9o7N1LS26NJ1WEp38e+dk8MbC
         LCFtWdXl4CCI+EdN2HyZMF9uHpvyHa8CvtTBtTfBTnWwJnKUk+0YxtdW3MbWYpFqmgYZ
         5An8OWc65n0VMTCqvPBGwZVB/vaCQ8d/sCrDNv++5Zf6vYAzKpXtO+XyGzBnnKoGTxh4
         BwSrtrOr+GI4zdQt3M4+H3IWh4VUYJKnvkSwUAedCE0uImgz1eZ+HzYn95tnOQLf2vI3
         85uCGsiS3whAh2wGjBdGXdhW93+jtBDAkjq6ZrHGKSBcIMp+TpF12GVDWNF/wo1fNz+p
         kHfA==
X-Gm-Message-State: AOAM530476gfAUU5P39+em26MI/KF5IQVRk8E0G9Ce37dkqvizFHCpQp
        lmFZJSV961Dwmdk9sBhsACAMlBv2WgKGxr+KtGyNOA==
X-Google-Smtp-Source: ABdhPJzSRrQoexp66WEFwfTRVwH565Tou4tzj1+FW+C+utMOv2XLr+b0Pd1S88XOqeyBvZ29OMI0WqXRnUlsUcTyzoA=
X-Received: by 2002:aca:5d0b:: with SMTP id r11mr454293oib.169.1591922983459;
 Thu, 11 Jun 2020 17:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <s5himfxet1c.wl-tiwai@suse.de> <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
In-Reply-To: <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 11 Jun 2020 17:49:29 -0700
Message-ID: <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
To:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 5:13 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Jun 11, 2020 at 6:39 AM Takashi Iwai <tiwai@suse.de> wrote:
> > sound fixes for 5.8-rc1
> >
> > Here are last-minute fixes gathered before merge window close;
> > a few fixes are for the core while the rest majority are driver
> > fixes.
> >
> > * PCM locking annotation fixes and the possible self-lock fix
> > * ASoC DPCM regression fixes with multi-CPU DAI
>
> Just as a heads up, we just recently got HDMI audio working on the
> Dragonboard 845c (Vinod has patches he's sending out here in the next
> few days), but they suddenly stopped working today with the following
> error:
> [   13.110725] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> MultiMedia1 mapping ok
> [   13.119343] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> MultiMedia2 mapping ok
> [   13.127969] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> MultiMedia3 mapping ok
> [   13.135891] msm-snd-sdm845 soc@0:sound: Compress ASoC:
> snd-soc-dummy-dai <-> MultiMedia4 mapping ok
> [   13.145042] msm-snd-sdm845 soc@0:sound: CPU DAI QUAT_MI2S_RX for
> rtd HDMI Playback does not support capture
> [   13.154873] msm-snd-sdm845 soc@0:sound: ASoC: can't create pcm HDMI
> Playback :-22
> [   13.165634] snd-malloc: invalid device type 0
> [   13.170057] snd-malloc: invalid device type 0
> [   13.174888] msm-snd-sdm845 soc@0:sound: Sound card registration failed
> [   13.181574] msm-snd-sdm845: probe of soc@0:sound failed with error -22
>
>  I've bisected it down to the following commit from this pull req:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b73287f0b0745961b14e5ebcce92cc8ed24d4d52
>
> Without this patch:
> [   13.056906] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> MultiMedia1 mapping ok
> [   13.075465] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> MultiMedia2 mapping ok
> [   13.092949] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> MultiMedia3 mapping ok
> [   13.109704] msm-snd-sdm845 soc@0:sound: Compress ASoC:
> snd-soc-dummy-dai <-> MultiMedia4 mapping ok
> [   13.125584] msm-snd-sdm845 soc@0:sound: i2s-hifi <-> QUAT_MI2S_RX mapping ok
> [   13.125621] msm-snd-sdm845 soc@0:sound: multicodec <-> SLIMBUS_0_RX
> mapping ok
> [   13.141682] msm-snd-sdm845 soc@0:sound: wcd934x_tx1 <->
> SLIMBUS_0_TX mapping ok
> ...
>
> I've not managed to dig in with much analysis yet (possibly something
> off with the current patches we have), but wanted to raise the issue
> in case others start to see it too.

I don't know the backgroun again, but would something like the
following make sense?
https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=7e49b248db77b5ed29b2aa278268e77650c75482

It avoids failing completely if playback or capture isn't found.

thanks
-john

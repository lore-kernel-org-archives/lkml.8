Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7369CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E85A206F5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOMtxh2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFMAAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgFMAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:00:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13842C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 17:00:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s13so8717777otd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 17:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=is3UDT8tkZfXuglKMbk+zYJdjksm2qqI2ouiOGmZpKE=;
        b=QOMtxh2oNDu+0Ss70/QpUvVtngWw/qPOuFdD2VTeAk4f7WL4ABpLFSk+qGNW8IoEUG
         BraYJoQwyvwaosWbcCp7tia4i/iHVKlVjB9vo6fKhiofefPXZR4dwbo2VaKs3gVyNoyQ
         v1VwapayUUBD1xReP4wZ11PqjUUt2RTIepVmx4SNvMCEbl0+kgC2cN1cPK4ehlg831L1
         eTJaCzgpDcQW4CmIlGeEC7X1Xih8r+sqfpTqR7vmRgCrywdT5KBu9xkJhAsw5XW2KBTm
         z0aeB0G2kO2ZpsKhw24N9tAaX18fiEJYruwojrUVSLd2DG+Gdovnx8QnXJekKVKv7FiK
         6dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=is3UDT8tkZfXuglKMbk+zYJdjksm2qqI2ouiOGmZpKE=;
        b=R4FPlat92jYdSZhlGQhtM/yd4KWcaSnHdgeJcO8Ubxg/2R20cJ4FMeundlF+fFDaCx
         1+d8+9TV0kW0B1NUJic7Af9IPYA4VSjbcT1JLG1Y1laAnZs5Wn8Ui4iF9OsHDvI32ANs
         ApgQ2k9ymEIQiFrMepPUnLSBuH0HHJxzORbe7F4vU159hs/gLWOi9RZst2FBmbZ8JjV5
         dHb98BAG2qLbWYaqH+/jBQjW5t4vyJ9FAiIFzJBp71ViVw5vW32//i7VmjzlaiT4o4IX
         Z862sE15ykEm9EacLm/uJC2XLyF3ZXaKERDMyCDR3ATgW7BkFXM9vPFO701eC9YRwS4g
         GeAw==
X-Gm-Message-State: AOAM533DIG1xuiRGTFZxsxlL4SSMKpKNVVZIo3K8OA2+V3aLep5YvmwH
        wC4CU2p3N8MWJNQuNB+PNamc/qTEJlbjhOO3MC4EcA==
X-Google-Smtp-Source: ABdhPJz/8qwhUTs/P0UYTBX9wNYQ02l9M0Ck2XFDiL6IQk/lWz5Guip0Zve2iGxX2hAygThRN0lt/QRcMpOfjd8qJ8A=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr12314068otn.221.1592006402065;
 Fri, 12 Jun 2020 17:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <s5himfxet1c.wl-tiwai@suse.de> <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
 <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com> <4d692acd-6fe8-7a5f-34d5-78a4d6dd03cf@linaro.org>
In-Reply-To: <4d692acd-6fe8-7a5f-34d5-78a4d6dd03cf@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 12 Jun 2020 16:59:49 -0700
Message-ID: <CALAqxLVko31=PXSGoGL3uvvdjpFZ9QVOYygwVSH0i2uR=EX9gw@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 4:42 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks John for reporting this,
>
> On 12/06/2020 01:49, John Stultz wrote:
> > On Thu, Jun 11, 2020 at 5:13 PM John Stultz <john.stultz@linaro.org> wrote:
> >>
> >> On Thu, Jun 11, 2020 at 6:39 AM Takashi Iwai <tiwai@suse.de> wrote:
> >>> sound fixes for 5.8-rc1
> >>>
> >>> Here are last-minute fixes gathered before merge window close;
> >>> a few fixes are for the core while the rest majority are driver
> >>> fixes.
> >>>
> >>> * PCM locking annotation fixes and the possible self-lock fix
> >>> * ASoC DPCM regression fixes with multi-CPU DAI
> >>
> >> Just as a heads up, we just recently got HDMI audio working on the
> >> Dragonboard 845c (Vinod has patches he's sending out here in the next
> >> few days), but they suddenly stopped working today with the following
> >> error:
> >> [   13.110725] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> >> MultiMedia1 mapping ok
> >> [   13.119343] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> >> MultiMedia2 mapping ok
> >> [   13.127969] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> >> MultiMedia3 mapping ok
> >> [   13.135891] msm-snd-sdm845 soc@0:sound: Compress ASoC:
> >> snd-soc-dummy-dai <-> MultiMedia4 mapping ok
> >> [   13.145042] msm-snd-sdm845 soc@0:sound: CPU DAI QUAT_MI2S_RX for
> >> rtd HDMI Playback does not support capture
> >> [   13.154873] msm-snd-sdm845 soc@0:sound: ASoC: can't create pcm HDMI
> >> Playback :-22
> >> [   13.165634] snd-malloc: invalid device type 0
> >> [   13.170057] snd-malloc: invalid device type 0
> >> [   13.174888] msm-snd-sdm845 soc@0:sound: Sound card registration failed
> >> [   13.181574] msm-snd-sdm845: probe of soc@0:sound failed with error -22
> >>
> >>   I've bisected it down to the following commit from this pull req:
> >>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b73287f0b0745961b14e5ebcce92cc8ed24d4d52
> >>
> >> Without this patch:
> >> [   13.056906] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> >> MultiMedia1 mapping ok
> >> [   13.075465] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> >> MultiMedia2 mapping ok
> >> [   13.092949] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
> >> MultiMedia3 mapping ok
> >> [   13.109704] msm-snd-sdm845 soc@0:sound: Compress ASoC:
> >> snd-soc-dummy-dai <-> MultiMedia4 mapping ok
> >> [   13.125584] msm-snd-sdm845 soc@0:sound: i2s-hifi <-> QUAT_MI2S_RX mapping ok
> >> [   13.125621] msm-snd-sdm845 soc@0:sound: multicodec <-> SLIMBUS_0_RX
> >> mapping ok
> >> [   13.141682] msm-snd-sdm845 soc@0:sound: wcd934x_tx1 <->
> >> SLIMBUS_0_TX mapping ok
> >> ...
> >>
> >> I've not managed to dig in with much analysis yet (possibly something
> >> off with the current patches we have), but wanted to raise the issue
> >> in case others start to see it too.
> >
> > I don't know the backgroun again, but would something like the
> > following make sense?
> > https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=7e49b248db77b5ed29b2aa278268e77650c75482
> >
> > It avoids failing completely if playback or capture isn't found.
>
> Can you please try these two patches, I think the problem is that FE
> dailinks are always set to bidirectional, this two patches should fix it.
>
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=gapless/v2&id=bb7ce65a0ca1640cd9ff301c885f56ce00519834
>
> https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=gapless/v2&id=9b568e491f0410b453aaf5a147b75252a6943ffd
>
>
> Once you confirm I can send them to list as fixes.

Yep! These two patches work for me! Thanks so much for the quick fix!
-john

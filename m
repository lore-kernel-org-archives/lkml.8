Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3AC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E063520679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgBQG42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:56:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41053 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBQG42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:56:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so19413103eds.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 22:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WHKaTGOgOAJM+VcnF+6HFOUNwxgDydG90xB7o+8lGE=;
        b=jXQp69LB0cB/N1kZW4yXSK6cIBtY0cp8pVznQvztgfPxz9EMERsO933ikeQTImq+VC
         MM3JyREm2sqxM+5cQ83Wok0p/iPMY0hJqhXj+jdaseLj59cs2Se/J0y/DBRAEZrWUtJf
         EppIi/sUtuKj81aBpKXBchxJ94F6hmXg1rXPk0FnNsaUaYao9DbL1cOYv7SheNtJbQAV
         p483oOkngvfr6c/HkfnWJ74XVGGqlSh7AAm6qbEJvIT6cWgmAkOC9YhmSdGhyrb417Jm
         WB8T6OxSKEth9xtVGQ04ebrwCAXOqIzYrPsraFyqeaEhatv2DXPGGNFMKK7xXoQ5TGFo
         OJdA==
X-Gm-Message-State: APjAAAVJ4nSbppsBwk2NDDbAs+jbty861h0nYlrBj8EnPlkURbExQ1Bj
        12cx82ObBeTHEB4K2gjcv53Hqad0Jgc=
X-Google-Smtp-Source: APXvYqzUjZnEUwvNaponYrgyXHew2v1fs32vxQmuJIW6DH/cNLwrmHVTVTmMFevviQATUx/Aembcqg==
X-Received: by 2002:a05:6402:387:: with SMTP id o7mr13364154edv.84.1581922586164;
        Sun, 16 Feb 2020 22:56:26 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id x6sm811596ejw.84.2020.02.16.22.56.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 22:56:25 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id p17so17121508wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 22:56:25 -0800 (PST)
X-Received: by 2002:a05:600c:10d2:: with SMTP id l18mr20086133wmd.122.1581922585072;
 Sun, 16 Feb 2020 22:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org> <20200217021813.53266-5-samuel@sholland.org>
 <CAGb2v677p8u8_0jhcbN07QsyVc21dKJmeK6=rxLCbde+AOqreQ@mail.gmail.com> <de0a08a8-eb02-375f-4364-2935cf4c3d7c@sholland.org>
In-Reply-To: <de0a08a8-eb02-375f-4364-2935cf4c3d7c@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 14:56:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xLO_=EFoa=vGh-HRY=nQuE0a+mv-nfveimK=pb=FjGQ@mail.gmail.com>
Message-ID: <CAGb2v64xLO_=EFoa=vGh-HRY=nQuE0a+mv-nfveimK=pb=FjGQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] ASoC: sun50i-codec-analog: Make headphone routes stereo
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:57 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Hello,
>
> On 2/16/20 9:48 PM, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> This matches the hardware more accurately, and is necessary for
> >> including the (stereo) headphone mute switch in the DAPM graph.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  sound/soc/sunxi/sun50i-codec-analog.c | 28 +++++++++++++++++++--------
> >>  1 file changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
> >> index 17165f1ddb63..f98851067f97 100644
> >> --- a/sound/soc/sunxi/sun50i-codec-analog.c
> >> +++ b/sound/soc/sunxi/sun50i-codec-analog.c
> >> @@ -311,9 +311,15 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
> >>          */
> >>
> >>         SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
> >> -       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
> >> +       SND_SOC_DAPM_MUX("Left Headphone Source",
> >>                          SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
> >> -       SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
> >> +       SND_SOC_DAPM_MUX("Right Headphone Source",
> >
> > Please don't remove the widget suffix. The suffix was chosen to work with
> > alsa-lib's control parsing code. The term "Playback Route" is appropriate
> > because it is playback only, and it is a routing switch, not a source or
> > sink.
>
> Removing the suffix here doesn't affect the control name as seen by userspace,
> because the control is shared between multiple widgets (Left and Right).

You're right.

> > Also, what's wrong with just having a single "stereo" widget instead of
> > two "mono" widgets? I added stereo (2-channel) support to DAPM quite
> > some time ago. You just have to have two routes in and out.
>
> If you have any completed path through a widget, the widget is turned on. A
> stereo mute switch is logically two separate paths. So if I break one path by
> muting one channel, that lets me turn off everything before and after in the
> path (e.g. turning off the right side of the DAC lets DAPM turn off the right
> mixer, the right side of the output amp, even the right side of the AIF or the
> ADC if that was the only input. That only works if there are separate Left/Right
> widgets.

Looks like that's the case indeed. Might be worth revisiting the core DAPM code
later on if I can find the time.

Since the widgets and routes changed are internal to the codec, there won't be
any issue if we rework this stuff later on. So for now,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

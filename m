Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46582072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 22:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="LLM9r0vY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCTWvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:51:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36312 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:51:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id 39so7675073otu.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJJPMLz7WHfijv4QsdDA8oo6aFkLf4z2pFfe94unjoE=;
        b=LLM9r0vYyuH2sIU2RS7aUWEyYWOB+2wa4CA44ADRkk14C5XdkRJ7swbzRiTdH39oGB
         CKtlEYwhcyA2wgT2iF41wWrgZHwNX/dnVTiq6ypc8AQnDP/or7M/HVp++u+U23YsSHC5
         koTOcuwPKxV7YkhTOmAR/czZBpCmMBKa4x4rZOtACZvhgw8kQ3/vhquFqJGXH71RETDk
         MQS1ZGkTHPOK/L8uFfuONZGrfcHJUBQH7meA/1Ow4LJc3WVD+X4spdjyKnw8NF49ncTL
         xFS5xQa39LhiHCFc5bf5RtkatmpayKHE/sjHa9frRGF5OOUG7KjWMvIAUyEsDewnvBjM
         hNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJJPMLz7WHfijv4QsdDA8oo6aFkLf4z2pFfe94unjoE=;
        b=gFvTMuLevQjvOxMfGgevU/DMWBiQS/ZBiqmTt10FBYOPSB+4Gbfm5VFp8XslFeAQSq
         SHUsZE0drlLZ9v9uQYXNhEE+xyLTEcsZjMkP+tja+ED3g6piCiJJV0jzKb9z5hCYKMDP
         eBOBadhXYsNtZfG0Wk0SysDRVdvB10QaIT3eCcukXeTifZeGlzKBd6sNZQaB4qsZJToq
         WeRqEO8bYDn+dg/gHtMX1ZBwqaSGctYaiyEARLMTTHuafdBpz5STAigKvoOQFIHkuNO3
         o32FxCQKkFeWoXDgLT3M4jzzZQo2iLoWEEn2qJy0XQ4TysWZPwppq6RsPnGI+G1zsONT
         5xgA==
X-Gm-Message-State: ANhLgQ2jS7RFrPbTgaZq/MY71cVh21U8CmAtsAHy3hpJwCuokX8Q6hG/
        DIK9c+ySDYky0UrjLf9obkFBoflLWtGzfxSlPppjJbjjgN0=
X-Google-Smtp-Source: ADFU+vsrPVD99WJDPNjK+smBphRsSjzG5wuLh3s4d1fcFl8xjfO2mFAAR+58K5OsCGWDB7pfc44EAJA6of2WZQlPCr8=
X-Received: by 2002:a9d:20e2:: with SMTP id x89mr8299168ota.252.1584744678589;
 Fri, 20 Mar 2020 15:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191212071847.45561-1-alison.wang@nxp.com> <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
 <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <20191212122318.GB4310@sirena.org.uk> <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
 <af99c9abd9c2aec6a074fb05310c56b780725ebd.camel@toradex.com>
 <CAJ+vNU16ax9JTx2kSMUF8SiVD-+4KGoFO-U07xM5eE=T6Fwjhw@mail.gmail.com> <CAGgjyvFNCbFw7x6QL063oi-fV2UuVQVfL1cv_pQ74HWoJS4Etg@mail.gmail.com>
In-Reply-To: <CAGgjyvFNCbFw7x6QL063oi-fV2UuVQVfL1cv_pQ74HWoJS4Etg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 20 Mar 2020 15:51:05 -0700
Message-ID: <CAJ+vNU3h1-tJT-KnyaCHj9wvXzdpDyWfvgTSGYLqU8OrzGXv6g@mail.gmail.com>
Subject: Re: [alsa-devel] [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC:
 sgtl5000: Fix of unmute outputs on probe"
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alison.wang@nxp.com" <alison.wang@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:06 AM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> On Fri, Mar 20, 2020 at 5:51 PM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Fri, Mar 20, 2020 at 12:26 AM Marcel Ziswiler
> > <marcel.ziswiler@toradex.com> wrote:
> > >
> > > Hi Tim
> > >
> > > On Thu, 2020-03-19 at 13:49 -0700, Tim Harvey wrote:
> > > > On Thu, Dec 12, 2019 at 4:24 AM Mark Brown <broonie@kernel.org>
> > > > wrote:
> > > > > On Thu, Dec 12, 2019 at 10:46:31AM +0000, Alison Wang wrote:
> > > > >
> > > > > > We tested this standard solution using gstreamer and standard
> > > > > > ALSA
> > > > > > tools like aplay, arecord and all these tools unmute needed
> > > > > > blocks
> > > > > > successfully.
> > > > > > [Alison Wang] I am using aplay. Do you mean I need to add some
> > > > > > parameters for aplay or others to unmute the outputs?
> > > > >
> > > > > Use amixer.
> > > >
> > > > Marc / Oleksandr,
> > > >
> > > > I can't seem to find the original patch in my mailbox for 631bc8f:
> > > > ('ASoC: sgtl5000: Fix of unmute outputs on probe')
> > >
> > > I forwarded you that one again. OK?
> > >
> > > > however I find it
> > > > breaks sgtl5000 audio output on the Gateworks boards which is still
> > > > broken on 5.6-rc6.
> > >
> > > What exactly do you mean by "breaks"? Isn't it that you just need to
> > > unmute stuff e.g. using amixer or using a proper updated asound.state
> > > file with default states for your controls?
> >
> > the audio device is in /proc/asound/cards but when I send audio to it
> > I 'hear' nothing out the normal line-out output.
> >
> > >
> > > > Was there some follow-up patches that haven't made
> > > > it into mainline yet regarding this?
> > >
> > > I don't think so. It all works perfectly, not?
> > >
> > > > The response above indicates maybe there was an additional ALSA
> > > > control perhaps added as a resolution but I don't see any differences
> > > > there.
> > >
> > > Not that I am aware of, no.
> > >
> >
> > The output of 'amixer' shows nothing different than before this patch
> > where audio out worked (same controls, same settings on them). I'm
> > testing this with a buildroot rootfs with no asound.conf (or at least
> > none that I know of... i'm honestly not clear where all they can be).
>
> Tim, did you try to unmute the output with amixer?
>
> Could you provide the output of your amixer with and without this patch?
>
> Before this patch, the driver unmuted HP, LO, and ADC unconditionally
> on load (while it just had to set up ZCD bits).
> Now HP, LO, ADC remain muted until one unmutes them using standard
> ALSA tools/interfaces.
> ALSA mute/unmute controls for these outputs have been presenting in
> the kernel for a long time. Please, just use them.
>

Oleksandr,

When I first bisected to this I must have done something wrong as I
thought amixer settings showed the same before and after - I see that
I'm wrong about that. I see the differences now with HP, LO, and ADC
muted by default. I agree using amixer controls is fine.

Sorry for the noise!

Tim

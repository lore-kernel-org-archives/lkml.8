Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D918C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF50B20709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="JrCCUJRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgCTPvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:51:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33683 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgCTPvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:51:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id r7so7010074oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ua2qKCRuJX1p+rRo3iu9VUft1KtJWJecbVLUDaflgk=;
        b=JrCCUJRDMF/N+NkW+ZOd9bgEyld9L064O27BZmFVHpZAwmutTV85jOU/v2s9twknFl
         mAwlpNzFzlfVOJKZ8NC0eE9nProuOVCq9O4JAFisbK/uA6igKBtYdB8EdqxAS0/5VnAK
         DB3SC/HWXyJMksqcyhlQyBI9l7apsGlNjFyYW9WVs8xtDpoUEvp7gBHQ5UCZnZ6XzQKz
         6+hhc26tEbs3xDOg6RtIIhv6ZAYwfzK7fXQxIX6NbqC1X2xiQdOXlawvqQOD6CXgBJEG
         dynuKd6WWWddOGJazON8ma8WC3BKCmS3lpyTmcFstxHzvWJwB1HSrD27jcDZiPfj8l59
         mLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ua2qKCRuJX1p+rRo3iu9VUft1KtJWJecbVLUDaflgk=;
        b=pXTD9q0OyW4ZTei/ZJO3Ydx+V+BxxMdOhTCx7hCoBi0vyfPdXO5YK7L9JmyLzQJiZ9
         rQ1JznVDTNwzW8GjOszVWmmH18PlCIemYVCISVYO0+KSX55aZ3G10EP4sExpKeEULE5k
         1v415tKs+EMKj+O1eif9v+Pl6iG+zWOuxqcRklK10l0Fob6If007QsyATVxLvohuuIrE
         +l0l427EnIoPG2/DBzAUeOeuS7d1Nmw5pNSskYyZn77556wIXT65MCbWgfojg9UxRwrl
         DK9wYvvUo2qV1H7Z+xX1yvHvcSk7rPpcxu8Dy/FcKz+98/iEtqB8rdMWyTR53Dcl8JXi
         Vdfg==
X-Gm-Message-State: ANhLgQ37LWiM/xuyiEizdlVvLnCm3Y24daZ6lehfPtSkaBYUKQDrqEqk
        oNfYUtT4Xl0JqYruz24F3NQf1Jl7b74dIqQBHba+MQiY
X-Google-Smtp-Source: ADFU+vvOFP1DF5/ZF9jaKsOKByY+/fgm5EgY644cpEkSUiXubLpGBAmhNaI1uzja7eIaSNjN3msBbppikJDPNVcnX/M=
X-Received: by 2002:aca:4b56:: with SMTP id y83mr7242234oia.142.1584719474911;
 Fri, 20 Mar 2020 08:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191212071847.45561-1-alison.wang@nxp.com> <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
 <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <20191212122318.GB4310@sirena.org.uk> <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
 <af99c9abd9c2aec6a074fb05310c56b780725ebd.camel@toradex.com>
In-Reply-To: <af99c9abd9c2aec6a074fb05310c56b780725ebd.camel@toradex.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 20 Mar 2020 08:51:03 -0700
Message-ID: <CAJ+vNU16ax9JTx2kSMUF8SiVD-+4KGoFO-U07xM5eE=T6Fwjhw@mail.gmail.com>
Subject: Re: [alsa-devel] [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC:
 sgtl5000: Fix of unmute outputs on probe"
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
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

On Fri, Mar 20, 2020 at 12:26 AM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Tim
>
> On Thu, 2020-03-19 at 13:49 -0700, Tim Harvey wrote:
> > On Thu, Dec 12, 2019 at 4:24 AM Mark Brown <broonie@kernel.org>
> > wrote:
> > > On Thu, Dec 12, 2019 at 10:46:31AM +0000, Alison Wang wrote:
> > >
> > > > We tested this standard solution using gstreamer and standard
> > > > ALSA
> > > > tools like aplay, arecord and all these tools unmute needed
> > > > blocks
> > > > successfully.
> > > > [Alison Wang] I am using aplay. Do you mean I need to add some
> > > > parameters for aplay or others to unmute the outputs?
> > >
> > > Use amixer.
> >
> > Marc / Oleksandr,
> >
> > I can't seem to find the original patch in my mailbox for 631bc8f:
> > ('ASoC: sgtl5000: Fix of unmute outputs on probe')
>
> I forwarded you that one again. OK?
>
> > however I find it
> > breaks sgtl5000 audio output on the Gateworks boards which is still
> > broken on 5.6-rc6.
>
> What exactly do you mean by "breaks"? Isn't it that you just need to
> unmute stuff e.g. using amixer or using a proper updated asound.state
> file with default states for your controls?

the audio device is in /proc/asound/cards but when I send audio to it
I 'hear' nothing out the normal line-out output.

>
> > Was there some follow-up patches that haven't made
> > it into mainline yet regarding this?
>
> I don't think so. It all works perfectly, not?
>
> > The response above indicates maybe there was an additional ALSA
> > control perhaps added as a resolution but I don't see any differences
> > there.
>
> Not that I am aware of, no.
>

The output of 'amixer' shows nothing different than before this patch
where audio out worked (same controls, same settings on them). I'm
testing this with a buildroot rootfs with no asound.conf (or at least
none that I know of... i'm honestly not clear where all they can be).

Tim

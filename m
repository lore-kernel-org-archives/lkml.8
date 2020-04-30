Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C5FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DE9206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxsmkjon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgD3OAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgD3OA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:00:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413CC035494;
        Thu, 30 Apr 2020 07:00:26 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u11so1553494iow.4;
        Thu, 30 Apr 2020 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nz4EYudAGnRAka2sLpxAUHkI/tIzbc4FpKMb2iD2HGI=;
        b=WxsmkjonITcLJ97YhEvjgmBobJxYhdcS0FMYbI0ha9eAYIbOvVa++0B/N61OFuA+vq
         TZYJoOOK1ZCNtDRuUb0+F6GjgICAVNM5rw4vEuVnM80xd3VkxSFGCpu0bX2tf4mdswgH
         D8T/Hct4kccVa1z5uGmKgC3cbV8W5/BGPIlISHzo6yjyI6Yd84kp1sl1eFHyPTD6GGmH
         0Q1F1IZODwzZhcHFUAcQpScBz+tK/gV6IwRa2pAu8aiuKxSgJ9XM9CrOeEgOUpJR6Mg0
         6oYATFOQutPCYugnCrV+5/HZ8KiRd7lgTda3lkj13rjmdcAeGR16UBPZIBdRZZnJts6f
         Vuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nz4EYudAGnRAka2sLpxAUHkI/tIzbc4FpKMb2iD2HGI=;
        b=CiwWFwshQdvP92w7Gq4UFxS8dWY/QB4VLzrv/Fv5WzUuF1H2+udlUzzN0oNB5PrCp5
         JDfW7qpXlB1CfLHp3qNnE4cvwmmsuBlkxpaQVoO8+yZRBwn06HweZtXwQqgFq9wn+BAw
         OhlJrMN9hF7/l6YD7tafQx4xByBQiOIoMRE6cjfAS/r1pvKjWSINoPOxc6oQDceCvuWR
         mzcLvzCjGCZiIARbyWCnPwKK9atKLl/idujJjghzNVZCL8hRNNt6Omnqr52iP9zwSK/K
         XOKHuBDj+D/1LFSFE6rGaoGYK0Ffhf2HLrwX0zc5KLKIYjOwtnCbmhDbmSgKltqJmQMm
         slBw==
X-Gm-Message-State: AGi0Pub3N2Cxo4L39iufmf9A8KhU1QiVU9tQA3+2VW80YrTnnsM9sWK7
        +RvhIB1Z0Vo2Rng1TbwF4efWg3ph+A6IJRbcZk4=
X-Google-Smtp-Source: APiQypL/hGXbUxNw4AVM3ITxY+bWgZQNGgI8BdvnXtQMrcBmjvMtXdgrG7Lhm8mMQi0TVyWgoYz+zdbaXKGpRu9prEA=
X-Received: by 2002:a6b:b8d6:: with SMTP id i205mr2058871iof.123.1588255225316;
 Thu, 30 Apr 2020 07:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan> <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan> <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
 <20200430084600.samghw4zxb5zdbez@gilmour.lan>
In-Reply-To: <20200430084600.samghw4zxb5zdbez@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 30 Apr 2020 16:00:14 +0200
Message-ID: <CAJiuCcf_LHrJ6QdZgH8HyN6TRiT+GiD+t4UggFCrz-VwVHXV6w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, 30 Apr 2020 at 10:46, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Wed, Apr 29, 2020 at 06:33:00PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Wed, 29 Apr 2020 at 14:35, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Tue, Apr 28, 2020 at 10:55:47AM +0200, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > > > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > > > > > +                              unsigned int fmt)
> > > > >
> > > > > The alignment is off here
> > > > >
> > > > > > +{
> > > > > > +     u32 mode, val;
> > > > > > +     u8 offset;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * DAI clock polarity
> > > > > > +      *
> > > > > > +      * The setup for LRCK contradicts the datasheet, but unde=
r a
> > > > > > +      * scope it's clear that the LRCK polarity is reversed
> > > > > > +      * compared to the expected polarity on the bus.
> > > > > > +      */
> > > > >
> > > > > Did you check this or has it been copy-pasted?
> > > >
> > > > copy-pasted, I will check this.
> > >
> > > It's not going to be easy to do this if you only have a board with HD=
MI. If you
> > > can't test that easily, just remove the comment (or make it explicit =
that you
> > > copy pasted it?), no comment is better than a wrong one.
> >
> > I have talked with Marcus Cooper it may be able to test this this week-=
end.
> > Also this can explain why we need the "
> > simple-audio-card,frame-inversion;" in the device-tree.
> >
> > If think this fix has been introduced by you, correct? Could you say
> > on which SoC did you see this issue?
>
> This was seen on an H3

Just two more questions:
- Did you observe this issue on both TDM and I2S mode?
- On which DAI node?

Since recent change in sun4i-i2s.c, we had to introduce the
"simple-audio-card,frame-inversion" in LibreElec tree.
H3 boards are quite common in LibreElec community so I think:
 - This fix is only needed in TDM mode
 - Or this fix is not required for the HDMI DAI node (HDMI DAI is a
little bit different compare to other DAI but I think the first guess
is more likely)

Regards,
Clement

>
> Maxime

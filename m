Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3BC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF582076B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm3du3ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF582076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgDMHTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgDMHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:19:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E07DC008651;
        Mon, 13 Apr 2020 00:19:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so3718287qtr.7;
        Mon, 13 Apr 2020 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2nT3Va3E4vwilp1Fdp7ARRfOyF9O8UdBycnmN+9Xhsw=;
        b=Lm3du3ZNa8HvaBi6XryhBn8zFP8p7bnaPyDhrcxfNIvLvG0xa9ym0IHVYBQ/nv9i9R
         sayue0wrNelJykTg46+IjgbVRRHGLYy7MZ6Lc0xIeBoLYkv5gtnJZXaDFqTWw0RZzYAl
         d9d0fz9wc5Fx2L+T6rvAWERt7aUZ4w8U+UXjORxiMrtg6Vps8Z93DdGOv9qIGL3LYGMQ
         vjInJ5kMEmKYQfraZHjLv6FpJ0LYJzSJYpJRnhzsCcCaaop1hAG98Uq7m1vU/LImOmDi
         eiLqXAV1rFX/qITBUBI3RwJIdPorIsc7k32KSrLj8kuzqJDfkJuSRClis03CI5UhSnEg
         UJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2nT3Va3E4vwilp1Fdp7ARRfOyF9O8UdBycnmN+9Xhsw=;
        b=X00MONC6kSEwcSUJtQhskjVo8K6S662WDhUd0XE2B07eC5+/wLL8hz0fAGSDti3dR4
         /iHMq3sg6iMpMs0KLPso+BbaoFOfhd68vf8zNXYmepnP7o40YD2tQYKcEgf6DqVqyr3z
         px5HNFHvlRxZ4U3ywzzs3/nVzhQvVgpxGtg68+vcPuWucLOUyYbO0HvbaNHNCIl9ADKG
         psXKF/LLLbWk5kptX3kxA4xltfiyvpuUsKAYJnckGuIfZldYPu/o8CKlSAe6QHEyXu6/
         5+NOdp3IOKvIeWvLihYXLk0PVbsz1TqM0eUvdhDA4TuWHpUKfx/mXrfbXJLEO6qmRvbd
         pamQ==
X-Gm-Message-State: AGi0PuackcR23og4P0CA4RwzKWsRaQT9eShJ1smcOCgwNkYd+3Rgcfw6
        8DC0b4cCwswA8mLdBa/u5hxhSSYYJtnsphi9d7I=
X-Google-Smtp-Source: APiQypLiZzOmvvNbZthlcuAk+7DNZ/bAtcOVLzBOGnKD29q18014aTMKUIxT6RpYFvwJHP1TcCDBEfyHYQ62HhVJz7M=
X-Received: by 2002:ac8:22ad:: with SMTP id f42mr9986167qta.292.1586762359717;
 Mon, 13 Apr 2020 00:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585726761.git.shengjiu.wang@nxp.com> <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
 <20200406234819.GB20945@Asurada-Nvidia.nvidia.com> <CAA+D8AM69bhorQKikQGwwFRqgBYN8V2pXBW5JLZyFCVHWKkNGg@mail.gmail.com>
 <20200412020814.GA5984@Asurada> <CAA+D8AOapHbw_AREcJmef2tnM4aNiU11FLacW3HS7CXQThs80Q@mail.gmail.com>
 <20200413043143.GA9116@Asurada>
In-Reply-To: <20200413043143.GA9116@Asurada>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 13 Apr 2020 15:19:08 +0800
Message-ID: <CAA+D8ANUDAfLVJ6NQvtHSV27G4RUoQYEnA3Ym0wH28YCA6bZMg@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] ASoC: fsl_asrc: Move common definition to fsl_asrc_common
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:31 PM Nicolin Chen <nicoleotsuka@gmail.com> wrot=
e:
>
> On Mon, Apr 13, 2020 at 11:16:31AM +0800, Shengjiu Wang wrote:
> > On Sun, Apr 12, 2020 at 10:08 AM Nicolin Chen <nicoleotsuka@gmail.com> =
wrote:
> > >
> > > On Sat, Apr 11, 2020 at 01:49:43PM +0800, Shengjiu Wang wrote:
> > >
> > > > > > diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_a=
src_dma.c
> > > > > > index b15946e03380..5cf0468ce6e3 100644
> > > > > > --- a/sound/soc/fsl/fsl_asrc_dma.c
> > > > > > +++ b/sound/soc/fsl/fsl_asrc_dma.c
> > > > >
> > > > > > @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct sn=
d_soc_component *component,
> > > > > >               return ret;
> > > > > >       }
> > > > > >
> > > > > > -     pair =3D kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL=
);
> > > > > > +     pair =3D kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIV=
AT_SIZE, GFP_KERNEL);
> > > > >
> > > > > If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
> > > > > define in this file too, rather than in the header file.
> > > > >
> > > > > And could fit 80 characters:
> > > > >
> > > > > +       pair =3D kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KE=
RNEL);
> > >
> > > > I will use a function pointer
> > > >     int (*get_pair_priv_size)(void)
> > >
> > > Since it's the size of pair or cts structure, could be just a
> > > size_t variable?
> >
> > Yes, should be "size_t (*get_pair_priv_size)(void)"
>
> Does it have to be a function? -- how about this:
>
> struct pair {
>         ...
>         size_t private_size;
>         void *private;
> };
>
> probe/or-somewhere() {
>         ...
>         pair->private =3D pair_priv;

we need to know the size of pair_priv before allocate memory.

>         pair->private_size =3D sizeof(*pair_priv);
>         ...
> }

In fsl_asrc_dma_startup, we need to allocate memory for pair and
pair->private=EF=BC=8Cbut we don't know the object, so we don't know the
size of private, so function pointer is better.

best regards
wang shengjiu

Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C74C2BB85
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:16:46 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E20206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 03:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN69rysV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E20206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgDMDQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 23:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbgDMDQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:16:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3FBC0A3BE0;
        Sun, 12 Apr 2020 20:16:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s63so4092969qke.4;
        Sun, 12 Apr 2020 20:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8E/j11TZfH7UZNApZvH4fEyzZjBApgpFuNvhfzAcUS4=;
        b=rN69rysVCPRtDzu9ocDB8luGscQ5EDAzFC2HUPBZoBmnadjkGd12CRKaUx5KCEmflo
         EjTtB+OZ2lBX7RZXRvyzxIqvKtDx/jgPV82ukKk4l3qRTVFmtWCScuIAIcWvHi+zUDww
         Cr7BAtYsbLMGPjM0IFFZx87NZcQUYIBsEaRTJDmxyRFWGIvQVX6iAisWS93MSXj07hrA
         FB3kyYhKxDxDChLwsHTilLFCicvIZSSBv1ehw6yEG2MMLACgwMJp58iqUHb7TfI55Qa4
         BVMIvw8KomziBHrkvm29KOnA7a6RWsgHHxhSdNWqrbO+XAg9rtixBd9DVRkw73jbvwkJ
         7/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8E/j11TZfH7UZNApZvH4fEyzZjBApgpFuNvhfzAcUS4=;
        b=Y1TvHYcwQFzq8Cui3L+JsfW5EjaBijLupYOfNVzKTy4pVYXldSFyzM6lHucKlwKjDm
         tIMwRMLtun/gYVC9fZPsmKfkllPWVoimXYJW5wb4QjQInoP0cptwct2qurcRaUavLFc6
         O0xcp8KPd/+g5lIUcnKaIL3WGDotO2GI/LbumlSiIqZa6eQN5sVB/gCE64MO4LlS53ll
         PI79B2mW/NYX/Qh6UgJ8IonCBGC67zGjaCHMNdlqMKOGph6GmLyh5lXH9UG8ckBf0+rh
         VreVF2+zMW+wqkUil7+DWm0eZiVeTX9q3O82bQu7fGDGMAt6u/EfG+4Aqug9t/Uwny2C
         cBNw==
X-Gm-Message-State: AGi0PuZj9U52AQGsPJPws3NsVd7pHnNNU/6PMb/u26+pie5iNC33krEI
        jcUGd789n2w9S8icBGr4NUZw/T3UQ4Gfa5asbOY=
X-Google-Smtp-Source: APiQypItGHPXPnsy1S/7ewXviLIp7ovweo1JzQvp+pRla6x2SM0Xc5ae+Mid29m10MeNtKBNayczigkmHxXihCVcmM0=
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr14522999qkb.121.1586747802796;
 Sun, 12 Apr 2020 20:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585726761.git.shengjiu.wang@nxp.com> <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
 <20200406234819.GB20945@Asurada-Nvidia.nvidia.com> <CAA+D8AM69bhorQKikQGwwFRqgBYN8V2pXBW5JLZyFCVHWKkNGg@mail.gmail.com>
 <20200412020814.GA5984@Asurada>
In-Reply-To: <20200412020814.GA5984@Asurada>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 13 Apr 2020 11:16:31 +0800
Message-ID: <CAA+D8AOapHbw_AREcJmef2tnM4aNiU11FLacW3HS7CXQThs80Q@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:08 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sat, Apr 11, 2020 at 01:49:43PM +0800, Shengjiu Wang wrote:
>
> > > > diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> > > > index b15946e03380..5cf0468ce6e3 100644
> > > > --- a/sound/soc/fsl/fsl_asrc_dma.c
> > > > +++ b/sound/soc/fsl/fsl_asrc_dma.c
> > >
> > > > @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
> > > >               return ret;
> > > >       }
> > > >
> > > > -     pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> > > > +     pair = kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
> > >
> > > If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
> > > define in this file too, rather than in the header file.
> > >
> > > And could fit 80 characters:
> > >
> > > +       pair = kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
>
> > I will use a function pointer
> >     int (*get_pair_priv_size)(void)
>
> Since it's the size of pair or cts structure, could be just a
> size_t variable?

Yes, should be "size_t (*get_pair_priv_size)(void)"

best regards
wang shengjiu

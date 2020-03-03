Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC2C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15A820842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2hhA1DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgCCHiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:38:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:38:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id o24so1013979pfp.13;
        Mon, 02 Mar 2020 23:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lp++SjSydgt9rFdJFF3CB/lDlkmkywlwzPGaMF0zRlA=;
        b=N2hhA1DHJRr48b03MdRwK7wZT+y/IIbu0elhvz7gKyVzfWBwfAl0mdXhHechKW3w5h
         wBxpbplnqcGuRCe2aCyqhLZ2wpo+o2zcRsqCG1KdGYHdSJxY32PohGGlo4aMczuoJHna
         CMWMl9Exwvu57I8hyLPt/3Q4RBQTH5w67lBRMPCFvGriXxlrcvaH322RGt4kpMoBHUxh
         3E4JEzdChP8g3QMeRMTmn351CirQyx390iw1AbTyvsytm9dZSNigQYXyPmQAa74sAYIC
         Pj+UjOdxqIfBRBpzjWssycX5jwrJViK8MAIoJf3vZquhGT10/uKK0BZsNZxEY15fRJdw
         35Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lp++SjSydgt9rFdJFF3CB/lDlkmkywlwzPGaMF0zRlA=;
        b=GrxvhCUgqmbfu92ZHnn3Uhi0H8/0NLyGayk+Grwljm0TAlkMYMnDi85iJpM6Sw2ZLu
         T9rZYu9gmrd1EzervZA0Bg4fgGVpIEIMn2Tq3mqVUVguWPJzUJjVD/Xt4Ll6ZcKsTPrm
         0RxWjBNcBkSVNkBAc1j562QIK78E5WfFiptxsTkcrjRvCKUqgGUxnaCefB4YgdX9VZe9
         RzwyYm1hMGHYFYIuLbBU2tLuiB/5MJ69QJN5Q2z9u12pP4YY/5eBFd0XNtspkCapGQ6J
         Ax+qW0S+hJFagAkh+7JFQ/k+fMVkoxJpETmMLbo0EKHQ9TopbsZ710wBflM7HHqGPbu/
         yR9A==
X-Gm-Message-State: ANhLgQ1wU/99vVINgFmqAuFhn3iCYq0LA3TS4ED/8oQlChE7Nrp/2RL6
        a6b5qDfGmYvUouStd6Oigo4=
X-Google-Smtp-Source: ADFU+vvzwWp+30x2055lNCAa+QhYWY8R2yyZZoSUjWYJZln5Koehw7RijTiQ1fkyuH3SDxsLzC7qTQ==
X-Received: by 2002:aa7:8582:: with SMTP id w2mr2820931pfn.89.1583221088207;
        Mon, 02 Mar 2020 23:38:08 -0800 (PST)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id p94sm1516093pjp.15.2020.03.02.23.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 23:38:07 -0800 (PST)
Date:   Mon, 2 Mar 2020 23:37:46 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to
 asrc-format
Message-ID: <20200303073745.GA2868@Asurada>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
 <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
 <20200303014133.GA24596@bogus>
 <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:59:30AM +0800, Shengjiu Wang wrote:
> Hi
> 
> On Tue, Mar 3, 2020 at 9:43 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Mar 01, 2020 at 01:24:12PM +0800, Shengjiu Wang wrote:
> > > asrc_format is more inteligent, which is align with the alsa
> > > definition snd_pcm_format_t, we don't need to convert it to
> > > format in driver, and it can distinguish S24_LE & S24_3LE.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > index cb9a25165503..0cbb86c026d5 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > > @@ -38,7 +38,9 @@ Required properties:
> > >
> > >     - fsl,asrc-rate   : Defines a mutual sample rate used by DPCM Back Ends.
> > >
> > > -   - fsl,asrc-width  : Defines a mutual sample width used by DPCM Back Ends.
> > > +   - fsl,asrc-format : Defines a mutual sample format used by DPCM Back
> > > +                       Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> > > +                       "include/uapi/sound/asound.h"
> >
> > You can't just change properties. They are an ABI.
> 
> I have updated all the things related with this ABI in this patch series.
> What else should I do?

You probably should add one beside the old one. And all
the existing drivers would have to continue to support
"fsl,asrc-width", even if they start to support the new
"fsl,asrc-format". The ground rule here is that a newer
kernel should be able to work with an old DTB, IIRC.

One more concern here is about the format value. Though
I don't think those values, defined in asound.h, would
be changed, yet I am not sure if it's legit to align DT
bindings to a subsystem header file -- I only know that
usually we keep shared macros under include/dt-bindings
folder. I won't have any problem, if either Rob or Mark
has no objection.

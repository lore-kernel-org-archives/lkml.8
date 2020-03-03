Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDABC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDB420866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRT8HZ4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCCD7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:59:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33656 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgCCD7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:59:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id d22so490518qtn.0;
        Mon, 02 Mar 2020 19:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvgiEL+QVxL1O0iuln0ifrtO9JeYp774TkUNa+6Pqoo=;
        b=oRT8HZ4B32/7utrig5nxukRcBp2kXL+RB7l6+X9X21Z/lE1ng0lir/2XnCN4MCNCL/
         JCs+4EUTPXdEdohoncGhgZqyiZqG5StxthdVvUsRlip4ttwbFnATHlA+0ivVzJ98ojAQ
         etVMYVwNN7kp/A+P/eYeqexBN4sWYR0yfSxguyzTQG1EhWJdw4iRlCK7sIud2Lthti89
         Zuo/HkGECwJlpBAV4fXexo/XYscKNWFwieSqQ49/DIMqu7XmrjH3AMeI6QVVDMguhKKz
         71NuaFosTdSaKOq6pav7EEC9eGWRitBjA0RGj7UMjPCGezvoauU4Wy4VAvwjAe5K/rs2
         NUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvgiEL+QVxL1O0iuln0ifrtO9JeYp774TkUNa+6Pqoo=;
        b=NjywlriaJTPixsPqLAZkLg32cuVK4C938HZcq2Yx0z4vRwEeZ+ROUnpUsKH8CnqsA+
         /6/BjtBoqsvjaMckHGdwCcsMJBHBvWu4zP4tX6WxAbqHMCCbWzoR4xYhWjqRUbKOGsDu
         yAZbp7OZkM1G3i3YhOSuQA2n5iXhggvnlfYFzimatgyR0uyKLpPF6VmVnL+RfQpVGO5m
         3JgGRXGRniEV0M2ZkgwZHEFqmY6SwLXVixZYD84k3gO08bVEfds3Hb6USoSfnuN87h1t
         t9Hf9tj1nAJnFKORcpulNQbVj+0SoVqoIPYRIH5ok5x/ooAXrNfwCg9SjO2HJvy03i9h
         04og==
X-Gm-Message-State: ANhLgQ39703IjgjgfjcoSmixIfUiiixul9WfT/GyZXYqpZIuv793GF9P
        eBUuNbB2zOoP94Z5Of47g6MsTx3NGHNqRM8/Wa0=
X-Google-Smtp-Source: ADFU+vv2FItiQhj89T5uuRfiab6WkfDHcosumKkrglL71peu+YE/jk0AhS8fXeo7PG4qPrc7PTpI+QkNhWhZ/+gdSNI=
X-Received: by 2002:ac8:518a:: with SMTP id c10mr2808979qtn.360.1583207982044;
 Mon, 02 Mar 2020 19:59:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583039752.git.shengjiu.wang@nxp.com> <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
 <20200303014133.GA24596@bogus>
In-Reply-To: <20200303014133.GA24596@bogus>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 3 Mar 2020 11:59:30 +0800
Message-ID: <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to asrc-format
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
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
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Mar 3, 2020 at 9:43 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Mar 01, 2020 at 01:24:12PM +0800, Shengjiu Wang wrote:
> > asrc_format is more inteligent, which is align with the alsa
> > definition snd_pcm_format_t, we don't need to convert it to
> > format in driver, and it can distinguish S24_LE & S24_3LE.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > index cb9a25165503..0cbb86c026d5 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > @@ -38,7 +38,9 @@ Required properties:
> >
> >     - fsl,asrc-rate   : Defines a mutual sample rate used by DPCM Back Ends.
> >
> > -   - fsl,asrc-width  : Defines a mutual sample width used by DPCM Back Ends.
> > +   - fsl,asrc-format : Defines a mutual sample format used by DPCM Back
> > +                       Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> > +                       "include/uapi/sound/asound.h"
>
> You can't just change properties. They are an ABI.

I have updated all the things related with this ABI in this patch series.
What else should I do?

Best regards
Wang Shengjiu

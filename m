Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48CDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC294206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjSAOZwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCMB6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:58:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37244 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCMB6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:58:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id l20so6287329qtp.4;
        Thu, 12 Mar 2020 18:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88CKdz/NKjVak04/lN/5uD3uM5mQKrmtijz9vSkeFgg=;
        b=pjSAOZwt9ryPLjEr9Hn+KApbAgGbTkRLnUUH65gnKwCdCkYwq6qZSG+nWJ2u4BqHK0
         tY7/ToQXdluH6nYEh0LlaNONnotFWYeWQs7ksBcJwWZSMbZAKiWOCD/mpDmNLmNx73Zs
         gCrn6ASGGxo23xeiOF+49pKCeuxy0UG9CtM2APILEqad5ipMKu2R/gDgkETqpzZY0S9l
         KsgrTyJW49G/BOUCKMgudmmuBywylqv8Xu4EXoXh0YXqE5BxR3lmju3MMUSBinST6SAC
         uYWe7YaaLMmgtI9jRzkTANe0kcvacI7UN5ylAZgsiCvqfGuyG00pqVMrO+S0hdF49UYM
         RSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88CKdz/NKjVak04/lN/5uD3uM5mQKrmtijz9vSkeFgg=;
        b=udlrYVGVyAHLu67RuvmwUjZvJeN4PzC1q2oa114gKwLMZNDRE4QIJqCTWctMwHmDoR
         wc6u4afJkd2aMQ+BcG0pvzGBJSZWFaqbBSN3L06VXhJD+KZoxVqCbEYSOub7JctnSplT
         lHOgOrWt0yRnDro8swQ12ocN7aXdr00L3/a0wIXSlLxsdh4zjHElsTCOFdiG9t5mMQgT
         TKiiQfXnjWkRlAXpjlRYZq9DLJ/vu6qoibTqBSk2CEsF2HxnOoq86nKtbekE0JQXcwld
         KZvtazrmSDZY9MDLTMcCIR1PVNOhAMUHoIh8Y2rdlFhi/1jJOUAIYm7zqVQ8ufRYoZ0q
         tzuw==
X-Gm-Message-State: ANhLgQ03DQsh6lNzIa9OdbLEz/OXtHri+2T4KY7XTzaANq/Xurr0JXir
        s/xbKvtoM8+px1dtX3QdAhfLKO/tuPhq6HZ5QavsGQ==
X-Google-Smtp-Source: ADFU+vvK5+cSY2SJjGHWhKW0xQKWTvae4atVpKpb9h+cuGuLEZkISiyaRiiGVQ5/eNNFTISVK0wd8Lq7pxHaHGITVPM=
X-Received: by 2002:ac8:5298:: with SMTP id s24mr10110299qtn.54.1584064696061;
 Thu, 12 Mar 2020 18:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583725533.git.shengjiu.wang@nxp.com> <24f69c50925b93afd7a706bd888ee25d27247c78.1583725533.git.shengjiu.wang@nxp.com>
 <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20200309211943.GB11333@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 13 Mar 2020 09:58:05 +0800
Message-ID: <CAA+D8ANwQ_orAxtVCxsAOJ8b2bRxM9myD+N8Ce7okNZK7q9g9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Tue, Mar 10, 2020 at 5:20 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Mar 09, 2020 at 11:58:28AM +0800, Shengjiu Wang wrote:
> > In order to support new EASRC and simplify the code structure,
> > We decide to share the common structure between them. This bring
> > a problem that EASRC accept format directly from devicetree, but
> > ASRC accept width from devicetree.
> >
> > In order to align with new ESARC, we add new property fsl,asrc-format.
> > The fsl,asrc-format can replace the fsl,asrc-width, then driver
> > can accept format from devicetree, don't need to convert it to
> > format through width.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > index cb9a25165503..780455cf7f71 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > @@ -51,6 +51,11 @@ Optional properties:
> >                         will be in use as default. Otherwise, the big endian
> >                         mode will be in use for all the device registers.
> >
> > +   - fsl,asrc-format : Defines a mutual sample format used by DPCM Back
> > +                       Ends, which can replace the fsl,asrc-width.
> > +                       The value is SNDRV_PCM_FORMAT_S16_LE, or
> > +                       SNDRV_PCM_FORMAT_S24_LE
>
> I am still holding the concern at the DT binding of this format,
> as it uses values from ASoC header file instead of a dt-binding
> header file -- not sure if we can do this. Let's wait for Rob's
> comments.

Could you please share your comments or proposal about
Nicolin's concern?

best regards
wang shengjiu

Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D4EC2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11C820CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5aneZKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDKFt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:49:57 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38361 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKFt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:49:57 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so1942754qva.5;
        Fri, 10 Apr 2020 22:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJrtFPh2k7Ocn2F2h4jgSLlpNWoMCuHTn40DR2631os=;
        b=q5aneZKKA78xQ6o1kJ1rScGZMZivPxz9JT4IiA4AblcWrlcRjvjh6cpnmwnS62vv1T
         bEbtqMxoHQvxkLa8HHlRwa3jMgYPeNd/k/3r9FuIGLgF0li7N2q7/0bUM8SSWLn3NE1U
         Sh9VJhTkn84Wrr87C5rn69nla076gFroH9YBa/4+skYdmR+O380EnUnRCbREX4jQKHiO
         0NXSGQXZv5jP6nMOdq3WowIdE0WqqKGcY5OOGEMtgqcYVBklvd2oZ19bMWyt+TdLtNg9
         XZQbPs3z2fUy1Z+BidU3rnDt+GzWSSMIddxLw8EkUI9Exn9cRvtHi2azMDuvotyBa/Bk
         mkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJrtFPh2k7Ocn2F2h4jgSLlpNWoMCuHTn40DR2631os=;
        b=aZ/dL+TlZ2j8z5Kuj36/d/nK9k08Sqi4LZ6E0XwYPSNKxt2GznuDCM8jxNDgWzQyU1
         ceTlv1GrliIaL24tObtycE5bcmhhW+z7TZp0uyq8t9h8RjEoHEYPnnxV4p0DbwK9KcNX
         obPx9wAQ8NlizBX4z3QwwtcAb2xYHBn0wNoVeBG1us1WGARxfP9iOWTet93HxCUkVGPv
         BaCHETHVyPv8GMsVapBHmQswkwwd7s7Mw9iGqh90N7TUYaYCsOhQAjIFe3Wz9EZOFHtR
         1NcKUjCiRqpWLWFVPuyzaesGU/X7EpcewfqhGg3uC1cEVCFdTmvyNCRSy27S6FMvion3
         Be/A==
X-Gm-Message-State: AGi0PuY1AFeuc7EU5UCw6geDZOmMT9CEeePRJsuJeg53+nws1PRcf7wq
        HIx19U3lesGefo6+G9EBQc0fN9QyQddTv8XEyUl+wGMKf8A=
X-Google-Smtp-Source: APiQypJ+BVKiXkyfqlXZ3G20bGDwTrRdeBK+2RCyToQfCR2IikaFnt/ESyQeRXUJ6JCeNWMvUq6ai+h+x7+pUzlEZaM=
X-Received: by 2002:ad4:4665:: with SMTP id z5mr8411234qvv.32.1586584194833;
 Fri, 10 Apr 2020 22:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585726761.git.shengjiu.wang@nxp.com> <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
 <20200406234819.GB20945@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20200406234819.GB20945@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sat, 11 Apr 2020 13:49:43 +0800
Message-ID: <CAA+D8AM69bhorQKikQGwwFRqgBYN8V2pXBW5JLZyFCVHWKkNGg@mail.gmail.com>
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

Hi

On Tue, Apr 7, 2020 at 7:50 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Apr 01, 2020 at 04:45:38PM +0800, Shengjiu Wang wrote:
>
> >  static int fsl_asrc_probe(struct platform_device *pdev)
> >  {
> >       struct device_node *np = pdev->dev.of_node;
> >       struct fsl_asrc *asrc;
> > +     struct fsl_asrc_priv *asrc_priv;
>
> Could we move it before "struct fsl_asrc *asrc;"?
>
> > diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
> > new file mode 100644
> > index 000000000000..5c93ccdfc30a
> > --- /dev/null
> > +++ b/sound/soc/fsl/fsl_asrc_common.h
>
> > +#define PAIR_CTX_NUM  0x4
> > +#define PAIR_PRIVAT_SIZE 0x400
>
> "PRIVAT_" => "PRIVATE_"
>
> > +/**
> > + * fsl_asrc_pair: ASRC common data
>
> "fsl_asrc_pair" => "fsl_asrc"
>
> > + */
> > +struct fsl_asrc {
>
> > diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> > index b15946e03380..5cf0468ce6e3 100644
> > --- a/sound/soc/fsl/fsl_asrc_dma.c
> > +++ b/sound/soc/fsl/fsl_asrc_dma.c
>
> > @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
> >               return ret;
> >       }
> >
> > -     pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> > +     pair = kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
>
> If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
> define in this file too, rather than in the header file.
>
> And could fit 80 characters:
>
> +       pair = kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);

I will use a function pointer
    int (*get_pair_priv_size)(void)
to avoid definition of  PAIR_PRIVATE_SIZE. which is not safe.

best regards
wang shengjiu

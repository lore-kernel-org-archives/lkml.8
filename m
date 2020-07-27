Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF112C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0C220714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb9XUO9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0Gdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0Gdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:33:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C92C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:33:30 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so11408744qtm.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w03YsC20p+dHNFM0U+uQthrGb6bTfy1HNpPAv/xPssM=;
        b=fb9XUO9zYs7ABnO/X0liXVU0exs845LVf7rzCAGArl4oIBDv6nRZMmTaLM/ad3gxfr
         WxjqZ69tAQlIm5FmiqeZkuPVAJfSDEV+FMiAAuvtJpUM2aAR0g/g/pCReUQikOfSIfUn
         Yonte7RtlVRG7RLZAJgn6vi89u2VC+MUH19PQZUD1dafIYgRzOMpC9pxj0z93j2BgFqA
         B26cuaNWywhMWJTYlfEdX57GNU//HWAZ3MbixzXamt96ER2zJiMBXpKweR2PC6xyepYh
         wI0Jf7tQG79YfUoegG5+Lwp3huwydPO2HasvcGqsiOVgIEsYpumF/InSmusZXpeawmM7
         ZSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w03YsC20p+dHNFM0U+uQthrGb6bTfy1HNpPAv/xPssM=;
        b=fdwj7/2DCP3wFQL/tzUQz286MLhIoT6+2KrW9I11jlJGl0+mGyBo5tAfPn8BFJqyor
         9oqhaPEg8e8scdz8DTVnkkkilbAGjcAW4jMQG/rUOQt2xB394QZDiLM27355lEc/55PV
         B3vqIgoMI1Va1j1A9RDFRh5zvGVtLFe37ToYnH5yiCOEtF3SrsB6lPLQfP5oQrtVln7E
         MOVD1Z/JHfRrwnHT80C6DSfpWo0roPtxjA5QYbnQ3gKF3D52CIxNcwxUY+ifAHheuXX0
         8Mga7ZWeiNDzMlD3BXKbjLGNfXA1BeZosQWeVdgZXzIBvQaNSicRtgSm+iEkjgH+EimU
         QXKQ==
X-Gm-Message-State: AOAM532uhNpOOaKKCFXTQv+9zEnfzlspBF69xF52PJRJU7tTE4PFfgek
        zpDRaWZGoqL5MpkIL7xpWRFn+CyVh+E3BpuqQnc=
X-Google-Smtp-Source: ABdhPJxAach4+q/kZpihLnqh0Vmpd7JeL6MA+Nyc9iccYws64hNeTYJWYJ30qASwfI5ZNQ2LrtckCQGMba3t1dGXCXI=
X-Received: by 2002:aed:2946:: with SMTP id s64mr442181qtd.204.1595831609481;
 Sun, 26 Jul 2020 23:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <1595762417-2190-1-git-send-email-shengjiu.wang@nxp.com> <20200727005558.GA30124@Asurada-Nvidia>
In-Reply-To: <20200727005558.GA30124@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 27 Jul 2020 14:33:18 +0800
Message-ID: <CAA+D8AOfh1gDec=0BPk6SUutqtY_gL1Rm1-Uc4Dv4s-86LAwPA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level function
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
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

On Mon, Jul 27, 2020 at 8:58 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Jul 26, 2020 at 07:20:17PM +0800, Shengjiu Wang wrote:
> > With this case:
> > aplay -Dhw:x 16khz.wav 24khz.wav
> > There is sound distortion for 24khz.wav. The reason is that setting
> > PLL of WM8962 with set_bias_level function, the bias level is not
> > changed when 24khz.wav is played, then the PLL won't be reset, the
> > clock is not correct, so distortion happens.
> >
> > The resolution of this issue is to remove fsl_asoc_card_set_bias_level.
> > Move PLL configuration to hw_params and hw_free.
>
> Hmm...using set_bias_level() instead of hw_params/hw_free() was
> strongly suggested by Mark when I got imx-wm8962 machine driver
> upstream. So we will need his input here, although I personally
> don't have a problem with it...
>
> > After removing fsl_asoc_card_set_bias_level, also test WM8960 case,
> > it can work.
> >
> > Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl-asoc-card.c | 149 +++++++++++++++-------------------
> >  1 file changed, 66 insertions(+), 83 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> > index 4848ba61d083..0517dbb3e908 100644
> > --- a/sound/soc/fsl/fsl-asoc-card.c
> > +++ b/sound/soc/fsl/fsl-asoc-card.c
> > @@ -73,6 +73,7 @@ struct cpu_priv {
> >   * @codec_priv: CODEC private data
> >   * @cpu_priv: CPU private data
> >   * @card: ASoC card structure
> > + * @is_stream_in_use: flags for release resource in hw_free
>
> Would love to see something shorter... Could we reuse similar
> one below, borrowing from fsl_ssi driver?
>
>  * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
>
> >  static int fsl_asoc_card_audmux_init(struct device_node *np,
> >                                    struct fsl_asoc_card_priv *priv)
> >  {
> > @@ -611,7 +600,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> >       /* Diversify the card configurations */
> >       if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
> >               codec_dai_name = "cs42888";
> > -             priv->card.set_bias_level = NULL;
>
> Can check if set_bias_level is still being used with this change.

Do you mean to keep this line:
priv->card.set_bias_level = NULL; ?

best regards
wang shengjiu

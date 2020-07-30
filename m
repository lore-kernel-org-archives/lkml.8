Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E187C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC672082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXYQQMgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgG3HYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3HX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:23:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4463C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 00:23:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so19616517qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UONcGtH87E3a5kjHLIWiuODkuzooKxlCqVfEhVFntOs=;
        b=HXYQQMgfzlVEj3WUkqkBrSxkEmTJohgn7cWeafHTC4o/k0JKSoPBxzLQZWVlUdWtSb
         /nP2n5lgXaR5sD9xSWYxzj4aw05lcL0G8vj1vYgxB5qViOBgNbPKMdj7Jfg+/recddQE
         xCgbYFo3KRM/t5/hPKE5YXNb3NYWa4OVLfs+HJ2WWSOyU8m1y4rXbZLUUruYm0QY6pd3
         shQtNvR2f9mvm8rok3XR5Aoj2nzJaqEIYlSXhjZX4d2Tnz1pDr2AKkBwHAANzATN5iDs
         TQFsqc3+O/EmhKFxilWouZ5mFNL2M9Vcib5o7lGLIeDAP4uCBujIJXoJwzXkIGVd7ehd
         xl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UONcGtH87E3a5kjHLIWiuODkuzooKxlCqVfEhVFntOs=;
        b=iNYdTeWHoAl0dOj4OOb2pEXEsTx24COMLFGJPHBvs5YgNuvV+fRFVLPvy8AIr4gjj8
         U0q5rZuwNmscBRWX1Rh04sUxTwRYybnd7m6Z8cEiRuNzD4ZcrDpHcTKil4RtftdnVPR6
         2cxoxZUlOjONh7wytJ+71iojf+Y0vnHKUcybQxk6vSMLCQ6UlhfqEMtiPm6G3XA/4req
         oMne2FySTjPqZfG+BXOT1iIDrMhEmZtm2AxYvCag9VO/D1rtdgYiC/plJ6O4LwNhB3Zh
         cfDTmwYm6tOhTEhcBSvwi/2YttMnYJrABYiFlpsR8lNULotJaOGUg1lQs/CGdY084F0X
         UsdA==
X-Gm-Message-State: AOAM532SncqLH8NkucT0wSWGgO0msqGBjWObsv8Epm5UPPS+uAhCAhTr
        9ZbGlBV+FIvTq3qePXTMNjbsaXgJA40l9iBY9iE=
X-Google-Smtp-Source: ABdhPJwyTxUPfHh/W6tv9g29pHFtPJF1Ko5E5uzGhYAwkdfNZ3VBu0oUQIo+AE2x1GxX7qRobBU900hB2OKzukb53L4=
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr1543191qtt.121.1596093838176;
 Thu, 30 Jul 2020 00:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <1595762417-2190-1-git-send-email-shengjiu.wang@nxp.com> <20200727005558.GA30124@Asurada-Nvidia>
In-Reply-To: <20200727005558.GA30124@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 30 Jul 2020 15:23:47 +0800
Message-ID: <CAA+D8AMiarV+FovE8ZTTe8zagSz8-XDcck7Z4W2TfbOvzgrLpw@mail.gmail.com>
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

will send v2 for this change.

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

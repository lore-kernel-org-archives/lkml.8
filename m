Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2642071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmZ8Vunc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgEYGLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgEYGLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:11:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF20C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:11:46 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c185so2554443qke.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zE6QF3wBuG+bbFky4XNH1ls+bDYS3myqBI0CKs9XLgY=;
        b=gmZ8VuncLIfL+xQ1uVR/HNEXvNFmcIL7W5Uce9o/Ajf7J1PDFBxeCDlCWbnUpHE6ew
         puJM4g0cpV7xMRSGDzwlLFFr5698CMId+R2S2OAHxbid2eP9t36+yRSdrVhVV8snbrxd
         6rsVpBMPe71+h9AvFol2x+TtVwUSlkSzXspe5p+Z/Hu45Wbl0bLDcp/UnIKo3WJC6lkj
         9ku4sr5N4poBK1P76/+PeROWEIRrwOAZCh59hVy/dGSJKfucj/zaU28pOZIwYfDI9w4P
         oxQB6iRYVc+ONa7iQkF5QlPsVXJ4N14h1uyhvh4HkDuA5La1uzSRNtP7DQZM9lno5YQs
         YYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zE6QF3wBuG+bbFky4XNH1ls+bDYS3myqBI0CKs9XLgY=;
        b=Tv5ad5/VkgENlQWl7IsSNDZmgwc2q5CMXA6SDCpjYUXYAySOhdK5KilaHmEa8T/qWi
         P6SiJD/68XItOfaePGHPL0KLHakA2uiku2ta04elYCqHPbUhjVH1Z0YJgi1Uw/Ye9bjp
         uqMOQCr1bBYBIsbglmte0FAy9Rhbaz8XwoaJ9EpugkDE2ivUBN/SU85jLtUYwKkMIh5K
         Q13fAhXUqgsgZnZw6u8tJZfeOkCezcF83YV6RsV11BRlKnScBH8sMndX5DvXI7zCt1Aa
         GPB1DCzqw+ODw/aKLk3/ttTp1BAMYzWC1dqmPXEZHrhMSaLzi4ue59LyXoh5OM+YIXRW
         xl3g==
X-Gm-Message-State: AOAM5334Yl/auyMJGZ9jVLSG0sk1IHTm2G+T6c7TvcoHMrQz5S1nfHeA
        0KTZB3aOdODz+pacU/7jwB3p0B1QxAwYhqFQp+g=
X-Google-Smtp-Source: ABdhPJydMBgq/Pjn4/khBBaHIGx05CEfpOqguypnLj9qdpyApo26fr/GyQlog+GyRmcHhBgT4Rg6CgKdiB76ee7lE7c=
X-Received: by 2002:a37:b50:: with SMTP id 77mr22555339qkl.152.1590387105305;
 Sun, 24 May 2020 23:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com> <20200525050950.GA1244@Asurada>
In-Reply-To: <20200525050950.GA1244@Asurada>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 25 May 2020 14:11:18 +0800
Message-ID: <CAA+D8AML7P3j+14w5PywPy4QEcxw09z1izZSZbrOB_nte+XDmA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Merge suspend/resume function to runtime_suspend/resume
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

On Mon, May 25, 2020 at 1:12 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 05:57:24PM +0800, Shengjiu Wang wrote:
> > With dedicated power domain for asrc, power can be disabled after
> > probe and pm runtime suspend, then the value of all registers need to
> > be restored in pm runtime resume. So we can merge suspend/resume function
> > to runtime_suspend/resume function and enable regcache only in end of
> > probe.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 70 ++++++++++++++++------------------------
> >  1 file changed, 27 insertions(+), 43 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > index 432936039de4..3ebbe15ac378 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -1100,6 +1100,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
> >       platform_set_drvdata(pdev, asrc);
> >       pm_runtime_enable(&pdev->dev);
> >       spin_lock_init(&asrc->lock);
> > +     regcache_cache_only(asrc->regmap, true);
> >
> >       ret = devm_snd_soc_register_component(&pdev->dev, &fsl_asrc_component,
> >                                             &fsl_asrc_dai, 1);
> > @@ -1117,6 +1118,7 @@ static int fsl_asrc_runtime_resume(struct device *dev)
> >       struct fsl_asrc *asrc = dev_get_drvdata(dev);
> >       struct fsl_asrc_priv *asrc_priv = asrc->private;
> >       int i, ret;
> > +     u32 asrctr;
> >
> >       ret = clk_prepare_enable(asrc->mem_clk);
> >       if (ret)
> > @@ -1135,6 +1137,24 @@ static int fsl_asrc_runtime_resume(struct device *dev)
> >                       goto disable_asrck_clk;
> >       }
> >
> > +     /* Stop all pairs provisionally */
> > +     regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> > +     regmap_update_bits(asrc->regmap, REG_ASRCTR,
> > +                        ASRCTR_ASRCEi_ALL_MASK, 0);
> > +
> > +     /* Restore all registers */
> > +     regcache_cache_only(asrc->regmap, false);
> > +     regcache_mark_dirty(asrc->regmap);
>
>
> I see you doing regcache_mark_dirty() in the resume() now,
> being different from previously doing in suspend()?
>
> Thanks
> Nic

Which is for probe -> runtime_resume case.
After probe, the power may be disabled, so move mark_dirtry
to runtime_resume, then regcache can re-write all the registers.

best regards
wang shengjiu

>
>
> > +     regcache_sync(asrc->regmap);
> > +
> > +     regmap_update_bits(asrc->regmap, REG_ASRCFG,
> > +                        ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
> > +                        ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
> > +
> > +     /* Restart enabled pairs */
> > +     regmap_update_bits(asrc->regmap, REG_ASRCTR,
> > +                        ASRCTR_ASRCEi_ALL_MASK, asrctr);
> > +
> >       return 0;
> >
> >  disable_asrck_clk:
> > @@ -1155,6 +1175,11 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
> >       struct fsl_asrc_priv *asrc_priv = asrc->private;
> >       int i;
> >
> > +     regmap_read(asrc->regmap, REG_ASRCFG,
> > +                 &asrc_priv->regcache_cfg);
> > +
> > +     regcache_cache_only(asrc->regmap, true);
> > +
> >       for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
> >               clk_disable_unprepare(asrc_priv->asrck_clk[i]);
> >       if (!IS_ERR(asrc->spba_clk))
> > @@ -1166,51 +1191,10 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
> >  }
> >  #endif /* CONFIG_PM */
> >
> > -#ifdef CONFIG_PM_SLEEP
> > -static int fsl_asrc_suspend(struct device *dev)
> > -{
> > -     struct fsl_asrc *asrc = dev_get_drvdata(dev);
> > -     struct fsl_asrc_priv *asrc_priv = asrc->private;
> > -
> > -     regmap_read(asrc->regmap, REG_ASRCFG,
> > -                 &asrc_priv->regcache_cfg);
> > -
> > -     regcache_cache_only(asrc->regmap, true);
> > -     regcache_mark_dirty(asrc->regmap);
> > -
> > -     return 0;
> > -}
> > -
> > -static int fsl_asrc_resume(struct device *dev)
> > -{
> > -     struct fsl_asrc *asrc = dev_get_drvdata(dev);
> > -     struct fsl_asrc_priv *asrc_priv = asrc->private;
> > -     u32 asrctr;
> > -
> > -     /* Stop all pairs provisionally */
> > -     regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> > -     regmap_update_bits(asrc->regmap, REG_ASRCTR,
> > -                        ASRCTR_ASRCEi_ALL_MASK, 0);
> > -
> > -     /* Restore all registers */
> > -     regcache_cache_only(asrc->regmap, false);
> > -     regcache_sync(asrc->regmap);
> > -
> > -     regmap_update_bits(asrc->regmap, REG_ASRCFG,
> > -                        ASRCFG_NDPRi_ALL_MASK | ASRCFG_POSTMODi_ALL_MASK |
> > -                        ASRCFG_PREMODi_ALL_MASK, asrc_priv->regcache_cfg);
> > -
> > -     /* Restart enabled pairs */
> > -     regmap_update_bits(asrc->regmap, REG_ASRCTR,
> > -                        ASRCTR_ASRCEi_ALL_MASK, asrctr);
> > -
> > -     return 0;
> > -}
> > -#endif /* CONFIG_PM_SLEEP */
> > -
> >  static const struct dev_pm_ops fsl_asrc_pm = {
> >       SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
> > -     SET_SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
> > +     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +                             pm_runtime_force_resume)
> >  };
> >
> >  static const struct fsl_asrc_soc_data fsl_asrc_imx35_data = {
> > --
> > 2.21.0
> >

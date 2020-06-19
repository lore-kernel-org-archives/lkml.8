Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DBF2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MThCG9Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgFSHQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFSHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:16:08 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E613CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:16:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so6492408qtr.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcLqzNszUsRDe3jzmL6Kvi+SK8buR0iM6L0pJ0UQJfo=;
        b=MThCG9Jwd1aI1wlSrnihvC6cp3eKrh1rOv53tY8fvT3TtKvhO4+k+EFdPX6DnBxykT
         HIAUcdBak30KNoee1xQlVGjQw+hElyt19YBKvIplGecD/KWhj8ClCPXrtKXwLneEzPkG
         FX2YRtIycp9pDMfyTHJgBM5aXLXlxwmFiJy+p+G9rjP4s16pUfA8Ed7dtd9yN2DsSr65
         ajQr2uZOX1cSLXZrD31ZkfHZImQMfY35RGJ5SEJylICknu5fwuDtAcUp6VtIPDTgMuIT
         SdzZcm84vhjqCYCVAgG9traNzYrCUBJBeoTdbYa44zPvck6LQiRZDIa5uulw8dHVCqPb
         HDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcLqzNszUsRDe3jzmL6Kvi+SK8buR0iM6L0pJ0UQJfo=;
        b=XdAhl8dvIsCBkNlG4DPABF1j3SN+4LYPSdRANatnPwQmAXHrwUqo3wjyN+VXMRbyg8
         /3RZtBEL6dO226v7pAWVkoehRxF1QD9Kk0olGhrMyPp28RiFBk623GliBphnkl+c4OSM
         PqhlO8Srx24WCp/ovqV2sx5AMRVAzLe0eCqPDiifiLznE5zdj/8B5wrYg7oAYmK+u9vt
         Mf1vqgkTn+k3zoORFyX7Tar1f5za/Z0JzU9xftYVep9gQ4YKgvQIFeGcRA5vtCHe1R9e
         8emibLKucM3fvNqEvdiMcIWGdxHPZkh78tRdMd7GWPPrrQTb+EJw+yuiJzlNB5VZ4p1+
         HghA==
X-Gm-Message-State: AOAM533pb3Vlj8CGIZn1GmPCmNlfP6TC6ye2/IfQ0ySR2s+VO6SiM6dU
        tibckI+dynp/r2UkbXnHDB5wyuuHDC/+YHkXhU+6YQ==
X-Google-Smtp-Source: ABdhPJwbTdL1Xjyp+rNzK2cppzw1kNNdm5CIImL/5YBuAp+LbbOkOHM6SMPUmT6BhKjPwcHCp3aPi+cLdaaqcQP4Te0=
X-Received: by 2002:ac8:7417:: with SMTP id p23mr2043092qtq.204.1592550967172;
 Fri, 19 Jun 2020 00:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <1592481334-3680-1-git-send-email-shengjiu.wang@nxp.com> <20200619054942.GA25856@Asurada-Nvidia>
In-Reply-To: <20200619054942.GA25856@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 19 Jun 2020 15:15:56 +0800
Message-ID: <CAA+D8APdNAzLyJyf+-FGSyAJtG5_8BVZCJ1+8ALZe_ePySY+rQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add pm runtime function
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 1:51 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 07:55:34PM +0800, Shengjiu Wang wrote:
> > Add pm runtime support and move clock handling there.
> > Close the clocks at suspend to reduce the power consumption.
> >
> > fsl_spdif_suspend is replaced by pm_runtime_force_suspend.
> > fsl_spdif_resume is replaced by pm_runtime_force_resume.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> LGTM, yet some nits, please add my ack after fixing:
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> > @@ -495,25 +496,10 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
>
> >
> > -disable_txclk:
> > -     for (i--; i >= 0; i--)
> > -             clk_disable_unprepare(spdif_priv->txclk[i]);
> >  err:
> > -     if (!IS_ERR(spdif_priv->spbaclk))
> > -             clk_disable_unprepare(spdif_priv->spbaclk);
> > -err_spbaclk:
> > -     clk_disable_unprepare(spdif_priv->coreclk);
> > -
> >       return ret;
>
> Only "return ret;" remains now. We could clean the goto away.
>
> > -static int fsl_spdif_resume(struct device *dev)
> > +static int fsl_spdif_runtime_resume(struct device *dev)
>
> > +disable_rx_clk:
> > +     clk_disable_unprepare(spdif_priv->rxclk);
> > +disable_tx_clk:
> > +disable_spba_clk:
>
> Why have two duplicated ones? Could probably drop the 2nd one.

seems can drop one, will send an update.

best regards
wang shengjiu

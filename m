Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88180C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507E62072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqYN+vMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEULa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgEULa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:30:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A2C061A0E;
        Thu, 21 May 2020 04:30:27 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so6849383qkh.2;
        Thu, 21 May 2020 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mVnGuA/c41po031/Zyo9z05iki6LpXCl3bw26UlV5Og=;
        b=MqYN+vMiHTEaW4UwLRy16WRoYfu+LJ4pOncpItD4O1GRnxH8TmktN6T6b2PcHxyEwB
         /Ls2IApWVfXgN0RNquNulhQ49MIzfMO2KbQlpew/gmesTLhSAFACIhd9NN5hvF8aTXrJ
         9dGZyhMELfyMK2fbiMTxbSKpZ8EVlDN75FSZjN4lYOI29EfHTi0l6te+3DGNqlishUcI
         ufFCYzDFtCRCTDhyOG4tSbItgT3oIdpuWbG9YF8aGWnFAtPl3K8qizsCVOk3/weuXndt
         nd8yUP/5mHGC7HDR1cjV9fJCWbl4EUH4bqfDeIq+Fhmmrdj99nMfB4lAH2i7rVf5TT9v
         sLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mVnGuA/c41po031/Zyo9z05iki6LpXCl3bw26UlV5Og=;
        b=W2kAtqGW2dRvsLrZ0jB1slglZmphugBxcwgen9anGSLCNPfDVIUBHfC2UYhJ+N252B
         /W6F8ARcrA4faoPcu6g7AY/AvmLE3fqldPf4bUok9BfIOXAtz9si2FPL7M5u93niK+uB
         dXC153ZY5f9wXgadiPtymO96gz9HSUTtBDrmtw8x0Yy3ztPFw5clEr1Eb2upYPjITeLb
         3ihghww8oaZBdBZYxm9ekfBvxFSQMhfLKP6N0vGaqKGu/Yw+avKluR67CyVwMGUekZ/F
         g3KfGUqMV/QWXes5/p9XnezHdjiqphHn7OrDqyxHS2SXqGxVDeuZPYUnx0dnq13i+T4Y
         funw==
X-Gm-Message-State: AOAM533sY+DYAlODFV9ixHUVnvqpnU1wvoZy7s7rg6WUiqnamT9uZzbA
        DuuqUS7Mg8tccPb+lLUOu+IVRxSBESN9T+Upt0U=
X-Google-Smtp-Source: ABdhPJyt/PrPu0HyLCBNIAlcBPVwQP3EdSaZpX3l0+ThMZQ3Nc11G0djVdAg3aM+jm8BukBsG/8Iq0VgME50WXdM3Aw=
X-Received: by 2002:a37:a50d:: with SMTP id o13mr9327701qke.121.1590060626064;
 Thu, 21 May 2020 04:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <1589881301-4143-1-git-send-email-shengjiu.wang@nxp.com>
 <0866cd8cdb0c22f0b2a6814c4dafa29202aad5f3.camel@pengutronix.de>
 <CAA+D8APhHvA39wmCayeCsAEKmOJ0n7qOQiT1tZmFHr4+yASgTw@mail.gmail.com>
 <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
 <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com> <20200520123850.GE4823@sirena.org.uk>
In-Reply-To: <20200520123850.GE4823@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 21 May 2020 19:30:04 +0800
Message-ID: <CAA+D8AOiVVi3B4dzU8r=rCMz=6w9R=wxBkzAQ=0=RAQLKCWy8Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-dma: Don't request dma channel in probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 8:38 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 20, 2020 at 07:22:19PM +0800, Shengjiu Wang wrote:
>
> > I see some driver also request dma channel in open() or hw_params().
> > how can they avoid the defer probe issue?
> > for example=EF=BC=9A
> > sound/arm/pxa2xx-pcm-lib.c
> > sound/soc/sprd/sprd-pcm-dma.c
>
> Other drivers having problems means those drivers should be fixed, not
> that we should copy the problems.  In the case of the PXA driver that's
> very old code which predates deferred probe by I'd guess a decade.

Thanks.

For the FE-BE case, do you have any suggestion for how fix it?

With DMA1->ASRC->DMA2->ESAI case, the DMA1->ASRC->DMA2
is in FE,  ESAI is in BE.  When ESAI drvier probe,  DMA3 channel is
created with ESAI's "dma:tx" (DMA3 channel
is not used in this FE-BE case).    When FE-BE startup, DMA2
channel is created, it needs the ESAI's "dma:tx", so the warning
comes out.

best regards
wang shengjiu

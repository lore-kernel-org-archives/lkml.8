Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E051C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E8520758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzRhD8IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETLWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:22:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E79C061A0E;
        Wed, 20 May 2020 04:22:41 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so3029080qke.13;
        Wed, 20 May 2020 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZjqVhvVauJwxzdubRCxzpwyDgNZsr/jK/zmF2UGqkm0=;
        b=LzRhD8IVgnmIVQzzoYcQc9SGvryKW9AvjBv+5xt1U5TlXPqkgWZYhhLZ+fDOiIMJVE
         j8fn5+fABxBNdukYPVM+l0vF16UvWxzpEJBJLKCW56Z4DkC5xa0rvUGkgFzj9G0Agcbl
         CR4ePEwCrdO65XTKv1Q7qKPo1V5T2jQjs+MOPyTun845of6hg3kQqItmtboNDlREjJcu
         Z2pKrl+oLt5umJH0Z+pIMp+EXFb7tOaN6BDew0UWwQ+/7bg+moQfUGPSduuzZJPyI5/X
         2YFdC3nAFQopV7V8BMDEMRy8CAn1JlcOebH4yDfMrImRBq3nMNW49Dcoe93t2TjTRQsi
         5qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZjqVhvVauJwxzdubRCxzpwyDgNZsr/jK/zmF2UGqkm0=;
        b=tGKfvQOLbYU/CCvevpp/elZsTM7jW2xKsLaADafhQe+knI3smKvwcOGAaZ+Vm+A4I/
         VUF5yGRw2wmZ8G+jz6LpMGsbWmPi7M+w7yvwfPBLr0wMTYZC2K1yVBSrEF0pefuHaehF
         0VmXDY0KIIPqj2xQeI0qGhQrc7tcktsceAhq2P2/9YrsUR+2Z0+gbbgTb7qCCIl69Jbc
         Wa12BS5zRf/QzTvFKR1162IKOeUZK50fCX8VcsdFQ0gaOaLwot1y1Lr08MH7JTJa1Fun
         uqNJnq05p2q+nAZneJjjBpvOmmkIAytpzfQLzAB32nmy4tLgxBTazuTFuhcPvL8IfZDW
         XqIw==
X-Gm-Message-State: AOAM532jmsvr7fhp83fnG/0ifx+WTD/JtVFX/YK7qkPl8+ForL6i7RsG
        3LfwpUMPIOJAD2UO8FoFmoxxg82yspwqdbu9AhI=
X-Google-Smtp-Source: ABdhPJxBdmgJNCR88xlbXPGclNlO2GaIwRkfV+dyapGMbu4Q9RuUthOHvMqPP4yv8y1KdCvdCmqnj7BHtLVZZI62f64=
X-Received: by 2002:a37:a50d:: with SMTP id o13mr4087174qke.121.1589973760794;
 Wed, 20 May 2020 04:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <1589881301-4143-1-git-send-email-shengjiu.wang@nxp.com>
 <0866cd8cdb0c22f0b2a6814c4dafa29202aad5f3.camel@pengutronix.de>
 <CAA+D8APhHvA39wmCayeCsAEKmOJ0n7qOQiT1tZmFHr4+yASgTw@mail.gmail.com> <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
In-Reply-To: <53258cd99caaf1199036737f8fad6cc097939567.camel@pengutronix.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 20 May 2020 19:22:19 +0800
Message-ID: <CAA+D8APAMRwtVneqFsuBgAhozmQo3R0AQi0bVdUCQO4Af4xVfw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-dma: Don't request dma channel in probe
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        Takashi Iwai <tiwai@suse.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        sumit.semwal@linaro.org, Linux-ALSA <alsa-devel@alsa-project.org>,
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

Hi

On Wed, May 20, 2020 at 5:42 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 20.05.2020, 16:20 +0800 schrieb Shengjiu Wang:
> > Hi
> >
> > On Tue, May 19, 2020 at 6:04 PM Lucas Stach <l.stach@pengutronix.de> wr=
ote:
> > > Am Dienstag, den 19.05.2020, 17:41 +0800 schrieb Shengjiu Wang:
> > > > There are two requirements that we need to move the request
> > > > of dma channel from probe to open.
> > >
> > > How do you handle -EPROBE_DEFER return code from the channel request =
if
> > > you don't do it in probe?
> >
> > I use the dma_request_slave_channel or dma_request_channel instead
> > of dmaengine_pcm_request_chan_of. so there should be not -EPROBE_DEFER
> > return code.
>
> This is a pretty weak argument. The dmaengine device might probe after
> you try to get the channel. Using a function to request the channel
> that doesn't allow you to handle probe deferral is IMHO a bug and
> should be fixed, instead of building even more assumptions on top of
> it.
>

I see some driver also request dma channel in open() or hw_params().
how can they avoid the defer probe issue?
for example=EF=BC=9A
sound/arm/pxa2xx-pcm-lib.c
sound/soc/sprd/sprd-pcm-dma.c

> > > > - When dma device binds with power-domains, the power will
> > > > be enabled when we request dma channel. If the request of dma
> > > > channel happen on probe, then the power-domains will be always
> > > > enabled after kernel boot up,  which is not good for power
> > > > saving,  so we need to move the request of dma channel to .open();
> > >
> > > This is certainly something which could be fixed in the dmaengine
> > > driver.
> >
> > Dma driver always call the pm_runtime_get_sync in
> > device_alloc_chan_resources, the device_alloc_chan_resources is
> > called when channel is requested. so power is enabled on channel
> > request.
>
> So why can't you fix the dmaengine driver to do that RPM call at a
> later time when the channel is actually going to be used? This will
> allow further power savings with other slave devices than the audio
> PCM.
>
> Regards,
> Lucas
>

It seems the best place for calling pm_runtime_get_sync is the
device_alloc_chan_resources, and calling pm_runtime_put_sync
in the .device_free_chan_resources

For the slave_sg mode, the .device_prep_slave_sg and
.device_issue_pending  will be called many times after
.device_alloc_chan_resources. so it is not good to call
pm_runtime_get_sync in .device_prep_slave_sg or
.device_issue_pending

best regards
wang shengjiu

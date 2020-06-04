Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C859AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9591204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI7b/qDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgFDRsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgFDRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:48:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0AAC08C5C0;
        Thu,  4 Jun 2020 10:48:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i1so5725874ils.11;
        Thu, 04 Jun 2020 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/V5YN3JVU+H2ybPVxXGB5Yo/z8JMsprmG2VuUwYuRz4=;
        b=sI7b/qDlRiArW/5SdFyLqdgMpyDYULV1NOXwELfaYauvEpbt74X36o+SGdZ0XY0oMw
         EpaXz8RJCt/CpvBzR+OYBkwFOk1WpNZbKQVuTFWUrR3te4T2zmLHJzEFg8hwVsYrB7/N
         I09OKDJDFNk7f8Tu3D3Zq2YoPScRztc+8zcHKHI/gpfX2mT91iVcUyVT6zLvOGMbNlZn
         GmUEqrEKUXiNRM5zGBvaonxxjpFF+Wx02FqC+20RilKlSP441jDoLViM/EB9RAxNfmSs
         4xuC5aMG8pzk1XT0M8/inYWjUyzpCbRIeFMt5CGH2+g+AJ5nS5k8Zcpv4uhrH/Wr155e
         Frkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/V5YN3JVU+H2ybPVxXGB5Yo/z8JMsprmG2VuUwYuRz4=;
        b=tv/WhXF0qEfLdJt0CHJslXD5g+/CDZ4hkRdJNKbOORx+g42bYv3JV+bzViDIWDAcUc
         AtiTskk/X8dDcGUKibIOya8s0DojmrA3TbhxNg/TezhWsUx6yf8IS1TL7yh3MQRFiTog
         L0Th0t0mArZ5FitU77irqphhBg2a1haIplexcLBZG1Q3tf9aD4YYLQcUz5ydwUxmH1m0
         E65usdlsKJOcl/QGQiFF+mzX8OreQpBn+TLlSIsOtQOCiZnbFOYtHG0X1GWO9lS45IR9
         4RzIgrd1XtUa2LxVGsCFR24pQ7sdNyK5Y8UC7Z/jkE4jEQtofSPhj3lGxbCRrItCAIeb
         az1w==
X-Gm-Message-State: AOAM5316GtgdV1awEP+o67E64P2Oqy5+nCV2KYpam6NDNvD1vZnzeKOQ
        OqUu+NEHRfE25sibP8l2a1JZabnriU/R9D9AeQU=
X-Google-Smtp-Source: ABdhPJzFeNeeQM7soCpQdZ+IhQ7n6azUC9Mg45G4VT9kcauWSICOdgF4RaKvqGNHiRKEevdJDQLNgIrhu3an3lem1s0=
X-Received: by 2002:a92:4852:: with SMTP id v79mr1192467ila.172.1591292901477;
 Thu, 04 Jun 2020 10:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200603184104.4475-1-navid.emamdoost@gmail.com> <900909fe-fa15-fbca-80f7-79aeee721ed9@nvidia.com>
In-Reply-To: <900909fe-fa15-fbca-80f7-79aeee721ed9@nvidia.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 4 Jun 2020 12:48:10 -0500
Message-ID: <CAEkB2ET8+Bo+0xw0TS80tzg0zq0ygPd=GEDsPEnd96k8shMAAg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix pm_runtime_get_sync failure
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 12:45 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 03/06/2020 19:41, Navid Emamdoost wrote:
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put if
> > pm_runtime_get_sync fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/dma/tegra210-adma.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> > index c4ce5dfb149b..e8c749cd3fe8 100644
> > --- a/drivers/dma/tegra210-adma.c
> > +++ b/drivers/dma/tegra210-adma.c
> > @@ -659,6 +659,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
> >       ret = pm_runtime_get_sync(tdc2dev(tdc));
> >       if (ret < 0) {
> >               free_irq(tdc->irq, tdc);
> > +             pm_runtime_put(tdc2dev(tdc));
> >               return ret;
> >       }
>
>
> Please do not send two patches with the same $subject that are fixing
> two different areas of the driver. In fact, please squash these two
> patches into a single fix and resend because they are fixing the same issue.

Sure, I will prepare a version 2 with your suggestions.

>
> Jon
>
> --
> nvpublic



-- 
Navid.

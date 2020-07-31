Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5834321744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M+csR49i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbgGaMtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbgGaMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:49:18 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:49:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l4so31226769ejd.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKmO2ZAvewEBOR4kyQ9VDj8a4Brdi56V8Gl0PxTOBWk=;
        b=M+csR49iDfxo6UoiXSocjp8GH38x/wp8SHIku/n1gRdFm7qloMmf72l2fFrkx2nHna
         vo9sUTwCKgwQ8pb5XQez3od4wwkP50GX0j5bBNqFwXIe4MebvxsiEKV08LeITrovK9zx
         G2SD+Fjj4b33BOJZoNLjiQtoU3DeWwnfhzlfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKmO2ZAvewEBOR4kyQ9VDj8a4Brdi56V8Gl0PxTOBWk=;
        b=M2ZvstDX24tFlpYXsR1fVUYYUcfUQn2epbbtpq3un2TAN/scflz8ZPVfopJF1l3T5G
         x5/tHQSRRoWnlBw1NdRS2gN25VJiR8Dc23p77jXs8rfEyB+8VKM6189+Cn3wf0ihIv2b
         jSNaUUn0/nGsI3zBJJkFoDkCAJ+MYdUBLNVYJFplvfrjmrUMSHU7tCgGtpHd7Sx3+JKk
         x5GQbpEFcazWbTYgeiPgMs9YbSMzzW1BLs7LuQtF9WLBlQQtLXM33QW3MZv+4JxYk6kZ
         KBmyFVsCeU/XXdXcLrYuN/HdIuoX4+aia9BFqcrLgEADVFD5OHJ6AvBleGLdFYwqaOe2
         wOAA==
X-Gm-Message-State: AOAM533vIJ69S/udCcJwqvNHBkG7a+rhQW86nXBXkaHIH0HniFXxCO54
        wOIideVirqE9QKRmrnr54LPmag6l+2Vi3Q==
X-Google-Smtp-Source: ABdhPJytmwjLi5+ktQi5ujLAbBVr68C5v2UTQEb4vDil7lgI7ctdkqFIqTuaBKnY9XszXcQAGe1tqw==
X-Received: by 2002:a17:906:140e:: with SMTP id p14mr3991760ejc.430.1596199756631;
        Fri, 31 Jul 2020 05:49:16 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id pv28sm9471050ejb.71.2020.07.31.05.49.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 05:49:15 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id k8so9147228wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:49:15 -0700 (PDT)
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr3555747wmg.183.1596199754613;
 Fri, 31 Jul 2020 05:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200723030451.5616-1-xia.jiang@mediatek.com> <20200723030451.5616-23-xia.jiang@mediatek.com>
 <20200730163419.GA3779380@chromium.org> <1596165602.17247.10.camel@mhfsdcap03>
In-Reply-To: <1596165602.17247.10.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 31 Jul 2020 14:49:03 +0200
X-Gmail-Original-Message-ID: <CAAFQd5C4hpz8DR101WYQ=9xeq3=yMbtbCasAUqGPpg9fLNORgA@mail.gmail.com>
Message-ID: <CAAFQd5C4hpz8DR101WYQ=9xeq3=yMbtbCasAUqGPpg9fLNORgA@mail.gmail.com>
Subject: Re: [PATCH v10 22/28] media: platform: Change the call functions of
 getting/enable/disable the jpeg's clock
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        mojahsu@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <maoguang.meng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 5:20 AM Xia Jiang <xia.jiang@mediatek.com> wrote:
>
> On Thu, 2020-07-30 at 16:34 +0000, Tomasz Figa wrote:
> > Hi Xia,
> >
> > On Thu, Jul 23, 2020 at 11:04:45AM +0800, Xia Jiang wrote:
> > > Use the generic of_property_* helpers to get the clock_nums and clocks
> > > from device tree.
> > > Use the generic clk_bulk_* helpers to enable and disable clocks.
> > >
> > > Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> > > ---
> > > v10: new add patch
> > > ---
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 47 +++++++++++++++----
> > >  .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  8 ++--
> > >  2 files changed, 42 insertions(+), 13 deletions(-)
> > >
> >
> > Thank you for the patch. Please see my comments inline.
> >
> > > diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > > index 7881e9c93df7..921ed21f7db3 100644
> > > --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > > +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > > @@ -783,14 +783,15 @@ static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
> > >     ret = mtk_smi_larb_get(jpeg->larb);
> > >     if (ret)
> > >             dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
> > > -   clk_prepare_enable(jpeg->clk_jdec_smi);
> > > -   clk_prepare_enable(jpeg->clk_jdec);
> > > +
> > > +   ret = clk_bulk_prepare_enable(jpeg->num_clks, jpeg->clks);
> > > +   if (ret)
> > > +           dev_err(jpeg->dev, "Failed to open jpeg clk: %d\n", ret);
> > >  }
> > >
> > >  static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
> > >  {
> > > -   clk_disable_unprepare(jpeg->clk_jdec);
> > > -   clk_disable_unprepare(jpeg->clk_jdec_smi);
> > > +   clk_bulk_disable_unprepare(jpeg->num_clks, jpeg->clks);
> > >     mtk_smi_larb_put(jpeg->larb);
> > >  }
> > >
> > > @@ -939,6 +940,7 @@ static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
> > >  {
> > >     struct device_node *node;
> > >     struct platform_device *pdev;
> > > +   int ret, i;
> > >
> > >     node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
> > >     if (!node)
> > > @@ -952,12 +954,39 @@ static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
> > >
> > >     jpeg->larb = &pdev->dev;
> > >
> > > -   jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
> > > -   if (IS_ERR(jpeg->clk_jdec))
> > > -           return PTR_ERR(jpeg->clk_jdec);
> > > +   jpeg->num_clks =
> > > +           of_property_count_strings(jpeg->dev->of_node, "clock-names");
> > > +
> > > +   if (jpeg->num_clks > 0) {
> > > +           jpeg->clks = devm_kcalloc(jpeg->dev, jpeg->num_clks,
> > > +                                     sizeof(struct clk_bulk_data),
> > > +                                     GFP_KERNEL);
> > > +           if (!jpeg->clks)
> > > +                   return -ENOMEM;
> > > +   } else {
> > > +           dev_err(&pdev->dev, "Failed to get jpeg clock count\n");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   for (i = 0; i < jpeg->num_clks; i++) {
> > > +           ret = of_property_read_string_index(jpeg->dev->of_node,
> > > +                                               "clock-names", i,
> > > +                                               &jpeg->clks->id);
> >
> > The names of the clocks must be explicitly specified in the driver, as per
> > the DT bindings.
> Dear Tomasz,
>
> Thank you for your reply.
> You mean that I should keep the v9 version about names of the clocks in
> the match data.
> The v10 version about the names of the clocks follows the upstreamed
> mtk_venc/vdec.I think that this method is more generic. For example,when
> other project has more clocks, we can get the names of clocks from dtsi
> without changing the driver code.
> What about your further opinion?

The problem with that method is that one can put any random names in
the DT and the driver will happily accept them, without any
correctness checking. Moreover, if the other project has more clocks,
it already requires a different compatible string in the DT bindings,
so the kernel needs to be changed anyway.

Actually this is something that needs to be fixed in the mtk_venc/vdec
driver as well. I believe someone just overlooked it when the driver
was being reviewed.

Best regards,
Tomasz

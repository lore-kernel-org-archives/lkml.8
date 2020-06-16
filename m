Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB10C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402A62074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbK+rT7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFPHMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:12:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B0C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:12:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u26so1581941wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cC345F3uE0UMoSIVtowqB/yiYQXwV2/nKjgt7xYao6I=;
        b=bbK+rT7jS8kjpRYkid3NabGRYvxdpuICpDGcIgWfUBNff6dpz0ixlCCLDzpZZtogot
         T/Qv33i0BXohAPtfxCQekbNLGBgsKUAASNe6nDQCM4mR1kAAgCcSWhfj4RaRbq5g73SZ
         riCUXLsGTXBHgVVuFKN0ckHPO1bPqmESEJOcGuLLxt54nruDW3Y3Mm0LzvF50QLABMhF
         FoUVu5TsfyPiIfVD/xh3lJ1lRLB4tgg2BQJHLU39wKGoQF1emlMSXRwpAmigD1tPMiYx
         WZ6/pBfHaSnhZ6NW59nhm0Zc3K6wMUpcQEmAoZdRp6xMO6ywzEe+mp/rFTiZr5ZfSw3a
         jBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cC345F3uE0UMoSIVtowqB/yiYQXwV2/nKjgt7xYao6I=;
        b=LtKU0LZOEwgavxVA5af8LEVYNYn8j24nkRoYgmRx10xmUhLXt+H4rYbDllBlBYMNcP
         O3JrLifSdPQtKHH/UeMTk5PoXpz5ofq9Umu2xfWC3YLPtPx9fJEdDD1FymwIWg3MkDCb
         7Ro6J/MZAyNrauLYuba5FOyvWxYq+5kNli3C6FsnmMPgZ3Il6Vy06JgYtC9v3cBBtqbc
         ClApFggQ4QJisFsRt6Pp6pm6tlDC7YEFOunizM3zumqOBEb8AJoioocY45xP/uyrWKfi
         4w60v1dpEcthLnnPb/h68pviTynP0/pjiUqC4gkJPDFlOlAzK6u0l5Tr2DtQVwDuwRMp
         IP7g==
X-Gm-Message-State: AOAM533q68toCayiBY8YZV8OAqk/ejILkqalND/GXykue8OvFOiYe/Jx
        C0nrO8GRw3Nj+530NR7+NTAT1A==
X-Google-Smtp-Source: ABdhPJwU3QiXILLDCyLrHb0VEnHVYuZxz6odm0jOoBng0kM1Dqzbou1bHHocONnwk0EcRV3MN6JXug==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr1825973wmg.52.1592291539835;
        Tue, 16 Jun 2020 00:12:19 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id k21sm28943505wrd.24.2020.06.16.00.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:12:18 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:12:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] mfd: sprd: get subdevices from DT instead for SC27XX SPI
Message-ID: <20200616071217.GE2608702@dell>
References: <20200615034715.11438-1-zhang.lyra@gmail.com>
 <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Baolin Wang wrote:

> On Mon, Jun 15, 2020 at 11:47 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
> > no matter these devices were really included on board. So with this
> > patch we switch to a new way of detecting subdevices which are
> > defined in the devicetree.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/mfd/sprd-sc27xx-spi.c | 102 +++++++++++-----------------------
> >  1 file changed, 31 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > index 33336cde4724..aa3daa0cfcf5 100644
> > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > @@ -93,73 +93,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> >
> > -static const struct mfd_cell sprd_pmic_devs[] = {
> > -       {
> > -               .name = "sc27xx-wdt",
> > -               .of_compatible = "sprd,sc2731-wdt",
> > -       }, {
> > -               .name = "sc27xx-rtc",
> > -               .of_compatible = "sprd,sc2731-rtc",
> > -       }, {
> > -               .name = "sc27xx-charger",
> > -               .of_compatible = "sprd,sc2731-charger",
> > -       }, {
> > -               .name = "sc27xx-chg-timer",
> > -               .of_compatible = "sprd,sc2731-chg-timer",
> > -       }, {
> > -               .name = "sc27xx-fast-chg",
> > -               .of_compatible = "sprd,sc2731-fast-chg",
> > -       }, {
> > -               .name = "sc27xx-chg-wdt",
> > -               .of_compatible = "sprd,sc2731-chg-wdt",
> > -       }, {
> > -               .name = "sc27xx-typec",
> > -               .of_compatible = "sprd,sc2731-typec",
> > -       }, {
> > -               .name = "sc27xx-flash",
> > -               .of_compatible = "sprd,sc2731-flash",
> > -       }, {
> > -               .name = "sc27xx-eic",
> > -               .of_compatible = "sprd,sc2731-eic",
> > -       }, {
> > -               .name = "sc27xx-efuse",
> > -               .of_compatible = "sprd,sc2731-efuse",
> > -       }, {
> > -               .name = "sc27xx-thermal",
> > -               .of_compatible = "sprd,sc2731-thermal",
> > -       }, {
> > -               .name = "sc27xx-adc",
> > -               .of_compatible = "sprd,sc2731-adc",
> > -       }, {
> > -               .name = "sc27xx-audio-codec",
> > -               .of_compatible = "sprd,sc2731-audio-codec",
> > -       }, {
> > -               .name = "sc27xx-regulator",
> > -               .of_compatible = "sprd,sc2731-regulator",
> > -       }, {
> > -               .name = "sc27xx-vibrator",
> > -               .of_compatible = "sprd,sc2731-vibrator",
> > -       }, {
> > -               .name = "sc27xx-keypad-led",
> > -               .of_compatible = "sprd,sc2731-keypad-led",
> > -       }, {
> > -               .name = "sc27xx-bltc",
> > -               .of_compatible = "sprd,sc2731-bltc",
> > -       }, {
> > -               .name = "sc27xx-fgu",
> > -               .of_compatible = "sprd,sc2731-fgu",
> > -       }, {
> > -               .name = "sc27xx-7sreset",
> > -               .of_compatible = "sprd,sc2731-7sreset",
> > -       }, {
> > -               .name = "sc27xx-poweroff",
> > -               .of_compatible = "sprd,sc2731-poweroff",
> > -       }, {
> > -               .name = "sc27xx-syscon",
> > -               .of_compatible = "sprd,sc2731-syscon",
> > -       },
> > -};
> > -
> >  static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
> >  {
> >         struct device *dev = context;
> > @@ -205,6 +138,35 @@ static const struct regmap_config sprd_pmic_config = {
> >         .max_register = 0xffff,
> >  };
> >
> > +static int sprd_pmic_add_subdevices(struct device *dev, int id,
> > +                        struct irq_domain *domain)
> > +{
> > +       int ret = 0;
> > +       struct device_node *child, *parent = dev->of_node;
> > +       struct mfd_cell cell = {0};
> > +       const char *comp;
> > +       unsigned int prefix_len = strlen("sprd,");
> > +       char buf[30];
> > +
> > +       for_each_child_of_node(parent, child) {
> > +               comp = of_get_property(child, "compatible", NULL);
> > +               if (!comp || strncmp("sprd,", comp, prefix_len))
> > +                       return -EINVAL;
> > +
> > +               memcpy(buf, comp, strlen(comp) + 1);
> > +               cell.of_compatible = buf;
> > +               cell.name = buf + prefix_len;
> 
> I feel it is a little hackish, you can create any device nodes from DT
> even the PMIC does not support.
> 
> I am not sure the problem caused by the original method, you can use
> the compatible string to be compatible with different PMICs, such as
> SC2730 ADC:
> compatible = "sprd,sc2731-adc", "sprd,sc2730-adc";
> 
> Moreover I think you can add the "sprd,sc2730-xxx" compatible string
> for the mfd_cell in this driver if you are sure we want to support
> SC2730 PMIC.

Why not just use of_platform_populate()?

> > +
> > +               ret = devm_mfd_add_devices(dev, id, &cell, 1, NULL, 0, domain);
> > +               if (ret) {
> > +                       pr_err("devm_mfd_add_devices return fail ret=%d\n", ret);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static int sprd_pmic_probe(struct spi_device *spi)
> >  {
> >         struct sprd_pmic *ddata;
> > @@ -263,10 +225,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
> >                 return ret;
> >         }
> >
> > -       ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
> > -                                  sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
> > -                                  NULL, 0,
> > -                                  regmap_irq_get_domain(ddata->irq_data));
> > +       ret = sprd_pmic_add_subdevices(&spi->dev, PLATFORM_DEVID_AUTO,
> > +                                      regmap_irq_get_domain(ddata->irq_data));
> >         if (ret) {
> >                 dev_err(&spi->dev, "Failed to register device %d\n", ret);
> >                 return ret;
> >
> 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

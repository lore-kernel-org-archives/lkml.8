Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC892074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVA4M1bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgFPIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFPIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:12:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69AC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:12:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d128so2085801wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dQDICIikufgD1p4AwMl4420T+aL7bD5B7t8676tcXNg=;
        b=AVA4M1bik7Kk5hh9NsWI/BjtqY1FnTlvwoLIZuHJcmKb/B7WHDhJk2pdupjBGD8ivM
         51KwklsGD++u0NgyJ4T2JKlG+iydjqwn2JDt1vVwWdKJwsxN/7hYHCHS2/M9DLpz/AB+
         Ca+VmsD7uDxI6haL7Ax0Y9veCLhBA0X0Tu+75r9D9J05yeJMtcoETeg8WP/Hle7ZNJoA
         IWdXWcclRGMYXEO7oy71Kgk9tHyWa/bv2wBe8ur6Tye8cIFLojHmHm/xXYNsvoGkB0Zp
         Objiip9kxWTrS+t4NNkvpG503+LVDPcZF/fnW3DnyGzHPmxJqsiieqei8fI2dLuGiwL0
         KKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dQDICIikufgD1p4AwMl4420T+aL7bD5B7t8676tcXNg=;
        b=iIUUFs+h/kHHz0fctvIPnHcpZBfGP7Y2KZ/WpF0Lbp4YuShBGFpUWK9QaCPYMUnnyo
         Vzo3eKNDAYgpYZI62hiFhsVAFmwGmnmAnpgT+CVVljAG5TMKmMkBBQMDATMgPAAiJpZl
         xCGdl1JqzBnkWPGLBb52Y1jAcJeHT/aI8UtuJCTeiTzVgue7gG1uDSd71ciCglQnYH3j
         eI1goIqRdO3aITnDnDoSmV2/UQOaj98czLY07HPnA3eOq4ZVsJoLaHRAqoWrYA3sunpT
         67WLYqoDoKxP8kOJXRMCsD5Z4pO2m+24ekVeZMPFq5lYZcffdZ8aRc8MtyBaJujyuKma
         4rcA==
X-Gm-Message-State: AOAM530wSOObKBiyj4ZVY+c5YC4YJMlVSqemt7TsI+TyhnXYXXdVrli1
        YVuKh0+9eCMzpeojbBg7OtzQVBgxMuQ=
X-Google-Smtp-Source: ABdhPJyQvnpF5L2Djg0L12Up/fWb1NoE3Np/pO26oNdlaDeN2dkHwUvB8mVbZqWfsL6tlPdK8w1R4Q==
X-Received: by 2002:a1c:6056:: with SMTP id u83mr1858410wmb.138.1592295162865;
        Tue, 16 Jun 2020 01:12:42 -0700 (PDT)
Received: from dell ([109.180.115.156])
        by smtp.gmail.com with ESMTPSA id k12sm28180127wrn.42.2020.06.16.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:12:42 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:12:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH] mfd: sprd: get subdevices from DT instead for SC27XX SPI
Message-ID: <20200616081240.GL2608702@dell>
References: <20200615034715.11438-1-zhang.lyra@gmail.com>
 <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
 <CA+H2tpF95rLRb8qbgCsrKBtjTV7JMTenuaYBHf19tpAXFqmqMQ@mail.gmail.com>
 <CADBw62r2bUxM4hxwN86aOJ9-2j0Zo8H3PMB67A=e8DUB1c0F+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62r2bUxM4hxwN86aOJ9-2j0Zo8H3PMB67A=e8DUB1c0F+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Baolin Wang wrote:

> On Mon, Jun 15, 2020 at 11:08 PM Orson Zhai <orsonzhai@gmail.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 10:12 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > On Mon, Jun 15, 2020 at 11:47 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > >
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
> > > > no matter these devices were really included on board. So with this
> > > > patch we switch to a new way of detecting subdevices which are
> > > > defined in the devicetree.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  drivers/mfd/sprd-sc27xx-spi.c | 102 +++++++++++-----------------------
> > > >  1 file changed, 31 insertions(+), 71 deletions(-)
> > > >
> > > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > > index 33336cde4724..aa3daa0cfcf5 100644
> > > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > > @@ -93,73 +93,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> > > >
> > > > -static const struct mfd_cell sprd_pmic_devs[] = {
> > > > -       {
> > > > -               .name = "sc27xx-wdt",
> > > > -               .of_compatible = "sprd,sc2731-wdt",
> > > > -       }, {
> > > > -               .name = "sc27xx-rtc",
> > > > -               .of_compatible = "sprd,sc2731-rtc",
> > > > -       }, {
> > > > -               .name = "sc27xx-charger",
> > > > -               .of_compatible = "sprd,sc2731-charger",
> > > > -       }, {
> > > > -               .name = "sc27xx-chg-timer",
> > > > -               .of_compatible = "sprd,sc2731-chg-timer",
> > > > -       }, {
> > > > -               .name = "sc27xx-fast-chg",
> > > > -               .of_compatible = "sprd,sc2731-fast-chg",
> > > > -       }, {
> > > > -               .name = "sc27xx-chg-wdt",
> > > > -               .of_compatible = "sprd,sc2731-chg-wdt",
> > > > -       }, {
> > > > -               .name = "sc27xx-typec",
> > > > -               .of_compatible = "sprd,sc2731-typec",
> > > > -       }, {
> > > > -               .name = "sc27xx-flash",
> > > > -               .of_compatible = "sprd,sc2731-flash",
> > > > -       }, {
> > > > -               .name = "sc27xx-eic",
> > > > -               .of_compatible = "sprd,sc2731-eic",
> > > > -       }, {
> > > > -               .name = "sc27xx-efuse",
> > > > -               .of_compatible = "sprd,sc2731-efuse",
> > > > -       }, {
> > > > -               .name = "sc27xx-thermal",
> > > > -               .of_compatible = "sprd,sc2731-thermal",
> > > > -       }, {
> > > > -               .name = "sc27xx-adc",
> > > > -               .of_compatible = "sprd,sc2731-adc",
> > > > -       }, {
> > > > -               .name = "sc27xx-audio-codec",
> > > > -               .of_compatible = "sprd,sc2731-audio-codec",
> > > > -       }, {
> > > > -               .name = "sc27xx-regulator",
> > > > -               .of_compatible = "sprd,sc2731-regulator",
> > > > -       }, {
> > > > -               .name = "sc27xx-vibrator",
> > > > -               .of_compatible = "sprd,sc2731-vibrator",
> > > > -       }, {
> > > > -               .name = "sc27xx-keypad-led",
> > > > -               .of_compatible = "sprd,sc2731-keypad-led",
> > > > -       }, {
> > > > -               .name = "sc27xx-bltc",
> > > > -               .of_compatible = "sprd,sc2731-bltc",
> > > > -       }, {
> > > > -               .name = "sc27xx-fgu",
> > > > -               .of_compatible = "sprd,sc2731-fgu",
> > > > -       }, {
> > > > -               .name = "sc27xx-7sreset",
> > > > -               .of_compatible = "sprd,sc2731-7sreset",
> > > > -       }, {
> > > > -               .name = "sc27xx-poweroff",
> > > > -               .of_compatible = "sprd,sc2731-poweroff",
> > > > -       }, {
> > > > -               .name = "sc27xx-syscon",
> > > > -               .of_compatible = "sprd,sc2731-syscon",
> > > > -       },
> > > > -};
> > > > -
> > > >  static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
> > > >  {
> > > >         struct device *dev = context;
> > > > @@ -205,6 +138,35 @@ static const struct regmap_config sprd_pmic_config = {
> > > >         .max_register = 0xffff,
> > > >  };
> > > >
> > > > +static int sprd_pmic_add_subdevices(struct device *dev, int id,
> > > > +                        struct irq_domain *domain)
> > > > +{
> > > > +       int ret = 0;
> > > > +       struct device_node *child, *parent = dev->of_node;
> > > > +       struct mfd_cell cell = {0};
> > > > +       const char *comp;
> > > > +       unsigned int prefix_len = strlen("sprd,");
> > > > +       char buf[30];
> > > > +
> > > > +       for_each_child_of_node(parent, child) {
> > > > +               comp = of_get_property(child, "compatible", NULL);
> > > > +               if (!comp || strncmp("sprd,", comp, prefix_len))
> > > > +                       return -EINVAL;
> > > > +
> > > > +               memcpy(buf, comp, strlen(comp) + 1);
> > > > +               cell.of_compatible = buf;
> > > > +               cell.name = buf + prefix_len;
> > >
> > > I feel it is a little hackish, you can create any device nodes from DT
> > > even the PMIC does not support.
> >
> > In the old code, if sub cells have wrong compatible strings, he will not get
> > an opportunity to be probed.
> 
> Yes, that's correct, and that's what PMIC asks.
> 
> > It is confused to user for  there is no any error and warning message.
> 
> The sub-nodes of PMIC should describe their standard compatible string
> in their DT bindings.
> 
> > I think it maybe better to let them being probed even when they might be wrong.
> > The cell will check by itself --  return success in probing if in the
> > right place or return error if any
> > thing is wrong there.
> 
> I do not think this is reasonable, since I can hack the DT to create
> any device nodes that PMIC does not support. But if Lee agrees with
> Chunyan's change, I am fine with that.

Obviously I do not agree to this patch, as it's one big hack.

Why not just use of_platform_populate()?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32392C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAFB20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkiRKAgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFOXa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:30:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE34C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:30:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so10592548lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UF9Ee31OpUvzg8FfY/QTxWI05lXy4q9JgfSXzHlkpH8=;
        b=JkiRKAgxaRxh97qMwOMfeMMfIUednqRnT3mDUJYVzwvbjcNKlYVEC2sPxxIfujEGZs
         gOC5Pf8vlZfhkg+07luoq2fKztjmg/LSz0evLAMhnsQMBjuCcirOldO+Fal0hLorOdqs
         IgrnUg86aLWQbkTrEvUSoU3Z5Vkya2lP5Omm+gHm6Fp+Qwv1VA8fzfecECPSBxPYUs9k
         y0FFg8drpJCnQMaiuKa5Le5FxaoO/tfm6/Rdiz4xAQOIf525ClXO2STpqHDuhkf8ldG8
         pW98tG4SVoTs99E1R6BCuXRjoMfptUZRQTSYNjOtPoWq0kvZGm+17XXfHv+2PQ+MteCJ
         h48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UF9Ee31OpUvzg8FfY/QTxWI05lXy4q9JgfSXzHlkpH8=;
        b=CjfRvBXtk5i5Xc0ZdzxhlXcs6EzJ3HDHvvw90hsai0NQWMYh4BVN7SyD8MPJxgMsX2
         fawr2OarHEPHrRCNbke37VghpoPoddmKRes430hyquSOmwxN51y+QEEmmMkIB5h3H3ct
         6dougZSkZ0fFFf4gjEBFwHwp0A/eCDLpGCavEZAYYAyak4LHgDPC50gqL74WnfpSNYCV
         cbu3FVb0UQewre4PUoDMsNm9IaTmYCVG4jNNa4bvrSI4cgwhMw0YaN5tdo44rF2kbfpx
         KySmV18VtegfWdYRc5EneaS5TMWaIgSAHySbJzQ7QN48X4JQKBH4oVXEzfU30g+NWW2l
         sCDA==
X-Gm-Message-State: AOAM531ycehnEpArKKQxyMra/CmEwyZWylreQHxqDz785NwcOGT8YQmj
        8elzbO4LyM/ws81uES3aKv2WKyapORAfkDRjjfM=
X-Google-Smtp-Source: ABdhPJxOhlAyOcNwQOvH51CNS2hYtaoy06emMY4U2IfNaTOlQ6a0kqeATo2vF7jyuKGe8tf4x56/exC+gtf5mY27Qq4=
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr170639lfq.183.1592263825405;
 Mon, 15 Jun 2020 16:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200615034715.11438-1-zhang.lyra@gmail.com> <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
 <CA+H2tpF95rLRb8qbgCsrKBtjTV7JMTenuaYBHf19tpAXFqmqMQ@mail.gmail.com>
In-Reply-To: <CA+H2tpF95rLRb8qbgCsrKBtjTV7JMTenuaYBHf19tpAXFqmqMQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 16 Jun 2020 07:30:14 +0800
Message-ID: <CADBw62r2bUxM4hxwN86aOJ9-2j0Zo8H3PMB67A=e8DUB1c0F+Q@mail.gmail.com>
Subject: Re: [PATCH] mfd: sprd: get subdevices from DT instead for SC27XX SPI
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:08 PM Orson Zhai <orsonzhai@gmail.com> wrote:
>
> On Mon, Jun 15, 2020 at 10:12 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 11:47 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
> > > no matter these devices were really included on board. So with this
> > > patch we switch to a new way of detecting subdevices which are
> > > defined in the devicetree.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  drivers/mfd/sprd-sc27xx-spi.c | 102 +++++++++++-----------------------
> > >  1 file changed, 31 insertions(+), 71 deletions(-)
> > >
> > > diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> > > index 33336cde4724..aa3daa0cfcf5 100644
> > > --- a/drivers/mfd/sprd-sc27xx-spi.c
> > > +++ b/drivers/mfd/sprd-sc27xx-spi.c
> > > @@ -93,73 +93,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> > >
> > > -static const struct mfd_cell sprd_pmic_devs[] = {
> > > -       {
> > > -               .name = "sc27xx-wdt",
> > > -               .of_compatible = "sprd,sc2731-wdt",
> > > -       }, {
> > > -               .name = "sc27xx-rtc",
> > > -               .of_compatible = "sprd,sc2731-rtc",
> > > -       }, {
> > > -               .name = "sc27xx-charger",
> > > -               .of_compatible = "sprd,sc2731-charger",
> > > -       }, {
> > > -               .name = "sc27xx-chg-timer",
> > > -               .of_compatible = "sprd,sc2731-chg-timer",
> > > -       }, {
> > > -               .name = "sc27xx-fast-chg",
> > > -               .of_compatible = "sprd,sc2731-fast-chg",
> > > -       }, {
> > > -               .name = "sc27xx-chg-wdt",
> > > -               .of_compatible = "sprd,sc2731-chg-wdt",
> > > -       }, {
> > > -               .name = "sc27xx-typec",
> > > -               .of_compatible = "sprd,sc2731-typec",
> > > -       }, {
> > > -               .name = "sc27xx-flash",
> > > -               .of_compatible = "sprd,sc2731-flash",
> > > -       }, {
> > > -               .name = "sc27xx-eic",
> > > -               .of_compatible = "sprd,sc2731-eic",
> > > -       }, {
> > > -               .name = "sc27xx-efuse",
> > > -               .of_compatible = "sprd,sc2731-efuse",
> > > -       }, {
> > > -               .name = "sc27xx-thermal",
> > > -               .of_compatible = "sprd,sc2731-thermal",
> > > -       }, {
> > > -               .name = "sc27xx-adc",
> > > -               .of_compatible = "sprd,sc2731-adc",
> > > -       }, {
> > > -               .name = "sc27xx-audio-codec",
> > > -               .of_compatible = "sprd,sc2731-audio-codec",
> > > -       }, {
> > > -               .name = "sc27xx-regulator",
> > > -               .of_compatible = "sprd,sc2731-regulator",
> > > -       }, {
> > > -               .name = "sc27xx-vibrator",
> > > -               .of_compatible = "sprd,sc2731-vibrator",
> > > -       }, {
> > > -               .name = "sc27xx-keypad-led",
> > > -               .of_compatible = "sprd,sc2731-keypad-led",
> > > -       }, {
> > > -               .name = "sc27xx-bltc",
> > > -               .of_compatible = "sprd,sc2731-bltc",
> > > -       }, {
> > > -               .name = "sc27xx-fgu",
> > > -               .of_compatible = "sprd,sc2731-fgu",
> > > -       }, {
> > > -               .name = "sc27xx-7sreset",
> > > -               .of_compatible = "sprd,sc2731-7sreset",
> > > -       }, {
> > > -               .name = "sc27xx-poweroff",
> > > -               .of_compatible = "sprd,sc2731-poweroff",
> > > -       }, {
> > > -               .name = "sc27xx-syscon",
> > > -               .of_compatible = "sprd,sc2731-syscon",
> > > -       },
> > > -};
> > > -
> > >  static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
> > >  {
> > >         struct device *dev = context;
> > > @@ -205,6 +138,35 @@ static const struct regmap_config sprd_pmic_config = {
> > >         .max_register = 0xffff,
> > >  };
> > >
> > > +static int sprd_pmic_add_subdevices(struct device *dev, int id,
> > > +                        struct irq_domain *domain)
> > > +{
> > > +       int ret = 0;
> > > +       struct device_node *child, *parent = dev->of_node;
> > > +       struct mfd_cell cell = {0};
> > > +       const char *comp;
> > > +       unsigned int prefix_len = strlen("sprd,");
> > > +       char buf[30];
> > > +
> > > +       for_each_child_of_node(parent, child) {
> > > +               comp = of_get_property(child, "compatible", NULL);
> > > +               if (!comp || strncmp("sprd,", comp, prefix_len))
> > > +                       return -EINVAL;
> > > +
> > > +               memcpy(buf, comp, strlen(comp) + 1);
> > > +               cell.of_compatible = buf;
> > > +               cell.name = buf + prefix_len;
> >
> > I feel it is a little hackish, you can create any device nodes from DT
> > even the PMIC does not support.
>
> In the old code, if sub cells have wrong compatible strings, he will not get
> an opportunity to be probed.

Yes, that's correct, and that's what PMIC asks.

> It is confused to user for  there is no any error and warning message.

The sub-nodes of PMIC should describe their standard compatible string
in their DT bindings.

> I think it maybe better to let them being probed even when they might be wrong.
> The cell will check by itself --  return success in probing if in the
> right place or return error if any
> thing is wrong there.

I do not think this is reasonable, since I can hack the DT to create
any device nodes that PMIC does not support. But if Lee agrees with
Chunyan's change, I am fine with that.

> >
> > I am not sure the problem caused by the original method, you can use
> > the compatible string to be compatible with different PMICs, such as
> > SC2730 ADC:
> > compatible = "sprd,sc2731-adc", "sprd,sc2730-adc";
> >
> > Moreover I think you can add the "sprd,sc2730-xxx" compatible string
> > for the mfd_cell in this driver if you are sure we want to support
> > SC2730 PMIC.
> >
> > > +
> > > +               ret = devm_mfd_add_devices(dev, id, &cell, 1, NULL, 0, domain);
> > > +               if (ret) {
> > > +                       pr_err("devm_mfd_add_devices return fail ret=%d\n", ret);
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static int sprd_pmic_probe(struct spi_device *spi)
> > >  {
> > >         struct sprd_pmic *ddata;
> > > @@ -263,10 +225,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
> > >                 return ret;
> > >         }
> > >
> > > -       ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
> > > -                                  sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
> > > -                                  NULL, 0,
> > > -                                  regmap_irq_get_domain(ddata->irq_data));
> > > +       ret = sprd_pmic_add_subdevices(&spi->dev, PLATFORM_DEVID_AUTO,
> > > +                                      regmap_irq_get_domain(ddata->irq_data));
> > >         if (ret) {
> > >                 dev_err(&spi->dev, "Failed to register device %d\n", ret);
> > >                 return ret;
> > > --
> > > 2.20.1
> > >
> >
> >
> > --
> > Baolin Wang



-- 
Baolin Wang

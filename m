Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F65C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93B62078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJDZ6pSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgFOOMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgFOOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:12:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:12:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so9623535lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKMGjfcMRUl7J2etclsOS97ElWZBE5Q7aOMTyz9ND+A=;
        b=iJDZ6pSgXWA2DpEPQslpjTUoRWHNvgrT5fxCcZE9Ogj6aY+6eoYJr3nF3DirL3l3aF
         HSPfC5YgX6LZDn5Oums8pMkF6jvtsWtfUkVNlQUdvmQMAp9u/xRl4iuPUcW7i1XL0IPF
         I/6dcXAcJk3u2Zn1ZCu+qlo+PdNK2MdM717oNX0GT5f6ouVD0xzK8HjExWWUpdwCsNmp
         EJR6wVR8YZs+WzGvjsOHNl56PI4UdnXuRLpdB0A3dZpoAikHAaOe+K4gyHM+c3CWktTu
         h2yVjthOkV+VYIQYcoYMernKm7qBD7oGmOgfY01jc9DRMqhBmd6aM1zrC/0USMiKWSPv
         dKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKMGjfcMRUl7J2etclsOS97ElWZBE5Q7aOMTyz9ND+A=;
        b=KfyVcx6V2M64GIds7JwfcxDQ8HVte3lMiNJa4kGUk3BZMoqh2eDawQk960p67EQGYG
         34oXLvVlnRWjJyi8XUwTr0m8EP6leql8jz04VN0LP61c2gSu5MRXZEgsDwOm/ANvd5Zu
         jVt51oreBwDj5tlTQ04uXkUU/SNzXsLtGAMwxBfkptY5hHziUMpspQtVseQl546+edcQ
         KpcXz6g2huZDBFq2yaz4uwPh4vi1s5I3t5CAuHpbOchqwPLKF6xedxjw3jloOK5y9KNV
         t1cCFzZEb63A29p+dTGwvIcsiytNa+h1ulO0TNHykSyJBflR49QpdDlGdU2XAh9YnsO4
         QCmw==
X-Gm-Message-State: AOAM532ppKZ2RAKUWUO3sq6Ge4cdqa21kf0mnjpSi+IAmS8h7EID9bAJ
        WRfkWk+ZGoGdIdIn9xpRYgi3AG5PZugHgesnhMg=
X-Google-Smtp-Source: ABdhPJyW1CEU5lyYqc6F2KOdJ7wd5KQdMzOCsYw3M0ftUQKSElh3lbR4SiTgQ534mURBhENxoDDQN2dttlyLACOgKT8=
X-Received: by 2002:a19:d7:: with SMTP id 206mr476794lfa.104.1592230322831;
 Mon, 15 Jun 2020 07:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200615034715.11438-1-zhang.lyra@gmail.com>
In-Reply-To: <20200615034715.11438-1-zhang.lyra@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 15 Jun 2020 22:11:42 +0800
Message-ID: <CADBw62oCNrvTgu9k-iykaX4bbpVWjbg3GN+v5yPBCc9R2bR3Pg@mail.gmail.com>
Subject: Re: [PATCH] mfd: sprd: get subdevices from DT instead for SC27XX SPI
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:47 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
> no matter these devices were really included on board. So with this
> patch we switch to a new way of detecting subdevices which are
> defined in the devicetree.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c | 102 +++++++++++-----------------------
>  1 file changed, 31 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index 33336cde4724..aa3daa0cfcf5 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -93,73 +93,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
>
> -static const struct mfd_cell sprd_pmic_devs[] = {
> -       {
> -               .name = "sc27xx-wdt",
> -               .of_compatible = "sprd,sc2731-wdt",
> -       }, {
> -               .name = "sc27xx-rtc",
> -               .of_compatible = "sprd,sc2731-rtc",
> -       }, {
> -               .name = "sc27xx-charger",
> -               .of_compatible = "sprd,sc2731-charger",
> -       }, {
> -               .name = "sc27xx-chg-timer",
> -               .of_compatible = "sprd,sc2731-chg-timer",
> -       }, {
> -               .name = "sc27xx-fast-chg",
> -               .of_compatible = "sprd,sc2731-fast-chg",
> -       }, {
> -               .name = "sc27xx-chg-wdt",
> -               .of_compatible = "sprd,sc2731-chg-wdt",
> -       }, {
> -               .name = "sc27xx-typec",
> -               .of_compatible = "sprd,sc2731-typec",
> -       }, {
> -               .name = "sc27xx-flash",
> -               .of_compatible = "sprd,sc2731-flash",
> -       }, {
> -               .name = "sc27xx-eic",
> -               .of_compatible = "sprd,sc2731-eic",
> -       }, {
> -               .name = "sc27xx-efuse",
> -               .of_compatible = "sprd,sc2731-efuse",
> -       }, {
> -               .name = "sc27xx-thermal",
> -               .of_compatible = "sprd,sc2731-thermal",
> -       }, {
> -               .name = "sc27xx-adc",
> -               .of_compatible = "sprd,sc2731-adc",
> -       }, {
> -               .name = "sc27xx-audio-codec",
> -               .of_compatible = "sprd,sc2731-audio-codec",
> -       }, {
> -               .name = "sc27xx-regulator",
> -               .of_compatible = "sprd,sc2731-regulator",
> -       }, {
> -               .name = "sc27xx-vibrator",
> -               .of_compatible = "sprd,sc2731-vibrator",
> -       }, {
> -               .name = "sc27xx-keypad-led",
> -               .of_compatible = "sprd,sc2731-keypad-led",
> -       }, {
> -               .name = "sc27xx-bltc",
> -               .of_compatible = "sprd,sc2731-bltc",
> -       }, {
> -               .name = "sc27xx-fgu",
> -               .of_compatible = "sprd,sc2731-fgu",
> -       }, {
> -               .name = "sc27xx-7sreset",
> -               .of_compatible = "sprd,sc2731-7sreset",
> -       }, {
> -               .name = "sc27xx-poweroff",
> -               .of_compatible = "sprd,sc2731-poweroff",
> -       }, {
> -               .name = "sc27xx-syscon",
> -               .of_compatible = "sprd,sc2731-syscon",
> -       },
> -};
> -
>  static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
>  {
>         struct device *dev = context;
> @@ -205,6 +138,35 @@ static const struct regmap_config sprd_pmic_config = {
>         .max_register = 0xffff,
>  };
>
> +static int sprd_pmic_add_subdevices(struct device *dev, int id,
> +                        struct irq_domain *domain)
> +{
> +       int ret = 0;
> +       struct device_node *child, *parent = dev->of_node;
> +       struct mfd_cell cell = {0};
> +       const char *comp;
> +       unsigned int prefix_len = strlen("sprd,");
> +       char buf[30];
> +
> +       for_each_child_of_node(parent, child) {
> +               comp = of_get_property(child, "compatible", NULL);
> +               if (!comp || strncmp("sprd,", comp, prefix_len))
> +                       return -EINVAL;
> +
> +               memcpy(buf, comp, strlen(comp) + 1);
> +               cell.of_compatible = buf;
> +               cell.name = buf + prefix_len;

I feel it is a little hackish, you can create any device nodes from DT
even the PMIC does not support.

I am not sure the problem caused by the original method, you can use
the compatible string to be compatible with different PMICs, such as
SC2730 ADC:
compatible = "sprd,sc2731-adc", "sprd,sc2730-adc";

Moreover I think you can add the "sprd,sc2730-xxx" compatible string
for the mfd_cell in this driver if you are sure we want to support
SC2730 PMIC.

> +
> +               ret = devm_mfd_add_devices(dev, id, &cell, 1, NULL, 0, domain);
> +               if (ret) {
> +                       pr_err("devm_mfd_add_devices return fail ret=%d\n", ret);
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  static int sprd_pmic_probe(struct spi_device *spi)
>  {
>         struct sprd_pmic *ddata;
> @@ -263,10 +225,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
>                 return ret;
>         }
>
> -       ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
> -                                  sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
> -                                  NULL, 0,
> -                                  regmap_irq_get_domain(ddata->irq_data));
> +       ret = sprd_pmic_add_subdevices(&spi->dev, PLATFORM_DEVID_AUTO,
> +                                      regmap_irq_get_domain(ddata->irq_data));
>         if (ret) {
>                 dev_err(&spi->dev, "Failed to register device %d\n", ret);
>                 return ret;
> --
> 2.20.1
>


-- 
Baolin Wang

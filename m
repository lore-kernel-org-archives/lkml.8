Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3685DC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B594207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkBD7bGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgANKN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:13:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52783 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbgANKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:13:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so13072146wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVJ9vsBKjNHAquu2wHQplGsVSsF8ZvsB04D/QJeGvO0=;
        b=QkBD7bGtsftShAVXrNLgP1GUir8zjpVH0BFB90Jq5fahbPDtUfMTZaLzyDbhXOmO2A
         nmmqavi/LtNmqfhcGG7sHpIdRdVeANyAR8RL4ouV2QsNHaRbPadxRhtHfIck56dD+8uQ
         amPWIBI+kZVA3StySeTyIOizmVdjxn4elq6Rdd/Vu1fbnzP1X5G5zN3FMNkpg/tfZKNO
         UGRQ/dsX9XyZDxTxyBVv3AiujdGMR3zooptycedYQPYqK3O/q7SqsUJzB2EFcT7aHdzZ
         U49U6xkIT+sSUuwO26vUpxKWZ8RlksiqQkZ2jKW9qn3klff/vprVctHRbtLhH98FzmK7
         a1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVJ9vsBKjNHAquu2wHQplGsVSsF8ZvsB04D/QJeGvO0=;
        b=jwrOQ3HGCSbJo64ZlYuMcUiKh9HVPvQkUhVWi5AkvrxTU5MqrpCDXjZTrFT89MUw30
         AsGY3SaPcofcqV4PKlU+vgnr567U2uF1UuHeMjGhnOG5uv36mCn7j537LfUygb5blAG2
         QasDF/gA56ZN75OSUEphyIb5j8wIynMIRRV1a+dZu3IRGz2G7FpKDoBmdDlS0cknx3Fj
         DO34o43xioCJl6yoVvF4WvH8HAiDlNk1DuYm8mjss/WbVZS2+IG19VM1Gvhf7rNV3rSl
         9hB2PruVpHcH1xvToZzb7Qsk/p3w29vATJFdYXqIh1pjfUIv+/aSTIEHxtUUXPAsaabY
         8Eww==
X-Gm-Message-State: APjAAAUQIMEDwWKoTARRSIBcHb4GB1eTOAodWz5bKDJwmrYiuK2yxsD/
        FdyDohalktXcvu7fb4jp1WB5y+dzuXDCOtVdCQ/gLG7M9vQ=
X-Google-Smtp-Source: APXvYqxJZ24GiVlk9lUMDjJkGJEI6s3pmAanrQrR6ZjPBl+XBfGQsJAevyPjLoW5Oxheg/hE/D/XAZSaJTq3QWFkOzU=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr26748340wmc.9.1578996805060;
 Tue, 14 Jan 2020 02:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20200114094505.11855-1-ardb@kernel.org> <20200114094505.11855-3-ardb@kernel.org>
In-Reply-To: <20200114094505.11855-3-ardb@kernel.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 14 Jan 2020 11:13:13 +0100
Message-ID: <CAKv+Gu93rePi1MctP9ffr3wT2r-8OCBoO7Pw5ivWOcXgwfS4Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 at 10:46, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> window that is backed by the SPI command sequencer in the SPI bus
> controller. This arrangement has the limitation that only byte size
> accesses are supported, and so we'll need to provide a separate set
> of read and write accessors that take this into account.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis.c | 31 ++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index e7df342a317d..693e48096035 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -32,6 +32,7 @@
>
>  struct tpm_info {
>         struct resource res;
> +       const struct tpm_tis_phy_ops *ops;
>         /* irq > 0 means: use irq $irq;
>          * irq = 0 means: autoprobe for an irq;
>          * irq = -1 means: no irq support
> @@ -186,6 +187,29 @@ static const struct tpm_tis_phy_ops tpm_tcg = {
>         .write32 = tpm_tcg_write32,
>  };
>
> +static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
> +{
> +       return tpm_tcg_read_bytes(data, addr, 2, (u8 *)result);
> +}
> +
> +static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
> +{
> +       return tpm_tcg_read_bytes(data, addr, 4, (u8 *)result);
> +}
> +
> +static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
> +{
> +       return tpm_tcg_write_bytes(data, addr, 4, (u8 *)&value);
> +}
> +

These are wrong - I'll need to respin. Apologies for the noise.

> +static const struct tpm_tis_phy_ops tpm_tcg_bw = {
> +       .read_bytes     = tpm_tcg_read_bytes,
> +       .write_bytes    = tpm_tcg_write_bytes,
> +       .read16         = tpm_tcg_read16_bw,
> +       .read32         = tpm_tcg_read32_bw,
> +       .write32        = tpm_tcg_write32_bw,
> +};
> +
>  static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  {
>         struct tpm_tis_tcg_phy *phy;
> @@ -210,7 +234,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>         if (itpm || is_itpm(ACPI_COMPANION(dev)))
>                 phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
>
> -       return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
> +       return tpm_tis_core_init(dev, &phy->priv, irq, tpm_info->ops,
>                                  ACPI_HANDLE(dev));
>  }
>
> @@ -219,7 +243,7 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
>  static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
>                             const struct pnp_device_id *pnp_id)
>  {
> -       struct tpm_info tpm_info = {};
> +       struct tpm_info tpm_info = { .ops = &tpm_tcg };
>         struct resource *res;
>
>         res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
> @@ -295,6 +319,8 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
>                         tpm_info.irq = 0;
>         }
>
> +       tpm_info.ops = of_device_get_match_data(&pdev->dev) ?: &tpm_tcg;
> +
>         return tpm_tis_init(&pdev->dev, &tpm_info);
>  }
>
> @@ -311,6 +337,7 @@ static int tpm_tis_plat_remove(struct platform_device *pdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id tis_of_platform_match[] = {
>         {.compatible = "tcg,tpm-tis-mmio"},
> +       {.compatible = "socionext,synquacer-tpm-mmio", .data = &tpm_tcg_bw},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, tis_of_platform_match);
> --
> 2.20.1
>

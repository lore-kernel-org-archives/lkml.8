Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDDC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218D32078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCAldAMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgIDMgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:35:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A53C061244;
        Fri,  4 Sep 2020 05:35:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e11so7770088ljn.6;
        Fri, 04 Sep 2020 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zQq8tzm/HGpBwn2FA7z9vkYgOXhNDcv626gb3rtLwE=;
        b=OCAldAMtHThOn6cxAkixmpOBbuF2X9s0hjde9Tm4VZ8jXAn4fc0CU0V0E2RC+MrSAx
         PO/MBl0Fpj5m+Uv48bukVSPpyDZLREPp60yL4Bdz/b3V8pk8ntBt8vaMTm0pjJBYwK/Z
         UY/n5drsmrgJ0teKn37TtYK4pSx/12iIAouBDcUugUICHq+YnSypY5ZOjKhD/S2hx564
         ec80VlZN82cwFwYMUtcMo5QEXlHQgyQl6Vzj16KR6Zp2BGi4QHBbYfa5TGxRRbtLIDeJ
         FKnlUqvV7+3cGblIac9jD5IeEEQz5yAj+vgMcxASDWMt/hGxKm17iRbqg3llT7K3wOuH
         oq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zQq8tzm/HGpBwn2FA7z9vkYgOXhNDcv626gb3rtLwE=;
        b=jIcLkPZdi2Hkp5WsXE6OSMk9U5F8JXphxQ9r4NHK3YZvR14c7trQAIsn2cBy89ZUjJ
         aHvHE1DzwVXf+eslfzXhuJqExdH0rsHQLDAuroxrDlVNOBM7KOLUG+XPm7NACg/xKgfV
         +74UWd2+xpAFl3MyaC2XwbqvqpbYYN/pmdbLC+Z8R+dSvQSYji5Ebirug8GL1oKJdGyK
         c9afYB7cLNobZLWuCM49Ei+Zx/s9AlM9qu2HqD2rzo+ROuXcNCJDEUcZeNW7j7ugVZnL
         Q/0A+ocxgP0ZvSE7DRuT489bZusp//Pc3fuwGODXWgezezh+eFWmASaUKVTJOi6Bqryl
         takg==
X-Gm-Message-State: AOAM531q4YjUDHpAv5dPjr46HYc8ZmnG/p5Zq1F1Of+3OISpH790DhEc
        X++F6GSJOG/Rth0fMKRys6T2aKepjXwIhQsL9Eo=
X-Google-Smtp-Source: ABdhPJxij5kxwBOGgOGBLbBCNP/8Ao8v4wC249amU4OSMif6DmD1Mc+OWkrBWzi2bo09EbcDzXxuYJCUqFtAuBhX19U=
X-Received: by 2002:a2e:390a:: with SMTP id g10mr3459414lja.218.1599222949595;
 Fri, 04 Sep 2020 05:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200903144028.20416-1-matthias.schiffer@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 4 Sep 2020 09:35:38 -0300
Message-ID: <CAOMZO5DGHoG_8X+fbrGCHR4g=sGdEaF7bYrHbC_2T=aUnfTs8g@mail.gmail.com>
Subject: Re: [PATCH] spi-imx: remove num-cs support, set num_chipselect to 4
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, Sep 3, 2020 at 11:40 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> The num-cs property is not considered useful, and no in-tree Device
> Trees define it for spi-imx.
>
> The default value to be used when no cs-gpios are defined is set to 4 to
> give access to all native CS pins of modern i.MX SoCs (i.MX6 and newer).
>
> In older SoCs, the number of CS pins varies (for example the i.MX27 has 3
> CS pins on CSPI1 and CSPI2, and only a single CS on CSPI3). Attempting
> to use the nonexisting CS pin would be an easy to notice DT
> misconfiguration; making the driver catch this doesn't seem worthwhile.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/spi/spi-imx.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 197f60632072..aece8482739b 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1581,7 +1581,6 @@ static int spi_imx_probe(struct platform_device *pdev)
>         const struct spi_imx_devtype_data *devtype_data = of_id ? of_id->data :
>                 (struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
>         bool slave_mode;
> -       u32 val;
>
>         slave_mode = devtype_data->has_slavemode &&
>                         of_property_read_bool(np, "spi-slave");
> @@ -1605,6 +1604,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>         master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>         master->bus_num = np ? -1 : pdev->id;
>         master->use_gpio_descriptors = true;
> +       master->num_chipselect = 4;

On an imx6q-sabresd, which only has one SPI chip-select via GPIO, this
makes the SPI core to understand that it has 4 chip selects.

From spi_get_gpio_descs() in drivers/spi/spi.c:

ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);

It is 4 now after your patch, it was 3 after 8cdcd8aeee28 ("spi:
imx/fsl-lpspi: Convert to GPIO descriptors") and 1 before such commit.

Couldn't we just remove master->num_chipselect from the spi-imx.c driver?

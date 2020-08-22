Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484E8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1057F2078D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQkQhG80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgHVOyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHVOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 10:54:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317FAC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 07:54:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t10so5943319ejs.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mbzm5gpuiwO9tFrWmdPpY3arq5Fa+qKMjnEd29bPLpQ=;
        b=FQkQhG808JI0eCeL5TQ57rNtCCg1AYXnUaZ+z+bIXDm0JphY/3kTObu2x7RD3HTTTE
         J/4DdcSBvZEl3HzlW99RxNL4Ctxtq7j2efM5diD9FiLMYPYVjnlCzbrlPS7Reu+anrxL
         fbO+3Lp90y+V28Qscu0lHKi06nifW+YbDpIJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mbzm5gpuiwO9tFrWmdPpY3arq5Fa+qKMjnEd29bPLpQ=;
        b=YRsnNDChMJf5r8wXQJ9Qgffy/bY4pJNM4pGrZ43rnKbMiTkLQzB4PCuIGL0x5VCrJB
         8o9K3dfDBeTbBpialsLNhvlkhC913c+x3tNJI4JVBpz6eQjQB3ioBXy+FVTebgqsnqS8
         LuJe/15C6AMSKEz3tj/l8x9OyyceqkkG3CNncPYpxN8bgRQtMjQdYzAhu7vOBnt86zYb
         DKY65jYPj1jWkGFEDyjmhD9vW3aW0mRBPuvR35VzAgWPfoo+5WeiMfaOczY5xwX/5D4p
         IYYUhSxdQ/3tTO4vz/PLDEZYI6jBhsMV8UbVbILYU0DeXWwL1bMsRc7n7a1+waarBLQY
         zZSQ==
X-Gm-Message-State: AOAM530dopCs9m0cBxJXUSRpZsCd2FgLzszdRhwP6Ve1VBqi2QdCdhgQ
        6qZjjC9ptNgubpxWW4pNNt22dZoDKthqcA==
X-Google-Smtp-Source: ABdhPJyuSfw/p8c522bCWjAlgES5+36RBN5LqoPq+r4wvbfJTaw2YpAqmLu1YfdgDkFPerPWnTijiQ==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr7370044ejb.340.1598108073606;
        Sat, 22 Aug 2020 07:54:33 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 24sm3013746edx.35.2020.08.22.07.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 07:54:33 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l2so4516082wrc.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 07:54:32 -0700 (PDT)
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr7016601wrn.385.1598108072233;
 Sat, 22 Aug 2020 07:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200821161407eucas1p249e4833b8839f717cc2a496ab43bb8a2@eucas1p2.samsung.com>
 <20200821161401.11307-1-l.stelmach@samsung.com> <20200821161401.11307-8-l.stelmach@samsung.com>
In-Reply-To: <20200821161401.11307-8-l.stelmach@samsung.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Sat, 22 Aug 2020 16:54:19 +0200
X-Gmail-Original-Message-ID: <CAAFQd5DKCsDOQXcaAqB0h8V8rdo_EcBevgkPO1LzU7FZJ+r_hg@mail.gmail.com>
Message-ID: <CAAFQd5DKCsDOQXcaAqB0h8V8rdo_EcBevgkPO1LzU7FZJ+r_hg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
To:     linux-spi@vger.kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 6:14 PM =C5=81ukasz Stelmach <l.stelmach@samsung.co=
m> wrote:
>
> cur_speed is used to calculate transfer timeout and needs to be
> set to the actual value of (half) the clock speed for precise
> calculations.
>
> Cc: Tomasz Figa <tfiga@chromium.org>

As we talked on IRC, Lukasz forgot to add:

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>

Would be nice if it could be added when (and if) applying.

> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 02de734b8ab1..89c162efe355 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driv=
er_data *sdd)
>                 ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>                 if (ret)
>                         return ret;
> +               sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>         } else {
>                 /* Configure Clock */
>                 val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
> --
> 2.26.2
>

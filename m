Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71F420756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhIr6KoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgERLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:24:03 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E3C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:24:01 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id f9so1151639uaq.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NrexrNb88DzhWjg1accwpxlE36qK5WbdKw5yFdpiOY=;
        b=bhIr6KoP/7JDIFZg1/+ZJ7uB6Eo9CU1AHTOjy0RHtzeKoIXN4B8VDJFJfXceiP6WPI
         5KoDw0IKcM7T9T2Y1Tpv1T9izX6ADCWSKvxniWt3I47DFWSkEzd+E6rlQzNSPud8gv0A
         ptjAyBqcVVoGuFxzS3hJf6RB8vD0ZPhOmdWuy68O9hXNmoGOwxfHkQRKhN8RJBIg9HWd
         ifb7HH0WM+H1evmtDuSa7Tuuno0O5JpT3i5UOsmcFdmJumgoStOIi7p5avLb22xSDROE
         ILTz9YQKvwc/+ZdSj/PAojpBHM4Snyc6S9t6s1h+xrEzqK08DK1y+6gJ6JodWtXtCvju
         983g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NrexrNb88DzhWjg1accwpxlE36qK5WbdKw5yFdpiOY=;
        b=Ocdutg2aQgt8+Wy134hUFp/J0K/TSRE0dwaTHgPWX/1DUUaCFvFLkDFx0o3/3phpTq
         852mKnz8HGKsg9yP5EQhTrwPXErkYnsS8kwLFXSbZdTYvMDNKXj5dmR4eR3jiqcXBVyV
         EPpEhwL4tmxPZ0xPf14It7/ETvPasfl157ZCB4t1NlMD5kR/9r7f+lm3uUnNsMO2Q47o
         uD902pl4gAzlWU5wtPIs2XWy1mBJykA808d5KOcF6B9U68gkr6AnxYm7YGtW90MnE3ja
         D4EbtOcmUx9V3vj0KrnNUJUP4NgVBRfMaf6xmANYT0SoDMBYp+ehWmE+9rT0VFFngAJk
         S4dQ==
X-Gm-Message-State: AOAM531K/YhsgPgULULS+pUYm+d9/rdRFC+t67w8Qx3ybrPJHvSLRZlg
        eeYsK/8cbvhFCLI3z750Bif3rypRv5KS2pmpmShFuw==
X-Google-Smtp-Source: ABdhPJwQhXupbBSuJ+hHwMN84vnYBg4shImkGSdF0QuDl2EYLw84KTUNHMpMakjTHXlNhtlZdKXb8AP0fPGmjtmCvzg=
X-Received: by 2002:a9f:26e2:: with SMTP id 89mr10991422uay.104.1589801041024;
 Mon, 18 May 2020 04:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com> <20200517222907.1277787-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200517222907.1277787-2-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 13:23:24 +0200
Message-ID: <CAPDyKFpPXNB6mvovCH73BbtvKS=GPpUoBxn_0_EfbudebjZDWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: host: meson-mx-sdhc: don't use literal 0 to
 initialize structs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 at 00:29, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Kbuild test robot reports the following warning in lines 56 and 87 of
> drivers/mmc/host/meson-mx-sdhc-clkc.c:
>   Using plain integer as NULL pointer
>
> Drop the integer value from the struct initialization to fix that
> warning. This will still ensure that the compiler will zero out the
> struct so it's in a well-defined state.
>
> Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> index ab0d6c68a078..e1f29b279123 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> @@ -53,7 +53,7 @@ static int meson_mx_sdhc_clk_hw_register(struct device *dev,
>                                          const struct clk_ops *ops,
>                                          struct clk_hw *hw)
>  {
> -       struct clk_init_data init = { 0 };
> +       struct clk_init_data init = { };
>         char clk_name[32];
>
>         snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(dev),
> @@ -84,7 +84,7 @@ static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
>  int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
>                                 struct clk_bulk_data *clk_bulk_data)
>  {
> -       struct clk_parent_data div_parent = { 0 };
> +       struct clk_parent_data div_parent = { };
>         struct meson_mx_sdhc_clkc *clkc_data;
>         int ret;
>
> --
> 2.26.2
>

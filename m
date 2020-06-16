Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F935C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068CC2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VK0MaGVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgFPLeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgFPLdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:33:44 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1EC08C5C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:33:44 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q10so4715048vka.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3xurtsGxG5+pBj/Wd/EiagOHM+i8tFxNIlSk/FHDFA=;
        b=VK0MaGVKyzGVAsortmOAkqQBfDxQ17xbC+E5ynMMCx+V6YoKoddQvXDG6GVU74fLDE
         3AOFqiB9yyL/7Bx9YbSZLLalzmmfXNKl6UgP0RgUNX3H7O8go3qlIWEaicPbap/w/fXa
         4Dhyg/QJIX3D4Sla8YWYe2UxMKRASkzm3vhhJ92d+92UAs26cKGtLdQHKIY+0/lLV17o
         EXPHDXICY8O7sHOyRdGyfYzx8DP/K2SXD3XSK5Ng/Eqjth22KJy3v6SHvbp8TdknSgHv
         DfOVaqgwFbXbUHUJLXtQCjdgXitPvvjeBqi3BmhG9GCsQleQY/b0GQ/ZXogtXQe8XA02
         3SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3xurtsGxG5+pBj/Wd/EiagOHM+i8tFxNIlSk/FHDFA=;
        b=STK7NvaD5jKz4qkuW8oJsIC0Q9DIRlWDjU+nHQzTY6UvRssQPl9X0RGlh3eJKQqK7P
         GNRbx8MXCaoagCCjFgsZZObEPk14mqTjTUvox0L/AEC1XhMsSpQrDPXPnMWSJuvil+pZ
         dpw+sUA7PrbGlkNFj5E/tXE1qjRxTXeYf7oxoYnDPs0QW94gdEsCw/QaHstahf04xX2L
         t9wKYLzDlIbjOTxKkcGlDsTlWOBA9nFTeETJ7DYYI8Dn9Uc5VBKz56YKCBck7p5ZQsQ5
         upfmROXOrZf4g9qZYzKKL9slYbOWxafW0w14qnkCprfkhU+vv1MdsuGk10uc5CT/P30k
         PPzw==
X-Gm-Message-State: AOAM533awIQdKd89HIZsxs3sasb08HuYiC2MnBFBaSW9cHmXhoggaY2W
        3uh7LjbCYzjaEYJ7j24ONcohn2ZjAGGa1lZt3PGxEw==
X-Google-Smtp-Source: ABdhPJwISf1vfOjyjum1tJCBaNteiqD3S1uRqKWFGycL6f89hwszildCgajIP6J3PoKnXdvffL4CBueNZTWeqBkPb0Y=
X-Received: by 2002:ac5:cc44:: with SMTP id l4mr1143248vkm.43.1592307223208;
 Tue, 16 Jun 2020 04:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200611132839.4515-1-ludovic.barre@st.com>
In-Reply-To: <20200611132839.4515-1-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:33:06 +0200
Message-ID: <CAPDyKFpeEdvFWj98LRHtckVRzzz1TaHcYR5AFJSMujuRCDoVgw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: add sdio datactrl mask for sdmmc revisions
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 at 15:28, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> This patch adds datactrl_mask_sdio for sdmmc revisions.
> sdmmc revisions used same bit of previous ST variant.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index a69d6a0c2e15..b5a41a7ce165 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -267,6 +267,7 @@ static struct variant_data variant_stm32_sdmmc = {
>         .datalength_bits        = 25,
>         .datactrl_blocksz       = 14,
>         .datactrl_any_blocksz   = true,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(12, 5),
>         .busy_timeout           = true,
>         .busy_detect            = true,
> @@ -292,6 +293,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
>         .datalength_bits        = 25,
>         .datactrl_blocksz       = 14,
>         .datactrl_any_blocksz   = true,
> +       .datactrl_mask_sdio     = MCI_DPSM_ST_SDIOEN,
>         .stm32_idmabsize_mask   = GENMASK(16, 5),
>         .dma_lli                = true,
>         .busy_timeout           = true,
> --
> 2.17.1
>

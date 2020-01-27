Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77FC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E2F20702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkdUqd2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0HXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:23:08 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41586 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgA0HXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 02:23:08 -0500
Received: by mail-vk1-f196.google.com with SMTP id p191so2285725vkf.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Zs7ordlPu6oLMie0ztw+ViABr97RTMvxSHDoSvg2y8=;
        b=ZkdUqd2zKSeWdVR91y36SdzJKYZWn6y3ItuefmZXZQ65FE7TOnAneczRyXuYZ73Q09
         dxyrhyivxIhtQcR2Niso9FYPdVIMx7MpX3rk2ZMJ0xzAOkFCuRZxaewbU0pVz0EnbFTf
         RwBf8kQhz4qiuQMkW/EoW11SdohZV+sqIYsjjZXPVt4bwAZ+59aKtKpOT4x+mz3DATbJ
         l8XSQjy40AFGHpBJmIXEwQ54J73jRsoZi6Gy68//Pw8gcbJwFQ77p8u1E4EGmL7UpgvB
         JZ/1N0idA75Y+pP1l/5Pl9EJcLI54QRiC4BtLNNHuB7wI92mBOYSLhRXl9HWHp1fHViD
         6DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Zs7ordlPu6oLMie0ztw+ViABr97RTMvxSHDoSvg2y8=;
        b=mC+s9skAFnv7yni5BNYQiPEvFVWVyOz8FL7i6cNISXQt41hMLP10ls9udLCqXlGk6q
         g8y3FsD7q8/mh/ZC8TMlLkgKB6vljZLdKz5c3gg29pxlf9yXCM7eLVa17alnGxOzd7hT
         fVAD37x0PLvvrj2td4uIZyWjPrFY7MP2By0OIR4JaHJSXApZrH6Ce+HNsPbUcW6o7JlX
         7VIliVu2B7jSBsG8Gm8OuiAJ2k+UT1sPOxI7cT8ApHDYOw5t8UMKuutw50kBIu+7LWFs
         pRL9MsuEcFtpQ4BRbSxO4qcvCQKmoPZX+prbhzRtvKDHzVV2edKmzUGd6VHq7dVJoMj6
         Fmqg==
X-Gm-Message-State: APjAAAU7bhKopjpuSgY5KQVjY+tXBw6XbRo84labm5r7Aw2mxVKPlMa+
        N/pwKqK7dbZ/CkOtKrxpWKYCxJf/kEwNVWVVjSA3Lg==
X-Google-Smtp-Source: APXvYqz4OQZA/2kIUqEb6B2klRTdDoZkhD2PvmDkLDercb9w5oGLFffYnzmHjIgmSkCuBSvVCAvCAxfvm+k7OKQr2M8=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr8497371vka.53.1580109787392;
 Sun, 26 Jan 2020 23:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20200126115247.13402-1-mpe@ellerman.id.au>
In-Reply-To: <20200126115247.13402-1-mpe@ellerman.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Jan 2020 08:22:29 +0100
Message-ID: <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
Subject: Re: [PATCH] of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020 at 12:53, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> There's an OF helper called of_dma_is_coherent(), which checks if a
> device has a "dma-coherent" property to see if the device is coherent
> for DMA.
>
> But on some platforms devices are coherent by default, and on some
> platforms it's not possible to update existing device trees to add the
> "dma-coherent" property.
>
> So add a Kconfig symbol to allow arch code to tell
> of_dma_is_coherent() that devices are coherent by default, regardless
> of the presence of the property.
>
> Select that symbol on powerpc when NOT_COHERENT_CACHE is not set, ie.
> when the system has a coherent cache.
>
> Fixes: 92ea637edea3 ("of: introduce of_dma_is_coherent() helper")
> Cc: stable@vger.kernel.org # v3.16+
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks Michael for helping out fixing and this! The patch looks good to me.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/powerpc/Kconfig | 1 +
>  drivers/of/Kconfig   | 4 ++++
>  drivers/of/address.c | 6 +++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1ec34e16ed65..19f5aa8ac9a3 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -238,6 +238,7 @@ config PPC
>         select NEED_DMA_MAP_STATE               if PPC64 || NOT_COHERENT_CACHE
>         select NEED_SG_DMA_LENGTH
>         select OF
> +       select OF_DMA_DEFAULT_COHERENT          if !NOT_COHERENT_CACHE
>         select OF_EARLY_FLATTREE
>         select OLD_SIGACTION                    if PPC32
>         select OLD_SIGSUSPEND
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 37c2ccbefecd..d91618641be6 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -103,4 +103,8 @@ config OF_OVERLAY
>  config OF_NUMA
>         bool
>
> +config OF_DMA_DEFAULT_COHERENT
> +       # arches should select this if DMA is coherent by default for OF devices
> +       bool
> +
>  endif # OF
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 99c1b8058559..e8a39c3ec4d4 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -995,12 +995,16 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
>   * @np:        device node
>   *
>   * It returns true if "dma-coherent" property was found
> - * for this device in DT.
> + * for this device in the DT, or if DMA is coherent by
> + * default for OF devices on the current platform.
>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
>         struct device_node *node = of_node_get(np);
>
> +       if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> +               return true;
> +
>         while (node) {
>                 if (of_property_read_bool(node, "dma-coherent")) {
>                         of_node_put(node);
> --
> 2.21.1
>

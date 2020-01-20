Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607BDC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30031217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKradegz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgATL0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:26:21 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39604 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgATL0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:26:19 -0500
Received: by mail-ua1-f65.google.com with SMTP id 73so11354054uac.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrZ1cNWXoOZ8fT2ookeU6LfhGU/rpts+myRvZ+HzI9g=;
        b=xKradegzNxSm3JodVwC8bDFeNs++luNLFd954kpauwz05VkHKs22WVAAAHoISqjY9I
         Os+sr4vpFUHCEs37s+t9iE0oe8OJE07ZZz1WYNUTDZkwif3cWH0dK2me+/qm2oIspyd9
         hgOcInRmbxlQdqoDb9vD6f24Qo+KGRRtyNPTzQz4J8VYdvRJDRpHfNw6YrUEH23OfgOy
         U1f4UtJB9n1kz1YwMzlAdrmMhKVI8CtdQMyE2LgsqM70i/8lHF9ixb0F5477R72BnIfz
         Zs2gFdiJ4Diw/xRrLzfW/kmD25+fwCREa1p7dPFym6CF1i7mXod0rdQRWmOO+JEWAH+N
         IPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrZ1cNWXoOZ8fT2ookeU6LfhGU/rpts+myRvZ+HzI9g=;
        b=Z7xbER0pfqPkCaVmQihqsnTlKHKvwxMs7YifG6SeZ0ZwAjFXHJNxVvJIctsGvveM0Y
         k+cWX84R1byo/7TbDpGaohwit1T5kEkClQnzdiy9zsh/3lLVdkl5UA3IoJbotuWqLolw
         CWxonbg6LlCRlLVepkCM9LKYX0J2qiL98EXkBB8PAjwtUk/SWnxG99KNrAKZOvLlzB9p
         sRjWdkdTBurKjUR0hFb3BjYPa42neqL/JhevNm0pXC8IVl/TfrpyeKgBXQGW0E1lcqDl
         CT45uu9uqcdnDpilMumtpvVp3soespLk3V/YooBMrucLKzdztklcNWoegKgi9v9pir4J
         zZ1w==
X-Gm-Message-State: APjAAAWdjYOfYvMer55oKvN+YDl7mwvR5WHVZrnbdwiEtDPzB6pZ9blB
        bNUBmqAMk3cRBuRz1fYiwMGY10Ix/Z+aCkuWJV9sYw==
X-Google-Smtp-Source: APXvYqwq5TZL0CTugyzzhLsfXuM5qOx0iPR5cC/kQQ7lRFAo8Jmioch3YNf9suiAcbDOUQ35/hh4rHffHCEm5/Y7CMw=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr27445303uak.129.1579519578171;
 Mon, 20 Jan 2020 03:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20200116144322.57308-1-yuehaibing@huawei.com>
In-Reply-To: <20200116144322.57308-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:42 +0100
Message-ID: <CAPDyKFqsB3rEF4z-13hvnc2L-xtS-KAPFtDE1uO9kz9T=_4kXQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-milbeaut: Remove redundant
 platform_get_irq error message
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Takao Orito <orito.takao@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 15:43, YueHaibing <yuehaibing@huawei.com> wrote:
>
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-milbeaut.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
> index e6245b7..92f30a1 100644
> --- a/drivers/mmc/host/sdhci-milbeaut.c
> +++ b/drivers/mmc/host/sdhci-milbeaut.c
> @@ -246,10 +246,8 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
>         struct f_sdhost_priv *priv;
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0) {
> -               dev_err(dev, "%s: no irq specified\n", __func__);
> +       if (irq < 0)
>                 return irq;
> -       }
>
>         host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
>         if (IS_ERR(host))
> --
> 2.7.4
>
>

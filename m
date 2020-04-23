Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE997C55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A1E2074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChWtq2qC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgDWMWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbgDWMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:22:50 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E66C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:22:50 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g10so5434877uae.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyUQ7T8MwRaHdAPJI7abXp96xTwq2Ak4XCoyE0/mFoQ=;
        b=ChWtq2qCG6vmtUnCPeAh/FqZWblKxfoNudH6cu384x+CsD7qz1RejBLCFeNJZdALHm
         WLNytixc2qCta9LmMZR5Dkq+HF2jc6Ekb/Knpdm6GwiydKs1DezizCTb/+E+u7pnGZjR
         ER81O0Jdx8+YTfl4m5cFYJB7hNhs60t7FBuAmXPk1DJVNSqMqmU13nHT0AKfoBf2THdl
         s1fzInLdp9aZPAzN7pG/X0AM1CIelYrrpHBO4oOAtgxpXJQsvZ5RWfvgWx2YeUn1BeA2
         0696F74qbe3DA0Ux+KfFTFFGabHUo9u39htTbgcRcbq8NsSNaTzLJ4ThO3RA29otxbdG
         Pj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyUQ7T8MwRaHdAPJI7abXp96xTwq2Ak4XCoyE0/mFoQ=;
        b=P4T6+ilXBD5cpBbecy4mMcS4xkAhCUC3ge4O3K0zw6W/GeTBoaZ4IDsT6E8aawW8K0
         uFf1ADMNSFrsAyqw9Xo72dOp9f2at/Dzkzu+FBeGczifFnt8HFevuCwmK8PsRDRHTDla
         TEGV4WOGwS+/Hg+QvlMR5FA/RdlzV7oBzGlYULmzNjzhjmGHnGsunrogfnKkCrbEbkCw
         Q1ZpsHTs2RMZm0TVuf8BkYsUE4mXfPKlW+/nduuoTF6NgdrQo6cVhYPr/k/t2MkKp0on
         YNh5m6t3ak0xAGDN8uiBzSlZ3vQBXrIPdxfDLY6e03W130ow/GaBNV7TiTr1jDS2Dckv
         HkBg==
X-Gm-Message-State: AGi0PuaOF55j851/bAPZVTkm6EkA1n5ilALXS1kN5qzwAjIwCROy+vUu
        EXkQxfWuJp/2+rblOy4THgp3olxyPzuhW7l3huPp4BNa
X-Google-Smtp-Source: APiQypI27h2BwPBCTt2BxeblVULnXnm/xZO3WRP0gskCwfE0EhLH488F/9dK+nAA/BrI7RBNxa32nBsVgzlLXVu3nH8=
X-Received: by 2002:ab0:3343:: with SMTP id h3mr2687570uap.19.1587644569030;
 Thu, 23 Apr 2020 05:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <1587624199-96926-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1587624199-96926-1-git-send-email-zou_wei@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Apr 2020 14:22:13 +0200
Message-ID: <CAPDyKFoOKFAH36CeuX8kBG_4iQFZCAGS02_WmkqFsYwWqMYeSQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-pci-o2micro: Make some symbols static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 at 08:37, Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> drivers/mmc/host/sdhci-pci-o2micro.c:497:6: warning: symbol
> 'sdhci_pci_o2_set_clock' was not declared. Should it be static?
> drivers/mmc/host/sdhci-pci-o2micro.c:512:5: warning: symbol
> 'sdhci_pci_o2_probe_slot' was not declared. Should it be static?
> drivers/mmc/host/sdhci-pci-o2micro.c:581:5: warning: symbol
> 'sdhci_pci_o2_probe' was not declared. Should it be static?
> drivers/mmc/host/sdhci-pci-o2micro.c:786:5: warning: symbol
> 'sdhci_pci_o2_resume' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index fa81050..e2a8468 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -494,7 +494,7 @@ static void sdhci_o2_enable_clk(struct sdhci_host *host, u16 clk)
>         }
>  }
>
> -void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
> +static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         u16 clk;
>
> @@ -509,7 +509,7 @@ void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_o2_enable_clk(host, clk);
>  }
>
> -int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
> +static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_pci_chip *chip;
>         struct sdhci_host *host;
> @@ -578,7 +578,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> -int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
> +static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  {
>         int ret;
>         u8 scratch;
> @@ -783,7 +783,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> -int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
> +static int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip)
>  {
>         sdhci_pci_o2_probe(chip);
>         return sdhci_pci_resume_host(chip);
> --
> 2.6.2
>

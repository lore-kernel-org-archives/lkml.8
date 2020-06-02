Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B85C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42C0205CB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdP/HTAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFBMIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:08:47 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E46AC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 05:08:47 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r10so1847390vsa.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSuH2ssktub11HVh5aT9ohujVQl3LgmK1DCQrcyOdK4=;
        b=sdP/HTAc6nXvL2hGmEyTJX1onSxGxWIY6PHm/zgiPj9SZ3UM5VttWUSZe/sOgq/MZZ
         U5TT7H0KEG1pqN+lFLfQM1VxuV8w463jq3ABTdMXXfMbpJCs5399RzIPLvqnhucb6GAl
         7iOr3OmMV6vw34Yv6PTRBYIqqEol9qcdDwUmXlsDAld90htUNi4dsyk2JITMTGIRiNd3
         vzIgtWplScORNH73BAJpSSHOtvB02HkMGZ6f+r7UrOOgDJPbaO2Bx3W2DNQ4f18NPEwC
         AsjLV8NEq87T/0/xJPQy2sZD/G6JmsH0U6J02UVo1BZsaCexTWXghuio6UNP7RrguPZp
         3EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSuH2ssktub11HVh5aT9ohujVQl3LgmK1DCQrcyOdK4=;
        b=gmsHQf4jB9qptqVw0M0QbZoNrHsChrJbW6HkGQPewFQZWnZX3sC3ksoT5AUg0fiSee
         joGOfgoXlS+jf8oLaEAKLszB5L5R3DtTtocSQHypKc37tv6ECLBPiLX1F5bKj+Mpls1R
         n75HDXPST7OzOLG+5lZd9UidE0Khp9w9z/wNhi1oHoXpAtj3qU1gSJeiYCLiIM5h9Q88
         Ike/0ih5llTSdYsG1iANOnzlOHM26+IMC9FuPXgCnWhOisZBueanOlpfSVdh0yCOJ6Xb
         LgSwROqmI9vJM7TeViFTBbkXJzj7Ys84yVYefuDd+ZHwO4LpjsAeAqt73AkGCv2Gross
         RGIw==
X-Gm-Message-State: AOAM532Pii1pkr4gqPN/m+8lsE7cKQwZJj54vzc77EPyFMCLA2SefBjc
        Im/fwOVO+lOUI8p+V72CNua8/wnqCcryDe0Sp2TbEQ==
X-Google-Smtp-Source: ABdhPJyCtNOeEAjxDqkMYPhZ7bNVvPVy8jRF7ZOw9E68bhQL1DI1tGywmSvr5kkH3BJaBkHt3jezR/MNUIIptIMnDzw=
X-Received: by 2002:a67:8983:: with SMTP id l125mr7222076vsd.34.1591099726569;
 Tue, 02 Jun 2020 05:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Jun 2020 14:08:09 +0200
Message-ID: <CAPDyKFqdwURZvBa=6p_=KqGA0AOfJW0os04wMJpOTsnpsxP4AA@mail.gmail.com>
Subject: Re: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where appropriate
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 11:21, Piotr Stankiewicz
<piotr.stankiewicz@intel.com> wrote:
>
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
>
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-gli.c     | 3 +--
>  drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index fd76aa672e02..d14997f9cbf9 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -271,8 +271,7 @@ static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
>  {
>         int ret;
>
> -       ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
> -                                   PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +       ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
>         if (ret < 0) {
>                 pr_warn("%s: enable PCI MSI failed, error=%d\n",
>                        mmc_hostname(slot->host->mmc), ret);
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index fa8105087d68..498c51207bfb 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -470,8 +470,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>                 return;
>         }
>
> -       ret = pci_alloc_irq_vectors(chip->pdev, 1, 1,
> -                                   PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +       ret = pci_alloc_irq_vectors(chip->pdev, 1, 1, PCI_IRQ_MSI_TYPES);
>         if (ret < 0) {
>                 pr_err("%s: enable PCI MSI failed, err=%d\n",
>                        mmc_hostname(host->mmc), ret);
> --
> 2.17.2
>

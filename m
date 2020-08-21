Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D9B2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gna3F4cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgHUMtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHUMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:49:16 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8414C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:49:15 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i20so382000vkk.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQgK+SNMvMHD2kMEy8rXU+kpyN6Xvc8FHA+4wVp0ysE=;
        b=Gna3F4cQeMdRPcx3MCe9fCAP6nafVCC1qEUsyb9rU2Au9Y4znu+61ohEmEmWjcq8JG
         ssjcV0YRJUQlItcSkspzyh+tjBRXSXFqc4GOnR3eOU6GlzFluiYEtFw+Rh7hZlftS2bt
         Mhm5S5M5v4SvAYTiEpkiL7NJuppdQklwADY47Oq3DRtqTBJ13lagaF+eTtu9ocArbjHd
         Pn8d6RL5KZlsZN48xthW2uuAiz9xzoUDO+BCZtfVkNDFYIfdgX+eYWR/M1vKbgdNUA8I
         by3cIZu6Ls+6ttjTsJcLdN36RJLVg8JdlC0imjFUazgjgyJpZRrldRmHVbLvOiTk5TpV
         0Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQgK+SNMvMHD2kMEy8rXU+kpyN6Xvc8FHA+4wVp0ysE=;
        b=GYqCPtF8W7KT/MG7/WEKQHN7BRX/5hbBvjOrqYTHlwo4AvsFFDVwxs792H0zNIu9Ct
         pgLSc68l499GYNPNoDkCn4FHKtngJtJs+ZEW/DkcRl3EC1usd2gU9wDsg12PkTQOncZq
         3UjuDxE/I2a7hK1C1ojnEnk68H2FwHJ8DK5y6yyEC9txmasstRlboVTZB7Zearaqewiq
         dHG/IshWhKMkaVcmqFMfhqbnEqwOupWqXjki2ir3TAuFEglj4PSinAR8IDoYYzVOAKls
         41hsRLTa1VB2LNRmnsW4YPMI/pIOKToQ0rBKxML7ngAu5FjSX1LBZD/GqMrHgKS0P9vl
         n/6Q==
X-Gm-Message-State: AOAM5303YP/NgdzIq1j5AOrpxGt5DIlrYSVeTFvDDz4qXJQGidhjDCHM
        QLimaKUtRAqUY6YY9B0Dx6MoIMxz9QD6Zybb4B06LA==
X-Google-Smtp-Source: ABdhPJwrS6QbuUDR6nCJUwjTtfPYuTq0XZSBfGtPdzuQVxc0gkKzzB3hELKAxvsVsO3J9XYhJ1LvhP0yoRBwYDHYw2g=
X-Received: by 2002:a1f:9d85:: with SMTP id g127mr1445404vke.101.1598014153688;
 Fri, 21 Aug 2020 05:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200803072857.8880-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200803072857.8880-1-madhuparnabhowmik10@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 14:48:37 +0200
Message-ID: <CAPDyKFo2njN6bU+VqpuHPpHDx4+ZkuoNRZVb0a0EjGBi9uXa7g@mail.gmail.com>
Subject: Re: [PATCH] drivers: mmc: host: via-sdmmc: Fix data race bug
To:     madhuparnabhowmik10@gmail.com
Cc:     Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 at 09:29, <madhuparnabhowmik10@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> via_save_pcictrlreg() should be called with host->lock held
> as it writes to pm_pcictrl_reg, otherwise there can be a race
> condition between via_sd_suspend() and via_sdc_card_detect().
> The same pattern is used in the function via_reset_pcictrl()
> as well, where via_save_pcictrlreg() is called with host->lock
> held.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This doesn't apply to my mmc tree, can you please rebase and submit a
new version.

Kind regards
Uffe

> ---
>  drivers/mmc/host/via-sdmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index ef95bce50889..e4d8126cd4e5 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1259,11 +1259,14 @@ static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
>  static int via_sd_suspend(struct pci_dev *pcidev, pm_message_t state)
>  {
>         struct via_crdr_mmc_host *host;
> +       unsigned long flags;
>
>         host = pci_get_drvdata(pcidev);
>
> +       spin_lock_irqsave(&host->lock, flags);
>         via_save_pcictrlreg(host);
>         via_save_sdcreg(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         pci_save_state(pcidev);
>         pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
> --
> 2.17.1
>

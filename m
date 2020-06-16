Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747ED20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSO1xWCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgFPLdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgFPLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:33:06 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2146C08C5C5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:33:05 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id u15so4702218vkk.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yS/6e/WCxZenWj9cO6UlgV0ZueHyZ1C28NWHU0JWvMY=;
        b=zSO1xWCI7V3fwY5yJE/kKH0xluZrLvP7XojSc1tZbMaxWYatHTVYF3xmiua7boWXoQ
         /wmEZPVlEr/tPhzegCZ5DxYQ7kTp0NxPET9S0BJS6uPYFScnVoisZn5YVXpfZFNAUPVe
         E261x3yvjxDsM3DozkKtKAak3Ps0rPg1kks78JL+0S7dkM7+huylVU2hj1k7RYrYSn0W
         aLqmQtxDiwlmZQ9aUreicXQd0w1ft5kij+p7/1U9CLhZTpwtFdp8Xue8d5zuYsvjQZgW
         VEmTchuBWyxG7IoGARTHIREuPFp1i3Nysx26MqL1+I/CnPrCjVpGumurwyKDfNzn1F4K
         DByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS/6e/WCxZenWj9cO6UlgV0ZueHyZ1C28NWHU0JWvMY=;
        b=p2Dy7RhnyzevBTX6leiLIQYOcGyKS2O66qadR86dkogjowRfjsYCz9l+tJ9Q2BgSK7
         +6MKaG0pX3KNCJL41xVCJm37j5g8GEFffNSpVmJLJbJwfIjXrmnEWZlDIyElDtm5fAVH
         ukqk0pLK+/NgnsYiQwh05FW5WdJMGObmE1pSIwxIFshbANBF9cJjgqyoBZv77tzs9nhC
         HDb0jJ1x7CEui8LW2BlddgDUHYtUD6TQxOGjcgD79UISsIJT0aCAwvufTfePJ6cKPVeX
         cbY6wf2vYvPPHVdGW9M6AYtLHnyOtAO8zl8IUysufTYtxw4Q8WpGlilHp15UPOmZEH6h
         eftw==
X-Gm-Message-State: AOAM5335BDu5cJYBHsOPNrfbob+PdLvhLPLODaESwK06X6U1afhnNoYX
        IG8bichuwqye/p+C65W764zzOp+fRX/Uxzw2w8axgA==
X-Google-Smtp-Source: ABdhPJyjMOjyUc4A/bFC2IEyahD8R1FiPDEbgPyOZ0ntp/23TwR+c4zzqMGiaNpEh5hEfDmfBPnYKmBSY9C6UP9z80A=
X-Received: by 2002:a1f:9511:: with SMTP id x17mr1128044vkd.101.1592307185187;
 Tue, 16 Jun 2020 04:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <1591326240-28928-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1591326240-28928-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:27 +0200
Message-ID: <CAPDyKFpscyQXYF+WQ98_sRvonCL+ZbddX+ctw3umQ8HLAqvxmA@mail.gmail.com>
Subject: Re: [PATCH] sdhci: tegra: Add comment for PADCALIB and PAD_CONTROL NVQUIRKS
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 at 05:04, Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
>
> This patch adds comments about NVQUIRKS HAS_PADCALIB and NEEDS_PAD_CONTROL.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 3a372ab..0a3f9d0 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -96,7 +96,16 @@
>  #define NVQUIRK_ENABLE_SDR50                           BIT(3)
>  #define NVQUIRK_ENABLE_SDR104                          BIT(4)
>  #define NVQUIRK_ENABLE_DDR50                           BIT(5)
> +/*
> + * HAS_PADCALIB NVQUIRK is for SoC's supporting auto calibration of pads
> + * drive strength.
> + */
>  #define NVQUIRK_HAS_PADCALIB                           BIT(6)
> +/*
> + * NEEDS_PAD_CONTROL NVQUIRK is for SoC's having separate 3V3 and 1V8 pads.
> + * 3V3/1V8 pad selection happens through pinctrl state selection depending
> + * on the signaling mode.
> + */
>  #define NVQUIRK_NEEDS_PAD_CONTROL                      BIT(7)
>  #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP                        BIT(8)
>  #define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING              BIT(9)
> --
> 2.7.4
>

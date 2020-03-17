Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34130C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088EA20736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJhgMiQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCQL7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:59:01 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35025 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:59:00 -0400
Received: by mail-vk1-f193.google.com with SMTP id g25so4445834vkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8aFTKWziCYV/JFp9YmzXCFKw7iBvzE2SIcpZsVJO/8=;
        b=aJhgMiQEwPKrbBDLomMEBpm+wTQQ9OiiVgXZXuULaXMbnvGbCvpialMlkvvGB6hqkC
         1AopurvLYSfCoqymSjP7ZB1VhLTWAPrdJO/jHIgCLA/LBuKshqI1HfzvpKTovKctJDeJ
         j916QqwW/LBQwrAmxcJ8Cnf06xEGWDOVnVN8GsS0/qTAkIzz65c2KcnhGi/+QP75p4KU
         JOFFejEc/Ekj9BWlOuArk1f2x3z0sR/NSGzLn8/uZUzfxQkivf9b/nthoLzPbGZMARqR
         KB0uB1AJKFhNzq5NieEJFVEpeRT76F7/uLjiYC3RP1wpW/sauEvW44FoOORd6O2Ns2Gq
         uweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8aFTKWziCYV/JFp9YmzXCFKw7iBvzE2SIcpZsVJO/8=;
        b=Ou/Y3QzMC+DJFqODeGDnk2zmIH1qqyyRzYSrrbTN2t/SXxb9eLsvRCCyB3OQvl+OX/
         EjTWVX7TdV6lyR6C0He7x6b2RJEcRiKx7m1EAuJLQbYJsfpyh41zVDeSFFDX00Ps1L/H
         DIMUKg79aueAI18kUv/ElH8t+TPbuHytrch9S/4Cx4Lecm1cgoCriMwe2vDgdKUwPvSE
         EsiTLj09WTxU4QBj5QE3eSj8bLBjeae/LI8fcY0koTIvygndgYFBbipU3VeMaeq0p6cH
         BC0u0zLhDWjRURjbT7L6NCwRERQRjBd9oZ3PX8O1SFPb0Lshum4G9l52YvexOEd713gW
         gZnQ==
X-Gm-Message-State: ANhLgQ17MMZaatAs1qE0m8FFD7QxNWghK9/I+ZOhSF72aXY5cRo3ac/U
        JPC24z0WVgBeR4/VZB/3SRdh4xPER/ELkx7Vu7entg==
X-Google-Smtp-Source: ADFU+vuJNhmyWk0EHE2y3jUvJnGQ9GFksqC7A8czsEfGv0AGGOW4Wcohcr/le6UtFo9V22nLmkRgF/lDPxmdyp00RDo=
X-Received: by 2002:a1f:8ccf:: with SMTP id o198mr3278826vkd.53.1584446338404;
 Tue, 17 Mar 2020 04:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200312110050.21732-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200312110050.21732-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Mar 2020 12:58:22 +0100
Message-ID: <CAPDyKFqnoyFGNAvcTfuGmEsKHy_b2vK90cUS1Nj_DEMJ+GgDag@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: use FIELD_GET for preset value bit masks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 at 12:01, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Use the FIELD_GET macro to get access to the register fields.
> Delete the shift macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci.c | 10 +++++-----
>  drivers/mmc/host/sdhci.h | 10 ++++------
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 63db84481dff..aec6692615c8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -9,6 +9,7 @@
>   *     - JMicron (hardware and technical support)
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/ktime.h>
> @@ -1766,10 +1767,9 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>
>                         clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>                         pre_val = sdhci_get_preset_value(host);
> -                       div = (pre_val & SDHCI_PRESET_SDCLK_FREQ_MASK)
> -                               >> SDHCI_PRESET_SDCLK_FREQ_SHIFT;
> +                       div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
>                         if (host->clk_mul &&
> -                               (pre_val & SDHCI_PRESET_CLKGEN_SEL_MASK)) {
> +                               (pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
>                                 clk = SDHCI_PROG_CLOCK_MODE;
>                                 real_div = div + 1;
>                                 clk_mul = host->clk_mul;
> @@ -2227,8 +2227,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                         sdhci_enable_preset_value(host, true);
>                         preset = sdhci_get_preset_value(host);
> -                       ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
> -                               >> SDHCI_PRESET_DRV_SHIFT;
> +                       ios->drv_type = FIELD_GET(SDHCI_PRESET_DRV_MASK,
> +                                                 preset);
>                 }
>
>                 /* Re-enable SD Clock */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a6a3ddcf97e7..abdcefee24cb 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -9,6 +9,7 @@
>  #ifndef __SDHCI_HW_H
>  #define __SDHCI_HW_H
>
> +#include <linux/bits.h>
>  #include <linux/scatterlist.h>
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> @@ -267,12 +268,9 @@
>  #define SDHCI_PRESET_FOR_SDR104        0x6C
>  #define SDHCI_PRESET_FOR_DDR50 0x6E
>  #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
> -#define SDHCI_PRESET_DRV_MASK  0xC000
> -#define SDHCI_PRESET_DRV_SHIFT  14
> -#define SDHCI_PRESET_CLKGEN_SEL_MASK   0x400
> -#define SDHCI_PRESET_CLKGEN_SEL_SHIFT  10
> -#define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
> -#define SDHCI_PRESET_SDCLK_FREQ_SHIFT  0
> +#define SDHCI_PRESET_DRV_MASK          GENMASK(15, 14)
> +#define SDHCI_PRESET_CLKGEN_SEL                BIT(10)
> +#define SDHCI_PRESET_SDCLK_FREQ_MASK   GENMASK(9, 0)
>
>  #define SDHCI_SLOT_INT_STATUS  0xFC
>
> --
> 2.17.1
>

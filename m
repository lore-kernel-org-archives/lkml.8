Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56031C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8382067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBsGXK3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgERJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:39:44 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BABC05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:39:44 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l15so3262834vsr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MorV8jZrfJk/BfhvGvB2TOF5zsx+Wxk/DjWRxlh/fVE=;
        b=xBsGXK3kMfgTXnjc7qVZN+0UmomJeOzYsQPrIb+9tF4CbFMgiDA6C3PuDbob77YJzH
         FakKCYPW/HtfPZpXfBOyOYW0f7QZes8e5nPCLSZE43x+uz7Ov/yGJKNJ3oXG0aXkDfXj
         Lw3GWaG0HNNSs9qAMMfQLkd8seEktWf/on2x39MxXgiQu9TXpXfUnFnYs4tpAnPd2/Rv
         VpQvQx/2Xwr1nGWIGgHhIpV/nMsBOdUrQqKVNLRTwGJnx4K1o0ySdlQIz+nnmTH3bw+p
         mz06rbqx0UNN4Ln5H+Ua9xKlFSdlyB6LA5QtAYNP53JHZADQXnmfihvNji0GkjP/E2ct
         VRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MorV8jZrfJk/BfhvGvB2TOF5zsx+Wxk/DjWRxlh/fVE=;
        b=QvClm/rFZbuoXTNXG+yOKE1pcT0FgTX0c4HLdOtxKwYE2BaiARcyvygQiifph0s+ZO
         mt90z5EmjWY3GCfxsbxUqKW/GQ7YzKNmi4vMwnMYnGxu/PaRl7zWpP1iqJcE+CMMrGEA
         OvEVVJXU7hqDWVwqJCCwstLjj+/gMoJwzqVQyaHL+BNMGIXpD1wLrWuOOge4j1qS2gA8
         ILpgC7WPPHsqEZhrTFTC5Cow+L0pB+7g72n5isOj1wESJGh4hD384rkELeHx7rMox66i
         /ojL+fBioj1T6kYytm6mBFF+cEbWQZlUeDfx+/vcAzBb5Nz1g/xfL/NJxSsNyTklvvSA
         NgjQ==
X-Gm-Message-State: AOAM533vKDKo/GO/qoeq46vrrAW5WQNlVvmS/ZjgbxuPL2Clt2swIjXp
        jzutOkmGkCVn8fDxnLRQXu/eHtWITEH4oeb0eor3MQ==
X-Google-Smtp-Source: ABdhPJxJq8NTrKez2Q/RxkVPbbOJtDSlSlSG3djZ0+NTOrY+UEne/3D3GaPsOLbplZSqzwcILBswQF/S3sTSohFoEoA=
X-Received: by 2002:a67:690e:: with SMTP id e14mr3632665vsc.34.1589794783785;
 Mon, 18 May 2020 02:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <1588772671-19675-1-git-send-email-sartgarg@codeaurora.org> <1588772671-19675-2-git-send-email-sartgarg@codeaurora.org>
In-Reply-To: <1588772671-19675-2-git-send-email-sartgarg@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 11:39:07 +0200
Message-ID: <CAPDyKFo0CabC_O-NusH4tUzjnG37_XQhY=QNhgnkQMoTokfaQg@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: sdhci: Introduce new quirk to use reserved timeout
To:     Sarthak Garg <sartgarg@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 15:53, Sarthak Garg <sartgarg@codeaurora.org> wrote:
>
> Introduce a new quirk for letting vendor drivers to use reserved
> timeout value (0xF) in timeout control register.
>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1bb6b67..07528a9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -967,7 +967,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>         }
>
>         if (count >= 0xF) {
> -               if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> +               if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) ||
> +               !(host->quirks2 & SDHCI_QUIRK2_USE_RESERVED_MAX_TIMEOUT))

I don't quite get how this can make your variant use 0xF rather than 0xE?

To me it looks like an updated conditional check to print a debug message, no?

>                         DBG("Too large timeout 0x%x requested for CMD%d!\n",
>                             count, cmd->opcode);
>                 count = 0xE;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 8d2a096..02f8779 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -476,6 +476,11 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT                 (1<<18)
> +/*
> + * Some controllers define the usage of 0xF in data timeout counter
> + * register (0x2E) which is actually a reserved bit as per specification.
> + */
> +#define SDHCI_QUIRK2_USE_RESERVED_MAX_TIMEOUT          (1<<19)
>
>         int irq;                /* Device IRQ */
>         void __iomem *ioaddr;   /* Mapped address */
> --
> 2.7.4
>

Kind regards
Uffe

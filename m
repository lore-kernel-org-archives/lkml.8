Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F0C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3020736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IK2FGpNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCQL7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:59:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39245 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:59:03 -0400
Received: by mail-vs1-f66.google.com with SMTP id p7so11408728vso.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZMNv0S0gNxKRZ8I1Nt8Tef752IFbYhohGP6J3gY5R2g=;
        b=IK2FGpNvya0KPuWS8sHWa+rKgz0eilpzn5f5+sCU1KqRc6Jn+VpaFKdIGAPz4TqDPb
         +whUIc36KW/NsuJi/uSyJwRnIwFHpHv6mklOJHYc87Z9lb7xmZSM4JbzfY0Xe5AwK4Pv
         kjmKTrI/Cs8rE8OSDTIBx2Cvsx5T9qSYuuL+SDbDZTqMuxmgrm3E0bkd7C/+xrWzZ12x
         e2yQouBryox7D94w26nvJte3UZIFJTaBClWSHrqI17gIZFZOk5WkDqK5cdoQE/7hsjTB
         g2OcaRVF8I+JAaP+84+d2O421o+ijdJIjEzDBlUxpHFczXzSB326OtwNaXToowscx6oA
         AS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZMNv0S0gNxKRZ8I1Nt8Tef752IFbYhohGP6J3gY5R2g=;
        b=VfmQEnt2JyKG8AM/C8oQiserG2//HRadfL3lb1GOSjiPZ4yRtXeExCpI/M5P6PqysQ
         ZT5yzTudW2EqbKGzsDxEDMl9dYf6My7YICardn6s9xabmgYa/aKj3dPmWUsjhbfHjibF
         kjQx5LizYnQObT4I1VXydOyfGWo33JBYVKytHkzdV7eiDO1+xLzzVHV3v2D56XWBDkZW
         VxlOidhE6GzNtZuFH6YBR3DnTAy1OnQlF9rnI2Jj4ATDidDUMUmqrqPuAEK+2zQ96pq/
         4OLYnhFZxijyueeZi/LMBnO3zKPDY3DRJjHdBp7O9fJlmDYV4/XNws3e/jWgRipqUuNT
         cqyQ==
X-Gm-Message-State: ANhLgQ17N7/w1DnYLm5XCHxw7KbMiL60tOLQzkDnJKPFN1ACnsVvxOsO
        GzaJH3NxQHAyNXv0OQMYKTsXDxr4miJDVCzhNPXoEQ==
X-Google-Smtp-Source: ADFU+vs9rKtqkF0djkWCDiEscynl38sMmaSIdB+SSu4Fbs8xS4kp2OEae2ng8PagWfKPz8og4NUAsO/MwoH7O2z8ah8=
X-Received: by 2002:a67:d03:: with SMTP id 3mr3069385vsn.35.1584446341128;
 Tue, 17 Mar 2020 04:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Mar 2020 12:58:25 +0100
Message-ID: <CAPDyKFoBWQa+ozERBrDLoHCWDATjShsYPYoKPN9mkaPUq8BFCw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Mar 2020 at 17:44, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> SAMA5D2x doesn't drive CMD line if GPIO is used as CD line (at least
> SAMA5D27 doesn't). Fix this by forcing card-detect in the module
> if module-controlled CD is not used.
>
> Fixed commit addresses the problem only for non-removable cards. This
> amends it to also cover gpio-cd case.
>
> Cc: stable@vger.kernel.org
> Fixes: 7a1e3f143176 ("mmc: sdhci-of-at91: force card detect value for non=
 removable devices")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of=
-at91.c
> index d90f4ed18283..8f8da2fe48a9 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -185,7 +185,8 @@ static void sdhci_at91_reset(struct sdhci_host *host,=
 u8 mask)
>
>         sdhci_reset(host, mask);
>
> -       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +       if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +           || mmc_gpio_get_cd(host->mmc) >=3D 0)
>                 sdhci_at91_set_force_card_detect(host);
>
>         if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
> @@ -487,8 +488,11 @@ static int sdhci_at91_probe(struct platform_device *=
pdev)
>          * detection procedure using the SDMCC_CD signal is bypassed.
>          * This bit is reset when a software reset for all command is per=
formed
>          * so we need to implement our own reset function to set back thi=
s bit.
> +        *
> +        * WA: SAMA5D2 doesn't drive CMD if using CD GPIO line.
>          */
> -       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +       if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
> +           || mmc_gpio_get_cd(host->mmc) >=3D 0)
>                 sdhci_at91_set_force_card_detect(host);
>
>         pm_runtime_put_autosuspend(&pdev->dev);
> --
> 2.20.1
>

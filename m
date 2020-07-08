Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C33AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EEF20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACwrozzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgGHNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGHNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:21:04 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40059C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:21:04 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e15so24446694vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1E21POru3zmdZ6HFzPnD0O/ns0rx/jP8kjgxQgRDrmM=;
        b=ACwrozzz+P2Wsxd3epGxe/MZr1epApOctZw7v0nt7erekf6hiPHQsQYIs1TGwglq+z
         oH7su7jwOkUFKrXZPMImb48iWNTUDwR14pQxYUYk94XHpY0aOJdjvtSvMFR9SE9t0fS9
         Gy/sRycXcaXrruWp2HV74ktp9UlzO+TQrwGNkp+aaCVWyCjbrKOwe+DoU4xjJvAUaKpy
         8cAts5nYJwdQkreEcCEWevLAY5k5CvdjiRSlbnCTk1xMhbKBNin7llwTxWhdhCyBKsWW
         SvxCo3CUtH32wxTbdxMYjT9pLz2kG2YHM6KoQSDm7AtWB7Zr/XZEAUWiOhG45LYvaX+C
         7+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1E21POru3zmdZ6HFzPnD0O/ns0rx/jP8kjgxQgRDrmM=;
        b=gbEvNhT3Am0+UummJqAbAi61l+StZfq4j+0JToOYHGLhYkYNVri7du+090fUi3P0rG
         3LSBi8WwPGiK0f5uQxYncs87pOFDjiN5JBZ6prNmaZPirBcoeBFAKJ1nJSmfexA9eopA
         1HW4hMo7GogFj7dfLs2Cl4zP2Rg4OGq6vpVIf/sgAKfHJ3fzkKHQTgC0UCTrhirjMV2N
         SdNuMuFalNFkM6SOff+WHcDLczOdUCu+bX+eCxW5L4J1c2IJFowzKSzzrSMrvh64kJXC
         D4bLeX3ZwrXg4VpiU09S0zNPjX++sCjmm/omd9VzzahA00ZmBa30mYB2y8dXKAb6+dGX
         SK1Q==
X-Gm-Message-State: AOAM532Cdxd3VfEQQsucbLarNi7dYOP13/0uBEgZDyu3IomxUTtIePsg
        W66fEr4pDMFS9JrPH8Sk+HB86k9lO1W71qDaE7FoXg==
X-Google-Smtp-Source: ABdhPJwsP9DnIjx8EeC3fsIyMr0/MHcRrZyMJ1LeL6NhcK8x5HfHbQZyfHNRhJgkSvakwiDp2gbQqWvwnudKZA2XanU=
X-Received: by 2002:a67:f888:: with SMTP id h8mr22995905vso.165.1594214462784;
 Wed, 08 Jul 2020 06:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200701124702.908713-1-lee.jones@linaro.org> <20200701124702.908713-16-lee.jones@linaro.org>
 <20200707064701.GC3500@dell>
In-Reply-To: <20200707064701.GC3500@dell>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jul 2020 15:20:26 +0200
Message-ID: <CAPDyKFr7s6hT=tfCf24hCqJvJEuCK6kR1c-QSASciiXwmE805w@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] mmc: host: sdhci-iproc: Do not define 'struct
 acpi_device_id' when !CONFIG_ACPI
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 at 08:47, Lee Jones <lee.jones@linaro.org> wrote:
>
> Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
> 'struct sdhci_iproc_acpi_ids' becomes defined but unused.
>
> Fixes the following W=3D1 kernel build warning:
>
>  mmc/host/sdhci-iproc.c:297:36: warning: =E2=80=98sdhci_iproc_acpi_ids=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Alright, so I have replaced v1 with this v2 on my next branch, thanks!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-ipro=
c.c
> index 225603148d7de..e2d8dfe90077e 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -294,12 +294,14 @@ static const struct of_device_id sdhci_iproc_of_mat=
ch[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id sdhci_iproc_acpi_ids[] =3D {
>         { .id =3D "BRCM5871", .driver_data =3D (kernel_ulong_t)&iproc_cyg=
nus_data },
>         { .id =3D "BRCM5872", .driver_data =3D (kernel_ulong_t)&iproc_dat=
a },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
> +#endif
>
>  static int sdhci_iproc_probe(struct platform_device *pdev)
>  {

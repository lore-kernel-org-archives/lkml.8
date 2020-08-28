Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7BCC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F033320848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Lh2vPqbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgH1QMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1QMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:12:16 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40914C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:12:14 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id u1so1638499edi.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68eDttIIdaNDtczAU5J2J6maRd1hjk4vD2eKoip4OiM=;
        b=Lh2vPqbCKyX+nvWywFutd7Njub4N1BKB0z0SGWL4Kx1eUvmeKx98gqs12jpOwZUImx
         a/jJy/VxVHxeuWC+9vl12hBlpQ2rX8aiOEU1VYo1rsgOsG1qrqbeJzCivpQEZsT3pdGN
         U3N/rtrQqwEOfPYjkaHZ+l/GidodYIOBDxzug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68eDttIIdaNDtczAU5J2J6maRd1hjk4vD2eKoip4OiM=;
        b=ZQT8fx1glhYe8TK6u4vdsiDXEnWYHX6YYJ8szEcQoPk610vLrqwb1D9198Sa7npoGq
         BflF2neT+5Gtj7O57MMCzFBOqaiP45UqXYVzG9qBnE/MBQyUwrbvzJ+biDPzkEKoAwco
         1OFYr3PJykkXIeLhMD7L3lVdoxXrlZOshSaiFUnGGH8MyFV5aRK0ym+ETUU1CnZhDki0
         b8CuWeNnGkQgy2VJ7EW/fBU/C0BML4H0JvCUrQYS1neilC6ryVoq32MOf+MTd0naDYes
         ppA2QzewvZHqd68t6CabDEhI1O9skHboQeYuRimX7duRoTtJis308/O/1XEu/bQuKXO1
         v5eQ==
X-Gm-Message-State: AOAM530vz5uFhwDEP3lnjQRiQ002YzJBsbav5cOAT3YZiu/yu5ayAXRl
        aOvtQEbfO4ZOjb1qwQOgcSKezQhNNUvwIetvh4mPhQ==
X-Google-Smtp-Source: ABdhPJwyMXFiYunR5+aSXpeSZSyTk3ZKCbauRXnvJOQ2s+rYkfnGyyEFqd3Jrbq0E2zU6ICWLcVfsVkKfvjSPNlJt98=
X-Received: by 2002:a05:6402:2212:: with SMTP id cq18mr2673132edb.34.1598631132537;
 Fri, 28 Aug 2020 09:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200828153747.22358-1-krzk@kernel.org>
In-Reply-To: <20200828153747.22358-1-krzk@kernel.org>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Fri, 28 Aug 2020 09:12:01 -0700
Message-ID: <CAGt4E5s4t+O=8P=HOZo_vN3S3RgOucyaUvLy3GoOhMYCSzbG+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 at 08:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Markus Mayer <mmayer@broadcom.com>

> ---
>  drivers/memory/brcmstb_dpfe.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index dcf50bb8dd69..f43ba69fbb3e 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -901,11 +901,8 @@ static int brcmstb_dpfe_probe(struct platform_device *pdev)
>         }
>
>         ret = brcmstb_dpfe_download_firmware(priv);
> -       if (ret) {
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(dev, "Couldn't download firmware -- %d\n", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't download firmware\n");
>
>         ret = sysfs_create_groups(&pdev->dev.kobj, priv->dpfe_api->sysfs_attrs);
>         if (!ret)
> --
> 2.17.1
>

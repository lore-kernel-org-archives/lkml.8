Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52613C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255FC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vV6YiyYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbgF2VVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgF2Swn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A027C030F18
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:25:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so3471283edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JdwFaIk/SBsKiNUj1msSBe/13JfoNO8Wze0XSCM5ME=;
        b=vV6YiyYs1Li40btnp4UbtO+zACr59gQjCO+fCxWJ2oVJh2GE5f3C2kHFkKAnvKvYBk
         l798V8RyBS3FP1ZGoOQQeWMhNaPDt0kELzqS6LHIzUT+HYzPDUPt5cYpZi49ZhhYD3Hs
         njjAgu3acTBMuW67l8TP+CrXdEAU1dhFv+hdpcguTdxG1DqWrMOXmmL9zYMYbRF7Vr5S
         h4DaZJNz6AcqAcj6uGdgqUn9giOH69Tmkz0g7QznClxnwwCZadcUdbGwqNP9GuPK1E5m
         2U+XA6A24SB+SooKyzJueP+H6LLlLsgETy9TtVd34JGr8kTUW1QSF2I5K2ctQjoM90EP
         Vyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JdwFaIk/SBsKiNUj1msSBe/13JfoNO8Wze0XSCM5ME=;
        b=uPQ0LXOXoM6i25WZUC6+F3KuVe2nsmaj9pT4XUwkg1Rl8LzjKwdceZzHSlGGkRrRwo
         YWpv0nzuo6BGoO2LWDGlCuMtOf5m9perhOv2mHxvKtgu/RGPSxbiIPs60zVn4fSrs4SX
         WqalU4+gDUYHrmDxpKyfH6LXV45l5c9rrpHKfLyn1fi4krpT5k1AygeYkMcNGa5h/ly8
         rKTCaQ6fwrmRc57EHiwtrv+AR5zGOoDftMZOEbP/sQ7eqQBGN/+v5QdQUi6i0+iCygOu
         Nma+qlFKXtCADCac40pbaOD5tYLbKDxi+tLSUkZRbDkeuEhWPZosf6Xb66ediPZ1/KAn
         Ek8w==
X-Gm-Message-State: AOAM530WK0KtEy70OIPxjedMNhkJ7bB5qsO2IAGjTnEjcRwNI9xns5zP
        ++NniYXPHUaJUYsYgMHbuHtWBnm860tGhWKerXhxjg==
X-Google-Smtp-Source: ABdhPJw/dx0pIba71K59e822Vxezxawzu1b4Q24KSpL6m//sHFjdfbI+QoKQ7V3kCj3C0FeVok/KJZm/ehl+h/H50Zo=
X-Received: by 2002:a05:6402:22f0:: with SMTP id dn16mr18662329edb.83.1593447942682;
 Mon, 29 Jun 2020 09:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200629161333.2110327-1-pmalani@chromium.org> <20200629161333.2110327-2-pmalani@chromium.org>
In-Reply-To: <20200629161333.2110327-2-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jun 2020 09:25:31 -0700
Message-ID: <CABXOdTe_t94GL6soaZbXp5TVxnG72zHRqh_qTa+zpmzTCw50ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add PM support
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 9:13 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Define basic suspend resume functions for cros-ec-typec. On suspend, we
> simply ensure that any pending port update work is completed, and on
> resume, we re-poll the port state to account for any
> changes/disconnections that might have occurred during suspend.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v2:
> - Remove #ifdef-ery, add __maybe_unused tag to functions.
>
>  drivers/platform/chrome/cros_ec_typec.c | 26 +++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 630170fb2cbe..b2e7e928e788 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -725,11 +725,37 @@ static int cros_typec_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static int __maybe_unused cros_typec_suspend(struct device *dev)
> +{
> +       struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +       cancel_work_sync(&typec->port_work);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused cros_typec_resume(struct device *dev)
> +{
> +       struct cros_typec_data *typec = dev_get_drvdata(dev);
> +
> +       /* Refresh port state. */
> +       schedule_work(&typec->port_work);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops cros_typec_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
> +};
> +
> +#define DEV_PM_OPS     (&cros_typec_pm_ops)

I don't think this define adds any value.

> +
>  static struct platform_driver cros_typec_driver = {
>         .driver = {
>                 .name = DRV_NAME,
>                 .acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
>                 .of_match_table = of_match_ptr(cros_typec_of_match),
> +               .pm = DEV_PM_OPS,
>         },
>         .probe = cros_typec_probe,
>  };
> --
> 2.27.0.212.ge8ba1cc988-goog
>

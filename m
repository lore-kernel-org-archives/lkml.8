Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0568FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8CC20768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAjeBl1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbgF2VFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390154AbgF2VFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:05:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F68CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:05:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i14so18254637ejr.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5+uXhdVLL1JQ/BpOyWY0ygfez6SfYmoRUf/dprU/yU=;
        b=DAjeBl1FR1/DsgxRPaw2h7sQ6NmKmhZOtQFKgN7YjvWQhxictsYYSeYGazOoUUQyVX
         alqgM2kNHwP4fyBEJbljNuPX4+oLFlR2Kg2TWkD56BYOjT6EOB8jJLvp2Hdv+ufX1/nV
         mmR4Vqn9Fw1p6ceCJxEKRz7RTmN7e+1f3A8vIkd6+JR64a8eHe4mZgHVXYmWhrkpCWMX
         wBIybOQwCJa3YXNY71dAYltEmU1ivZPlvNAjUR6HNAK0i74Wp0jhtOIrxrhLRhBgNoAl
         rXr7U7XMJJbc3tml365yyXerE1Qx0L2CcPue0xQ4AUqvS1l5pBgl+U9Y27beRtN3x621
         UbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5+uXhdVLL1JQ/BpOyWY0ygfez6SfYmoRUf/dprU/yU=;
        b=i3s3vRA8ZAglJ/oA1f2r6hKDTttIdEQ3yFNTAeh2eGO8bTFeSX7WXWWvXwLcch3QSj
         VB+x5otjuCJDRcbkIJfN64Vsvb2FD4ZHdGQXXIlfcTYgaDnxFBiLRk0hQdt6O9lpFfEA
         JhYad+hCcGdXLqrG69EGV5Qk0cy/XKWD94jVErQeQJwmYm5XQz2GWxgNg1dHtLvvYVC6
         MAK8wFbaAe3ooEMr2h2CrHPAOlLNEKcDQk/PNNX65hW6m+oLA+KFogVCxnH31gwXRQAf
         hKj6dkmwx9eV65UY/eQpXEPmdBV0RDuYWQvO6LIMy+RV6tq1+ixMMuT8F53RQ3oMoX4a
         Lx2A==
X-Gm-Message-State: AOAM531tevBtox3+0L7+J+Ig08gu2lm6WYMbmu1w4aPzMolYGelRWdwI
        iOg0Q40LGt0Ar6UNdhm1mxcvWDlARbFOgJO80Ty3Ww==
X-Google-Smtp-Source: ABdhPJwx9rhIytg8KU9TIpWcmbacvDsAZoA4TlJzTKaE74b20apQO9Ypzds5Sl0QWHtudAJj5L+BZoDvzVK9463aznE=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr15149889eji.547.1593464713805;
 Mon, 29 Jun 2020 14:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200629163851.2130450-1-pmalani@chromium.org>
In-Reply-To: <20200629163851.2130450-1-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jun 2020 14:05:02 -0700
Message-ID: <CABXOdTe-hY98YFusFkS+C8iVWZANVWcavpKSmaYtjC11yMgFrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: cros_ec_typec: Use workqueue for
 port update
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

On Mon, Jun 29, 2020 at 9:38 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Use a work queue to call the port update routines, instead of doing it
> directly in the PD notifier callback. This will prevent other drivers
> with PD notifier callbacks from being blocked on the port update routine
> completing.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v3:
> - Use new 100 character line length limit.
>
> Changes in v2:
> - No changes.
>
>  drivers/platform/chrome/cros_ec_typec.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..0beb62bf5adf 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -58,6 +58,7 @@ struct cros_typec_data {
>         /* Array of ports, indexed by port number. */
>         struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
>         struct notifier_block nb;
> +       struct work_struct port_work;
>  };
>
>  static int cros_typec_parse_port_props(struct typec_capability *cap,
> @@ -619,18 +620,26 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>         return 0;
>  }
>
> -static int cros_ec_typec_event(struct notifier_block *nb,
> -                              unsigned long host_event, void *_notify)
> +static void cros_typec_port_work(struct work_struct *work)
>  {
> -       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> -                                                    nb);
> -       int ret, i;
> +       struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
> +       int ret;
> +       int i;
>

I know I am getting picky here, but this seems like a personal
preference change. There is no "one variable declaration per line"
coding style rule.

>         for (i = 0; i < typec->num_ports; i++) {
>                 ret = cros_typec_port_update(typec, i);
>                 if (ret < 0)
>                         dev_warn(typec->dev, "Update failed for port: %d\n", i);
>         }
> +}
> +
> +

... but anyway, there should be no double empty lines.

> +static int cros_ec_typec_event(struct notifier_block *nb,
> +                              unsigned long host_event, void *_notify)
> +{
> +       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
> +
> +       schedule_work(&typec->port_work);
>
>         return NOTIFY_OK;
>  }
> @@ -689,6 +698,12 @@ static int cros_typec_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> +       INIT_WORK(&typec->port_work, cros_typec_port_work);
> +
> +       /*
> +        * Safe to call port update here, since we haven't registered the
> +        * PD notifier yet.
> +        */
>         for (i = 0; i < typec->num_ports; i++) {
>                 ret = cros_typec_port_update(typec, i);
>                 if (ret < 0)
> --
> 2.27.0.212.ge8ba1cc988-goog
>

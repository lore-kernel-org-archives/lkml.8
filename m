Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3D1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A7420724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDoV+f/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgF2VSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD80C030F15
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:24:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so17192602ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud+jy3wulB5wSts5pAy11Tc3R2svZplkU4sR98nwwJE=;
        b=uDoV+f/amMJySkjiD5nfcXFSEYKLa7JOmygbWtDrbVnsvXumsg4JB325HUaxGjw2Vi
         eNdd9RRj62EnIZ4pbaSVLWpw3IL0kteHloONkLXM8vzkvFt3entXOVvKORsQfBIiJ8FH
         xusOSAMEt1gemF6n6eornvY9U6B9dxUiqNR5UmkXigrRjgElYE81qVrgeaUwWFLy0piP
         oFimG/Ha18kkdW68rV9v8tq3sflRfqesYVAcwc0DVBNEd5wdvY0hty6tnKDa+73zY6Lx
         /l9tVNaU6LiRvD6apfQlzXRVljaVF0aJKrqm5HQOlFyJ7A2dczyLCFj9qc6OUuEBJpke
         wfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud+jy3wulB5wSts5pAy11Tc3R2svZplkU4sR98nwwJE=;
        b=WjO+9TQtNzVA6JLt4gip8Bnl+/GKSxgcJ3rMv2mJt0YuIkMEq+JqKnBYnW2toK+A0i
         QVKCqukYqCRgwfmD+aptafsuV6vqmpaNe3m6v5IYnrVIfWDpkIAW4MYk0rFpI1CP4F6g
         sMXxi5Vr677ajQeMgBVFQ5zIFLfip4xnmy0kevSRexgSIMdyaGGhKQmg+p9wumaqed15
         RZUU8mAs8K3wtf702BkYDp9gZI9p/kuTnhFCb6uD5E7W0OPx8zG95X5VWocgj0ZPI69T
         4wzSzvVaBMOsbEYhYM1TaTtgrAub8mnZrSZ6jbgG7rIL5OGSjwd2WAKPY2cFqlAl7EnE
         LDbw==
X-Gm-Message-State: AOAM531VHvQa1naekDUlPLeRSLHwL/pZCsQrTFCUMuXR9ZPJj14ig5GA
        OiUtZweYGtznglTl+FjWYMkWthJVo6hoPP4fh4vMyw==
X-Google-Smtp-Source: ABdhPJxlRAhYNvkoRyV5Hwm46QJy+t17bof8FUMuwBjVY5l48RtUsL6y2BFz2PS0mENanl2mteJxNhRc2gCcq/W5WPs=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr14263665eji.547.1593447885760;
 Mon, 29 Jun 2020 09:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200629161333.2110327-1-pmalani@chromium.org>
In-Reply-To: <20200629161333.2110327-1-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jun 2020 09:24:34 -0700
Message-ID: <CABXOdTcSOUru-B_nbB0Z9k1_EUrL5ENZ7zQhuXoG+e1gZmz4qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Use workqueue for
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

On Mon, Jun 29, 2020 at 9:13 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Use a work queue to call the port update routines, instead of doing it
> directly in the PD notifier callback. This will prevent other drivers
> with PD notifier callbacks from being blocked on the port update routine
> completing.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v2:
> - No changes.
>
>  drivers/platform/chrome/cros_ec_typec.c | 28 ++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..630170fb2cbe 100644
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
> @@ -619,18 +620,29 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
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
> +       struct cros_typec_data *typec = container_of(work,
> +                                                    struct cros_typec_data,
> +                                                    port_work);

Nit, but the upstream line length limit is now 100 characters, and
this is a perfect example where this would come handy.

> +       int ret;
> +       int i;
>
>         for (i = 0; i < typec->num_ports; i++) {
>                 ret = cros_typec_port_update(typec, i);
>                 if (ret < 0)
>                         dev_warn(typec->dev, "Update failed for port: %d\n", i);
>         }
> +}
> +
> +
> +static int cros_ec_typec_event(struct notifier_block *nb,
> +                              unsigned long host_event, void *_notify)
> +{
> +       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data,
> +                                                    nb);
> +
... and even more so here.

> +       schedule_work(&typec->port_work);
>
>         return NOTIFY_OK;
>  }
> @@ -689,6 +701,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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

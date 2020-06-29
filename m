Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE5820775
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmjgHMCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgF2VSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgF2VSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:18:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE572C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so4347710ejx.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3u8HXAMPWhEhabpqjdYJ146WuNuaOg2EhIYFRuXqpM=;
        b=QmjgHMCPFtCfnd59WVkDYYDiCvQJ9TLMoKuXhlgAiNXcDkkFsNyOXAh0kOxXWFEiDT
         81VLh016Tri13UHQ7NSxRn8xP5ymt1ZMTpuNM8uz/KZ6WQCLFkfurQOO0rly/X+Jucs/
         A1qCYgMyWxe7vr921ErrncDcDEzz5AkoHqEtC/blRCUiNzOtz17KT7vgZsm33z4WgzN3
         MHKvpcINhb5Iznv0VUNmFulPauzyQf/+ojmfY0KPNuzUC5ck0A2iBFLMxrH1Kfu+zQmX
         wzwgFkdU4USwX2P7373AMUo7uLfXYWPKvfF/g5OM5KMN315qZdMTsRszkPTyeK3DnJZl
         TBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3u8HXAMPWhEhabpqjdYJ146WuNuaOg2EhIYFRuXqpM=;
        b=B+pE0eq69x517LwhcTQqv910rwCOK0Rs0GGOf0MifnpH8IyCX9pnfcpD+KU8XYPBhS
         ZzYj8P5YP4cjfPySw9TILcUUL9iXYARbzvANBALyc4lPEBnaolIvxNoibEu5cp1rMoqp
         cjOy8W0mauBtKORSxeHSUQAX8yBa1T9bAS2FMy2Wlz6d2SgDI5joapVfkAhp0Xbgw5Kg
         9fq4JuLtXHQLJZVvO27A1Y8Sc8Rtow35yjEq00jm6K3weXQPPLEFDCjL0EkbGsDrbgsh
         3guxmB4zlolsu3g67WfOgYr5ebIMeHFeXMrjPNgKO8nI4B37DiugDO0Kd6uYzHUpq7ea
         c9/w==
X-Gm-Message-State: AOAM532OOfwymQJs89P2WpA/K6AXQLNalUvlIGXeDBlBfrVhmfXjSd/4
        I1IqPPOjbYftC1l/yoTrIQs1nisOpgV1evDbX8ZWpbQWyK1YVg==
X-Google-Smtp-Source: ABdhPJwM0wqdpMYgzcsUtDEa7EOy9g/cN2Z7gW1lSQFWRn7v+meb/CMrSR5490ZvdAkIzHdlncJj9DBeAMUV/VcNmZM=
X-Received: by 2002:a17:906:899:: with SMTP id n25mr14799477eje.298.1593465483433;
 Mon, 29 Jun 2020 14:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200629211329.2185342-1-pmalani@chromium.org>
In-Reply-To: <20200629211329.2185342-1-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jun 2020 14:17:52 -0700
Message-ID: <CABXOdTfoks7+hmQA8rj98TsSGF6oabkrOOJzrd0NTKrzHNqjPg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Use workqueue for
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

On Mon, Jun 29, 2020 at 2:13 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Use a work queue to call the port update routines, instead of doing it
> directly in the PD notifier callback. This will prevent other drivers
> with PD notifier callbacks from being blocked on the port update routine
> completing.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

I can see you are having fun with me :-)

> -       int ret, i;
> +       int i, ret;

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v4:
> - Removed extra newline.
> - Moved both variable declarations into one line.
>
> Changes in v3:
> - Use new 100 character line length limit.
>
> Changes in v2:
> - No changes.
>
>  drivers/platform/chrome/cros_ec_typec.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..69c4118e280c 100644
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
> @@ -619,18 +620,24 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
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
> +       int i, ret;
>
>         for (i = 0; i < typec->num_ports; i++) {
>                 ret = cros_typec_port_update(typec, i);
>                 if (ret < 0)
>                         dev_warn(typec->dev, "Update failed for port: %d\n", i);
>         }
> +}
> +
> +static int cros_ec_typec_event(struct notifier_block *nb,
> +                              unsigned long host_event, void *_notify)
> +{
> +       struct cros_typec_data *typec = container_of(nb, struct cros_typec_data, nb);
> +
> +       schedule_work(&typec->port_work);
>
>         return NOTIFY_OK;
>  }
> @@ -689,6 +696,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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

Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8666C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E2721569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiQh5gmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgAWVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:05:11 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43652 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgAWVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:05:11 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so2183708qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcbgbKXHYzFeK72nb97pWxaHY+EZyGnc0S9E+ApdXgs=;
        b=kiQh5gmyJl9700k6zOiLXFG+rMXZHdZexdPHhc9Oo/WZkyRTatXR1udIrGkvsG66u8
         q0rAB/dhh0LWPtn+GWe5a99BMC97Lurx5lQOotFfeIIYCtCGszmf0r2j0ZbYnFnfPn/1
         n3l2OfAYzoYlLsKH4ck090Hf41x1DJLwZtQahzFGTxBThS3FTWwUygkzuc7W1seUZlmB
         1itqYVomtcqrt0pSIN7H1+3UvpITXzxUGhFcbLvc6NUPWnPN26yTIleOEzzDYh+MrtYg
         8OgG0KY7Pyqj2UnBj/Agzut5JTZpX3rWNDKl8j9vQ1/aA0W40ph/AGl9IM5w++cesls9
         crMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcbgbKXHYzFeK72nb97pWxaHY+EZyGnc0S9E+ApdXgs=;
        b=CV8m1WJfv5crhhYYFqaPoCbXPg/xEoT/DqxT9PzjsAumHGj3Ay1dUqaXd0a6yuX1Lp
         nohK1iPVwaSnB30273+UOcuimdx2lXR+TdnUicsPjVnXw4+pqnghAYe34uLBm6BgBY+V
         bsGnwP8NuI18+xnOgcY739rr5s1HYUMz4M31lKoLnrh6UGILL32Trm1PmtqQS1/duHGU
         PtYs4oKl19LV3A8roKBjSZuEyszyeuBbTtAE+phYmjUCEWi//rrKNg+N3Sljca8hqQfd
         Mxf+Hr+OlOnRW+tIuZtlvVfZIYXQBfhhWNGYkRKEyBiqP4MqQFsTWNuvCJHC79IM4n+4
         bkUg==
X-Gm-Message-State: APjAAAVawJWbeDwyQp/Pup87c3XEHQd1ibvOiVoETnEYeybR7PMe5jRu
        FY/lYMFcY6wgbhfP+bmR9FA7pVq5V6CehjLk6xQ=
X-Google-Smtp-Source: APXvYqyU4q0R+13VyLA6khfyhXa/z4Ae+4+LM6baqHej3pQtAvoBbfdV2vu5cZ8RDOXlrnl3VafUWuaJgCovP0srz4E=
X-Received: by 2002:a0c:edb2:: with SMTP id h18mr17967337qvr.94.1579813509664;
 Thu, 23 Jan 2020 13:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20200107220640.834-1-yichengli@chromium.org>
In-Reply-To: <20200107220640.834-1-yichengli@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Jan 2020 22:04:58 +0100
Message-ID: <CAFqH_538ncoNMuSZoC9VfT9fV_NUd7GhGd2q0D0-ag-V9Cpw3A@mail.gmail.com>
Subject: Re: [PATCH v5] platform: cros_ec: Query EC protocol version if EC
 transitions between RO/RW
To:     Yicheng Li <yichengli@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicheng,

Missatge de Yicheng Li <yichengli@chromium.org> del dia dt., 7 de gen.
2020 a les 23:10:
>
> RO and RW of EC may have different EC protocol version. If EC transitions
> between RO and RW, but AP does not reboot (this is true for fingerprint
> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> still uses the protocol version queried before transition, which can
> cause problems. In the case of fingerprint microcontroller, this causes
> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> interrupt handler, which in turn prevents RO to clear the interrupt
> line to AP, in an infinite loop.
>
> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> might have been a transition between RO and RW, so re-query the protocol.
>
> Change-Id: I49a51cc10d22a4ab9e75204a4c0c8819d5b3d282

I changed the subject to 'platform/chrome' and removed the Change-id line

> Signed-off-by: Yicheng Li <yichengli@chromium.org>

And added the Fabien's Tested-by tag

> ---
>  drivers/platform/chrome/cros_ec.c           | 24 +++++++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |  3 +++

Fixed a trivial conflict with current chrome-platform tree and applied for-next.

Please remember to cc all the maintainers and maintain a changelog
between version next time.

Thanks,
 Enric


>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 9b2d07422e17..38ec1fb409a5 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>         return ret;
>  }
>
> +static int cros_ec_ready_event(struct notifier_block *nb,
> +       unsigned long queued_during_suspend, void *_notify)
> +{
> +       struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
> +                                                    notifier_ready);
> +       u32 host_event = cros_ec_get_host_event(ec_dev);
> +
> +       if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> +               mutex_lock(&ec_dev->lock);
> +               cros_ec_query_all(ec_dev);
> +               mutex_unlock(&ec_dev->lock);
> +               return NOTIFY_OK;
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
>  /**
>   * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
>   * @ec_dev: Device to register.
> @@ -201,6 +218,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
>                         err);
>
> +       /* Register the notifier for EC_HOST_EVENT_INTERFACE_READY event. */
> +       ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> +       err = blocking_notifier_chain_register(&ec_dev->event_notifier,
> +                                              &ec_dev->notifier_ready);
> +       if (err)
> +               return err;
> +
>         dev_info(dev, "Chrome EC device registered\n");
>
>         return 0;
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 0d4e4aaed37a..a1c545c464e7 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -121,6 +121,8 @@ struct cros_ec_command {
>   * @event_data: Raw payload transferred with the MKBP event.
>   * @event_size: Size in bytes of the event data.
>   * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> + * @notifier_ready: The notifier_block to let the kernel re-query EC
> + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
>   * @ec: The platform_device used by the mfd driver to interface with the
>   *      main EC.
>   * @pd: The platform_device used by the mfd driver to interface with the
> @@ -161,6 +163,7 @@ struct cros_ec_device {
>         int event_size;
>         u32 host_event_wake_mask;
>         u32 last_resume_result;
> +       struct notifier_block notifier_ready;
>
>         /* The platform devices used by the mfd driver */
>         struct platform_device *ec;
> --
> 2.21.0
>

Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BACC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FED2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tby1rdqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgGUTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbgGUTz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:55:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:55:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x62so103299qtd.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKQJqSYQIQEezmJqGfrn3V+2FebaItNHBjKTadyiaWU=;
        b=Tby1rdqSS5Ia0kDMkvFgyf8NYs9uwgJNfLN5l0NBzmuxc8Dhe/hEgGNh2a8LnQjHca
         g6YK2BeNpf58OiIEeSs83P8vgUNdN5rPtvU4y6+Uj/qi4ZUIdwqTrBKIs8y1SYT6sDtW
         QD2wLp06bT0/nwsTfsfVI4+uC7tZdAH8CgtKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKQJqSYQIQEezmJqGfrn3V+2FebaItNHBjKTadyiaWU=;
        b=fnYMn6L1FUX26fdz+Lbo7IOC8kcJcdBZa269OZ2AoeoieWXLLiRI7jRXJoyde/4Zqf
         wZyO8IUhYy6USDQhBJvFHbZeVbJky7Fp4uVOlX3dgWMNYwfWfcQW1tvGmoHAME6eN0BC
         q6VqjzAmuSZ1+NRr6r/uyMtDjTWB/HMskiEsBwuCeis4f75ZV1hLEbbTL0PPtfBN2CG8
         5zOGMtNpI5skzn6MxVJlhlgyIkc/6XVWlTG8jJ/F7C4pa1PJTQcu8tbt0yrSK+ZacbZc
         eLFjCXJV8EHgGqhh/6KtLoZp7c/4oMn1POoTvrnzN/sEAc56uLaOG8MIC7ojXm/jNMHf
         KeCQ==
X-Gm-Message-State: AOAM5336wmXjoCtXHBGT05ktx3ls9coTfGbs51df1zbscg4GD9PstxDQ
        ghxO3wa8NaJKTGVlXbdd9BvUagvZxQ2598aWw9ILPdcv
X-Google-Smtp-Source: ABdhPJwZpxrR1jrRQMcD239ShXQLBf/q+YzL8mKLBmFLUoEq/7gX4L+Xg3WyT+kmfFZ71OhNzFMf1NHb8KbJNQHcd0M=
X-Received: by 2002:ac8:1991:: with SMTP id u17mr29352243qtj.93.1595361357168;
 Tue, 21 Jul 2020 12:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200710194017.1126000-1-pmalani@chromium.org>
In-Reply-To: <20200710194017.1126000-1-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 21 Jul 2020 12:55:46 -0700
Message-ID: <CACeCKadwsH2yhqegZubgJnLy+p0CM3H1DzXiA-72Gagy2aYB-A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: USB4 support
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Enric, Benson,

Just wondering if you've had a chance to review this patch.

Best regards,

-Prashant

On Fri, Jul 10, 2020 at 12:40 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> With USB4 mode the mux driver needs the Enter_USB Data
> Object (EUDO) that was used when the USB mode was entered.
> Though the object is not available in the driver, it is
> possible to construct it from the information we have.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> This patch depends on latest usb-next from Greg KH, this commit in
> particular:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ad8db94d6813dc659bd4de0531a8a1150559eafb
>
> Changes in v2:
> - Removed EUDO bits for cable current and tunneling support.
>
>  drivers/platform/chrome/cros_ec_typec.c | 33 ++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 0c041b79cbba..a9700275a851 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_device.h>
> +#include <linux/usb/pd.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
>  #include <linux/usb/typec_dp.h>
> @@ -494,6 +495,34 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>         return typec_mux_set(port->mux, &port->state);
>  }
>
> +static int cros_typec_enable_usb4(struct cros_typec_data *typec,
> +                                 int port_num,
> +                                 struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +{
> +       struct cros_typec_port *port = typec->ports[port_num];
> +       struct enter_usb_data data;
> +
> +       data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
> +
> +       /* Cable Speed */
> +       data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
> +
> +       /* Cable Type */
> +       if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> +               data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
> +       else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> +               data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
> +
> +       data.active_link_training = !!(pd_ctrl->control_flags &
> +                                      USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
> +
> +       port->state.alt = NULL;
> +       port->state.data = &data;
> +       port->state.mode = TYPEC_MODE_USB4;
> +
> +       return typec_mux_set(port->mux, &port->state);
> +}
> +
>  static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>                                 uint8_t mux_flags,
>                                 struct ec_response_usb_pd_control_v2 *pd_ctrl)
> @@ -514,7 +543,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>         if (ret)
>                 return ret;
>
> -       if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
> +       if (mux_flags & USB_PD_MUX_USB4_ENABLED) {
> +               ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
> +       } else if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
>                 ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
>         } else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
>                 ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
> --
> 2.27.0.383.g050319c2ae-goog
>

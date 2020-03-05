Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA037C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8A21739
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TINuTS5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbgCEADe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:03:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45128 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgCEADe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:03:34 -0500
Received: by mail-io1-f67.google.com with SMTP id w9so4438083iob.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcXMvP83pyGZ1I5nm90C47eaUp73C3wISS7XfIKSpxw=;
        b=TINuTS5todeyzCYRdZD2BXIqFaI+WzyR6cIQeHZmA9pebcQh1OCN1McUIHLQvzczYe
         /3FZTgioIXu60vuCoLPGW0Mb+4iQ7F0bOBUiD8IVzVpYbL2ricjrPBjtAfpuJEqZ13jN
         AshqXEnsr4aLO3R/AUBRwQb3zm/9bYKz02t44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcXMvP83pyGZ1I5nm90C47eaUp73C3wISS7XfIKSpxw=;
        b=EbEkH3EIDj7HBbBGJ2tYPx7bIJ1PYbL1WN6EMy03POL9AAbKaCkzraY5BdZIA96Cwr
         w/C5zP6B/Z1uZY1S/iBY0EBXtF6sIQ72thC6tHedKRUZZF0PCDPzjnpzRJg9f5G2L1Vc
         aaM7v1Q65lE60J0+Gj25PWHIJIYfvOb3Jajb00c+yeQMoPc45areKh0mSqzpg6MHqukP
         faw2Qylm78w328TcePzs0trJ1GDtO+7xrHPburYbUaD1oeYfzt6Ft/h/lKoH5zBstJWv
         r5swfSaPaaf6o0d06a9xQYL1KDpzC0720aTFgSim77Ew8De9BRSn/zE0pxXqoSth07RX
         J0HA==
X-Gm-Message-State: ANhLgQ10td78T1EhEsCpyZYqZkXOJjWSMbGWTKin1E18OuKS8pJ2rCii
        5hjbBGQytjTO+k4iqWz289BkzWvqhR4szKF5YZUb0A==
X-Google-Smtp-Source: ADFU+vtyNe6CWanl85WP18h1v5gApJVgCinHIFhFfvX7Yln8ACBdfbhL0oNX3ybv2HV6wjzZLNBKpsQUroHrWzZCHxI=
X-Received: by 2002:a6b:b414:: with SMTP id d20mr4331951iof.236.1583366612072;
 Wed, 04 Mar 2020 16:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20200304232108.149553-1-gwendal@chromium.org>
In-Reply-To: <20200304232108.149553-1-gwendal@chromium.org>
From:   Benson Leung <bleung@chromium.org>
Date:   Wed, 4 Mar 2020 16:03:20 -0800
Message-ID: <CANLzEkvgFf4-TwP4iSgCzPJoJrFKAdnMdTmbnBHfg-aGm8x7Bg@mail.gmail.com>
Subject: Re: [PATCH] platform: chrome: Fix cros-usbpd-notify notifier
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jon Flatley <jflat@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Gwendal. Copying +Prashant Malani as well.

On Wed, Mar 4, 2020 at 3:21 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> cros-usbpd-notify notifier was returning NOTIFY_BAD when no host event
> was available in the MKBP message.
> But MKBP messages are used to transmit other information, so return
> NOTIFY_DONE instead, to allow other notifier to be called.
>
> Fixes: ec2daf6e33f9f ("platform: chrome: Add cros-usbpd-notify driver")
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/platform/chrome/cros_usbpd_notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
> index 3851bbd6e9a39..ca2c0181a1dbf 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -84,7 +84,7 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
>         u32 host_event = cros_ec_get_host_event(ec_dev);
>
>         if (!host_event)
> -               return NOTIFY_BAD;
> +               return NOTIFY_DONE;
>
>         if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
>                 blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> --
> 2.25.0.265.gbab2e86ba0-goog
>


-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

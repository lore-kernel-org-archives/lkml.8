Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687EEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3559520838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 21:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hdSRR6y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAXVxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:53:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40890 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 16:53:06 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so1661587qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwPE2uTviQEjsE1utp28wLeHm+u6Nm1mopOXiGOBzew=;
        b=hdSRR6y3yyYN5tacXi+RUq0t2z4YfE1ePsXUhGNpUWKTMDRZTr0wsZPXDXhVSa8tA3
         CAW1ZeaBTTIg/bnTiHLkBV0tSmf2R9eAHjlHSvTCE3u0S4VczhZas42sBXaqKOA0K1WF
         OzJBeZRPvezT+6eL4IyyN1n8kytHgbLrRA+jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwPE2uTviQEjsE1utp28wLeHm+u6Nm1mopOXiGOBzew=;
        b=Jr6OJUhOtNHr58K7yfEBwD2Mzyeh4vioYlWiUpOCR38M3Q9B9r1f45H28bSCWNloPi
         dtehB8G1te2bFTj4O8xt3N+A2lg9Klkl3paihFWZF1+y+Dv/o1SQ0KcTl5pkrBeXj7+R
         Ud5fTp+PlpqeTwBQKcgRduCXZVazRkPyMlyvqEWU4a3+p4I9ZsSX4Hk9kq4wnbOFXoHJ
         Oy92DDb1lu/qK8A4uxHvJtIrfKrWuyhWcgnTASqV1+oXaA+++s42fSDbOy+qC4YOr2xx
         g9sFHa/LNb0o+0W0s2TtEuKDnY128v3oMQcpNmGo1Sh6nGW7rVv/ehoqL05J/gUKHjcx
         OPug==
X-Gm-Message-State: APjAAAXjDy95+GxhzjkmG0FPsuHC79uc9CTdAkRypnlSXpNrbKrcfh+I
        vg+6TIXoLPumn9GpwKQQ+hH8w1kGe1zUUQWQPiTMzg==
X-Google-Smtp-Source: APXvYqwaEBzde+nCZdruWwVj8c3DUWHnDaZLJU9IaZnAYEkiij1P43wPznbHTec6Ot4T0ZERdsB+1brEdVsmz/xobxI=
X-Received: by 2002:a05:6214:bc6:: with SMTP id ff6mr5098954qvb.133.1579902784863;
 Fri, 24 Jan 2020 13:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20200117002820.56872-1-pmalani@chromium.org> <c338d46d-5600-a53e-5a04-12100f5628b1@collabora.com>
 <CACeCKafMOUgLgrO-VwAH5so-O7ALZXdTaiC_=2E9M91mhfFt6g@mail.gmail.com> <75dc83a6-c183-6808-c668-d31a71a31682@collabora.com>
In-Reply-To: <75dc83a6-c183-6808-c668-d31a71a31682@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 24 Jan 2020 13:52:54 -0800
Message-ID: <CACeCKafersQp9gx_zSYNczNTbB7u-2UYdxsrrgPhAmpW_nC2rQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, sre@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric

(removed lot of the context text to keep the message length small)
> > So, in summary, my proposed additions to the edits you suggested are:
> > - Remove IS_ENABLED(CONFIG_OF)... checks from
> > cros_usbpd_notify_probe_plat() and cros_usbpd_notify_remove_plat()
> > - Change check in cros_ec_dev to be:
> >               if (IS_ENABLED(CONFIG_OF) && ec->ec_dev->dev->of_node)
> >
> > WDYT? Could you kindly try this on your kevin configuration? I've
> > tried it for the cases "CONFIG_OF && !CONFIG_ACPI" and "!CONFIG_OF &&
> > CONFIG_ACPI" but not the third one (CONFIG_OF && CONFIG_ACPI) since I
> > don't have an environment to test with (I can confirm it builds).
> >
> > Thanks as always for helping iterate on this.
> >
> >
>
> Let's continue talking with a new version. Could you send another one and I can
> check. I have now setup both systems one with ACPi and another one with OF.
Sounds good. Will push a new version. Thanks.
>
> Thanks,
>  Enric
>
>
> >>                 if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> >>                         retval = mfd_add_hotplug_devices(ec->dev,
> >>                                         cros_usbpd_notify_cells,
> >>
> >>
> >>> diff --git a/include/linux/platform_data/cros_usbpd_notify.h b/include/linux/platform_data/cros_usbpd_notify.h
> >>> new file mode 100644
> >>> index 0000000000000..4f2791722b6d3
> >>> --- /dev/null
> >>> +++ b/include/linux/platform_data/cros_usbpd_notify.h
> >>> @@ -0,0 +1,17 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * ChromeOS EC Power Delivery Notifier Driver
> >>> + *
> >>> + * Copyright 2020 Google LLC
> >>> + */
> >>> +
> >>> +#ifndef __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> >>> +#define __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H
> >>> +
> >>> +#include <linux/notifier.h>
> >>> +
> >>> +int cros_usbpd_register_notify(struct notifier_block *nb);
> >>> +
> >>> +void cros_usbpd_unregister_notify(struct notifier_block *nb);
> >>> +
> >>> +#endif  /* __LINUX_PLATFORM_DATA_CROS_USBPD_NOTIFY_H */
> >>>
> >>
> >> Cheers,
> >>  Enric

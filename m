Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17515C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1075207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TeSq9Nlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBOA6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:58:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37408 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBOA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:58:05 -0500
Received: by mail-qv1-f65.google.com with SMTP id m5so5152822qvv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 16:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cKFrJvxjBZmwV8fx4PYPqMr+d+UV5RB12ZA7bxHkY0=;
        b=TeSq9Nlzf7M/ZtJ8VOaje5NhgoW8Yeqrn8llHTbkbSXb5O/a1WCI5M5AZcp131CFwf
         13Arnsb5ipnKvw44LV/bDy99jaw3XQ6+lrSgP3r47jcFBAANti4hct/FKSVSzETMGn1s
         g5c5h0yzaGpiilE+3o2Xg2CjsUeE+cvpiSA/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cKFrJvxjBZmwV8fx4PYPqMr+d+UV5RB12ZA7bxHkY0=;
        b=mA8ylPqx5qKsbHoMlSDVAh9Aa8+uM7hLELj7V0y3Rb+pv8+cTiiGWRq46GelbKvu2g
         6CQ5sI0jbkxi48hUzll+elt4Ua+UxCX7Wl93oUarTlnyf3dQIPP2jHHfyJObjGehHov0
         fn9vI8p8lGNv00X/9iFI45nysNSQ/WsI7eCWjatse4ZcRz2uvb/WaR7R2qSIpP3ZP3N4
         yFb96Tq4iIThAbHfl0mg6IJI05CH9yB8u7g4P7IMF3LDZF8ZmriXX1nSqzuG/RUcYaHA
         L/Ba0qD/43xegkED5IW89TPWUBNqCYd9iQK/WojS4KBM+Svyk8Paqhj4kLkrf/ViXUdb
         W91w==
X-Gm-Message-State: APjAAAVaXMuwONsbJ5gF/rmWsH5pLiw41gyunHGGoAqB7K25Nd/W7ERj
        JIwhCvGJYEvpEUa54wiL9LMScjjbjsDwyCz9zHbYNjBoeXU=
X-Google-Smtp-Source: APXvYqzCBMYNJm+5z3VItZNU8GREjvs8qxBPDVO54pJ2EWZ9LKE1F+BAhKKuBrQstARpdGDLibG5Ehxxqpzcf4gxABI=
X-Received: by 2002:a05:6214:531:: with SMTP id x17mr4638090qvw.156.1581728284775;
 Fri, 14 Feb 2020 16:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
 <20200213145416.890080-2-enric.balletbo@collabora.com> <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
In-Reply-To: <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 15 Feb 2020 08:57:53 +0800
Message-ID: <CANMq1KCAp6fYEqX3udxUXi+zEgjSy_FddDngDwriB8D-gAj=YQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver support
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Gleixner <tglx@linutronix.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@suse.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 5:36 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Thu, Feb 13, 2020 at 6:54 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > From: Nicolas Boichat <drinkcat@chromium.org>
> >
> > ANX7688 is a HDMI to DP converter (as well as USB-C port controller),
> > that has an internal microcontroller.
> >
> > The only reason a Linux kernel driver is necessary is to reject
> > resolutions that require more bandwidth than what is available on
> > the DP side. DP bandwidth and lane count are reported by the bridge
> > via 2 registers on I2C.
>
> It is true only for your particular platform where usb-c part is
> managed by firmware. Pinephone has the same anx7688 but linux will
> need a driver that manages usb-c in addition to DP.
>
> I'd suggest making it MFD driver from the beginning, or at least make
> proper bindings so we don't have to rework it and introduce binding
> incompatibilities in future.

If that helps for the binding, ANX7688 is indeed a MFD (TCPC, HDMI to
DP converter, USB-C mux between USB 3.0 lanes and the DP output of the
embedded converter), with 2 I2C addresses:
- 0x2c is the TCPC/mux, used by the Embedded Controller [1] on Chrome
OS, and the code in this patch (my understanding is that lane count/BW
registers in the kernel driver below may only be available to FW on
Chromebooks).
- 0x28:
    - Used to update the embedded FW in the anx7688 (on Chrome OS we
do this in depthcharge [2]). This is a EEPROM-based FW (so even
without implementing this, it'll usually "just work").
    - Used to workaround some TCPC issues (see [1] again).

[1] EC driver: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/driver/tcpm/anx7688.c
[2] depthcharge driver to update ANX7688 FW:
https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/master/src/drivers/ec/anx7688/anx7688.c

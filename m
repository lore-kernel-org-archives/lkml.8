Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1117DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE22920658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lfpCtz3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgCPHvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 03:51:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40598 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbgCPHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:51:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id t20so6135136uao.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0zDChC/wEd931QcHPYFdsZbptmXL5czRy9fIJzF9Os=;
        b=lfpCtz3okbIvkiKIsprySyGNw0WWfVbJqWnQpSrysHhl3opcygESioQgUUw5y8OIw8
         0YlyBmrVGZqeMxbhvBDhb2oqbnjGugyu/qg/HxDJBB7pTei/FIlPMr6VV+MoJiA/sFXN
         hwicZwzDF9qOY145bYD4UU0vh/NPw3LckjGNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0zDChC/wEd931QcHPYFdsZbptmXL5czRy9fIJzF9Os=;
        b=uc9NDALRPyzW8a2JHSIGFGCYaQoA2+fFvfsQBesmWM2sieTWdNcJtDUuMueg9ldYrg
         SCr+U6WXLM05HQHgzXh2qMqsy9Wc50Cu0d1jTZWtNz/AWtn1c7kAbAhQNQ/5iB7mw8mw
         Hk5lLfhqnvJIbRlIz58PFw4c1P2n8pd4N11sPRcZVWgmLnugoARIinAsrFWD1RVzm527
         ofW2kcLDjJP24u41Ty/UmHOjdXuGI+BQ4TxPrTDlRAa7eJr/xClWEySe4w2x3xNrQ+QH
         53RS11IzMgxNvGI/INMG425mM0jaKG/VlG5i/mybHml9aJonomLzopcEIdU1mvnTA7M6
         kLCQ==
X-Gm-Message-State: ANhLgQ2Jr6/SgVDTd7Z1Y4iqeB6j6TZbhchbuRd10GGHAYMizuxG5Ah1
        8TsAJhFKrFkKcUDB8rnKOiHYMyHlxAlvy6Psjt78gw==
X-Google-Smtp-Source: ADFU+vsjo1dRLv/zfDMpdVrD9x5y9Nya6mOAFCScpBDgpmsQ2ypeVyujD90X50SbOKlS3aMqDRYItp3vkhNbHVPWdUE=
X-Received: by 2002:ab0:28c9:: with SMTP id g9mr14197112uaq.117.1584345064363;
 Mon, 16 Mar 2020 00:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200316072419.65274-1-chentsung@chromium.org>
In-Reply-To: <20200316072419.65274-1-chentsung@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Mar 2020 15:50:53 +0800
Message-ID: <CANMq1KD1dLzd3cYmdsg5wF5z-prtdq41P8fuzDQomX=6UbZpeg@mail.gmail.com>
Subject: Re: [PATCH] HID: google: add moonball USB id
To:     Chen-Tsung Hsieh <chentsung@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks better with the mailing lists cc-ed, thanks!

On Mon, Mar 16, 2020 at 3:24 PM Chen-Tsung Hsieh <chentsung@chromium.org> wrote:
>
> Add 1 additional hammer-like device.
>
> Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/hid/hid-google-hammer.c | 2 ++
>  drivers/hid/hid-ids.h           | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 2aa4ed157aec..85a054f1ce38 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -532,6 +532,8 @@ static const struct hid_device_id hammer_devices[] = {
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MASTERBALL) },
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MOONBALL) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3a400ce603c4..33fddab41722 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -478,6 +478,7 @@
>  #define USB_DEVICE_ID_GOOGLE_WHISKERS  0x5030
>  #define USB_DEVICE_ID_GOOGLE_MASTERBALL        0x503c
>  #define USB_DEVICE_ID_GOOGLE_MAGNEMITE 0x503d
> +#define USB_DEVICE_ID_GOOGLE_MOONBALL  0x5044
>
>  #define USB_VENDOR_ID_GOTOP            0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2         0x007f
> --
> 2.25.1.481.gfbce0eb801-goog
>

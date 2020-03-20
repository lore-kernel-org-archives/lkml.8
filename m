Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F06C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B6C20409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XIa7u3f+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCTUAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:00:34 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38100 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:00:34 -0400
Received: by mail-vk1-f195.google.com with SMTP id n128so2095644vke.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9G97mtWNBX+ElGAqKmEux98igXbnng7EqPDZBWwqrlI=;
        b=XIa7u3f+gYyOZeSn2kuITnCAnmgCdTLRe8GQWf6hV2yDUSrPXqnTvD6WorITlRi7Fy
         s98Rmdc2qbHuAN53Qu1aPOiv+BIfRacxC/vrFhm0a9TQPCBXqol2FmGC2MS+3c61v+HZ
         D66aBIkoaRbAP9wLHIGo6bF43GsNX0giiYLTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G97mtWNBX+ElGAqKmEux98igXbnng7EqPDZBWwqrlI=;
        b=I+4ndjURGync9lx4zlSzDrboxjd/E77F8EeY7Nk6wR5wgDsCvSQvlyofsMW2KF8sgH
         3p4sPF/1vhHUe7eCBFFz43UU0WZo2AQNwo5b9U8IAmxDMpYSdbDj7Gt57uaOI2ojztIK
         EGCstY/vrJSQLYgVJ0HIBgN49qXJGV8he8Mj4rUWwaCud3Wz/LDxdyeaEGxXR7Wgzx/s
         Gj3yoXWr6fRhYfE2V24RMLuDXmBgwDZm3SQZ2q9ocKeYrugWfIVNafpzg2ONXbsHCGRF
         HSLkqm898IDQ0j+fT9XhmpAKpwUR0O6TmjPvrrSZZBXHvN7e2jsYOC7jGFsIfVkIcIfY
         1VDw==
X-Gm-Message-State: ANhLgQ1MBm3E6ah38+oq0yELsQKBLkh0aTrnKBwn3krt6f1rLTyOt35Y
        HPoX+BQ8uj2yzdaI5vFVBNU7nxf7bCM=
X-Google-Smtp-Source: ADFU+vt1i0V2OilqmwoI+SMAH2gy5U1QHrtrcI4GjSfISJvIqskp7KvFt4x1YCVCZtnsXxeqPBhNaw==
X-Received: by 2002:a1f:9710:: with SMTP id z16mr7947936vkd.88.1584734429345;
        Fri, 20 Mar 2020 13:00:29 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id r3sm3532969vsp.10.2020.03.20.13.00.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 13:00:26 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id 9so2687983uav.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:00:26 -0700 (PDT)
X-Received: by 2002:a9f:2478:: with SMTP id 111mr7131238uaq.0.1584734426059;
 Fri, 20 Mar 2020 13:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200320020153.98280-1-abhishekpandit@chromium.org> <20200319190144.1.I40cc9b3d5de04f0631c931d94757fb0f462b24bd@changeid>
In-Reply-To: <20200319190144.1.I40cc9b3d5de04f0631c931d94757fb0f462b24bd@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Mar 2020 13:00:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XT=NTyPag9wNCotATBzT4v9pg=OOa8X6=xWkMH2AFiLQ@mail.gmail.com>
Message-ID: <CAD=FV=XT=NTyPag9wNCotATBzT4v9pg=OOa8X6=xWkMH2AFiLQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: btmrvl: Detect hangs and force a reset of
 the SDIO card
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 19, 2020 at 7:02 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> From: Matthias Kaehlcke <mka@chromium.org>
>
> When scanning for BLE devices for a longer period (e.g. because a
> BLE device is paired, but not connected) the Marvell 8997 often
> ends up in a borked state, which manifests through failures on
> certain SDIO transactions.
>
> When such a SDIO failure is detected force a reset of the SDIO
> card to initialize it from scratch. Since the SDIO bus is shared
> with the WiFi part of the chip this also involves a reset of WiFi.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  drivers/bluetooth/btmrvl_sdio.c | 24 ++++++++++++++++++++++++
>  drivers/bluetooth/btmrvl_sdio.h |  1 +
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 0f3a020703ab..69a8b6b3c11c 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -22,6 +22,8 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/card.h>
>  #include <linux/mmc/sdio_ids.h>
>  #include <linux/mmc/sdio_func.h>
>  #include <linux/module.h>
> @@ -59,6 +61,23 @@ static const struct of_device_id btmrvl_sdio_of_match_table[] = {
>         { }
>  };
>
> +static void btmrvl_sdio_card_reset_work(struct work_struct *work)
> +{
> +       struct btmrvl_sdio_card *card =
> +               container_of(work, struct btmrvl_sdio_card, reset_work);
> +       struct sdio_func *func = card->func;
> +
> +       sdio_claim_host(func);
> +       mmc_hw_reset(func->card->host);

The fact that you don't check the return value here seems like a
problem.  See specifically how commit cdb2256f795e ("mwifiex: Re-work
support for SDIO HW reset") handles it.

This is a distinct difference between the solution that we landed in
Chrome OS 4.19 and what landed upstream.  In Chrome OS 4.19 we went
the simple approach and said that there was only one way to reset the
card: treat it as a full unplug / replug of the card.  ...but upstream
adopted a different solution.  For upstream if there is only a single
function on the SD card it will not trigger a full unplug/replug and
it's up to the function driver to re-init itself.  This wasn't such a
big deal for the WiFi driver since it already had a way to re-init
itself (mwifiex_reinit_sw).  I don't know how hard it will be for
Bluetooth, but that needs to be part of this patch I think?

-Doug

Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C88EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5402076C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 04:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZOkuBJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgHMEGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 00:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHMEGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 00:06:15 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A57C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:06:15 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id n4so2222366vsl.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFADKmKh7X3diP0daFq4Uh/PnuNyIFdsVOnr2X8DxEQ=;
        b=YZOkuBJsgTHvjSG9g5a/xPxSZTOJqLyRy5QvKnBhTb1LmpDhPoDH0G+SwUIP8hDuPC
         Kd6o2Vn2ksK+EGfYUQO1sKlBCj1lPLSED3wGvd6pb/aR0VOGkNhNHXM0bodOhZpy1LQH
         NehGXzZu+3AQNedbVRYBnAW25PW3VOvt+hfpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFADKmKh7X3diP0daFq4Uh/PnuNyIFdsVOnr2X8DxEQ=;
        b=ipQ+gVgD2HgZpCNNfsWnebH4KBxZu64x+rynzkAFggQZvrnBzHI33FJ+xeXsVE1AXi
         YLNYC/WOPD5A8RBZm5D22/jZibjvmXW4HWOlyFW+QvJdjqTXqVqmt0inpbptZNKzs/HR
         DfQo/rYNRctZup3Sch9EFGKEgctcl4jwE71+fJxxIr5jj+Fr5uKkUD1QTScfsFHeYqIG
         BCVuJniKcvWDLRo/pvBkG61h6iQ2UxLL05kfurUhe5fsFLufl/Nixj0aCT+TPFi2Gl3K
         z3+3dRNfeaiKPb8iFPV1QLEgdZFcXezsAcsgeYNxudIgpCdrByraPrW94/Jg9KITuKgk
         QI5g==
X-Gm-Message-State: AOAM530BqHIemrd5lUVqA5LXIORO53LLxbqDEru+q4YMQ2LWSwLc1vAS
        8F6ChXZGcEidpT1tfei0nFN6eVUFmt80KQB9WYynUQ==
X-Google-Smtp-Source: ABdhPJxOLU/xPfybMFGa215m/YHXhxhvxAG948nEvYLq+qYAi4i1/TNCntTeQOm53HE/NsCM/5k/TRa7EtCXCzZwwLs=
X-Received: by 2002:a05:6102:85:: with SMTP id t5mr1848857vsp.1.1597291574574;
 Wed, 12 Aug 2020 21:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200811065902.2100551-1-ikjn@chromium.org>
In-Reply-To: <20200811065902.2100551-1-ikjn@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 13 Aug 2020 12:06:03 +0800
Message-ID: <CANMq1KDzDGJiRDQSPAvdXEt5iDCggZyjQkmUKoY4huYQu3UDeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] power: supply: sbs-battery: don't assume every i2c
 errors as battery disconnect
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 2:59 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Current sbs-battery considers all smbus errors as diconnection events

disconnection

> when battery-detect pin isn't supplied, and restored to present state back
> on any successful transaction were made.

when any... is made

>
> This can leads

lead

> to unlimited state changes between present and !present
> when one unsupported command was requested and other following commands
> were successful, e.g. udev rules tries to read multiple properties.
>
> This patch checks battery presence by reading known good command to
> check battery existence.
>
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> v2: fix return value checking of sbs_get_battery_presence_and_health()
> ---
>  drivers/power/supply/sbs-battery.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 6acb4ea25d2a..db964a470ebc 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -878,10 +878,17 @@ static int sbs_get_property(struct power_supply *psy,
>         if (!chip->enable_detection)
>                 goto done;
>
> -       if (!chip->gpio_detect &&
> -               chip->is_present != (ret >= 0)) {
> -               sbs_update_presence(chip, (ret >= 0));
> -               power_supply_changed(chip->power_supply);
> +       if (!chip->gpio_detect && chip->is_present != (ret >=0)) {
> +               bool old_present = chip->is_present;
> +               union power_supply_propval val;
> +
> +               sbs_get_battery_presence_and_health(
> +                               client, POWER_SUPPLY_PROP_PRESENT, &val);
> +
> +               sbs_update_presence(chip, val.intval);

I don't think you can/should assume that val.intval will be set
correctly if the return value is negative (even if that's what the
functions currently do, it'd be too easy to accidentally change them).

So I still think you need to have:

ret = sbs_get_battery_presence_and_health...

sbs_update_presence(chip, !ret && val.intval);

> +
> +               if (old_present != chip->is_present)
> +                       power_supply_changed(chip->power_supply);
>         }
>
>  done:
> @@ -1067,11 +1074,12 @@ static int sbs_probe(struct i2c_client *client)
>          * to the battery.
>          */
>         if (!(force_load || chip->gpio_detect)) {
> -               rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> -
> -               if (rc < 0) {
> -                       dev_err(&client->dev, "%s: Failed to get device status\n",
> -                               __func__);
> +               union power_supply_propval val;
> +               sbs_get_battery_presence_and_health(
> +                               client, POWER_SUPPLY_PROP_PRESENT, &val);
> +               if (!val.intval) {
> +                       dev_err(&client->dev, "Failed to get present status\n");
> +                       rc = -ENODEV;
>                         goto exit_psupply;
>                 }
>         }
> --
> 2.28.0.236.gb10cc79966-goog
>

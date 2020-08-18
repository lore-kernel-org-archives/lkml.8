Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CCCC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511DE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUQHZGPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHRBqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:46:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3371C061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:46:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq28so13958361edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+lrgfwMqPomcWygbUK3e6COtGQC4/UPSB2RLkkHV+A=;
        b=FUQHZGPmxY0dGVSuUc83kBkn4ATwkOdEQO+KwXiht76mke5IWG8/nQcLNFJ9/gCV7v
         +idWk+VlJAxuwN3pu4g58HoUUP471EEiLamE5u3ddKgZjWYR8WcQs2JYN0E2nGf/Z6cV
         jXCeK3EgxInYP1lw+sn5SoFOOu33YwmF15gpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+lrgfwMqPomcWygbUK3e6COtGQC4/UPSB2RLkkHV+A=;
        b=D5q699oDuAOdkQHv+mEv8rjJqRwPx1aTw9iGLYqcVCo3XXSfO0ezYsla28NwAVxI6f
         gZszVTxU+feeJt1vHU6HePBeFxJ8Qz3vFzIJPBfYZsSePBS1iegqqi6Gl+iTvusjLv4P
         fesXRIx/Oon299dd0pnj/KliO5bRcpfT3uyzSZbj6Hcenl5zUpF6tN7L8RJ13HKvOnUa
         IYc+83xLWY6dSSuYiVezq8HYyKcyX0XXGYeIa4Hh6tTzbqaQKcYpqAQOL/u/CFiGtYNG
         3X0/bqdQVWTWqzaiDH7rVn7/HmKcRJKoDFAl3Gjnp50oIe4w7qUbJmj0t7bhgxxr7ou8
         1NhA==
X-Gm-Message-State: AOAM532cnTvLOTF8rHuHUr577L6NJaGLZtLaCusps5x/7At4TqKy1VT3
        JLQ8l2k8Ch7TkMzOQz3wLHJ4Gof4pklDmg==
X-Google-Smtp-Source: ABdhPJzA8U0ttZS8e7x89JE/N6Eb6ikNXZHp5qZOx0IqirGwrYx5B8dRvM3NBG8vmRd8AQtK6ygDgg==
X-Received: by 2002:a05:6402:b67:: with SMTP id cb7mr17739274edb.216.1597715198180;
        Mon, 17 Aug 2020 18:46:38 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id g11sm14675516edv.95.2020.08.17.18.46.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:46:36 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id a15so16688909wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:46:35 -0700 (PDT)
X-Received: by 2002:adf:ed85:: with SMTP id c5mr17886807wro.307.1597715195448;
 Mon, 17 Aug 2020 18:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200803235815.778997-1-campello@chromium.org> <20200803175559.v5.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
In-Reply-To: <20200803175559.v5.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
From:   Daniel Campello <campello@chromium.org>
Date:   Mon, 17 Aug 2020 19:45:59 -0600
X-Gmail-Original-Message-ID: <CAHcu+Vb3ezGgRAPWgmHMGAisOQzEm-kKs7bj0ssgyASx-fqoXA@mail.gmail.com>
Message-ID: <CAHcu+Vb3ezGgRAPWgmHMGAisOQzEm-kKs7bj0ssgyASx-fqoXA@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] iio: sx9310: Update copyright
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 5:58 PM Daniel Campello <campello@chromium.org> wrote:
>
> Fixes wrong copyright year.
>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/iio/proximity/sx9310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index cd7de40a55c2f6..87b2de0d7b55a3 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright 2018 Google LLC.
> + * Copyright 2020 Google LLC.
>   *
>   * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
>   * Based on SX9500 driver and Semtech driver using the input framework
>   * <https://my.syncplicity.com/share/teouwsim8niiaud/
>   *          linux-driver-SX9310_NoSmartHSensing>.
> - * Reworked April 2019 by Evan Green <evgreen@chromium.org>
> - * and January 2020 by Daniel Campello <campello@chromium.org>
> + * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
> + * and in January 2020 by Daniel Campello <campello@chromium.org>.
>   */
>
>  #include <linux/acpi.h>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>

Hi Jonathan,

After discussing with Gwendal on crrev.com/c/2360467 it seems that the
right year for the copyright is 2018 as it was before this change.
Sorry about the inconvenience.

Regards,
Daniel Campello

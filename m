Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D5DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D74E206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpGLRpEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGXV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXV40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:56:26 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D63C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:56:26 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id o25so3431644uar.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wu9Z19uRtGtJ0NasFeWEnBkj7jELCMCGAKW7BoOuLmA=;
        b=CpGLRpEhHAWmIvAZYKn0xvAoo10wA4C9CeUytti2gF630AeKnqsyVJEJzVOwEeJheO
         aNgiUp32xACS0QVxGpuCCGANOs2ewM3UJio6fp8tOoFT4Ait2UiUBODk2u6763JCuFqq
         PUmmGifrKE4B8YjocgrEo9u0+Zes/x2Bv2n2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wu9Z19uRtGtJ0NasFeWEnBkj7jELCMCGAKW7BoOuLmA=;
        b=sbreGIcIYwv43QSzDK1/N2ou0rd5utNUVUHVn3hRkEHktooSlJXELEY2cE9Izkhrda
         xUT/09PugJkqu92SPPf98XWSMKOouyN5OUURNlmEjZ8Q/L7cIxVy5hN/aXMsTbv3MBH/
         sXzR6QhESig0cYT6pzYQffhnXj0dgaUOBiJqN2x8ma88hgsupUHGI5+NWcjyCK/FWG4r
         3o0oeeg7REAqDrHzpiEY2gNuV96NFZw8AxGVEX4fjL4CNovn5B6fTeztGkfvcXlTsFCU
         1X9Wahl8gmrEmYiKm/unVwSR0EnixWJ7SwuYGqqwXSFS9CporlzVZh7INPniJYfqGHMb
         r5Eg==
X-Gm-Message-State: AOAM53202aoWQjWZgZrZPM0GW4WDhaEwfMTCUsxwUF87SUvqOPdFF1J6
        MJkwojZqHERZ13jXopFbON3uMPmmkJ4=
X-Google-Smtp-Source: ABdhPJzvgxw7HliE+FqueW9j7DAjTx9iu+VDohUaR8157QsmRQAbk/kPbLa2iBPTkIea9SNRKqfDwQ==
X-Received: by 2002:ab0:6402:: with SMTP id x2mr9905048uao.134.1595627785577;
        Fri, 24 Jul 2020 14:56:25 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id w204sm283180vkd.2.2020.07.24.14.56.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:56:24 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id k7so5685842vso.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:56:24 -0700 (PDT)
X-Received: by 2002:a67:e046:: with SMTP id n6mr9513301vsl.6.1595627783920;
 Fri, 24 Jul 2020 14:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-4-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 14:56:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WQUpfjk7r-w5f0uP0Xnx39Mv8WxLfjfwxfNoGa_1XBvw@mail.gmail.com>
Message-ID: <CAD=FV=WQUpfjk7r-w5f0uP0Xnx39Mv8WxLfjfwxfNoGa_1XBvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: sx9310: whoami is unsigned
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This is an unsigned value, actually it's a u8 but regmap doesn't handle
> that easily. Let's make it unsigned throughout so that we don't need to
> worry about signed vs. unsigned comparison behavior.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BBBC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821F82070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQ1M6w5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGXV5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXV5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:57:13 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:57:13 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id s192so2545005vkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5ZO7ecIplgVGZE3pSmrS86woNFYgLHmLoVoYXhNGQw=;
        b=oQ1M6w5QAzqeJzt+SFRvwn2pwYb0joq4H65Na9q8NLD9b/ClfWMJwURqLssOZMsuZA
         H7DdRRFsellUUWvcItY1KH+MXc6vVT4LJZICuSNnw240Eh6J/+he4MpimjBqh0IrRM3U
         puqrZHkYW7V/AcEhCyeL/VoD2Jy8CmLexYrz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5ZO7ecIplgVGZE3pSmrS86woNFYgLHmLoVoYXhNGQw=;
        b=W3sdokuE5OJX9lG/nHEziwtZohhlh9ZS61axaw//5S+JK+eb5mLOpOHokWPgvVW8oJ
         Z3Mie++BAiE2HtU6wWNUse8+M8gHXg34lg6t3VTGyiN1IuidagNGekhsS1fHlJWAGxEm
         EebqHGNFgDe6xCHj1dTcKI2gxjGkkeXAUpsYkaOGXUSyl2E/uSJ3OdqADGgUORKIH/YD
         rr7EsnMmDAO+eLqZU9L7p6EV7OfvQV48z9HBiXk12OTpIaDAwjvQL0uog1i+KXgSRDYQ
         W7gxWFMO/8V22+78amX8X5PMGnq7Ez/psloxd3trC/VZR4X3NzOTpGPW5zsZ2COmc5uw
         ZbXQ==
X-Gm-Message-State: AOAM533HCpkPWxH2N1qO6lmAk0bYiiL9Xv4qDJVNwrcGihFF1KT3hXQA
        MsfXF79x8GLRxz2qY5ScueKbGlhhiR4=
X-Google-Smtp-Source: ABdhPJxkb5FbmOslDZ8gNI6HNx5LIqzDqAlK35pXIFrVPI8FEOQS1g6+dF3zhRgXvNZq6A3EDaOQzQ==
X-Received: by 2002:a1f:2706:: with SMTP id n6mr9602198vkn.81.1595627832760;
        Fri, 24 Jul 2020 14:57:12 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id j189sm247679vsd.24.2020.07.24.14.57.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:57:12 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id x205so5661256vsc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:57:12 -0700 (PDT)
X-Received: by 2002:a05:6102:20a:: with SMTP id z10mr9532703vsp.213.1595627831736;
 Fri, 24 Jul 2020 14:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-5-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-5-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 14:57:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WL2wb+bj99KgDg4bTV15hU3k6O8UVz8WMNJXLeWNc--Q@mail.gmail.com>
Message-ID: <CAD=FV=WL2wb+bj99KgDg4bTV15hU3k6O8UVz8WMNJXLeWNc--Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: sx9310: Drop channel_users[]
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
> This struct member isn't used. Drop it.
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
>  drivers/iio/proximity/sx9310.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

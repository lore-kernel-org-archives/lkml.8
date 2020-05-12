Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D54BC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3D5206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ywl9SCvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgELJDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729917AbgELJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:03:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C2C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:03:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so1998039ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odTSOiCuFW0TklzckYCQG6DvBZsnxyimLAqm7OGXvHY=;
        b=Ywl9SCvmKHiY3yhke36DIUNmXVxZ6RZr1xQLCdhcAt85loO8f5QwAB9C3nGM5nD4Qu
         f0R75AM9wTccysNCrLcqDuC5lR4c3X6AOy1hH9gHjmegqRErxUkJkm5OmYYHSO4TvrhB
         PH5idrhfg3BEv7YfjDO+igNoMGDfj2w2J31J7b9pU+c4YPcOITqFzGPcngUw1BfyvrBh
         lM+A+9Q2E444kyAS72sbp8wFRpD5qlv2L/tSZUcCViXCKmjrAq7iWh5h8/mLzBtQOuok
         YMY1uQHfvX5V0PQYVFda7s12RfxtqpZIoduOTEtDPVPNnnxoAO+ZLEcHtC9qf4rtGni3
         OlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odTSOiCuFW0TklzckYCQG6DvBZsnxyimLAqm7OGXvHY=;
        b=JFxmj8It1zdvAh/Yd/6XbAmuBh+K0UJc8uTWbsLJQlRwNNxp6j0Jc613wG8JJP8ZYl
         CJn5crjtckNlwWLo2TdbC94uEPo9DJp4j+JeOpfn1ebfuhvMSkiahjF0k6OfB+XQY+zh
         LPKdu+WRlrooeOGhsQuTWHjP+k8uHa/hkVTZkxeGk8UVkthP1a7Tu9QisdB/p0akumoG
         5k5ajNsaBq/RSBWkw2iAjJDiBj+5TPnb0gBgUm/buhzRFYe8BM7mv5ftMf1UmJoB2bdH
         wGoOU6r6Aw6drIHB/mZSD5tTgjUlqXIFU5HR1trAJfh0JCu/Yl8mH2uwuTxO52rjp54d
         +hgg==
X-Gm-Message-State: AOAM5319OwtI1avPgilSiR2eYMtDjJTcGYjNjuiHHONvOpi4PcX77S80
        0rEIXxjOAIgDgfPu0AAki2j/7wzzhjaiuF0kjh2Dew==
X-Google-Smtp-Source: ABdhPJx6/P82+0XHIa1NIY1LjcUbB3jwhI5ZVx5pNhIaNBB7mCBqt3/s4nMi5LWlq/CfR62xLIDpTHxQXgTayF6LqSY=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr12786190ljg.258.1589274213796;
 Tue, 12 May 2020 02:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
 <BN6PR04MB066041D27D2A70B6B00C4751A3A00@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB066041D27D2A70B6B00C4751A3A00@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 11:03:22 +0200
Message-ID: <CACRpkdZ-uuzjbHz9oXwjkTBO5ss1KcBN2Vth6N6h32zmgYhAUA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: gp2ap002: Take runtime PM reference on
 light read
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 5:58 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The light sensor needs the regulators to be enabled which means
> the runtime PM needs to be on.  This only happened when the
> proximity part of the chip was enabled.
>
> As fallout from this change, only report changes to the prox
> state in the interrupt handler when it is explicitly enabled.
>
> Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for missing this!

Yours,
Linus Walleij

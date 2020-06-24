Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE14C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB1620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wDgnINvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbgFXMQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbgFXMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:16:14 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3FC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:16:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so1422001qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b2OqfNiPleZIbmb7TmwrT/wLfhv0B6VNDBgxLf+fGcw=;
        b=wDgnINvcsTBFswtUyZD+fNQOqoBt3GJeRE73tzdf2M8n16m1WwfoJKAC+WdGOu9k0C
         UTkvqhR/NFUp/luzs3XG0B809/B1PzozvO39+egk5K6Ig9iBdsGZHqQqMrOpRv8XMzhP
         OTMCWBkWWH8OpoSsfBlEcRixDpwG1SIPWkUW+Tk3sFk5WwUkOq4/uqg/JLdCbCMUnMTa
         mUo+om5kwRdP7bOpquXz3bWIY+dgGVsmFwCjy2ZXDnMeuW2kPG7WLQcigbsL21q0BQSe
         EWFbU3nX6pGIVaPXoJV70AbExK9ZahDVr4p75gdmgVujT8oy06iXsBVhY7oVLsGX/JHc
         sXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2OqfNiPleZIbmb7TmwrT/wLfhv0B6VNDBgxLf+fGcw=;
        b=smGwR5z+Z9ZDKN62ZZXdLpzHR/gicu/A5xraz9tJJDGgDu8ObaLtssd3FrI6OAmynL
         19z0CCpnQLRBJcRTNVjC2uCjecydHnuRY7QpTwqkvhR+KpDyH2PFs9pKaAtNAb2DoC2I
         7CfA1mTWwtN3bWzhi2vrPmzdD5j826BViZ89P1WXIb8FHYqoR2wUn4ANx00WwsMnCRZa
         g4pee7OCzwAb78VLiTQG8nivhw0UQc8cex/J9aQiV0/wIDa5qPzwBbfSGB7a7mPSlLVz
         QpY+aKtM6RL5R+hE0qNp0gyuelEn46gw7eZx81NkUbNbnrLhG5Kc1mu/ipPP89sGMY4s
         qDVA==
X-Gm-Message-State: AOAM5330XIJY3MFVxNSkxWcJ10HWX65MvsSKkXxl+o5CMkBjIGFR6MGl
        eLHRu/YtHuRlrxW9wJpIqt5q5vlgPhS2UaevhhPmCQ==
X-Google-Smtp-Source: ABdhPJyVXQxb2WStduflc8ziDJ/iq9alEg0Ys2bSXmPItpbNP4s9a4/DeQdKJ02m2rZfc+IhApMgmFH3wEFyoiRlizk=
X-Received: by 2002:ac8:134a:: with SMTP id f10mr18680640qtj.131.1593000973743;
 Wed, 24 Jun 2020 05:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200623145748.28877-1-geert+renesas@glider.be> <20200623145748.28877-3-geert+renesas@glider.be>
In-Reply-To: <20200623145748.28877-3-geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 14:16:03 +0200
Message-ID: <CAMpxmJWGckzicz6FddXybcJh-hb+-hoGbV29Z3BA61RVQ1nQDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: aggregator: Use bitmap_parselist() for parsing
 GPIO offsets
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 16:57 Geert Uytterhoeven <geert+renesas@glider.be>
napisa=C5=82(a):
>
> Replace the custom code to parse GPIO offsets and/or GPIO offset ranges
> by a call to bitmap_parselist(), and an iteration over the returned bit
> mask.
>
> This should have no impact on the format of the configuration parameters
> written to the "new_device" virtual file in sysfs.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> I'm not super happy with the mask[] array, which is on the stack.
> But there is no real limit on the number of GPIO lines provided by a
> single gpiochip, except for the global ARCH_NR_GPIOS.

Why not allocate it with bitmap_zalloc() then?

Bart

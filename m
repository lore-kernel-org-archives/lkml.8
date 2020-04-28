Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5C2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7982206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZJiPMCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgD1Nxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD1Nxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:53:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9DC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:53:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so8005477ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/fWDN7mDDqYLAmmXW/SbuqDdwF/3UMPgZPEucxrYVY=;
        b=CZJiPMCOx7X2ZGByE6u7Xcq1U3WeSVV/3rPPNf+eI8yPxACPZoq5mW+rLc4puGCdc0
         hXqz8KsE3NQyK+f+/3IzUJSk1GDS6h060SWGNs0pBG3vkEhzluDilC0A1gw7UJ/bdQcV
         6SL/C3xnGq5lhZ96SGCCtbIO837Ae5PhSjojqU2aSkA/HO9RpNp8v1VHYBR7DSegcv2g
         oJ9y3KCWU3CQMzGgNEbKaIoMNHfjEIEKqjSSZhu/vcKcnQUPiBhqziDeh/39xK+zHIi2
         LdFHpbFpn1uChvfoMux3xD1CX9cb+wUuot1xP++WFh4Gb/KIOd5w6SjXwbVm7d9BNa1I
         U/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/fWDN7mDDqYLAmmXW/SbuqDdwF/3UMPgZPEucxrYVY=;
        b=kLB5GNydqHcUD4SKIcaHF0dRAsbKDpNdw1HnRb5bsP9EPLsdTGf8KR5bvA5eNR7at7
         a9MoPa/VNJXwHtcWf+9QeMT52/EMqrJ3Tues6kGT5od1PqZ6dWeVtj8OgavEitOoITff
         2BLrhaR3okT3hWllJSSW/amLZ+ky/H87pXOMa4x/jDzI/1zdDeW8uS8Iou/ZLKr6BX52
         AT6IZU+XYwhBf0McS7ZM9EvlhQlr3CVRcybFypaG8fiAkH64oi0f5LBwHemv00aUkAgh
         +75qpVuWgSMzAG3cWaFtdZHDv8ssaQvHcMyxV39fHMRyWXuGr5xroSQmUA83j1bIJ9Wa
         p7tQ==
X-Gm-Message-State: AGi0PuZLDEmNHCIZWplWdMj8p+O605/1J737YKMUsoLkVCMsqMd0eOew
        jkvtGiXRSXVXq8dGLymqvD+Dsas4kr23+5lM+48KLQ==
X-Google-Smtp-Source: APiQypLrlOkEwUuaW+ZE2ms70LGWakIPfN/GLVZj8T5r8/WjawDU7q+VAHVoFDhq+cKIoLc65EhT732GDbAVZ+2Z6+s=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr16376560ljg.99.1588082030295;
 Tue, 28 Apr 2020 06:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200424154103.10311-1-zhengdejin5@gmail.com> <20200424154103.10311-3-zhengdejin5@gmail.com>
In-Reply-To: <20200424154103.10311-3-zhengdejin5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 15:53:39 +0200
Message-ID: <CACRpkdY5_+_n8qfUxAGtG16QW_VoVcpSFZuoBR8A6iuCbmsrFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: mm-lantiq: Fix small typo
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 5:41 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:

> Fix a spelling typo in gpio-mm-lantiq.c by codespell
> s/dont/don't/
>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v1 -> v2:
>         - split patch v1 (only one patch) into patches for each driver
>           by Bartosz's suggestion. thanks Bartosz.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Andy: since this is an Intel product are you picking it up?
I think this Intel-MIPS platform is a bit of a special case so
I can also handle it if you prefer.

Yours,
Linus Walleij

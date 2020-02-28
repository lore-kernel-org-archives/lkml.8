Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26EC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5109821556
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMe5Q6us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgB1XbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:31:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33039 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgB1XbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:31:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so5224457lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJMOjeid6sdwgXv4TTvMxMhevRyWK73UfsN1mnUN154=;
        b=sMe5Q6usg9+F4riRxov5cjG3cyELLD3oY3eqeIrCM0aMmY7BGEfLMLJT1SZ1gK0IwN
         UFNBkrP7J25JufhFor+00VbaiY0V3wNFi5Y0V6yp/yTwjh7YTnRrLqyZ7eaDMrvF/TzZ
         Dd+uXEyp9pONbPMH+vFvJHPbmE3J7xZx3HwKpXwcCLupuc+vQZA6GenODw9SfH6Az6nZ
         hzzXjyLjydDHeMjOWfWF8PjkvIagnRsfW3bwZi7A4bzOB19Lx7TbyhEccYzR/YHRJNAZ
         eoJubijvMqEQ04/8kdlkwXDI6wo5CzuUN5RPHEtk0Zeu1q+sM3u3109tFuStjvE6jYPa
         NuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJMOjeid6sdwgXv4TTvMxMhevRyWK73UfsN1mnUN154=;
        b=NG72WODpQq8zD6qlznbXpSRMdHWuN/974Yh2R8oL4ED52LKxuVDrEZW5PKSC3thbaS
         BwgFJj9+dcsIBLuLuHMdXD/fxz/84nPN3q8KDKCzbv8op2uCSpvlLvHcRGfzebi/Es97
         cBoe2obY8VH2XYiDNZZPx2QZmbHTp09OX8TbkE0v7DI7A0vzgqAtcBBkPUupAEY64j9t
         NGzJ1XHCIMRE784rA6Cu5pDeHI9GY86GJVpX8R1hNWVFf/atz6lhgL0uWCJwpwRG1LD2
         saPCmbgVL+9XiJ5q68YqXNq0EDi1s3YzkDcmurlCeght/0xhuJ/j4SwRja1L8JNIhh6X
         Y6bQ==
X-Gm-Message-State: ANhLgQ12v/9F73lwEFOj6ymRqsfNMjMBEsqZJxzqkXaorB7Rt6t6vFWn
        KKUbFDQiiCY+GTMe4D1t03bAGLPTBvja9Kep1lEo7Q==
X-Google-Smtp-Source: ADFU+vsxoOHRMUZvXuoHzVp2SunBEAeVGYJ5QRP7my8lror2nKWFrPn2yB/CjkXexreMLjBZgrvV44n23yoajzkayqA=
X-Received: by 2002:a05:651c:2049:: with SMTP id t9mr4108228ljo.39.1582932660936;
 Fri, 28 Feb 2020 15:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20200227185837.GA4469@embeddedor>
In-Reply-To: <20200227185837.GA4469@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:30:50 +0100
Message-ID: <CACRpkda4wEck_JYpMYuQ+pAkaVo1JUE9nUpNseCBRCFADpZ9Ug@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sirf/atlas7: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Barry Song <baohua@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 7:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied!

Yours,
Linus Walleij

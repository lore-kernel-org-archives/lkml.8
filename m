Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D94C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164B020679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4LtiqIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBUOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:37:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40310 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgBUOhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:37:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so1650104lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7mTmKB1Y25U0g4q3RoTli21LYId0oXzN7cSDlfaxGU=;
        b=J4LtiqICrcN1d1FVgUAW+f6vnzA520FQfsoVgKLyplCBIVY6LTQd0ghkLG9rNIifNR
         Y4Yl8HIYrnw5JV5SphEUVgGMWU15R3N6kivbt95EfiN+JdzaGVX6zzpNX3qX9CZXcf4E
         LYEjgEWi509SQIo8PlmMGsKVCtbweF5z92tDm08Ve+SXthMI17jFi55+CysFV+3yZjI2
         7Gs1cGYR4yz7uKBhsfeGTLtR1Qb4qG6i5iUJ/RotNNXzByhhQe9y80JDZfMOOPN5GDyh
         /eVeBYbLLYtgVj8NCBseh4C6efBuUTSQ72KFG2IHQYjM0KMawg6SxUSf3koWkFnGVCuU
         r6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7mTmKB1Y25U0g4q3RoTli21LYId0oXzN7cSDlfaxGU=;
        b=exXocaACuIaKuXj2+JOofJtrnYCGzMIEYRU7U4/81Au4yMABa9clDsLmnWLHdO6oXg
         VSyLPxyS47Ln3HM6UYJEAvC0Gy4tQAXHgIwMRLs4IfYIxI/5FnoAywD6w8jp7L7Kh//+
         F3J2YYTXSNqc7h8ouu46cysL57KtX6ziq+G6DEgEnnFhdhUuWRdo13gwRpsy/ypdS2xI
         B8Q4MKUr61/JxaQahVh/iraAJRVKkpwSYDdZVVV8NI1ZUN0OxT8OJK/T+MJGTcnqExoF
         CvxhAB4lWKKghdu5aSNZCbILELe5f/AtWXcMUZ/uCkjuDebP7mAz+gr7rYMUpz3ev72w
         ialw==
X-Gm-Message-State: APjAAAXMJsqQeyj/8rYbiyBN16ymrSzcjR/2FRV3cSx8YvOi2MtyN9F4
        mZXwENisNR3k8HcWQ6g/YLkz61rH33poOusXMic8Og==
X-Google-Smtp-Source: APXvYqyAWnLDYIxOg7JWzArkYp1QAJB8O//RA7y+f9fkdXf46018OkIiEEmlg593NgXDxY3ewyKPZHYklLUJa00pt3k=
X-Received: by 2002:a19:5e1d:: with SMTP id s29mr20173445lfb.21.1582295838433;
 Fri, 21 Feb 2020 06:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20200217185437.GA20901@embeddedor>
In-Reply-To: <20200217185437.GA20901@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:37:07 +0100
Message-ID: <CACRpkdaJHQoZZCK0tJVb5Ntxsg+gr1FcHwtdxjQEHo=ZiKkxAQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 7:51 PM Gustavo A. R. Silva
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

Patch applied with Masahiro's ACK.

Yours,
Linus Walleij

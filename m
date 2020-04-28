Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A6C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540A9206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0lctHGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgD1NvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgD1NvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:51:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C0C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:51:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h4so7994882ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=No9mDU8+hvTrxab2bfODpNQEmVb8+9eYKL1viviYflk=;
        b=F0lctHGXr6jxwvKD4j4xHhHu6YEO/4zlTpbN7NBj+iDYDcRv+wMBBKfiOOM+FjiMR+
         lpR9iy2WdJwDPLMri0y+4EDQWpt3PO7Gkih2Kn6NOAKd57pi1KoiFfPXJNAGBMDqJHC0
         PDoT931yQq4MLlavt+7GIhVrgpoUvNVnLqUqJwQzS02Uv1JuUU/GDQIMPeFVxCHdYjL+
         dNJELMJC65x1lv+B9ioAWKrWL7MTGups367J+RXMINkXOt7TZqoF0W7XZ6mDb/HyKmyK
         Rvr56ynF6c9t4hGrSfszYPHDkkotjTPKZ2At7Bp0KjLq2aSTb8B/1RBmpO/SeXpxpJmg
         e16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=No9mDU8+hvTrxab2bfODpNQEmVb8+9eYKL1viviYflk=;
        b=cRUeEaX+GI2HqQv63NA5ccfUBMD43AYVUTj79YnsXnSscse0cbmQ4t5uTgnWCLQovb
         naOr0nE//6bmMgorvKmznRhNlUEOr/DvCTCIk3nVj8zHZsy4Qelm2dvjTmNMI3/X7MTv
         G+6FCxqt392QMi1puFuZLibkwHgOsoZG+LufPoi8J1DkE53Syw1tah+gkiCbpfi16+Wg
         7TimuQlCNiz98V+0RVU+V4VBUKt9TzJNpCuhaIKYa1r3nkQO1Gfo/liCzp75mAupk58F
         dFSag+RoY33+FiBwlpdh5hOzESPj7Y6pLPFQLvSxMrTpmkDS6BSKTam33cpifAlOmIcw
         q0oA==
X-Gm-Message-State: AGi0Pub3GhPXV7phJQ0OGfYuQNW8+D1wfHNrNzGwzH7Zab6xKzS5l2uA
        J0pDFtIxXBsX2RqaBzLqfKgg2/bLkQ4JS5nWzAqIuA==
X-Google-Smtp-Source: APiQypLdIhxDt7oAMgAtRuC1BqrbNsbzfwAGYm/SlOw+A65DFkTDz7D8p1kJXqeCEJ9Pc5tSJD376epb7DfyMNEXiso=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr18490498ljh.223.1588081861179;
 Tue, 28 Apr 2020 06:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200424154103.10311-1-zhengdejin5@gmail.com> <20200424154103.10311-2-zhengdejin5@gmail.com>
In-Reply-To: <20200424154103.10311-2-zhengdejin5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 15:50:49 +0200
Message-ID: <CACRpkdZD4x3PV4jn0Wwxq7N_Ub4HGQFVFzniTUHYajQSOy6sGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: ftgpio010: Fix small typo
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

> Fix a spelling typo in gpio-ftgpio010.c by codespell
> s/desireable/desirable/
>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v1 -> v2:
>         - split patch v1 (only one patch) into patches for each driver
>           by Bartosz's suggestion. thanks Bartosz.

Patch applied.

Yours,
Linus Walleij

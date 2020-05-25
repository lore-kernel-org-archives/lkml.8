Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54652084C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgEYItP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:49:15 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:41412 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388773AbgEYItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:49:14 -0400
Received: by mail-oo1-f67.google.com with SMTP id z26so3453326oog.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+PuH/pTGAFDoL2hcME8N+/oYCZf4CIdiqezjAv2DZ0=;
        b=jAocEbMXtiBYW6J0Lky0SwLf38n9GXNy6eDeQFxaduUV2vjPLuSHs/BrkrLQyOrizJ
         uurvnNfLGgKwSgeQCA4eeH8xX0H+pSSCQ5+SqL+5UlTY4DDUkS+GPe9v/ekGw3MeSh7x
         q8OJIJt46DrMpwNjrDCPwXp0DeNu2s5w9RQuR492UYLc+5jqpbW4gEe+hxAFx3beVmfO
         rJxsxkz4tSM4tk0qo+rQB3ECEfb3lDFmNE6IZUoamwPAw2VvjbPYvCksAET1OZgmSpFI
         VGv+BRLqj5h3X5DGrWyKF6CQASHZStCTcaxjrj2LnKiSpIlVnk7XPoDKoZOvhLYkJMcj
         utZw==
X-Gm-Message-State: AOAM5339hV8wvvR6w5Nc/TYnGY3uH+ryC25lZWfhcsCbYnjDeznLJfHp
        VN//Ziy7SvgMQ0ZoCWPJXKlS9BG5Qw0axO4BMGw=
X-Google-Smtp-Source: ABdhPJwx++7vr09NOyjF/OrUTnNC3we2My4ZE1fNWT4N/UM+Ioatv7uIPOceNSYDHBQKEw3b7wBE7TZ7HQRP/gO1ySY=
X-Received: by 2002:a4a:95d0:: with SMTP id p16mr12463896ooi.40.1590396553331;
 Mon, 25 May 2020 01:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200521185707.GA3661@embeddedor>
In-Reply-To: <20200521185707.GA3661@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 10:49:02 +0200
Message-ID: <CAMuHMdUGPMrPTqypGpnhe2wdpnbtUOsdUacnrHAapBM_996F5A@mail.gmail.com>
Subject: Re: [PATCH] m68k: tools: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 8:52 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
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
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.8 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

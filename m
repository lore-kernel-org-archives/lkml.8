Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68535C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C130214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgCCJ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:57:32 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40736 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgCCJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:57:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id j80so2394692oih.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YqxdQa1ilWOSiLraQPjm7TPTEifD+tyJWNIlA8bYpk=;
        b=CY7XhQM8JmaGloS6gAyGBhpxfdZvfce80R8NlxmP+amLJfTKUtc9xsjd/HkPXN6dl4
         SyinhiQ77Amdly//I8XTNns7hk1E1x9EIj13l0F1gxmHRybSd4z7EinSP+bbnM6Sj7V8
         beqJruZD+F1Wbd+yaLsHqRUGTTSCx2MlluzKtmhbtAG3n+7rwZo57FZadiOBeF+U0CPJ
         uIfJuCb+jHLCR+DPWZtP8BYLiVOivkZMNSrdc/c5wRfBukK16WyqOt10/3jW2JDBCjio
         JW9XlmkR80Y8bpIc0dJKbkhe70JLLq3BsroJE2PIJ+i2dApVkhSbqtNo8G9SLL5Lv0Ak
         nOCg==
X-Gm-Message-State: ANhLgQ3gJ2vqgwRQXIN/xeNYKMdBTdbxpaVAlZoIEpXCEKOf+MeQPI8b
        crmXUDjkgAfUfFCAih2lZ5qkw75wFVuNj1vaIrrBYQ==
X-Google-Smtp-Source: ADFU+vs9z4mBtCuZweCHY2/aqnLaygT4ej9HMxCl8wm4hVja8W8jGcq442xFYlOU/W0oazaGHEEdSqsMhYOZ6MqTl2M=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr1781294oig.153.1583229450514;
 Tue, 03 Mar 2020 01:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20200227183748.GA31018@embeddedor>
In-Reply-To: <20200227183748.GA31018@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Mar 2020 10:57:19 +0100
Message-ID: <CAMuHMdXCWtgGKM1Uqtps4CYbGsfBZtoQ8e4t8VrMoL29nP4V3w@mail.gmail.com>
Subject: Re: [PATCH] zorro: Replace zero-length array with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Thanks for your patch!

On Thu, Feb 27, 2020 at 7:35 PM Gustavo A. R. Silva
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

Note that in practice, this "undefined behavior" may lead to corrupting
the next member, when the zero-length array is written to.

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.7 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

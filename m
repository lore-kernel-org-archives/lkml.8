Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C05C2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz444vhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDGWbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:31:15 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50793 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDGWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:31:14 -0400
Received: by mail-pj1-f67.google.com with SMTP id b7so217002pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w44VJtl16qHNkWkqplH4KRD3jsqhKvrC7qlIBo2fGY0=;
        b=gz444vhAbYuQ2rwWXgbT3tAmEp6Q4FD8q2H4HadzmJ+f7Rnl+FSlmoHrMD9snN/UZ5
         yU4CBguJ4Ea2QfELx2EOGlPAtY7JEhbAPpP2yKtwsbQ9Fp80yfXrPFscbYI3Dl4GBJ64
         1Oj/v2bP7TFNa5pCZT40cjYLo9s/qLI0tb03VX8TWaxfvZHCmseVEP80rTlMEEARlKV9
         rOAauFtJvQEzZqAWgUJlXnhH0cd4K07Cv8tmKFBO22XibYHs9xa+zmgqkjplCGqn2Dir
         e7xMXi49+8TkCS2ZvIh9sy5XPgEba78lPS3dlEnAmTnpTny4Qc8Y2H9dKk4sOQxld272
         u0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w44VJtl16qHNkWkqplH4KRD3jsqhKvrC7qlIBo2fGY0=;
        b=jliDT9Y4sm4ukf4MFj/+xKCZHfi6znMVUR8Cf8pJRmsX4/jNKoNCRQMD/ILr0Riod6
         55fdVBUmLOexAuq7Acz3XWy3mmo4MS4FMeKHV8XCVDQ/WhDx64TCP1nl7oekQlqkSfUp
         /ME3vRlf3EJy8eGwzQSJjRcGNCp1KNSjqNNtKyrn9dNFPKQjy2JRbwLgP4pmTBArl972
         UdNrfweQO1C8FI8nHf3gX3jMwXEL32jacO8rbjHwnzn9NzTOS8ZOoG2Syu6aYKzO46Ux
         7nlDA+bqbQjWqt6vmAYed2JIdSVXDPFF83SSb8TjGAq4/R+ArYN6EBe2+hVkZaIaHgBy
         t9WA==
X-Gm-Message-State: AGi0PuZmfJWJX/B2omX2R6UhSHz7k6JBkjAgvOIcHUenbdsDLhprlfKm
        Mjf0NnvDQbWnyiCI0SyX5DfLvLTh2rcyw5mJyIM=
X-Google-Smtp-Source: APiQypIjQ0n7reS+FFVDBxtFpI06BT9cEhBAgsZFkno4saYePMd7jNdUWDmcGQN7WTy3wy3n3h9OMKCf564GRLTAHQE=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr1715859pjy.1.1586298673972;
 Tue, 07 Apr 2020 15:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com> <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
In-Reply-To: <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Apr 2020 01:31:01 +0300
Message-ID: <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 12:45 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Feb 19, 2020 at 8:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:

> Hi Petr,
>
> Bump, as I don't see this in linux-next or other public branches.
> The discussion was split between several threads, revolving around
> the vision for how lib/test_printf.c should be structured, but the
> fix itself wasn't disputed.
>
> Could you please pick it up for 5.7-rc1?  If you want to restructure
> the test suite before adding any new test cases, v1 doesn't have them.
> Other than the test cases, the only difference between v1 and v2 is
> added reviews and acks.

Petr has some obstacles that prevent him to pay attention on this and
actually do anything right now for Linux kernel.
If Rasmus, Sergey, you and maybe others will got consensus here, I
think Andrew can take it thru his tree.

-- 
With Best Regards,
Andy Shevchenko

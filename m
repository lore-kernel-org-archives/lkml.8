Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B1C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683D52071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 08:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da9GNL/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgBVIOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 03:14:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45315 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 03:14:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so2182290pgk.12;
        Sat, 22 Feb 2020 00:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/sEM9m8/BfpN//Z+cqohWMKYfsWyIj6BtdHG+fGeTc=;
        b=Da9GNL/ole8tIKOnRXqSb/UKpnSicVYDSkjADZ2BTQndythvM4xoihiGyRyvL49FqP
         ehVg5wBYbKr2F0ESSTonTut4j7Cl0+y67/qKRcKUVb2rRc+VmnIz8zmwOJmMcq6mwr9a
         ONE0zDxw1LlQeTTbwxRdaEt3rLxf1TXptzHvFPoPUOJHo1ZHKLyCbeiGhVCxDwsApRxm
         qHxCIkmgR2nW3I/1mDdXnXwMkKvFgcFA/F1vKGyjbWQQ9G/KSukNsedcMLjgGIjIPT5D
         7VbVGuu198KH50GCh0GGCAG+sFCCE6hESeiFKQfFcGvSO9CMRUA45EI1xNCjpUZjC17P
         P91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/sEM9m8/BfpN//Z+cqohWMKYfsWyIj6BtdHG+fGeTc=;
        b=Ai6+TvzC2ZutcG0kEztpTdRl6ZuXV954HsOTzHZKIQaPnQv5ZBR3I+hGE8w8WR4Q+V
         vqKz4X2wKYXnfI4K3tfYypqL3+JJRjicQ3O5xajKqFIEbqV5x0E9M+RkXCrMHMKm0hFp
         lEG8/6fX9LypiL9hBCWgF4ZLgchS1SE9URS0utAiKKphLmDWLAbGxHpaENmRzUwBXQ3M
         +aRE65ojHtixfHyNm46LUYgztFAmPvjOS/0PL6mqh6Nd6wRGLxjY2nX6btNS6h4JaUFR
         fWjmAKlsuPWP2Xwkwzw1Jn3Vpxk/FRYMectN6mSh3vsMa+tsrKVIu8r9/iQKPWyFYZSO
         2ZaA==
X-Gm-Message-State: APjAAAXsNydxgA4ocJWVeSpAQ3OrKOP7NvfM54Uo61PPGq9+td7rFjeS
        I3+zs0dG66y1ax+S4cJ8BKhAY6WvHT65QDqUmOc=
X-Google-Smtp-Source: APXvYqwnXN+u1jIKOYXizt0jOLd/M21T1Ya20W6R4Hw/0giVBYykU3S0HHyGxESG8ar+ffNtHFYsnmM7YWzYimpv6TY=
X-Received: by 2002:a63:5a23:: with SMTP id o35mr41725204pgb.4.1582359283721;
 Sat, 22 Feb 2020 00:14:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk> <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk> <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
 <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk> <20200219144558.2jbawr52qb63vysq@pathway.suse.cz>
 <bcfb2f94-e7a8-0860-86e3-9fc866d98742@rasmusvillemoes.dk> <20200220125707.hbcox3xgevpezq4l@pathway.suse.cz>
 <CAOi1vP8E_DL7y=STP5-vbe_Wf5PZRiXWGTNV3rN96i4N2R3zUQ@mail.gmail.com>
 <20200221130506.mly26uycxpdjl6oz@pathway.suse.cz> <cec0c65b-5b5d-6268-dae0-1d4088baab76@rasmusvillemoes.dk>
In-Reply-To: <cec0c65b-5b5d-6268-dae0-1d4088baab76@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 Feb 2020 10:14:32 +0200
Message-ID: <CAHp75Vft5YiHndMXvcQfHoV1R5M1VHc5bzLgZBAsiBmNFzgvsw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 1:53 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 21/02/2020 14.05, Petr Mladek wrote:

...

> and we save testing the "%px" case for when we figure out a good name
> for a helper for that (explicit_pointer? pointer_as_hex?)
>
> ?

real_pointer() ?

-- 
With Best Regards,
Andy Shevchenko

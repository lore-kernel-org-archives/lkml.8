Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A830FC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7435B2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpLbf4ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgAPJXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:23:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44686 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAPJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:23:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so18434022qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 01:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqTHK7EsHlkxZxI0RjfjnnG8P6WuHcl1Hv4xLIayM+k=;
        b=HpLbf4uxq8fRi3bKhNWhpU5pHPQckZfZ59vh4lK7H3xBt3xhQD10n+b7yfJQNUjRlE
         6lrTGckCWoGJ80lqWQEPzJAX/y8viSSaP6MmBJp5ZRrJ5bO1Tvvcn7dNK6JAAuiRFgJ0
         vUsyFFsl7D86NxAhTcG3FNEpM3lkaEpRs02bNjsI0wTbwnCMr6jQX9+ehe2MlUysBU5d
         FPEjlJw1uTPm0hz5FMQZcvBd2m+HJhpZQaHVy0Ge8LZ/k8ygGX1GdF//REwrGXAZp+Z/
         KTczAg81N3qZYs0gBnM03cA3l54YK4/Du1xkipH5D01C69gU++YuCiMObidhYiQSV67a
         bo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqTHK7EsHlkxZxI0RjfjnnG8P6WuHcl1Hv4xLIayM+k=;
        b=pGYL0ZHt3kcIwDCupBqstHqCA2RYgIvvrmWjbCSWYjx4eKngdsrd/t79vVMQX+Wlct
         joaH7VPtWBRjWcIEWab+3r9HxNnSckksMg3AjjSPlh7jR0rCZD3MtoUUzc6t4cGOmGDy
         +RQ6r/e1zTynAZjyGy/zcu3ZvZfREt6/NIllemzeOtN06bIlnHj7vvtfTZPTGKCGn5zZ
         Oy1PToQ3O4vKWPl2oFbooc6wrCvgvBIQ2knjw13CS1N6Akr7CyUWBKyJ090M8C5ri8SS
         FnQY04ILm5GLVJquvgMyUyno+96VW+1ICt0Cz+lx5bB/7/X4d1ARs8yV3frUmdgpEsNO
         1paw==
X-Gm-Message-State: APjAAAVQnAWWskyV7QhmMLSih/I+JQFn2xS+FILaLIdJdkEw787eaqdL
        3hXwnC4TtXDfgKCAPpsom8mzAxdlQXzUqhlqrbcZPA==
X-Google-Smtp-Source: APXvYqzRcOD1MwxQn8qYqwSzfmgb2otB+rAxauBC2WSZWrut8reYJRkAHaY0kX+FVmBcUlxUEcZQgk3dsF7IF5+sa10=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr31201094qkg.43.1579166595511;
 Thu, 16 Jan 2020 01:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
 <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
 <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com> <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
In-Reply-To: <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 10:23:04 +0100
Message-ID: <CACT4Y+b6C+y9sDfMYPDy-nh=WTt5+u2kLcWx2LQmHc1A5L7y0A@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        anton.ivanov@cambridgegreys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:20 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-01-16 at 10:18 +0100, Dmitry Vyukov wrote:
> >
> > Looking at this problem and at the number of KASAN_SANITIZE := n in
> > Makefiles (some of which are pretty sad, e.g. ignoring string.c,
> > kstrtox.c, vsprintf.c -- that's where the bugs are!), I think we
> > initialize KASAN too late. I think we need to do roughly what we do in
> > user-space asan (because it is user-space asan!). Constructors run
> > before main and it's really good, we need to initialize KASAN from
> > these constructors. Or if that's not enough in all cases, also add own
> > constructor/.preinit array entry to initialize as early as possible.
>
> We even control the linker in this case, so we can put something into
> the .preinit array *first*.

Even better! If we can reliably put something before constructors, we
don't even need lazy init in constructors.

> > All we need to do is to call mmap syscall, there is really no
> > dependencies on anything kernel-related.
>
> OK. I wasn't really familiar with those details.
>
> > This should resolve the problem with constructors (after they
> > initialize KASAN, they can proceed to do anything they need) and it
> > should get rid of most KASAN_SANITIZE (in particular, all of
> > lib/Makefile and kernel/Makefile) and should fix stack instrumentation
> > (in case it does not work now). The only tiny bit we should not
> > instrument is the path from constructor up to mmap call.
>
> That'd be great :)
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel%40sipsolutions.net.

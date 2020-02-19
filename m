Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57265C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D859206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEbSTUvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBSRhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:37:38 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32862 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBSRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:37:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so303966pjs.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3mPqc+Wc2BYmBfLm7UX6uarTjFea9zBCaFrXja1Tvo=;
        b=dEbSTUvhj5Wof544xqUrjSNCVduSag+cy0MWcJ98tVnM5IcWp+rXtWy3EFzn8LAe8c
         yOg//K+GcogUWXYrLJqb1JFx1sybxZr/3ImJaqH0shlX7NF4irZNtX41TETebHxm04Hl
         jNwgjHeM4Ep6o4PZhD22Gj/ZMOrgDitYLrR+Ubx34KvSVKg5jQbEZm/tKhlH5fDaRWss
         8OTa8fj98ZAZP6oj9PDmAHGmoXyM6ATt7lUNQhV8j5sOgg1jGpotDldsjkBK+gj7ZqVK
         Y+MDxJPFVE0fhtLJH3f++ovQTVvAac1OkPdDBJtNOX3VU5I3JERRkDt7vo/3W0QbBsJx
         Y/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3mPqc+Wc2BYmBfLm7UX6uarTjFea9zBCaFrXja1Tvo=;
        b=RpNJGC+bQCZc2RVS+DV85Z4j9ipzIxZYiQEMpJvBuNazkhzAahoLELfAHqMdC0grRs
         YpXlqv7VXiCf9Q9bETV6aWF7R4UUEBOi0XviXB/PUWJvcXX+dCnGaaQgxzY8rKxcmK9m
         A2dHk49a6ImtmjdO6CW1HGb8zBfxom7aTwPh+nB2QrmVT9j3/wpIJOoCJSd/+iDblyum
         2g3mBH3N32FrJgMY389DJM8JHQFIGhlF25MlC7OhTyP9BLjgXWSPWeVW7arDFOdVmE0U
         eCtQ2f/v9heLy8fDjFhr1wBIvirLiw8WppK8+6nr6pUTMQKgqeE0e4vCAoVT4UF2n2Hi
         fuag==
X-Gm-Message-State: APjAAAXccJmQY+VU5jJJq5TEKjoeMtA3PiDmHoPwrFLE3AcktsyU65cC
        c0IDhb6MiHcA63kVbonw+nSKBk7/d4tQM+OrOfU=
X-Google-Smtp-Source: APXvYqzsCIa6bh8M6vrNCAjhd3hZMzPwYj1lXsLQpDBhz3AucbjGgW+6blclSlx9ntQ6O1SYbxyfninNyf4f6+pj/pg=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr10416494pjq.132.1582133857025;
 Wed, 19 Feb 2020 09:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com>
In-Reply-To: <20200219171225.5547-1-idryomov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Feb 2020 19:37:29 +0200
Message-ID: <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
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

On Wed, Feb 19, 2020 at 7:13 PM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> I don't see what security concern is addressed by obfuscating NULL
> and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> of sites where %p is used (over 10000) and the fact that NULL pointers
> aren't uncommon, it probably wouldn't take long for an attacker to
> find the hash that corresponds to 0.  Although harder, the same goes
> for most common error values, such as -1, -2, -11, -14, etc.
>
> The NULL part actually fixes a regression: NULL pointers weren't
> obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> dereferencing invalid pointers") which went into 5.2.  I'm tacking
> the IS_ERR() part on here because error pointers won't leak kernel
> addresses and printing them as pointers shouldn't be any different
> from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> debugging based on existing pr_debug and friends excruciating.
>
> Note that the "always print 0's for %pK when kptr_restrict == 2"
> behaviour which goes way back is left as is.
>
> Example output with the patch applied:
>
>                             ptr         error-ptr              NULL
> %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000

...

> +/*
> + * NULL pointers aren't hashed.
> + */
>  static void __init
>  null_pointer(void)
>  {
> -       test_hashed("%p", NULL);
> +       test(ZEROS "00000000", "%p", NULL);
>         test(ZEROS "00000000", "%px", NULL);
>         test("(null)", "%pE", NULL);
>  }
>
> +/*
> + * Error pointers aren't hashed.
> + */
> +static void __init
> +error_pointer(void)
> +{
> +       test(ONES "fffffff5", "%p", ERR_PTR(-EAGAIN));
> +       test(ONES "fffffff5", "%px", ERR_PTR(-EAGAIN));

> +       test("(efault)", "%pE", ERR_PTR(-EAGAIN));

Hmm... Is capital E on purpose here?
Maybe we may use something else ('%ph'?) for sake of deviation?

> +}

-- 
With Best Regards,
Andy Shevchenko

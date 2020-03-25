Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41AAC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9291A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCxSv0lU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCYQeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:34:05 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37284 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:34:05 -0400
Received: by mail-pj1-f66.google.com with SMTP id o12so1227416pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/mwcS2k49Q8FtkpWy9oWS3FImYCLq2+zg7rNJhSOZg=;
        b=cCxSv0lUkGe2EkApXp9qAszTvolABAR+7z9AuUMmHhvDbeRZpWR6Q0bYuAPqFUF6Zp
         jAqjCTAjkGIbSmWBIMSVXhJN66nTO6w4p8bJGqbMGN0RHan4V/rN4nSpCoCZW/+IZ6Lb
         BapU1uUUBkAzcg6RjyW9DQk9sAa9zz9BVA+3jFW4plA85kvU4GJN2702eW4e7McqWvGD
         vqNc4jpN6Islq1dfjZ+sI3gFRBxhl9R7Wxh+vHtiJsDfeEADMZK5MKd2zrcYY7mHxonR
         FLL/P9nRwVdwkoJlihPemv1VYENWVfU4m5DOYZYY4ZipQAOx0dPlpJrEcWA7pK8BdsOj
         UcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/mwcS2k49Q8FtkpWy9oWS3FImYCLq2+zg7rNJhSOZg=;
        b=B6dMagGMh2N6kAyYHh0qgOEGhujn337id75oSBxSta7ctJWR2bNw62/WwQiW8oYkz9
         QUtKbNo4A5Uw2fHXxftZnPxzy/dv6vcu+qccFbEW1b6PUkazAau6+g4XsyEOwTnYhwW3
         epxMDA7fTmol+EEqyogUgK6O0rem5vOvZmcgMuUst7DPpopWyvLNUu3xinh8W5eH097x
         /fDEi7FcLFrAmi8UyIeXWsuteeCjaEGOMJet5Mu74wCtrgsuJfAAZtlVTurU77ocMzOn
         8GvmtFs7zc6to9TGZpu91mJ8pAMpGUyg5tGnO8VbYDjfuu0CvEW8w0Gjr4N+YtF0LMf0
         DCfQ==
X-Gm-Message-State: ANhLgQ2rLvnHaWOREfn7iP3c/u7ljAfdVTEkOLzuhj1mLhJgzCHCQfsW
        8NMzG6St66Rk4Ig88TE+APdceNHXfUje6JS1XxbCtg==
X-Google-Smtp-Source: ADFU+vtCxCivYqNY8mO/9aWa/cKHkQkKuRGcuG8inKcGrdz+TlM7ovpnPxVq4LLDz6GsobBMJqt1oTu+L8Xs6yWLSDM=
X-Received: by 2002:a17:90a:32c5:: with SMTP id l63mr4814987pjb.47.1585154043671;
 Wed, 25 Mar 2020 09:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191121235058.21653-1-davidgow@google.com> <CAFd5g46Z_vVb92Y-sfWi68=HFy5+kukZXvT9usEEnhBUvPg3AQ@mail.gmail.com>
 <CABVgOSn1azUN4XujHLsc3NY9fOUPB4Vw6930zc4oR26kxqrwOg@mail.gmail.com>
In-Reply-To: <CABVgOSn1azUN4XujHLsc3NY9fOUPB4Vw6930zc4oR26kxqrwOg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 25 Mar 2020 09:33:52 -0700
Message-ID: <CAFd5g44ZNv-BP_t6M1EWQjXbgBYsA0+oBZ_-nTAmZbE4GNWgpQ@mail.gmail.com>
Subject: Re: [PATCH kselftest/test] kunit: Always print actual pointer values
 in asserts
To:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 8:33 PM David Gow <davidgow@google.com> wrote:
>
> On Tue, Dec 3, 2019 at 3:44 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 3:51 PM David Gow <davidgow@google.com> wrote:
> > >
> > > KUnit assertions and expectations will print the values being tested. If
> > > these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
> > > pointers are currently printed with the %pK format specifier, which -- to
> > > prevent information leaks which may compromise, e.g., ASLR -- are often
> > > either hashed or replaced with ____ptrval____ or similar, making debugging
> > > tests difficult.
> > >
> > > By replacing %pK with %px as Documentation/core-api/printk-formats.rst
> > > suggests, we disable this security feature for KUnit assertions and
> > > expectations, allowing the actual pointer values to be printed. Given
> > > that KUnit is not intended for use in production kernels, and the
> > > pointers are only printed on failing tests, this seems like a worthwhile
> > > tradeoff.
> >
> > I agree. However, I also remember that others in the past yelled at me
> > for assuming that KUnit would not be built into production kernels.
> >
> > I feel like +Kees Cook would have a good opinion on this (or will at
> > least CC the right people).
> >
>
> I'm tempted to take the silence as a sign that no-one is upset by
> this. Otherwise, consider this a gentle reminder to file any
> objections you may have. :-)
>
> Otherwise, I've confirmed that this still applies cleanly to the
> latest linux-kselftest/kunit branch, so -- assuming there are no
> last-minute objections -- this ought to be ready to go.

Shuah, can you pick this up for 5.7?

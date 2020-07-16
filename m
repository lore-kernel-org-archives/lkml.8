Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4932070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="farj/N/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgGPQfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGPQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:35:20 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBA4C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:35:20 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m8so2981986qvk.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fNLVxbryOFz0P4iYYN4nq5tJAfgthGwNwlN4AMKfx5s=;
        b=farj/N/v+ww/83TMrMdBjmvadr5J8dJu08GDa5Tve6Cw2sMPHNaIVTcHH0ZFEV5Kwi
         NiY2D1Xt8uErC7YPv3kQC3PYDE+gwdKrJ3ApxcyQRSaOYXO/qJ+F/3mQXuS4533nh0cd
         CqcEznH6H2jGjttpN0nwhYp/vK6gjEhSQ/a9Oa41IlFPOaVxX09ev84NgIYKEqGfBQjN
         2sfhwOFwfdkryZ8q66d4MsB4adXy+0a+VLB51dDnO7M7+ZtBBOhD24vmB4rDE760G7SI
         xqALJZLkbyjkz4BesCT5g/br60aItZRF4KnT16fHXN2oNCeMyy8e2n5U2tWOPWuiytxP
         9dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fNLVxbryOFz0P4iYYN4nq5tJAfgthGwNwlN4AMKfx5s=;
        b=JwkHcf1sLkNQgyk92slpPpzu4hJRd6CueWySQ6TLNzoYdC/T+wF6FvPX5s4nE30HNR
         iuqAV31rr5TnRLVhJKI8bNm1kbwc3MnK4g9I7aUH1vj1Bgy2BdUuprxx+08xyd+t40zm
         Vw7oqfZtwrONcBVJhBrlfxYidlFTd6cqv2tHHcCgG4Eg6Eilhny/i5ZaVqAZNs5AvvcP
         DaNgbzKkNvtuxgj4x6w/JaI9Jotg5okaDE3rIl4sR6BI4PaYFMt4xhxupgICbAAtNjYN
         RikYxKQ3LKvS4XDFp/A3Uy3rx/mG0vTQ5mEm97zJrLEJZ0NkP6G3TRr23uqh2CzTBrp6
         Im+Q==
X-Gm-Message-State: AOAM5338PbJa2lFT9FOCuPJkm3apilLtTWwsbO3HuZKXoX4eJ6FogzbI
        mWH4T0KeVAhwweBLlhLMEyvdCw==
X-Google-Smtp-Source: ABdhPJwLiVWEhyy9wE5hXwCJKWEklBwb1sYkeUh8lfEwZJQowdISUQsLFJ8anNvNV9YuVvNhuv80nA==
X-Received: by 2002:a05:6214:851:: with SMTP id dg17mr5157555qvb.235.1594917319752;
        Thu, 16 Jul 2020 09:35:19 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id l5sm8264754qtd.37.2020.07.16.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:35:18 -0700 (PDT)
Message-ID: <a1221f11e7ab6926dcca8b4cabfa4ef6dfecf654.camel@massaru.org>
Subject: Re: [RFC 2/3] lib: Allows to borrow mm in userspace on KUnit
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:35:14 -0300
In-Reply-To: <CAFd5g47HPGjX4AYuBCjH8DqSUMNO+yqjudWH+ZNovStM+aXExA@mail.gmail.com>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <20200715031120.1002016-3-vitor@massaru.org>
         <CAFd5g47HPGjX4AYuBCjH8DqSUMNO+yqjudWH+ZNovStM+aXExA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 17:37 -0700, Brendan Higgins wrote:
> On Tue, Jul 14, 2020 at 8:11 PM Vitor Massaru Iha <vitor@massaru.org>
> wrote:
> 
> Probably want to add more of a description here as what you are doing
> is not entirely trivial to someone not familiar with mm contexts.
> 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  include/kunit/test.h  |  1 +
> >  lib/kunit/try-catch.c | 15 ++++++++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 59f3144f009a..49c38bdcb93e 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -222,6 +222,7 @@ struct kunit {
> >          * protect it with some type of lock.
> >          */
> >         struct list_head resources; /* Protected by lock. */
> > +       struct mm_struct *mm;
> 
> Part of me thinks we should put a better name here, part of me thinks
> it is fine because it matches the convention.
> 
> Either way, this DEFINITELY deserves a comment explaining what it is,
> why it exists, and how it should/shouldn't be used.
> 
> >  };
> > 
> >  void kunit_init_test(struct kunit *test, const char *name, char
> > *log);
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index 0dd434e40487..f677c2f2a51a 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -11,7 +11,8 @@
> >  #include <linux/completion.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kthread.h>
> > -
> > +#include <linux/sched/mm.h>
> > +#include <linux/sched/task.h>
> >  #include "try-catch-impl.h"
> > 
> >  void __noreturn kunit_try_catch_throw(struct kunit_try_catch
> > *try_catch)
> > @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
> >  static int kunit_generic_run_threadfn_adapter(void *data)
> >  {
> >         struct kunit_try_catch *try_catch = data;
> > +       struct kunit *test = try_catch->test;
> > +
> > +       if (test->mm != NULL)
> > +               kthread_use_mm(try_catch->test->mm);
> > 
> >         try_catch->try(try_catch->context);
> > +       if (try_catch->test->mm) {
> 
> Here and below: You already have a pointer to test. You should use
> it.
> 
> > +               if (test->mm != NULL)
> > +                       kthread_unuse_mm(try_catch->test->mm);
> > +               try_catch->test->mm = NULL;
> > +       }
> > 
> >         complete_and_exit(try_catch->try_completion, 0);
> >  }
> > @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch
> > *try_catch, void *context)
> >         try_catch->context = context;
> >         try_catch->try_completion = &try_completion;
> >         try_catch->try_result = 0;
> > +
> > +       test->mm = get_task_mm(current);
> > +
> >         task_struct =
> > kthread_run(kunit_generic_run_threadfn_adapter,
> >                                   try_catch,
> >                                   "kunit_try_catch_thread");
> > --
> > 2.26.2
> > 


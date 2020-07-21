Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD0C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF2206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="yJ+Z1CIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgGUVun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUVul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:50:41 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6FAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:50:41 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id g6so10705568ybo.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLMDiGczciFjSsOj3dZDq7sO5iSQNRSWpLVbsp1EiI0=;
        b=yJ+Z1CIy1mq/LzN/hH8uLcG40OzKefS7+5Bg/NswbBmn8MKxf/kKxj6mZmlP+q7mgF
         61hll9Qjw6QqpPXgOyQDtLOrFxxlSrrfANYbpCqxgwUD2MPYOPryqui0sffIk6SxmTGu
         yk+VWw8NsjDNDO9Ev5bJxPO6XM4s4ugokO6dTC52BdtaxaTqThLi0HD4NG4GXIVeqnGa
         Reojvl6PKuUxlyjqNWnkw5U6dTBCORhBFPoOuRA1NBUvGVjh1SQvV+NVxqNjGivu1tmb
         XB8kCjXh9ymKFwhfBLmAAS/Hs3ph1vncbo7yD/z+k+DHW6xTKdo3UiHIfl0IJ6H7S3wH
         /T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLMDiGczciFjSsOj3dZDq7sO5iSQNRSWpLVbsp1EiI0=;
        b=eDztFeNtHaSOosla60bxQBynpGhaEp4H7kqEjnFD5L6AK9HnqksKtvnIYKYw5br64x
         nSbAuMh2A41PcNkO7tcG7WAvTT9zFAGUoBAaqnJ0kNzCZYWzLSDcoC+JJDgH4QBaXDTy
         ns+mWWu99rzUUanjkRUJSwbKmNo9qE7tb5FxavblMuguuuf8K1w06T87l1HQzLrF4y61
         XG4jIVps5vT7JGR6ai5UyoDwFOExaNe2O7Z9gUFRTmrhnXhpuXeSG47ufWtK+mhNezG0
         NAUsz619GF3y/MN7j4bwTXT6jsjnyYLGYlakCmeAr+rA6KdrUpgJVBzkzCjfJz4JkeyI
         /Q7w==
X-Gm-Message-State: AOAM533o/hQ0pEQSSZZ0j6qUt3hGyzWDfZpW/V5wGD+d2Ov4H7zc5EAd
        uFpNP/DnKusaOnlkbstyFVXLBeQHTtKbF1wl7tcdDA==
X-Google-Smtp-Source: ABdhPJy68bX+ByEEwPuuMTF4k+NRbvWooV+CsEwnm8IuYSK8Pqsbeq/9PyEnxgdLO8OZ26n5SdppRrvdKekIiQY4vEM=
X-Received: by 2002:a25:cfd2:: with SMTP id f201mr45418368ybg.286.1595368240752;
 Tue, 21 Jul 2020 14:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174036.71072-1-vitor@massaru.org> <202007211203.6CFE2F19BE@keescook>
In-Reply-To: <202007211203.6CFE2F19BE@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Tue, 21 Jul 2020 18:50:04 -0300
Message-ID: <CADQ6JjWGqOG568TmBvM-ZxK9j4n=WWsLTBJvzCCswC-SgW59rQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: kunit: Provides a userspace memory context when
 tests are compiled as module
To:     Kees Cook <keescook@chromium.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 4:06 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 21, 2020 at 02:40:36PM -0300, Vitor Massaru Iha wrote:
> > KUnit test cases run on kthreads, and kthreads don't have an
> > adddress space (current->mm is NULL), but processes have mm.
> >
> > The purpose of this patch is to allow to borrow mm to KUnit kthread
> > after userspace is brought up, because we know that there are processes
> > running, at least the process that loaded the module to borrow mm.
> >
> > This allows, for example, tests such as user_copy_kunit, which uses
> > vm_mmap, which needs current->mm.
>
> Ah! In the case of kunit starting before there IS a userspace...
> interesting.

I didn't think that way, but I can rewrite if it looked like that.

> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> > v2:
> >     * splitted patch in 3:
> >         - Allows to install and load modules in root filesystem;
> >         - Provides an userspace memory context when tests are compiled
> >           as module;
> >         - Convert test_user_copy to KUnit test;
> >     * added documentation;
> >     * added more explanation;
> >     * added a missed test pointer;
> >     * released mm with mmput();
> > v3:
> >     * rebased with last kunit branch
> >     * Please apply this commit from kunit-fixes:
> >         3f37d14b8a3152441f36b6bc74000996679f0998
> >
> >  Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
> >  include/kunit/test.h                    | 12 ++++++++++++
> >  lib/kunit/try-catch.c                   | 15 ++++++++++++++-
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> > ---
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 3c3fe8b5fecc..9f909157be34 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -448,6 +448,20 @@ We can now use it to test ``struct eeprom_buffer``:
> >
> >  .. _kunit-on-non-uml:
> >
> > +User-space context
> > +------------------
> > +
> > +I case you need a user-space context, for now this is only possible through
>
> typo: In case ...

Oops, thanks!

>
> > +tests compiled as a module. And it will be necessary to use a root filesystem
> > +and uml_utilities.
> > +
> > +Example:
> > +
> > +.. code-block:: bash
> > +
> > +   ./tools/testing/kunit/kunit.py run --timeout=60 --uml_rootfs_dir=.uml_rootfs
> > +
> > +
> >  KUnit on non-UML architectures
> >  ==============================
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 59f3144f009a..ae3337139c65 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -222,6 +222,18 @@ struct kunit {
> >        * protect it with some type of lock.
> >        */
> >       struct list_head resources; /* Protected by lock. */
> > +     /*
> > +      * KUnit test cases run on kthreads, and kthreads don't have an
> > +      * adddress space (current->mm is NULL), but processes have mm.
> > +      *
> > +      * The purpose of this mm_struct is to allow to borrow mm to KUnit kthread
> > +      * after userspace is brought up, because we know that there are processes
> > +      * running, at least the process that loaded the module to borrow mm.
> > +      *
> > +      * This allows, for example, tests such as user_copy_kunit, which uses
> > +      * vm_mmap, which needs current->mm.
> > +      */
> > +     struct mm_struct *mm;
>
> I have a general concern that this will need more careful solving in the
> future as there are likely to be many tests that need a userspace
> context to operate sanely. But that's just a note; this solves the
> specific case now.
>
> >  };
> >
> >  void kunit_init_test(struct kunit *test, const char *name, char *log);
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index 0dd434e40487..d03e2093985b 100644
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
> >  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
> > @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
> >  static int kunit_generic_run_threadfn_adapter(void *data)
> >  {
> >       struct kunit_try_catch *try_catch = data;
> > +     struct kunit *test = try_catch->test;
> > +
> > +     if (test != NULL && test->mm != NULL)
> > +             kthread_use_mm(test->mm);
> >
> >       try_catch->try(try_catch->context);
> > +     if (test != NULL && test->mm != NULL) {
> > +             kthread_unuse_mm(test->mm);
> > +             mmput(test->mm);
> > +             test->mm = NULL;
>
> This mmput() seems unbalanced... see below.
>
> > +     }
> >
> >       complete_and_exit(try_catch->try_completion, 0);
> >  }
> > @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> >       try_catch->context = context;
> >       try_catch->try_completion = &try_completion;
> >       try_catch->try_result = 0;
> > +
> > +     test->mm = get_task_mm(current);
> > +
> >       task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
> >                                 try_catch,
> >                                 "kunit_try_catch_thread");
>
> Isn't there something that destroys a "struct kunit"? I would expect
> that to perform the mmput(). Why is it up in the threadfn?

My bad. From what I saw, there's nothing that would destroy "struct
kunit", but I will fix this umbalance.

Thanks for the review!

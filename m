Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968AAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7B4207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWhJfXIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHSVFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHSVFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:05:50 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B70C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:05:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d4so1681585pjx.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9eRVOLaul6cq01mtbbr/ED3T1zhaooeYNDSyj6PbBQ=;
        b=bWhJfXIHoYrd3Cbwkg7cRhBSQajpxTQ6y9B4X7AwebO+WOLWJmZB5uFsklsfyrcPbk
         E38o8S/CJmckAgblLWsrO/ZpA4M5275XCCP4rgvZje1Ap+6V3YRqg0XT/r+XaZaptPEi
         oQq9Erv0sQWQAsjNxM++KsGSm7VtsLsFs+OeghXEhlLjiQL0VHhJYmKgZw1DfobEJaPz
         fczscWNyP7MB7AJ5hFVAN3UgiDRMagfqEcNw/RGUSE3IS4p9DRv9SdmlLG+WbkxgkXNO
         pdL3TBJyFeS+BF2vH8azBWUlj7TxadcYNtc+j+bb1Gqzxwpq1uOZ3O3hmQDDhBS2+nTi
         P8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9eRVOLaul6cq01mtbbr/ED3T1zhaooeYNDSyj6PbBQ=;
        b=thNhX/hxsYkpZsGyYeNKOJnhj0WClxpy19abg2V1QKdm6zvtvDgOiMZ/4dBkL2diFV
         NWtun0lJLiI73x2G7c40+D6y9IF0UTsfIr/cGkGqsuCndmekrT/x5vZWtUoUs+1HXBUO
         JHExu2i/m8dJ2kZXQMR1ZAB8Xdlx3oVUi4k7BeD/83hLM9P60ZfYhAJJMWVCrdQomhRH
         EvGCPWG+e5qLytftaHFdhSn3I1rwMe/Y1Wa+r1FeUt/xwb4nUR4jgA1RV2zqWPyTnkFf
         WyxiB2Prz0WJpImzVBD9wbFdkj1mtd8C29DZ3nWwe/VMxEiQGHigbr9Cpmb47Db0klA5
         z8eA==
X-Gm-Message-State: AOAM532xyqMEPQZYh1Ix/4eaEtgnp4qC+u/hCuG0XwmWLeyaUVZTyGnv
        qhW9KTwqOZK3awVfHas3WOz/26uWCgjFGjhuLaNiZw==
X-Google-Smtp-Source: ABdhPJy4L45+jit4l+08gbBJ4kJKTqDvMaJ+/xeQR0tWB76SQei+95epNN9E9y29KndTWunNmWZYTAzrCswY+U3YmYk=
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr1602728plg.297.1597871149723;
 Wed, 19 Aug 2020 14:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200718005025.440320-1-vitor@massaru.org>
In-Reply-To: <20200718005025.440320-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:05:38 -0700
Message-ID: <CAFd5g44pr4z4X_E7sFYvYQnKQ22Lqz1a7Oy7Y_yXvJnqGQo9KQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: Provides a userspace memory context when
 tests are compiled as module
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 5:50 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> KUnit test cases run on kthreads, and kthreads don't have an
> adddress space (current->mm is NULL), but processes have mm.
>
> The purpose of this patch is to allow to borrow mm to KUnit kthread
> after userspace is brought up, because we know that there are processes
> running, at least the process that loaded the module to borrow mm.
>
> This allows, for example, tests such as user_copy_kunit, which uses
> vm_mmap, which needs current->mm.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Can you put these together in the same patch series as you had before?
When I asked you to split the patch up, I was just asking about that
specific patch within the series. I still think all the patches go
together.

As for this specific patch, I see one minor issue below; other than
that, this looks good to me, so:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
> v2:
>     * splitted patch in 3:
>         - Allows to install and load modules in root filesystem;
>         - Provides an userspace memory context when tests are compiled
>           as module;
>         - Convert test_user_copy to KUnit test;
>     * added documentation;
>     * added more explanation;
>     * tested a pointer;
>     * released mput();
> ---
>  Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
>  include/kunit/test.h                    | 12 ++++++++++++
>  lib/kunit/try-catch.c                   | 15 ++++++++++++++-
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 3c3fe8b5fecc..9f909157be34 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -448,6 +448,20 @@ We can now use it to test ``struct eeprom_buffer``:
>
>  .. _kunit-on-non-uml:
>
> +User-space context
> +------------------
> +
> +I case you need a user-space context, for now this is only possible through
> +tests compiled as a module. And it will be necessary to use a root filesystem
> +and uml_utilities.
> +
> +Example:
> +
> +.. code-block:: bash
> +
> +   ./tools/testing/kunit/kunit.py run --timeout=60 --uml_rootfs_dir=.uml_rootfs
> +
> +
>  KUnit on non-UML architectures
>  ==============================

I think the above documentation change belongs in the other related
patch where you introduce the --uml_rootfs_dir flag.

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..ae3337139c65 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -222,6 +222,18 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +       /*
> +        * KUnit test cases run on kthreads, and kthreads don't have an
> +        * adddress space (current->mm is NULL), but processes have mm.
> +        *
> +        * The purpose of this mm_struct is to allow to borrow mm to KUnit kthread
> +        * after userspace is brought up, because we know that there are processes
> +        * running, at least the process that loaded the module to borrow mm.
> +        *
> +        * This allows, for example, tests such as user_copy_kunit, which uses
> +        * vm_mmap, which needs current->mm.
> +        */
> +       struct mm_struct *mm;
>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 0dd434e40487..d03e2093985b 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,7 +11,8 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> -
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
>  #include "try-catch-impl.h"
>
>  void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
> @@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
>  static int kunit_generic_run_threadfn_adapter(void *data)
>  {
>         struct kunit_try_catch *try_catch = data;
> +       struct kunit *test = try_catch->test;
> +
> +       if (test != NULL && test->mm != NULL)
> +               kthread_use_mm(test->mm);
>
>         try_catch->try(try_catch->context);
> +       if (test != NULL && test->mm != NULL) {
> +               kthread_unuse_mm(test->mm);
> +               mmput(test->mm);
> +               test->mm = NULL;
> +       }
>
>         complete_and_exit(try_catch->try_completion, 0);
>  }
> @@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
>         try_catch->context = context;
>         try_catch->try_completion = &try_completion;
>         try_catch->try_result = 0;
> +
> +       test->mm = get_task_mm(current);
> +
>         task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
>                                   try_catch,
>                                   "kunit_try_catch_thread");
>
> base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
> prerequisite-patch-id: 5e5f9a8a05c5680fda1b04c9ab1b95ce91dc88b2
> prerequisite-patch-id: 4d997940f4a9f303424af9bac412de1af861f9d9
> prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
> --
> 2.26.2
>

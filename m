Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8752C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F5720714
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFRDIY5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGPAhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgGPAhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:37:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5FC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 17:37:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so2850728pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVodWiEHQkq0E0nBn3v+yTDqfSzN287V6yNqrTXAono=;
        b=DFRDIY5fVPO+tRVNaoPThKmwQLGgQrirP047p4B4mIhpL3deqJvaKcI6gRIHq2khNf
         F2HBJTLyaJ0AOeUJMrdPmoZXu1MX6JIUNyHpWyKuJmvM4f/vwPug1KfLEUZ9EumRKA8+
         BDV3AXymAZFVYqoNfq8/LWIfCLKe5k65NnSlI0GlLgzpaZG5zzpqmG/4uDVihsjMcOeU
         RRYscvBpSrSYR2qq/IoM2yj8IHgx7LEJk22IysJ1llJHOVowsOCwtN28MeycXUYHEswY
         ai80mqr23WL40hFdEbfuHRotDCTONfWYWb3obD3Hmh1+8qpd3YxhafkepdkyH2YmY3R0
         59FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVodWiEHQkq0E0nBn3v+yTDqfSzN287V6yNqrTXAono=;
        b=TQqDSsfV/WkL6IlewVAlrmaE29IyWi0LBCHd2mOgrY41fgBJzp2lWwZl/Uxu0zPbhg
         7T5MPBhqxTdra9rcftpY2pbATgcRqInnbS44ICjvsO5R1fDecbNGUb1UBESfcChiUZwa
         MOjh2+2Gc30o4PKCBcDYPQWqJiiY+KQdWPF+CuV0Z6gv11nejTOXagbaWHGhQBWXBqhZ
         ACKSqopaKTx9+svrGgP9EtxaijQuIVIk375OsphD9BscJ1ZmdPaR0Xa6flXgrq/OZfQX
         sVH+t/iUWpM4thobZdza3gVIFGKuTGfgO1CW6z1kfe5U4R5JEErsKI7ptggqbBh9fMLa
         zj1A==
X-Gm-Message-State: AOAM533bxcxYqyaZ3VxsnhQsr05bcri0Qu98hChk7zIg4Z/KuxNO9fQ8
        +/4H5i0qYEbZvZVDweF5hwH3ua97EPVSgKsh3DTdQCXI
X-Google-Smtp-Source: ABdhPJxGnJt4lUyRPW/VpEnwG2xIOd8fevL53BtMpqCJAdDEXJ8OmXXg7qkQPjBLGYmVPWNYLNSVgaXlhqhI5V1KDoQ=
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr1944707pgc.384.1594859837823;
 Wed, 15 Jul 2020 17:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200715031120.1002016-1-vitor@massaru.org> <20200715031120.1002016-3-vitor@massaru.org>
In-Reply-To: <20200715031120.1002016-3-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 15 Jul 2020 17:37:06 -0700
Message-ID: <CAFd5g47HPGjX4AYuBCjH8DqSUMNO+yqjudWH+ZNovStM+aXExA@mail.gmail.com>
Subject: Re: [RFC 2/3] lib: Allows to borrow mm in userspace on KUnit
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

On Tue, Jul 14, 2020 at 8:11 PM Vitor Massaru Iha <vitor@massaru.org> wrote:

Probably want to add more of a description here as what you are doing
is not entirely trivial to someone not familiar with mm contexts.

>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  include/kunit/test.h  |  1 +
>  lib/kunit/try-catch.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 59f3144f009a..49c38bdcb93e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -222,6 +222,7 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +       struct mm_struct *mm;

Part of me thinks we should put a better name here, part of me thinks
it is fine because it matches the convention.

Either way, this DEFINITELY deserves a comment explaining what it is,
why it exists, and how it should/shouldn't be used.

>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 0dd434e40487..f677c2f2a51a 100644
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
> +       if (test->mm != NULL)
> +               kthread_use_mm(try_catch->test->mm);
>
>         try_catch->try(try_catch->context);
> +       if (try_catch->test->mm) {

Here and below: You already have a pointer to test. You should use it.

> +               if (test->mm != NULL)
> +                       kthread_unuse_mm(try_catch->test->mm);
> +               try_catch->test->mm = NULL;
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
> --
> 2.26.2
>

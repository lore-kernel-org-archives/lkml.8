Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1A2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48E9222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGPu8cMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCBQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:57:04 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45765 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:57:03 -0500
Received: by mail-ua1-f68.google.com with SMTP id q17so599274uao.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Emi3zvh0GvAdchRt2bZiLjp8wJpgJ0s1FpAc2eNaRuE=;
        b=UGPu8cMVzp70w7nVbEKjZtx9UFRGJyMmvWuiso/t2ciYBcXV4NidYkYwQAEfBh4QWG
         aZpMq3EIRcnl8u2+zjl2+Jd5Vn/puw82z77b8eg+Ef8uol7aujjohP/vJUQqJTHtr8t8
         J2Cqobj7UlwAIEEZ0i7+TZWAKL9aSaTZfnM2RqogQR6Kl3eC34GfLDXAEpNrwSyaDWoN
         XhLfOL9n0HFgkugck2+qA6dntYdYc8tSvr4vw4jpypZ0iO7FTPHKDDrvJpKHCJlGidwX
         exP6xZDfsfoWf5f3gQmolw9asucK2URju54NMvJssO8d95gZKWjAAVjgY4puF2stuAE3
         CkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Emi3zvh0GvAdchRt2bZiLjp8wJpgJ0s1FpAc2eNaRuE=;
        b=ebH4yNuEl1FBZybe0KYAZUNkD+icOom/5Ze1yzZJ7p5rxs7HOpzNF4QcM9dyxSoF7x
         +pxUrfOs2gChzqWJ934gi4CahKYLyMgwxyTmTuVQgMlAkC2Uxk0olGJP6+ZdMcxTSZMV
         kf0g11woA7VV37+hUt/SLWHkewr46/s07cfRNS4GReeA4u/QTulfH/G6nHDQPxBzOPOY
         sLI8/ijc0sX2bmxqD0Qb4ME1aYfXwOhgr9RynwjN1oSAMhKsKqpgdGGdnZibfZ87ym77
         efGggBy3fTMAboGe/CMLyFNMThvZqrUSe/cXVgA34tPyQ5+nbMu1MKlTLGvbbnnQRF2z
         Hztw==
X-Gm-Message-State: ANhLgQ3SLjmL6l0dKrOj84tkXV67fMurVktY7OJaUsyZiGKTZ2aT8Smh
        99Acp40LZ1oyeDHaUPhrzaSjZqzNO+nIFWJdcViV9g==
X-Google-Smtp-Source: ADFU+vuWmdQz60uGm7dRu6x9AM6ilHJspWpQIG6duvbA7201l798XQKtBgH7CH8EdhToZchz7burnpQ0NzpfZLNjqow=
X-Received: by 2002:ab0:1161:: with SMTP id g33mr392064uac.32.1583168221423;
 Mon, 02 Mar 2020 08:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-3-glider@google.com>
In-Reply-To: <20200302130430.201037-3-glider@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 2 Mar 2020 08:56:50 -0800
Message-ID: <CAHRSSEwe=jZAEVhGw4ACBU0m-76TzZfJFv1Rzw=_UVm6HbTvAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/wait: avoid double initialization in ___wait_event()
To:     Alexander Potapenko <glider@google.com>
Cc:     keescook@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 5:04 AM <glider@google.com> wrote:
>
> With CONFIG_INIT_STACK_ALL enabled, the local __wq_entry is initialized
> twice. Because Clang is currently unable to optimize the automatic
> initialization away (init_wait_entry() is defined in another translation
> unit), remove it with the __no_initialize annotation.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Potapenko <glider@google.com>
>
> ---
>  v2:
>   - changed __do_not_initialize to __no_initialize as requested by Kees
>     Cook
> ---
>  drivers/android/binder.c | 4 ++--
>  include/linux/wait.h     | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index a59871532ff6b..66984e7c33094 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4827,7 +4827,7 @@ static int binder_ioctl_write_read(struct file *filp,
>         struct binder_proc *proc = filp->private_data;
>         unsigned int size = _IOC_SIZE(cmd);
>         void __user *ubuf = (void __user *)arg;
> -       struct binder_write_read bwr __no_initialize;
> +       struct binder_write_read bwr;

How did __no_initialize get set so that it can be removed here? Should
the addition of __no_initilize be removed earlier in the series (tip
doesn't have the __no_initialize).

>
>         if (size != sizeof(struct binder_write_read)) {
>                 ret = -EINVAL;
> @@ -5026,7 +5026,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                         goto err;
>                 break;
>         case BINDER_SET_MAX_THREADS: {
> -               int max_threads;
> +               int max_threads __no_initialize;

Is this really needed? A single integer in a rarely called ioctl()
being initialized twice doesn't warrant this optimization.

>
>                 if (copy_from_user(&max_threads, ubuf,
>                                    sizeof(max_threads))) {
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 3283c8d021377..b52a9bb2c7727 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -262,7 +262,8 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
>  #define ___wait_event(wq_head, condition, state, exclusive, ret, cmd)          \
>  ({                                                                             \
>         __label__ __out;                                                        \
> -       struct wait_queue_entry __wq_entry;                                     \
> +       /* Unconditionally initialized by init_wait_entry(). */                 \
> +       struct wait_queue_entry __wq_entry __no_initialize;                     \
>         long __ret = ret;       /* explicit shadow */                           \
>                                                                                 \
>         init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);        \
> --
> 2.25.0.265.gbab2e86ba0-goog
>

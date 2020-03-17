Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0039C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBC120714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgs0mmBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCQSfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:35:40 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40110 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:35:40 -0400
Received: by mail-il1-f194.google.com with SMTP id p12so6460588ilm.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Hm84WZCLyHsOQceLRbgNnTau/dWrz89P8V4rFeTZYo=;
        b=kgs0mmBON9uHzrIYlpWlO9EGDqt3g+tszYPLPUADzO5ceUxosowT8bIV1Ar9NJivXP
         xI49g2ZeXZOZadeLhbKUbYQNhkGmBti/8HH65jiKemyrAxQtwp59CjQYUyhmQvFF6r2r
         Z+V3MxNXpcYQ760AjnvMWYYvNkeqg53OGyTJd/6CBpFDaZ8A3NFTVUPEz1Xc64NxeS/0
         vPjYey7Nc+JSWfKI/Fq8Gq85Hsz3fONiSjFupdN0wi+9BKkY1Gu+HTHSMK5fnwg5miwn
         VBiEarvswxrjkkCMmcVmpvgfmKdFkICOr+qjy1Ycv8NON14I/oQWoj1KT1KeksMpy2Ap
         PklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Hm84WZCLyHsOQceLRbgNnTau/dWrz89P8V4rFeTZYo=;
        b=SJuGdBLDPew1qbrRNcLGTJmi7WdB5AK6mcMxMXFYUKbkn8RxIyXcq721d/1UPPk/PX
         mG5n4iD7an4MCmfBoGUMWLChfXkbXvfKbRyWvYd8vi/s6SiBBwRjYUbXD+WISQ5ZrKjf
         reZ6d/2Gvm+G5iNkRMyQxM4PDDYU/1hQCAlSRNw8nhEwhkvzRXNo0xKcCivRXBFCPYhf
         T2y6Q6swozRubJuitgy+hHtDFv+PLaYIFXz0ojBJvIeIgLjstBcMJ5gS5dfEoIEdjx6f
         B8vxwuuo6hApItcx3ZwgF6XGhdlDWWI1PYYvwDPKMEpmijyr6UObRQ8fHkH8Zi8ZGRFx
         J5Dg==
X-Gm-Message-State: ANhLgQ1gOOx+xhoJCcVE9xhg3UmL0Cdn5aC8D4KmQwtCywsMEEzydWz9
        o1CBWZMUeDLjBSF3l7oqiFzuuW+H5GO/hdZqTI02ZQ==
X-Google-Smtp-Source: ADFU+vtNR3aMrlREDO911uzRAGBSb5QNq7A/SraieLmBZvfJGT6bbBDAAmsuWPFzrOt5m2wWCYMHo70u1WJzcFUpFVg=
X-Received: by 2002:a92:3d8c:: with SMTP id k12mr184090ilf.7.1584470139307;
 Tue, 17 Mar 2020 11:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200317133614.23152-1-linux@roeck-us.net>
In-Reply-To: <20200317133614.23152-1-linux@roeck-us.net>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Tue, 17 Mar 2020 21:35:28 +0300
Message-ID: <CALYGNiMTyBWmUWiVsf9=w5bv4CVzvPinpPn3s+aUdrdRS-RGgw@mail.gmail.com>
Subject: Re: [PATCH] lib/test_lockup: Rename disable_irq to fix build error
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 4:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> mips:allmodconfig fails to build.
>
> lib/test_lockup.c:87:13: error:
>         'disable_irq' redeclared as different kind of symbol
>    87 | static bool disable_irq;
>       |             ^~~~~~~~~~~
> In file included from arch/mips/include/asm/highmem.h:24,
>                  from arch/mips/include/asm/pgtable-32.h:22,
>                  from arch/mips/include/asm/pgtable.h:14,
>                  from include/linux/mm.h:95,
>                  from lib/test_lockup.c:15:
> include/linux/interrupt.h:237:13: note:
>         previous declaration of 'disable_irq' was here
>   237 | extern void disable_irq(unsigned int irq);
>
> Rename the variable to fix the problem.

Looks good. Thank you.

>
> Fixes: 0e86238873f3 ("lib/test_lockup: test module to generate lockups")
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  lib/test_lockup.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/lib/test_lockup.c b/lib/test_lockup.c
> index b45afd3ad7cb..83683ec1f429 100644
> --- a/lib/test_lockup.c
> +++ b/lib/test_lockup.c
> @@ -84,8 +84,8 @@ static unsigned long lock_wait_threshold = ULONG_MAX;
>  module_param(lock_wait_threshold, ulong, 0400);
>  MODULE_PARM_DESC(lock_wait_threshold, "print lock wait time longer than this in nanoseconds, default off");
>
> -static bool disable_irq;
> -module_param(disable_irq, bool, 0400);
> +static bool test_disable_irq;
> +module_param_named(disable_irq, test_disable_irq, bool, 0400);
>  MODULE_PARM_DESC(disable_irq, "disable interrupts: generate hard-lockups");
>
>  static bool disable_softirq;
> @@ -179,7 +179,7 @@ static void test_lock(bool master, bool verbose)
>                         down_write(&main_task->mm->mmap_sem);
>         }
>
> -       if (disable_irq)
> +       if (test_disable_irq)
>                 local_irq_disable();
>
>         if (disable_softirq)
> @@ -252,7 +252,7 @@ static void test_unlock(bool master, bool verbose)
>         if (disable_softirq)
>                 local_bh_enable();
>
> -       if (disable_irq)
> +       if (test_disable_irq)
>                 local_irq_enable();
>
>         if (lock_mmap_sem && master) {
> @@ -479,8 +479,8 @@ static int __init test_lockup_init(void)
>         if ((wait_state != TASK_RUNNING ||
>              (call_cond_resched && !reacquire_locks) ||
>              (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
> -           (disable_irq || disable_softirq || disable_preempt || lock_rcu ||
> -            lock_spinlock_ptr || lock_rwlock_ptr)) {
> +           (test_disable_irq || disable_softirq || disable_preempt ||
> +            lock_rcu || lock_spinlock_ptr || lock_rwlock_ptr)) {
>                 pr_err("refuse to sleep in atomic context\n");
>                 return -EINVAL;
>         }
> @@ -495,7 +495,7 @@ static int __init test_lockup_init(void)
>                   cooldown_secs, cooldown_nsecs, iterations, state,
>                   all_cpus ? "all_cpus " : "",
>                   iowait ? "iowait " : "",
> -                 disable_irq ? "disable_irq " : "",
> +                 test_disable_irq ? "disable_irq " : "",
>                   disable_softirq ? "disable_softirq " : "",
>                   disable_preempt ? "disable_preempt " : "",
>                   lock_rcu ? "lock_rcu " : "",
> --
> 2.17.1
>

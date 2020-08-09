Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785C6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 20:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4085A206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhuuysqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHIUzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 16:55:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBDC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 13:55:51 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w12so6962919iom.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8RoXjKE+mO+ypPWDmlXeRlCwzQadgngKc06JsatsKg=;
        b=UhuuysqmtF/lM+KTQxKdcZZ1QeFhLPWBmOpVvZ9k/IVY63THFsxQPFaz61xViD+Urw
         mA4oW5PankZeJXGDyNrPwzu/JMGoGvzSKRHE9NugaCNam+bSwhs77pqyiEMFvc5T3xil
         21Cu/IwyTIpfgP9so88lkqjcr118JySdKfJmWgtBeykOrGCXbhew4OfGc6j6wvGgGscS
         PFYOqVpjgaZf25r/H6wm4q62urshovwTXgcPqbzNUrEq4BjZ1mNBNf8SLPbzrjwp9bL5
         InKMNHSvy6xKLhFv97heyokYoIkPP2psxThSnfdVQLOyL7PCccNDg2tb5aCh8SyzGxXd
         N49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8RoXjKE+mO+ypPWDmlXeRlCwzQadgngKc06JsatsKg=;
        b=dDnV/CXtKphjdVZtb4LvZefUdD+87n0ixwmCbZqh6sBcnJs9OffB8DdfUxTCLp9Ykb
         Ikp+c02f0R6XRQTcNxp262dow0OYIYpI5Pn99No9xj35FGfgaus1nlOc99wM95oukfVR
         9NomLhnsJ+XFrnsrMX/9CwBAHYBXpzrnNFD7gae03ymr3NWdSIjPu5HHnPg89r5EOrDb
         H6nupwR4qvvLeN5+SehcPBax56a35Y6RWfTtEBl75YdJBGpD+TIyksScZL6n2GQatPGT
         jmpHEJAZbwkICa6Ax9Hg4Vl3XnEDpB3CeuMgLsX+V+y31SysM7qeIYT3VpVkn6yY9YE0
         UDFw==
X-Gm-Message-State: AOAM533xzLgsfsHhFhODEjLZeZQnVShUVrzdvbnAdcT10pOtZdas5ey5
        FzsjMFZS5luidv55YiX5Ps17Awc1VTLyvyE4avSBBcZW+Co=
X-Google-Smtp-Source: ABdhPJzLdjR54EtwHzbQ0Jj8paSIn7+9G8LOojV1fSOGIMcnVTmkYNkfPCxLSEKAllL54jm6DW2tP6r4MIv0+vjrUlA=
X-Received: by 2002:a02:ccd7:: with SMTP id k23mr16875552jaq.73.1597006550551;
 Sun, 09 Aug 2020 13:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200809190615.25647-1-dmtrmonakhov@yandex-team.ru>
In-Reply-To: <20200809190615.25647-1-dmtrmonakhov@yandex-team.ru>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Sun, 9 Aug 2020 23:55:39 +0300
Message-ID: <CALYGNiNFc6vgSt9WNp8+VL82aRS3a2q6x0AXJnn-HzZ33t_W9A@mail.gmail.com>
Subject: Re: [PATCH] lib/test_lockup.c: add parameters for cond_resched inside loop
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 10:06 PM Dmitry Monakhov
<dmtrmonakhov@yandex-team.ru> wrote:
>
> call_cond_resched_before=Y  call cond_resched with resource before wait
> call_cond_resched_after=Y   call cond_resched with resource after wait
> measure_cond_resched=Y      measure maximum cond_resched time inside loop

Do you really need all of them? It seems "call_cond_resched_after" is
enough for demonstration.
It could be shortened to just "call_cond_resched". I see no sense in
ordering before\after sleep.

Measuring time of cond_resched has vague meaning too. This just "yep,
we have an overload".

>
> This simulate situation where process call cond_resched() with lock held.
>
> Example demonstrate priority inversion issue with epbf-program, where
> low priority task sheduled out while holding cgroup_mutex for a long
> periods of time which blocks others programs with high priority.
>
> CGROUP_MUTEX=$(gawk '$3 == "cgroup_mutex" {print "0x"$1}' /proc/kallsyms)
> # Emulate ebpf-application load which can hung inside cgroup_bpf_attach()
> nice -20 modprobe lib/test_lockup.ko \
>       time_nsecs=1000 cooldown_nsecs=100000 iterations=100000 \
>       lock_mutex_ptr=$CGROUP_MUTEX \
>       measure_lock_wait=Y call_cond_resched_after=Y &
>
> stress-ng -c $(nproc) --timeout 10s&
> time mkdir /sys/fs/cgroup/blkio/a
>
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  lib/test_lockup.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/lib/test_lockup.c b/lib/test_lockup.c
> index 0f81252..3e05d6e 100644
> --- a/lib/test_lockup.c
> +++ b/lib/test_lockup.c
> @@ -77,6 +77,18 @@ static bool call_cond_resched;
>  module_param(call_cond_resched, bool, 0600);
>  MODULE_PARM_DESC(call_cond_resched, "call cond_resched() between iterations");
>
> +static bool call_cond_resched_before;
> +module_param(call_cond_resched_before, bool, 0600);
> +MODULE_PARM_DESC(call_cond_resched_before, "call cond_resched() before wait");
> +
> +static bool call_cond_resched_after;
> +module_param(call_cond_resched_after, bool, 0600);
> +MODULE_PARM_DESC(call_cond_resched_after, "call cond_resched() after wait");
> +
> +static bool measure_cond_resched;
> +module_param(measure_cond_resched, bool, 0400);
> +MODULE_PARM_DESC(measure_cond_resched, "measure cond_resched time");
> +
>  static bool measure_lock_wait;
>  module_param(measure_lock_wait, bool, 0400);
>  MODULE_PARM_DESC(measure_lock_wait, "measure lock wait time");
> @@ -162,6 +174,7 @@ MODULE_PARM_DESC(lock_sb_umount, "lock file -> sb -> s_umount");
>  static atomic_t alloc_pages_failed = ATOMIC_INIT(0);
>
>  static atomic64_t max_lock_wait = ATOMIC64_INIT(0);
> +static atomic64_t max_cond_resched = ATOMIC64_INIT(0);
>
>  static struct task_struct *main_task;
>  static int master_cpu;
> @@ -346,6 +359,22 @@ static void test_wait(unsigned int secs, unsigned int nsecs)
>         }
>  }
>
> +static void test_cond_resched(void)
> +{
> +       s64 cur, old_max;
> +       s64 start = local_clock();
> +
> +       cond_resched();
> +
> +       cur  = local_clock() - start;
> +       old_max = atomic64_read(&max_cond_resched);
> +       do {
> +               if (cur < old_max)
> +                       break;
> +               old_max = atomic64_cmpxchg(&max_cond_resched, old_max, cur);
> +       } while (old_max != cur);
> +}
> +
>  static void test_lockup(bool master)
>  {
>         u64 lockup_start = local_clock();
> @@ -363,8 +392,14 @@ static void test_lockup(bool master)
>                 if (iowait)
>                         current->in_iowait = 1;
>
> +               if (call_cond_resched_before)
> +                       test_cond_resched();
> +
>                 test_wait(time_secs, time_nsecs);
>
> +               if (call_cond_resched_after)
> +                       test_cond_resched();
> +
>                 if (iowait)
>                         current->in_iowait = 0;
>
> @@ -497,6 +532,7 @@ static int __init test_lockup_init(void)
>
>         if ((wait_state != TASK_RUNNING ||
>              (call_cond_resched && !reacquire_locks) ||
> +            call_cond_resched_before || call_cond_resched_after ||
>              (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
>             (test_disable_irq || disable_softirq || disable_preempt ||
>              lock_rcu || lock_spinlock_ptr || lock_rwlock_ptr)) {
> @@ -532,7 +568,7 @@ static int __init test_lockup_init(void)
>         if (test_lock_sb_umount && test_inode)
>                 lock_rwsem_ptr = (unsigned long)&test_inode->i_sb->s_umount;
>
> -       pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
> +       pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s%s%s\n",
>                   main_task->pid, time_secs, time_nsecs,
>                   cooldown_secs, cooldown_nsecs, iterations, state,
>                   all_cpus ? "all_cpus " : "",
> @@ -545,6 +581,8 @@ static int __init test_lockup_init(void)
>                   touch_softlockup ? "touch_softlockup " : "",
>                   touch_hardlockup ? "touch_hardlockup " : "",
>                   call_cond_resched ? "call_cond_resched " : "",
> +                 call_cond_resched_before ? "call_cond_resched_before " : "",
> +                 call_cond_resched_after ? "call_cond_resched_after " : "",
>                   reacquire_locks ? "reacquire_locks " : "");
>
>         if (alloc_pages_nr)
> @@ -578,6 +616,10 @@ static int __init test_lockup_init(void)
>                 pr_notice("Maximum lock wait: %lld ns\n",
>                           atomic64_read(&max_lock_wait));
>
> +       if (measure_cond_resched)
> +               pr_notice("Maximum cond resched time: %lld ns\n",
> +                         atomic64_read(&max_cond_resched));
> +
>         if (alloc_pages_nr)
>                 pr_notice("Page allocation failed %u times\n",
>                           atomic_read(&alloc_pages_failed));
> --
> 2.7.4
>

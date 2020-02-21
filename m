Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5029FC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAAD20658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582249286;
	bh=PY4zNr6G2aqLZFfhO1UHAytauwW5F7oLZsMV1OjkxbY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=nTZ5I06UI4aAcw8saW5MCIJ6FJUz5yZE5NySBgFRx9OMAC7gdacCdfGd0BWHovqd2
	 aYdqop8aXsIXqXZEqo/QB7bZNrnzS/MEG6lvtdHGtwjqEq2T/zh9zSs/fm1svZOBaQ
	 0uILWY7UvD1q+lv8s4ZU48KFbdR3u8/vkG6lV+ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgBUBlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:41:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgBUBlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:41:24 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3FC20722;
        Fri, 21 Feb 2020 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582249284;
        bh=PY4zNr6G2aqLZFfhO1UHAytauwW5F7oLZsMV1OjkxbY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bG60k057Wlv1YRIonfm55EVO2n+tJJ+sWyJOJ+/TeUU45NYc4CD3mEEEL4WM49tJ1
         0Hrar8loydobnXPCfgUtUs+4XibHHASkTcmrQBHin7vNh91uNhZg03Q/wMUPohJ78I
         Q3K32E3bX6lV34KX6XhUQQB2XMoF++BZgZaVMvKg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582170152-69418-1-git-send-email-yangyingliang@huawei.com>
References: <1582170152-69418-1-git-send-email-yangyingliang@huawei.com>
Subject: Re: [PATCH] timer_list: avoid other cpu soft lockup when printing timer list
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     tglx@linutronix.de, john.stultz@linaro.org
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Feb 2020 17:41:23 -0800
Message-ID: <158224928306.184098.11550548610262156729@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Yingliang (2020-02-19 19:42:32)
> If system has many cpus (e.g. 128), it will spend a lot of time to
> print message to the console when execute echo q > /proc/sysrq-trigger.
>=20
> When /proc/sys/kernel/numa_balancing is enabled, if the migration threads
> are woke up, the migration thread that on print mesasage cpu can't run
> until the print finish, another migration thread may trigger soft lockup.
>=20
> PID: 619    TASK: ffffa02fdd8bec80  CPU: 121  COMMAND: "migration/121"
>   #0 [ffff00000a103b10] __crash_kexec at ffff0000081bf200
>   #1 [ffff00000a103ca0] panic at ffff0000080ec93c
>   #2 [ffff00000a103d80] watchdog_timer_fn at ffff0000081f8a14
>   #3 [ffff00000a103e00] __run_hrtimer at ffff00000819701c
>   #4 [ffff00000a103e40] __hrtimer_run_queues at ffff000008197420
>   #5 [ffff00000a103ea0] hrtimer_interrupt at ffff00000819831c
>   #6 [ffff00000a103f10] arch_timer_dying_cpu at ffff000008b53144
>   #7 [ffff00000a103f30] handle_percpu_devid_irq at ffff000008174e34
>   #8 [ffff00000a103f70] generic_handle_irq at ffff00000816c5e8
>   #9 [ffff00000a103f90] __handle_domain_irq at ffff00000816d1f4
>  #10 [ffff00000a103fd0] gic_handle_irq at ffff000008081860
>  --- <IRQ stack> ---
>  #11 [ffff00000d6e3d50] el1_irq at ffff0000080834c8
>  #12 [ffff00000d6e3d60] multi_cpu_stop at ffff0000081d9964
>  #13 [ffff00000d6e3db0] cpu_stopper_thread at ffff0000081d9cfc
>  #14 [ffff00000d6e3e10] smpboot_thread_fn at ffff00000811e0a8
>  #15 [ffff00000d6e3e70] kthread at ffff000008118988
>=20
> To avoid this soft lockup, add touch_all_softlockup_watchdogs()
> in sysrq_timer_list_show()
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/time/timer_list.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index acb326f..4cb0e6f 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -289,13 +289,17 @@ void sysrq_timer_list_show(void)
> =20
>         timer_list_header(NULL, now);
> =20
> -       for_each_online_cpu(cpu)
> +       for_each_online_cpu(cpu) {
> +               touch_all_softlockup_watchdogs();

Usage of touch_all_softlockup_watchdogs() deserves a comment. Otherwise
the reader is left to git archaeology to understand why watchdogs are
being touched. Of course, we failed at that with commit 010704276865
("sysrq: Reset the watchdog timers while displaying high-resolution
timers") which looks awfully similar to this.

>                 print_cpu(NULL, cpu, now);
> +       }
> =20
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>         timer_list_show_tickdevices_header(NULL);
> -       for_each_online_cpu(cpu)
> +       for_each_online_cpu(cpu) {
> +               touch_all_softlockup_watchdogs();
>                 print_tickdevice(NULL, tick_get_device(cpu), cpu);

print_tickdevice() already has touch_nmi_watchdog() which eventually
touches the softlockup watchdog. Is the problem that it isn't enough to
do that when the migration thread is also running?

> +       }
>  #endif
>         return;

Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394EFC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15539206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgD0JnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbgD0JnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:43:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3322C0610D5;
        Mon, 27 Apr 2020 02:43:19 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT0IF-0007ll-Iz; Mon, 27 Apr 2020 11:43:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EAECA100606; Mon, 27 Apr 2020 11:43:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 1/6] posix-cpu-timers: Always call __get_task_for_clock holding rcu_read_lock
In-Reply-To: <87h7x6mj6h.fsf_-_@x220.int.ebiederm.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com> <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org> <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org> <87h7x6mj6h.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 27 Apr 2020 11:43:14 +0200
Message-ID: <87368ps1ql.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> This allows the getref flag to be removed and the callers can
> than take a task reference if needed.

That changelog lacks any form of information why this should be
changed. I can see the point vs. patch 2, but pretty please put coherent
explanations into each patch.

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/time/posix-cpu-timers.c | 41 +++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 2fd3b3fa68bf..eba41c70f0f0 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -86,36 +86,34 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
>  }
>  
>  static struct task_struct *__get_task_for_clock(const clockid_t clock,
> -						bool getref, bool gettime)
> +						bool gettime)
>  {
>  	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
>  	const pid_t pid = CPUCLOCK_PID(clock);
> -	struct task_struct *p;
>  
>  	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
>  		return NULL;
>  
> -	rcu_read_lock();
> -	p = lookup_task(pid, thread, gettime);
> -	if (p && getref)
> -		get_task_struct(p);
> -	rcu_read_unlock();
> -	return p;
> +	return lookup_task(pid, thread, gettime);
>  }
>  
>  static inline struct task_struct *get_task_for_clock(const clockid_t clock)
>  {
> -	return __get_task_for_clock(clock, true, false);
> +	return __get_task_for_clock(clock, false);
>  }
>  
>  static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
>  {
> -	return __get_task_for_clock(clock, true, true);
> +	return __get_task_for_clock(clock, true);
>  }
>  
>  static inline int validate_clock_permissions(const clockid_t clock)
>  {
> -	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
> +	int ret;

New line between declarations and code please.

> +	rcu_read_lock();
> +	ret = __get_task_for_clock(clock, false) ? 0 : -EINVAL;
> +	rcu_read_unlock();
> +	return ret;
>  }

Thanks,

        tglx

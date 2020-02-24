Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A33C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C35222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXVWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:22:38 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46662 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBXVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:22:37 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LBT-0007lJ-1K; Mon, 24 Feb 2020 14:22:35 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6LBR-0002HL-BN; Mon, 24 Feb 2020 14:22:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Feng Tang <feng.tang@intel.com>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang\, Ying" <ying.huang@intel.com>
References: <20200205123216.GO12867@shao2-debian>
        <20200205125804.GM14879@hirez.programming.kicks-ass.net>
        <20200221080325.GA67807@shbuild999.sh.intel.com>
        <20200221132048.GE652992@krava>
        <20200223141147.GA53531@shbuild999.sh.intel.com>
        <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
        <20200224003301.GA5061@shbuild999.sh.intel.com>
        <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
        <20200224021915.GC5061@shbuild999.sh.intel.com>
        <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
        <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
        <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
Date:   Mon, 24 Feb 2020 15:20:26 -0600
In-Reply-To: <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 24 Feb 2020 12:47:14 -0800")
Message-ID: <87a757znqd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6LBR-0002HL-BN;;;mid=<87a757znqd.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SSyf6yZIP/k5uVMtCOs9svimc0568GaY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops -5.5% regression
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> [ Adding a few more people that tend to be involved in signal
> handling. Just in case - even if they probably don't care ]
>
> On Mon, Feb 24, 2020 at 12:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> TOTALLY UNTESTED patch attached. It may be completely buggy garbage,
>> but it _looks_ trivial enough.
>
> I've tested it, and the profiles on the silly microbenchmark look much
> nicer. Now it's just the sigpending update shows up, the refcount case
> clearly still occasionally happens, but it's now in the noise.
>
> I made slight changes to the __sigqueue_alloc() case to generate
> better code: since we now use that atomic_inc_return() anyway, we
> might as well then use the value that is returned for the
> RLIMIT_SIGPENDING check too, instead of reading it again.
>
> That might avoid another potential cacheline bounce, plus the
> generated code just looks better.
>
> Updated (and now slightly tested!) patch attached.
>
> It would be interesting if this is noticeable on your benchmark
> numbers. I didn't actually _time_ anything, I just looked at profiles.
>
> But my setup clearly isn't going to see the horrible contention case
> anyway, so my timing numbers wouldn't be all that interesting.
>
>              Linus

I keep looking at your patch and wondering if there isn't a way
to remove the uid refcount entirely on this path.

Linus I might be wrong but I have this sense that your change will only
help when signal delivery is backed up.  I expect in the common case
there won't be any pending signals outstanding for the user.

Not that I see anything bad jumping out at me from your patch.

Eric



>  kernel/signal.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9ad8dea93dbb..5b2396350dd1 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -413,27 +413,32 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
>  {
>  	struct sigqueue *q = NULL;
>  	struct user_struct *user;
> +	int sigpending;
>  
>  	/*
>  	 * Protect access to @t credentials. This can go away when all
>  	 * callers hold rcu read lock.
> +	 *
> +	 * NOTE! A pending signal will hold on to the user refcount,
> +	 * and we get/put the refcount only when the sigpending count
> +	 * changes from/to zero.
>  	 */
>  	rcu_read_lock();
> -	user = get_uid(__task_cred(t)->user);
> -	atomic_inc(&user->sigpending);
> +	user = __task_cred(t)->user;
> +	sigpending = atomic_inc_return(&user->sigpending);
> +	if (sigpending == 1)
> +		get_uid(user);
>  	rcu_read_unlock();
>  
> -	if (override_rlimit ||
> -	    atomic_read(&user->sigpending) <=
> -			task_rlimit(t, RLIMIT_SIGPENDING)) {
> +	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
>  		q = kmem_cache_alloc(sigqueue_cachep, flags);
>  	} else {
>  		print_dropped_signal(sig);
>  	}
>  
>  	if (unlikely(q == NULL)) {
> -		atomic_dec(&user->sigpending);
> -		free_uid(user);
> +		if (atomic_dec_and_test(&user->sigpending))
> +			free_uid(user);
>  	} else {
>  		INIT_LIST_HEAD(&q->list);
>  		q->flags = 0;
> @@ -447,8 +452,8 @@ static void __sigqueue_free(struct sigqueue *q)
>  {
>  	if (q->flags & SIGQUEUE_PREALLOC)
>  		return;
> -	atomic_dec(&q->user->sigpending);
> -	free_uid(q->user);
> +	if (atomic_dec_and_test(&q->user->sigpending))
> +		free_uid(q->user);
>  	kmem_cache_free(sigqueue_cachep, q);
>  }
>  

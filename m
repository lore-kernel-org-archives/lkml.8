Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC3C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253D922464
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgBYC5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:57:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:39452 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgBYC5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:57:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 18:57:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,482,1574150400"; 
   d="scan'208";a="230023010"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2020 18:57:48 -0800
Date:   Tue, 25 Feb 2020 10:57:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200225025748.GB63065@shbuild999.sh.intel.com>
References: <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com>
 <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com>
 <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com>
 <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
 <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
 <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:47:14PM -0800, Linus Torvalds wrote:
> [ Adding a few more people that tend to be involved in signal
> handling. Just in case - even if they probably don't care ]
> 
> On Mon, Feb 24, 2020 at 12:09 PM Linus Torvalds
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
> It would be interesting if this is noticeable on your benchmark
> numbers. I didn't actually _time_ anything, I just looked at profiles.
> 
> But my setup clearly isn't going to see the horrible contention case
> anyway, so my timing numbers wouldn't be all that interesting.

Thanks for the optimization patch for signal!

It makes a big difference, that the performance score is tripled!
bump from original 17000 to 54000. Also the gap between 5.0-rc6 and
5.0-rc6+Jiri's patch is reduced to around 2%.

The test I run is inserting your patch right before 5.0-rc6, then
run the test for 5.0-rc6 and 5.0-rc6+Jiri's patch. Sorry it took
quite some time, as the test platform is not local but inside
0day's framework, which takes some time for scheduling, kbuilding
and testing.

Thanks,
Feng

 
>              Linus

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


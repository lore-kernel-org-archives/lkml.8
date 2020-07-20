Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9587C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C81F22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="IGIpniGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgGTOtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:49:24 -0400
Received: from mail6.tencent.com ([220.249.245.26]:41313 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgGTOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:49:24 -0400
X-Greylist: delayed 871 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 10:49:19 EDT
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
        by mail6.tencent.com (Postfix) with ESMTP id 14AE7CC36A;
        Mon, 20 Jul 2020 22:35:52 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595255752;
        bh=28Hzqp0zBl/L0kyUJ2oJsek9vrVGCYcz3VH2Qqe77zo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=IGIpniGNRHccIGCHjsS4AM9IO2k8jxxdFq46LPgNBZUeCM8imV8/3F9wltMhn6MDq
         UnlxtYdyW7H/HPqcSt//Rc2Y88ttJIbtTj0DAFdO+TX0idAoOJrkHlma265A5tQiVc
         +VQ1/2gXO0+aTi7Bo5XebihDFIXKSSYw8kz55UtY=
Received: from EX-SZ001.tencent.com (10.28.6.13) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 20 Jul
 2020 22:34:44 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ001.tencent.com
 (10.28.6.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 20 Jul
 2020 22:34:43 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Mon, 20 Jul 2020 22:34:43 +0800
From:   =?iso-2022-jp?B?YmVuYmppYW5nKBskQj5VSTcbKEIp?= 
        <benbjiang@tencent.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
CC:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 10/16] sched: Trivial forced-newidle balancer(Internet
 mail)
Thread-Topic: [RFC PATCH 10/16] sched: Trivial forced-newidle
 balancer(Internet mail)
Thread-Index: AQHWTyYpnBjYC7x930alFUJ4JyvKnakQIWiA
Date:   Mon, 20 Jul 2020 14:34:43 +0000
Message-ID: <603813E7-7096-455F-894F-9356456C2E33@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <980b600006945a45ce1ec34ef206fc04bcf0b5dc.1593530334.git.vpillai@digitalocean.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.123]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <DF6AE0286BEF8F4C9631576F7E152FC7@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.=
com> wrote:
>=20
> From: Peter Zijlstra <peterz@infradead.org>
>=20
> When a sibling is forced-idle to match the core-cookie; search for
> matching tasks to fill the core.
>=20
> rcu_read_unlock() can incur an infrequent deadlock in
> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> ---
> include/linux/sched.h |   1 +
> kernel/sched/core.c   | 131 +++++++++++++++++++++++++++++++++++++++++-
> kernel/sched/idle.c   |   1 +
> kernel/sched/sched.h  |   6 ++
> 4 files changed, 138 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 3c8dcc5ff039..4f9edf013df3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -688,6 +688,7 @@ struct task_struct {
> #ifdef CONFIG_SCHED_CORE
> 	struct rb_node			core_node;
> 	unsigned long			core_cookie;
> +	unsigned int			core_occupation;
> #endif
>=20
> #ifdef CONFIG_CGROUP_SCHED
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4d6d6a678013..fb9edb09ead7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -201,6 +201,21 @@ static struct task_struct *sched_core_find(struct rq=
 *rq, unsigned long cookie)
> 	return match;
> }
>=20
> +static struct task_struct *sched_core_next(struct task_struct *p, unsign=
ed long cookie)
> +{
> +	struct rb_node *node =3D &p->core_node;
> +
> +	node =3D rb_next(node);
> +	if (!node)
> +		return NULL;
> +
> +	p =3D container_of(node, struct task_struct, core_node);
> +	if (p->core_cookie !=3D cookie)
> +		return NULL;
> +
> +	return p;
> +}
> +
> /*
>  * The static-key + stop-machine variable are needed such that:
>  *
> @@ -4233,7 +4248,7 @@ pick_next_task(struct rq *rq, struct task_struct *p=
rev, struct rq_flags *rf)
> 	struct task_struct *next, *max =3D NULL;
> 	const struct sched_class *class;
> 	const struct cpumask *smt_mask;
> -	int i, j, cpu;
> +	int i, j, cpu, occ =3D 0;
> 	bool need_sync;
>=20
> 	if (!sched_core_enabled(rq))
> @@ -4332,6 +4347,9 @@ pick_next_task(struct rq *rq, struct task_struct *p=
rev, struct rq_flags *rf)
> 				goto done;
> 			}
>=20
> +			if (!is_idle_task(p))
> +				occ++;
> +
> 			rq_i->core_pick =3D p;
>=20
> 			/*
> @@ -4357,6 +4375,7 @@ pick_next_task(struct rq *rq, struct task_struct *p=
rev, struct rq_flags *rf)
>=20
> 						cpu_rq(j)->core_pick =3D NULL;
> 					}
> +					occ =3D 1;
> 					goto again;
> 				} else {
> 					/*
> @@ -4393,6 +4412,8 @@ next_class:;
> 		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> 			rq_i->core_forceidle =3D true;
>=20
> +		rq_i->core_pick->core_occupation =3D occ;
> +
> 		if (i =3D=3D cpu)
> 			continue;
>=20
> @@ -4408,6 +4429,114 @@ next_class:;
> 	return next;
> }
>=20
> +static bool try_steal_cookie(int this, int that)
> +{
> +	struct rq *dst =3D cpu_rq(this), *src =3D cpu_rq(that);
> +	struct task_struct *p;
> +	unsigned long cookie;
> +	bool success =3D false;
> +
> +	local_irq_disable();
> +	double_rq_lock(dst, src);
> +
> +	cookie =3D dst->core->core_cookie;
> +	if (!cookie)
> +		goto unlock;
> +
> +	if (dst->curr !=3D dst->idle)
> +		goto unlock;
> +
Could it be ok to add another fast return here?
	if  (src->nr_running =3D=3D 1)
		goto unlock;
When src cpu has only 1 running task, no need to pull and no need to do sch=
ed_core_find.

Thx.
Regards,
Jiang

> +	p =3D sched_core_find(src, cookie);
> +	if (p =3D=3D src->idle)
> +		goto unlock;
> +
> +	do {
> +		if (p =3D=3D src->core_pick || p =3D=3D src->curr)
> +			goto next;
> +
> +		if (!cpumask_test_cpu(this, &p->cpus_mask))
> +			goto next;
> +
> +		if (p->core_occupation > dst->idle->core_occupation)
> +			goto next;
> +
> +		p->on_rq =3D TASK_ON_RQ_MIGRATING;
> +		deactivate_task(src, p, 0);
> +		set_task_cpu(p, this);
> +		activate_task(dst, p, 0);
> +		p->on_rq =3D TASK_ON_RQ_QUEUED;
> +
> +		resched_curr(dst);
> +
> +		success =3D true;
> +		break;
> +
> +next:
> +		p =3D sched_core_next(p, cookie);
> +	} while (p);
> +
> +unlock:
> +	double_rq_unlock(dst, src);
> +	local_irq_enable();
> +
> +	return success;
> +}
> +
> +static bool steal_cookie_task(int cpu, struct sched_domain *sd)
> +{
> +	int i;
> +
> +	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
> +		if (i =3D=3D cpu)
> +			continue;
> +
> +		if (need_resched())
> +			break;
> +
> +		if (try_steal_cookie(cpu, i))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void sched_core_balance(struct rq *rq)
> +{
> +	struct sched_domain *sd;
> +	int cpu =3D cpu_of(rq);
> +
> +	rcu_read_lock_sched();
> +	raw_spin_unlock_irq(rq_lockp(rq));
> +	for_each_domain(cpu, sd) {
> +		if (!(sd->flags & SD_LOAD_BALANCE))
> +			break;
> +
> +		if (need_resched())
> +			break;
> +
> +		if (steal_cookie_task(cpu, sd))
> +			break;
> +	}
> +	raw_spin_lock_irq(rq_lockp(rq));
> +	rcu_read_unlock_sched();
> +}
> +
> +static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> +
> +void queue_core_balance(struct rq *rq)
> +{
> +	if (!sched_core_enabled(rq))
> +		return;
> +
> +	if (!rq->core->core_cookie)
> +		return;
> +
> +	if (!rq->nr_running) /* not forced idle */
> +		return;
> +
> +	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_=
core_balance);
> +}
> +
> #else /* !CONFIG_SCHED_CORE */
>=20
> static struct task_struct *
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index a8d40ffab097..dff6ba220ed7 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -395,6 +395,7 @@ static void set_next_task_idle(struct rq *rq, struct =
task_struct *next, bool fir
> {
> 	update_idle_core(rq);
> 	schedstat_inc(rq->sched_goidle);
> +	queue_core_balance(rq);
> }
>=20
> #ifdef CONFIG_SMP
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 293aa1ae0308..464559676fd2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1089,6 +1089,8 @@ static inline raw_spinlock_t *rq_lockp(struct rq *r=
q)
> bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
> void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
>=20
> +extern void queue_core_balance(struct rq *rq);
> +
> #else /* !CONFIG_SCHED_CORE */
>=20
> static inline bool sched_core_enabled(struct rq *rq)
> @@ -1101,6 +1103,10 @@ static inline raw_spinlock_t *rq_lockp(struct rq *=
rq)
> 	return &rq->__lock;
> }
>=20
> +static inline void queue_core_balance(struct rq *rq)
> +{
> +}
> +
> #endif /* CONFIG_SCHED_CORE */
>=20
> #ifdef CONFIG_SCHED_SMT
> --=20
> 2.17.1
>=20
>=20


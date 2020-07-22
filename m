Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F1D20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="FgTOCOmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgGVAXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:23:48 -0400
Received: from mail6.tencent.com ([220.249.245.26]:40768 "EHLO
        mail6.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGVAXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:23:48 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail6.tencent.com (Postfix) with ESMTP id F1213CC27C;
        Wed, 22 Jul 2020 08:24:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595377494;
        bh=zGpOvXintxRrcxirEJtmvaD4xUuLoamTnkCPpcbzXno=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=FgTOCOmMse1L1rA2RYth6MDW6l/o18gcyBVDHzK7xFtgAFf8Lpjwfr2bjfeYH8+Sp
         koZIqVRGmH1U/P3CwckG7LdNlkbHg9iUJVw+dbdJZBxUvFeMUERc6+ku2UVQFeeog+
         YjRF3Q6cqPre9RwYu4/wQfrtFtE9+4DmXuB4f5vo=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 08:23:45 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 08:23:45 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 22 Jul 2020 08:23:45 +0800
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
        Aaron Lu <aaron.lwe@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: Re: [RFC PATCH 09/16] sched/fair: core wide cfs task priority
 comparison(Internet mail)
Thread-Topic: [RFC PATCH 09/16] sched/fair: core wide cfs task priority
 comparison(Internet mail)
Thread-Index: AQHWTyYpR5h3B5ayLkqXVxL86Q2nQqkSWE2A
Date:   Wed, 22 Jul 2020 00:23:44 +0000
Message-ID: <4229D3E1-8792-4B43-9AC4-F648D49CCC99@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <2d0e3da8c80c314048d598fb03ae3fe52d9619f3.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <2d0e3da8c80c314048d598fb03ae3fe52d9619f3.1593530334.git.vpillai@digitalocean.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.59]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <410D634F4467CD479F6F893822DE97C7@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.=
com> wrote:
>=20
> From: Aaron Lu <aaron.lwe@gmail.com>
>=20
> This patch provides a vruntime based way to compare two cfs task's
> priority, be it on the same cpu or different threads of the same core.
>=20
> When the two tasks are on the same CPU, we just need to find a common
> cfs_rq both sched_entities are on and then do the comparison.
>=20
> When the two tasks are on differen threads of the same core, each thread
> will choose the next task to run the usual way and then the root level
> sched entities which the two tasks belong to will be used to decide
> which task runs next core wide.
>=20
> An illustration for the cross CPU case:
>=20
>   cpu0         cpu1
> /   |  \     /   |  \
> se1 se2 se3  se4 se5 se6
>    /  \            /   \
>  se21 se22       se61  se62
>  (A)                    /
>                       se621
>                        (B)
>=20
> Assume CPU0 and CPU1 are smt siblings and cpu0 has decided task A to
> run next and cpu1 has decided task B to run next. To compare priority
> of task A and B, we compare priority of se2 and se6. Whose vruntime is
> smaller, who wins.
>=20
> To make this work, the root level sched entities' vruntime of the two
> threads must be directly comparable. So one of the hyperthread's root
> cfs_rq's min_vruntime is chosen as the core wide one and all root level
> sched entities' vruntime is normalized against it.
>=20
> All sub cfs_rqs and sched entities are not interesting in cross cpu
> priority comparison as they will only participate in the usual cpu local
> schedule decision so no need to normalize their vruntimes.
>=20
> Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
> ---
> kernel/sched/core.c  |  23 +++----
> kernel/sched/fair.c  | 142 ++++++++++++++++++++++++++++++++++++++++++-
> kernel/sched/sched.h |   3 +
> 3 files changed, 150 insertions(+), 18 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f51e5c4798c8..4d6d6a678013 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -114,19 +114,8 @@ static inline bool prio_less(struct task_struct *a, =
struct task_struct *b)
> 	if (pa =3D=3D -1) /* dl_prio() doesn't work because of stop_class above =
*/
> 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
>=20
> -	if (pa =3D=3D MAX_RT_PRIO + MAX_NICE)  { /* fair */
> -		u64 vruntime =3D b->se.vruntime;
> -
> -		/*
> -		 * Normalize the vruntime if tasks are in different cpus.
> -		 */
> -		if (task_cpu(a) !=3D task_cpu(b)) {
> -			vruntime -=3D task_cfs_rq(b)->min_vruntime;
> -			vruntime +=3D task_cfs_rq(a)->min_vruntime;
> -		}
> -
> -		return !((s64)(a->se.vruntime - vruntime) <=3D 0);
> -	}
> +	if (pa =3D=3D MAX_RT_PRIO + MAX_NICE) /* fair */
> +		return cfs_prio_less(a, b);
>=20
> 	return false;
> }
> @@ -229,8 +218,12 @@ static int __sched_core_stopper(void *data)
> 	bool enabled =3D !!(unsigned long)data;
> 	int cpu;
>=20
> -	for_each_possible_cpu(cpu)
> -		cpu_rq(cpu)->core_enabled =3D enabled;
> +	for_each_possible_cpu(cpu) {
> +		struct rq *rq =3D cpu_rq(cpu);
> +		rq->core_enabled =3D enabled;
> +		if (cpu_online(cpu) && rq->core !=3D rq)
> +			sched_core_adjust_sibling_vruntime(cpu, enabled);
> +	}
>=20
> 	return 0;
> }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 61d19e573443..d16939766361 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -462,11 +462,142 @@ find_matching_se(struct sched_entity **se, struct =
sched_entity **pse)
>=20
> #endif	/* CONFIG_FAIR_GROUP_SCHED */
>=20
> +#ifdef CONFIG_SCHED_CORE
> +static inline struct cfs_rq *root_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +	return &rq_of(cfs_rq)->cfs;
> +}
> +
> +static inline bool is_root_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +	return cfs_rq =3D=3D root_cfs_rq(cfs_rq);
> +}
> +
> +static inline struct cfs_rq *core_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +	return &rq_of(cfs_rq)->core->cfs;
> +}
> +
> +static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
> +{
> +	if (!sched_core_enabled(rq_of(cfs_rq)) || !is_root_cfs_rq(cfs_rq))
> +		return cfs_rq->min_vruntime;
> +
> +	return core_cfs_rq(cfs_rq)->min_vruntime;
> +}
> +
> +#ifndef CONFIG_64BIT
> +static inline u64 cfs_rq_min_vruntime_copy(struct cfs_rq *cfs_rq)
> +{
> +	if (!sched_core_enabled(rq_of(cfs_rq)) || !is_root_cfs_rq(cfs_rq))
> +		return cfs_rq->min_vruntime_copy;
> +
> +	return core_cfs_rq(cfs_rq)->min_vruntime_copy;
> +}
> +#endif /* CONFIG_64BIT */
> +
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	struct sched_entity *sea =3D &a->se;
> +	struct sched_entity *seb =3D &b->se;
> +	bool samecpu =3D task_cpu(a) =3D=3D task_cpu(b);
> +	s64 delta;
> +
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +	if (samecpu) {
> +		/* vruntime is per cfs_rq */
> +		while (!is_same_group(sea, seb)) {
> +			int sea_depth =3D sea->depth;
> +			int seb_depth =3D seb->depth;
> +
> +			if (sea_depth >=3D seb_depth)
> +				sea =3D parent_entity(sea);
> +			if (sea_depth <=3D seb_depth)
> +				seb =3D parent_entity(seb);
> +		}
> +
> +		delta =3D (s64)(sea->vruntime - seb->vruntime);
> +		goto out;
> +	}
> +
> +	/* crosscpu: compare root level se's vruntime to decide priority */
> +	while (sea->parent)
> +		sea =3D sea->parent;
> +	while (seb->parent)
> +		seb =3D seb->parent;
> +#else
> +	/*
> +	 * Use the min_vruntime of root cfs_rq if the tasks are
> +	 * enqueued in different cpus.
> +	 * */
> +	if (!samecpu) {
> +		delta =3D (s64)(task_rq(a)->cfs.min_vruntime -
> +			      task_rq(b)->cfs.min_vruntime);
> +		goto out;
> +	}
> +#endif /* CONFIG_FAIR_GROUP_SCHED */
> +
> +	delta =3D (s64)(sea->vruntime - seb->vruntime);
> +
> +out:
> +	return delta > 0;
> +}
> +
> +/*
> + * This function takes care of adjusting the min_vruntime of siblings of
> + * a core during coresched enable/disable.
> + * This is called in stop machine context so no need to take the rq lock=
.
Hi,

IMHO, it seems that stop machine context cannot guarantee race free. The pa=
ram *cpu* maybe not *this_cpu*, rq lock should be taken even in stop machin=
e context, and irq should be disabled too, to avoid potential races with ot=
her contexts.

Thx.
Regards,
Jiang

> + *
> + * Coresched enable case
> + *  Once Core scheduling is enabled, the root level sched entities
> + *  of both siblings will use cfs_rq->min_vruntime as the common cfs_rq
> + *  min_vruntime, so it's necessary to normalize vruntime of existing ro=
ot
> + *  level sched entities in sibling_cfs_rq.
> + *
> + *  Update of sibling_cfs_rq's min_vruntime isn't necessary as we will b=
e
> + *  only using cfs_rq->min_vruntime during the entire run of core schedu=
ling.
> + *
> + * Coresched disable case
> + *  During the entire run of core scheduling, sibling_cfs_rq's min_vrunt=
ime
> + *  is left unused and could lag far behind its still queued sched entit=
ies.
> + *  Sync it to the up2date core wide one to avoid problems.
> + */
> +void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled)
> +{
> +	struct cfs_rq *cfs =3D &cpu_rq(cpu)->cfs;
> +	struct cfs_rq *core_cfs =3D &cpu_rq(cpu)->core->cfs;
> +	if (coresched_enabled) {
> +		struct sched_entity *se, *next;
> +		s64 delta =3D core_cfs->min_vruntime - cfs->min_vruntime;
> +		rbtree_postorder_for_each_entry_safe(se, next,
> +				&cfs->tasks_timeline.rb_root,
> +				run_node) {
> +			se->vruntime +=3D delta;
> +		}
> +	} else {
> +		cfs->min_vruntime =3D core_cfs->min_vruntime;
> +#ifndef CONFIG_64BIT
> +		smp_wmb();
> +		cfs->min_vruntime_copy =3D core_cfs->min_vruntime;
> +#endif
> +	}
> +}
> +
> +#else
> static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
> {
> 	return cfs_rq->min_vruntime;
> }
>=20
> +#ifndef CONFIG_64BIT
> +static inline u64 cfs_rq_min_vruntime_copy(struct cfs_rq *cfs_rq)
> +{
> +	return cfs_rq->min_vruntime_copy;
> +}
> +#endif /* CONFIG_64BIT */
> +
> +#endif /* CONFIG_SCHED_CORE */
> +
> static __always_inline
> void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
>=20
> @@ -522,8 +653,13 @@ static void update_min_vruntime(struct cfs_rq *cfs_r=
q)
> 			vruntime =3D min_vruntime(vruntime, se->vruntime);
> 	}
>=20
> +#ifdef CONFIG_SCHED_CORE
> +	if (sched_core_enabled(rq_of(cfs_rq)) && is_root_cfs_rq(cfs_rq))
> +		cfs_rq =3D core_cfs_rq(cfs_rq);
> +#endif
> +
> 	/* ensure we never gain time by being placed backwards. */
> -	cfs_rq->min_vruntime =3D max_vruntime(cfs_rq_min_vruntime(cfs_rq), vrun=
time);
> +	cfs_rq->min_vruntime =3D max_vruntime(cfs_rq->min_vruntime, vruntime);
> #ifndef CONFIG_64BIT
> 	smp_wmb();
> 	cfs_rq->min_vruntime_copy =3D cfs_rq->min_vruntime;
> @@ -6700,9 +6836,9 @@ static void migrate_task_rq_fair(struct task_struct=
 *p, int new_cpu)
> 		u64 min_vruntime_copy;
>=20
> 		do {
> -			min_vruntime_copy =3D cfs_rq->min_vruntime_copy;
> +			min_vruntime_copy =3D cfs_rq_min_vruntime_copy(cfs_rq);
> 			smp_rmb();
> -			min_vruntime =3D cfs_rq->min_vruntime;
> +			min_vruntime =3D cfs_rq_min_vruntime(cfs_rq);
> 		} while (min_vruntime !=3D min_vruntime_copy);
> #else
> 		min_vruntime =3D cfs_rq_min_vruntime(cfs_rq);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4a738093d731..293aa1ae0308 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1086,6 +1086,9 @@ static inline raw_spinlock_t *rq_lockp(struct rq *r=
q)
> 	return &rq->__lock;
> }
>=20
> +bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
> +void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled)=
;
> +
> #else /* !CONFIG_SCHED_CORE */
>=20
> static inline bool sched_core_enabled(struct rq *rq)
> --=20
> 2.17.1
>=20
>=20


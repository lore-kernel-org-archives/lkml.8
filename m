Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18391207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="hFGEKLml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbgGVIyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:54:41 -0400
Received: from mail4.tencent.com ([183.57.53.109]:57111 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGVIyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:54:40 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail4.tencent.com (Postfix) with ESMTP id 8AB23724CA;
        Wed, 22 Jul 2020 16:54:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595408075;
        bh=Z5wz6SguzXs1PozL8x1L5jrEg9NHhzbRHa0IkJjnaBY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=hFGEKLmlK0S2lV9JNHwkCOo+n/b6i+VTqhyOu6xHFsZTX3tjVe6cLNLdYko/5ZG2l
         Co+DaHTbfH0yXOyTyT7zpLQJ++gl+24LFOkwIA6XjX46xGWFcB9qd/4MTckyobmURP
         bvbG5AawRtsRFKhCaVxTTAOOmbT9lpqiRN0ELlYE=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 16:54:35 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 16:54:34 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 22 Jul 2020 16:54:31 +0800
From:   =?iso-2022-jp?B?YmVuYmppYW5nKBskQj5VSTcbKEIp?= 
        <benbjiang@tencent.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
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
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
Thread-Topic: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
Thread-Index: AQHWTzVqBGu6Ndoz306mL65QHjIl9akS5uOA
Date:   Wed, 22 Jul 2020 08:54:31 +0000
Message-ID: <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.45.201.110]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <8204BD307F8510479E149D9AF19645B7@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Aubrey,

> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.=
com> wrote:
>=20
> From: Aubrey Li <aubrey.li@intel.com>
>=20
> - Don't migrate if there is a cookie mismatch
>     Load balance tries to move task from busiest CPU to the
>     destination CPU. When core scheduling is enabled, if the
>     task's cookie does not match with the destination CPU's
>     core cookie, this task will be skipped by this CPU. This
>     mitigates the forced idle time on the destination CPU.
>=20
> - Select cookie matched idle CPU
>     In the fast path of task wakeup, select the first cookie matched
>     idle CPU instead of the first idle CPU.
>=20
> - Find cookie matched idlest CPU
>     In the slow path of task wakeup, find the idlest CPU whose core
>     cookie matches with task's cookie
>=20
> - Don't migrate task if cookie not match
>     For the NUMA load balance, don't migrate task to the CPU whose
>     core cookie does not match with task's cookie
>=20
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> ---
> kernel/sched/fair.c  | 64 ++++++++++++++++++++++++++++++++++++++++----
> kernel/sched/sched.h | 29 ++++++++++++++++++++
> 2 files changed, 88 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d16939766361..33dc4bf01817 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2051,6 +2051,15 @@ static void task_numa_find_cpu(struct task_numa_en=
v *env,
> 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
> 			continue;
>=20
> +#ifdef CONFIG_SCHED_CORE
> +		/*
> +		 * Skip this cpu if source task's cookie does not match
> +		 * with CPU's core cookie.
> +		 */
> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
> +			continue;
> +#endif
> +
> 		env->dst_cpu =3D cpu;
> 		if (task_numa_compare(env, taskimp, groupimp, maymove))
> 			break;
> @@ -5963,11 +5972,17 @@ find_idlest_group_cpu(struct sched_group *group, =
struct task_struct *p, int this
>=20
> 	/* Traverse only the allowed CPUs */
> 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
> +		struct rq *rq =3D cpu_rq(i);
> +
> +#ifdef CONFIG_SCHED_CORE
> +		if (!sched_core_cookie_match(rq, p))
> +			continue;
> +#endif
> +
> 		if (sched_idle_cpu(i))
> 			return i;
>=20
> 		if (available_idle_cpu(i)) {
> -			struct rq *rq =3D cpu_rq(i);
> 			struct cpuidle_state *idle =3D idle_get_state(rq);
> 			if (idle && idle->exit_latency < min_exit_latency) {
> 				/*
> @@ -6224,8 +6239,18 @@ static int select_idle_cpu(struct task_struct *p, =
struct sched_domain *sd, int t
> 	for_each_cpu_wrap(cpu, cpus, target) {
> 		if (!--nr)
> 			return -1;
> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -			break;
> +
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu)) {
> +#ifdef CONFIG_SCHED_CORE
> +			/*
> +			 * If Core Scheduling is enabled, select this cpu
> +			 * only if the process cookie matches core cookie.
> +			 */
> +			if (sched_core_enabled(cpu_rq(cpu)) &&
> +			    p->core_cookie =3D=3D cpu_rq(cpu)->core->core_cookie)
Why not also add similar logic in select_idle_smt to reduce forced-idle? :)


> +#endif
> +				break;
> +		}
> 	}
>=20
> 	time =3D cpu_clock(this) - time;
> @@ -7609,8 +7634,9 @@ int can_migrate_task(struct task_struct *p, struct =
lb_env *env)
> 	 * We do not migrate tasks that are:
> 	 * 1) throttled_lb_pair, or
> 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> -	 * 3) running (obviously), or
> -	 * 4) are cache-hot on their current CPU.
> +	 * 3) task's cookie does not match with this CPU's core cookie
> +	 * 4) running (obviously), or
> +	 * 5) are cache-hot on their current CPU.
> 	 */
> 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
> 		return 0;
> @@ -7645,6 +7671,15 @@ int can_migrate_task(struct task_struct *p, struct=
 lb_env *env)
> 		return 0;
> 	}
>=20
> +#ifdef CONFIG_SCHED_CORE
> +	/*
> +	 * Don't migrate task if the task's cookie does not match
> +	 * with the destination CPU's core cookie.
> +	 */
> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
> +		return 0;
> +#endif
> +
> 	/* Record that we found atleast one task that could run on dst_cpu */
> 	env->flags &=3D ~LBF_ALL_PINNED;
>=20
> @@ -8857,6 +8892,25 @@ find_idlest_group(struct sched_domain *sd, struct =
task_struct *p,
> 					p->cpus_ptr))
> 			continue;
>=20
> +#ifdef CONFIG_SCHED_CORE
> +		if (sched_core_enabled(cpu_rq(this_cpu))) {
> +			int i =3D 0;
> +			bool cookie_match =3D false;
> +
> +			for_each_cpu(i, sched_group_span(group)) {
Should we consider the p->cpus_ptr here? like,
			for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr ) {
				...
			}
Thx.
Regards,
Jiang

> +				struct rq *rq =3D cpu_rq(i);
> +
> +				if (sched_core_cookie_match(rq, p)) {
> +					cookie_match =3D true;
> +					break;
> +				}
> +			}
> +			/* Skip over this group if no cookie matched */
> +			if (!cookie_match)
> +				continue;
> +		}
> +#endif
> +
> 		local_group =3D cpumask_test_cpu(this_cpu,
> 					       sched_group_span(group));
>=20
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 464559676fd2..875796d43fca 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1089,6 +1089,35 @@ static inline raw_spinlock_t *rq_lockp(struct rq *=
rq)
> bool cfs_prio_less(struct task_struct *a, struct task_struct *b);
> void sched_core_adjust_sibling_vruntime(int cpu, bool coresched_enabled);
>=20
> +/*
> + * Helper to check if the CPU's core cookie matches with the task's cook=
ie
> + * when core scheduling is enabled.
> + * A special case is that the task's cookie always matches with CPU's co=
re
> + * cookie if the CPU is in an idle core.
> + */
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_st=
ruct *p)
> +{
> +	bool idle_core =3D true;
> +	int cpu;
> +
> +	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
> +	if (!sched_core_enabled(rq))
> +		return true;
> +
> +	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> +		if (!available_idle_cpu(cpu)) {
> +			idle_core =3D false;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * A CPU in an idle core is always the best choice for tasks with
> +	 * cookies.
> +	 */
> +	return idle_core || rq->core->core_cookie =3D=3D p->core_cookie;
> +}
> +
> extern void queue_core_balance(struct rq *rq);
>=20
> #else /* !CONFIG_SCHED_CORE */
> --=20
> 2.17.1
>=20
>=20


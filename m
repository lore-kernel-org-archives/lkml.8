Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C02C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A049E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="Wahxc+Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgGUOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:02:49 -0400
Received: from mail4.tencent.com ([183.57.53.109]:34753 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgGUOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:02:48 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail4.tencent.com (Postfix) with ESMTP id 4134872345;
        Tue, 21 Jul 2020 22:02:28 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595340148;
        bh=MULU+lptYUk80ILLHraaQCrpDddk2Am2y2TH3U20auc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Wahxc+HsU4EgJpq5OJBO8D31XMzayEOrx77OieWyEqu5cnIbLnPV2yUWC+ZUuzQT9
         pnNFkb7bzYibnYNVEquq9sjP1sZucKd4WM1KDK+7XdvKF/vAHYHVgOwAnIpbgakSiy
         gA6HtOUwSbVnHl3eUl+oEXw7FZxdF+Z4yhH2q3pU=
Received: from EX-SZ007.tencent.com (10.28.6.31) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 21 Jul
 2020 22:02:28 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ007.tencent.com
 (10.28.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 21 Jul
 2020 22:02:27 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Tue, 21 Jul 2020 22:02:27 +0800
From:   =?iso-2022-jp?B?YmVuYmppYW5nKBskQj5VSTcbKEIp?= 
        <benbjiang@tencent.com>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>
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
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 05/16] sched: Basic tracking of matching
 tasks(Internet mail)
Thread-Topic: [RFC PATCH 05/16] sched: Basic tracking of matching
 tasks(Internet mail)
Thread-Index: AQHWTyYaGKlAaqennU2IFgurg8DvGakRqrmA
Date:   Tue, 21 Jul 2020 14:02:27 +0000
Message-ID: <4CED2328-B487-49EB-988E-406CE5A4930F@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <2ae4e2f2d2b027d186365ce9d98abd6c430aaa0e.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <2ae4e2f2d2b027d186365ce9d98abd6c430aaa0e.1593530334.git.vpillai@digitalocean.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.78]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <23D436FB49AFDC44A191A61152B47021@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, perter

> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.=
com> wrote:
>=20
> From: Peter Zijlstra <peterz@infradead.org>
>=20
> Introduce task_struct::core_cookie as an opaque identifier for core
> scheduling. When enabled; core scheduling will only allow matching
> task to be on the core; where idle matches everything.
>=20
> When task_struct::core_cookie is set (and core scheduling is enabled)
> these tasks are indexed in a second RB-tree, first on cookie value
> then on scheduling function, such that matching task selection always
> finds the most elegible match.
>=20
> NOTE: *shudder* at the overhead...
>=20
> NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
> is per class tracking of cookies and that just duplicates a lot of
> stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> ---
> include/linux/sched.h |   8 ++-
> kernel/sched/core.c   | 146 ++++++++++++++++++++++++++++++++++++++++++
> kernel/sched/fair.c   |  46 -------------
> kernel/sched/sched.h  |  55 ++++++++++++++++
> 4 files changed, 208 insertions(+), 47 deletions(-)
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4418f5cb8324..3c8dcc5ff039 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -683,10 +683,16 @@ struct task_struct {
> 	const struct sched_class	*sched_class;
> 	struct sched_entity		se;
> 	struct sched_rt_entity		rt;
> +	struct sched_dl_entity		dl;
> +
> +#ifdef CONFIG_SCHED_CORE
> +	struct rb_node			core_node;
> +	unsigned long			core_cookie;
> +#endif
> +
> #ifdef CONFIG_CGROUP_SCHED
> 	struct task_group		*sched_task_group;
> #endif
> -	struct sched_dl_entity		dl;
>=20
> #ifdef CONFIG_UCLAMP_TASK
> 	/* Clamp values requested for a scheduling entity */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4b81301e3f21..b21bcab20da6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -77,6 +77,141 @@ int sysctl_sched_rt_runtime =3D 950000;
>=20
> DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
>=20
> +/* kernel prio, less is more */
> +static inline int __task_prio(struct task_struct *p)
> +{
> +	if (p->sched_class =3D=3D &stop_sched_class) /* trumps deadline */
> +		return -2;
> +
> +	if (rt_prio(p->prio)) /* includes deadline */
> +		return p->prio; /* [-1, 99] */
> +
> +	if (p->sched_class =3D=3D &idle_sched_class)
> +		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */

return MAX_PRIO;=20
May be simpler?

> +
> +	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */

MAX_RT_PRIO(100) + MAX_NICE(19) Should be 119?  :)

Thx.
Regards,
Jiang

> +}
> +
> +/*
> + * l(a,b)
> + * le(a,b) :=3D !l(b,a)
> + * g(a,b)  :=3D l(b,a)
> + * ge(a,b) :=3D !l(a,b)
> + */
> +
> +/* real prio, less is less */
> +static inline bool prio_less(struct task_struct *a, struct task_struct *=
b)
> +{
> +
> +	int pa =3D __task_prio(a), pb =3D __task_prio(b);
> +
> +	if (-pa < -pb)
> +		return true;
> +
> +	if (-pb < -pa)
> +		return false;
> +
> +	if (pa =3D=3D -1) /* dl_prio() doesn't work because of stop_class above=
 */
> +		return !dl_time_before(a->dl.deadline, b->dl.deadline);
> +
> +	if (pa =3D=3D MAX_RT_PRIO + MAX_NICE)  { /* fair */
> +		u64 vruntime =3D b->se.vruntime;
> +
> +		/*
> +		 * Normalize the vruntime if tasks are in different cpus.
> +		 */
> +		if (task_cpu(a) !=3D task_cpu(b)) {
> +			vruntime -=3D task_cfs_rq(b)->min_vruntime;
> +			vruntime +=3D task_cfs_rq(a)->min_vruntime;
> +		}
> +
> +		return !((s64)(a->se.vruntime - vruntime) <=3D 0);
> +	}
> +
> +	return false;
> +}
> +
> +static inline bool __sched_core_less(struct task_struct *a, struct task_=
struct *b)
> +{
> +	if (a->core_cookie < b->core_cookie)
> +		return true;
> +
> +	if (a->core_cookie > b->core_cookie)
> +		return false;
> +
> +	/* flip prio, so high prio is leftmost */
> +	if (prio_less(b, a))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
> +{
> +	struct rb_node *parent, **node;
> +	struct task_struct *node_task;
> +
> +	rq->core->core_task_seq++;
> +
> +	if (!p->core_cookie)
> +		return;
> +
> +	node =3D &rq->core_tree.rb_node;
> +	parent =3D *node;
> +
> +	while (*node) {
> +		node_task =3D container_of(*node, struct task_struct, core_node);
> +		parent =3D *node;
> +
> +		if (__sched_core_less(p, node_task))
> +			node =3D &parent->rb_left;
> +		else
> +			node =3D &parent->rb_right;
> +	}
> +
> +	rb_link_node(&p->core_node, parent, node);
> +	rb_insert_color(&p->core_node, &rq->core_tree);
> +}
> +
> +static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
> +{
> +	rq->core->core_task_seq++;
> +
> +	if (!p->core_cookie)
> +		return;
> +
> +	rb_erase(&p->core_node, &rq->core_tree);
> +}
> +
> +/*
> + * Find left-most (aka, highest priority) task matching @cookie.
> + */
> +static struct task_struct *sched_core_find(struct rq *rq, unsigned long =
cookie)
> +{
> +	struct rb_node *node =3D rq->core_tree.rb_node;
> +	struct task_struct *node_task, *match;
> +
> +	/*
> +	 * The idle task always matches any cookie!
> +	 */
> +	match =3D idle_sched_class.pick_task(rq);
> +
> +	while (node) {
> +		node_task =3D container_of(node, struct task_struct, core_node);
> +
> +		if (cookie < node_task->core_cookie) {
> +			node =3D node->rb_left;
> +		} else if (cookie > node_task->core_cookie) {
> +			node =3D node->rb_right;
> +		} else {
> +			match =3D node_task;
> +			node =3D node->rb_left;
> +		}
> +	}
> +
> +	return match;
> +}
> +
> /*
>  * The static-key + stop-machine variable are needed such that:
>  *
> @@ -135,6 +270,11 @@ void sched_core_put(void)
> 	mutex_unlock(&sched_core_mutex);
> }
>=20
> +#else /* !CONFIG_SCHED_CORE */
> +
> +static inline void sched_core_enqueue(struct rq *rq, struct task_struct =
*p) { }
> +static inline void sched_core_dequeue(struct rq *rq, struct task_struct =
*p) { }
> +
> #endif /* CONFIG_SCHED_CORE */
>=20
> /*
> @@ -1347,6 +1487,9 @@ static inline void init_uclamp(void) { }
>=20
> static inline void enqueue_task(struct rq *rq, struct task_struct *p, int=
 flags)
> {
> +	if (sched_core_enabled(rq))
> +		sched_core_enqueue(rq, p);
> +
> 	if (!(flags & ENQUEUE_NOCLOCK))
> 		update_rq_clock(rq);
>=20
> @@ -1361,6 +1504,9 @@ static inline void enqueue_task(struct rq *rq, stru=
ct task_struct *p, int flags)
>=20
> static inline void dequeue_task(struct rq *rq, struct task_struct *p, int=
 flags)
> {
> +	if (sched_core_enabled(rq))
> +		sched_core_dequeue(rq, p);
> +
> 	if (!(flags & DEQUEUE_NOCLOCK))
> 		update_rq_clock(rq);
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e44a43b87975..ae17507533a0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -260,33 +260,11 @@ const struct sched_class fair_sched_class;
>  */
>=20
> #ifdef CONFIG_FAIR_GROUP_SCHED
> -static inline struct task_struct *task_of(struct sched_entity *se)
> -{
> -	SCHED_WARN_ON(!entity_is_task(se));
> -	return container_of(se, struct task_struct, se);
> -}
>=20
> /* Walk up scheduling entities hierarchy */
> #define for_each_sched_entity(se) \
> 		for (; se; se =3D se->parent)
>=20
> -static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
> -{
> -	return p->se.cfs_rq;
> -}
> -
> -/* runqueue on which this entity is (to be) queued */
> -static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
> -{
> -	return se->cfs_rq;
> -}
> -
> -/* runqueue "owned" by this group */
> -static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
> -{
> -	return grp->my_q;
> -}
> -
> static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int =
len)
> {
> 	if (!path)
> @@ -447,33 +425,9 @@ find_matching_se(struct sched_entity **se, struct sc=
hed_entity **pse)
>=20
> #else	/* !CONFIG_FAIR_GROUP_SCHED */
>=20
> -static inline struct task_struct *task_of(struct sched_entity *se)
> -{
> -	return container_of(se, struct task_struct, se);
> -}
> -
> #define for_each_sched_entity(se) \
> 		for (; se; se =3D NULL)
>=20
> -static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
> -{
> -	return &task_rq(p)->cfs;
> -}
> -
> -static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
> -{
> -	struct task_struct *p =3D task_of(se);
> -	struct rq *rq =3D task_rq(p);
> -
> -	return &rq->cfs;
> -}
> -
> -/* runqueue "owned" by this group */
> -static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
> -{
> -	return NULL;
> -}
> -
> static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int =
len)
> {
> 	if (path)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 66e586adee18..c85c5a4bc21f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1033,6 +1033,10 @@ struct rq {
> 	/* per rq */
> 	struct rq		*core;
> 	unsigned int		core_enabled;
> +	struct rb_root		core_tree;
> +
> +	/* shared state */
> +	unsigned int		core_task_seq;
> #endif
> };
>=20
> @@ -1112,6 +1116,57 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueue=
s);
> #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
> #define raw_rq()		raw_cpu_ptr(&runqueues)
>=20
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +static inline struct task_struct *task_of(struct sched_entity *se)
> +{
> +	SCHED_WARN_ON(!entity_is_task(se));
> +	return container_of(se, struct task_struct, se);
> +}
> +
> +static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
> +{
> +	return p->se.cfs_rq;
> +}
> +
> +/* runqueue on which this entity is (to be) queued */
> +static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
> +{
> +	return se->cfs_rq;
> +}
> +
> +/* runqueue "owned" by this group */
> +static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
> +{
> +	return grp->my_q;
> +}
> +
> +#else
> +
> +static inline struct task_struct *task_of(struct sched_entity *se)
> +{
> +	return container_of(se, struct task_struct, se);
> +}
> +
> +static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
> +{
> +	return &task_rq(p)->cfs;
> +}
> +
> +static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
> +{
> +	struct task_struct *p =3D task_of(se);
> +	struct rq *rq =3D task_rq(p);
> +
> +	return &rq->cfs;
> +}
> +
> +/* runqueue "owned" by this group */
> +static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
> +{
> +	return NULL;
> +}
> +#endif
> +
> extern void update_rq_clock(struct rq *rq);
>=20
> static inline u64 __rq_clock_broken(struct rq *rq)
> --=20
> 2.17.1
>=20
>=20


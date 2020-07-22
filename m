Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AEFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563FD20674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="GPpx9vug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbgGVHUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:20:19 -0400
Received: from mail4.tencent.com ([183.57.53.109]:34838 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgGVHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:20:17 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
        by mail4.tencent.com (Postfix) with ESMTP id B5702724D6;
        Wed, 22 Jul 2020 15:20:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1595402413;
        bh=AsYlnjFF2hYKj+7FKYMNeD7e5NE3fdzhp7oH/PzpvYU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=GPpx9vughH3O4VqknGZLt6yFJ5PC1HUDD6Mwg4VvOD6LT5kSo0kKzO4qGRWdrrfZ4
         8R5Gqkx35QNqeht4VBkGakJ+DYb7FUhxCkT91+Ae5raq1dsqX/44bWVwUHK0YNYwv6
         1CUkb6/sudfv0EsVeLOIzV35OmQtChgA5H/LapWU=
Received: from EX-SZ004.tencent.com (10.28.6.25) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 15:20:13 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ004.tencent.com
 (10.28.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Jul
 2020 15:20:13 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 22 Jul 2020 15:20:13 +0800
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 07/16] sched/fair: Fix forced idle sibling starvation
 corner case(Internet mail)
Thread-Topic: [RFC PATCH 07/16] sched/fair: Fix forced idle sibling starvation
 corner case(Internet mail)
Thread-Index: AQHWTyYlpLP1bK1w0UWTtI+YyeyPMKkSzKoA
Date:   Wed, 22 Jul 2020 07:20:13 +0000
Message-ID: <8C431BBC-154C-4AAC-8876-FFFF173AE2B9@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <d8ff57c098623e701cc3a8b37f667542f9b8d218.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <d8ff57c098623e701cc3a8b37f667542f9b8d218.1593530334.git.vpillai@digitalocean.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.93]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <BBBF2514D607514095EA89A79DFF2015@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@digitalocean.=
com> wrote:
>=20
> From: vpillai <vpillai@digitalocean.com>
>=20
> If there is only one long running local task and the sibling is
> forced idle, it  might not get a chance to run until a schedule
> event happens on any cpu in the core.
>=20
> So we check for this condition during a tick to see if a sibling
> is starved and then give it a chance to schedule.
Hi,

There may be other similar starvation cases this patch can not cover.=20
Such as, If there is one long running RT task and sibling is forced idle, t=
hen all tasks with different cookies on all siblings could be starving fore=
ver.
Current load-balances seems not able to pull the starved tasks away.=20
Would load-balance be more aware of core-scheduling to make things better? =
:)

Thx.
Regards,
Jiang=20

>=20
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> ---
> kernel/sched/fair.c | 39 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 39 insertions(+)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae17507533a0..49fb93296e35 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10613,6 +10613,40 @@ static void rq_offline_fair(struct rq *rq)
>=20
> #endif /* CONFIG_SMP */
>=20
> +#ifdef CONFIG_SCHED_CORE
> +static inline bool
> +__entity_slice_used(struct sched_entity *se)
> +{
> +	return (se->sum_exec_runtime - se->prev_sum_exec_runtime) >
> +		sched_slice(cfs_rq_of(se), se);
> +}
> +
> +/*
> + * If runqueue has only one task which used up its slice and if the sibl=
ing
> + * is forced idle, then trigger schedule to give forced idle task a chan=
ce.
> + */
> +static void resched_forceidle_sibling(struct rq *rq, struct sched_entity=
 *se)
> +{
> +	int cpu =3D cpu_of(rq), sibling_cpu;
> +
> +	if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
> +		return;
> +
> +	for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
> +		struct rq *sibling_rq;
> +		if (sibling_cpu =3D=3D cpu)
> +			continue;
> +		if (cpu_is_offline(sibling_cpu))
> +			continue;
> +
> +		sibling_rq =3D cpu_rq(sibling_cpu);
> +		if (sibling_rq->core_forceidle) {
> +			resched_curr(sibling_rq);
> +		}
> +	}
> +}
> +#endif
> +
> /*
>  * scheduler tick hitting a task of our scheduling class.
>  *
> @@ -10636,6 +10670,11 @@ static void task_tick_fair(struct rq *rq, struct=
 task_struct *curr, int queued)
>=20
> 	update_misfit_status(curr, rq);
> 	update_overutilized_status(task_rq(curr));
> +
> +#ifdef CONFIG_SCHED_CORE
> +	if (sched_core_enabled(rq))
> +		resched_forceidle_sibling(rq, &curr->se);
> +#endif
> }
>=20
> /*
> --=20
> 2.17.1
>=20
>=20


Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B6BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E307820732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5A3naqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgDMOpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:45:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728557AbgDMOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586789111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIIIpRe6mjSrtNEiLaRkIQTDbcU67t51lD1WUmbZpGs=;
        b=G5A3naqWTgWH2X0n7qEeoBEPxD+2n+3u0PjUuApfckwnXjnsennhw4z++XRFyvml6n5kwK
        fH8r0214sfM7oFRRoKg9usuRUm31uX3FzBLj4OmEDCGnaxIsIaezj3uzsqBO3doldKrFoa
        xoLZ2HyU7ECnK6XxxTI3oB9DaCC+8F0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-4HCdmAWcMWaa4dPRDBIuEA-1; Mon, 13 Apr 2020 10:45:05 -0400
X-MC-Unique: 4HCdmAWcMWaa4dPRDBIuEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B033DDB60;
        Mon, 13 Apr 2020 14:45:03 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-48.phx2.redhat.com [10.3.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86D3C5C1B2;
        Mon, 13 Apr 2020 14:44:59 +0000 (UTC)
Date:   Mon, 13 Apr 2020 10:44:57 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Paul Turner <pjt@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: eliminate bandwidth race between throttling
 and distribution
Message-ID: <20200413144457.GA2517@lorien.usersys.redhat.com>
References: <20200410225208.109717-1-joshdon@google.com>
 <20200410225208.109717-2-joshdon@google.com>
 <CABk29NtxG8t6wHM6MDVFun7jxqRpupWr0d5dK57N2ecFbdSumw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CABk29NtxG8t6wHM6MDVFun7jxqRpupWr0d5dK57N2ecFbdSumw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Sat, Apr 11, 2020 at 07:00:17PM -0700 Josh Don wrote:
> +[1]pauld@redhat.com
>=20
> On Fri, Apr 10, 2020 at 3:52 PM Josh Don <[2]joshdon@google.com> wrote:
>=20
>     From: Paul Turner <[3]pjt@google.com>
>=20
>     There is a race window in which an entity begins throttling before =
quota
>     is added to the pool, but does not finish throttling until after we=
 have
>     finished with distribute_cfs_runtime(). This entity is not observed=
 by
>     distribute_cfs_runtime() because it was not on the throttled list a=
t the
>     time that distribution was running. This race manifests as rare
>     period-length statlls for such entities.
>=20
>     Rather than heavy-weight the synchronization with the progress of
>     distribution, we can fix this by aborting throttling if bandwidth h=
as
>     become available. Otherwise, we immediately add the entity to the
>     throttled list so that it can be observed by a subsequent distribut=
ion.
>=20
>     Additionally, we can remove the case of adding the throttled entity=
 to
>     the head of the throttled list, and simply always add to the tail.
>     Thanks to 26a8b12747c97, distribute_cfs_runtime() no longer holds o=
nto
>     its own pool of runtime. This means that if we do hit the !assign a=
nd
>     distribute_running case, we know that distribution is about to end.
>=20
>     Signed-off-by: Paul Turner <[4]pjt@google.com>
>     Co-developed-by: Ben Segall <[5]bsegall@google.com>
>     Signed-off-by: Ben Segall <[6]bsegall@google.com>
>     Signed-off-by: Josh Don <[7]joshdon@google.com>

This looks good to me, thanks for the cc.

Reviewed-by: Phil Auld <pauld@redhat.com>

>     ---
>     =A0kernel/sched/fair.c | 78 ++++++++++++++++++++++++++-------------=
------
>     =A01 file changed, 46 insertions(+), 32 deletions(-)
>=20
>     diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>     index 02f323b85b6d..3fb986c52825 100644
>     --- a/kernel/sched/fair.c
>     +++ b/kernel/sched/fair.c
>     @@ -4587,17 +4587,15 @@ static inline struct cfs_bandwidth
>     *tg_cfs_bandwidth(struct task_group *tg)
>     =A0 =A0 =A0 =A0 return &tg->cfs_bandwidth;
>     =A0}
>=20
>     -/* returns 0 on failure to allocate runtime */
>     -static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>     +/* returns 0 on failure to allocate runtime, called with cfs_b->lo=
ck held
>     */
>     +static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct cfs_rq *cfs_rq, u64
>     target_runtime)
>     =A0{
>     -=A0 =A0 =A0 =A0struct task_group *tg =3D cfs_rq->tg;
>     -=A0 =A0 =A0 =A0struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(tg=
);
>     =A0 =A0 =A0 =A0 u64 amount =3D 0, min_amount;
>=20
>     =A0 =A0 =A0 =A0 /* note: this is a positive sum as runtime_remainin=
g <=3D 0 */
>     -=A0 =A0 =A0 =A0min_amount =3D sched_cfs_bandwidth_slice() - cfs_rq=
->
>     runtime_remaining;
>     +=A0 =A0 =A0 =A0min_amount =3D target_runtime - cfs_rq->runtime_rem=
aining;
>=20
>     -=A0 =A0 =A0 =A0raw_spin_lock(&cfs_b->lock);
>     =A0 =A0 =A0 =A0 if (cfs_b->quota =3D=3D RUNTIME_INF)
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 amount =3D min_amount;
>     =A0 =A0 =A0 =A0 else {
>     @@ -4609,13 +4607,26 @@ static int assign_cfs_rq_runtime(struct cfs=
_rq
>     *cfs_rq)
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfs_b->idle =3D 0;
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>     =A0 =A0 =A0 =A0 }
>     -=A0 =A0 =A0 =A0raw_spin_unlock(&cfs_b->lock);
>=20
>     =A0 =A0 =A0 =A0 cfs_rq->runtime_remaining +=3D amount;
>=20
>     =A0 =A0 =A0 =A0 return cfs_rq->runtime_remaining > 0;
>     =A0}
>=20
>     +/* returns 0 on failure to allocate runtime */
>     +static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>     +{
>     +=A0 =A0 =A0 =A0int ret;
>     +=A0 =A0 =A0 =A0struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(cf=
s_rq->tg);
>     +
>     +=A0 =A0 =A0 =A0raw_spin_lock(&cfs_b->lock);
>     +=A0 =A0 =A0 =A0ret =3D __assign_cfs_rq_runtime(cfs_b, cfs_rq,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0sched_cfs_bandwidth_slice());
>     +=A0 =A0 =A0 =A0raw_spin_unlock(&cfs_b->lock);
>     +
>     +=A0 =A0 =A0 =A0return ret;
>     +}
>     +
>     =A0static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64
>     delta_exec)
>     =A0{
>     =A0 =A0 =A0 =A0 /* dock delta_exec before expiring quota (as it cou=
ld span periods)
>     */
>     @@ -4704,13 +4715,33 @@ static int tg_throttle_down(struct task_gro=
up *tg,
>     void *data)
>     =A0 =A0 =A0 =A0 return 0;
>     =A0}
>=20
>     -static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>     +static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>     =A0{
>     =A0 =A0 =A0 =A0 struct rq *rq =3D rq_of(cfs_rq);
>     =A0 =A0 =A0 =A0 struct cfs_bandwidth *cfs_b =3D tg_cfs_bandwidth(cf=
s_rq->tg);
>     =A0 =A0 =A0 =A0 struct sched_entity *se;
>     =A0 =A0 =A0 =A0 long task_delta, idle_task_delta, dequeue =3D 1;
>     -=A0 =A0 =A0 =A0bool empty;
>     +
>     +=A0 =A0 =A0 =A0raw_spin_lock(&cfs_b->lock);
>     +=A0 =A0 =A0 =A0/* This will start the period timer if necessary */
>     +=A0 =A0 =A0 =A0if (__assign_cfs_rq_runtime(cfs_b, cfs_rq, 1)) {
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We have raced with bandwidth bec=
oming available, and if
>     we
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * actually throttled the timer mig=
ht not unthrottle us for
>     an
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * entire period. We additionally n=
eeded to make sure that
>     any
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * subsequent check_cfs_rq_runtime =
calls agree not to
>     throttle
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * us, as we may commit to do cfs p=
ut_prev+pick_next, so we
>     ask
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * for 1ns of runtime rather than j=
ust check cfs_b.
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dequeue =3D 0;
>     +=A0 =A0 =A0 =A0} else {
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_add_tail_rcu(&cfs_rq->throttle=
d_list,
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
&cfs_b->throttled_cfs_rq);
>     +=A0 =A0 =A0 =A0}
>     +=A0 =A0 =A0 =A0raw_spin_unlock(&cfs_b->lock);
>     +
>     +=A0 =A0 =A0 =A0if (!dequeue)
>     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return false;=A0 /* Throttle no lon=
ger required. */
>=20
>     =A0 =A0 =A0 =A0 se =3D cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
>=20
>     @@ -4744,29 +4775,13 @@ static void throttle_cfs_rq(struct cfs_rq *=
cfs_rq)
>     =A0 =A0 =A0 =A0 if (!se)
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sub_nr_running(rq, task_delta);
>=20
>     -=A0 =A0 =A0 =A0cfs_rq->throttled =3D 1;
>     -=A0 =A0 =A0 =A0cfs_rq->throttled_clock =3D rq_clock(rq);
>     -=A0 =A0 =A0 =A0raw_spin_lock(&cfs_b->lock);
>     -=A0 =A0 =A0 =A0empty =3D list_empty(&cfs_b->throttled_cfs_rq);
>     -
>     =A0 =A0 =A0 =A0 /*
>     -=A0 =A0 =A0 =A0 * Add to the _head_ of the list, so that an alread=
y-started
>     -=A0 =A0 =A0 =A0 * distribute_cfs_runtime will not see us. If disri=
bute_cfs_runtime
>     is
>     -=A0 =A0 =A0 =A0 * not running add to the tail so that later runque=
ues don't get
>     starved.
>     +=A0 =A0 =A0 =A0 * Note: distribution will already see us throttled=
 via the
>     +=A0 =A0 =A0 =A0 * throttled-list.=A0 rq->lock protects completion.
>     =A0 =A0 =A0 =A0 =A0*/
>     -=A0 =A0 =A0 =A0if (cfs_b->distribute_running)
>     -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_add_rcu(&cfs_rq->throttled_lis=
t, &cfs_b->
>     throttled_cfs_rq);
>     -=A0 =A0 =A0 =A0else
>     -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_add_tail_rcu(&cfs_rq->throttle=
d_list, &cfs_b->
>     throttled_cfs_rq);
>     -
>     -=A0 =A0 =A0 =A0/*
>     -=A0 =A0 =A0 =A0 * If we're the first throttled task, make sure the=
 bandwidth
>     -=A0 =A0 =A0 =A0 * timer is running.
>     -=A0 =A0 =A0 =A0 */
>     -=A0 =A0 =A0 =A0if (empty)
>     -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_cfs_bandwidth(cfs_b);
>     -
>     -=A0 =A0 =A0 =A0raw_spin_unlock(&cfs_b->lock);
>     +=A0 =A0 =A0 =A0cfs_rq->throttled =3D 1;
>     +=A0 =A0 =A0 =A0cfs_rq->throttled_clock =3D rq_clock(rq);
>     +=A0 =A0 =A0 =A0return true;
>     =A0}
>=20
>     =A0void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>     @@ -5121,8 +5136,7 @@ static bool check_cfs_rq_runtime(struct cfs_r=
q
>     *cfs_rq)
>     =A0 =A0 =A0 =A0 if (cfs_rq_throttled(cfs_rq))
>     =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
>=20
>     -=A0 =A0 =A0 =A0throttle_cfs_rq(cfs_rq);
>     -=A0 =A0 =A0 =A0return true;
>     +=A0 =A0 =A0 =A0return throttle_cfs_rq(cfs_rq);
>     =A0}
>=20
>     =A0static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer=
 *timer)
>     --
>     2.26.0.110.g2183baf09c-goog
>=20
>=20
>=20
> References:
>=20
> [1] mailto:pauld@redhat.com
> [2] mailto:joshdon@google.com
> [3] mailto:pjt@google.com
> [4] mailto:pjt@google.com
> [5] mailto:bsegall@google.com
> [6] mailto:bsegall@google.com
> [7] mailto:joshdon@google.com

--=20


Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA9E2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR1Yz7hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGWXnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGWXng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:43:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0546C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:43:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so8211264lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lrITTsHMWJgtlxQrfu80nB96T41W3LIcvJxyQMd+CQ4=;
        b=WR1Yz7hOSFkyK+iBp9hZFjmlhqsXo29pxuvaLrj/E4/9SwL0L1b9bv8sZBZqMnnyMx
         7YI7XhNKd4Fy/8es3w+G80udaKxlxKo/chDSZRnG0HGIaeVvLJovtn/snS3xf41ZY6XE
         OlrHYBjNOsPUVvJh70FstqY1/YGro1oYus/noKEYtKvi/SWSUCsFHay3ih16X4BghZfY
         H9tsM1UxlNYO0+ohBFahza8Y/7IkVojjjR4WxYCmNzHVrXg/rRtSMSguaE2Sk3HM3Ocn
         TF8Br64dntlOE48mhoIXyOrozqweMgnvWCViLuD/HUc6p4Z7PxmkugeRM4/RI1ws5iY+
         2ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lrITTsHMWJgtlxQrfu80nB96T41W3LIcvJxyQMd+CQ4=;
        b=jYg1ODnqkuAt4OImGKTpYTaHbQQJ0VT8/8zO4ljfeYP+yg7cLIVR0WCW4UVljwWBvP
         EFoOOgXB3WKO2rchTvCoaYx0VvCKjjQ79YiAQlhnU+jXPP9aIx31rDB3r6zMCmNnfMy/
         yjE3RInsiqcG6oww/dPQG39NelrVCPSrxr4F+I7PvvwXoSOvCqIRjNAELtN7JSviKub6
         Ihcc1nSVOsxn6DF4tdEZEw9gywpJ0/Iw4ZVcVFEpZLg9J9OhWz1+dtp+M70MVxpFsDik
         U+Wt4YLdDuSXxl2r/3wuWRrPwdX+/b3U6WgJdx4r8IRCpONb9anYKWxV42srFHttA+OE
         +Jvw==
X-Gm-Message-State: AOAM532IpWzwqAqhxR4LDc7gIu6WVEENMLn+aTp8/wogJQDXQsyJa4aa
        6S37xKgupl+vq0IRP9LmsqZiZOJAIoNKWAxWv6w=
X-Google-Smtp-Source: ABdhPJwdjm3Som5VWCw6t9X/IAH/6qUvFelmhDQ6r59d/QN66EVobeV85YD2FCQCFElBJENsIRKBfNNj5lOVUclEpaY=
X-Received: by 2002:a2e:98d0:: with SMTP id s16mr2835371ljj.457.1595547813936;
 Thu, 23 Jul 2020 16:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <9044a2ebde089483d45c091752d208a878c604ac.1593530334.git.vpillai@digitalocean.com>
 <72869477-AA03-47D4-96C5-D3CDBDBC12E7@tencent.com> <459dbf33-02f6-d4e0-52e4-919e1e33be13@linux.intel.com>
 <5C71B460-8DC3-44AF-A75E-68BB2E33686B@tencent.com> <589382b3-709e-17a6-d693-05ebd3998336@linux.intel.com>
 <897E5117-8A78-4CE3-8514-3577C4474775@tencent.com> <6ab8a001-ae5e-e484-c571-90d6931004e7@linux.intel.com>
 <96A765D7-7FD3-40EB-873B-0F9365569490@tencent.com> <a4533d7f-41b0-3477-0316-0e2df55cbe9c@linux.intel.com>
 <325B98A4-9135-4138-AFED-ADFC3560D917@tencent.com> <36cce58e-03b3-4d77-dfc5-e3c49f3ecdd8@linux.intel.com>
 <A73E4BD3-D742-40E1-9928-B45BC68D1B89@tencent.com>
In-Reply-To: <A73E4BD3-D742-40E1-9928-B45BC68D1B89@tencent.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 24 Jul 2020 07:43:21 +0800
Message-ID: <CAERHkrseWGsQ7Vw1Sb4A+PB6XFeeuTj4d1nH70kadRFRXLQLsg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/16] sched: migration changes for core
 scheduling(Internet mail)
To:     =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "vineethrp@gmail.com" <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 4:28 PM benbjiang(=E8=92=8B=E5=BD=AA) <benbjiang@te=
ncent.com> wrote:
>
> Hi,
>
> > On Jul 23, 2020, at 4:06 PM, Li, Aubrey <aubrey.li@linux.intel.com> wro=
te:
> >
> > On 2020/7/23 15:47, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >> Hi,
> >>
> >>> On Jul 23, 2020, at 1:39 PM, Li, Aubrey <aubrey.li@linux.intel.com> w=
rote:
> >>>
> >>> On 2020/7/23 12:23, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>> Hi,
> >>>>> On Jul 23, 2020, at 11:35 AM, Li, Aubrey <aubrey.li@linux.intel.com=
> wrote:
> >>>>>
> >>>>> On 2020/7/23 10:42, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>>> On Jul 23, 2020, at 9:57 AM, Li, Aubrey <aubrey.li@linux.intel.co=
m> wrote:
> >>>>>>>
> >>>>>>> On 2020/7/22 22:32, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>>> On Jul 22, 2020, at 8:13 PM, Li, Aubrey <aubrey.li@linux.intel.=
com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 2020/7/22 16:54, benbjiang(=E8=92=8B=E5=BD=AA) wrote:
> >>>>>>>>>> Hi, Aubrey,
> >>>>>>>>>>
> >>>>>>>>>>> On Jul 1, 2020, at 5:32 AM, Vineeth Remanan Pillai <vpillai@d=
igitalocean.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> From: Aubrey Li <aubrey.li@intel.com>
> >>>>>>>>>>>
> >>>>>>>>>>> - Don't migrate if there is a cookie mismatch
> >>>>>>>>>>> Load balance tries to move task from busiest CPU to the
> >>>>>>>>>>> destination CPU. When core scheduling is enabled, if the
> >>>>>>>>>>> task's cookie does not match with the destination CPU's
> >>>>>>>>>>> core cookie, this task will be skipped by this CPU. This
> >>>>>>>>>>> mitigates the forced idle time on the destination CPU.
> >>>>>>>>>>>
> >>>>>>>>>>> - Select cookie matched idle CPU
> >>>>>>>>>>> In the fast path of task wakeup, select the first cookie matc=
hed
> >>>>>>>>>>> idle CPU instead of the first idle CPU.
> >>>>>>>>>>>
> >>>>>>>>>>> - Find cookie matched idlest CPU
> >>>>>>>>>>> In the slow path of task wakeup, find the idlest CPU whose co=
re
> >>>>>>>>>>> cookie matches with task's cookie
> >>>>>>>>>>>
> >>>>>>>>>>> - Don't migrate task if cookie not match
> >>>>>>>>>>> For the NUMA load balance, don't migrate task to the CPU whos=
e
> >>>>>>>>>>> core cookie does not match with task's cookie
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> >>>>>>>>>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> >>>>>>>>>>> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.c=
om>
> >>>>>>>>>>> ---
> >>>>>>>>>>> kernel/sched/fair.c  | 64 +++++++++++++++++++++++++++++++++++=
+++++----
> >>>>>>>>>>> kernel/sched/sched.h | 29 ++++++++++++++++++++
> >>>>>>>>>>> 2 files changed, 88 insertions(+), 5 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>>>>>>>> index d16939766361..33dc4bf01817 100644
> >>>>>>>>>>> --- a/kernel/sched/fair.c
> >>>>>>>>>>> +++ b/kernel/sched/fair.c
> >>>>>>>>>>> @@ -2051,6 +2051,15 @@ static void task_numa_find_cpu(struct =
task_numa_env *env,
> >>>>>>>>>>>             if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
> >>>>>>>>>>>                     continue;
> >>>>>>>>>>>
> >>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
> >>>>>>>>>>> +           /*
> >>>>>>>>>>> +            * Skip this cpu if source task's cookie does not=
 match
> >>>>>>>>>>> +            * with CPU's core cookie.
> >>>>>>>>>>> +            */
> >>>>>>>>>>> +           if (!sched_core_cookie_match(cpu_rq(cpu), env->p)=
)
> >>>>>>>>>>> +                   continue;
> >>>>>>>>>>> +#endif
> >>>>>>>>>>> +
> >>>>>>>>>>>             env->dst_cpu =3D cpu;
> >>>>>>>>>>>             if (task_numa_compare(env, taskimp, groupimp, may=
move))
> >>>>>>>>>>>                     break;
> >>>>>>>>>>> @@ -5963,11 +5972,17 @@ find_idlest_group_cpu(struct sched_gr=
oup *group, struct task_struct *p, int this
> >>>>>>>>>>>
> >>>>>>>>>>>     /* Traverse only the allowed CPUs */
> >>>>>>>>>>>     for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr)=
 {
> >>>>>>>>>>> +           struct rq *rq =3D cpu_rq(i);
> >>>>>>>>>>> +
> >>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
> >>>>>>>>>>> +           if (!sched_core_cookie_match(rq, p))
> >>>>>>>>>>> +                   continue;
> >>>>>>>>>>> +#endif
> >>>>>>>>>>> +
> >>>>>>>>>>>             if (sched_idle_cpu(i))
> >>>>>>>>>>>                     return i;
> >>>>>>>>>>>
> >>>>>>>>>>>             if (available_idle_cpu(i)) {
> >>>>>>>>>>> -                   struct rq *rq =3D cpu_rq(i);
> >>>>>>>>>>>                     struct cpuidle_state *idle =3D idle_get_s=
tate(rq);
> >>>>>>>>>>>                     if (idle && idle->exit_latency < min_exit=
_latency) {
> >>>>>>>>>>>                             /*
> >>>>>>>>>>> @@ -6224,8 +6239,18 @@ static int select_idle_cpu(struct task=
_struct *p, struct sched_domain *sd, int t
> >>>>>>>>>>>     for_each_cpu_wrap(cpu, cpus, target) {
> >>>>>>>>>>>             if (!--nr)
> >>>>>>>>>>>                     return -1;
> >>>>>>>>>>> -           if (available_idle_cpu(cpu) || sched_idle_cpu(cpu=
))
> >>>>>>>>>>> -                   break;
> >>>>>>>>>>> +
> >>>>>>>>>>> +           if (available_idle_cpu(cpu) || sched_idle_cpu(cpu=
)) {
> >>>>>>>>>>> +#ifdef CONFIG_SCHED_CORE
> >>>>>>>>>>> +                   /*
> >>>>>>>>>>> +                    * If Core Scheduling is enabled, select =
this cpu
> >>>>>>>>>>> +                    * only if the process cookie matches cor=
e cookie.
> >>>>>>>>>>> +                    */
> >>>>>>>>>>> +                   if (sched_core_enabled(cpu_rq(cpu)) &&
> >>>>>>>>>>> +                       p->core_cookie =3D=3D cpu_rq(cpu)->co=
re->core_cookie)
> >>>>>>>>>> Why not also add similar logic in select_idle_smt to reduce fo=
rced-idle? :)
> >>>>>>>>> We hit select_idle_smt after we scaned the entire LLC domain fo=
r idle cores
> >>>>>>>>> and idle cpus and failed,so IMHO, an idle smt is probably a goo=
d choice under
> >>>>>>>>> this scenario.
> >>>>>>>>
> >>>>>>>> AFAIC, selecting idle sibling with unmatched cookie will cause u=
nnecessary fored-idle, unfairness and latency, compared to choosing *target=
* cpu.
> >>>>>>> Choosing target cpu could increase the runnable task number on th=
e target runqueue, this
> >>>>>>> could trigger busiest->nr_running > 1 logic and makes the idle si=
bling trying to pull but
> >>>>>>> not success(due to cookie not match). Putting task to the idle si=
bling is relatively stable IMHO.
> >>>>>>
> >>>>>> I=E2=80=99m afraid that *unsuccessful* pullings between smts would=
 not result in unstableness, because
> >>>>>> the load-balance always do periodicly , and unsuccess means nothin=
g happen.
> >>>>> unsuccess pulling means more unnecessary overhead in load balance.
> >>>>>
> >>>>>> On the contrary, unmatched sibling tasks running concurrently coul=
d bring forced-idle to each other repeatedly,
> >>>>>> Which is more unstable, and more costly when pick_next_task for al=
l siblings.
> >>>>> Not worse than two tasks ping-pong on the same target run queue I g=
uess, and better if
> >>>>> - task1(cookie A) is running on the target, and task2(cookie B) in =
the runqueue,
> >>>>> - task3(cookie B) coming
> >>>>>
> >>>>> If task3 chooses target's sibling, it could have a chance to run co=
ncurrently with task2.
> >>>>> But if task3 chooses target, it will wait for next pulling luck of =
load balancer
> >>>> That=E2=80=99s more interesting. :)
> >>>> Distributing different cookie tasks onto different cpus(or cpusets) =
could be the *ideal stable status* we want, as I understood.
> >>>> Different cookie tasks running on sibling smts could hurt performanc=
e, and that should be avoided with best effort.
> >>> We already tried to avoid when we scan idle cores and idle cpus in ll=
c domain.
> >>
> >> I=E2=80=99m afraid that=E2=80=99s not enough either, :)
> >> 1. Scanning Idle cpus is not a full scan, there is limit according to =
scan cost.
> >> 2. That's only trying at the *core/cpu* level, *SMT* level should be c=
onsidered too.
> >>
> >>>
> >>>> For above case, selecting idle sibling cpu can improve the concurren=
cy indeed, but it decrease the imbalance for load-balancer.
> >>>> In that case, load-balancer could not notice the imbalance, and woul=
d do nothing to improve the unmatched situation.
> >>>> On the contrary, choosing the *target* cpu could enhance the imbalan=
ce, and load-balancer could try to pull unmatched task away,
> >>> Pulling away to where needs another bunch of elaboration.
> >>
> >> Still with the SMT2+3tasks case,
> >> if *idle sibling* chosen,
> >> Smt1=E2=80=99s load =3D task1+task2, smt2=E2=80=99s load =3D task3. Ta=
sk3 will run intermittently because of forced-idle,
> >> so smt2=E2=80=99s real load could low enough, that it could not be pul=
led away forever. That=E2=80=99s indeed a stable state,
> >> but with performance at a discount.
> >>
> >> If *target sibling* chose,
> >> Smt1=E2=80=99s load =3D task1+task2+task3, smt2=E2=80=99s load=3D0. It=
=E2=80=99s a obvious imbalance, and load-balancer will pick a task to pull,
> >> 1. If task1(cookie A) picked, that=E2=80=99s done for good.
> >> 2. If task2(cookie B) or task3(cookie B) picked, that=E2=80=99s ok too=
, the rest task(cookie B) could be pulled away at next balance(maybe need t=
o improve the pulling to tend to pull matched task more aggressively).
> >> And then, we may reach a more stable state *globally* without performa=
nce discount.
> >
> > I'm not sure what you mean pulled away,
> I mean pulled away by other cpus, may be triggered by idle balance or per=
iodic balance on other cpus.
>
> > - if you mean pulled away from this core, cookieA in idle sibling case =
can be
> >  pulled away too.
> Yep, cookieA(task1) in idle sibling case could be pulled away, but
> cookieB(task3) on the smt2 could never get the chance being pulled
> away(unless being waken up).
> If cookieA(task1) failed being pulled(cookieB(task2) on smt1 may be pulle=
d,
> 50% chance), cookieA(task1) and cookieB(task3) would reach the stable sta=
te
> with performance discount.
>
If you meant pulled away from this core, I didn't see how two cases are
different either. For example, when task2(cookieB) runs on SMT1, task3
cookieb can be pulled to SMT2. and when task1(cookieA) switch onto SMT1,
task2(cookieB) can be pulled away by other cpus, too.

Thanks,
-Aubrey

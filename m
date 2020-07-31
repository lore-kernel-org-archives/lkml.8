Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711F42067D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgGaHmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:42:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:40984 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:42:21 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1k1PgC-0001KE-6a; Fri, 31 Jul 2020 03:42:12 -0400
Message-ID: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
Subject: CFS flat runqueue proposal fixes/update
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>,
        "vincent.guittot" <vincent.guittot@linaro.org>, kernel-team@fb.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggeman" <dietmar.eggeman@arm.com>
Date:   Fri, 31 Jul 2020 03:42:10 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HqUfgquP2LeAlkjHK+wR"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HqUfgquP2LeAlkjHK+wR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

last year at Linux Plumbers conference, I presented on my work
of turning the hierarchical CFS runqueue into a flat runqueue,
and Paul Turner pointed out some corner cases that could not
work with my design as it was last year.

Paul pointed out two corner cases, and I have come up with a
third one myself, but I believe they all revolve around the
same issue, admission control, and can all be solved with the
same solution.

This is a fairly complex thing, so this email is long and
in 3 parts:
- hierarchical runqueue problem statement
- quick design overview of the flat runqueue for CFS
- overview of the problems pointed out by Paul Turner
- description of a possible solution


   hierarchical runqueue problem statement

Currently CFS with the cgroups CPU controller uses a
hierarchical design, which means that a task is enqueued
on its cgroup's runqueu, that cgroup is enqueued on its
parent's runqueue, etc all the way up to the root runqueue.
This also means that every time a task in a cgroup wakes
up or goes to sleep, the common case (1 task on the CPU)
is that the entire hierarchy is enqueued or dequeued,
resulting in significant overhead for workloads with lots
of context switches.

For example, the hierarchy in a system with equal priority
cgroups A and B, with cgroup A subdivided in two unequal
priority cgroups A1 and B2, and a task in each leaf cgroup
would look like this:

        /\
       /  \
      A    B
     / \    \=20
    A1 A2   t3
   /     \
  t1     t2

The common case on most systems is that CPUs are idle
some of the time, and CPUs usually have 0, 1, or 2
running tasks at a time.

That means when task t1 wakes up when the CPU is idle,
t1 first gets enqueued on A1, which then gets enqueued
on A2, which then gets enqueued on the root runqueue.
When t1 goes back to sleep, the whole thing is torn back
down.

In case all three tasks are runnable at the same time,
the scheduler will first choose between A and B in the
root runqueue, and, in case it chose A, between A1 and A2
the next level down.


   CFS flat runqueue design

The code I presented last year operates on the principle
of separating determining hierarchical priority of a task,
which is done periodically, from the runqueues, and using
the hierarchical priority to scale the vruntime of a task
like is done for nice levels.

The hierarchical priority of a tasks is the fraction of
the weight at each level in the runqueue hierarchy of the
path to that task. In the example above, with equal priority
levels for cgroups A, B, A1, and A2, and a total weight 1000
for the root runqueue, tasks t1, t2, and t3 will have hierarchical
weights of 250, 250, and 500 respectively.

CFS tracks both wall clock run time and vruntime for each
task, where vruntime is the wall clock run time scaled
according to the task's priority. The vruntime of every
entity on a runqueue advances at the same rate.

The vruntime is calculated as follows:

 vruntime =3D exec_time * FIXED_POINT_ONE / priority

That is, if the priority of the task is equal to the
fixed point constant used, the vruntime corresponds
to the executed wall clock time, while a lower priority
task has its vruntime advance at a faster rate, and
a higher priority task has its vruntime advance slower.

With every entity on a runqueue having its vruntime
advance at the same rate, that translates into higher
priority tasks receiving more CPU time, and lower
priority tasks receiving less CPU time.


    Problems identified by Paul Turner

Lets revisit the hierarchy from above, and assign priorities
to the cgroups, with the fixed point one being 1000. Lets
say cgroups A, A1, and B have priority 1000, while cgroup
A2 has priority 1.

        /\
       /  \
      A    B
     / \    \=20
    A1 A2   t3
   /     \
  t1     t2

One consequence of this is that when t1, t2, and t3 each
get a time slice, the vruntime of tasks t1 and t3 advances
at roughly the same speed as the clock time, while the
vruntime of task t2 advances 1000x faster.

This is fine if all three tasks continue to be runnable,
since t1, t2 and t3 each get their fair share of CPU time.

However, if t1 goes to sleep, t2 is the only thing running
inside cgroup A, which has the same priority as cgroup B,
and tasks t2 and t3 should be getting the same amount of
CPU time.

They eventually will, but not before task t3 has used up
enough CPU time to catch up with the enormous vruntime
advance that t2 just suffered.

That needs to be fixed, to get near-immediate convergence,
and not convergence after some unknown (potentially long)
period of time.


There are similar issues with thundering herds and cgroup
cpu.max throttling, where a large number of tasks can be
woken up simultaneously.

        /\
       /  \
      A    B
     /      \
    t1    t2 t3 t4 t5 ...
t42

In the current, hierarchical runqueue setup, CFS will
time slice between cgroups A and B at the top level,
which means task t1 will never go long without being
scheduled.  Only the tasks in cgroup B suffer the
latency effects of cgroup B being overloaded with way
too many runnable tasks.

A similar issue can happen when a cgroup is throttled
with cpu.max, and wakes up with a large number of
runnable tasks inside.

It is desirable that fairness, both from a latency and
a throughput point of view, converge quickly rather
than slowly.


    Possible solution

A possible solution to the problems above consists of
three parts:
- Instead of accounting all used wall clock CPU time into
  vruntime immediately, at the task's current hierarchical
  priority, the vruntime can be accounted for piecemeal, for
  example in amounts corresponding to "one timeslice at full
  priority".
- If there is only one runnable task on the runqueue,
  all the runtime can be accounted into vruntime in one go.
- Tasks that cannot account all of their used CPU time
  into vruntime at once can be removed from the root runqueue,
  and placed into the cgroup runqueue. A heap of cgroup
  runqueues with "overloaded" tasks can be attached to the
  main runqueue, where the left-most task from that heap of
  heaps gets some vruntime accounted every time we go into
  pick_next_task.
- The difference between the vruntime of each task in that
  heap and the vruntime of the root runqueue can help determine
  how much vruntime can be accounted to that task at once.
- If the task, or its runqueue, is no longer the left-most
  in the heap after getting vruntime accounted, that runqueue
  and the queue of runqueues can be resorted.
- Once a task has accounted all of its outstanding delta
  exec runtime into vruntime, it can be moved back to the
  main runqueue.
- This should solve the unequal task weight scenario Paul
  Turner pointed out last year, because after task t1 goes
  to sleep and only t2 and t3 remain on the CPU, t2 will
  get its delta exec runtime converted into vruntime at
  its new priority (equal to t3).
- By only accounting delta exec runtime to vruntime for
  the left-most task in the "overloaded" heap at one time,
  we guarantee only one task at a time will be added back
  into the root runqueue.
- Every time a task is added to the root runqueue, that
  slows down the rate at which vruntime advances, which
  in turn reduces the rate at which tasks get added back
  into the runqueue, and makes it more likely that a currently
  running task with low hierarchical priority gets booted
  off into the "overloaded" heap.

To tackle the thundering herd at task wakeup time, another
strategy may be needed. One thing we may be able to do
there is place tasks into the "overloaded" heap immediately
on wakeup, if the hierarchical priority of the task is so
low that if the task were to run a minimal timeslice length,
it would be unable to account that time into its vruntime
in one go, AND the CPU already has a larger number of tasks
on it.

Because the common case on most systems is having just
0, 1, or 2 runnable tasks on a CPU, this fancy scheme
should rarely end up being used, and even when it is the
overhead should be reasonable because most of the
overloaded tasks will just sit there until pick_next_task
gets around to them.

Does this seem like something worth trying out?

Did I overlook any other corner cases that would make this
approach unworkable?

Did I forget to explain anything that is needed to help
understand the problem and the proposed solution better?

--=20
All Rights Reversed.

--=-HqUfgquP2LeAlkjHK+wR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl8jy1IACgkQznnekoTE
3oO38wgAvZOv78rqiHx6QIoBTyA4Xr3b1DUsGxRYlSGcj/OMuXuJFmQJMbwBQw5w
dijJJcUth4QVz+sSAmEaTRAh3+te5YUDZw1NM4ufrHYqIOdueCkCUFQcMtG0GkYr
VsqV9lGvi5SWGdEa4jgPXQA7IaHxVTHa9efgqSdIZwRchwAFv45F8bH675UJAI7k
C7asBJawxLUlKgwcF7zCByyinNnV/OUMR90Ctt+CasOdrDhbDF/3gPiMUQyCIP0N
Colbqt/zOt64wmwkgN7yvqkCiHTdjjH1JJlAp6T+TjtCXEhNcy7rZ9/wbK0PMV7G
P4lcoXFv9hTDZb7eNzMciOJ8svw8HA==
=nC3/
-----END PGP SIGNATURE-----

--=-HqUfgquP2LeAlkjHK+wR--


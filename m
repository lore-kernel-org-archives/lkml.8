Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408F1C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE70A21473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghnakjhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgIGMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgIGMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:37:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D36DC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 05:37:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s205so15977417lja.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 05:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cwPCPEtLET3S/2dbcGHpUnIU95ePzW+j47quR2vi66k=;
        b=ghnakjhgPg51NqpbL4mKUXOhAKH9iYlN+aCVAKDxHPe01brXbyklVs+MbTapmk1aAF
         342zpt+y4wPH6ZV4VCMO7olS9gyjNV5aGmIGpZWw9tn0PHb8tjSasDp6jY4QRrgbyT0N
         eZJH3LkcDNh8KHSjY3dtGBxz2T815OWwuUtND3pXRFXHLoD8CtPQ7jjYqeMWUuWwW9qx
         KuHBjsf5+39yOIHrK17FT66OGA7NR5+Zs3VFWZLL5Z3mEv8iE0bLtyuO5BxTfoNFz4f+
         zUv+8nB0jMMIApd+iB5nxnw1eh+sClsxBn0epvWu9YkMOgY58sGnO7cv29aGsf6A0jRa
         Z2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cwPCPEtLET3S/2dbcGHpUnIU95ePzW+j47quR2vi66k=;
        b=TXEaHPF4SSPkbOc5Xj2baWmdjjE8VWYu9jKCW24sQeSJjb+i8++O24GPQ5M4ILJik9
         dcnCJnme+9qWP4/PM1/5/2iZjoiyxtWPHrmO5xthVcAtW8hSf/hpHHKgZuTqzzGvX2ic
         RJcJoyR9E56DBQ7Y89ZJ3xvR5fvSso8SvB5rL1djnd/+z/fgqmuWFCa1nEd7lODvFRNB
         HbDQF7cxcC3DeFfGOXHVkLshi9yD7W747nmbyunJ/IEHBzI8If6SqFgHOIbprYGiuxe/
         2Ph+rMyHe8GBaQyxxevDZM7L07Hk+4qNd0bBQDqOKix5NP9IzAkjyo6sdHFI0tTS94f8
         jdwQ==
X-Gm-Message-State: AOAM5319vbETdCIbYlRygGFZ0/61OFJT5xXoqhwEkULW6WQwVV+UXOOa
        YrCnH6N+2maPRPjAZYFFYG56D3dE31CUontRae7PvA==
X-Google-Smtp-Source: ABdhPJyhcL++PoFUbugUdIh1EzFFpd3kEua+HBTjPE9mZynQQnAQpNnIwlg9isjHDy6XShUvpnTJgGOdECgZgpix0mo=
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr6077136ljp.177.1599482253662;
 Mon, 07 Sep 2020 05:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <e7b7462375de4175a83ece3b60bab899@hisilicon.com>
In-Reply-To: <e7b7462375de4175a83ece3b60bab899@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 7 Sep 2020 14:37:22 +0200
Message-ID: <CAKfTPtDoL34u3bteN+DckHTcZc7vczf1xeZRiKk6RCev6-Gh3w@mail.gmail.com>
Subject: Re: [RFC] sched/numa: don't move tasks to idle numa nodes while src
 node has very light load?
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 at 14:00, Song Bao Hua (Barry Song)
<song.bao.hua@hisilicon.com> wrote:
>
> Hi All,
> In case we have a numa system with 4 nodes and in each node we have 24 cp=
us, and all of the 96 cores are idle.
> Then we start a process with 4 threads in this totally idle system.
> Actually any one of the four numa nodes should have enough capability to =
run the 4 threads while they can still have 20 idle CPUS after that.
> But right now the existing code in CFS load balance will spread the 4 thr=
eads to multiple nodes.
> This results in two negative side effects:
> 1. more numa nodes are awaken while they can save power in lowest frequen=
cy and halt status
> 2. cache coherency overhead between numa nodes
>
> A proof-of-concept patch I made to "fix" this issue to some extent is lik=
e:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a68a05..f671e15 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9068,9 +9068,20 @@ static inline void calculate_imbalance(struct lb_e=
nv *env, struct sd_lb_stats *s
>                 }
>
>                 /* Consider allowing a small imbalance between NUMA group=
s */
> -               if (env->sd->flags & SD_NUMA)
> +               if (env->sd->flags & SD_NUMA) {
> +                       /* if the src group uses only 1/4 capability and =
dst is idle
> +                        * don't move task
> +                        */
> +                       if (busiest->sum_nr_running <=3D busiest->group_w=
eight/4 &&
> +                                       local->sum_nr_running =3D=3D 0) {
> +                               env->imbalance =3D 0;
> +                               return;

Without considering if that makes sense or not, such tests should be
in adjust_numa_imbalance() which is there to decide if it's worth
"fixing" the imbalance between numa node or not.

The default behavior of load balancer is all about spreading tasks.
Then we have 2 NUMA hooks to prevent this to happen if it doesn't make
sense:
-This adjust_numa_imbalance()
-The fbq_type which is used to skip some rqs

Finally, there were several discussions around adjust_numa_imbalance()
when it was introduced and one was how to define how much imbalance is
allowed that will not regress the performance. The conclusion was that
it depends of a lot of inputs about the topology like the number of
CPUs, the number of nodes, the distance between nodes and several
others things. So as a 1st step, it was decided to use the simple and
current implementation.

The 1/4 threshold that you use above may work for some used cases on
your system but will most probably be wrong for others. We must find
something that is not just a heuristic and can work of other system
too



> +                       }
>                         env->imbalance =3D adjust_numa_imbalance(env->imb=
alance,
>                                                 busiest->sum_nr_running);
> +               }
>
>                 return;
>         }
>
> And I wrote a simple process with 4 threads to measure the execution time=
:
>
> #include <stdio.h>
> #include <pthread.h>
> #include <sys/types.h>
>
> struct foo {
>     int x;
>     int y;
> } f1;
>
> void* thread_fun1(void* param)
> {
>     int s =3D 0;
>     for (int i =3D 0; i < 1000000000; ++i)
>         s +=3D f1.x;
>         return NULL;
> }
>
> void* thread_fun2(void* param)
> {
>     for (int i =3D 0; i < 1000000000; ++i)
>         ++f1.y;
>         return NULL;
> }
>
> double difftimeval(const struct timeval *start, const struct timeval *end=
)
> {
>         double d;
>         time_t s;
>         suseconds_t u;
>
>         s =3D start->tv_sec - end->tv_sec;
>         u =3D start->tv_usec - end->tv_usec;
>
>         d =3D s;
>         d +=3D u/1000000.0;
>
>         return d;
> }
>
> int main(void)
> {
>         pthread_t tid1,tid2,tid3,tid4;
>         struct timeval start,end;
>
>         gettimeofday(&start, NULL);
>
>         pthread_create(&tid1,NULL,thread_fun1,NULL);
>         pthread_create(&tid2,NULL,thread_fun2,NULL);
>         pthread_create(&tid3,NULL,thread_fun1,NULL);
>         pthread_create(&tid4,NULL,thread_fun2,NULL);
>
>         pthread_join(tid1,NULL);
>         pthread_join(tid2,NULL);
>         pthread_join(tid3,NULL);
>         pthread_join(tid4,NULL);
>
>         gettimeofday(&end, NULL);
>
>         printf("execution time:%f\n", difftimeval(&end, &start));
> }
>
> Before the PoC patch, the test result:
> $ ./a.out
> execution time:10.734581
>
> After the PoC patch, the test result:
> $ ./a.out
> execution time:6.775150
>
> The execution time reduces around 30-40% because 4 threads are put in sin=
gle one numa node.
>
> On the other hand, the patch doesn't have to depend on NUMA, it can also =
apply to SCHED_MC with some changes. If one CPU can be still idle after the=
y handle all tasks in the system, we maybe not need to wake up the 2nd CPU =
at all?
>
> I understand this PoC patch could have negative side effect in some corne=
r cases, for example, if the four threads running in one process want more =
memory bandwidth by running in multiple nodes. But generally speaking, we d=
o a tradeoff between cache locality and better CPU utilization as they are =
the main concerns. If one process highly depends on memory bandwidth, they =
may change their mempolicy?
>
> Thanks
> Barry

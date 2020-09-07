Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A482075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgIGMHr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:07:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729199AbgIGMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:00:57 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 47B1B437D911662C7AF1;
        Mon,  7 Sep 2020 20:00:45 +0800 (CST)
Received: from dggemi710-chm.china.huawei.com (10.3.20.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Sep 2020 20:00:10 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi710-chm.china.huawei.com (10.3.20.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 7 Sep 2020 20:00:10 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 7 Sep 2020 20:00:10 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mel Gorman <mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
Subject: [RFC] sched/numa: don't move tasks to idle numa nodes while src node
 has very light load?
Thread-Topic: [RFC] sched/numa: don't move tasks to idle numa nodes while src
 node has very light load?
Thread-Index: AdaFDgJxar2HSiPxTFetuIpaUOKfaA==
Date:   Mon, 7 Sep 2020 12:00:10 +0000
Message-ID: <e7b7462375de4175a83ece3b60bab899@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
In case we have a numa system with 4 nodes and in each node we have 24 cpus, and all of the 96 cores are idle.
Then we start a process with 4 threads in this totally idle system. 
Actually any one of the four numa nodes should have enough capability to run the 4 threads while they can still have 20 idle CPUS after that.
But right now the existing code in CFS load balance will spread the 4 threads to multiple nodes.
This results in two negative side effects:
1. more numa nodes are awaken while they can save power in lowest frequency and halt status
2. cache coherency overhead between numa nodes

A proof-of-concept patch I made to "fix" this issue to some extent is like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..f671e15 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9068,9 +9068,20 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
                }
 
                /* Consider allowing a small imbalance between NUMA groups */
-               if (env->sd->flags & SD_NUMA)
+               if (env->sd->flags & SD_NUMA) {
+                       /* if the src group uses only 1/4 capability and dst is idle
+                        * don't move task
+                        */
+                       if (busiest->sum_nr_running <= busiest->group_weight/4 &&
+                                       local->sum_nr_running == 0) {
+                               env->imbalance = 0;
+                               return;
+                       }
                        env->imbalance = adjust_numa_imbalance(env->imbalance,
                                                busiest->sum_nr_running);
+               }
 
                return;
        }

And I wrote a simple process with 4 threads to measure the execution time:

#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>

struct foo {
    int x;
    int y;
} f1;

void* thread_fun1(void* param)
{
    int s = 0; 
    for (int i = 0; i < 1000000000; ++i)
        s += f1.x;
        return NULL;
}

void* thread_fun2(void* param)
{   
    for (int i = 0; i < 1000000000; ++i)
        ++f1.y;
        return NULL;
}

double difftimeval(const struct timeval *start, const struct timeval *end)
{
        double d;
        time_t s;
        suseconds_t u;

        s = start->tv_sec - end->tv_sec;
        u = start->tv_usec - end->tv_usec;

        d = s;
        d += u/1000000.0;

        return d;
}

int main(void)
{
        pthread_t tid1,tid2,tid3,tid4;
        struct timeval start,end;

        gettimeofday(&start, NULL);

        pthread_create(&tid1,NULL,thread_fun1,NULL);
        pthread_create(&tid2,NULL,thread_fun2,NULL);
        pthread_create(&tid3,NULL,thread_fun1,NULL);
        pthread_create(&tid4,NULL,thread_fun2,NULL);

        pthread_join(tid1,NULL);
        pthread_join(tid2,NULL);
        pthread_join(tid3,NULL);
        pthread_join(tid4,NULL);

        gettimeofday(&end, NULL);

        printf("execution time:%f\n", difftimeval(&end, &start));
}

Before the PoC patch, the test result:
$ ./a.out 
execution time:10.734581

After the PoC patch, the test result:
$ ./a.out 
execution time:6.775150

The execution time reduces around 30-40% because 4 threads are put in single one numa node.

On the other hand, the patch doesn't have to depend on NUMA, it can also apply to SCHED_MC with some changes. If one CPU can be still idle after they handle all tasks in the system, we maybe not need to wake up the 2nd CPU at all?

I understand this PoC patch could have negative side effect in some corner cases, for example, if the four threads running in one process want more memory bandwidth by running in multiple nodes. But generally speaking, we do a tradeoff between cache locality and better CPU utilization as they are the main concerns. If one process highly depends on memory bandwidth, they may change their mempolicy?

Thanks
Barry

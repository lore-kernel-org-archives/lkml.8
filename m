Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6195CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4891F206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgEFKzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:55:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgEFKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:55:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219D81FB;
        Wed,  6 May 2020 03:55:01 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54843F71F;
        Wed,  6 May 2020 03:54:58 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] sched/deadline: Add dl_bw_capacity()
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-4-dietmar.eggemann@arm.com>
Message-ID: <23bde551-0d91-4bfe-ce65-40af9fbfdef9@arm.com>
Date:   Wed, 6 May 2020 12:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427083709.30262-4-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 10:37, Dietmar Eggemann wrote:

[...]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4ae22bfc37ae..eb23e6921d94 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -69,6 +69,25 @@ static inline int dl_bw_cpus(int i)
>  
>  	return cpus;
>  }
> +
> +static inline unsigned long dl_bw_capacity(int i)
> +{
> +	struct root_domain *rd = cpu_rq(i)->rd;
> +	unsigned long cap;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
> +			 "sched RCU must be held");
> +
> +	if (cpumask_subset(rd->span, cpu_active_mask))
> +		return rd->sum_cpu_capacity;
> +
> +	cap = 0;
> +
> +	for_each_cpu_and(i, rd->span, cpu_active_mask)
> +		cap += capacity_orig_of(i);
> +
> +	return cap;
> +}

There is an issue w/ excl. cpusets and cpuset.sched_load_balance=0. The
latter is needed to demonstrate the problem since DL task affinity can't
be altered.

A CPU in such a cpuset has its rq attached to def_root_domain which does
not have its 'sum_cpu_capacity' properly set.

root@juno:~# bash
root@juno:~# ps -eo comm,pid,class | grep bash
bash             1661 TS
bash             2040 TS
bash             2176 TS <--

root@juno:~# echo 2176 > /sys/fs/cgroup/cpuset/B/tasks 

root@juno:~# chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 2176
chrt: failed to set pid 2176's policy: Device or resource busy

...
sched_dl_overflow: [bash 2176] task_cpu=4 cpus_ptr=2,4-5
dl_bw_capacity() CPU4 dflt_rd->sum_cpu_capacity=0 <-- !!! dflt_rd->span=2,4-5 cpu_active_mask=0-5
...

OTHA, rd->span is properly set due to 'cpumask_clear_cpu(rq->cpu,
old_rd->span) and cpumask_set_cpu(rq->cpu, rd->span)' in rq_attach_root().

It's not possible to treat 'rd->sum_cpu_capacity' like 'rd->span' since
the former changes between sched domain teardown/bringup w/ asymmetric
CPU capacity.

What could be done is to return 'dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT'
w/ symmetric CPU capacity (of 1024) and to loop over rd->span otherwise.
Latter includes symmetric cpusets w/ only little CPUs. 

---8<---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 575b7d88d839..6d17748cb7a1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -70,24 +70,28 @@ static inline int dl_bw_cpus(int i)
 	return cpus;
 }
 
-static inline unsigned long dl_bw_capacity(int i)
-{
+static inline unsigned long __dl_bw_capacity(int i) {
 	struct root_domain *rd = cpu_rq(i)->rd;
-	unsigned long cap;
+	unsigned long cap = 0;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
 
-	if (cpumask_subset(rd->span, cpu_active_mask))
-		return rd->sum_cpu_capacity;
-
-	cap = 0;
-
 	for_each_cpu_and(i, rd->span, cpu_active_mask)
 		cap += capacity_orig_of(i);
 
 	return cap;
 }
+
+static inline unsigned long dl_bw_capacity(int i)
+{
+	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
+	    capacity_orig_of(i) == SCHED_CAPACITY_SCALE) {
+		return dl_bw_cpus(i) << SCHED_CAPACITY_SHIFT;
+	} else {
+		return __dl_bw_capacity(i);
+	}
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
-- 
2.17.1

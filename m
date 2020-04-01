Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABABC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9224E2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgDANXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:23:44 -0400
Received: from foss.arm.com ([217.140.110.172]:51680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732703AbgDANXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:23:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A67C430E;
        Wed,  1 Apr 2020 06:23:43 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D8643F71E;
        Wed,  1 Apr 2020 06:23:40 -0700 (PDT)
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com> <20200401114215.36640-1-cj.chengjian@huawei.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     vpillai@digitalocean.com, aaron.lwe@gmail.com,
        aubrey.intel@gmail.com, aubrey.li@linux.intel.com,
        fweisbec@gmail.com, jdesfossez@digitalocean.com,
        joel@joelfernandes.org, joelaf@google.com, keescook@chromium.org,
        kerrnel@google.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        naravamudan@digitalocean.com, pauld@redhat.com,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        peterz@infradead.org, pjt@google.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        xiexiuqi@huawei.com, huawei.libin@huawei.com, w.f@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] sched/arm64: store cpu topology before notify_cpu_starting
In-reply-to: <20200401114215.36640-1-cj.chengjian@huawei.com>
Date:   Wed, 01 Apr 2020 14:23:33 +0100
Message-ID: <jhjwo6zjq5m.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(+LAKML, +Sudeep)

On Wed, Apr 01 2020, Cheng Jian wrote:
> when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
> SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
> the thread_sibling is ready for use.
>
>       notify_cpu_starting()
>           -> sched_cpu_starting()	# use thread_sibling
>
>       store_cpu_topology(cpu)
>           -> update_siblings_masks	# set thread_sibling
>
> Fix this by doing notify_cpu_starting later, just like x86 do.
>

I haven't been following the sched core stuff closely; can't this
rq->core assignment be done in sched_cpu_activate() instead? We already
look at the cpu_smt_mask() in there, and it is valid (we go through the
entirety of secondary_start_kernel() before getting anywhere near
CPUHP_AP_ACTIVE).

I don't think this breaks anything, but without this dependency in
sched_cpu_starting() then there isn't really a reason for this move.

> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 5407bf5d98ac..a427c14e82af 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -236,13 +236,18 @@ asmlinkage notrace void secondary_start_kernel(void)
>       cpuinfo_store_cpu();
>
>       /*
> -	 * Enable GIC and timers.
> +	 * Store cpu topology before notify_cpu_starting,
> +	 * CPUHP_AP_SCHED_STARTING requires SMT topology
> +	 * been initialized for SCHED_CORE.
>        */
> -	notify_cpu_starting(cpu);
> -
>       store_cpu_topology(cpu);
>       numa_add_cpu(cpu);
>
> +	/*
> +	 * Enable GIC and timers.
> +	 */
> +	notify_cpu_starting(cpu);
> +
>       /*
>        * OK, now it's safe to let the boot CPU continue.  Wait for
>        * the CPU migration code to notice that the CPU is online

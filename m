Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277D3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060BE20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDIKcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:32:22 -0400
Received: from foss.arm.com ([217.140.110.172]:48316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIKcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:32:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312DF31B;
        Thu,  9 Apr 2020 03:32:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE0FD3F73D;
        Thu,  9 Apr 2020 03:32:18 -0700 (PDT)
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com> <20200401114215.36640-1-cj.chengjian@huawei.com> <jhjwo6zjq5m.mognet@arm.com> <20200409095941.GA25948@bogus>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cheng Jian <cj.chengjian@huawei.com>, vpillai@digitalocean.com,
        aaron.lwe@gmail.com, aubrey.intel@gmail.com,
        aubrey.li@linux.intel.com, fweisbec@gmail.com,
        jdesfossez@digitalocean.com, joel@joelfernandes.org,
        joelaf@google.com, keescook@chromium.org, kerrnel@google.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, naravamudan@digitalocean.com, pauld@redhat.com,
        pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com,
        peterz@infradead.org, pjt@google.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        xiexiuqi@huawei.com, huawei.libin@huawei.com, w.f@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] sched/arm64: store cpu topology before notify_cpu_starting
In-reply-to: <20200409095941.GA25948@bogus>
Date:   Thu, 09 Apr 2020 11:32:12 +0100
Message-ID: <jhj5ze9t0er.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/04/20 10:59, Sudeep Holla wrote:
> On Wed, Apr 01, 2020 at 02:23:33PM +0100, Valentin Schneider wrote:
>>
>> (+LAKML, +Sudeep)
>>
>
> Thanks Valentin.
>
>> On Wed, Apr 01 2020, Cheng Jian wrote:
>> > when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
>> > SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
>> > the thread_sibling is ready for use.
>> >
>> >       notify_cpu_starting()
>> >           -> sched_cpu_starting()	# use thread_sibling
>> >
>> >       store_cpu_topology(cpu)
>> >           -> update_siblings_masks	# set thread_sibling
>> >
>> > Fix this by doing notify_cpu_starting later, just like x86 do.
>> >
>>
>> I haven't been following the sched core stuff closely; can't this
>> rq->core assignment be done in sched_cpu_activate() instead? We already
>> look at the cpu_smt_mask() in there, and it is valid (we go through the
>> entirety of secondary_start_kernel() before getting anywhere near
>> CPUHP_AP_ACTIVE).
>>
>
> I too came to same conclusion. Did you see any issues ? Or is it
> just code inspection in parity with x86 ?
>

With mainline this isn't a problem; with the core scheduling stuff there is
an expectation that we can use the SMT masks in sched_cpu_starting().

>> I don't think this breaks anything, but without this dependency in
>> sched_cpu_starting() then there isn't really a reason for this move.
>>
>
> Based on the commit message, had a quick look at x86 code and I agree
> this shouldn't break anything. However the commit message does make
> complete sense to me, especially reference to sched_cpu_starting
> while smt_masks are accessed in sched_cpu_activate. Or am I missing
> to understand something here ?

As stated above, it's not a problem for mainline, and AIUI we can change
the core scheduling bits to only use the SMT mask in sched_cpu_activate()
instead, therefore not requiring any change in the arch code.

I'm not aware of any written rule that the topology masks should be usable
from a given hotplug state upwards, only that right now we need them in
sched_cpu_(de)activate() for SMT scheduling - and that is already working
fine.

So really this should be considering as a simple neutral cleanup; I don't
really have any opinion on picking it up or not.

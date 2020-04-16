Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4737C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8681F22242
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395183AbgDPP1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:27:44 -0400
Received: from foss.arm.com ([217.140.110.172]:35904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395240AbgDPP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:27:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C115B30E;
        Thu, 16 Apr 2020 08:27:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035633F237;
        Thu, 16 Apr 2020 08:27:36 -0700 (PDT)
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-10-valentin.schneider@arm.com> <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com> <jhj4ktjpw2z.mognet@arm.com> <d508a6a5-c04f-087f-8767-6fb397b70055@arm.com> <CAKfTPtD5x_NQ1KfHhTiAR3eNA85+k13nfSR-9_PKLp6FgVu08A@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
In-reply-to: <CAKfTPtD5x_NQ1KfHhTiAR3eNA85+k13nfSR-9_PKLp6FgVu08A@mail.gmail.com>
Date:   Thu, 16 Apr 2020 16:27:32 +0100
Message-ID: <jhjv9lz78nv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/04/20 14:36, Vincent Guittot wrote:
>> Coming back to the v2 discussion on this patch
>>
>> https://lore.kernel.org/r/20200311181601.18314-10-valentin.schneider@arm.com
>>
>> SD_BALANCE_WAKE is not used in mainline anymore, so wakeups are always
>> fast today.
>>
>> I.e. you wouldn't need a per_cpu(sd_balance_wake, cpu) since it's always
>> NULL.
>>
>> I.e. want_affine logic and the 'for_each_domain(cpu, tmp)' isn't needed
>> anymore.
>>
>> This will dramatically simplify the code in select_task_rq_fair().
>>
>> But I guess Vincent wants to keep the functionality so we're able to
>> enable SD_BALANCE_WAKE on certain sd's?
>
> I looked too quickly what was done by this patch. I thought that it
> was adding a per_cpu pointer for all cases including the fast path
> with wake affine but it only skips the for_each_domain loop for the
> slow paths which don't need it because they are already slow.
>
> It would be better to keep the for_each_domain loop for slow paths and
> to use a per_cpu pointer for fast_path/wake affine. Regarding the
> wake_affine path, we don't really care about looping all domains and
> we could directly use the highest domain because wake_affine() that is
> used in the loop, only uses the imbalance_pct of the sched domain for
> wake_affine_weight() and it should not harm to use only the highest
> domain and then select_idle_sibling doesn't use it but the llc or
> asym_capacity pointer instead.

So Dietmar's pointing out that sd will always be NULL for want_affine,
because want_affine can only be true at wakeups and we don't have any
topologies with SD_BALANCE_WAKE anymore. We would still want to call
wake_affine() though, because that can change new_cpu.

What you are adding on top is that the only sd field used in wake_affine()
is the imbalance_pct, so we could take a shortcut and just go for the
highest domain with SD_WAKE_AFFINE; i.e. something like this:

---
if (want_affine) {
        // We can cache that at topology buildup
        sd = highest_flag_domain(cpu, SD_WAKE_AFFINE);

        if (cpumask_test_cpu(prev_cpu, sched_domain_span(sd) &&
            cpu != prev_cpu)
                new_cpu = wake_affine();

        // Directly go to select_idle_sibling()
        goto sis;
}

// !want_affine logic here
---

As for the !want_affine part, we could either keep the current domain walk
(IIUC this is what you are suggesting) or go for the extra cached pointers
I'm introducing.

Now if we are a bit bolder than that, because there are no more
(mainline) topologies w/ SD_BALANCE_WAKE, we could even turn the above
into:

---
if (wake_flags & WF_TTWU) {
        if (want_affine) {
                // We can cache that at topology buildup
                sd = highest_flag_domain(cpu, SD_WAKE_AFFINE);

                if (cpumask_test_cpu(prev_cpu, sched_domain_span(sd) &&
                    cpu != prev_cpu)
                        new_cpu = wake_affine();

        }
        // Directly go to select_idle_sibling()
        goto sis;
}

// !want_affine logic here
---

This in turns mean we could get rid of SD_BALANCE_WAKE entirely... I'm a
bit more reluctant to that only because the last SD_BALANCE_WAKE setter was
removed fairly recently, see
  a526d466798d ("sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems")

Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00310206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgDPUy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:54:59 -0400
Received: from foss.arm.com ([217.140.110.172]:41368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgDPUy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:54:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C7F30E;
        Thu, 16 Apr 2020 13:54:58 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B9BE3F237;
        Thu, 16 Apr 2020 13:54:57 -0700 (PDT)
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200415210512.805-10-valentin.schneider@arm.com> <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com> <jhj4ktjpw2z.mognet@arm.com> <d508a6a5-c04f-087f-8767-6fb397b70055@arm.com> <CAKfTPtD5x_NQ1KfHhTiAR3eNA85+k13nfSR-9_PKLp6FgVu08A@mail.gmail.com> <jhjv9lz78nv.mognet@arm.com> <CAKfTPtDFD7KMcSK-2_LP-_APN2m05pWVhzKvJOVnD+Nacn846w@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
In-reply-to: <CAKfTPtDFD7KMcSK-2_LP-_APN2m05pWVhzKvJOVnD+Nacn846w@mail.gmail.com>
Date:   Thu, 16 Apr 2020 21:54:52 +0100
Message-ID: <jhjsgh36tib.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/04/20 16:58, Vincent Guittot wrote:
>> ---
>> if (wake_flags & WF_TTWU) {
>>         if (want_affine) {
>>                 // We can cache that at topology buildup
>>                 sd = highest_flag_domain(cpu, SD_WAKE_AFFINE);
>>
>>                 if (cpumask_test_cpu(prev_cpu, sched_domain_span(sd) &&
>>                     cpu != prev_cpu)
>>                         new_cpu = wake_affine();
>>
>>         }
>>         // Directly go to select_idle_sibling()
>>         goto sis;
>> }
>>
>> // !want_affine logic here
>> ---
>>
>> This in turns mean we could get rid of SD_BALANCE_WAKE entirely... I'm a
>> bit more reluctant to that only because the last SD_BALANCE_WAKE setter was
>
> For now, we should probably skip the additional test above: "if
> (wake_flags & WF_TTWU) {" and keep SD_BALANCE_WAKE so we will continue
> to loop in case of !want_affine.
>
> We can imagine that we might want at the end to be a bit more smart
> for SD_BALANCE_WAKE and the slow path... like with the latency nice
> proposal and latency-nice=19 as a example
>

Good point. I'll go for the first option and see where I end up; I'd like
to cache the other domain pointers if possible, I'll do some benchmarking
and see if I can do that without another switch case.

>> removed fairly recently, see
>>   a526d466798d ("sched/topology: Remove SD_BALANCE_WAKE on asymmetric capacity systems")

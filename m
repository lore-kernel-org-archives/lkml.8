Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD2FC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A7D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894846AbgDPNE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:04:29 -0400
Received: from foss.arm.com ([217.140.110.172]:60510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894786AbgDPNEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:04:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A79F61FB;
        Thu, 16 Apr 2020 06:04:24 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8EB53F68F;
        Thu, 16 Apr 2020 06:04:23 -0700 (PDT)
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers
 for wakeup sd_flag scan
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200415210512.805-1-valentin.schneider@arm.com>
 <20200415210512.805-10-valentin.schneider@arm.com>
 <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com>
 <jhj4ktjpw2z.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d508a6a5-c04f-087f-8767-6fb397b70055@arm.com>
Date:   Thu, 16 Apr 2020 15:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <jhj4ktjpw2z.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.20 12:24, Valentin Schneider wrote:
> 
> On 16/04/20 08:46, Vincent Guittot wrote:
>>> @@ -6657,7 +6646,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>>
>>>         rcu_read_lock();
>>>
>>> -       sd = highest_flag_domain(cpu, sd_flag);
>>> +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
>>> +       case WF_TTWU:
>>> +               sd_flag = SD_BALANCE_WAKE;
>>> +               sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));
>>
>> It's worth having a direct pointer for the fast path which we always
>> try to keep short but the other paths are already slow and will not
>> get any benefit of this per cpu pointer.
>> We should keep the loop for the slow paths
>>
> 
> Which fast/slow paths are you referring to here? want_affine vs
> !want_affine? If so, do you then mean that we should do the switch case
> only when !want_affine, and otherwise look for the domain via the
> for_each_domain() loop?

Coming back to the v2 discussion on this patch

https://lore.kernel.org/r/20200311181601.18314-10-valentin.schneider@arm.com

SD_BALANCE_WAKE is not used in mainline anymore, so wakeups are always
fast today.

I.e. you wouldn't need a per_cpu(sd_balance_wake, cpu) since it's always
NULL.

I.e. want_affine logic and the 'for_each_domain(cpu, tmp)' isn't needed
anymore.

This will dramatically simplify the code in select_task_rq_fair().

But I guess Vincent wants to keep the functionality so we're able to
enable SD_BALANCE_WAKE on certain sd's?

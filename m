Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98810C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C40F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCSMXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:34410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbgCSMXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:23:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDBA731B;
        Thu, 19 Mar 2020 05:23:22 -0700 (PDT)
Received: from e113632-lin (unknown [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ECD93F305;
        Thu, 19 Mar 2020 05:23:21 -0700 (PDT)
References: <20200311181601.18314-1-valentin.schneider@arm.com> <20200311181601.18314-10-valentin.schneider@arm.com> <53763a32-0ce5-e267-9d5d-99e65c921d08@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 9/9] sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
In-reply-to: <53763a32-0ce5-e267-9d5d-99e65c921d08@arm.com>
Date:   Thu, 19 Mar 2020 12:22:34 +0000
Message-ID: <jhj8sjwilf9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 19 2020, Dietmar Eggemann wrote:
> On 11.03.20 19:16, Valentin Schneider wrote:
>> @@ -6621,7 +6610,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>
>>      rcu_read_lock();
>>
>> -	sd = highest_flag_domain(cpu, sd_flag);
>> +	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
>> +	case WF_TTWU:
>> +		sd_flag = SD_BALANCE_WAKE;
>> +		sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));
>
> IMHO, since we hard-code 0*SD_BALANCE_WAKE in sd_init(), sd would always
> be NULL, so !want_affine (i.e. wake_wide()) would still go sis().
>
> SD_BALANCE_WAKE is no a topology related sd_flag so it can't be set from
> outside. Since the sd->flags sysctl is now read-only, wouldn't this case
> be redundant?
>

On a purely mainline kernel, yes, 'sd' will always be NULL for
wakeups. I'm playing a bit more conservative here with SD_BALANCE_WAKE,
as I could see some folks using that flag in some ~franken~ downstream
kernels (I am not aware of any, however).

Also, to be fair we've only very recently gotten rid of the last
SD_BALANCE_WAKE user (asymmetric CPU capacity topologies), so I felt
like keeping it around for a bit before entirely killing it would be a
sane thing to do.

> [...]

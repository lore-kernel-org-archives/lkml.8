Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35C920663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCSMHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:07:12 -0400
Received: from foss.arm.com ([217.140.110.172]:34092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSMHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:07:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 846EE31B;
        Thu, 19 Mar 2020 05:07:11 -0700 (PDT)
Received: from e113632-lin (unknown [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAB883F305;
        Thu, 19 Mar 2020 05:07:10 -0700 (PDT)
References: <20200311181601.18314-1-valentin.schneider@arm.com> <20200311181601.18314-9-valentin.schneider@arm.com> <c0a1f683-f5c5-cd95-a586-28cc1da9fc3d@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 8/9] sched/fair: Split select_task_rq_fair want_affine logic
In-reply-to: <c0a1f683-f5c5-cd95-a586-28cc1da9fc3d@arm.com>
Date:   Thu, 19 Mar 2020 12:06:48 +0000
Message-ID: <jhjsgi4o8fb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 19 2020, Dietmar Eggemann wrote:
>> +	 */
>>      for_each_domain(cpu, tmp) {
>> -		/*
>> -		 * If both 'cpu' and 'prev_cpu' are part of this domain,
>> -		 * cpu is a valid SD_WAKE_AFFINE target.
>> -		 */
>> -		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
>> +		if ((tmp->flags & SD_WAKE_AFFINE) &&
>>                  cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
>>                      if (cpu != prev_cpu)
>>                              new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
>>
>> -			sd = NULL; /* Prefer wake_affine over balance flags */
>> +			/* Prefer wake_affine over SD lookup */
>
> I assume that 'balance flags' stands for (wakeup) load balance, i.e.
> find_idlest_xxx() path. So why change it?
>
>

You mean the comment part, right? I was hoping to clarify it a bit - if
we go through the want_affine condition, we'll override whatever SD we
picked with the highest_flag_domain() lookup (and the cached version in
9/9). Hence me referring to the SD lookup there.

> [...]

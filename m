Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07756C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8CA20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgFRIv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:51:28 -0400
Received: from foss.arm.com ([217.140.110.172]:46330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgFRIv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:51:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3579931B;
        Thu, 18 Jun 2020 01:51:26 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A010F3F6CF;
        Thu, 18 Jun 2020 01:51:24 -0700 (PDT)
References: <20200617121742.cpxppyi7twxmpin7@linutronix.de> <jhjmu51eq2k.mognet@arm.com> <696309d91635fa965ad8436388e7ae7d098420a1.camel@redhat.com> <20200618080700.cig4x4y7n3thmneu@linutronix.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Scott Wood <swood@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: __set_cpus_allowed_ptr(): Check cpus_mask, not cpus_ptr
In-reply-to: <20200618080700.cig4x4y7n3thmneu@linutronix.de>
Date:   Thu, 18 Jun 2020 09:51:18 +0100
Message-ID: <jhj366seozd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/20 09:07, Sebastian Andrzej Siewior wrote:
> On 2020-06-17 17:49:48 [-0500], Scott Wood wrote:
>> > Makes sense, but what about the rest of the checks? Further down there is
>> >
>> >         /* Can the task run on the task's current CPU? If so, we're done
>> > */
>> >         if (cpumask_test_cpu(task_cpu(p), new_mask))
>> >                 goto out;
>> >
>> > If the task is currently migrate disabled and for some stupid reason it
>> > gets affined elsewhere, we could try to move it out - which AFAICT we
>> > don't
>> > want to do because migrate disabled. So I suppose you'd want an extra
>> > bailout condition here when the task is migrate disabled.
>> >
>> > ISTR in RT you do re-check the affinity and potentially move the task away
>> > when re-enabling migration, so that should work out all fine.
>>
>> On RT the above test is:
>>
>>         /* Can the task run on the task's current CPU? If so, we're done */
>>         if (cpumask_test_cpu(task_cpu(p), new_mask) ||
>>             p->cpus_ptr != &p->cpus_mask)
>>                 goto out;
>>
>> ...so we do bail out if we're migrate disabled.
>
> correct. There is a complete migrate_disable() patch in the RT queue
> which has to wait. This patch however looked to be independent of that
> and could "fix" the pointer part which is already here so I sent it.
>

Okay, thanks. I don't see any harm in including that extra check with the
patch, but either way:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>> -Scott
>
> Sebastian

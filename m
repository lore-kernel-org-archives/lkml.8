Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B2C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A32075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgD0Q63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:58:29 -0400
Received: from foss.arm.com ([217.140.110.172]:38340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0Q63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:58:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02F481063;
        Mon, 27 Apr 2020 09:58:29 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E8A3F68F;
        Mon, 27 Apr 2020 09:58:27 -0700 (PDT)
References: <20200422112719.826676174@infradead.org> <20200422112831.574539982@infradead.org> <20200427163540.45wrw5kaakxzrokj@e107158-lin>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com
Subject: Re: [PATCH 06/23] sched,psci: Convert to sched_set_fifo*()
In-reply-to: <20200427163540.45wrw5kaakxzrokj@e107158-lin>
Date:   Mon, 27 Apr 2020 17:58:15 +0100
Message-ID: <jhjk120sw60.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/04/20 17:35, Qais Yousef wrote:
>>      drv = cpuidle_get_cpu_driver(dev);
>> @@ -349,11 +347,6 @@ static int suspend_test_thread(void *arg
>>      if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
>>              complete(&suspend_threads_done);
>>
>> -	/* Give up on RT scheduling and wait for termination. */
>> -	sched_priority.sched_priority = 0;
>> -	if (sched_setscheduler_nocheck(current, SCHED_NORMAL, &sched_priority))
>> -		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
>> -			cpu);
>
> No need for sched_set_normal() here before the busy loop?
>

Given the tasks become TASK_INTERRUPTIBLE, and the only extra thing they'll
do is exit (barring the parking weirdness), changing them back to CFS
seems superfluous.

> Thanks

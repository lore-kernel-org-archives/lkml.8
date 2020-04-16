Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2512C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7ED421D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506474AbgDPLhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:37:40 -0400
Received: from foss.arm.com ([217.140.110.172]:58854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505814AbgDPLCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:02:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B761063;
        Thu, 16 Apr 2020 04:02:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E4393F73D;
        Thu, 16 Apr 2020 04:02:53 -0700 (PDT)
References: <20200415210512.805-1-valentin.schneider@arm.com> <20200416105828.GN20730@hirez.programming.kicks-ass.net> <20200416110056.GT20760@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 0/9] sched: Streamline select_task_rq() & select_task_rq_fair()
In-reply-to: <20200416110056.GT20760@hirez.programming.kicks-ass.net>
Date:   Thu, 16 Apr 2020 12:02:51 +0100
Message-ID: <jhj3693puas.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/04/20 12:00, Peter Zijlstra wrote:
> On Thu, Apr 16, 2020 at 12:58:28PM +0200, Peter Zijlstra wrote:
>> On Wed, Apr 15, 2020 at 10:05:03PM +0100, Valentin Schneider wrote:
>> > Valentin Schneider (9):
>> >   sched/fair: find_idlest_group(): Remove unused sd_flag parameter
>> >   sched/debug: Make sd->flags sysctl read-only
>> >   sched: Remove checks against SD_LOAD_BALANCE
>> >   sched/topology: Kill SD_LOAD_BALANCE
>> >   sched: Add WF_TTWU, WF_EXEC wakeup flags
>>
>> How about I queue two first 5, and you rework these last few?
>
> Argh, 4 ofcourse, that 5th patch doesn't make much sense if we have to
> rework those flags like I proposed.
>

Was about to comment on that :) Sounds good to me!

>> >   sched: Kill select_task_rq()'s sd_flag parameter
>> >   sched/fair: Dissociate wakeup decisions from SD flag value
>> >   sched/fair: Split select_task_rq_fair want_affine logic
>> >   sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
>>
>>

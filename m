Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89BD20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgCCKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:08:49 -0500
Received: from foss.arm.com ([217.140.110.172]:45008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgCCKIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:08:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE82FEC;
        Tue,  3 Mar 2020 02:08:48 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C21F3F6C4;
        Tue,  3 Mar 2020 02:08:47 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix kernel build warning in test_idle_cores()
 for !SMT NUMA
To:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20200227140222.GH3818@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <19447f16-d42d-2e89-c431-71c14d1151bd@arm.com>
Date:   Tue, 3 Mar 2020 10:08:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227140222.GH3818@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 2:02 PM, Mel Gorman wrote:
> Building against tip/sched/core as of as ff7db0bf24db ("sched/numa: Prefer
> using an idle CPU as a migration target instead of comparing tasks") with
> the arm64 defconfig (which doesn't have CONFIG_SCHED_SMT set) leads to:
> 
>   kernel/sched/fair.c:1525:20: warning: ‘test_idle_cores’ declared ‘static’ but never defined [-Wunused-function]
                                          ^               ^          ^      ^
For some reason the quotes got turned into � in your edit. Doesn't really
matter TBH.

>    static inline bool test_idle_cores(int cpu, bool def);
> 		      ^~~~~~~~~~~~~~~
> 
> Rather than define it in its own CONFIG_SCHED_SMT #define island, bunch it
> up with test_idle_cores().
> 
> Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
> [mgorman@techsingularity.net: Edit changelog, minor style change]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Could we get this in tip (and hopefully -next will follow shortly)? We're at
like the third duplicate fix on the list already.

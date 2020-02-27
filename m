Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CCC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB02469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgB0P05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:26:57 -0500
Received: from foss.arm.com ([217.140.110.172]:53662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgB0P05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:26:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DADC230E;
        Thu, 27 Feb 2020 07:26:56 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDA153F7B4;
        Thu, 27 Feb 2020 07:26:55 -0800 (PST)
References: <1582812549.7365.134.camel@lca.pw> <1582814862.7365.135.camel@lca.pw>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: suspicious RCU due to "Prefer using an idle CPU as a migration target instead of comparing tasks"
In-reply-to: <1582814862.7365.135.camel@lca.pw>
Date:   Thu, 27 Feb 2020 15:26:41 +0000
Message-ID: <jhjimjsvyoe.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Feb 27 2020, Qian Cai wrote:

> On Thu, 2020-02-27 at 09:09 -0500, Qian Cai wrote:
>> The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
>> migration target instead of comparing tasks") introduced a boot warning,
>
> This?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a61d83ea2930..ca780cd1eae2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1607,7 +1607,9 @@ static void update_numa_stats(struct task_numa_env *env,
> if (ns->idle_cpu == -1)
> ns->idle_cpu = cpu;
>
> +rcu_read_lock();
> idle_core = numa_idle_core(idle_core, cpu);
> +rcu_read_unlock();
> }
> }
>


Hmph right, we have
numa_idle_core()->test_idle_cores()->rcu_dereference().

Dunno if it's preferable to wrap the entirety of update_numa_stats() or
if that fine-grained read-side section is ok.

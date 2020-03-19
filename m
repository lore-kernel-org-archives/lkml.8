Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78442C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556B920663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCSMF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:05:56 -0400
Received: from foss.arm.com ([217.140.110.172]:34060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSMFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:05:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3215231B;
        Thu, 19 Mar 2020 05:05:55 -0700 (PDT)
Received: from e113632-lin (unknown [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6843A3F305;
        Thu, 19 Mar 2020 05:05:54 -0700 (PDT)
References: <20200311181601.18314-1-valentin.schneider@arm.com> <20200311181601.18314-4-valentin.schneider@arm.com> <c74a32d9-e40c-b976-be19-9ceea91d6fa7@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 3/9] sched: Remove checks against SD_LOAD_BALANCE
In-reply-to: <c74a32d9-e40c-b976-be19-9ceea91d6fa7@arm.com>
Date:   Thu, 19 Mar 2020 12:05:32 +0000
Message-ID: <jhjv9n0o8hf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 19 2020, Dietmar Eggemann wrote:
> On 11.03.20 19:15, Valentin Schneider wrote:
>> Potential users of that flag could have been cpusets and isolcpus.
>>
>> cpusets don't need it because they define exclusive (i.e. non-overlapping)
>> domain spans, see cpuset.cpu_exclusive and cpuset.sched_load_balance.
>> If such a cpuset contains a single CPU, it will have the NULL domain
>> attached to it. If it contains several CPUs, none of their domains will
>> extend beyond the span of the cpuset.
>
> There are also non-exclusive cpusets but I assume the statement is the same.
>

Right, AFAICT the cpuset.cpu_exclusive thing doesn't actually impact the
sched_domains, only how CPUs can be allocated to cpusets. The important
bits are:

- the CPUs spanned by the cpuset
- Whether we have cpuset.sched_load_balance

> CPUs which are only used in cpusets with cpuset.sched_load_balance=0 are
> attached to the NULL sched-domain.
>

Indeed, I was only considering the case with root.sched_load_balance=0
and the siblings would have cpuset.sched_load_balance=1, in which case
we get separate root domains. If !root cpusets have
sched_load_balance=0, related CPUs will only get the NULL domain
attached to them.

> There seems to be no code which alters the SD_LOAD_BALANCE flag.
>

The sysctl interface would've been the last possible modifier.

Your comments make me realize that changelog isn't great, what about the
following?

---

The SD_LOAD_BALANCE flag is set unconditionally for all domains in
sd_init(). By making the sched_domain->flags syctl interface read-only, we
have removed the last piece of code that could clear that flag - as such,
it will now be always present. Rather than to keep carrying it along, we
can work towards getting rid of it entirely.

cpusets don't need it because they can make CPUs be attached to the NULL
domain (e.g. cpuset with sched_load_balance=0), or to a partitionned
root_domain, i.e. a sched_domain hierarchy that doesn't span the entire
system (e.g. root cpuset with sched_load_balance=0 and sibling cpusets with
sched_load_balance=1).

isolcpus apply the same "trick": isolated CPUs are explicitly taken out of
the sched_domain rebuild (using housekeeping_cpumask()), so they get the
NULL domain treatment as well.

Remove the checks against SD_LOAD_BALANCE.

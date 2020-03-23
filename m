Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8303620722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgCWRRq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:17:46 -0400
Received: from foss.arm.com ([217.140.110.172]:52280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgCWRRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:17:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FF781FB;
        Mon, 23 Mar 2020 10:17:45 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C873F7C3;
        Mon, 23 Mar 2020 10:17:44 -0700 (PDT)
References: <20200311181601.18314-1-valentin.schneider@arm.com> <20200311181601.18314-4-valentin.schneider@arm.com> <c74a32d9-e40c-b976-be19-9ceea91d6fa7@arm.com> <jhjv9n0o8hf.mognet@arm.com> <5decd96b-6fe0-3c35-4609-59378a0c8621@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 3/9] sched: Remove checks against SD_LOAD_BALANCE
In-reply-to: <5decd96b-6fe0-3c35-4609-59378a0c8621@arm.com>
Date:   Mon, 23 Mar 2020 17:17:42 +0000
Message-ID: <jhjwo7bkn2h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 23 2020, Dietmar Eggemann wrote:

> On 19.03.20 13:05, Valentin Schneider wrote:
>>
>> On Thu, Mar 19 2020, Dietmar Eggemann wrote:
>>> On 11.03.20 19:15, Valentin Schneider wrote:
>
> [...]
>
>> Your comments make me realize that changelog isn't great, what about the
>> following?
>>
>> ---
>>
>> The SD_LOAD_BALANCE flag is set unconditionally for all domains in
>> sd_init(). By making the sched_domain->flags syctl interface read-only, we
>> have removed the last piece of code that could clear that flag - as such,
>> it will now be always present. Rather than to keep carrying it along, we
>> can work towards getting rid of it entirely.
>>
>> cpusets don't need it because they can make CPUs be attached to the NULL
>> domain (e.g. cpuset with sched_load_balance=0), or to a partitionned
>
> s/partitionned/partitioned
>
>> root_domain, i.e. a sched_domain hierarchy that doesn't span the entire
>> system (e.g. root cpuset with sched_load_balance=0 and sibling cpusets with
>> sched_load_balance=1).
>>
>> isolcpus apply the same "trick": isolated CPUs are explicitly taken out of
>> the sched_domain rebuild (using housekeeping_cpumask()), so they get the
>> NULL domain treatment as well.
>>
>> Remove the checks against SD_LOAD_BALANCE.
>
> Sounds better to me:
>
> Essentially, I was referring to examples like:
>
> Hikey960 - 2x4
>
> (A) exclusive cpusets:
>
> root@h960:/sys/fs/cgroup/cpuset# mkdir cs1
> root@h960:/sys/fs/cgroup/cpuset# echo 1 > cs1/cpuset.cpu_exclusive
> root@h960:/sys/fs/cgroup/cpuset# echo 0 > cs1/cpuset.mems
> root@h960:/sys/fs/cgroup/cpuset# echo 0-2 > cs1/cpuset.cpus
> root@h960:/sys/fs/cgroup/cpuset# mkdir cs2
> root@h960:/sys/fs/cgroup/cpuset# echo 1 > cs2/cpuset.cpu_exclusive
> root@h960:/sys/fs/cgroup/cpuset# echo 0 > cs2/cpuset.mems
> root@h960:/sys/fs/cgroup/cpuset# echo 3-5 > cs2/cpuset.cpus
> root@h960:/sys/fs/cgroup/cpuset# echo 0 > cpuset.sched_load_balance
>

AFAICT you don't even have to bother with cpuset.cpu_exclusive if you
only care about the end-result wrt sched_domains.

> root@h960:/proc/sys/kernel# tree -d sched_domain
>
> ├── cpu0
> │   └── domain0
> ├── cpu1
> │   └── domain0
> ├── cpu2
> │   └── domain0
> ├── cpu3
> │   └── domain0
> ├── cpu4
> │   ├── domain0
> │   └── domain1
> ├── cpu5
> │   ├── domain0
> │   └── domain1
> ├── cpu6
> └── cpu7
>
> (B) non-exclusive cpuset:
>
> root@h960:/sys/fs/cgroup/cpuset# echo 0 > cpuset.sched_load_balance
>
> [ 8661.240385] CPU1 attaching NULL sched-domain.
> [ 8661.244802] CPU2 attaching NULL sched-domain.
> [ 8661.249255] CPU3 attaching NULL sched-domain.
> [ 8661.253623] CPU4 attaching NULL sched-domain.
> [ 8661.257989] CPU5 attaching NULL sched-domain.
> [ 8661.262363] CPU6 attaching NULL sched-domain.
> [ 8661.266730] CPU7 attaching NULL sched-domain.
>
> root@h960:/sys/fs/cgroup/cpuset# mkdir cs1
> root@h960:/sys/fs/cgroup/cpuset# echo 0-5 > cs1/cpuset.cpus
>
> root@h960:/proc/sys/kernel# tree -d sched_domain
>
> ├── cpu0
> │   ├── domain0
> │   └── domain1
> ├── cpu1
> │   ├── domain0
> │   └── domain1
> ├── cpu2
> │   ├── domain0
> │   └── domain1
> ├── cpu3
> │   ├── domain0
> │   └── domain1
> ├── cpu4
> │   ├── domain0
> │   └── domain1
> ├── cpu5
> │   ├── domain0
> │   └── domain1
> ├── cpu6
> └── cpu7

I think my updated changelog covers those cases, right?

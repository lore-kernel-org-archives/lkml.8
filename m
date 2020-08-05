Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE77822B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHED51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:57:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:12898 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHED51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:57:27 -0400
IronPort-SDR: V9MbrmgphVpVeG2Va6o66+cljy24jk42lzi3oTBeELJuL+mZb9DHWUc5jZEfVwvjVtVEWgYSTu
 ogLLWC32+wJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="237319410"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="237319410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 20:57:26 -0700
IronPort-SDR: 8SZAryz4BEhy65sUklKm54H7M8MknXTFJPnNuhaz/7EPiFGVOyP/sW/qnX9tvJtIh6e4h7ScCk
 kdWGTSStlqiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="330810908"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2020 20:57:20 -0700
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     viremana@linux.microsoft.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
Date:   Wed, 5 Aug 2020 11:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/4 0:53, Joel Fernandes wrote:
> Hi Aubrey,
> 
> On Mon, Aug 3, 2020 at 4:23 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
>>> Sixth iteration of the Core-Scheduling feature.
>>>
>>> Core scheduling is a feature that allows only trusted tasks to run
>>> concurrently on cpus sharing compute resources (eg: hyperthreads on a
>>> core). The goal is to mitigate the core-level side-channel attacks
>>> without requiring to disable SMT (which has a significant impact on
>>> performance in some situations). Core scheduling (as of v6) mitigates
>>> user-space to user-space attacks and user to kernel attack when one of
>>> the siblings enters the kernel via interrupts. It is still possible to
>>> have a task attack the sibling thread when it enters the kernel via
>>> syscalls.
>>>
>>> By default, the feature doesn't change any of the current scheduler
>>> behavior. The user decides which tasks can run simultaneously on the
>>> same core (for now by having them in the same tagged cgroup). When a
>>> tag is enabled in a cgroup and a task from that cgroup is running on a
>>> hardware thread, the scheduler ensures that only idle or trusted tasks
>>> run on the other sibling(s). Besides security concerns, this feature
>>> can also be beneficial for RT and performance applications where we
>>> want to control how tasks make use of SMT dynamically.
>>>
>>> This iteration is mostly a cleanup of v5 except for a major feature of
>>> pausing sibling when a cpu enters kernel via nmi/irq/softirq. Also
>>> introducing documentation and includes minor crash fixes.
>>>
>>> One major cleanup was removing the hotplug support and related code.
>>> The hotplug related crashes were not documented and the fixes piled up
>>> over time leading to complex code. We were not able to reproduce the
>>> crashes in the limited testing done. But if they are reroducable, we
>>> don't want to hide them. We should document them and design better
>>> fixes if any.
>>>
>>> In terms of performance, the results in this release are similar to
>>> v5. On a x86 system with N hardware threads:
>>> - if only N/2 hardware threads are busy, the performance is similar
>>>   between baseline, corescheduling and nosmt
>>> - if N hardware threads are busy with N different corescheduling
>>>   groups, the impact of corescheduling is similar to nosmt
>>> - if N hardware threads are busy and multiple active threads share the
>>>   same corescheduling cookie, they gain a performance improvement over
>>>   nosmt.
>>>   The specific performance impact depends on the workload, but for a
>>>   really busy database 12-vcpu VM (1 coresched tag) running on a 36
>>>   hardware threads NUMA node with 96 mostly idle neighbor VMs (each in
>>>   their own coresched tag), the performance drops by 54% with
>>>   corescheduling and drops by 90% with nosmt.
>>>
>>
>> We found uperf(in cgroup) throughput drops by ~50% with corescheduling.
>>
>> The problem is, uperf triggered a lot of softirq and offloaded softirq
>> service to *ksoftirqd* thread.
>>
>> - default, ksoftirqd thread can run with uperf on the same core, we saw
>>   100% CPU utilization.
>> - coresched enabled, ksoftirqd's core cookie is different from uperf, so
>>   they can't run concurrently on the same core, we saw ~15% forced idle.
>>
>> I guess this kind of performance drop can be replicated by other similar
>> (a lot of softirq activities) workloads.
>>
>> Currently core scheduler picks cookie-match tasks for all SMT siblings, does
>> it make sense we add a policy to allow cookie-compatible task running together?
>> For example, if a task is trusted(set by admin), it can work with kernel thread.
>> The difference from corescheduling disabled is that we still have user to user
>> isolation.
> 
> In ChromeOS we are considering all cookie-0 tasks as trusted.
> Basically if you don't trust a task, then that is when you assign the
> task a tag. We do this for the sandboxed processes.

I have a proposal of this, by changing cpu.tag to cpu.coresched_policy,
something like the following:

+/*
+ * Core scheduling policy:
+ * - CORE_SCHED_DISABLED: core scheduling is disabled.
+ * - CORE_COOKIE_MATCH: tasks with same cookie can run
+ *                     on the same core concurrently.
+ * - CORE_COOKIE_TRUST: trusted task can run with kernel
			thread on the same core concurrently. 
+ * - CORE_COOKIE_LONELY: tasks with cookie can run only
+ *                     with idle thread on the same core.
+ */
+enum coresched_policy {
+       CORE_SCHED_DISABLED,
+       CORE_SCHED_COOKIE_MATCH,
+	CORE_SCHED_COOKIE_TRUST,
+       CORE_SCHED_COOKIE_LONELY,
+};

We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
of performance regression. Not sure if this sounds attractive?

> 
> Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?

This is a good question, from the data we measured by uperf,
SMT+core-scheduling is 28.2% worse than no-SMT, :(

Thanks,
-Aubrey

> 
> thanks,
> 
>  - Joel
> PS: I am planning to write a patch behind a CONFIG option that tags
> all processes (default untrusted) so everything gets a cookie which
> some folks said was how they wanted (have a whitelist instead of
> blacklist).
> 


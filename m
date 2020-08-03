Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F019EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5132206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgHCIXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:23:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:34766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgHCIXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:23:32 -0400
IronPort-SDR: 5jktLlD9grkGgOvxBtzh8TIXl61whsEF41wavJj2w9CH2R0OlWOjR+yN/FhH7+v22+Qrvs1CXU
 +GZHO2SbRdng==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="216487932"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="216487932"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:23:32 -0700
IronPort-SDR: IqKQYllmsmUv1SF5B7jY+UiuAiPWzm98dCbhaC3Q5ZJE0AmQILR9xC90WHYbW93Slw25btj1Fr
 iSAkhYogKByg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="329927012"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2020 01:23:26 -0700
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
To:     viremana@linux.microsoft.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Message-ID: <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
Date:   Mon, 3 Aug 2020 16:23:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
> Sixth iteration of the Core-Scheduling feature.
> 
> Core scheduling is a feature that allows only trusted tasks to run
> concurrently on cpus sharing compute resources (eg: hyperthreads on a
> core). The goal is to mitigate the core-level side-channel attacks
> without requiring to disable SMT (which has a significant impact on
> performance in some situations). Core scheduling (as of v6) mitigates
> user-space to user-space attacks and user to kernel attack when one of
> the siblings enters the kernel via interrupts. It is still possible to
> have a task attack the sibling thread when it enters the kernel via
> syscalls.
> 
> By default, the feature doesn't change any of the current scheduler
> behavior. The user decides which tasks can run simultaneously on the
> same core (for now by having them in the same tagged cgroup). When a
> tag is enabled in a cgroup and a task from that cgroup is running on a
> hardware thread, the scheduler ensures that only idle or trusted tasks
> run on the other sibling(s). Besides security concerns, this feature
> can also be beneficial for RT and performance applications where we
> want to control how tasks make use of SMT dynamically.
> 
> This iteration is mostly a cleanup of v5 except for a major feature of
> pausing sibling when a cpu enters kernel via nmi/irq/softirq. Also
> introducing documentation and includes minor crash fixes.
> 
> One major cleanup was removing the hotplug support and related code.
> The hotplug related crashes were not documented and the fixes piled up
> over time leading to complex code. We were not able to reproduce the
> crashes in the limited testing done. But if they are reroducable, we
> don't want to hide them. We should document them and design better
> fixes if any.
> 
> In terms of performance, the results in this release are similar to
> v5. On a x86 system with N hardware threads:
> - if only N/2 hardware threads are busy, the performance is similar
>   between baseline, corescheduling and nosmt
> - if N hardware threads are busy with N different corescheduling
>   groups, the impact of corescheduling is similar to nosmt
> - if N hardware threads are busy and multiple active threads share the
>   same corescheduling cookie, they gain a performance improvement over
>   nosmt.
>   The specific performance impact depends on the workload, but for a
>   really busy database 12-vcpu VM (1 coresched tag) running on a 36
>   hardware threads NUMA node with 96 mostly idle neighbor VMs (each in
>   their own coresched tag), the performance drops by 54% with
>   corescheduling and drops by 90% with nosmt.
> 

We found uperf(in cgroup) throughput drops by ~50% with corescheduling.

The problem is, uperf triggered a lot of softirq and offloaded softirq
service to *ksoftirqd* thread. 

- default, ksoftirqd thread can run with uperf on the same core, we saw
  100% CPU utilization.
- coresched enabled, ksoftirqd's core cookie is different from uperf, so
  they can't run concurrently on the same core, we saw ~15% forced idle.

I guess this kind of performance drop can be replicated by other similar
(a lot of softirq activities) workloads.

Currently core scheduler picks cookie-match tasks for all SMT siblings, does
it make sense we add a policy to allow cookie-compatible task running together?
For example, if a task is trusted(set by admin), it can work with kernel thread.
The difference from corescheduling disabled is that we still have user to user
isolation.

Thanks,
-Aubrey







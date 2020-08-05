Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A79C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7943022B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="DIcHOITK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgHEGRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:17:03 -0400
Received: from mail4.tencent.com ([183.57.53.109]:42852 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:17:02 -0400
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id A7D0F7246A;
        Wed,  5 Aug 2020 14:16:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1596608211;
        bh=9dUm1YkmcldDZeaBdod9SaxYkWzQSNZ3oDJAKDOPBdw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=DIcHOITKEoNeBoLUY8MV5Y6R8RHZv9YQKQhy3wDhsSEMu9IHyFENZ6K+jyHDKD+mT
         gTBqYOrCtQjKcQJCdhPxZ1cHgBtPL29knrQ8ZAstIDGTdGfO1U8PQyjZDNkrNVZRv9
         eqPSjrq3obBmtK6luLsyZI7yu8RADxunsGgkf+2w=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 5 Aug 2020
 14:16:51 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 5 Aug 2020
 14:16:51 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 5 Aug 2020 14:16:48 +0800
From:   =?iso-2022-jp?B?YmVuYmppYW5nKBskQj5VSTcbKEIp?= 
        <benbjiang@tencent.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thomas Glexiner" <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Subhra Mazumdar" <subhra.mazumdar@oracle.com>,
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
        "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Subject: Re: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
Thread-Topic: [RFC PATCH 00/16] Core scheduling v6(Internet mail)
Thread-Index: AQHWTyYIdUbfm2uvOEagav1FxQIttakluk8AgACOfACAAkvVAIAAJvUA
Date:   Wed, 5 Aug 2020 06:16:48 +0000
Message-ID: <2332D19B-7CDC-4BD9-9224-3C6B02153514@tencent.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <6d0f9fc0-2e34-f559-29bc-4143e6d3f751@linux.intel.com>
 <CAEXW_YS6oW_AAkmOuXNMCj_N5763aG9SXEcWz_onPhQQU2TZ0g@mail.gmail.com>
 <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
In-Reply-To: <f986f5a9-5c97-10ed-1e44-84bbd929e605@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.198]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <2F374B3B886D574BBF792FC5F673D68E@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Aug 5, 2020, at 11:57 AM, Li, Aubrey <aubrey.li@linux.intel.com> wrote=
:
>=20
> On 2020/8/4 0:53, Joel Fernandes wrote:
>> Hi Aubrey,
>>=20
>> On Mon, Aug 3, 2020 at 4:23 AM Li, Aubrey <aubrey.li@linux.intel.com> wr=
ote:
>>>=20
>>> On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
>>>> Sixth iteration of the Core-Scheduling feature.
>>>>=20
>>>> Core scheduling is a feature that allows only trusted tasks to run
>>>> concurrently on cpus sharing compute resources (eg: hyperthreads on a
>>>> core). The goal is to mitigate the core-level side-channel attacks
>>>> without requiring to disable SMT (which has a significant impact on
>>>> performance in some situations). Core scheduling (as of v6) mitigates
>>>> user-space to user-space attacks and user to kernel attack when one of
>>>> the siblings enters the kernel via interrupts. It is still possible to
>>>> have a task attack the sibling thread when it enters the kernel via
>>>> syscalls.
>>>>=20
>>>> By default, the feature doesn't change any of the current scheduler
>>>> behavior. The user decides which tasks can run simultaneously on the
>>>> same core (for now by having them in the same tagged cgroup). When a
>>>> tag is enabled in a cgroup and a task from that cgroup is running on a
>>>> hardware thread, the scheduler ensures that only idle or trusted tasks
>>>> run on the other sibling(s). Besides security concerns, this feature
>>>> can also be beneficial for RT and performance applications where we
>>>> want to control how tasks make use of SMT dynamically.
>>>>=20
>>>> This iteration is mostly a cleanup of v5 except for a major feature of
>>>> pausing sibling when a cpu enters kernel via nmi/irq/softirq. Also
>>>> introducing documentation and includes minor crash fixes.
>>>>=20
>>>> One major cleanup was removing the hotplug support and related code.
>>>> The hotplug related crashes were not documented and the fixes piled up
>>>> over time leading to complex code. We were not able to reproduce the
>>>> crashes in the limited testing done. But if they are reroducable, we
>>>> don't want to hide them. We should document them and design better
>>>> fixes if any.
>>>>=20
>>>> In terms of performance, the results in this release are similar to
>>>> v5. On a x86 system with N hardware threads:
>>>> - if only N/2 hardware threads are busy, the performance is similar
>>>>  between baseline, corescheduling and nosmt
>>>> - if N hardware threads are busy with N different corescheduling
>>>>  groups, the impact of corescheduling is similar to nosmt
>>>> - if N hardware threads are busy and multiple active threads share the
>>>>  same corescheduling cookie, they gain a performance improvement over
>>>>  nosmt.
>>>>  The specific performance impact depends on the workload, but for a
>>>>  really busy database 12-vcpu VM (1 coresched tag) running on a 36
>>>>  hardware threads NUMA node with 96 mostly idle neighbor VMs (each in
>>>>  their own coresched tag), the performance drops by 54% with
>>>>  corescheduling and drops by 90% with nosmt.
>>>>=20
>>>=20
>>> We found uperf(in cgroup) throughput drops by ~50% with corescheduling.
>>>=20
>>> The problem is, uperf triggered a lot of softirq and offloaded softirq
>>> service to *ksoftirqd* thread.
>>>=20
>>> - default, ksoftirqd thread can run with uperf on the same core, we saw
>>>  100% CPU utilization.
>>> - coresched enabled, ksoftirqd's core cookie is different from uperf, s=
o
>>>  they can't run concurrently on the same core, we saw ~15% forced idle.
>>>=20
>>> I guess this kind of performance drop can be replicated by other simila=
r
>>> (a lot of softirq activities) workloads.
>>>=20
>>> Currently core scheduler picks cookie-match tasks for all SMT siblings,=
 does
>>> it make sense we add a policy to allow cookie-compatible task running t=
ogether?
>>> For example, if a task is trusted(set by admin), it can work with kerne=
l thread.
>>> The difference from corescheduling disabled is that we still have user =
to user
>>> isolation.
>>=20
>> In ChromeOS we are considering all cookie-0 tasks as trusted.
>> Basically if you don't trust a task, then that is when you assign the
>> task a tag. We do this for the sandboxed processes.
>=20
> I have a proposal of this, by changing cpu.tag to cpu.coresched_policy,
> something like the following:
>=20
> +/*
> + * Core scheduling policy:
> + * - CORE_SCHED_DISABLED: core scheduling is disabled.
> + * - CORE_COOKIE_MATCH: tasks with same cookie can run
> + *                     on the same core concurrently.
> + * - CORE_COOKIE_TRUST: trusted task can run with kernel
> 			thread on the same core concurrently.=20
How about other OS tasks(like systemd) except kernel thread? :)

Thx.
Regards,
Jiang
> + * - CORE_COOKIE_LONELY: tasks with cookie can run only
> + *                     with idle thread on the same core.
> + */
> +enum coresched_policy {
> +       CORE_SCHED_DISABLED,
> +       CORE_SCHED_COOKIE_MATCH,
> +	CORE_SCHED_COOKIE_TRUST,
> +       CORE_SCHED_COOKIE_LONELY,
> +};
>=20
> We can set policy to CORE_COOKIE_TRUST of uperf cgroup and fix this kind
> of performance regression. Not sure if this sounds attractive?
>=20
>>=20
>> Is the uperf throughput worse with SMT+core-scheduling versus no-SMT ?
>=20
> This is a good question, from the data we measured by uperf,
> SMT+core-scheduling is 28.2% worse than no-SMT, :(
>=20
> Thanks,
> -Aubrey
>=20
>>=20
>> thanks,
>>=20
>> - Joel
>> PS: I am planning to write a patch behind a CONFIG option that tags
>> all processes (default untrusted) so everything gets a cookie which
>> some folks said was how they wanted (have a whitelist instead of
>> blacklist).


Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57940C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C0320786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PofhpSNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgH0Aa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:30:59 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40365 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgH0Aa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598488258; x=1630024258;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GchuMbUxxpOlsCsLPOEd1NRP53jYqJ9z9vTMf41whBc=;
  b=PofhpSNAKeW1xqZ3vvHlRbxbpg5DAiSAl1365nrP0p9dXnA69hllwocP
   X84z19/98WfXyq9C8L5NBZGvnjuldGDRPlVHnBmnqjX33sIhR8AEdPDJf
   GrYnX9cLVdSiLunpQsqaBcYcUEYk32lfilgapya9/S5KRr3nG2f3KQPk5
   Y=;
X-IronPort-AV: E=Sophos;i="5.76,357,1592870400"; 
   d="scan'208";a="50323416"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 27 Aug 2020 00:30:56 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id A7B63A22E9;
        Thu, 27 Aug 2020 00:30:47 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:30:46 +0000
Received: from vpn-10-85-95-61.fra53.corp.amazon.com (10.43.162.55) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 27 Aug 2020 00:30:41 +0000
Subject: Re: [RFC PATCH 00/16] Core scheduling v6
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <pjt@google.com>,
        <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <subhra.mazumdar@oracle.com>,
        <fweisbec@gmail.com>, <keescook@chromium.org>,
        <kerrnel@google.com>, "Phil Auld" <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, <joel@joelfernandes.org>,
        <vineethrp@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <c4556033-4d78-0419-0114-a17f68456ec8@amazon.com>
Date:   Thu, 27 Aug 2020 02:30:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.55]
X-ClientProxiedBy: EX13D36UWB002.ant.amazon.com (10.43.161.149) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On 30.06.20 23:32, Vineeth Remanan Pillai wrote:
> Sixth iteration of the Core-Scheduling feature.
> =

> Core scheduling is a feature that allows only trusted tasks to run
> concurrently on cpus sharing compute resources (eg: hyperthreads on a
> core). The goal is to mitigate the core-level side-channel attacks
> without requiring to disable SMT (which has a significant impact on
> performance in some situations). Core scheduling (as of v6) mitigates
> user-space to user-space attacks and user to kernel attack when one of
> the siblings enters the kernel via interrupts. It is still possible to
> have a task attack the sibling thread when it enters the kernel via
> syscalls.
> =

> By default, the feature doesn't change any of the current scheduler
> behavior. The user decides which tasks can run simultaneously on the
> same core (for now by having them in the same tagged cgroup). When a
> tag is enabled in a cgroup and a task from that cgroup is running on a
> hardware thread, the scheduler ensures that only idle or trusted tasks
> run on the other sibling(s). Besides security concerns, this feature
> can also be beneficial for RT and performance applications where we
> want to control how tasks make use of SMT dynamically.
> =

> This iteration is mostly a cleanup of v5 except for a major feature of
> pausing sibling when a cpu enters kernel via nmi/irq/softirq. Also
> introducing documentation and includes minor crash fixes.
> =

> One major cleanup was removing the hotplug support and related code.
> The hotplug related crashes were not documented and the fixes piled up
> over time leading to complex code. We were not able to reproduce the
> crashes in the limited testing done. But if they are reroducable, we
> don't want to hide them. We should document them and design better
> fixes if any.
> =

> In terms of performance, the results in this release are similar to
> v5. On a x86 system with N hardware threads:
> - if only N/2 hardware threads are busy, the performance is similar
>    between baseline, corescheduling and nosmt
> - if N hardware threads are busy with N different corescheduling
>    groups, the impact of corescheduling is similar to nosmt
> - if N hardware threads are busy and multiple active threads share the
>    same corescheduling cookie, they gain a performance improvement over
>    nosmt.
>    The specific performance impact depends on the workload, but for a
>    really busy database 12-vcpu VM (1 coresched tag) running on a 36
>    hardware threads NUMA node with 96 mostly idle neighbor VMs (each in
>    their own coresched tag), the performance drops by 54% with
>    corescheduling and drops by 90% with nosmt.
> =

> v6 is rebased on 5.7.6(a06eb423367e)
> https://github.com/digitalocean/linux-coresched/tree/coresched/v6-v5.7.y

As discussed during Linux Plumbers, here is a small repo with test =

scripts and applications that I've used to look at core scheduling =

unfairness:

   https://github.com/agraf/schedgaps

Please let me know if it's unclear how to use it or if you see issues in =

your environment.

Please also make sure to only run this on idle server class hardware. =

Notebooks will most definitely have too many uncontrollable sources of =

timing entropy to give sensible results.


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




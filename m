Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A3C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9A208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SjD63oM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgDQMfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:35:50 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20166 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgDQMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587126950; x=1618662950;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OdibdvnRCiR3oRCFtr6knxg31LyffzptNwEOCUjysp4=;
  b=SjD63oM0xQcXpQTG1Qh47qvP46S9GVGRtuGUvYFfQXjXPFtdRUv80+1m
   cvaEBfdyYJQpDYQSBFNGJ/IxwYxH2jNYEC+bKL6EvtVMsv80tmGDd/fv0
   7dopXMp5Ekqmtq75E/q2md3uD53d6qS22/2k9Vbuq6Ejji0OGzk0Eqx6U
   w=;
IronPort-SDR: 0nSogWMX86xLX3NlVdhcejMl4jOXHByzST8bOTvlmFHFvIpcyMUt1uHUS9yXLGRP2vPs97Ae5t
 fXxpzzXtV5tw==
X-IronPort-AV: E=Sophos;i="5.72,395,1580774400"; 
   d="scan'208";a="37684605"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 17 Apr 2020 12:35:48 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 80E4CA1E8F;
        Fri, 17 Apr 2020 12:35:46 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 12:35:45 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.238) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 12:35:41 +0000
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
CC:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, <mingo@kernel.org>,
        <tglx@linutronix.de>, <pjt@google.com>,
        <torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <fweisbec@gmail.com>, <keescook@chromium.org>,
        <kerrnel@google.com>, "Phil Auld" <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200414142152.GV20730@hirez.programming.kicks-ass.net>
 <20200415163220.GA180518@google.com>
 <20200417111255.GZ20730@hirez.programming.kicks-ass.net>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <79529592-5d60-2a41-fbb6-4a5f8279f998@amazon.com>
Date:   Fri, 17 Apr 2020 14:35:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417111255.GZ20730@hirez.programming.kicks-ass.net>
Content-Language: en-US
X-Originating-IP: [10.43.162.238]
X-ClientProxiedBy: EX13D22UWC001.ant.amazon.com (10.43.162.192) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.20 13:12, Peter Zijlstra wrote:
> On Wed, Apr 15, 2020 at 12:32:20PM -0400, Joel Fernandes wrote:
>> On Tue, Apr 14, 2020 at 04:21:52PM +0200, Peter Zijlstra wrote:
>>> On Wed, Mar 04, 2020 at 04:59:50PM +0000, vpillai wrote:
>>>> TODO
>>>> ----
>>>> - Work on merging patches that are ready to be merged
>>>> - Decide on the API for exposing the feature to userland
>>>> - Experiment with adding synchronization points in VMEXIT to mitigate
>>>>    the VM-to-host-kernel leaking
>>>
>>> VMEXIT is too late, you need to hook irq_enter(), which is what makes
>>> the whole thing so horrible.
>>
>> We came up with a patch to do this as well. Currently testing it more an=
d it
>> looks clean, will share it soon.
> =

> Thomas said we actually first do VMEXIT, and then enable interrupts. So
> the VMEXIT thing should actually work, and that is indeed much saner
> than sticking it in irq_enter().

If we first kick out the sibling HT for every #VMEXIT, performance will =

be abysmal, no?

I know of a few options to make this work without the big hammer:


   1) Leave interrupts disabled on "fast-path" exits. This can become =

very hard to grasp very quickly.

   2) Patch the IRQ handlers (or build something more generic that =

installs a trampoline on all IRQ handler installations)

   3) Ignore IRQ data exposure (what could possibly go wrong, it's not =

like your IRQ handler reads secret data from the network, right)

   4) Create a "safe" page table which runs with HT enabled. Any access =

outside of the "safe" zone disables the sibling and switches to the =

"full" kernel page table. This should prevent any secret data to be =

fetched into caches/core buffers.

   5) Create a KVM specific "safe zone": Keep improving the ASI patches =

and make only the ASI environment safe for HT, everything else not.

Has there been any progress on 4? It sounded like the most generic =

option ...

> =

> It does however put yet more nails in the out-of-tree hypervisors.
> =

>>>> - Investigate the source of the overhead even when no tasks are tagged:
>>>>    https://lkml.org/lkml/2019/10/29/242
>>>
>>>   - explain why we're all still doing this ....
>>>
>>> Seriously, what actual problems does it solve? The patch-set still isn't
>>> L1TF complete and afaict it does exactly nothing for MDS.
>>
>> The L1TF incompleteness is because of cross-HT attack from Guest vCPU
>> attacker to an interrupt/softirq executing on the other sibling correct?=
 The
>> IRQ enter pausing the other sibling should fix that (which we will share=
 in
>> a future series revision after adequate testing).
> =

> Correct, the vCPU still running can glean host (kernel) state from the
> sibling handling the interrupt in the host kernel.
> =

>>> Like I've written many times now, back when the world was simpler and
>>> all we had to worry about was L1TF, core-scheduling made some sense, but
>>> how does it make sense today?
>>
>> For ChromeOS we're planning to tag each and every task seperately except=
 for
>> trusted processes, so we are isolating untrusted tasks even from each ot=
her.
>>
>> Sorry if this sounds like pushing my usecase, but we do get parallelism
>> advantage for the trusted tasks while still solving all security issues =
(for
>> ChromeOS). I agree that cross-HT user <-> kernel MDS is still an issue if
>> untrusted (tagged) tasks execute together on same core, but we are not
>> planning to do that on our setup at least.
> =

> That doesn't completely solve things I think. Even if you run all
> untrusted tasks as core exclusive, you still have a problem of them vs
> interrupts on the other sibling.
 >
> You need to somehow arrange all interrupts to the core happen on the
> same sibling that runs your untrusted task, such that the VERW on
> return-to-userspace works as intended.
> =

> I suppose you can try and play funny games with interrupt routing tied
> to the force-idle state, but I'm dreading what that'll look like. Or
> were you going to handle this from your irq_enter() thing too?

I'm not sure I follow. We have thread local interrupts (timers, IPIs) =

and device interrupts (network, block, etc).

Thread local ones shouldn't transfer too much knowledge, so I'd be =

inclined to say we can just ignore that attack vector.

Device interrupts we can easily route to HT0. If we now make "core =

exclusive" a synonym for "always run on HT0", we can guarantee that they =

always land on the same CPU, no?

Then you don't need to hook into any idle state tracking, because you =

always know which CPU the "safe" one to both schedule tasks and route =

interrupts to is.


Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D1EC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9169D206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQTHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:07:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:11723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQTHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:07:48 -0400
IronPort-SDR: h2UnIB6Mo8HiYrwzSIo8x64z8mNZr9crnGhdEAznRPDLyrSjwkLU0dN2kzYJQh6xzcMXpG6r8c
 CMHFDP87D7aQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 12:07:47 -0700
IronPort-SDR: BNgwjUB08FpzBbWznhz+T+qyrbP+bGbCVf1DIlcszOOSQjd9SUhXOMNuMlLBHmwLqN4g/YqSJC
 XzLr0Sz6JYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="355456537"
Received: from rkarmazi-mobl1.amr.corp.intel.com (HELO schen9-mobl.amr.corp.intel.com) ([10.134.81.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2020 12:07:43 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Joel Fernandes <joel@joelfernandes.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad> <20200317005521.GA8244@google.com>
Message-ID: <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
Date:   Tue, 17 Mar 2020 12:07:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317005521.GA8244@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

> 
> Looks quite interesting. We are trying apply this work to ChromeOS. What we
> want to do is selectively marking tasks, instead of grouping sets of trusted
> tasks. I have a patch that adds a prctl which a task can call, and it works
> well (task calls prctl and gets a cookie which gives it a dedicated core).
> 
> However, I have the following questions, in particular there are 4 scenarios
> where I feel the current patches do not resolve MDS/L1TF, would you guys
> please share your thoughts?
> 
> 1. HT1 is running either hostile guest or host code.
>    HT2 is running an interrupt handler (victim).
> 
>    In this case I see there is a possible MDS issue between HT1 and HT2.

Core scheduling mitigates the userspace to userspace attacks via MDS between the HT.
It does not prevent the userspace to kernel space attack.  That will
have to be mitigated via other means, e.g. redirecting interrupts to a core
that don't run potentially unsafe code.

> 
> 2. HT1 is executing hostile host code, and gets interrupted by a victim
>    interrupt. HT2 is idle.

Similar to above.

> 
>    In this case, I see there is a possible MDS issue between interrupt and
>    the host code on the same HT1.

The cpu buffers are cleared before return to the hostile host code.  So
MDS shouldn't be an issue if interrupt handler and hostile code
runs on the same HT thread.

> 
> 3. HT1 is executing hostile guest code, HT2 is executing a victim interrupt
>    handler on the host.
> 
>    In this case, I see there is a possible L1TF issue between HT1 and HT2.
>    This issue does not happen if HT1 is running host code, since the host
>    kernel takes care of inverting PTE bits.

The interrupt handler will be run with PTE inverted.  So I don't think
there's a leak via L1TF in this scenario.

> 
> 4. HT1 is idle, and HT2 is running a victim process. Now HT1 starts running
>    hostile code on guest or host. HT2 is being forced idle. However, there is
>    an overlap between HT1 starting to execute hostile code and HT2's victim
>    process getting scheduled out.
>    Speaking to Vineeth, we discussed an idea to monitor the core_sched_seq
>    counter of the sibling being idled to detect that it is now idle.
>    However we discussed today that looking at this data, it is not really an
>    issue since it is such a small window.
> 
> My concern is now cases 1, 2 to which there does not seem a good solution,
> short of disabling interrupts. For 3, we could still possibly do something on
> the guest side, such as using shadow page tables. Any thoughts on all this?
> 

+ Tony who may have more insights on L1TF and MDS.

Thanks.

Tim

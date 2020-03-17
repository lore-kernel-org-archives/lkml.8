Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF5CC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E2020724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCQV6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:58:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:49897 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQV6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:58:31 -0400
IronPort-SDR: eJX9kXCNckAPmt58OzzpIr69oTqVPdK7cxMekhQbguJYJXWEEF/4qRPA967mGr7wEnskAXvQyw
 hz9zB7R8E67g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 14:58:30 -0700
IronPort-SDR: p5wfDfuzIMx4tKu750Euj7b7ubnd15YxlVgF2BjLfIwxN6Xj9lAvr0AGGgaiofAVQrhfkS9WlA
 rtd63bpilOUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="355500363"
Received: from schen9-mobl.amr.corp.intel.com ([10.134.81.123])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2020 14:58:29 -0700
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
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
 <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
 <87imj2bs04.fsf@nanos.tec.linutronix.de>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <a2f292cc-45b2-6942-c579-a82ea9f047fb@linux.intel.com>
Date:   Tue, 17 Mar 2020 14:58:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imj2bs04.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 2:17 PM, Thomas Gleixner wrote:

>> The interrupt handler will be run with PTE inverted.  So I don't think
>> there's a leak via L1TF in this scenario.
> 
> How so?
> 
> Host memory is attackable, when one of the sibling SMT threads runs in
> host OS (hypervisor) context and the other in guest context.
> 
> HT1 is in guest mode and attacking (has control over PTEs). HT2 is
> running in host mode and executes an interrupt handler. The host PTE
> inversion does not matter in this scenario at all.
> 
> So HT1 can very well see data which is brought into the shared L1 by
> HT2.
> 
> The only way to mitigate that aside of disabling HT is disabling EPT.
> 

I had a brain lapse. Yes, PTE inversion is for mitigating against malicious
user space code, not for malicious guest.

Thanks for the correction.

Tim


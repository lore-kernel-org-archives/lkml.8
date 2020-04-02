Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361612078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbgDBQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:42:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:55493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgDBQmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:42:02 -0400
IronPort-SDR: KCUgcajdfJNsnPeo+czqs1faKay3oyHniad+b38d65kHZjJRwVAcikGCgC6QzBM2dipps9Br6v
 C6gYVezyqbHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 09:42:02 -0700
IronPort-SDR: nRCn5XujqpcJlyzDA7FP1e7OHy2RhPcU9qyjSkkoPKWIN1REVvqGWirY0hqNhf0H9KZH+Hao9r
 4BJRTGJn/ZzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="273629977"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.179]) ([10.249.169.179])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2020 09:41:58 -0700
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
 <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
 <20200402162548.GH20730@hirez.programming.kicks-ass.net>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <2d2140c4-712a-2f8d-cde7-b3e64c28b204@intel.com>
Date:   Fri, 3 Apr 2020 00:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402162548.GH20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2020 12:25 AM, Peter Zijlstra wrote:
> 
> Learn to trim your replies already!

Sorry.

> On Fri, Apr 03, 2020 at 12:20:08AM +0800, Xiaoyao Li wrote:
>> On 4/2/2020 11:23 PM, Peter Zijlstra wrote:
> 
>>> +bad_module:
>>> +	pr_warn("disabled due to VMX in module: %s\n", me->name);
>>> +	sld_state = sld_off;
>>
>> shouldn't we remove the __ro_after_init of sld_state?
> 
> Oh, that's probably a good idea. I can't actually test this due to no
> hardware.
> 
>> And, shouldn't we clear X86_FEATURE_SPLIT_LOCK_DETECT flag?
> 
> Don't think you can do that this late. Also, the hardware has the MSR
> and it works, it's just that we should not.
> 

Actually, I agree to keep this flag.

But, during the previous patch review, tglx wants to make

	sld_off = no X86_FEATURE_SPLIT_LOCK_DETECT

I'm not sure whether he still insists on it now.

I really want to decouple sld_off and X86_FEATURE_SPLIT_LOCK_DETECT.
So if X86_FEATURE_SPLIT_LOCK_DETECT is set, we can virtualize and expose 
it to guest even when host is sld_off.

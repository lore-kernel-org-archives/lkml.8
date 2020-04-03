Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306E9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69BE2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585938923;
	bh=Gx76OWxX9x0q7P0Z37+EbVclgWRovp84Puof/u/5vEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FrELUnxEzN0L2Ylwfdwlosi123UKWU80GyT7R6Di1736TylwLG7Tndl5za7bwSgym
	 xc4Hb+LKstOzZphezFtqNURd3hkiXL5EtnMrNDMvncBpU2yCEHIBSNQtAowXhOpEAG
	 SkYW69bsTULQivD/uvQ4nGgYwWIvB4QlWiaOxeiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbgDCSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgDCSfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:35:21 -0400
Received: from linux-8ccs (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A1120737;
        Fri,  3 Apr 2020 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585938921;
        bh=Gx76OWxX9x0q7P0Z37+EbVclgWRovp84Puof/u/5vEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeQ9+pUN2c8n8uUQYjFz+dS/UE4wuA5ctlqaMFqD/40NAvVNnup89ZeKUH4pvJj3I
         bMxbdHHE9qn17bP3IVaeG92n4eUdKEN66EuKoSi5lEhmGzb3BODyehc0TibGwf5svU
         6bGWiyvfOjjlpgRD4UrW8lzBge9YU4oyCPlVQPqY=
Date:   Fri, 3 Apr 2020 20:35:15 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403183515.GA2529@linux-8ccs>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200403163605.GC2701@linux.intel.com>
 <20200403164156.GY20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200403164156.GY20730@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [03/04/20 18:41 +0200]:
>On Fri, Apr 03, 2020 at 09:36:05AM -0700, Sean Christopherson wrote:
>> On Thu, Apr 02, 2020 at 02:32:59PM +0200, Thomas Gleixner wrote:
>> > --- a/arch/x86/kernel/module.c
>> > +++ b/arch/x86/kernel/module.c
>> > @@ -24,6 +24,7 @@
>> >  #include <asm/pgtable.h>
>> >  #include <asm/setup.h>
>> >  #include <asm/unwind.h>
>> > +#include <asm/cpu.h>
>> >
>> >  #if 0
>> >  #define DEBUGP(fmt, ...)				\
>> > @@ -253,6 +254,11 @@ int module_finalize(const Elf_Ehdr *hdr,
>> >  					    tseg, tseg + text->sh_size);
>> >  	}
>> >
>> > +	if (text && !me->sld_safe) {
>>
>> As also reported by the test bot, sld_safe only exist if CPU_SUP_INTEL=y.
>>
>> This can also be conditioned on boot_cpu_has(X86_FEATURE_VMX), or the
>> static variant.  If CPU_SUP_INTEL=y, X86_FEATURE_VMX will be set if and
>> only if VMX is fully enabled, i.e. supported by the CPU and enabled in
>> MSR_IA32_FEATURE_CONTROl.
>>
>> > +		void *tseg = (void *)text->sh_addr;
>> > +		split_lock_validate_module_text(me, tseg, tseg + text->sh_size);
>> > +	}
>
>Ideally we push it all into arch code, but load_info isn't exposed to
>arch module code :/.

Hm, I can look into exposing load_info to arch module code and will
post a patch on Monday.

Jessica

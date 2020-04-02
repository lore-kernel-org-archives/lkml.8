Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E339C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD30A20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389943AbgDBQ5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:57:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38659 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387700AbgDBQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:57:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK39G-0008FO-Ds; Thu, 02 Apr 2020 18:56:58 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E8BA9100D52; Thu,  2 Apr 2020 18:56:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2/2] x86/kvm/vmx: Prevent split lock detection induced #AC wreckage
In-Reply-To: <20200402153035.GA13879@linux.intel.com>
References: <20200402123258.895628824@linutronix.de> <20200402124205.334622628@linutronix.de> <20200402153035.GA13879@linux.intel.com>
Date:   Thu, 02 Apr 2020 18:56:57 +0200
Message-ID: <87y2rdn7vq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> On Thu, Apr 02, 2020 at 02:33:00PM +0200, Thomas Gleixner wrote:
>> Mark the module with MOD_INFO(sld_safe, "Y") so the module loader does not
>> force SLD off.
>
> Some comments below.  But, any objection to taking Xiaoyao's patches that
> do effectively the same things, minus the MOD_INFO()?  I'll repost them in
> reply to this thread.

If they are sane, I don't have a problem. But TBH, I really couldn't be
bothered to actually scan my mails whether there surfaced something sane
by now. Writing that up was just faster :)

I'll have look.

>> +static bool guest_handles_ac(struct kvm_vcpu *vcpu)
>> +{
>> +	/*
>> +	 * If guest has alignment checking enabled in CR0 and activated in
>> +	 * eflags, then the #AC originated from CPL3 and the guest is able
>> +	 * to handle it. It does not matter whether this is a regular or
>> +	 * a split lock operation induced #AC.
>> +	 */
>> +	if (vcpu->arch.cr0 & X86_CR0_AM &&
>
> Technically not required since KVM doesn't let the gets toggle CR0.AM at
> will, but going through kvm_read_cr0{_bits}() is preferred.

You're the expert here.

>> +	    vmx_get_rflags(vcpu) & X86_EFLAGS_AC)
>
> I don't think this is correct.  A guest could trigger a split-lock #AC at
> CPL0 with EFLAGS.AC=1 and CR0.AM=1, and then panic because it didn't expect
> #AC at CPL0.

Indeed.

Thanks,

        tglx

Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710AEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E92206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbgDCRUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:20:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:53973 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgDCRUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:20:20 -0400
IronPort-SDR: 8xRw2mYWBlAVu/aHRg51EJ02lTNoKTB2QHP/bHZfhTkM00OiVvwG8YikkfYY22eJDS+dbE+3h8
 Rn9WxJU0hyAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 10:20:19 -0700
IronPort-SDR: jokLSxJtXu412ArxBhtTIlU+DAQiS2gQuXmIsa1nfWOkvQAVA9lSueHRZFvFyNXDzYVPKYN25D
 N8rXpo0SK7vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="296043927"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2020 10:20:19 -0700
Date:   Fri, 3 Apr 2020 10:20:18 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200403172018.GD2701@linux.intel.com>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200403164244.GZ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403164244.GZ20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:42:44PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 09:30:07AM -0700, Sean Christopherson wrote:
> > Hook into native CR4 writes to disable split-lock detection if CR4.VMXE
> > is toggled on by an SDL-unaware entity, e.g. an out-of-tree hypervisor
> > module.  Most/all VMX-based hypervisors blindly reflect #AC exceptions
> > into the guest, or don't intercept #AC in the first place.  With SLD
> > enabled, this results in unexpected #AC faults in the guest, leading to
> > crashes in the guest and other undesirable behavior.
> > 
> > Reported-by: "Kenneth R. Crudup" <kenny@panix.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Cc: Kenneth R. Crudup <kenny@panix.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Nadav Amit <namit@vmware.com>
> > Cc: Thomas Hellstrom <thellstrom@vmware.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: David Laight <David.Laight@ACULAB.COM>
> > Cc: Doug Covelli <dcovelli@vmware.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> > 
> > A bit ugly, but on the plus side the code is largely contained to intel.c.
> > I think forgoing the on_all_cpus() remote kill is safe? 
> 
> How would it be safe? You can't control where the module text will be
> ran, or how quickly.

Ugh, I forgot about the stupid core scope behavior.

CR4.VMXE needs to be set on every logical CPU before that CPU can do VMXON
and enter a guest, so every CPU will come through this code and locally
disable SLD.

But, a SMT sibling could race on the WRMSR and re-enable SLD on the CPU
that just killed SLD.  Waiting until other CPUs stop enabling SLD should
work.  Something like this?  Disclaimer, memory ordering isn't my forte.

static atomic_t enabling_sld = ATOMIC_INIT(0);

static void sld_update_msr(bool on)
{
	u64 test_ctrl_val = msr_test_ctrl_cache;

	if (on && !sld_killed)
		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;

	if (test_ctrl_val & MSR_TEST_CTRL_SPLIT_LOCK_DETECT)
		atomic_inc(&enabling_sld);

	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);

	if (test_ctrl_val & MSR_TEST_CTRL_SPLIT_LOCK_DETECT)
		atomic_dec(&enabling_sld);
}

void split_lock_cr4_write(unsigned long val)
{
	u64 ctrl;

	/*
	 * Out-of-tree hypervisors that aren't aware of split-lock will blindly
	 * reflect split-lock #AC into their guests.  Kill split-lock detection
	 * if an unaware entity enables VMX.
	 */
	if (!static_cpu_has(X86_FEATURE_VMX) ||
	    !static_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) ||
	    !(val & X86_CR4_VMXE) || atomic_read(&cr4_vmxe_split_lock_safe) ||
	    (native_read_cr4() & X86_CR4_VMXE))
		return;

	WARN_ON_ONCE(1);

	/*
	 * Set the global kill flag to prevent re-enabling SLD, e.g. via
	 * switch_to_sld().
	 */
	WRITE_ONCE(sld_killed, true);

	/*
	 * No need to forcefully disable SLD on other CPUs, they'll come here
	 * if/when they set CR4.VMXE.  But, wait until no other threads are
	 * enabling SLD, i.e. have seen sld_killed, as the MSR may be shared
	 * by SMT siblings.
	 */
	while (atomic_read(&enabling_sld));
	sld_update_msr(false);
}

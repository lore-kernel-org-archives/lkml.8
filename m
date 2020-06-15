Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A545C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313BA207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgFOPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:48:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:37512 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbgFOPsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:48:55 -0400
IronPort-SDR: eAr1d9AGC9yutfqhM5WnDV6PF3kkPYr6UEYASkt/aoyKt3qW/5y6kWugwH2IVQdPOJpqLxs4G6
 uCB0DC0rrjVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 08:48:54 -0700
IronPort-SDR: gkkYVgcY8xV06BkKjnJOGSlBzFZYve2j2awE0FGSSUIvIj3XiwAj5QsvMoP3GPr1BbNqj0sBuD
 XicWuOj61BNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="382581571"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 08:48:54 -0700
Date:   Mon, 15 Jun 2020 08:48:54 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615154854.GB13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
 <20200615075649.GK2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615075649.GK2497@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,
On Mon, Jun 15, 2020 at 09:56:49AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 05:41:33PM -0700, Fenghua Yu wrote:
> > +/*
> > + * Apply some heuristics to see if the #GP fault was caused by a thread
> > + * that hasn't had the IA32_PASID MSR initialized.  If it looks like that
> > + * is the problem, try initializing the IA32_PASID MSR. If the heuristic
> > + * guesses incorrectly, take one more #GP fault.
> 
> How is that going to help? Aren't we then going to run this same
> heuristic again and again and again?

The heuristic always initializes the MSR with the per mm PASID IIF the
mm has a valid PASID but the MSR doesn't have one. This heuristic usually
happens only once on the first #GP in a thread.

If the next #GP still comes in, the heuristic finds out the MSR already
has a valid PASID and thus will not fixup the MSR any more. The fixup()
returns "false" and lets others to handle the #GP.

So the heuristic will be executed once (at most) and won't be executed
again and again.

> 
> > + */
> > +bool __fixup_pasid_exception(void)
> > +{
> > +	u64 pasid_msr;
> > +	unsigned int pasid;
> > +
> > +	/*
> > +	 * This function is called only when this #GP was triggered from user
> > +	 * space. So the mm cannot be NULL.
> > +	 */
> > +	pasid = current->mm->pasid;
> > +	/* If the mm doesn't have a valid PASID, then can't help. */
> > +	if (invalid_pasid(pasid))
> > +		return false;
> > +
> > +	/*
> > +	 * Since IRQ is disabled now, the current task still owns the FPU on
> 
> That's just weird and confusing. What you want to say is that you rely
> on the exception disabling the interrupt.

I checked SDM again. You are right. #GP can be interrupted by machine check
or other interrupts. So I cannot assume the current task still owns the FPU.
Instead of directly rdmsr() and wrmsr(), I will add helpers that can access
either the MSR on the processor or the PASID state in the memory.

> 
> > +	 * this CPU and the PASID MSR can be directly accessed.
> > +	 *
> > +	 * If the MSR has a valid PASID, the #GP must be for some other reason.
> > +	 *
> > +	 * If rdmsr() is really a performance issue, a TIF_ flag may be
> > +	 * added to check if the thread has a valid PASID instead of rdmsr().
> 
> I don't understand any of this. Nobody except us writes to this MSR, we
> should bloody well know what's in it. What gives?

Patch 4 describes how to manage the MSR and patch 7 describes the format
of the MSR (20-bit PASID value and bit 31 is valid bit).

Are they sufficient to help? Or do you mean something else?

> > +	 */
> > +	rdmsrl(MSR_IA32_PASID, pasid_msr);
> > +	if (pasid_msr & MSR_IA32_PASID_VALID)
> > +		return false;
> > +
> > +	/* Fix up the MSR if the MSR doesn't have a valid PASID. */
> > +	wrmsrl(MSR_IA32_PASID, pasid | MSR_IA32_PASID_VALID);
> > +
> > +	return true;
> > +}
> > -- 
> > 2.19.1
> > 

Thanks.

-Fenghua

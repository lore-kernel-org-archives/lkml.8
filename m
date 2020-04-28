Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219EAC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E2D2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgD1ANZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1ANY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 20:13:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FBBC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 17:13:24 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jTDs8-0004yZ-8l; Tue, 28 Apr 2020 02:13:12 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B194C100FC0; Tue, 28 Apr 2020 02:13:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 6/7] x86/traps: Fix up invalid PASID
In-Reply-To: <20200427201141.GA242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-7-git-send-email-fenghua.yu@intel.com> <87mu6ys20d.fsf@nanos.tec.linutronix.de> <20200427201141.GA242333@romley-ivt3.sc.intel.com>
Date:   Tue, 28 Apr 2020 02:13:11 +0200
Message-ID: <87a72wpiw8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:
> On Sun, Apr 26, 2020 at 05:25:06PM +0200, Thomas Gleixner wrote:
>> > @@ -499,6 +510,12 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
>> >  	int ret;
>> >  
>> >  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>> > +
>> > +	if (user_mode(regs) && fixup_pasid_exception()) {
>> > +		cond_local_irq_enable(regs);
>> 
>> The point of this conditional irq enable _AFTER_ calling into the fixup
>> function is? Also what's the reason for keeping interrupts disabled
>> while calling into that function? Comments exist for a reason.
>
> irq needs to be disabled because the fixup function requires to disable
> preempt in order to update the PASID MSR on the faulting CPU.

No, that's just wrong. It's not about the update itself.

> Will add comments here.

Factual ones and not some fairy tales please.

>> > +bool __fixup_pasid_exception(void)
>> > +{
>> > +	struct mm_struct *mm;
>> > +	bool ret = true;
>> > +	u64 pasid_msr;
>> > +	int pasid;
>> > +
>> > +	mm = get_task_mm(current);
>> 
>> Why do you need a reference to current->mm ?
>
> The PASID for the address space is per mm and is stored in mm.
> To get the PASID, we need to get the mm and the
> pasid=mm->context.pasid.

It's obvious that you need to access current-mm in order to check
current->mm->context.pasid. Let me rephrase the question:

   Why do you need to take a reference on current->mm ?

Thanks,

        tglx


Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817D12065C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5W5zo0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgHKIM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgHKIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:12:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Dh9BiEVz6epUQSvBxpIbJVz7h5uxpAes5kiPqWr2N0U=; b=X5W5zo0+0m8POb2sgcLnXP4bPg
        mk0vObilIOFyEj+A5HaEz+W1jDJt1wcG62Ovyz2EWSieVA+fS3grO2WfYNFeND3dKw6EA3l8YsF9t
        qtohHGWUKY5eaHpmYO7ANKECXrOSwRjyckhuDD4FrDcdAI5M5WICMmSlc20ps9Pg3BTFcaS1Ap98g
        WnN/ysi9XMStwYB8MxYQYf7J/65n0WMSp2+R1EkCxxztnL9XqMef/tUN8xKszVgPGRvxeeA4Pyi3l
        xuO3Td1khhxEdMkLFaeXx0ZRmriZCAYURHYuyRwZBCjAc0NFw0vAiWpEl+fYUHPhntl5sMGpQSrfT
        EJ7FWlYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5POA-00074x-1J; Tue, 11 Aug 2020 08:12:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3665980C9D; Tue, 11 Aug 2020 10:12:05 +0200 (CEST)
Date:   Tue, 11 Aug 2020 10:12:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200811081205.GV3982@worktop.programming.kicks-ass.net>
References: <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
 <fe2bfa7f-132f-7581-a967-d01d58be1588@suse.com>
 <20200807095032.GA3528289@elver.google.com>
 <16671cf3-3885-eb06-79ff-4cbfaeeaea79@suse.com>
 <20200807113838.GA3547125@elver.google.com>
 <e5bf3e6a-efff-7170-5ee6-1798008393a2@suse.com>
 <CANpmjNPau_DEYadey9OL+iFZKEaUTqnFnyFs1dU12o00mg7ofA@mail.gmail.com>
 <20200807151903.GA1263469@elver.google.com>
 <20200811074127.GR3982@worktop.programming.kicks-ass.net>
 <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2dffeeb-04f0-8042-b39a-b839c4800d6f@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:57:55AM +0200, Jürgen Groß wrote:
> On 11.08.20 09:41, Peter Zijlstra wrote:
> > On Fri, Aug 07, 2020 at 05:19:03PM +0200, Marco Elver wrote:
> > 
> > > My hypothesis here is simply that kvm_wait() may be called in a place
> > > where we get the same case I mentioned to Peter,
> > > 
> > > 	raw_local_irq_save(); /* or other IRQs off without tracing */
> > > 	...
> > > 	kvm_wait() /* IRQ state tracing gets confused */
> > > 	...
> > > 	raw_local_irq_restore();
> > > 
> > > and therefore, using raw variants in kvm_wait() works. It's also safe
> > > because it doesn't call any other libraries that would result in corrupt
> > 
> > Yes, this is definitely an issue.
> > 
> > Tracing, we also musn't call into tracing when using raw_local_irq_*().
> > Because then we re-intoduce this same issue all over again.
> > 
> > Both halt() and safe_halt() are more paravirt calls, but given we're in
> > a KVM paravirt call already, I suppose we can directly use native_*()
> > here.
> > 
> > Something like so then... I suppose, but then the Xen variants need TLC
> > too.
> 
> Just to be sure I understand you correct:
> 
> You mean that xen_qlock_kick() and xen_qlock_wait() and all functions
> called by those should gain the "notrace" attribute, right?
> 
> I am not sure why the kick variants need it, though. IMO those are
> called only after the lock has been released, so they should be fine
> without notrace.

The issue happens when someone uses arch_spinlock_t under
raw_local_irq_*().

> And again: we shouldn't forget the Hyper-V variants.

Bah, my grep failed :/ Also *groan*, that's calling apic->send_IPI().



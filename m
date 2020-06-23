Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0760C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC86A20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgFWPi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:38:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:45762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbgFWPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:38:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A2E6AF3D;
        Tue, 23 Jun 2020 15:38:57 +0000 (UTC)
Date:   Tue, 23 Jun 2020 17:38:55 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Mike Stunes <mstunes@vmware.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>,
        Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Message-ID: <20200623153855.GM14101@suse.de>
References: <20200623110706.GB4817@hirez.programming.kicks-ass.net>
 <20200623113007.GH31822@suse.de>
 <20200623114818.GD4817@hirez.programming.kicks-ass.net>
 <20200623120433.GB14101@suse.de>
 <20200623125201.GG4817@hirez.programming.kicks-ass.net>
 <20200623134003.GD14101@suse.de>
 <20200623135916.GI4817@hirez.programming.kicks-ass.net>
 <20200623145344.GA117543@hirez.programming.kicks-ass.net>
 <20200623145914.GF14101@suse.de>
 <20200623152326.GL4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623152326.GL4817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:23:26PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 04:59:14PM +0200, Joerg Roedel wrote:
> > On Tue, Jun 23, 2020 at 04:53:44PM +0200, Peter Zijlstra wrote:
> > > +noinstr void idtentry_validate_ist(struct pt_regs *regs)
> > > +{
> > > +	if ((regs->sp & ~(EXCEPTION_STKSZ-1)) ==
> > > +	    (_RET_IP_ & ~(EXCEPTION_STKSZ-1)))
> > > +		die("IST stack recursion", regs, 0);
> > > +}
> > 
> > Yes, this is a start, it doesn't cover the case where the NMI stack is
> > in-between, so I think you need to walk down regs->sp too.
> 
> That shouldn't be possible with the current code, I think.

Not with the current code, but possibly with SNP #VC exceptions:

      ->  First #VC
	  -> NMI before VC handler switched off its IST stack
	     (now on NMI IST stack)
	      -> Second SNP #VC exception before the NMI handler did the
		 #VC stack check (because HV messed around with some pages
		 touched there).

In the second #VC you use the same IST stack as in the first #VC, but
the the NMI-stack in-between.

> Reliability of that depends on the unwinder, I wouldn't want the guess
> uwinder to OOPS me by accident.

It doesn't use the full unwinder, it just assumes that there is a
pt_regs struct at the top of every kernel stack and walks through them
until SP points to a user-space stack.

As long as the assumption that there is a pt_regs struct on top of every
stack holds, this should be safe. The assumption might be wrong when an
exception happens during SYSCALL/SYSENTER entry, when the return frame
is not written by hardware.


	Joerg


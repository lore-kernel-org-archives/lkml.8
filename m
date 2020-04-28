Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6BDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3A6206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgD1QZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:25:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:12475 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgD1QZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:25:52 -0400
IronPort-SDR: PU3RQCCjYkMmd0vdEkVO08ptqSDEtb82MyedCAZoUNMer2kPPosOf/A+pxPhUXrbnhz38Q+4KI
 bt/DMNGRYkKA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 09:25:52 -0700
IronPort-SDR: o9qfiixZgpPv7olKXguVA/hw8pcwWte5ZDyXuu0rYEqwInkNn8xQhzNgH7JzRQGXBm80pRnQiM
 FYjMrqqXW6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="432240240"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2020 09:25:51 -0700
Date:   Tue, 28 Apr 2020 09:25:51 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428162551.GF12735@linux.intel.com>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
 <20200428152552.GD13592@hirez.programming.kicks-ass.net>
 <20200428154909.4cjwetyyb2zhnq5i@treble>
 <20200428155413.b5xzef4s2kyzg5ed@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428155413.b5xzef4s2kyzg5ed@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:54:13AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 28, 2020 at 10:49:09AM -0500, Josh Poimboeuf wrote:
> > On Tue, Apr 28, 2020 at 05:25:52PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 28, 2020 at 09:31:57AM -0500, Josh Poimboeuf wrote:
> > > > That's quite the monstrosity, and I still don't see the point.  I
> > > > thought we decided to just disallow CFI changes in alternatives anyway?
> > > > That can be done much simpler.
> > > 
> > > Something like so then ?
> > > 
> > > ---
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index 8443ec690051..d14d83e6edb0 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -940,6 +940,7 @@ static int handle_group_alt(struct objtool_file *file,
> > >  
> > >  		last_new_insn = insn;
> > >  
> > > +		insn->alt_group = true;
> > >  		insn->ignore = orig_insn->ignore_alts;
> > >  		insn->func = orig_insn->func;
> > >  
> > > @@ -2242,6 +2243,11 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
> > >  	list_for_each_entry(op, &insn->stack_ops, list) {
> > >  		int res;
> > >  
> > > +		if (insn->alt_group) {
> > > +			WARN_FUNC("alternative has CFI", insn->sec, insn->offset);
> > > +			return 1;
> > > +		}
> > > +
> > 
> > ACK (separate patch)
> 
> BTW, since most people don't know what CFI is, how about something like
> 
> 	"unsupported stack change in alternatives code"

Would it be accurate to print

	"unsupported CFI stack change in alternatives code"?

to give the developer something more explicit to plug into their search
engine?

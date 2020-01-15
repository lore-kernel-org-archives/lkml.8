Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF4FC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC922081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgAOW50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:57:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:17719 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730410AbgAOW5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:57:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 14:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="255241149"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2020 14:57:24 -0800
Date:   Wed, 15 Jan 2020 14:57:24 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v11] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200115225724.GA18268@linux.intel.com>
References: <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:27:54PM -0800, Luck, Tony wrote:
> On Mon, Jan 13, 2020 at 09:55:21PM -0800, Sean Christopherson wrote:
> > On Fri, Jan 10, 2020 at 11:24:09AM -0800, Luck, Tony wrote:
> 
> All comments accepted and code changed ... except for these three:

Sounds like you're also writing code, in which case you should give
yourself credit with your own Co-developed-by: tag.

> > > +#define TIF_SLD			18	/* split_lock_detect */
> > 
> > A more informative name comment would be helpful since the flag is set when
> > SLD is disabled by the previous task.  Something like? 
> > 
> > #define TIF_NEED_SLD_RESTORE	18	/* Restore split lock detection on context switch */
> 
> That name is more informative ... but it is also really, really long. Are
> you sure?

Not at all.  I picked a semi-arbitrary name that was similar to existing
TIF names, I'll defer to anyone with an opinion.

> > > +bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> > > +{
> > > +	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> > > +		return false;
> > 
> > Maybe add "|| WARN_ON_ONCE(sld_state != sld_off)" to try to prevent the
> > kernel from going fully into the weeds if a spurious #AC occurs.
> 
> Can a spurious #AC occur? I don't see how.

It's mostly paranoia, e.g. if sld_state==sld_off but the MSR bit was
misconfigured.  No objection if you want to omit the check.

> > > @@ -242,7 +243,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
> > >  {
> > >  	struct task_struct *tsk = current;
> > >  
> > > -
> > 
> > Whitespace.
> > 
> > >  	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
> > >  		return;
> 
> I'm staring at the post patch code, and I can't see what whitespace
> issue you see.

There's a random newline removal in do_trap().  It's a good change in the
sense that it eliminates an extra newline, bad in the sense that it's
unrelated to the rest of the patch.

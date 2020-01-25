Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB16AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD220716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgAYVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:50:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:7059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgAYVuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 16:50:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 13:50:05 -0800
X-IronPort-AV: E=Sophos;i="5.70,363,1574150400"; 
   d="scan'208";a="298427377"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 13:50:05 -0800
Date:   Sat, 25 Jan 2020 13:50:03 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
References: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125212524.GA538225@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125212524.GA538225@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 04:25:25PM -0500, Arvind Sankar wrote:
> On Fri, Jan 24, 2020 at 06:47:27PM -0800, Luck, Tony wrote:
> > I did find something with a new test. Applications that hit a
> > split lock warn as expected. But if they sleep before they hit
> > a new split lock, we get another warning. This is may be because
> > I messed up when fixing a PeterZ typo in the untested patch.
> > But I think there may have been bigger problems.
> > 
> > Context switch in V14 code did: 
> > 
> >        if (tifp & _TIF_SLD)
> >                switch_to_sld(prev_p);
> > 
> > void switch_to_sld(struct task_struct *prev)
> > {
> >        __sld_msr_set(true);
> >        clear_tsk_thread_flag(prev, TIF_SLD);
> > }
> > 
> > Which re-enables split lock checking for the next process to run. But
> > mysteriously clears the TIF_SLD bit on the previous task.
> 
> Did Peter mean to disable it only for the current timeslice and
> re-enable it for the next time its scheduled?

He's seen and commented on this thread since I made this comment. So
I'll assume not.  Things get really noisy on the console (even with
the rate limit) if split lock detection is re-enabled after a context
switch (my new test highlighted this!)

> > +void switch_to_sld(struct task_struct *prev, struct task_struct *next)
> > +{
> > +	bool prevflag = test_tsk_thread_flag(prev, TIF_SLD);
> > +	bool nextflag = test_tsk_thread_flag(next, TIF_SLD);
> > +
> > +	/*
> > +	 * If we are switching between tasks that have the same
> > +	 * need for split lock checking, then the MSR is (probably)
> > +	 * right (modulo the other thread messing with it.
> > +	 * Otherwise look at whether the new task needs split
> > +	 * lock enabled.
> > +	 */
> > +	if (prevflag != nextflag)
> > +		__sld_msr_set(nextflag);
> > +}
> 
> I might be missing something but shouldnt this be !nextflag given the
> flag being unset is when the task wants sld?

That logic is convoluted ... but Thomas showed me a much better
way that is also much simpler ... so this code has gone now. The
new version is far easier to read (argument is flags for the new task
that we are switching to)

void switch_to_sld(unsigned long tifn)
{
        __sld_msr_set(tifn & _TIF_SLD);
}

-Tony

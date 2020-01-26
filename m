Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE9C35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 02:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6639206D3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 02:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAZCwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 21:52:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:54892 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgAZCww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 21:52:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 18:52:27 -0800
X-IronPort-AV: E=Sophos;i="5.70,364,1574150400"; 
   d="scan'208";a="221412012"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 18:52:26 -0800
Date:   Sat, 25 Jan 2020 18:52:25 -0800
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
Message-ID: <20200126025225.GA20804@agluck-desk2.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125212524.GA538225@rani.riverdale.lan>
 <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
 <20200125235130.GA565241@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125235130.GA565241@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 06:51:31PM -0500, Arvind Sankar wrote:
> On Sat, Jan 25, 2020 at 01:50:03PM -0800, Luck, Tony wrote:
> > > 
> > > I might be missing something but shouldnt this be !nextflag given the
> > > flag being unset is when the task wants sld?
> > 
> > That logic is convoluted ... but Thomas showed me a much better
> > way that is also much simpler ... so this code has gone now. The
> > new version is far easier to read (argument is flags for the new task
> > that we are switching to)
> > 
> > void switch_to_sld(unsigned long tifn)
> > {
> >         __sld_msr_set(tifn & _TIF_SLD);
> > }
> > 
> > -Tony
> 
> why doesnt this have the same problem though? tifn & _TIF_SLD still
> needs to be logically negated no?

There's something very odd happening. I added this trace code:

        if ((tifp ^ tifn) & _TIF_SLD) {
                pr_info("switch from %d (%d) to %d (%d)\n",
                        task_tgid_nr(prev_p), (tifp & _TIF_SLD) != 0,
                        task_tgid_nr(next_p), (tifn & _TIF_SLD) != 0);
                switch_to_sld(tifn);
        }

Then ran:

$ taskset -cp 10 $$	# bind everything to just one CPU
pid 3205's current affinity list: 0-55
pid 3205's new affinity list: 10
$ ./spin &		# infinite loop
[1] 3289
$ ./split_lock_test &	# 10 * split lock with udelay(1000) between
[2] 3294

I was expecting to see transitions back & forward between the "spin"
process (which won't have TIF_SLD set) and the test program (which
will have it set after the first split executes).

But I see:
[   83.871629] x86/split lock detection: #AC: split_lock_test/3294 took a split_lock trap at address: 0x4007fc
[   83.871638] process: switch from 3294 (1) to 3289 (0)
[   83.882583] process: switch from 3294 (1) to 3289 (0)
[   83.893555] process: switch from 3294 (1) to 3289 (0)
[   83.904528] process: switch from 3294 (1) to 3289 (0)
[   83.915501] process: switch from 3294 (1) to 3289 (0)
[   83.926475] process: switch from 3294 (1) to 3289 (0)
[   83.937448] process: switch from 3294 (1) to 3289 (0)
[   83.948421] process: switch from 3294 (1) to 3289 (0)
[   83.959394] process: switch from 3294 (1) to 3289 (0)
[   83.970439] process: switch from 3294 (1) to 3289 (0)

i.e. only the switches from the test process to the spinner.

So split-lock testing is disabled when we first hit the #AC
and is never re-enabled because we don't pass through this
code when switching to the spinner.

So you are right that the argument is inverted. We should be
ENABLING split lock when switching to the spin loop process
and we actually disable.

So why don't we come through __switch_to_xtra() when the spinner
runs out its time slice (or the udelay interrupt happens and
preempts the spinner)?

-Tony

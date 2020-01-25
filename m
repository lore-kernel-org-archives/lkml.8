Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE342071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgAYTzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:55:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:34185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbgAYTzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:55:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 11:55:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,363,1574150400"; 
   d="scan'208";a="216907851"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 11:55:14 -0800
Date:   Sat, 25 Jan 2020 11:55:13 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125195513.GA15834@agluck-desk2.amr.corp.intel.com>
References: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125104419.GA16136@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125104419.GA16136@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 11:44:19AM +0100, Borislav Petkov wrote:

Boris,

Thanks for the review. All comments accepted and changes made, except as
listed below.  Also will fix up some other checkpatch fluff.

-Tony


> > +#define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
> 
> Do you really want to have "split_lock_detect" in /proc/cpuinfo or
> rather somethign shorter?

I don't have a good abbreviation.  It would become the joint 2nd longest
flag name ... top ten lengths look like this on my test machine. So while
long, not unprecedented.

18 tsc_deadline_timer
17 split_lock_detect
17 arch_capabilities
16 avx512_vpopcntdq
14 tsc_known_freq
14 invpcid_single
14 hwp_act_window
13 ibrs_enhanced
13 cqm_occup_llc
13 cqm_mbm_total
13 cqm_mbm_local
13 avx512_bitalg
13 3dnowprefetch


> > +static inline bool match_option(const char *arg, int arglen, const char *opt)
> > +{
> > +	int len = strlen(opt);
> > +
> > +	return len == arglen && !strncmp(arg, opt, len);
> > +}
> 
> There's the same function in arch/x86/kernel/cpu/bugs.c. Why are you
> duplicating it here?
> 
> Yeah, this whole chunk looks like it has been "influenced" by the sec
> mitigations in bugs.c :-)

Blame PeterZ for that. For now I'd like to add the duplicate inline function
and then clean up by putting it into some header file (and maybe hunting down
other places where it could be used).

> > +	/*
> > +	 * If this is anything other than the boot-cpu, you've done
> > +	 * funny things and you get to keep whatever pieces.
> > +	 */
> > +	pr_warn("MSR fail -- disabled\n");
> 
> What's that for? Guests?

Also some PeterZ code. As the comment implies we really shouldn't be able
to get here. This whole function should only be called on CPU models that
support the MSR ... but PeterZ is defending against the situation that sometimes
there are special SKUs with the same model number (since we may be here because
of an x86_match_cpu() hit, rather than the architectural enumeration check).

> > +void switch_to_sld(struct task_struct *prev, struct task_struct *next)
> 
> This will get called on other vendors but let's just assume, for
> simplicity's sake, TIF_SLD won't be set there so it is only a couple of
> insns on a task switch going to waste.

Thomas explained how to fix it so we only call the function if TIF_SLD
is set in either the previous or next process (but not both). So the
overhead is just extra XOR/AND in the caller.

-Tony

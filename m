Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA65C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CF120720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBFQqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:46:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:2851 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:46:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:46:17 -0800
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="225069050"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:46:16 -0800
Date:   Thu, 6 Feb 2020 08:46:14 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark D Rustad <mrustad@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
Message-ID: <20200206164614.GA20622@agluck-desk2.amr.corp.intel.com>
References: <4E95BFAA-A115-4159-AA4F-6AAB548C6E6C@gmail.com>
 <C3302B2F-177F-4C39-910E-EADBA9285DD0@intel.com>
 <8CC9FBA7-D464-4E58-8912-3E14A751D243@gmail.com>
 <20200126200535.GB30377@agluck-desk2.amr.corp.intel.com>
 <20200203204155.GE19638@linux.intel.com>
 <20200206004944.GA11455@agluck-desk2.amr.corp.intel.com>
 <CALCETrWmuTbHn9YCpGsWLBjR9rV1QEoEQ-m63NDd9cu7SecV6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWmuTbHn9YCpGsWLBjR9rV1QEoEQ-m63NDd9cu7SecV6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:18:23PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 5, 2020 at 4:49 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > In a context switch from a task that is detecting split locks
> > to one that is not (or vice versa) we need to update the TEST_CTRL
> > MSR. Currently this is done with the common sequence:
> >         read the MSR
> >         flip the bit
> >         write the MSR
> > in order to avoid changing the value of any reserved bits in the MSR.
> >
> > Cache the value of the TEST_CTRL MSR when we read it during initialization
> > so we can avoid an expensive RDMSR instruction during context switch.
> 
> If something else that is per-cpu-ish gets added to the MSR in the
> future, I will personally make fun of you for not making this percpu.

Xiaoyao Li has posted a version using a percpu cache value:

https://lore.kernel.org/r/20200206070412.17400-4-xiaoyao.li@intel.com

So take that if it makes you happier.  My patch only used the
cached value to store the state of the reserved bits in the MSR
and assumed those are the same for all cores.

Xiaoyao Li's version updates with what was most recently written
on each thread (but doesn't, and can't, make use of that because we
know that the other thread on the core may have changed the actual
value in the MSR).

If more bits are implemented that need to be set at run time, we
are likely up the proverbial creek. I'll see if I can find out if
there are plans for that.

-Tony

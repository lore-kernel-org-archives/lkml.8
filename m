Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75288C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44571206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAZUBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:01:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:51976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAZUBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:01:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 12:01:26 -0800
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="217101369"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 12:01:25 -0800
Date:   Sun, 26 Jan 2020 12:01:24 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v16] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200126200124.GA30377@agluck-desk2.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <875zgzmz5e.fsf@nanos.tec.linutronix.de>
 <20200125220706.GA18290@agluck-desk2.amr.corp.intel.com>
 <CALCETrXT9zo2yFN+iz-1ijayOKNNz-717pEJggU1kC79ZVf34g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXT9zo2yFN+iz-1ijayOKNNz-717pEJggU1kC79ZVf34g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 04:34:29PM -0800, Andy Lutomirski wrote:
> Although I suppose the pile of wrmsrl_safes() in the existing patch
> might be sufficient.
> 
> All this being said, the current code appears wrong if a CPU is in the
> list but does have X86_FEATURE_CORE_CAPABILITIES.  Are there such
> CPUs?  I think either the logic should be changed or a comment should
> be added.

Is it really wrong? Code check the CPUID & CORE_CAPABILTIES first and
believes what they say. Otherwise falls back to the x86_match_cpu()
list.

I don't believe we put a CPU on that list that currently says
it supports CORE_CAPABILITIES. That could theoretically change
with a microcode update. I doubt we'd waste microcode space to do
that, but if we did, I assume we'd include the split lock bit
in the newly present MSR. So behavior would not change.

-Tony

Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C99C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A718246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgB1SMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:12:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:61772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1SMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:12:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 10:12:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="437503672"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2020 10:12:32 -0800
Message-ID: <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 28 Feb 2020 10:11:44 -0800
In-Reply-To: <20200228172202.GD25261@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
         <20200121201843.12047-9-yu-cheng.yu@intel.com>
         <20200221175859.GL25747@zn.tnic>
         <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
         <20200228121724.GA25261@zn.tnic>
         <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
         <20200228162359.GC25261@zn.tnic>
         <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
         <20200228172202.GD25261@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 18:22 +0100, Borislav Petkov wrote:
> On Fri, Feb 28, 2020 at 08:20:27AM -0800, Yu-cheng Yu wrote:
> > When XSAVES writes to an xsave buffer, xsave->header.xcomp_bv is set to
> > include only saved components, effectively changing the buffer's format.
> 
> So you want to *save* the supervisor states and xcomp_bv will be set to
> supervisor states only and since we don't care about the user states
> there - they will be loaded later - we're good.

No!

> Or do you have to set xcomp_bv later in order to save the user
> components too and also rearrange the buffer to undo the format change
> above?

That is the case.  If we save only supervisor states, the buffer becomes
smaller and has only supervisor states.

> We have using_compacted_format() and we do conversion from compacted to
> standard buffers - I'm looking at copy_xstate_to_kernel() et al - so it
> shouldn't be impossible. So to repeat Sebastian's question which you
> ignored:
> 
> "How large is this supervisor state at most? I guess saving the AVX512
> state just to get the 2 bytes of the supervisor state at the right spot
> is not really optimal."

I thought Sebastian was saying XSAVES is not optimal.

CET has 16 bytes for ring-3 setting, 24 bytes for ring-0.
Saving supervisor states somewhere else and copying back is not better
either.

> In any case, this performance penalty better be paid only by those
> who are actually using some supervisor states. I haven't looked at
> the CET patchset but I'm assuming you're setting the CET bit in
> xfeatures_mask_all only when the feature is being actually used?

We save supervisor states only when xfeatures_mask_supervisor() is not
zero.

Yu-cheng


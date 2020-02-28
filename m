Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6742469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1QOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:14:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:34048 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1QOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:14:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 08:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="439277163"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga006.fm.intel.com with ESMTP; 28 Feb 2020 08:14:13 -0800
Message-ID: <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
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
Date:   Fri, 28 Feb 2020 07:53:38 -0800
In-Reply-To: <20200228121724.GA25261@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
         <20200121201843.12047-9-yu-cheng.yu@intel.com>
         <20200221175859.GL25747@zn.tnic>
         <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
         <20200228121724.GA25261@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 13:17 +0100, Borislav Petkov wrote:
> On Thu, Feb 27, 2020 at 02:52:12PM -0800, Yu-cheng Yu wrote:
> > > So the code sets TIF_NEED_FPU_LOAD unconditionally, why are you changing
> > > this?
> > > 
> > > Why don't you simply do:
> > > 
> > > 		set_thread_flag(TIF_NEED_FPU_LOAD);
> > > 		fpregs_lock();
> > > 		if (xfeatures_mask_supervisor())
> > > 			copy_xregs_to_kernel(&fpu->state.xsave);
> > > 		fpregs_unlock();
> > 
> > If TIF_NEED_FPU_LOAD is set, then xstates are already in the xsave buffer. 
> > We can skip saving them again.
> 
> Ok, then pls use test_and_set_thread_flag().
> 
> Also, in talking to Sebastian about this on IRC, he raised a valid
> concern: if we are going to save supervisor states here, then
> copy_xregs_to_kernel() should better save *only* supervisor states
> because we're not interested in the user states - they're going to be
> overwritten with the states from the stack.

Yes, saving only supervisor states is optimal, but doing XSAVES with a
partial RFBM changes xcomp_bv.

Yu-cheng


Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDACC3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C63246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgB0XMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:12:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:26298 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgB0XMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:12:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 15:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="317948278"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 15:12:47 -0800
Message-ID: <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
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
Date:   Thu, 27 Feb 2020 14:52:12 -0800
In-Reply-To: <20200221175859.GL25747@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
         <20200121201843.12047-9-yu-cheng.yu@intel.com>
         <20200221175859.GL25747@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-21 at 18:58 +0100, Borislav Petkov wrote:
> On Tue, Jan 21, 2020 at 12:18:43PM -0800, Yu-cheng Yu wrote:
> > [...]
> >  arch/x86/kernel/fpu/signal.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index e3781a4a52a8..0d3e06a772b0 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -327,14 +327,22 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
> >  	}
> >  
> >  	/*
> > -	 * The current state of the FPU registers does not matter. By setting
> > -	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate
> > -	 * is not modified on context switch and that the xstate is considered
> > +	 * Supervisor xstates are not modified by user space input, and
> > +	 * need to be saved and restored.  Save the whole because doing
> > +	 * partial XSAVES changes xcomp_bv.
> > +	 * By setting TIF_NEED_FPU_LOAD it is ensured that our xstate is
> > +	 * not modified on context switch and that the xstate is considered
> 
> Reflow those comments to 80 cols. There's room to the right.
> 
> >  	 * to be loaded again on return to userland (overriding last_cpu avoids
> >  	 * the optimisation).
> >  	 */
> > -	set_thread_flag(TIF_NEED_FPU_LOAD);
> > +	fpregs_lock();
> > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> > +		if (xfeatures_mask_supervisor())
> > +			copy_xregs_to_kernel(&fpu->state.xsave);
> > +		set_thread_flag(TIF_NEED_FPU_LOAD);
> 
> So the code sets TIF_NEED_FPU_LOAD unconditionally, why are you changing
> this?
> 
> Why don't you simply do:
> 
> 		set_thread_flag(TIF_NEED_FPU_LOAD);
> 		fpregs_lock();
> 		if (xfeatures_mask_supervisor())
> 			copy_xregs_to_kernel(&fpu->state.xsave);
> 		fpregs_unlock();

If TIF_NEED_FPU_LOAD is set, then xstates are already in the xsave buffer. 
We can skip saving them again.

Yu-cheng


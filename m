Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A0FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0532083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgD2RCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:02:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:16013 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgD2RCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:02:49 -0400
IronPort-SDR: OnVH5QCIA1TEd9TRkzGzUxpzSAA+w4znlZO3msVnx6qTQiM9eqkmdK/wcAMUyJKYDJ2nJd8SXU
 CMhIEI/FYpXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 10:02:45 -0700
IronPort-SDR: mQULBHZb41yIVnbCt9y5lfq/YPmOopAi1d86ySjeS9k08T2lUaNk7f+0PmCj6GMa7h3CkMF6HB
 +IfCa2rYO9UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="258020657"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2020 10:02:44 -0700
Message-ID: <1b43e3cc36dd707c0268e96b166eca4421d7c2e2.camel@intel.com>
Subject: Re: [PATCH v3 05/10] x86/fpu/xstate: Define new functions for
 clearing fpregs and xstates
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
Date:   Wed, 29 Apr 2020 10:02:46 -0700
In-Reply-To: <20200429163906.GC16407@zn.tnic>
References: <20200328164307.17497-6-yu-cheng.yu@intel.com>
         <20200429160644.28584-1-yu-cheng.yu@intel.com>
         <20200429163906.GC16407@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 18:39 +0200, Borislav Petkov wrote:
> On Wed, Apr 29, 2020 at 09:06:44AM -0700, Yu-cheng Yu wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > Currently, fpu__clear() clears all fpregs and xstates.  Once XSAVES
> > supervisor states are introduced, supervisor settings (e.g. CET xstates)
> > must remain active for signals; It is necessary to have separate functions:
> > 
> > - Create fpu__clear_user_states(): clear only user settings for signals;
> > - Create fpu__clear_all(): clear both user and supervisor settings in
> >    flush_thread().
> > 
> > Also modify copy_init_fpstate_to_fpregs() to take a mask from above two
> > functions.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > 
> > v3:
> > - Put common code into a static function fpu__clear(), with a parameter
> >   user_only.
> > 
> > v2:
> > - Fixed an issue where fpu__clear_user_states() drops supervisor xstates.
> > - Revise commit log.
> 
> Try applying that patch from this mail yourself and see whether the
> patch changelog will remain in the commit message or it will get
> discarded.

My mistake!  I will fix it.

> 
> > @@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
> >   * Called by sys_execve(), by the signal handler code and by various
> >   * error paths.
> >   */
> > -void fpu__clear(struct fpu *fpu)
> > +static void fpu__clear(struct fpu *fpu, int user_only)
> >  {
> > -	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> > +	WARN_ON_FPU(fpu != &current->thread.fpu);
> 
> Why did you remove the side comment?
> 
> Is it wrong?
> 
> Why do you do such arbitrary changes which are not needed instead of
> concentrating on only the changes the patch should do?

It has been some time since Thomas commented on this tail comment.
https://lore.kernel.org/lkml/alpine.DEB.2.21.1908161703010.1923@nanos.tec.linutronix.de/

I think why not fixing it while at it.

Yu-cheng


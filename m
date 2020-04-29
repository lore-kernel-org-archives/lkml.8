Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E0CC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8B62072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgD2QJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:09:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:49801 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD2QJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:09:11 -0400
IronPort-SDR: EKCP6PpRHvDwAO9R9pRS/mqdnRdvDzYchr+U8CPiXsTXrHMkIRk1hGv1baP20o7WbivKsKi/0y
 dzbQNEQQWBOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 09:09:11 -0700
IronPort-SDR: o13zNz1X0zp6nQ4m3uOuK7eeFIPIHlOfwZSrqqI9JIJomJmMZ3m5cm5P8+cYRCH5n77jWhckeA
 bAounM1t1bOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="249494398"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 09:09:11 -0700
Message-ID: <c0177f20d14bd607b8293a802bb16782fae5113d.camel@intel.com>
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
Date:   Wed, 29 Apr 2020 09:09:12 -0700
In-Reply-To: <20200429092735.GA16407@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
         <20200328164307.17497-6-yu-cheng.yu@intel.com>
         <20200429092735.GA16407@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 11:27 +0200, Borislav Petkov wrote:
> On Sat, Mar 28, 2020 at 09:43:02AM -0700, Yu-cheng Yu wrote:
> > @@ -318,18 +313,40 @@ static inline void copy_init_fpstate_to_fpregs(void)
> >   * Called by sys_execve(), by the signal handler code and by various
> >   * error paths.
> >   */
> > -void fpu__clear(struct fpu *fpu)
> > +static void fpu__clear(struct fpu *fpu, int clear_user_only)
> 
> I said:
> 
> "fpu__clear(struct fpu *fpu, bool user_only)"
> 			     ^^^^^^^^^^^^^^
> 
> you made it
> 
> 		     ..., int clear_user_only)
> 
> Why?
> 
> If you agree with the review comment, then please do it as suggested. If
> you don't, then say why you don't.
> 
> Why would you do something in-between?
> 
> >  {
> > -	WARN_ON_FPU(fpu != &current->thread.fpu); /* Almost certainly an anomaly */
> 
> Why are you moving this into the callers when *both* do it?
> 
> > +	if (static_cpu_has(X86_FEATURE_FPU)) {
> 
> Flip this logic:
> 
> 	if (!static_cpu_has(X86_FEATURE_FPU)) {
>                 fpu__drop(fpu);
>                 fpu__initialize(fpu);
> 		return;
> 	}
> 
> 	fpregs_lock();
> 	...
> 
> to save an indentation level and make the important case more readable
> and locking more prominent.

All fixed.

Thanks,
Yu-cheng


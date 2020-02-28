Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBADC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC47246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HEioBiCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1MRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:17:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53952 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgB1MRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:17:32 -0500
Received: from zn.tnic (p200300EC2F08460041E63C1DC591983D.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:4600:41e6:3c1d:c591:983d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B58D1EC02FE;
        Fri, 28 Feb 2020 13:17:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582892250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gpbPci87piKc5kSbTtScQpgQ/Cpf5WwOJ0tjLIp24PA=;
        b=HEioBiCAC03WKPulacDjf2tOeLtLFYa4ps4yMpWhhoCloRf6BRo6g/9tZ2DtJV/wTmgRsm
        KW5vo9RZU2DaUKVUv5MO4WWKRIhWD2YogFUFVCGY81sssSstnXEkE2QZqG9yNjBWzGKSsD
        GKbNlcCvW58dNHqv4FDtFX983cWxtF0=
Date:   Fri, 28 Feb 2020 13:17:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200228121724.GA25261@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-9-yu-cheng.yu@intel.com>
 <20200221175859.GL25747@zn.tnic>
 <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:52:12PM -0800, Yu-cheng Yu wrote:
> > So the code sets TIF_NEED_FPU_LOAD unconditionally, why are you changing
> > this?
> > 
> > Why don't you simply do:
> > 
> > 		set_thread_flag(TIF_NEED_FPU_LOAD);
> > 		fpregs_lock();
> > 		if (xfeatures_mask_supervisor())
> > 			copy_xregs_to_kernel(&fpu->state.xsave);
> > 		fpregs_unlock();
> 
> If TIF_NEED_FPU_LOAD is set, then xstates are already in the xsave buffer. 
> We can skip saving them again.

Ok, then pls use test_and_set_thread_flag().

Also, in talking to Sebastian about this on IRC, he raised a valid
concern: if we are going to save supervisor states here, then
copy_xregs_to_kernel() should better save *only* supervisor states
because we're not interested in the user states - they're going to be
overwritten with the states from the stack.

So copy_xregs_to_kernel() needs to learn about a second parameter called
@mask like copy_kernel_to_xregs().

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

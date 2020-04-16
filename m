Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746CFC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431D62076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587000197;
	bh=WpBtJ2OE7796v0OAM/LxTWCtHsLnk0YxplA1elCpSFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U8k7wcClP+4JkL1gAbaFbs+2ScDpOGJvUIGsNhqR6ZgNBtG1VJHm2FkP91gTWQ2a4
	 60zs6u+bt879G2fTdLYVQNGbo0l6tu3fQDqJUR7lOlTpx3ZdNGkksAcVxAN8UNTxQ+
	 fOUzfP5cKx9jeQhOcvhUMv8ou0D4DI+HtmW2MsRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgDPBXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgDPBWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:22:55 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BCFD208E4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587000174;
        bh=WpBtJ2OE7796v0OAM/LxTWCtHsLnk0YxplA1elCpSFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ua/y4Cs+y4osdY2SSKXr6B/IiqSFdks0EILn0wDqCk6wC3WIV7aST6PZtOuSbOEUs
         aLaU/u5gveKMeAoPtXq2gcvEGYYAD+k8+sIA6nEUKIWC96W+aYD2NWupc4NTldpqix
         EuS4yiPzZYzct+ARMNjEpEh6EzCJL4swgP331xaU=
Received: by mail-wr1-f50.google.com with SMTP id h9so2910616wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:22:54 -0700 (PDT)
X-Gm-Message-State: AGi0Pubv0ZB5z7EXqyOdTS5/p7iQ8POEqyKnCyxGSE1t5HVG2VE69FeE
        Lcm4MVkMWV+dBxTIf5ZROKrlHam4/2fVgO32LD/b3A==
X-Google-Smtp-Source: APiQypKH0Gc84O1GGPl9yxMxB+q91TwBbHMhmQdTlRv52VBqyPcr5bcH+2Dm+pUjhPtse9FHUyL45Vc1TEAic8X84I8=
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr9790817wrn.18.1587000172481;
 Wed, 15 Apr 2020 18:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
 <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net> <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
 <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
 <CABV8kRxfMNxzy8r2P4GKj-22i+GMj=VDfPWAZB-VSgfrsQsjCA@mail.gmail.com>
 <CALCETrWTDrcynTwpWZ6u6JXRL1rz6_vakLK7=BqMjCPCkQ+9dg@mail.gmail.com>
 <CABV8kRzbGgF4Uc9+VyzBUiH-kGfMALd8tDtjE3hjyE2Z5VD3-g@mail.gmail.com> <CABV8kRz0nxSu=Nr-ViGamKd=vZ5-v6=+CFRC19hB+CdQ28C4yg@mail.gmail.com>
In-Reply-To: <CABV8kRz0nxSu=Nr-ViGamKd=vZ5-v6=+CFRC19hB+CdQ28C4yg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 15 Apr 2020 18:22:41 -0700
X-Gmail-Original-Message-ID: <CALCETrWY3tk=NckFjjZ0dixr5WmNTRRw1Wiry0uAjBJw7jnZ3g@mail.gmail.com>
Message-ID: <CALCETrWY3tk=NckFjjZ0dixr5WmNTRRw1Wiry0uAjBJw7jnZ3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 6:17 PM Keno Fischer <keno@juliacomputing.com> wrote:
>
> On Wed, Apr 15, 2020 at 9:14 PM Keno Fischer <keno@juliacomputing.com> wrote:
> >
> > > Would it make matters easier if tasks with nonstandard XCR0 were not
> > > allowed to use ptrace() at all?  And if ARCH_SET_XCR0 were disallowed
> > > if the caller is tracing anyone?
> >
> > That would be fine by me (as long as you're still allowed to ptrace them of
> > course).
>
> Sorry, I realized after I had hit send that this wording may not be clear.
> What I meant was that it would need to be able to have an external ptracer
> (with unmodified XCR0) attach to the task, even if it had modified its XCR0.
> I don't think you were suggesting that that wouldn't be possible,
> but I just wanted to make sure.

Yes, exactly.  Just to make sure we're on the same page, I suggest:

If a process modifies XCR0, then it cannot use ptrace().  Signal
delivery and sigreturn use the modified XCR0.  If you modify your XCR0
from within a signal handler, you get to keep both pieces.  If you
ptrace() a process with a modified XCR0, you see the full regset.
Among other things, this means that you could ptrace() a task with a
reduced XCR0, poke a value in one of the disabled register sets with
ptrace(), and read that same value back out again with ptrace().

Before you implement this, you might want to make sure that at least
one other x86 maintainer agrees with me. :)

I'm sure the CRIU people will notice this and want to find a way to
make ptrace() work from a modified-XCR0 process.  They are welcome to
propose semantics, since neither of the obvious ways to handle it
actually seem correct.

--Andy

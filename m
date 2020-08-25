Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C800C20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598376551;
	bh=dULKwL42q/4e0ZYm77Bn7SwwIszQEJ0OpvMKdcqi0MA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PVvkec6ftdUVXOGsUhrIdeTfc/3ArJQly3BROJNOHTFwVsWs38+ZVumz4oX5K1fd2
	 VaorZx6l9+tUQmqb8Dd6SEk7ut4B9oV+5Nf4ETtrQrLLzF0xDERzXaWDVjcLQRECCC
	 I/iNhe6XOZprGlxZFfRvEnu+c4F5xT9ofvi5+SU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHYR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHYR3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:29:07 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39CE20706
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598376546;
        bh=dULKwL42q/4e0ZYm77Bn7SwwIszQEJ0OpvMKdcqi0MA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bvecNlnLMlcjwul7p3ET+a77aJZgnR/8VkepXcx/zGP9gf8YesuRENsiW/OWgDcQd
         5gDsRx5FSfBRtjfqWxusTidq1RkPDa/ZGB4BSrhd1EsHgxR5MqAPmjK2FyOFCwr9ER
         alShZMj4dN+BJf29ES2MaUPgkaznVUMlK4P2zr/Y=
Received: by mail-wr1-f44.google.com with SMTP id b18so2912666wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:29:05 -0700 (PDT)
X-Gm-Message-State: AOAM532UQch3aCJcC3F3AIVv0JEdqEduZdf3+h9LuEaNb8rAE/M+0UNM
        9cRhZMdZzW3qaI4+wRNncE2cgfws0DAzvtCGsf8NUw==
X-Google-Smtp-Source: ABdhPJz4CCDUcprFA6nGVOXM/R1OoM+JTHDlGCFhpBqDHrxhk4HYGihPyvkMyjNGGKYFJalhS3r2zjfMzH1uuNqzj5g=
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr11454197wrx.257.1598376544496;
 Tue, 25 Aug 2020 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <875z98jkof.fsf@nanos.tec.linutronix.de> <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice> <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice>
In-Reply-To: <20200825171903.GA20660@sjchrist-ice>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Aug 2020 10:28:53 -0700
X-Gmail-Original-Message-ID: <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
Message-ID: <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pu Wen <puwen@hygon.cn>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Dirk Hohndel <dirkhh@vmware.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Gordon Tetlow <gordon@tetlows.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:19 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Aug 25, 2020 at 09:49:05AM -0700, Andy Lutomirski wrote:
> > On Mon, Aug 24, 2020 at 9:40 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > +Andy
> > >
> > > On Mon, Aug 24, 2020 at 02:52:01PM +0100, Andrew Cooper wrote:
> > > > And to help with coordination, here is something prepared (slightly)
> > > > earlier.
> > > >
> > > > https://docs.google.com/document/d/1hWejnyDkjRRAW-JEsRjA5c9CKLOPc6VKJQsuvODlQEI/edit?usp=sharing
> > > >
> > > > This identifies the problems from software's perspective, along with
> > > > proposing behaviour which ought to resolve the issues.
> > > >
> > > > It is still a work-in-progress.  The #VE section still needs updating in
> > > > light of the publication of the recent TDX spec.
> > >
> > > For #VE on memory accesses in the SYSCALL gap (or NMI entry), is this
> > > something we (Linux) as the guest kernel actually want to handle gracefully
> > > (where gracefully means not panicking)?  For TDX, a #VE in the SYSCALL gap
> > > would require one of two things:
> > >
> > >   a) The guest kernel to not accept/validate the GPA->HPA mapping for the
> > >      relevant pages, e.g. code or scratch data.
> > >
> > >   b) The host VMM to remap the GPA (making the GPA->HPA pending again).
> > >
> > > (a) is only possible if there's a fatal buggy guest kernel (or perhaps vBIOS).
> > > (b) requires either a buggy or malicious host VMM.
> > >
> > > I ask because, if the answer is "no, panic at will", then we shouldn't need
> > > to burn an IST for TDX #VE.  Exceptions won't morph to #VE and hitting an
> > > instruction based #VE in the SYSCALL gap would be a CPU bug or a kernel bug.
> >
> > Or malicious hypervisor action, and that's a problem.
> >
> > Suppose the hypervisor remaps a GPA used in the SYSCALL gap (e.g. the
> > actual SYSCALL text or the first memory it accesses -- I don't have a
> > TDX spec so I don't know the details).
>
> You can thank our legal department :-)
>
> > The user does SYSCALL, the kernel hits the funny GPA, and #VE is delivered.
> > The microcode wil write the IRET frame, with mostly user-controlled contents,
> > wherever RSP points, and RSP is also user controlled.  Calling this a "panic"
> > is charitable -- it's really game over against an attacker who is moderately
> > clever.
> >
> > The kernel can't do anything about this because it's game over before
> > the kernel has had the chance to execute any instructions.
>
> Hrm, I was thinking that SMAP=1 would give the necessary protections, but
> in typing that out I realized userspace can throw in an RSP value that
> points at kernel memory.  Duh.
>
> One thought would be to have the TDX module (thing that runs in SEAM and
> sits between the VMM and the guest) provide a TDCALL (hypercall from guest
> to TDX module) to the guest that would allow the guest to specify a very
> limited number of GPAs that must never generate a #VE, e.g. go straight to
> guest shutdown if a disallowed GPA would go pending.  That seems doable
> from a TDX perspective without incurring noticeable overhead (assuming the
> list of GPAs is very small) and should be easy to to support in the guest,
> e.g. make a TDCALL/hypercall or two during boot to protect the SYSCALL
> page and its scratch data.

I guess you could do that, but this is getting gross.  The x86
architecture has really gone off the rails here.

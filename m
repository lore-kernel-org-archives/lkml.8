Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BBC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE84E206EB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598801879;
	bh=Ky8WZcvLA6RRhgL1u44QnF3iAcvOtIXT+Pxx/AL88xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N/iFr/Znwl9n6+9BBixBioJOO9m3d4F+hqTV+Cvt0F0nzt2KSX83/bkZX9Mx7LFE/
	 L5LoJKaijs4hqGHcDbp1gNqucbLGaw9TmDpPHK9Rd/fgdV+tYhyXe9l/5KKBshOllk
	 8xLC1Ocmfw5xA0h8viRvNUr4HRPS65QpHH3enj0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgH3Ph5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgH3Phw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:37:52 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A66208DB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598801872;
        bh=Ky8WZcvLA6RRhgL1u44QnF3iAcvOtIXT+Pxx/AL88xs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vbfkGqLLfy2DbjB/ExklgKrk5bLby4XxBr7haICm78qf4jr/56msMPDO+PDMkEZff
         H3HgwGKuspVp0ACLXkVBjyMeIRixs5BxB7V65ro84b7L41Kpm9PCr2vDWmNZg7Y2XH
         XQLGlWb+idXtRCV9x1ZZ2HCCMcNOAge/wStVHodg=
Received: by mail-wr1-f54.google.com with SMTP id e16so3587995wrm.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 08:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM531SKIVAVtMXQbWPqvKJb7sgbbrqlW35+moh5vuHusgl+cgUv48K
        fC9LJzt6nTKdAC8jfiOZJwq7Wuq4VLLusRDnvgXDsg==
X-Google-Smtp-Source: ABdhPJy1Cig6isTrNsU1CNS0leoIgn3n82Zq+tjXpbvFOUJMC2+LKOujy1Tw3sXuFDGsUypPl+Kmt+Q4EXdL9CY/A9M=
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr1252760wrw.75.1598801870331;
 Sun, 30 Aug 2020 08:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <875z98jkof.fsf@nanos.tec.linutronix.de> <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice> <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice> <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
 <20200826191644.GC21065@sjchrist-ice>
In-Reply-To: <20200826191644.GC21065@sjchrist-ice>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 30 Aug 2020 08:37:39 -0700
X-Gmail-Original-Message-ID: <CALCETrUwqka6M9wxkwFYvq-5Byi8JFiiPNRdYQRw3_2m1hXd0w@mail.gmail.com>
Message-ID: <CALCETrUwqka6M9wxkwFYvq-5Byi8JFiiPNRdYQRw3_2m1hXd0w@mail.gmail.com>
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

On Wed, Aug 26, 2020 at 12:16 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Aug 25, 2020 at 10:28:53AM -0700, Andy Lutomirski wrote:
> > On Tue, Aug 25, 2020 at 10:19 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > > One thought would be to have the TDX module (thing that runs in SEAM and
> > > sits between the VMM and the guest) provide a TDCALL (hypercall from guest
> > > to TDX module) to the guest that would allow the guest to specify a very
> > > limited number of GPAs that must never generate a #VE, e.g. go straight to
> > > guest shutdown if a disallowed GPA would go pending.  That seems doable
> > > from a TDX perspective without incurring noticeable overhead (assuming the
> > > list of GPAs is very small) and should be easy to to support in the guest,
> > > e.g. make a TDCALL/hypercall or two during boot to protect the SYSCALL
> > > page and its scratch data.
> >
> > I guess you could do that, but this is getting gross.  The x86
> > architecture has really gone off the rails here.
>
> Does it suck less than using an IST?  Honest question.
>
> I will add my voice to the "fix SYSCALL" train, but the odds of that getting
> a proper fix in time to intercept TDX are not good.  On the other hand,
> "fixing" the SYSCALL issue in the TDX module is much more feasible, but only
> if we see real value in such an approach as opposed to just using an IST.  I
> personally like the idea of a TDX module solution as I think it would be
> simpler for the kernel to implement/support, and would mean we wouldn't need
> to roll back IST usage for #VE if the heavens should part and bestow upon us
> a sane SYSCALL.

There's no such thing as "just" using an IST.  Using IST opens a huge
can of works due to its recursion issues.

The TDX module solution is utterly gross but may well suck less than
using an IST.

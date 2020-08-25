Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF472C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A242075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHYRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:19:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:25615 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgHYRTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:19:06 -0400
IronPort-SDR: JUcZaUMBFBs3VyyqVsv751mo7zoFYkcNqK8BE9dERjwQms+c0+Kp7gotWiPCRNHSQB4Unfsjm+
 2lLf+Tu3C33w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="240977616"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="240977616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:19:05 -0700
IronPort-SDR: krjUEd96SVu4XLcWJAAUpNkzjjOe59NPZ8snzleXVYa7kPRurHNa29n9kc7zUqyEtSdCxb4F2K
 64Waj9OxekDA==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="322836478"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:19:05 -0700
Date:   Tue, 25 Aug 2020 10:19:03 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
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
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
Message-ID: <20200825171903.GA20660@sjchrist-ice>
References: <875z98jkof.fsf@nanos.tec.linutronix.de>
 <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice>
 <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 09:49:05AM -0700, Andy Lutomirski wrote:
> On Mon, Aug 24, 2020 at 9:40 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > +Andy
> >
> > On Mon, Aug 24, 2020 at 02:52:01PM +0100, Andrew Cooper wrote:
> > > And to help with coordination, here is something prepared (slightly)
> > > earlier.
> > >
> > > https://docs.google.com/document/d/1hWejnyDkjRRAW-JEsRjA5c9CKLOPc6VKJQsuvODlQEI/edit?usp=sharing
> > >
> > > This identifies the problems from software's perspective, along with
> > > proposing behaviour which ought to resolve the issues.
> > >
> > > It is still a work-in-progress.  The #VE section still needs updating in
> > > light of the publication of the recent TDX spec.
> >
> > For #VE on memory accesses in the SYSCALL gap (or NMI entry), is this
> > something we (Linux) as the guest kernel actually want to handle gracefully
> > (where gracefully means not panicking)?  For TDX, a #VE in the SYSCALL gap
> > would require one of two things:
> >
> >   a) The guest kernel to not accept/validate the GPA->HPA mapping for the
> >      relevant pages, e.g. code or scratch data.
> >
> >   b) The host VMM to remap the GPA (making the GPA->HPA pending again).
> >
> > (a) is only possible if there's a fatal buggy guest kernel (or perhaps vBIOS).
> > (b) requires either a buggy or malicious host VMM.
> >
> > I ask because, if the answer is "no, panic at will", then we shouldn't need
> > to burn an IST for TDX #VE.  Exceptions won't morph to #VE and hitting an
> > instruction based #VE in the SYSCALL gap would be a CPU bug or a kernel bug.
> 
> Or malicious hypervisor action, and that's a problem.
> 
> Suppose the hypervisor remaps a GPA used in the SYSCALL gap (e.g. the
> actual SYSCALL text or the first memory it accesses -- I don't have a
> TDX spec so I don't know the details).

You can thank our legal department :-)

> The user does SYSCALL, the kernel hits the funny GPA, and #VE is delivered.
> The microcode wil write the IRET frame, with mostly user-controlled contents,
> wherever RSP points, and RSP is also user controlled.  Calling this a "panic"
> is charitable -- it's really game over against an attacker who is moderately
> clever.
> 
> The kernel can't do anything about this because it's game over before
> the kernel has had the chance to execute any instructions.

Hrm, I was thinking that SMAP=1 would give the necessary protections, but
in typing that out I realized userspace can throw in an RSP value that
points at kernel memory.  Duh.

One thought would be to have the TDX module (thing that runs in SEAM and
sits between the VMM and the guest) provide a TDCALL (hypercall from guest
to TDX module) to the guest that would allow the guest to specify a very
limited number of GPAs that must never generate a #VE, e.g. go straight to
guest shutdown if a disallowed GPA would go pending.  That seems doable
from a TDX perspective without incurring noticeable overhead (assuming the
list of GPAs is very small) and should be easy to to support in the guest,
e.g. make a TDCALL/hypercall or two during boot to protect the SYSCALL
page and its scratch data.

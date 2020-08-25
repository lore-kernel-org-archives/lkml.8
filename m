Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0993520782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598374166;
	bh=9+o+z80XuKuTsz1MzRnkmmu3FeAm+4uaDIsalSIrtzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qLk2qNWbUbWLkubKPg35kgoH/+XM9LhKpWJV10Je+9wTm86o0mDYnv0juXNiC/h8F
	 v7Oz7w4o5pZ52SFZ7jl+ogR/v+Q2H+BZwasVS150h9AbCWVg9WQ+Zjq02YEN96UrxK
	 C0rK6b99w3XIV2xCtCAqTK/YhQ7WeenHzxYJZ63U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgHYQtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgHYQtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:49:18 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21BF320838
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598374158;
        bh=9+o+z80XuKuTsz1MzRnkmmu3FeAm+4uaDIsalSIrtzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G5kzU/Top3evaRqsg/JngO60GDPOmHdgF1IiA7DnM7kQpIAIgH9JYHL+AQ/4FDMMQ
         IIPiMwdA8gUKXyakUON6exDcYM5mmklY0TpTk0QzajA7kI5cCOGDGtdx6ugGFSKNhp
         e7UhjcgH7A1pyFfJmqkPpjRBYKw52TT/0g9Z0InA=
Received: by mail-wm1-f44.google.com with SMTP id a65so3153225wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:49:18 -0700 (PDT)
X-Gm-Message-State: AOAM533X4yUb/sbd82D+cIhEfBijPNz3QDLdk2osftOOLS227kqcuYmr
        Fp57p1wbZA7IAfB8AW8QXNZ+CFuQwofe53v9PeAyLA==
X-Google-Smtp-Source: ABdhPJybv9Ep+O5MydbMzuLt4o7/sm89SqmGv78fUf04FbNxCqfpOgW1FayZEQ5qihXJpZgxRqwnuAQHi3R1SpnnjEw=
X-Received: by 2002:a1c:bc45:: with SMTP id m66mr2531587wmf.36.1598374156654;
 Tue, 25 Aug 2020 09:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <875z98jkof.fsf@nanos.tec.linutronix.de> <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice>
In-Reply-To: <20200825043959.GF15046@sjchrist-ice>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Aug 2020 09:49:05 -0700
X-Gmail-Original-Message-ID: <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
Message-ID: <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
To:     Sean Christopherson <sean.j.christopherson@intel.com>
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
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 9:40 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> +Andy
>
> On Mon, Aug 24, 2020 at 02:52:01PM +0100, Andrew Cooper wrote:
> > And to help with coordination, here is something prepared (slightly)
> > earlier.
> >
> > https://docs.google.com/document/d/1hWejnyDkjRRAW-JEsRjA5c9CKLOPc6VKJQsuvODlQEI/edit?usp=sharing
> >
> > This identifies the problems from software's perspective, along with
> > proposing behaviour which ought to resolve the issues.
> >
> > It is still a work-in-progress.  The #VE section still needs updating in
> > light of the publication of the recent TDX spec.
>
> For #VE on memory accesses in the SYSCALL gap (or NMI entry), is this
> something we (Linux) as the guest kernel actually want to handle gracefully
> (where gracefully means not panicking)?  For TDX, a #VE in the SYSCALL gap
> would require one of two things:
>
>   a) The guest kernel to not accept/validate the GPA->HPA mapping for the
>      relevant pages, e.g. code or scratch data.
>
>   b) The host VMM to remap the GPA (making the GPA->HPA pending again).
>
> (a) is only possible if there's a fatal buggy guest kernel (or perhaps vBIOS).
> (b) requires either a buggy or malicious host VMM.
>
> I ask because, if the answer is "no, panic at will", then we shouldn't need
> to burn an IST for TDX #VE.  Exceptions won't morph to #VE and hitting an
> instruction based #VE in the SYSCALL gap would be a CPU bug or a kernel bug.

Or malicious hypervisor action, and that's a problem.

Suppose the hypervisor remaps a GPA used in the SYSCALL gap (e.g. the
actual SYSCALL text or the first memory it accesses -- I don't have a
TDX spec so I don't know the details).  The user does SYSCALL, the
kernel hits the funny GPA, and #VE is delivered.  The microcode wil
write the IRET frame, with mostly user-controlled contents, wherever
RSP points, and RSP is also user controlled.  Calling this a "panic"
is charitable -- it's really game over against an attacker who is
moderately clever.

The kernel can't do anything about this because it's game over before
the kernel has had the chance to execute any instructions.

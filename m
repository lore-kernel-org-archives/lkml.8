Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7AFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BA820809
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592936829;
	bh=e3u7eLEEiVgkvLGksxftLW9CJqkzsq+PZNCEuWyaMmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d9oY/nZNC0770VtINh9CcrsJhx0SFzZqtQneBtNnw8r2ua6sbhQODV8B+MY3pyS0P
	 83mKD1ygksShrakMnv/HuyqSpeFUbxfstf/D11D3tegjDa03HslDttOpMwBtiY29uU
	 6ntSmdJMZTpsu43plp3qN19hDC95zM2Le+SEB9+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbgFWS1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733125AbgFWS1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:27:07 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C41420842
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592936826;
        bh=e3u7eLEEiVgkvLGksxftLW9CJqkzsq+PZNCEuWyaMmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=df8cmTqu/u475ksvRlgGMGspPrUZ1p4YlTLJWRWJf2sLid0Jg+1PK1r6nHm17M0Nf
         Cs9pG/JyzOOIt6yP8CVgR6gkIFrQyirjD0ndbYEKmArDq+iSaao360C3EcX7/d1YSM
         VHRwBaOLwVvpAT9hUlJJVXqo8l0Og1MbMtH/xeJ0=
Received: by mail-wr1-f52.google.com with SMTP id v3so14077854wrc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:27:06 -0700 (PDT)
X-Gm-Message-State: AOAM532PP9vms/7fwtNQMHYv+Cc9Mtmeyk9P0+BRnQFL450O5jIQ6740
        UDnNiHV9Q68LAjZwjFyu/StwqatJEU2BBLSHhcyiaw==
X-Google-Smtp-Source: ABdhPJz5I7kL1T4ZP6bKS2E9K/nkWfzSSzswn+8HddchIlf6AWc3lOZVTGa8iJYbAb/SvKbx8Na8udAAXAZQ0/7UDfE=
X-Received: by 2002:adf:e482:: with SMTP id i2mr2759106wrm.75.1592936824477;
 Tue, 23 Jun 2020 11:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200425202316.GL21900@8bytes.org> <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200623094519.GF31822@suse.de> <20200623104559.GA4817@hirez.programming.kicks-ass.net>
 <20200623111107.GG31822@suse.de> <20200623111443.GC4817@hirez.programming.kicks-ass.net>
 <20200623114324.GA14101@suse.de> <20200623115014.GE4817@hirez.programming.kicks-ass.net>
 <20200623121237.GC14101@suse.de> <20200623130322.GH4817@hirez.programming.kicks-ass.net>
 <9e3f9b2a-505e-dfd7-c936-461227b4033e@citrix.com>
In-Reply-To: <9e3f9b2a-505e-dfd7-c936-461227b4033e@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 23 Jun 2020 11:26:52 -0700
X-Gmail-Original-Message-ID: <CALCETrWEUXU_BYd5ypF3XC10hSQUJ=XCVz40n3VfcWELS+roTg@mail.gmail.com>
Message-ID: <CALCETrWEUXU_BYd5ypF3XC10hSQUJ=XCVz40n3VfcWELS+roTg@mail.gmail.com>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Mike Stunes <mstunes@vmware.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <JGross@suse.com>,
        Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 8:23 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 23/06/2020 14:03, Peter Zijlstra wrote:
> > On Tue, Jun 23, 2020 at 02:12:37PM +0200, Joerg Roedel wrote:
> >> On Tue, Jun 23, 2020 at 01:50:14PM +0200, Peter Zijlstra wrote:
> >>> If SNP is the sole reason #VC needs to be IST, then I'd strongly urge
> >>> you to only make it IST if/when you try and make SNP happen, not before.
> >> It is not the only reason, when ES guests gain debug register support
> >> then #VC also needs to be IST, because #DB can be promoted into #VC
> >> then, and as #DB is IST for a reason, #VC needs to be too.
> > Didn't I read somewhere that that is only so for Rome/Naples but not for
> > the later chips (Milan) which have #DB pass-through?
>
> I don't know about hardware timelines, but some future part can now opt
> in to having debug registers as part of the encrypted state, and swapped
> by VMExit, which would make debug facilities generally usable, and
> supposedly safe to the #DB infinite loop issues, at which point the
> hypervisor need not intercept #DB for safety reasons.
>
> Its worth nothing that on current parts, the hypervisor can set up debug
> facilities on behalf of the guest (or behind its back) as the DR state
> is unencrypted, but that attempting to intercept #DB will redirect to
> #VC inside the guest and cause fun. (Also spare a thought for 32bit
> kernels which have to cope with userspace singlestepping the SYSENTER
> path with every #DB turning into #VC.)

What do you mean 32-bit?  64-bit kernels have exactly the same
problem.  At least the stack is okay, though.


Anyway, since I'm way behind on this thread, here are some thoughts:

First, I plan to implement actual precise recursion detection for the
IST stacks.  We'll be able to reliably panic when unallowed recursion
happens.

Second, I don't object *that* strongly to switching to a second #VC
stack if an NMI or MCE happens, but we really need to make sure we
cover *all* the bases.  And #VC is distressingly close to "happens at
all kinds of unfortunate times and the guest doesn't actually have
much ability to predice it" right now.  So we have #VC + #DB + #VC,
#VC + NMI + #VC, #VC + MCE + #VC, and even worse options.  So doing
the shift in a reliable way is not necessarily possible in a clean
way.

Let me contemplate.   And maybe produce some code soon.

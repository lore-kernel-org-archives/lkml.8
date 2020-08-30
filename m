Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DECC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCB12078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598812676;
	bh=liuUsMff4Rt4cVF71jKx677UKNdj2jQTAUDPvmqcul8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yL+bpVlCTx/5cg7JBAC/1L4fNgxYgLDVAlZwOomoEkUp6a7oO1na5qeH3SXNZgmPM
	 erZPAJ82k6gbV0TlkmzzB4a6IfOhiuiyVGHREapMpQFgl3gIaF1j6AR9ZPpYdTt2Yk
	 8n3Mggrp+MM2VGayEWVTBhum+NBJ9VwKT+ZC3hCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgH3Shy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgH3Shx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:37:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23829C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:37:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so4221277ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NTYppXVFlAtMJ5lMPooDjQI0LeiUfB45dzpf9LtvXk=;
        b=QQ2VZR83aWyPSugNb4yjiAdB7wS5jzkBO4bRzddE6oyZ7jU9MKbbA2fLOSEqueCFFM
         ThGV8N5/AoI67xjlJ9dAdYvS4tYAnSfKEYAFSjX75o0R5Ejs/H99v0BY6qoBbaYjbpGK
         xDEJUXCBMXj5oyexpFtdYSZEqFBPnpkk0z7pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NTYppXVFlAtMJ5lMPooDjQI0LeiUfB45dzpf9LtvXk=;
        b=JxRvL8glJ8cn64b/QsqFfYNsDxybACjajp7+BSWvzxVw5oVZg71LvRwattMoNiIr5o
         r8XB26FKZzRNKZr6e2EihWxFOekZGngF8U8nNe5HkAnS6fxPbgj4IFvSyfOvaifYMknU
         ilU5FvCeyrqmfzJAlLT+yR+bfocUNlp0UUY3qju3igFA9ZLg0JruW284Jn3pT1jtoiKr
         PwTyZZIcxKswaVwejmG87663JLHpQ2Yh7rhoz1fN66ptd9XCyoZ3f6HFezEX8pYg/Eob
         wxbtsyb50lzBlNoFesIJancX5kBD3pOOvnSXyx95pnucgm/NUIWYmZUbfl0ZEP0tg92L
         +0Zg==
X-Gm-Message-State: AOAM5323CgRptub/KiBKUKKXoooFojXat0g0kh6ja3UxYieHUcncVGkR
        DKvzGnXU+3td6ay/tO3TO4zPbIsX7RoiHQ==
X-Google-Smtp-Source: ABdhPJydPeKHCPnyT6gtEHENxS2TWTYWU9OjslT7G7FvCErQ0zuHc3wOxujb/72OhbJGqjP2gnjUzw==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr3612011ljh.328.1598812671479;
        Sun, 30 Aug 2020 11:37:51 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id w6sm300155ljj.121.2020.08.30.11.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 11:37:51 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y2so4261114ljc.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:37:50 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr3497698lju.102.1598812670449;
 Sun, 30 Aug 2020 11:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <875z98jkof.fsf@nanos.tec.linutronix.de> <3babf003-6854-e50a-34ca-c87ce4169c77@citrix.com>
 <20200825043959.GF15046@sjchrist-ice> <CALCETrUP1T2k3UzZMsXMfAD83xbYEG+nAv3a-LeBjNW+=ijJAg@mail.gmail.com>
 <20200825171903.GA20660@sjchrist-ice> <CALCETrWy2x-RByfknjjKxRbE0LBPk2Ugj1d58xYHb91ogbfnvA@mail.gmail.com>
 <20200826191644.GC21065@sjchrist-ice> <CALCETrUwqka6M9wxkwFYvq-5Byi8JFiiPNRdYQRw3_2m1hXd0w@mail.gmail.com>
In-Reply-To: <CALCETrUwqka6M9wxkwFYvq-5Byi8JFiiPNRdYQRw3_2m1hXd0w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Aug 2020 11:37:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimnCtaDhCswqBUag37J1ALDno5dGv4v8Emv0b7SgVgPw@mail.gmail.com>
Message-ID: <CAHk-=wimnCtaDhCswqBUag37J1ALDno5dGv4v8Emv0b7SgVgPw@mail.gmail.com>
Subject: Re: TDX #VE in SYSCALL gap (was: [RFD] x86: Curing the exception and
 syscall trainwreck in hardware)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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

On Sun, Aug 30, 2020 at 8:37 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> There's no such thing as "just" using an IST.  Using IST opens a huge
> can of works due to its recursion issues.

I absolutely despise all the x86 "indirect system structures". They
are horrible garbage. IST is only yet another example of that kind of
brokenness, and annoys me particularly because it (and swapgs) were
actually making x86 _worse_.

The old i386 exception model was actually better than what x86-64 did,
and IST is a big part of the problem. Just have a supervisor stack,
and push the state on it. Stop playing games with multiple stacks
depending on some magical indirect system state.

Other examples of stupid and bad indirection:

 - the GDT and LDT.

   The kernel should never have to use them. It would be much better
if the segment "shadow" state would stop being shadow state, and be
the REAL state that the kernel (and user space, for that matter)
accesses.

   Yeah, we got halfway there with MSR_FS/GS_BASE, but what a complete
garbage crock that was. So now we're forced to use the selector *and*
the base reghister, and they may be out of sync with each other, so
you have the worst of both worlds.

   Keep the GDT and LDT around for compatibility reasons, so that old
broken programs that want to load the segment state the oldfashioned
way can do so. But make it clear that that is purely for legacy, and
make the modern code just save and restore the actual true
non-indirect segment state.

   For new models, give us a way to load base/limit/permissions
directly, and reset them on kernel entry. No more descriptor table
indirection games.

 - the IDT and the TSS segment.

   Exact same arguments as above. Keep them around for legacy
programs, but let us just set "this is the entrypoint, this the the
kernel stack" as registers. Christ, we're probably better off with one
single entry-point for the whole kernel (ok, give us a separate one
for NMI/MCE/doublefault, since they are _so_ special, and maybe
separate "CPU exceptions" from "external interrupts), together with
just a register that says what the exception was.

 - swapgs needs to die.

   The kernel GS/FS segments should just be separate segment registers
from user space. No "swapping" needed. In CPL0, "gs" just means
something different from user space. No save/restore code for it, no
swapping, no nothing.

Honestly, I think %rsp/%rip could work like that too. Just make "rsp"
and "rip" be a completely different register in kernel mode - rename
it in the front-end of the CPU or whatever.

Imagine not having to save/restore rsp/rip on kernel entry/exit at
all, because returning to user more just implicitly starts using
ursp/urip. And a context switch uses (fast) MSR's to save/restore the
user state (or, since it's actually a real register in the register
file, just a new "mov" instruction to access the user registers).

                 Linus

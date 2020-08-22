Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF83C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1FC2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fGNzcexa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaUrR/w4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHVAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 20:43:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHVAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 20:43:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598056988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9j5b+CtfA3mIyxZyTYcFL91niFPfgh0kPXDP8Y6fJV0=;
        b=fGNzcexaB0EfXZu78Cu1jtyLOEaKC9MQijZNjrtkdIlzqTqFdB/JPyJCgK5EIYlWAOaK/K
        ++gL6+7M5HBZYzfWi5qKwdUClKZs4iz3mCj7toiHgIDdaQvJFkkqlBLOAzeX8r3WkNC77n
        xx2RKtSMIpFKsHDG2z93gHkJt5HduxJdy5MDxWfdeVBglUxW8aj4itx8CDAIKbujmAChSF
        vpWh0DTCX/QR5Gc46ux4/pOvMs7BTm/9UALzLDD8qceJRLvqohcQUkkhZIdLr3vuprJYJL
        JOJm3Okr1GlzTQ89UKw1+oCqhsaOL+WBKBmuMnjdS8mVVTip8kCTnbyvEolKkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598056988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9j5b+CtfA3mIyxZyTYcFL91niFPfgh0kPXDP8Y6fJV0=;
        b=SaUrR/w46g7GN5iqAqa8LUfdWEQVi2MhqeKJbM7aAf1rOy2RvDPGhLDpDnq310TI2ewDfJ
        xkV+f++c/tSQofDA==
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
In-Reply-To: <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
References: <20200527135329.1172644-1-arnd@arndb.de> <878serh1b9.fsf@nanos.tec.linutronix.de> <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com> <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72> <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de> <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de> <20200821230435.GA56974@rani.riverdale.lan> <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
Date:   Sat, 22 Aug 2020 02:43:08 +0200
Message-ID: <87eenzqzmr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21 2020 at 16:16, Nick Desaulniers wrote:
> On Fri, Aug 21, 2020 at 4:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>> On Fri, Aug 21, 2020 at 02:37:48AM +0200, Thomas Gleixner wrote:
>> The gcc bug I linked to earlier is only fixed in gcc-6 onwards. Is that
>
> (based on https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602#c14)
>
>> good enough to remove force_order? I can test gcc-4.9 and gcc-5 to check
>> if it would currently have any impact.

And that test tells you what exactly? That your particular build of
those compilers does not have the problem. A truly scientific approach.

> I think checking the disassemblies with a pre-gcc-6 would be good
> enough then; that bug isn't specific to this particular case.

What? I clearly want a statement from the GCC people that this won't
happen on pre gcc6 compilers and not just some 'works for me' statement
based on a randomly picked compiler build.

Thanks,

        tglx

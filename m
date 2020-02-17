Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC8C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D1C20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAcbX/to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgBQVK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:10:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34331 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:10:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so17477578otl.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 13:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxGKMOcaVmtYBJsQFMG9XcBq+4HK9qOJedimYVGECnc=;
        b=cAcbX/to2FsZm371gcOorgLW4wUJPwgVYzE0wQo+/g8JAurh+6E0dPlKifHY+UkgWI
         H3znjGnqFcQMKH+W1FmGWAKQbOvQaLT/C+eCvutEx4ZUjS0QrdoCxPlsmTesaJWsZZA5
         GeVkfvfNZ0SZM1Oi9Mfs0qRfUpZqAdWpHAk2nv3aGMwRQjQibAFixLQifDYm2M/LLRR0
         SJTQn19ImBGpJP0SJwm9Plp61F5l01agUrX9eIywel4w4E+CPycAM3X4lG1qSh2t+t86
         Mu5/DKJPAKBdaGm6n8U2nkzSPF8m41vR9gEMSykb4VoRuv37Swm1EL17PWdEMKUv6ncn
         2UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxGKMOcaVmtYBJsQFMG9XcBq+4HK9qOJedimYVGECnc=;
        b=CTufYu4DCo0FWxWHIdZuN0nt8HVOBo5X9sQyCm6aXyXhYge/NnMJ7kNiDDRnneUC1G
         FBXuxYZAnmKZWTM4rFSGJS7yxtddq/UpUqOzSjjB2sLIWliMggJkPibFuiDP6QAX0UQO
         L2KHwuLten/Zm5CD09uVmGIvx7CeojFYRMWA5gRq0uxvOP3tsKvXDPWKActbWoih5B61
         J3whOQhx9isbKEYesO++A30CFadmf7zqQmC6gNS8qLi2Y48JI8h5Tw1x70DtxHcPrQi9
         kmW1G+IEeU14NYBovZwQskODaMnUZfPMkAK9MCBgafO3+Ra6GMZoCeNLtGM/JwCir+k+
         3iTA==
X-Gm-Message-State: APjAAAXCAkub+hUAfg/M3IlBN5gqmcNq6rBj6WAqYpiZ3JYQHfXvAkeu
        dNhrp/utInnPzG8pGrd4jitdJxmmLxDiIO4kS6oEag==
X-Google-Smtp-Source: APXvYqxyQp2Q4c69hrEzyecMErq7xSCR4nj5SI/+asKMyk8vddsgezLaExzWs6x+JEjm3LT5MDomIT3FuLnG4Ugyp+I=
X-Received: by 2002:a05:6830:22cc:: with SMTP id q12mr13880885otc.110.1581973853761;
 Mon, 17 Feb 2020 13:10:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
In-Reply-To: <20190110205226.iburt6mrddsxnjpk@treble>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 17 Feb 2020 22:10:27 +0100
Message-ID: <CAG48ez0owFet0E43UAGd7sV9Oi0yhVpWTmy4W+Vm5+0q=74-DA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 9:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Jan 10, 2019 at 09:30:23PM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 09, 2019 at 04:59:35PM -0600, Josh Poimboeuf wrote:
> > > With this version, I stopped trying to use text_poke_bp(), and instead
> > > went with a different approach: if the call site destination doesn't
> > > cross a cacheline boundary, just do an atomic write.  Otherwise, keep
> > > using the trampoline indefinitely.
> >
> > > - Get rid of the use of text_poke_bp(), in favor of atomic writes.
> > >   Out-of-line calls will be promoted to inline only if the call sites
> > >   don't cross cache line boundaries. [Linus/Andy]
> >
> > Can we perserve why text_poke_bp() didn't work? I seem to have forgotten
> > again. The problem was poking the return address onto the stack from the
> > int3 handler, or something along those lines?
>
> Right, emulating a call instruction from the #BP handler is ugly,
> because you have to somehow grow the stack to make room for the return
> address.  Personally I liked the idea of shifting the iret frame by 16
> bytes in the #DB entry code, but others hated it.
>
> So many bad-but-not-completely-unacceptable options to choose from.

Silly suggestion from someone who has skimmed the thread:

Wouldn't a retpoline-style trampoline solve this without needing
memory allocations? Let the interrupt handler stash the destination in
a percpu variable and clear IF in regs->flags. Something like:

void simulate_call(unsigned long target) {
  __this_cpu_write(static_call_restore_if, (regs->flags & X86_EFLAGS_IF) != 0);
  regs->flags &= ~X86_EFLAGS_IF;
  __this_cpu_write(static_call_trampoline_source, regs->ip + 5);
  __this_cpu_write(static_call_trampoline_target, target);
  regs->ip = magic_static_call_trampoline;
}

magic_static_call_trampoline:
; set up return address for returning from target function
pushl PER_CPU_VAR(static_call_trampoline_source)
; set up retpoline-style return address
pushl PER_CPU_VAR(static_call_trampoline_target)
; restore flags if needed
cmp PER_CPU_VAR(static_call_restore_if), 0
je 1f
sti ; NOTE: percpu data must not be accessed past this point
1:
ret ; "return" to the call target

By using a return to implement the call, we don't need any scratch
registers for the call.

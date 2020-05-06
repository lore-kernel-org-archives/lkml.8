Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11867C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB67920747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hTM+BjtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgEFT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:57:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 12:57:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so1608328pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LNWHRG4K9qHI5KbbCb7GvYbHc9+TzAyl6TbfjrwoBuU=;
        b=hTM+BjtBnFZtKGIuuVr1uHGZY8KttAiB447/OV3KVAm6Mzgo6MnZy6cw8eULbEDNGe
         5r523gTuG6H6kqM9YdCetLO0CIofvXNBiVwhKGWx7UUDUvJvnPh4+dV8/4M4Y01TtABS
         pPjhGqwByARidKZ2AE6V7EN3P6Y1r/JPHvk/9IdACcoURSwnG0fs9J2pQhoLrPErVz5i
         cqy7qlR8KIfZmVjV/tdKkxjbdFbucgxqkg2K2LA+LrrCHwk1QIRsXvjkaf0R3WvqruvC
         oMTUy8rWmDqtbZkZfa9tmp40Lg0M5RvorAF3ZLUDuxdKbGZ3IuonfQKg7Vch5ClgtAxB
         IJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LNWHRG4K9qHI5KbbCb7GvYbHc9+TzAyl6TbfjrwoBuU=;
        b=mMMXWPPT46s8rK6xMyebySC7JiBs5bHnF/IOR6Zzm+ynga5cjkm9MYMxdnFpaTV21d
         DE3Yh4GMvkfBxVoUNHegCLQWthDuB7D8OUwycvih9YiQHl2l15Xfrsv0CZf7+KaMq7bE
         p27zejCf5kbZ8GKmGAEpZy+eyttg/oeyu6z3zSjcyKvkNPJXWzzUrk2gX8Oe/zczkYTs
         /StnnVJIHKUJEyU6Vb1uX4W1q3k47tdMao4fcCRTTaN4LI1Vos+jMrG8vUdStilzAUQD
         CmetGK2xDa2zKYiqpAROFwYAdbNRAQabw4EhZ3Xm9xUfJ/gGMdIcvLkHKdlxyXW20xHC
         rQbw==
X-Gm-Message-State: AGi0PuZuSvsqilqv8IDVrtQqyAd0wCRjL1BJ0jdb6d38V+uuzsinzSg5
        R63Bke5xSlhz3B5JM4bj5Dd6bw==
X-Google-Smtp-Source: APiQypKu900R3JSW8vrIuLL8qd/ssvOhtxw/ZYMXpkmnTQgg0cMFio1kuAlXr8hUy1z7JM3iG2fgSA==
X-Received: by 2002:aa7:8489:: with SMTP id u9mr10209486pfn.248.1588795033916;
        Wed, 06 May 2020 12:57:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:da1:bee0:4d4f:1387? ([2601:646:c200:1ef2:da1:bee0:4d4f:1387])
        by smtp.gmail.com with ESMTPSA id t76sm2273100pgb.33.2020.05.06.12.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 12:57:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Date:   Wed, 6 May 2020 12:57:02 -0700
Message-Id: <88AE3649-C2E6-4965-86B5-C8FE9D226293@amacapital.net>
References: <CAHk-=wjdLY-E3m21_QcHUauakW3qAAOCe2rxzuFEm-Af_oqG0g@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
In-Reply-To: <CAHk-=wjdLY-E3m21_QcHUauakW3qAAOCe2rxzuFEm-Af_oqG0g@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 6, 2020, at 10:23 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
> =EF=BB=BFOn Wed, May 6, 2020 at 6:51 AM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>>=20
>> I was hoping for:
>>=20
>>        bar:                                    # @bar
>>                movl    %edi, .L_x$local(%rip)
>>                retq
>>        ponies:                                 # @ponies
>>                movq    .Lfoo$local(%rip), %rax
>>                testq   %rax, %rax
>>                jz      1f
>>                jmpq    *%rcx                   # TAILCALL
>>        1:
>>                retq
>=20
> If you want to just avoid the 'cmov', the best way to do that is to
> insert a barrier() on one side of the if-statement.
>=20
> That breaks the ability to turn the conditional jump into a cmov.

Having done this in the past, you can get potentially better code with asm v=
olatile (=E2=80=9C=E2=80=9D); than with a barrier and its memory clobber. I d=
on=E2=80=99t know if that will make a difference in this particular case.=

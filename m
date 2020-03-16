Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1559C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6921720663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv2J3Jh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbgCPUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:40:05 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37383 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732516AbgCPUkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:40:04 -0400
Received: by mail-qv1-f67.google.com with SMTP id n1so5888203qvz.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwiLZWZJb8LiTm8ChhHd1B7qjQwdImHaIuZO9qfo7Wk=;
        b=iv2J3Jh3WGpOtrZZo0BUOC8zfCEp1RreMxscAFeisExPnF+fn8M1sV5Biw+viJS2KQ
         tB92PwP/q6Z9Oy3CmhZIixYUJIPgoxlWpEBDWPUKs0jsgcol2cZ/KX0SMQIn1fOsIiXL
         B5G4IkZxRzwL9YLoLis36ChA1ULWssU0UQDEv1skK2Lk1E9cx4qd1Uk5KBays/IpYpPL
         uN4kdVZm1svPKQ8bv/ik1B8wCm+dE4a3a1QwKueppZ8OmFogsZMS6YLdkYs5CC+EImme
         Dx/fdNhe/QegIDXVeCQXirnSdT7EtahJ9OfHiNMJGPqNus2CDeFvegINY4IOe74KCxve
         7pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwiLZWZJb8LiTm8ChhHd1B7qjQwdImHaIuZO9qfo7Wk=;
        b=KLr6hre4e9+ad6Sx8jGznGMtnEtnSklKgnKaWzD+MF8HjDSKAIrfu96qSETj7LVLf0
         C7ozAUhCtRmNmDUhjuDsjgdVJ1zo6+CPxk+rAaYPIGO9GIekTLJk581hrnjJmyek3KAX
         ckXKUQTJ1+S8mak/g4YrX416KT6r7KeTvD/yTTY92b7xBl4AmKhaCs9iIyV2mgrqsp/P
         g4gnmSIYrTSGhTKFEs4MlB5IEq2qVTMlT0OXJtmA6UtrEe9NPj7SnEahvjKNp9K7KjQ0
         +EZO2IXk/uvWU4PH3Tw+XXXV5jXg0ffiXGkp5X1iFTvzs7LrzYAd0ZoG253IQHCNxxxK
         ZEiA==
X-Gm-Message-State: ANhLgQ14oAGTqFB/Z/tXAZH7GnSuCbRVbfjsekyyB2z8/C5NSAU5Vzu6
        27U6bR0Q+MEfwphyKJEaRY8=
X-Google-Smtp-Source: ADFU+vv2+vKfio6iiWvZ0GA+eJ3vXgQOR2sOWbIcab5wTSzUjjumuTV6Xiw8aziHro3crbDxEPO+Sw==
X-Received: by 2002:a0c:c246:: with SMTP id w6mr1690744qvh.250.1584391203426;
        Mon, 16 Mar 2020 13:40:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i13sm523174qke.56.2020.03.16.13.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 13:40:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 16 Mar 2020 16:40:01 -0400
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316204000.GB768497@rani.riverdale.lan>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316181957.GA348193@rani.riverdale.lan>
 <20200316185418.GA372474@rani.riverdale.lan>
 <20200316195340.GA768497@rani.riverdale.lan>
 <20200316200855.GS2156@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316200855.GS2156@tucnak>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 09:08:55PM +0100, Jakub Jelinek wrote:
> On Mon, Mar 16, 2020 at 03:53:41PM -0400, Arvind Sankar wrote:
> > > /*
> > >  * Initialize the stackprotector canary value.
> > >  *
> > >  * NOTE: this must only be called from functions that never return,
> > >  * and it must always be inlined.
> > >  */
> > > static __always_inline void boot_init_stack_canary(void)
> > 
> > Ugh, gcc10 tail-call optimizes the cpu_startup_entry call, and so checks
> > the canary before jumping out. The xen one will need to have stack
> > protector disabled too. It doesn't optimize the arch_call_rest_init call
> > in start_kernel for some reason, but we should probably disable it there
> > too.
> 
> If you mark cpu_startup_entry with __attribute__((noreturn)), then gcc won't
> tail call it.

So I've actually noticed this before -- what's the reason we don't
tail-call optimize calls to noreturn functions? The code remains a call
with nothing after it, but wouldn't a jump still be better? Or if it has
to be a call, at least an undefined opcode or int 3 after the call in
case it was erroneously annotated and returns anyway?

objtool apparently doesn't like what gcc does when calling noreturn
functions, complains about control falling through to next function.
Though it isn't good enough to detect that that's happening even in
start_secondary because there's some cold code following the call :)

init/main.o: warning: objtool: rest_init() falls through to next function kernel_init()

> If you don't, you could add asm (""); after the call to avoid the tail call
> too.
> > 
> >      a06:       0f ae f8                sfence
> >      a09:       48 8b 44 24 08          mov    0x8(%rsp),%rax
> >      a0e:       65 48 2b 04 25 28 00    sub    %gs:0x28,%rax
> >      a15:       00 00
> >      a17:       75 1b                   jne    a34 <start_secondary+0x164>
> >      a19:       48 83 c4 10             add    $0x10,%rsp
> >      a1d:       bf 8d 00 00 00          mov    $0x8d,%edi
> >      a22:       5b                      pop    %rbx
> >      a23:       e9 00 00 00 00          jmpq   a28 <start_secondary+0x158>
> >                         a24: R_X86_64_PLT32     cpu_startup_entry-0x4
> >      a28:       0f 01 1d 00 00 00 00    lidt   0x0(%rip)        # a2f <start_secondary+0x15f>
> >                         a2b: R_X86_64_PC32      debug_idt_descr-0x4
> >      a2f:       e9 cc fe ff ff          jmpq   900 <start_secondary+0x30>
> >      a34:       e8 00 00 00 00          callq  a39 <start_secondary+0x169>
> >                         a35: R_X86_64_PLT32     __stack_chk_fail-0x4
> 
> 	Jakub
> 

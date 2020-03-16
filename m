Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A95206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceDaX64L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbgCPSyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:54:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44688 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:54:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so11560981qkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j32gmo/PWyKSH2KKl33eo3+SCvi6lrdhWIC2GDs4hzo=;
        b=ceDaX64LDB5mV76tG8Bfals1ox4n3w7v0y7LV6OXFe9M/JiYK9sujkHWz9OmhJxnYn
         hYPrupyZqumt9QjZsOnn9N8YFbwAGhIbs0U+uuDnGHwzmUrCtX471/atMrDkGA0XomNL
         GCU7E48vn+AEVU8KyP9so9W6hJQ8Idf2svmRw6eFz45mKsWurYtCxDHuFVNMy2+6YFKO
         o7e341biClIFOGiTO0/g1cVuXBgxIzSEIqd2Py2b2iQ9Uc4wP2a6hCyRLGy1ufYIvRVu
         y+9do1eQ0MPGGMCgJOpzMPYv61AVi/ntYbvnPPiZu/cOU55uk1f1FqsvT0PbY/ZAFyp1
         yJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j32gmo/PWyKSH2KKl33eo3+SCvi6lrdhWIC2GDs4hzo=;
        b=KOLk2J891fseUg/Ys8QrFTdDr9yMFJfbjGevOOKLU+a6ra20+AY3M/legZzRzffi12
         EvddT2jx7/76B60Pm6QSuA/A2vAAywo8L8hFXQPltXEdcz+9hUSQU4PJSHv5VzrdxIoL
         xso8D7MIiqfX/2MszYYmGnMAfrUHI+kNDmrUeHBWZpZavQtvgvT1DAO0D6CKlA9ZduGb
         iSPp3fCDLJTNfPhO1UtJy8fDPEwOELtbareA6Tz4ARonQC9Oez6lojaoK94b0zXSCv1g
         eae+MVgLDtDO/RSw2R9I1rwwLauUzxoIqSLE0iw56h1rzCUkbqOtrfhTP0OSnQJ9Wqsu
         j1Nw==
X-Gm-Message-State: ANhLgQ3NRRI9RdBt5DqvVUsCxwWRPoSsiS5UCSaSJs219I/26Q/bKX4W
        2CRe7gE7/4huGZQz2gj61to=
X-Google-Smtp-Source: ADFU+vuldi0WS5oZiFmvPDbwNsuRDauCg5AB7Cz2t4qWxrvcHDggnvOpefb9qoF2jqItmlnq/j4Mfg==
X-Received: by 2002:a37:b944:: with SMTP id j65mr1154498qkf.374.1584384863306;
        Mon, 16 Mar 2020 11:54:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w16sm334727qkw.37.2020.03.16.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 11:54:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 16 Mar 2020 14:54:21 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316185418.GA372474@rani.riverdale.lan>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316181957.GA348193@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316181957.GA348193@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:20:00PM -0400, Arvind Sankar wrote:
> On Mon, Mar 16, 2020 at 06:54:50PM +0100, Borislav Petkov wrote:
> > On Mon, Mar 16, 2020 at 02:42:34PM +0100, Peter Zijlstra wrote:
> > > Right I know, I looked for it recently :/ But since this is new in 10
> > > and 10 isn't released yet, I figured someone can add the attribute
> > > before it does get released.
> > 
> > Yes, that would be a good solution.
> > 
> > I looked at what happens briefly after building gcc10 from git and IINM,
> > the function in question - start_secondary() - already gets the stack
> > canary asm glue added so it checks for a stack canary.
> > 
> > However, the stack canary value itself gets set later in that same
> > function:
> > 
> >         /* to prevent fake stack check failure in clock setup */
> >         boot_init_stack_canary();
> > 
> > so the asm glue which checks for it would need to reload the newly
> > computed canary value (it is 0 before we compute it and thus the
> > mismatch).
> > 
> > So having a way to state "do not add stack canary checking to this
> > particular function" would be optimal. And since you already have the
> > "stack_protect" function attribute I figure adding a "no_stack_protect"
> > one should be easy...
> > 
> > > > Or of course you could add noinline attribute to whatever got inlined
> > > > and contains some array or addressable variable that whatever
> > > > -fstack-protector* mode kernel uses triggers it.  With -fstack-protector-all
> > > > it would never work even in the past I believe.
> > > 
> > > I don't think the kernel supports -fstack-protector-all, but I could be
> > > mistaken.
> > 
> > The other thing I was thinking was to carve out only that function into
> > a separate compilation unit and disable stack protector only for it.
> > 
> > All IMHO of course.
> > 
> > Thx.
> > 
> > -- 
> > Regards/Gruss,
> >     Boris.
> > 
> > https://people.kernel.org/tglx/notes-about-netiquette
> 
> With STACKPROTECTOR_STRONG, gcc9 (at least gentoo's version, not sure if
> they have some patches that affect it) already adds stack canary into
> start_secondary. Not sure why it doesn't panic already with gcc9?
> 
> 00000000000008f0 <start_secondary>:
>      8f0:       53                      push   %rbx
>      8f1:       48 83 ec 10             sub    $0x10,%rsp
>      8f5:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
>      8fc:       00 00
>      8fe:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>      903:       31 c0                   xor    %eax,%eax
> ...
>      a2e:       e8 00 00 00 00          callq  a33 <start_secondary+0x143>
>                         a2f: R_X86_64_PLT32     cpu_startup_entry-0x4
>      a33:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>      a38:       65 48 33 04 25 28 00    xor    %gs:0x28,%rax
>      a3f:       00 00 
>      a41:       75 12                   jne    a55 <start_secondary+0x165>
>      a43:       48 83 c4 10             add    $0x10,%rsp
>      a47:       5b                      pop    %rbx
>      a48:       c3                      retq   
>      a49:       0f 01 1d 00 00 00 00    lidt   0x0(%rip)        # a50 <start_secondary+0x160>
>                         a4c: R_X86_64_PC32      debug_idt_descr-0x4
>      a50:       e9 cb fe ff ff          jmpq   920 <start_secondary+0x30>
>      a55:       e8 00 00 00 00          callq  a5a <start_secondary+0x16a>
>                         a56: R_X86_64_PLT32     __stack_chk_fail-0x4

Wait a sec, this function calls cpu_startup_entry as the last thing it
does, which should never return, and hence the stack canary value should
never get checked.

How does the canary get checked with the gcc10 code?

boot_init_stack_canary depends on working if called from functions that
don't return. If that doesn't work with gcc10, we need to disable stack
protector for the other callpoints too -- start_kernel in init/main.c
and cpu_bringup_and_idle in arch/x86/xen/smp_pv.c.

/*
 * Initialize the stackprotector canary value.
 *
 * NOTE: this must only be called from functions that never return,
 * and it must always be inlined.
 */
static __always_inline void boot_init_stack_canary(void)

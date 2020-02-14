Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC3EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763CF222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swshXf0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgBNUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:42:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39583 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbgBNUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:42:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id a141so642613qkg.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nO59hUcE7IAJE3zl0mbNkPEwvhdB+UVqeIgDKUs84Ak=;
        b=swshXf0SIC4WNhSIsQrpE90ysrITW7yjyqmRIF0RHAdEvpNJzRA5vPXAaQi7C5gef+
         a+r2RfJVkAx03vCINteSPG3v/r9uj0gZaBL2DXtI0xYo17wUHAIw1WklX/M7mAcdVHFV
         S1PdreyqydjIu+f07MEzMcBhNQ7HfYVJ9HkhdQMBzGaflbNHUWG+RhKP9UL8rJNuRgix
         rULGzvVhlcEtuwW+rhDJv3N5TiBnHQajiN87L1YghChGndqDX00zxbuy6TtH83DmrNX2
         xMyuAEqK86fVXZHObLwPyXLWNJAoRnCLGaUope383wHjgxgXsBbGZvmRxrVnSO6aIQ/r
         uHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nO59hUcE7IAJE3zl0mbNkPEwvhdB+UVqeIgDKUs84Ak=;
        b=rsRnTAhWPRMPIlZXCQ+SlOWtRUNhCJeszz4iY8obOtWkcvQdGOrDSdQN/dn+IaMJIu
         uyijT5YQZJHb3/0rS0Jejq4dX3vykRXMH6zd4+zELeO6RrbAU1U97zFI6Cm2TjmCHWWT
         UOURC0iQQK23yLmzyKn66yttUOgdxwQ3MtbxfW/laohEb/qAuYEDBaANtnVJdqFkgIiR
         OOFMq9SJ+nQzJ35XR5Ttmvc7AHDoPaSr2niwBsiO7MXR+e7Hxi6SMi75icWlxC2hyYgI
         k7tIw9nPX20gQ5jrT0qI+l81R+dyIhfyj1udfyjGBkhidKe+mm5P06MRhONNWbTOTCev
         7CVQ==
X-Gm-Message-State: APjAAAUgFOk+3Y41LAZ5w3DlTGk4P1Qx6eAQESUBle1dt1GOJBAa/1fR
        UFn3dg9W+b7KUS2GqkqbGvg=
X-Google-Smtp-Source: APXvYqza0rMpkCzLPb1r+My9D3WHs6x3Bi0wcZbTZTlUxE3+NYSvgLIVtAMit812cYoBJ0FhpnHE+w==
X-Received: by 2002:a37:a84f:: with SMTP id r76mr4303279qke.115.1581712971940;
        Fri, 14 Feb 2020 12:42:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n191sm4033808qkn.6.2020.02.14.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:42:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 14 Feb 2020 15:42:49 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        jpoimboe@redhat.com, peterz@infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200214204249.GA3624438@rani.riverdale.lan>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213192055.23kn5pp3s6gwxamq@google.com>
 <20200214061654.GA3136404@rani.riverdale.lan>
 <20200214180527.z44b4bmzn336mff2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214180527.z44b4bmzn336mff2@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:05:27AM -0800, Fangrui Song wrote:
> I know little about objtool, but if it may be used by other
> architectures, hope the following explanations don't appear to be too
> off-topic:)
> 
> On 2020-02-14, Arvind Sankar wrote:
> >Can you describe what case the clang change is supposed to optimize?
> >AFAICT, it kicks in when the symbol is known by the compiler to be local
> >to the DSO and defined in the same translation unit.
> >
> >But then there are two cases:
> >(a) we have call foo, where foo is defined in the same section as the
> >call instruction. In this case the assembler should be able to fully
> >resolve foo and not generate any relocation, regardless of whether foo
> >is global or local.
> 
> If foo is STB_GLOBAL or STB_WEAK, the assembler cannot fully resolve a
> reference to foo in the same section, unless the assembler can assume
> (the codegen tells it) the call to foo cannot be interposed by another
> foo definition at runtime.

I was testing with hidden/protected visibility, I see you want this for
the no-semantic-interposition case. Actually a bit more testing shows
some peculiarities even with hidden visibility. With the below, the call
and lea create relocations in the object file, but the jmp doesn't. ld
does avoid creating a plt for this though.

	.text
	.globl foo, bar
	.hidden foo
	bar:
		call	foo
		leaq	foo(%rip), %rax
		jmp	foo

	foo:	ret

> 
> >(b) we have call foo, where foo is defined in a different section from
> >the call instruction. In this case the assembler must generate a
> >relocation regardless of whether foo is global or local, and the linker
> >should eliminate it.
> >In what case does does replacing call foo with call .Lfoo$local help?
> 
> For -fPIC -fno-semantic-interposition, the assembly emitter can perform
> the following optimization:
> 
>    void foo() {}
>    void bar() { foo(); }
> 
>    .globl foo, bar
>    foo:
>    .Lfoo$local:
>      ret
>    bar:
>      call foo  --> call .Lfoo$local
>      ret
> 
> call foo generates an R_X86_64_PLT32. In a -shared link, it creates an
> unneeded PLT entry for foo.
> 
> call .Lfoo$local generates an R_X86_64_PLT32. In a -shared link, .Lfoo$local is
> non-preemptible => no PLT entry is created.
> 
> For -fno-PIC and -fPIE, the final link is expected to be -no-pie or
> -pie. This optimization does not save anything, because PLT entries will
> not be generated. With clang's integrated assembler, it may increase the
> number of STT_SECTION symbols (because .Lfoo$local will be turned to a
> STT_SECTION relative relocation), but the size increase is very small.
> 
> 
> I want to teach clang -fPIC to use -fno-semantic-interposition by
> default. (It is currently an LLVM optimization, not realized in clang.)
> clang traditionally makes various -fno-semantic-interposition
> assumptions and can perform interprocedural optimizations even if the
> strict ELF rule disallows them.

FWIW, gcc with no-semantic-interposition also uses local aliases, but
rather than using .L labels, it creates a local alias by
	.set foo.localalias, foo
This makes the type of foo.localalias the same as foo, which I gather
should placate objtool as it'll still see an STT_FUNC no matter whether
it picks up foo.localalias or foo.

Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABFDC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05D20726
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhOOE++P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBNWUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:20:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45675 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbgBNWUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:20:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so4217596pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tiLMcpuQCJowZpF4KBzP5ytOkA1tgz9FkwQwKlIP3sE=;
        b=YhOOE++P6kYMuMuhkdWRWy5XJyL2B/TzXIj8QsnEu1pySzHwEOUFpCFui7Aqbki08p
         yi+BXp/zwmMDszuZg3Qdtmg8W0WMyH2f3OAB8CioH3H/1NB9q7vH/+7X4BmWpzn3FkCl
         O3Z8voKShuXW71uTp61tcRsZc/LMYl/O518WL80EjU0b3AEGG7fO7sAF4ofW7YIb9sYn
         Dw7/TQB46X8ARY3A9YwPNm2tr9hmXZhFvCKDRLRDN0xczr2m0xKFCMLabeIvOCzDYfwf
         bHZFZXzXWBqhp89cf8YqOituFsHMHzyw8Aad/RkSV50iJNzUGEPyJnWCv6K9QFnciazq
         2jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tiLMcpuQCJowZpF4KBzP5ytOkA1tgz9FkwQwKlIP3sE=;
        b=B1sYqZsAJYTH2PXF1SYnDBLUYeJCXWyBCxp7scFR0mfrcYQwjHOeefHNN16XRWIBRq
         ZCD2GHS6uGzM052FS6IGRPXyOIM/m/MyTDScnC7WQ+L9vWks3vSDb0smZEVAUi6yKmDq
         SIPumw25OCua0AmTOe2y/Q4RXm9i3P3GMHkq9DBHCZExBZGeGfYuySNSUMu19EbuTlmb
         7SuntgY1vEdFKwPaQpGb8twGiIp1VsuPR8AeN8eu24pZS0y3qvvM/LmFjhAR1vkHWSLT
         ONcTXeTgEANxx0WxzkuRIMms71dmKlumUt21dwjWDju9w2OsgUlw7ow5hpqX3NM8Dmqp
         blnw==
X-Gm-Message-State: APjAAAV4MkcvUI7Qa02WQrhAWhFwNDELrgZE2lcNH9283y4hXDqnaoQL
        X9dOaXROewGd7bP31HFGpkx2JQ==
X-Google-Smtp-Source: APXvYqyp3fOvzSBLpD53RFWuvIKCoJc04JYrln/0ld4GwUyz1v/QbOBUuFhdv+T6DEpdYYRetCSWvg==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr5525465pls.310.1581718849867;
        Fri, 14 Feb 2020 14:20:49 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id p16sm7816969pgi.50.2020.02.14.14.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:20:49 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:20:46 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, jpoimboe@redhat.com,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200214222046.bkafub6dbtapgter@google.com>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213192055.23kn5pp3s6gwxamq@google.com>
 <20200214061654.GA3136404@rani.riverdale.lan>
 <20200214180527.z44b4bmzn336mff2@google.com>
 <20200214204249.GA3624438@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200214204249.GA3624438@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-14, Arvind Sankar wrote:
>On Fri, Feb 14, 2020 at 10:05:27AM -0800, Fangrui Song wrote:
>> I know little about objtool, but if it may be used by other
>> architectures, hope the following explanations don't appear to be too
>> off-topic:)
>>
>> On 2020-02-14, Arvind Sankar wrote:
>> >Can you describe what case the clang change is supposed to optimize?
>> >AFAICT, it kicks in when the symbol is known by the compiler to be local
>> >to the DSO and defined in the same translation unit.
>> >
>> >But then there are two cases:
>> >(a) we have call foo, where foo is defined in the same section as the
>> >call instruction. In this case the assembler should be able to fully
>> >resolve foo and not generate any relocation, regardless of whether foo
>> >is global or local.
>>
>> If foo is STB_GLOBAL or STB_WEAK, the assembler cannot fully resolve a
>> reference to foo in the same section, unless the assembler can assume
>> (the codegen tells it) the call to foo cannot be interposed by another
>> foo definition at runtime.
>
>I was testing with hidden/protected visibility, I see you want this for
>the no-semantic-interposition case. Actually a bit more testing shows
>some peculiarities even with hidden visibility. With the below, the call
>and lea create relocations in the object file, but the jmp doesn't. ld
>does avoid creating a plt for this though.
>
>	.text
>	.globl foo, bar
>	.hidden foo
>	bar:
>		call	foo
>		leaq	foo(%rip), %rax
>		jmp	foo
>
>	foo:	ret

Yes, GNU as is inconsistent here.  While fixing
https://sourceware.org/ml/binutils/2020-02/msg00243.html , I noticed
that the rule is quite complex. There are definitely lots of places to
improve.  clang 10 emits relocations consistently.

   call	foo              # R_X86_64_PLT32
   leaq	foo(%rip), %rax  # R_X86_64_PC32
   jmp	foo              # R_X86_64_PLT32

We can teach the assembler to not emit relocations referencing STV_HIDDEN or
STV_INTERNAL symbols, but I favor the simpler rule that only relocations
referencing STB_LOCAL non-STT_GNU_IFUNC symbols defined in the same section are resolved.
Leave the visibility jobs to the linker.

If we ever teach GNU objcopy or llvm-objcopt an option to set
visibility, resolving relocations may disallow such use cases.

Unfortunately gcc>=5 x86 and GNU ld>=2.26 x86 are in a bad status
regarding STV_PROTECTED (https://reviews.llvm.org/D72197#1866384).
(Now I retest it, I think I may add a special -no-integrated-as rule to
clang just to work around GNU ld x86>=2.26.)

>> >(b) we have call foo, where foo is defined in a different section from
>> >the call instruction. In this case the assembler must generate a
>> >relocation regardless of whether foo is global or local, and the linker
>> >should eliminate it.
>> >In what case does does replacing call foo with call .Lfoo$local help?
>>
>> For -fPIC -fno-semantic-interposition, the assembly emitter can perform
>> the following optimization:
>>
>>    void foo() {}
>>    void bar() { foo(); }
>>
>>    .globl foo, bar
>>    foo:
>>    .Lfoo$local:
>>      ret
>>    bar:
>>      call foo  --> call .Lfoo$local
>>      ret
>>
>> call foo generates an R_X86_64_PLT32. In a -shared link, it creates an
>> unneeded PLT entry for foo.
>>
>> call .Lfoo$local generates an R_X86_64_PLT32. In a -shared link, .Lfoo$local is
>> non-preemptible => no PLT entry is created.
>>
>> For -fno-PIC and -fPIE, the final link is expected to be -no-pie or
>> -pie. This optimization does not save anything, because PLT entries will
>> not be generated. With clang's integrated assembler, it may increase the
>> number of STT_SECTION symbols (because .Lfoo$local will be turned to a
>> STT_SECTION relative relocation), but the size increase is very small.
>>
>>
>> I want to teach clang -fPIC to use -fno-semantic-interposition by
>> default. (It is currently an LLVM optimization, not realized in clang.)
>> clang traditionally makes various -fno-semantic-interposition
>> assumptions and can perform interprocedural optimizations even if the
>> strict ELF rule disallows them.
>
>FWIW, gcc with no-semantic-interposition also uses local aliases, but
>rather than using .L labels, it creates a local alias by
>	.set foo.localalias, foo
>This makes the type of foo.localalias the same as foo, which I gather
>should placate objtool as it'll still see an STT_FUNC no matter whether
>it picks up foo.localalias or foo.

The GCC approach costs more bytes. foo.localalias is not prefixed by .L,
thus it wastes sizeof(Elf*_Sym) bytes for each such function.

      5: 0000000000401000     7 FUNC    LOCAL  DEFAULT    1 foo.localalias

Call/jump relocations on ARM and MIPS treat STT_FUNC differently.
If eventually we use the clang optimization for ARM and MIPS, we
probably should consider changing `.Lfoo$local:` to `.set .Lfoo$local, foo`
The assembler is quite complex. I need to investigate more into LLVM MC.

R_ARM_CALL/R_ARM_THM_CALL can be used against STT_NOTYPE symbols.
That disables interwork thunks (https://reviews.llvm.org/D73542).
If objtool is used by ARM and such disabling semantic is ever needed,
the rule should be loosened to allow STT_NOTYPE.

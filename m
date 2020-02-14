Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8710C3B1B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4C2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5AmDy0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391642AbgBNSFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:05:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36828 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbgBNSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:05:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so5252186pfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PeJVIEeg3tPQINwbm2y3Jjzsm6FgJXYc98QBZ5VnR4=;
        b=X5AmDy0koPxHa3FXVlVNXC5GRkH+MypAPLkG1iYq293gW8Hu59/dvez7dVkjkygWhK
         pmEf4mwGZC/ZEdK9qKmZqyhzF/rj6qutlX8on6FC0tVMwYILg1Mtj6ze6Hrauz0Vm8em
         k7mh60J/kqwEGidfAQvvEFq+dZM/irbQ+1FXKq3J2s1r/iJliXcSnLgXrZsRooT5ZmSl
         A9LHjWYSkJsPBuLoHXqtb0B71ZjaMMj80hXBSpp1IKSufV385R9jUV3EL61dakE/7Quw
         qKmmTOh9oCedlFug9SbxngbCsjI2d6BrtdzjtGqDHysTOyUdeFxenVndWh2dlOLAnen9
         LMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PeJVIEeg3tPQINwbm2y3Jjzsm6FgJXYc98QBZ5VnR4=;
        b=o0BsjX9ICEjpfHMcw5zBsHxQHlRai9V5Ha/vfRaJXemLaEZktv8QRfWyG0EOm5p2Uo
         V6uCg3eat6OdMurmdOzK8v3WmNc/5gGxIh3g0Kqs3LdAxSCBzEVR2VxDuSsE01BWhcjs
         YdTP0IDPNhftMJnfPS4k8kW3PUUOrPuGulSx3ck/V7AralcL+aikMN8ScxPaG9FTwvx4
         U5WuFAEoGEnqhHx/FlAxVIlPKOWQ57pWUkYc6b/Depyl0rzidecxYSWFQiCAIv2Q3vOj
         5rXKuMRVFl2hMGsi8d4h7iEs4+BV/N5r5UsAYd9gNImb7aVRv6F9bKHCTiosUi33hrLZ
         ZPeA==
X-Gm-Message-State: APjAAAVg4usuGo1D9rDIvPz7IvBdof4YNPXqCIggO8w3LLMA0G386NRC
        OhRkkmBEG4OKY7Gh8SdaYr8Zmw==
X-Google-Smtp-Source: APXvYqzwS1u3R0qkJViYDmwkbl/4A7ldgXR8I3CqSydNDrM+iNJ355KUhkxhJte4M+6mfkKogfumtg==
X-Received: by 2002:a63:ba03:: with SMTP id k3mr5028786pgf.52.1581703530837;
        Fri, 14 Feb 2020 10:05:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id p16sm7474658pgi.50.2020.02.14.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:05:30 -0800 (PST)
Date:   Fri, 14 Feb 2020 10:05:27 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, jpoimboe@redhat.com,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200214180527.z44b4bmzn336mff2@google.com>
References: <20200213184708.205083-1-ndesaulniers@google.com>
 <20200213192055.23kn5pp3s6gwxamq@google.com>
 <20200214061654.GA3136404@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200214061654.GA3136404@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know little about objtool, but if it may be used by other
architectures, hope the following explanations don't appear to be too
off-topic:)

On 2020-02-14, Arvind Sankar wrote:
>On Thu, Feb 13, 2020 at 11:20:55AM -0800, Fangrui Song wrote:
>> On 2020-02-13, Nick Desaulniers wrote:
>> >Top of tree LLVM has optimizations related to
>> >-fno-semantic-interposition to avoid emitting PLT relocations for
>> >references to symbols located in the same translation unit, where it
>> >will emit "local symbol" references.
>> >
>> >Clang builds fall back on GNU as for assembling, currently. It appears a
>> >bug in GNU as introduced around 2.31 is keeping around local labels in
>> >the symbol table, despite the documentation saying:
>> >
>> >"Local symbols are defined and used within the assembler, but they are
>> >normally not saved in object files."
>>
>> If you can reword the paragraph above mentioning the fact below without being
>> more verbose, please do that.
>>
>> If the reference is within the same section which defines the .L symbol,
>> there is no outstanding relocation. If the reference is outside the
>> section, there will be an R_X86_64_PLT32 referencing .L
>>
>
>Can you describe what case the clang change is supposed to optimize?
>AFAICT, it kicks in when the symbol is known by the compiler to be local
>to the DSO and defined in the same translation unit.
>
>But then there are two cases:
>(a) we have call foo, where foo is defined in the same section as the
>call instruction. In this case the assembler should be able to fully
>resolve foo and not generate any relocation, regardless of whether foo
>is global or local.

If foo is STB_GLOBAL or STB_WEAK, the assembler cannot fully resolve a
reference to foo in the same section, unless the assembler can assume
(the codegen tells it) the call to foo cannot be interposed by another
foo definition at runtime.

>(b) we have call foo, where foo is defined in a different section from
>the call instruction. In this case the assembler must generate a
>relocation regardless of whether foo is global or local, and the linker
>should eliminate it.
>In what case does does replacing call foo with call .Lfoo$local help?

For -fPIC -fno-semantic-interposition, the assembly emitter can perform
the following optimization:

   void foo() {}
   void bar() { foo(); }

   .globl foo, bar
   foo:
   .Lfoo$local:
     ret
   bar:
     call foo  --> call .Lfoo$local
     ret

call foo generates an R_X86_64_PLT32. In a -shared link, it creates an
unneeded PLT entry for foo.

call .Lfoo$local generates an R_X86_64_PLT32. In a -shared link, .Lfoo$local is
non-preemptible => no PLT entry is created.

For -fno-PIC and -fPIE, the final link is expected to be -no-pie or
-pie. This optimization does not save anything, because PLT entries will
not be generated. With clang's integrated assembler, it may increase the
number of STT_SECTION symbols (because .Lfoo$local will be turned to a
STT_SECTION relative relocation), but the size increase is very small.


I want to teach clang -fPIC to use -fno-semantic-interposition by
default. (It is currently an LLVM optimization, not realized in clang.)
clang traditionally makes various -fno-semantic-interposition
assumptions and can perform interprocedural optimizations even if the
strict ELF rule disallows them.

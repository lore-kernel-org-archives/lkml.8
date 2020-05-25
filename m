Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 757A32076C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GePoBYiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbgEYAzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 20:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbgEYAzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:55:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74986C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 17:55:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c75so7989188pga.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rnfFBtWF5NwtLUph1toRJ0xIkBihpsO8Cu7DfqjU0eE=;
        b=GePoBYiXn6i8aqhxGud16lszJHgXq125GOd1K8ZgiRSHLoSzF7pBXhT85Uwy1lhs5N
         fuN41a4GnWbb8kXhGbV/p4JOSGDdFwArXuRX1pPGS8RCP3WmLt2AjqBRadaKvhZYMOsD
         eqqJYGRqnaWF0YY9Hj0r2SQdTiVdTuDP8ZFVbkw3MnMfRv0l+5PEzj9Gf1OUB91w9GoV
         922CerV5UFiza6YHSBgr5wfmCOjTtUvVHnlvdke1eVwCz0xHcXS8QsK29dCGLOfA0SKf
         JqXR574HUmvFg8EVQja1p1tgOco+ApSAr8OkEWSGsB1DcimT4Da3lRiFIiHMhK+TLNou
         tzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnfFBtWF5NwtLUph1toRJ0xIkBihpsO8Cu7DfqjU0eE=;
        b=cP/P41c6xAuYfb9osMsr5/lPZlEbkrfPEQXuJSp0IzPy+XFHJImiyMSF/FWxH1Xn6f
         XNoJUgocsj0POM+WReRcmRYnXrxJtP41cS7QfhDD3j1Oihi8oJ8X4L+BnH1z1fiAXgQv
         AUU30AGbPpWkEBNrVF8rbSJerxx6xvDB7t6Qf9QwClM4GW3PjcPvfu0V4yEz49sKTb2x
         N2z91uSvSvb6K2NtsdS9rbW+8rx9mmwZKiQk8ff27zTtpX8ulSKAmN5Car6veLkWf6ZW
         gx2+k8sw0q7ojGs22DIwJBIFiPEjkXjXdNFYBKfi13zDzBYdlho9Nd9hHSFV5YkrQSqY
         E8XQ==
X-Gm-Message-State: AOAM533/1cfxrFa1N56ioZanjFpCo/cY3el7tv/vG+bRXpSLBhTaJh8W
        +l+4xlJ//NcgDBNn4mc3PqkCFg==
X-Google-Smtp-Source: ABdhPJwh3KB4C+Khpc7Zmz/QvDGCjPpG4hD+x5kgIIdY3H60A8WqFMj58COohO0fDiNuVq9iew/IEA==
X-Received: by 2002:aa7:8bcd:: with SMTP id s13mr3561374pfd.321.1590368116689;
        Sun, 24 May 2020 17:55:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id q12sm10798602pfn.129.2020.05.24.17.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 17:55:15 -0700 (PDT)
Date:   Sun, 24 May 2020 17:55:11 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: Remove runtime relocations from .head.text
 code
Message-ID: <20200525005511.2aar7gfnklbnzj74@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-3-nivedita@alum.mit.edu>
 <20200524225359.wnc43jmh6rvfaezq@google.com>
 <20200524234402.GB280334@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524234402.GB280334@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-05-24, Arvind Sankar wrote:
>On Sun, May 24, 2020 at 03:53:59PM -0700, Fangrui Song wrote:
>> On 2020-05-24, Arvind Sankar wrote:
>> >The assembly code in head_{32,64}.S, while meant to be
>> >position-independent, generates run-time relocations because it uses
>> >instructions such as
>> >	leal	gdt(%edx), %eax
>> >which make the assembler and linker think that the code is using %edx as
>> >an index into gdt, and hence gdt needs to be relocated to its run-time
>> >address.
>> >
>> >With the BFD linker, this generates a warning during the build:
>> >  LD      arch/x86/boot/compressed/vmlinux
>> >ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-only section `.head.text'
>> >ld: warning: creating a DT_TEXTREL in object
>>
>> Interesting. How does the build generate a warning by default?
>> Do you use Gentoo Linux which appears to ship a --warn-shared-textrel
>> enabled-by-default patch? (https://bugs.gentoo.org/700488)
>
>Ah, yes I am using gentoo. I didn't realize that was a distro
>modification.
>
>> >+
>> >+/*
>> >+ * This macro gives the link address of X. It's the same as X, since startup_32
>> >+ * has link address 0, but defining it this way tells the assembler/linker that
>> >+ * we want the link address, and not the run-time address of X. This prevents
>> >+ * the linker from creating a run-time relocation entry for this reference.
>> >+ * The macro should be used as a displacement with a base register containing
>> >+ * the run-time address of startup_32 [i.e. la(X)(%reg)], or as an
>> >+ * immediate [$ la(X)].
>> >+ *
>> >+ * This macro can only be used from within the .head.text section, since the
>> >+ * expression requires startup_32 to be in the same section as the code being
>> >+ * assembled.
>> >+ */
>> >+#define la(X) ((X) - startup_32)
>> >+
>>
>> IIRC, %ebp contains the address of startup_32. la(X) references X
>> relative to startup_32. The fixup (in GNU as and clang integrated
>> assembler's term) is a constant which is resolved by the assembler.
>>
>> There is no R_386_32 or R_386_PC32 for the linker to resolve.
>
>This is incorrect (or maybe I'm not understanding you correctly). X is a
>symbol whose final location relative to startup_32 is in most cases not
>known to the assembler (there are a couple of cases where X is a label
>within .head.text which do get completely resolved by the assembler).
>
>For example, taking the instruction loading the gdt address, this is
>what we get from the assembler:
>	lea	la(gdt)(%ebp), %eax
>becomes in the object file:
>  11:   8d 85 00 00 00 00       lea    0x0(%ebp),%eax
>			13: R_X86_64_PC32       .data+0x23
>or a cleaner example using a global symbol:
>	subl	la(image_offset)(%ebp), %ebx
>becomes
>  41:   2b 9d 00 00 00 00       sub    0x0(%ebp),%ebx
>			43: R_X86_64_PC32       image_offset+0x43
>
>So in general you get PC32 relocations, with the addend being set by the
>assembler to .-startup_32, modulo the adjustment for where within the
>instruction the displacement needs to be. These relocations are resolved
>by the static linker to produce constants in the final executable.
>

You are right. I am not familiar with the code and only looked at 1b.

Just preprocessed head_64.S and verified many target symbols are in
.data and .pgtable  The assembler converts an expression `foo - symbol_defined_in_same_section`
to be `foo - . + offset` which can be encoded as an R_X86_64_PC32 (or
resolved the fixup if it is a constant, e.g. `1b - startup_32`)

>>
>> Not very sure stating that "since startup_32 has link address 0" is very
>> appropriate here (probably because I did't see the term "link address"
>> before). If my understanding above is correct, I think you can just
>> reword the comment to express that X is referenced relative to
>> startup_32, which is stored in %ebp.
>>
>
>Yeah, the more standard term is virtual address/VMA, but that sounds
>confusing to me with PIE code since the _actual_ virtual address at
>which this code is going to run isn't 0, that's just the address assumed
>for linking. I can reword it to avoid referencing "link address" but
>then it's not obvious why the macro is named "la" :) I'm open to
>suggestions on a better name, I could use offset but that's a bit
>long-winded. I could just use vma() if nobody else finds it confusing.
>
>Thanks.

With your approach, the important property is that "the distance between
startup_32 and the target symbol is a constant", not that "startup_32
has link address 0".  `ra`, `rva`, `rvma` or any other term which expresses "relative"
should work.  Hope someone can come up with a good suggestion:)

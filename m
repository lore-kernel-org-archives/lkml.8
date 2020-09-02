Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C69620773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnk+c8Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIBQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgIBQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:14:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA27C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:14:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o64so155603qkb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wfu3+LD5LYR9xjUm060ljmpR4bdkzzrekUkQirlGcak=;
        b=rnk+c8BqbbNLwwgHLjq5yKxsCA5qTHCSv2hR5J9gD4gXNVpnQzsC4j0nmhXJMyN+e8
         V0rnrO+dFhaeScv09/+jFTIxjtTNc4gTQc8Cjgiuk6dBCHZQkHWJQExFqhcxvX5bRPC/
         Z6YKot23H3CmMguddd9Obby1nOSTHen+P3d2CFt6TTlU5FVYRBYJOIq9vyULNKVpxZuy
         KNzNKOyltmRdGWHL390JxqkPka7ub/0DEn1R/ZiCqgt46Ypi+E322K+Uxrgn1XqNypsG
         CsXQC7AeKJ3WDkgyewAwEBr+rG/x7pSjBFi5S6JpO8A3CtUAzB5dqZ+vA9J2ofado0Nm
         Nayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Wfu3+LD5LYR9xjUm060ljmpR4bdkzzrekUkQirlGcak=;
        b=syJN33/mIsGU3wg7X3M4lQoJ62c44/lvevOUug+oPX9m3tG2WwWNEiAub/RSCRDD9F
         h7zoejDggQdPXYf0q4+I953e585fTuVLyDOTtIQ3a1mA8u7++cdGNrAa+dr3xAau05mz
         LuXSX+GxSHVKkQkbnpzGYIwB+2z/FXEn3JNz/FvQOZ3zX5ODZv/PX68VzVeiO2Gljvk4
         wEtRxp0XFSNYcEDMSIpzHnABXSuKkccrE8gXvhMfGJtjsSrAdFzLA6fbKXl4LaAeL62K
         qwB2hQtPsnUOa4Xp9boL8ebU2nqmUvwrXNdEtDIfwFWO5b9kEHvDyXUaaAHsxrXgGGxi
         /OKg==
X-Gm-Message-State: AOAM531jOAzMj2+WXCBfFSH3sXFq7tM/BJwIcL0NrjFNEio8Q2u9V8Sz
        K5pJ9FYZflA0iJRg9Cxe5Q8=
X-Google-Smtp-Source: ABdhPJz++BESwCj61Ss6UGWLqP9WWYdFuX2daonTAihLYQDmW6SbzW2KWN22eNPI/JY/Rmham54+hw==
X-Received: by 2002:a37:9945:: with SMTP id b66mr7728406qke.51.1599063272786;
        Wed, 02 Sep 2020 09:14:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v39sm5180655qtv.47.2020.09.02.09.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:14:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 2 Sep 2020 12:14:29 -0400
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Message-ID: <20200902161429.GB3297881@rani.riverdale.lan>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902153346.3296117-1-nivedita@alum.mit.edu>
 <55a35a3d8fba417aabe63ad13d519198@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55a35a3d8fba417aabe63ad13d519198@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:58:38PM +0000, David Laight wrote:
> From: Arvind Sankar
> > Sent: 02 September 2020 16:34
> > 
> > The CRn accessor functions use __force_order as a dummy operand to
> > prevent the compiler from reordering the inline asm.
> > 
> > The fact that the asm is volatile should be enough to prevent this
> > already, however older versions of GCC had a bug that could sometimes
> > result in reordering. This was fixed in 8.1, 7.3 and 6.5. Versions prior
> > to these, including 5.x and 4.9.x, may reorder volatile asm.
> > 
> > There are some issues with __force_order as implemented:
> > - It is used only as an input operand for the write functions, and hence
> >   doesn't do anything additional to prevent reordering writes.
> > - It allows memory accesses to be cached/reordered across write
> >   functions, but CRn writes affect the semantics of memory accesses, so
> >   this could be dangerous.
> > - __force_order is not actually defined in the kernel proper, but the
> >   LLVM toolchain can in some cases require a definition: LLVM (as well
> >   as GCC 4.9) requires it for PIE code, which is why the compressed
> >   kernel has a definition, but also the clang integrated assembler may
> >   consider the address of __force_order to be significant, resulting in
> >   a reference that requires a definition.
> > 
> > Fix this by:
> > - Using a memory clobber for the write functions to additionally prevent
> >   caching/reordering memory accesses across CRn writes.
> > - Using a dummy input operand with an arbitrary constant address for the
> >   read functions, instead of a global variable. This will prevent reads
> >   from being reordered across writes, while allowing memory loads to be
> >   cached/reordered across CRn reads, which should be safe.
> 
> How much does using a full memory clobber for the reads cost?
> 
> It would remove any chance that the compiler decides it needs to
> get the address of the 'dummy' location into a register so that
> it can be used as a memory reference in a generated instruction
> (which is probably what was happening for PIE compiles).
> 
> 	David
> 

It doesn't cost much. When I tested it, the only differences were in
startup code and sleep/hibernate/reboot code.

The compiler doesn't load 0x1000 into a register even for PIE code, the
reason it was doing it with a real symbol is to go through the GOT.

Thanks.

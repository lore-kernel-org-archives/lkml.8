Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED8BC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABBE20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="laStFcPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgICCRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICCRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:17:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63503C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 19:17:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so808611pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 19:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IHLgwRN3gkcsqO4620zdyxmJ2uNXW71sGgDdH/6/SQs=;
        b=laStFcPAe3ZhoOqAQcPEXoO1gMeXCDC8Khu2qeHxqRZQnTkOz+SKjxx1jrDIR70bSH
         78+Q4QU1NycsWlO00PwGibP+KvZ+KZI9z4ohtnM0Fc/NXszR4PBHvY4LATHc3SKDuHYt
         jTaj1Rc/4nmzsSJr5Er/ST8YJiQ2yQZ78et6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IHLgwRN3gkcsqO4620zdyxmJ2uNXW71sGgDdH/6/SQs=;
        b=JOz7MtCdlMYUI+crx0LYsTxgfYj+OTG11xA5QTD83ZCRA0y+qXiJRl68G7NsL3RftQ
         2TNcqKdU31gtVIkd7ultNxdzsi+kIGXids/2y08jZ/4wQObXW/90mu8HyMArV6NJBlTr
         kgYmtR8ahJdmKtffkJ0TJiO/OM1EwfAbiUfX90WKBpQHoYPzPvqEtRi+DLgFy1MM7myN
         /hRlhxs3jZJs2agc1u5Xelf3aKeaaxHWlA3DUyGM4ouYoBaR1m3POe9KuGf6zfH1/tAd
         dlxZLRqi36vE5Vf4omBdCVbSskhH0cg1VtSQTDHsBvLFPpkecehFZKLr9qYdELPsDYJg
         /N4A==
X-Gm-Message-State: AOAM5309C9ykynio7MkY1QIBrM56jqLcjccdGMD8MAiz0YUjcgm6tUCm
        BBtjh2L3fKb9eJspj79roq4kKg==
X-Google-Smtp-Source: ABdhPJwbLYpaRcCjH8tDBeiwJAWeN+DjKOIz/O5l80+MMupLZqwfc1kwR0KcvFc0w+IDpPtNvX8pww==
X-Received: by 2002:a63:920e:: with SMTP id o14mr803345pgd.367.1599099452818;
        Wed, 02 Sep 2020 19:17:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k35sm638776pgb.39.2020.09.02.19.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 19:17:31 -0700 (PDT)
Date:   Wed, 2 Sep 2020 19:17:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3] x86/asm: Replace __force_order with memory clobber
Message-ID: <202009021916.CD41C28A52@keescook>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902232152.3709896-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902232152.3709896-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 07:21:52PM -0400, Arvind Sankar wrote:
> The CRn accessor functions use __force_order as a dummy operand to
> prevent the compiler from reordering CRn reads/writes with respect to
> each other.
> 
> The fact that the asm is volatile should be enough to prevent this:
> volatile asm statements should be executed in program order. However GCC
> 4.9.x and 5.x have a bug that might result in reordering. This was fixed
> in 8.1, 7.3 and 6.5. Versions prior to these, including 5.x and 4.9.x,
> may reorder volatile asm statements with respect to each other.
> 
> There are some issues with __force_order as implemented:
> - It is used only as an input operand for the write functions, and hence
>   doesn't do anything additional to prevent reordering writes.
> - It allows memory accesses to be cached/reordered across write
>   functions, but CRn writes affect the semantics of memory accesses, so
>   this could be dangerous.
> - __force_order is not actually defined in the kernel proper, but the
>   LLVM toolchain can in some cases require a definition: LLVM (as well
>   as GCC 4.9) requires it for PIE code, which is why the compressed
>   kernel has a definition, but also the clang integrated assembler may
>   consider the address of __force_order to be significant, resulting in
>   a reference that requires a definition.
> 
> Fix this by:
> - Using a memory clobber for the write functions to additionally prevent
>   caching/reordering memory accesses across CRn writes.
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Seems reasonable to me. As reasonable as compiler bug workarounds
go, that is. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

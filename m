Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C952BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5ED2078A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 01:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsPMZ5su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHWBQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 21:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHWBQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 21:16:56 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA8C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 18:16:56 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so2315888qvb.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMZwOnPr/kgr8gJIALudEGJEnhBEYV4zfZwOjTzah9Q=;
        b=ZsPMZ5suHCRYgZmkwNSWpd6HJbQI/JDLVImdhWuxIDy7gGhqkYl4qUPihJfWztd2DA
         bAB27cDYV5cOhUk+QtFLKeUZ9I+WOfaRfNSQIDB8mGshEDu6Wn66GnjEQmTqjmEc2Fhs
         PpWL2xFVnCncpBRij3V9bx0WLWbih8cdF6zn2wxKKYobGJUIthDSvrM5nKU/wWMjri5D
         dCgwbboFZE9kMTOEFPcM1s7bpt/s/71OADWz9EKwfI4toN3aD2OuHnozDiB4i12zk8i1
         6nYsBW0Nv6ezuKmWybBgPqwWV7yclEGefai/x5qHTZUOOrwDivtkPNBB4HPuTrHXJQxm
         M6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KMZwOnPr/kgr8gJIALudEGJEnhBEYV4zfZwOjTzah9Q=;
        b=a5Xv1aITS78I23hpw9cwDME/ZpnlRw0qRvSmBuwrRgeigvwcqHAiStOjIzjFCASm0q
         +RPSYQR64lNFfKSZUiyVt1v4my8zFX0xkQr1z9dhk4GPRZyJ/1nQcHKAW2d2uOcHeZBk
         sYIbwhcA69QRsSOiLP6Zw8eWK+tBkPBomeZk2Bo+zfRZHhIs/eUxsUVkgjeAU6phN6jW
         WVNLRevLNU5TZY0omSqvhO07kXrxukL/tYD5cYfQX/WnouVnXnYBKE+CZ5uyJ8G4n0jm
         mQCKGvVGKjeqOPJiu5/LO7Be8FGgLYXqEsk4YDEQyNMDew6Uif48zS8vky+cFvfTn6ui
         S8xg==
X-Gm-Message-State: AOAM533MFsws2UBN67tJvMkDx53SS+LBvG2cAvJE4bxUROE1MdPU4hJt
        Li+PAefKsa9hd+E0zI7xiHo=
X-Google-Smtp-Source: ABdhPJwJvUeVm8LI15OBrwxqc0jjo+cnTlwf6RgptIHGYIaZz10KIRsVCt0Hrexej45uSbVmGU5eBA==
X-Received: by 2002:a0c:f507:: with SMTP id j7mr8530731qvm.82.1598145415396;
        Sat, 22 Aug 2020 18:16:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z197sm5958411qkb.66.2020.08.22.18.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 18:16:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Aug 2020 21:16:52 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
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
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200823011652.GA1910689@rani.riverdale.lan>
References: <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de>
 <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org>
 <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
 <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
 <CAHk-=whaVW4FQjdwaicLFE4kiqr18rk6V50CuU-ziUPyRFjHrg@mail.gmail.com>
 <20200822231055.GA1871205@rani.riverdale.lan>
 <CAHk-=whEb2xVU7uGOFwLxPgX-U2asMu1bJQA8QUEZPrL7zWwQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whEb2xVU7uGOFwLxPgX-U2asMu1bJQA8QUEZPrL7zWwQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 05:10:21PM -0700, Linus Torvalds wrote:
> On Sat, Aug 22, 2020 at 4:11 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Actually, is a memory clobber required for correctness? Memory accesses
> > probably shouldn't be reordered across a CRn write. Is asm volatile
> > enough to stop that or do you need a memory clobber?
> 
> You do need a memory clobber if you really care about ordering wrt
> normal memory references.
> 
> That said, I'm not convinced we do care here. Normal memory accesses
> (as seen by the compiler) should be entirely immune to any changes we
> do wrt CRx registers.
> 
> Because code that really fundamentally changes kernel mappings or
> access rules is already written in low-level assembler (eg the entry
> routines or bootup).
> 
> Anything that relies on the more subtle changes (ie user space
> accesses etc) should already be ordered by other things - usually by
> the fact that they are also "asm volatile".
> 
> But hey, maybe somebody can come up with an exception to that.
> 
>                 Linus

I'm sure in practice it can't happen, as any memory accesses happening
immediately around write_cr3() are probably mapped the same in both
pagetables anyway, but eg cleanup_trampoline() in
arch/x86/boot/compressed/pgtable_64.c:

	memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
	native_write_cr3((unsigned long)pgtable);

There'll probably be trouble if the compiler were to reverse the order
here.

We could actually make write_crn() use memory clobber, and read_crn()
use "m"(*(int *)0x1000) as an input operand. A bit hacky, but no global
variable needed. And maybe read_crn() doesn't even have to be volatile.

Also, if we look at the rdmsr/wrmsr pair, there's no force_order
equivalent AFAICT. wrmsr has a memory clobber, but the asm volatile-ness
is the only thing enforcing read/write ordering.

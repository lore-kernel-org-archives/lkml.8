Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCB8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 23:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D56B206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 23:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht6E7a1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgHVXLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 19:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgHVXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 19:10:59 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D44C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 16:10:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so3806985qtn.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WP9wSIBfD5wQcrpZkPoM0hMwoWbFysB2p8Lq1GzRYos=;
        b=ht6E7a1eeLBJIHl9aEjd3ev1/r7WsVvVKww5iOuCNDhCAduLaASmfQpoUjIloOPDXe
         KqGFzgukIGYxxjVfUWPeb9q8AH1TihQTQ4z9EwPOA8C4f3sdmd54Z0vePcQAnaX18gC6
         hSM1lZyF2nw43CeUKprvNYjlSyde1iCa7YCOvAKMbuO2x2MFDqztu9lJxHs0d9wUXsBS
         B43ZPYojNY8aFKCkGU8TOs5bHwRUkNjbv8iW/VbfPCvfXsmK2PwwWb7wrZkoO2H2/9ph
         JUGCWcGr9/xb7RmodLwXwTXMPVVRmD1jxDjeEMN1BauAKNYBNJhOZncmHGkAYMyt6R+P
         1KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WP9wSIBfD5wQcrpZkPoM0hMwoWbFysB2p8Lq1GzRYos=;
        b=Ff3JkaF4vzbS5o4Es6zx6siAgtYEt1aGL7ofoQgmYFlHrUbzF1DrSDpjJy8OpbPOG3
         3HprYKpjc5NWwEshUSL/KS4btZMJngEfAojDtv9jPujp8eYkRjKUSgGYxI1yy9JMwBPO
         7WDavcIA3mi3itwg+NdEK8j2AUTnslLgEHD9qKPXnlPAJcqJiLct8jfLUAYtnDwPL5Uy
         RFSV4LF7OwIAEulD41m+QYv3zRAIINMwAmYvEtUf8oxStC0ik+Vw4kmgYAEW06cKkLKb
         UZUTxrhlOjr3OIzTwZSXPsTknSevFqi0a9gMyZfAtZq0TCQdOOqkIm5cmGuSH/iibVmO
         4QCg==
X-Gm-Message-State: AOAM531PChPq7JWrl79MiVKYCf80G3e2t8CRHqghc/7KQ41KZCbMkAe5
        zspdRSistvji0yI5YGZFLCE=
X-Google-Smtp-Source: ABdhPJxlgdZdjJPfofYPG5NLgouYEpUg3oFBpJPyD7TEeo54elozEDffExEtl8fFLQD+9tUbWCZGwg==
X-Received: by 2002:ac8:777a:: with SMTP id h26mr8246848qtu.141.1598137857602;
        Sat, 22 Aug 2020 16:10:57 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z10sm6774896qtf.24.2020.08.22.16.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 16:10:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Aug 2020 19:10:55 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20200822231055.GA1871205@rani.riverdale.lan>
References: <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de>
 <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org>
 <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
 <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
 <CAHk-=whaVW4FQjdwaicLFE4kiqr18rk6V50CuU-ziUPyRFjHrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whaVW4FQjdwaicLFE4kiqr18rk6V50CuU-ziUPyRFjHrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 02:08:27PM -0700, Linus Torvalds wrote:
> However, in this case, can we just leave that old "__force_order" hack
> alone, and to work around the clang thing, just make a dummy
> definition of it anyway.
> 
> Alternatively, just use the memory clobber. We use memory clobbers
> elsewhere in inline asms to make sure they are serialized, it's not
> normally a huge problem. Both clang and gcc should be smart enough to
> know that a memory clobber doesn't matter for things like local
> variables etc that might be on stack but have never had their address
> taken.
> 
> Or are there other cases than that particular __force_order thing that
> people now worry about?
> 
>              Linus

Actually, is a memory clobber required for correctness? Memory accesses
probably shouldn't be reordered across a CRn write. Is asm volatile
enough to stop that or do you need a memory clobber?

Replacing force_order with memory clobber introduces a few extra
instructions (testing with defconfig), but only in x86-64
hibernate/reboot/sleep code and early_ioremap_init on x86-32.

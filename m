Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0366C20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYG5ZcBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgEZPQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbgEZPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:16:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2AEC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:16:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f89so9588334qva.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rvmRiO1axYsyxr5K067CYVfJq2RYqnnENI5i0SPdwNw=;
        b=AYG5ZcBZg7DPNpdTYajmW8KMUjpQ97F75lHITc3mGrWGudUS7txKYRUe9Lf2xl5kMT
         uQT0D1rrWGXEscQM+Qkdcyid7H/CNvz1XGnJrsQ9/EVLJ37aIF25kSQllRiDZAgw5+Y2
         wpIpC1yt/rsAuDgTh6sD3eIM87JUBvOAkonat0cFNU5rSsyrg0YqRa8GN2FETQAW+RNy
         BMqeLYt/qMF7EbybSHBp6+W8hqr4eYMU5yMaXvUQz0b5wiW0pX2oblojpsEsQYlrb9ov
         u4bn9TvMhHPOyQFa/nkNiggh9WllA+MrPf3N1FlLjyQfkBZ0pMHgPrxBKmcuVqZ7Y8L3
         484Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rvmRiO1axYsyxr5K067CYVfJq2RYqnnENI5i0SPdwNw=;
        b=LV36rJfkcmxm8agIGM0mMxsU2zDfZGCtprO/9o5/rgjwYQPrCapKcovQD/Q26hGBfm
         46uKww79xy2ZeuQmEyUHmt2aSJ0KNZ5hU52D7sYqhI5yoXywjpsMBm4WBO3CbUjQxSvy
         CN2GIEj01I/OyYGZVHNh2LnWVCSrjDW8aqV7B4e7XpuXSOhBV395w3JdZYtgIH41J1NG
         OmjQ1fv0cIwcChl7MdMKft+U6fI83o0n9Wzrh2lPNUQ1UtEuL+2w4QY6BqKZ/LGg2PTA
         72QHkbJx8XCthQColb2tb55dfl39Jp6nYlp1M+a+fMtN5C4Wbouln8XvMek3ooRgWLSZ
         YoWA==
X-Gm-Message-State: AOAM533FVmO4FQVMJh9oLot5MTWB7TrhmfAf8mwSHOO8q+ZtTsqc7J3e
        Kvfb1WOJLz+dtv4pBSSxSLSCErSB
X-Google-Smtp-Source: ABdhPJzBt3A987E2PyRC75PuhxUBsfQgYzwSjDBfR5Udgo6yButsxXR6+us3d5tX43L9+RAFKDKxLg==
X-Received: by 2002:ad4:4e6f:: with SMTP id ec15mr20989235qvb.88.1590506185506;
        Tue, 26 May 2020 08:16:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m19sm9295311qtn.38.2020.05.26.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 08:16:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 26 May 2020 11:16:23 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200526151623.GB2190602@rani.riverdale.lan>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-5-nivedita@alum.mit.edu>
 <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:11:56AM +0200, Ard Biesheuvel wrote:
> On Tue, 26 May 2020 at 00:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> > +KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> 
> Do we still need -pie linking with these changes applied?
> 

I think it's currently not strictly necessary -- eg the 64bit kernel
doesn't get linked as pie right now with LLD or old binutils. However,
it is safer to do so to ensure that the result remains PIC with future
versions of the linker. There are linker optimizations that can convert
certain PIC instructions when PIE is disabled. While I think they
currently all focus on eliminating indirection through the GOT (and thus
wouldn't be applicable any more), it's easy to imagine that they could
get extended to, for eg, convert
	leaq	foo(%rip), %rax
to
	movl	$foo, %eax
with some nop padding, etc.

Also, the relocation check that's being added here would only work with
PIE linking.

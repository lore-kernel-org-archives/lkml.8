Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF30C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7B2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9YB0nYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBXVdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:33:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39525 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:33:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id e16so7256213qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRWoeoOM8DL9OmT3+yYVal9mOTve0BZlMU96rBIIFe0=;
        b=E9YB0nYWyyqpbnhocJZ8cG/fU3LFV5rYqfrQVQ6ggzZbU09l2ZOa+8zYB9o5rcQykY
         KkX+C5jQspLPr+su1sQHvmXtf8cebQcqN/URtvzxylUvBst7P49jC7Ka+QWawUifzD7O
         KJ+46Cfra+s7sfRvYu3LZ6bW62hG64FoVYV5l5iIGbAcf/QUkBSAz8DY2ABk3wsuKlNZ
         jqffs0SivE29ITfqb6DjFe9XecxTiK7kwIZzYr6Bd4rBpyPkbCKntST5NbJyIsmk3z5X
         WlGFxI8T/pl5ROuE4ftxTNgkIxFTJM8TyWCUlMScCiDGabeQBEMd46kn4Y8AzFwNtEj9
         zLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRWoeoOM8DL9OmT3+yYVal9mOTve0BZlMU96rBIIFe0=;
        b=paOISClX27NWDwR9xSNOucEzsA4bVmc9CaIRD3fTRvkv3rQr6AnNL5H/s58Gjnonks
         coVSVMuySL3Hy9kjIRgshVEkSKFdawomfM0nk9DFjys14L5dKUJhNtW23I6+804rgyM0
         j+iJNkxSjrk1Mrf7aLvlpbY3oehRSS0jmQRMLv0enmuxgFsV/LF2RnQ8rxY+01kZN8Tk
         NlbNR7WJEOhv+kJNxSbxvfYdcWnc2gnspQ4Qu6jKxZQihtIDK89/HdawUmgsNg57/1Oz
         jx/lNOoXg9GY5EV8i8JL2ZL7Cs/kJ36IQSAjsd5s7BKkThJABKROaQQ4uOjCu15pjzhg
         f4zg==
X-Gm-Message-State: APjAAAWKBSMIZRA0q9osQ9VPmbFCp9O3DzYLpT1qwCa1QqgMFNOsGTP/
        3E4wGvNEmrL/KsPZQKyJTE0=
X-Google-Smtp-Source: APXvYqy4/TarFYSnVxoCsF3QA4gs91/IwvBd/MT049wjd2XdXdsBEFfmCj6sek4n5bI8YLgzyqy6+A==
X-Received: by 2002:a05:620a:2224:: with SMTP id n4mr4141190qkh.21.1582580001588;
        Mon, 24 Feb 2020 13:33:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 132sm6409229qkn.109.2020.02.24.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:33:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 16:33:19 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/2] arch/x86: Drop unneeded linker script discard of
 .eh_frame
Message-ID: <20200224213319.GB409112@rani.riverdale.lan>
References: <20200222235709.GA3786197@rani.riverdale.lan>
 <20200223193715.83729-3-nivedita@alum.mit.edu>
 <CAKwvOdmqM5aHnDCyL62gmWV5wFrKwAEdkHq+HPnvp3ZYA=dtbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmqM5aHnDCyL62gmWV5wFrKwAEdkHq+HPnvp3ZYA=dtbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:45:51PM -0800, Nick Desaulniers wrote:
> 
> grepping for eh_frame in arch/x86/ there's a comment in
> arch/x86/include/asm/dwarf2.h:
>  40 #ifndef BUILD_VDSO
>  41   /*
>  42    * Emit CFI data in .debug_frame sections, not .eh_frame
> sections.
>  43    * The latter we currently just discard since we don't do DWARF
>  44    * unwinding at runtime.  So only the offline DWARF information is
>  45    * useful to anyone.  Note we should not use this directive if
>  46    * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
>  47    */
>  48   .cfi_sections .debug_frame
> 
> add via:
> commit 7b956f035a9ef ("x86/asm: Re-add parts of the manual CFI infrastructure")
> 
> https://sourceware.org/binutils/docs/as/CFI-directives.html#g_t_002ecfi_005fsections-section_005flist
> is the manual's section on .cfi_sections directives, and states `The
> default if this directive is not used is .cfi_sections .eh_frame.`.
> So the comment is slightly stale since we're no longer explicitly
> discarding .eh_frame in arch/x86/kernel/vmlinux.lds.S, rather
> preventing the generation via -fno-asynchronous-unwind-tables in
> KBUILD_CFLAGS (across a few different Makefiles).  Would you mind also
> updating the comment in arch/x86/include/asm/dwarf2.h in a V2? The
> rest of this patch LGTM.
> 

i.e. just replace that last sentence with "Note ... if we decide to use
runtime DWARF unwinding again"?

The whole ifdef-ery machinery there is obsolete, all the directives its
checking support for have been there since binutils-2.18, so should
probably also clean it up to just unconditionally define them.

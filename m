Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A037C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DC620CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpUIx8IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBXV6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:58:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35626 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgBXV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:58:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so6055919pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlniHU7g9k96/uUW/5ypNnFyMnufPLmI9nvXsoiLe/g=;
        b=DpUIx8INd405dnm5VcX8QJ7nbI+ViAejLCkj+OXRG7zPaFMR8n3Zv2BfOEAYdraTBX
         DOsURALwsVRKQR6m9AW+DQWN+G/jg6g4tpPVnA8XVLmyyV6/3b9ntjfpYCh8Jo0B1owN
         moBFH9jmFSwRt98lpmA7Wso663+jWPBy5q1WDaQMggthTL7PJmo0rbvu3UyFqsn/gt8A
         TdP3MCbeyt81rtKb64x7WMcqmqTuszy03WZgH/8v2lmUt4lPDoqo0hCtCqNq7i6qzIh7
         cjclWVI6Y4GuJyiOZ5dJTolpcVu/9WVLUcP7LwjGv/ybNjDzzhylU1HHP2+Wn7Sx0Kas
         D2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlniHU7g9k96/uUW/5ypNnFyMnufPLmI9nvXsoiLe/g=;
        b=ENxNkT0MgvmGNtFlO6z8MgxRjo2aZZtq+nhvLCGeBMVWrUSoaM+wXJB8QLAwz4fZTm
         wWYbMZtZfZdIManBk3+aqc9BJVqFXD3O6HjBtB+vtUxhLL6S+nxubSKZNYhK/jjehWEZ
         HT28tvKhQazjgQr9tfPm+AUSHkB6mNi2jRW5tk0CjZovoj6UxVQEWlpP05Qrbz5SvlZq
         68c+M5SUBjQNlddUFJS14uzJYYlZSovuqB5T6hLhh/rvbp2EMvAVoepyNXIrt0oFmCWD
         kxK/0aVmTgFD/dR2fYOcWL1Tc/l14Pxi8L0NOCOLzv6qFvfKTDI+oWL2TpcZ2nOl2QUI
         HrpA==
X-Gm-Message-State: APjAAAU7MRc9JOTwOtCYbu1IwJbmey4lhG5YwStueERNuss7USZptwi/
        HQkK7Db1qpEp/pQnwYsiu63PH/xShCbpfp9ym9Djog==
X-Google-Smtp-Source: APXvYqwXiS5VJLfKFLWVe0HMFWPJZhrjN8WAE38qYzfXReNIc9dhwOItemZQiQdfviqGqLjTDDML7d83fQOGXj9tsm8=
X-Received: by 2002:aa7:8618:: with SMTP id p24mr54461821pfn.3.1582581526452;
 Mon, 24 Feb 2020 13:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-3-nivedita@alum.mit.edu>
 <CAKwvOdmqM5aHnDCyL62gmWV5wFrKwAEdkHq+HPnvp3ZYA=dtbg@mail.gmail.com> <20200224213319.GB409112@rani.riverdale.lan>
In-Reply-To: <20200224213319.GB409112@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 13:58:35 -0800
Message-ID: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch/x86: Drop unneeded linker script discard of .eh_frame
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:33 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Feb 24, 2020 at 12:45:51PM -0800, Nick Desaulniers wrote:
> >
> > grepping for eh_frame in arch/x86/ there's a comment in
> > arch/x86/include/asm/dwarf2.h:
> >  40 #ifndef BUILD_VDSO
> >  41   /*
> >  42    * Emit CFI data in .debug_frame sections, not .eh_frame
> > sections.
> >  43    * The latter we currently just discard since we don't do DWARF
> >  44    * unwinding at runtime.  So only the offline DWARF information is
> >  45    * useful to anyone.  Note we should not use this directive if
> >  46    * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
> >  47    */
> >  48   .cfi_sections .debug_frame
> >
> > add via:
> > commit 7b956f035a9ef ("x86/asm: Re-add parts of the manual CFI infrastructure")
> >
> > https://sourceware.org/binutils/docs/as/CFI-directives.html#g_t_002ecfi_005fsections-section_005flist
> > is the manual's section on .cfi_sections directives, and states `The
> > default if this directive is not used is .cfi_sections .eh_frame.`.
> > So the comment is slightly stale since we're no longer explicitly
> > discarding .eh_frame in arch/x86/kernel/vmlinux.lds.S, rather
> > preventing the generation via -fno-asynchronous-unwind-tables in
> > KBUILD_CFLAGS (across a few different Makefiles).  Would you mind also
> > updating the comment in arch/x86/include/asm/dwarf2.h in a V2? The
> > rest of this patch LGTM.
> >
>
> i.e. just replace that last sentence with "Note ... if we decide to use
> runtime DWARF unwinding again"?

Yeah that should be good.  Maybe these cleanups could be a separate
patch, if you prefer?

>
> The whole ifdef-ery machinery there is obsolete, all the directives its
> checking support for have been there since binutils-2.18, so should
> probably also clean it up to just unconditionally define them.

arch/x86/Makefile:
184 # do binutils support CFI?
185 cfi := $(call as-instr,.cfi_startproc\n.cfi_rel_offset
$(sp-y)$(comma)0\n.cfi_endproc,-DCONFIG_AS_CFI=1)
186 # is .cfi_signal_frame supported too?
187 cfi-sigframe := $(call
as-instr,.cfi_startproc\n.cfi_signal_frame\n.cfi_endproc,-DCONFIG_AS_CFI_SIGNAL_FRAME=1)
188 cfi-sections := $(call as-instr,.cfi_sections
.debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)

2.18? Oh, yeah, we can clean that up to.
Documentation/process/changes.rst list binutils 2.21 as the minimum
supported version.  Then I assume that code that uses those -D flags
can go, too.
-- 
Thanks,
~Nick Desaulniers

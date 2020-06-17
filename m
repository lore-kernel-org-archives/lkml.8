Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8D820734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELLbGi2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFQXNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQXNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:13:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA5C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 16:13:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so2361602lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 16:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1hiYaNAZ1bLAJ3WDBfpStfQ2+z+3MaNkLkhLLpU+xY=;
        b=ELLbGi2Lvl8ATWdOWJvpSQaXVZZadODaheeYEsfszSRxOx4yh1ZGAULhuYEgOt5UB+
         V2wEk2s78NYwAjQSgtLv56qdw4cVjNe6LTHN2NF9fxapiyTidVWmIEKBsIzMAeuSlSOf
         EqMbWm7RDtO5aTksbhy7hAcKdWHyRBQ9xQu720i12ycAyguPaGHnKD2CjWRicYRys6B6
         /QmT8Rzy1W3+PPkereuxmW6NmG9BpMeCwIJ8aKrbT4jZH1kQqohcbFAen8p3Kh9r/lj6
         LewddS6btW5ibhj09BcsX4Fkeu8NshQA8pbT99fulljCpE7FxbED+s50B/AKpkCMkvah
         72lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1hiYaNAZ1bLAJ3WDBfpStfQ2+z+3MaNkLkhLLpU+xY=;
        b=otGP6Q6jRnFRRCDIja/rDg/UpyAlI1WaFb9V/lOG4qA5BajHDBFUb6FZrpetbkD+/l
         uLLLH8l2ihasEN5LCYW2tJOrYbrtVmY/OJ7MVbdh3Sgk1i2GJpI4MW1+vaJkcKscI62c
         ThjGhtqKafutFMi9BheFX1WnEk/8ZbZE7tRhiGzBrA3FU0YgvdaM5awnl6lpjvDA3PDp
         23BJ1L78R8vk37Gf/ZTviHTsMk1gRO1V1NfqQ2EQymok3L3P7ozWpLECNYkxLG2HHEAd
         zLmw4YPEpJ41vG3YVHITcm3kefrg+tcVr+8iFkn4rZdAkTSpdg1ksYbDkRVnJFgCzUE6
         7v4g==
X-Gm-Message-State: AOAM530d2cPeABUYEoz9RXaL78NtGvdBZCWFiTsLyfa+Pc9dtcqh/PPS
        r07nJYveoMhDimDzPT9BnsSmQEEI5BnumXJX2kVmBQ==
X-Google-Smtp-Source: ABdhPJyhM1WMODSepRrPwfVjQNmt/DjcIFSu2jtn0OhcOVTEVd1lYX5mLfyWxVB7SA+2HwNGn2wltsQVKC5ENvytcxI=
X-Received: by 2002:a19:a405:: with SMTP id q5mr665223lfc.164.1592435583623;
 Wed, 17 Jun 2020 16:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200617165616.52241bde@oasis.local.home> <CAG48ez2pOns4vF9M_4ubMJ+p9YFY29udMaH0wm8UuCwGQ4ZZAQ@mail.gmail.com>
 <20200617183628.3594271d@oasis.local.home>
In-Reply-To: <20200617183628.3594271d@oasis.local.home>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 18 Jun 2020 01:12:37 +0200
Message-ID: <CAG48ez04Fj=1p61KAxAQWZ3f_z073fVUr8LsQgtKA9c-kcHmDQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Use linker magic instead of recasting ftrace_ops_list_func()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 17 Jun 2020 23:30:07 +0200
> Jann Horn <jannh@google.com> wrote:
> > [...]
> > > +/* Defined by vmlinux.lds.h see the commment above arch_ftrace_ops_list_func for details */
> > > +void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> > > +                         struct ftrace_ops *op, struct pt_regs *regs);
> > [...]
> > > +void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip)
> > >  {
> >
> > Well, it's not like the function cast itself is the part that's
> > problematic for CFI; the problematic part is when you actually make a
> > C function call (in particular an indirect one) where the destination
> > is compiled with a prototype that is different from the prototype used
> > at the call site. Doing this linker hackery isn't really any better
> > than shutting up the compiler warning by piling on enough casts or
> > whatever. (There should be some combination of casts that'll shut up
> > this warning, right?)
>
> It's not called by C, it's called by assembly.

Except on nds32 and parisc, right?

> > IIUC the real issue here is that ftrace_func_t is defined as a fixed
> > type, but actually has different types depending on the architecture?
> > If so, it might be cleaner to define ftrace_func_t differently
> > depending on architecture, or something like that?
>
> There's functions that use this type.
>
> When you register a function to be used by the function tracer (that
> will have 4 parameters). If the arch supports it, it will call it
> directly from the trampoline in assembly, but if it does not, then the
> C code will only let assembly call the two parameter version, that will
> call the 4 parameter function (adding NULLs to the extra two arguments).

So essentially there are two types, right? One type for the
registration API, one type for the assembly API? On some
architectures, the types are the same (and assembly calls directly
into the function); on other architectures, the types are not the
same, and assembly calls the NULL-adding helper (with the
assembly-API-type), and then the helper calls the function with the
registration-API-type?

Would it not be possible to have two function types (#define'd as the
same if ARCH_SUPPORTS_FTRACE_OPS), and then ensure that ftrace_func_t
is only used as ftrace_asm_func_t if ARCH_SUPPORTS_FTRACE_OPS?
Something like this (entirely untested)?

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e339dac91ee62..b08fa393c1fad 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -89,6 +89,11 @@ struct ftrace_ops;

 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
                              struct ftrace_ops *op, struct pt_regs *regs);
+#if ARCH_SUPPORTS_FTRACE_OPS
+#define ftrace_asm_func_t ftrace_func_t
+#else
+typedef void (*ftrace_asm_func_t)(unsigned long ip, unsigned long parent_ip);
+#endif

 ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);

@@ -254,8 +259,12 @@ extern enum ftrace_tracing_type_t ftrace_tracing_type;
 int register_ftrace_function(struct ftrace_ops *ops);
 int unregister_ftrace_function(struct ftrace_ops *ops);

+#if ARCH_SUPPORTS_FTRACE_OPS
 extern void ftrace_stub(unsigned long a0, unsigned long a1,
                        struct ftrace_ops *op, struct pt_regs *regs);
+#else
+extern void ftrace_stub(unsigned long a0, unsigned long a1);
+#endif

 #else /* !CONFIG_FUNCTION_TRACER */
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c163c3531fafc..abd076cdd84d9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -116,7 +116,7 @@ static int ftrace_disabled __read_mostly;
 DEFINE_MUTEX(ftrace_lock);

 struct ftrace_ops __rcu *ftrace_ops_list __read_mostly = &ftrace_list_end;
-ftrace_func_t ftrace_trace_function __read_mostly = ftrace_stub;
+ftrace_asm_func_t ftrace_trace_function __read_mostly = ftrace_stub;
 struct ftrace_ops global_ops;

 #if ARCH_SUPPORTS_FTRACE_OPS
@@ -125,7 +125,7 @@ static void ftrace_ops_list_func(unsigned long ip,
unsigned long parent_ip,
 #else
 /* See comment below, where ftrace_ops_list_func is defined */
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
-#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
+#define ftrace_ops_list_func ftrace_ops_no_ops
 #endif

 static inline void ftrace_ops_init(struct ftrace_ops *ops)
@@ -166,22 +166,25 @@ static void ftrace_sync_ipi(void *data)
        smp_rmb();
 }

-static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
+static ftrace_asm_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
 {
+#if FTRACE_FORCE_LIST_FUNC
+       return ftrace_ops_list_func;
+#else
        /*
         * If this is a dynamic, RCU, or per CPU ops, or we force list func,
         * then it needs to call the list anyway.
         */
-       if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU) ||
-           FTRACE_FORCE_LIST_FUNC)
+       if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU))
                return ftrace_ops_list_func;

        return ftrace_ops_get_func(ops);
+#endif
 }

 static void update_ftrace_function(void)
 {
-       ftrace_func_t func;
+       ftrace_asm_func_t func;

        /*
         * Prepare the ftrace_ops that the arch callback will use.

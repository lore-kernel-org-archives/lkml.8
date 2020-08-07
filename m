Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A42AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E943621744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596769173;
	bh=rohTHTvBnOfXgLz546XmcHOe65GGSth3l9B42BKK52U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qFAsw13pWMI2fCV89eEIecrMoB0s8xxPtecqr/bDTLVGoCCIk+WJ+VL9qS4r7N/PE
	 nllOQeXwbyBLpyjB0dmruLeZU5L798C10uIzocJQqNo+Dnz9o0IMo77nMc7Cj1afL3
	 FoJ3FsOJLXDPQTNqS/Xf8S43nqI8Ht8WPvoKiF98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHGC7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGC7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:59:30 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D7122D01;
        Fri,  7 Aug 2020 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596769170;
        bh=rohTHTvBnOfXgLz546XmcHOe65GGSth3l9B42BKK52U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LGUOG4xAAqNl5JK0ekaICDXc6dnE2jHVF1DS1L3bqOvRtbENdMSjKbKoas2QLjvnq
         0V4Qhpzk4T0E/en+jHOc/4WRkHTexxWdMm7lw1EqJWDQhheo7OG9eMd435oFzsXgqq
         bCfbshAUDyck54ZmI6PyryxbkdaXV7S2JWyDuA1U=
Received: by mail-lj1-f178.google.com with SMTP id z14so626443ljm.1;
        Thu, 06 Aug 2020 19:59:29 -0700 (PDT)
X-Gm-Message-State: AOAM531oCDGQ7gGH1IIpYoFfcPr0dXBa+jPy5G5AxIGrIGVo/A9FuZHD
        Yt4vbUJC8zHVJNj+LOk3IE7WoyfKjRS810fAIHQ=
X-Google-Smtp-Source: ABdhPJy3cyMLEpLQp+e9nmXl1yojXJ9/wlMyQ5xgEtncZI62/v4i1cFVkr3ygiVhv/Sk+csRIK1JhBPw/s7GD1hAbPs=
X-Received: by 2002:a2e:2f02:: with SMTP id v2mr4659800ljv.79.1596769167982;
 Thu, 06 Aug 2020 19:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <1596725454-16245-1-git-send-email-guoren@kernel.org> <20200806114850.051f84d0@oasis.local.home>
In-Reply-To: <20200806114850.051f84d0@oasis.local.home>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Aug 2020 10:59:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRufu561K_8p6KS0C=2xTq+YdOfGLbFqkuuiapSk3_cAQ@mail.gmail.com>
Message-ID: <CAJF2gTRufu561K_8p6KS0C=2xTq+YdOfGLbFqkuuiapSk3_cAQ@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
To:     Steven Rostedt <rostedt@goodmis.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 11:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu,  6 Aug 2020 14:50:54 +0000
> guoren@kernel.org wrote:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The function ftrace_process_locs() will modify text code, so we
> > should give a text_mutex lock. Because some arch's patch code
> > will assert held of text_mutex even during start_kernel->
> > ftrace_init().
>
> NAK.
>
> This looks like a bug in the lockdep_assert_held() in whatever arch
> (riscv) is running.
Seems you think it's a bug of arch implementation with the wrong usage
of text_mutex?

Also @riscv maintainer,
How about modifying it in riscv's code? we still need to solve it.

----------------
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index ace8a6e..fb266c3 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -23,6 +23,12 @@ static inline unsigned long
ftrace_call_adjust(unsigned long addr)

 struct dyn_arch_ftrace {
 };
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+struct dyn_ftrace;
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
+#define ftrace_init_nop ftrace_init_nop
+#endif
 #endif

 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 2ff63d0..9e9f7c0 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -97,6 +97,17 @@ int ftrace_make_nop(struct module *mod, struct
dyn_ftrace *rec,
        return __ftrace_modify_call(rec->ip, addr, false);
 }

+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
+{
+       int ret;
+
+       mutex_lock(&text_mutex);
+       ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
+       mutex_unlock(&text_mutex);
+
+       return ret;
+}
+
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
        int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
-------------------

>
> >
> > backtrace log:
> >    assert by lockdep_assert_held(&text_mutex)
> > 0  patch_insn_write (addr=0xffffffe0000010fc <set_reset_devices+10>, insn=0xffffffe001203eb8, len=8) at arch/riscv/kernel/patch.c:63
> > 1  0xffffffe0002042ec in patch_text_nosync (addr=<optimized out>, insns=<optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:93
> > 2  0xffffffe00020628e in __ftrace_modify_call (hook_pos=<optimized out>, target=<optimized out>, enable=<optimized out>) at arch/riscv/kernel/ftrace.c:68
> > 3  0xffffffe0002063c0 in ftrace_make_nop (mod=<optimized out>, rec=0xffffffe001221c70 <text_mutex+96>, addr=18446743936272720288) at arch/riscv/kernel/ftrace.c:97
> > 4  0xffffffe0002b13f0 in ftrace_init_nop (rec=<optimized out>, mod=<optimized out>) at ./include/linux/ftrace.h:647
> > 5  ftrace_nop_initialize (rec=<optimized out>, mod=<optimized out>) at kernel/trace/ftrace.c:2619
> > 6  ftrace_update_code (new_pgs=<optimized out>, mod=<optimized out>) at kernel/trace/ftrace.c:3063
> > 7  ftrace_process_locs (mod=<optimized out>, start=<optimized out>, end=<optimized out>) at kernel/trace/ftrace.c:6154
> > 8  0xffffffe00000b6e6 in ftrace_init () at kernel/trace/ftrace.c:6715
> > 9  0xffffffe000001b48 in start_kernel () at init/main.c:888
> > 10 0xffffffe0000010a8 in _start_kernel () at arch/riscv/kernel/head.S:247
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > ---
> >  kernel/trace/ftrace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 1903b80..4b48b88 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/bsearch.h>
> >  #include <linux/module.h>
> > +#include <linux/memory.h>
> >  #include <linux/ftrace.h>
> >  #include <linux/sysctl.h>
> >  #include <linux/slab.h>
> > @@ -6712,9 +6713,11 @@ void __init ftrace_init(void)
>
> ftrace_init() is called before SMP is initialized. Nothing else should
> be running here. That means grabbing a mutex is useless.
I don't agree, ftrace_init are modifying kernel text, so we should
give the lock of text_mutex to keep semantic consistency.


>
> -- Steve
>
>
> >
> >       last_ftrace_enabled = ftrace_enabled = 1;
> >
> > +     mutex_lock(&text_mutex);
> >       ret = ftrace_process_locs(NULL,
> >                                 __start_mcount_loc,
> >                                 __stop_mcount_loc);
> > +     mutex_unlock(&text_mutex);
> >
> >       pr_info("ftrace: allocated %ld pages with %ld groups\n",
> >               ftrace_number_of_pages, ftrace_number_of_groups);
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

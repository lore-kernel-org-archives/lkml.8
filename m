Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8EFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F135206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4xOIGIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFEK53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgFEK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:57:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E788C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 03:57:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so8033554qtr.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+FRzkDxx24cf0JvfqgWOwJXwQpB0rcy5gXQ1S61x5s=;
        b=G4xOIGIT8lRxaUrD1AsoFubKF2Ha8/E14FOWxhUsPu9z7z85o+O3BQHZYq3+/ZVWM0
         oUXwJDcgJTu24/+KkmtgUppiceA10mydsbxrNRKG1858kyGRMtTSCeoMYTiTwaXiTzLZ
         eEKzydQs94hS6MRQjKL/UJE7UGvEUhCezsjGSvDg6VKpdaDT0RmWpcvOpLaA2jAL/FxT
         joI3tfODJDk9O8/hyONb+kwSGS+0uqlSs4xLXkf3DNHme/aGmIXKqX+hifBt/d1GkrsD
         kpQdThbc1AO5/RpZf2ywbQUeWNEGRakRwEchlXZ2jO1Qq0eTVv452GrtkcXrJKSPMF33
         JP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+FRzkDxx24cf0JvfqgWOwJXwQpB0rcy5gXQ1S61x5s=;
        b=cdS5b7noOhqBukW1rZMsrbPdxATvmKrKSRNGJPwsPqWP4XAxFGTuh+Aqumx3IEDxt+
         WMEMvfO0yXxopi9g9GZD+3biiyMXuxob2tvO79ClftGk1gGsYIfp1k+o6t+RL8g8i4ns
         nf7/gqvhfOKFi0NQRHWRrQ5Nx7TIcvl98YPS+MLq+bbyJyeGzNsE4d39OJeV3WI4GvTi
         N0B1TnNqDGTh9mZ33XVk9ukUIniqUOxxQ/ANmWXZPpu6R2nH3HxsP0gQ4NDZHdRtT64Z
         enUDYks3bzKh1Znc6ohhcTYiG7VnNs6+IFr/8RATYhgO3zeR5/JotEbTaLT5G+/adBQx
         4h4g==
X-Gm-Message-State: AOAM5333p+53IUcbT6B/ijeERRorWvXTbzgfX+tI9qRwOP7Q+LuEHezX
        qmO8XrDYHpXIghYuFV2ZR5by63QsqvBbrCrrQ+WosA==
X-Google-Smtp-Source: ABdhPJxLrRRwoK3BBA8G+knjvLJPIFjbJp6DFSr2GJVSgeuUa7qHJcLKxSETLx6Ah2TWnI7ThSbN3ZkCsP/0FL3UTwU=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr9415205qtu.380.1591354647018;
 Fri, 05 Jun 2020 03:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com>
In-Reply-To: <20200605082839.226418-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jun 2020 12:57:15 +0200
Message-ID: <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
To:     Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 10:28 AM Marco Elver <elver@google.com> wrote:
>
> While we lack a compiler attribute to add to noinstr that would disable
> KCOV, make the KCOV runtime functions return if the caller is in a
> noinstr section, and mark them noinstr.
>
> Declare write_comp_data() as __always_inline to ensure it is inlined,
> which also reduces stack usage and removes one extra call from the
> fast-path.
>
> In future, our compilers may provide an attribute to implement
> __no_sanitize_coverage, which can then be added to noinstr, and the
> checks added in this patch can be guarded by an #ifdef checking if the
> compiler has such an attribute or not.

Adding noinstr attribute to instrumentation callbacks looks fine to me.

But I don't understand the within_noinstr_section part.
As the cover letter mentions, kcov callbacks don't do much and we
already have it inserted and called. What is the benefit of bailing
out a bit earlier rather than letting it run to completion?
Is the only reason for potential faults on access to the vmalloc-ed
region? If so, I think the right approach is to eliminate the faults
(if it's possible). We don't want faults for other reasons: they
caused recursion on ARM and these callbacks are inserted into lots of
sensitive code, so I am not sure checking only noinstr will resolve
all potential issues. E.g. we may get a deadlock if we fault from a
code that holds some lock, or we still can get that recursion on ARM (
I don't think all of page fault handling code is noinstr).
The fact that we started getting faults again (did we?) looks like a
regression related to remote KCOV.
Andrey, Mark, do you know if it's possible to pre-fault these areas?
The difference is that they run in a context of kernel threads. Maybe
we could do kcov_fault_in_area when we activate and remove KCOV on an
area? This way we get all faults in a very well-defined place (which
is not noinstr and holds known locks).



> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Applies to -tip only currently, because of the use of instrumentation.h
> markers.
>
> v3:
> * Remove objtool hack, and instead properly mark __sanitizer_cov
>   functions as noinstr.
> * Add comment about .entry.text.
>
> v2: https://lkml.kernel.org/r/20200604145635.21565-1-elver@google.com
> * Rewrite based on Peter's and Andrey's feedback -- v1 worked because we
>   got lucky. Let's not rely on luck, as it will be difficult to ensure the
>   same conditions remain true in future.
>
> v1: https://lkml.kernel.org/r/20200604095057.259452-1-elver@google.com
>
> Note: There are a set of KCOV patches from Andrey in -next:
> https://lkml.kernel.org/r/cover.1585233617.git.andreyknvl@google.com --
> Git cleanly merges this patch with those patches, and no merge conflict
> is expected.
> ---
>  kernel/kcov.c | 59 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 8accc9722a81..84cdc30d478e 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -6,6 +6,7 @@
>  #include <linux/compiler.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/instrumentation.h>
>  #include <linux/types.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> @@ -24,6 +25,7 @@
>  #include <linux/refcount.h>
>  #include <linux/log2.h>
>  #include <asm/setup.h>
> +#include <asm/sections.h>
>
>  #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>
> @@ -172,20 +174,38 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
>         return ip;
>  }
>
> +/* Return true if @ip is within a noinstr section. */
> +static __always_inline bool within_noinstr_section(unsigned long ip)
> +{
> +       /*
> +        * Note: .entry.text is also considered noinstr, but for now, since all
> +        * .entry.text code lives in .S files, these are never instrumented.
> +        */
> +       return (unsigned long)__noinstr_text_start <= ip &&
> +              ip < (unsigned long)__noinstr_text_end;
> +}
> +
>  /*
>   * Entry point from instrumented code.
>   * This is called once per basic-block/edge.
>   */
> -void notrace __sanitizer_cov_trace_pc(void)
> +void noinstr __sanitizer_cov_trace_pc(void)
>  {
>         struct task_struct *t;
>         unsigned long *area;
> -       unsigned long ip = canonicalize_ip(_RET_IP_);
> +       unsigned long ip;
>         unsigned long pos;
>
> +       if (unlikely(within_noinstr_section(_RET_IP_)))
> +               return;
> +
> +       instrumentation_begin();
> +
>         t = current;
>         if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> -               return;
> +               goto out;
> +
> +       ip = canonicalize_ip(_RET_IP_);
>
>         area = t->kcov_area;
>         /* The first 64-bit word is the number of subsequent PCs. */
> @@ -194,19 +214,27 @@ void notrace __sanitizer_cov_trace_pc(void)
>                 area[pos] = ip;
>                 WRITE_ONCE(area[0], pos);
>         }
> +
> +out:
> +       instrumentation_end();
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
>
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
> -static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> +static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>  {
>         struct task_struct *t;
>         u64 *area;
>         u64 count, start_index, end_pos, max_pos;
>
> +       if (unlikely(within_noinstr_section(ip)))
> +               return;
> +
> +       instrumentation_begin();
> +
>         t = current;
>         if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
> -               return;
> +               goto out;
>
>         ip = canonicalize_ip(ip);
>
> @@ -229,61 +257,64 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>                 area[start_index + 3] = ip;
>                 WRITE_ONCE(area[0], count + 1);
>         }
> +
> +out:
> +       instrumentation_end();
>  }
>
> -void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> +void noinstr __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(0), arg1, arg2, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_cmp1);
>
> -void notrace __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2)
> +void noinstr __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(1), arg1, arg2, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_cmp2);
>
> -void notrace __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2)
> +void noinstr __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(2), arg1, arg2, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_cmp4);
>
> -void notrace __sanitizer_cov_trace_cmp8(u64 arg1, u64 arg2)
> +void noinstr __sanitizer_cov_trace_cmp8(u64 arg1, u64 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(3), arg1, arg2, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_cmp8);
>
> -void notrace __sanitizer_cov_trace_const_cmp1(u8 arg1, u8 arg2)
> +void noinstr __sanitizer_cov_trace_const_cmp1(u8 arg1, u8 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(0) | KCOV_CMP_CONST, arg1, arg2,
>                         _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp1);
>
> -void notrace __sanitizer_cov_trace_const_cmp2(u16 arg1, u16 arg2)
> +void noinstr __sanitizer_cov_trace_const_cmp2(u16 arg1, u16 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(1) | KCOV_CMP_CONST, arg1, arg2,
>                         _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp2);
>
> -void notrace __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2)
> +void noinstr __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(2) | KCOV_CMP_CONST, arg1, arg2,
>                         _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp4);
>
> -void notrace __sanitizer_cov_trace_const_cmp8(u64 arg1, u64 arg2)
> +void noinstr __sanitizer_cov_trace_const_cmp8(u64 arg1, u64 arg2)
>  {
>         write_comp_data(KCOV_CMP_SIZE(3) | KCOV_CMP_CONST, arg1, arg2,
>                         _RET_IP_);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp8);
>
> -void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
> +void noinstr __sanitizer_cov_trace_switch(u64 val, u64 *cases)
>  {
>         u64 i;
>         u64 count = cases[0];
> --
> 2.27.0.278.ge193c7cf3a9-goog
>

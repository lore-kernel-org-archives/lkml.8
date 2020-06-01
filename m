Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29827C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBFA206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTN0KPcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgFAUnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:43:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E07C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:43:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so4034902pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53PobnMXXIvJkI0Sukcip3xX+z8MPjzfSKWsAjYxgRo=;
        b=gTN0KPcZ7NiBzgz5Pa+hOtBXiZyAStDGftJk/BLjsW7K1QMrgbGaT10BnoJJBUwlRy
         Kyk/sCwuZ9SfcOCU9SRa8t3/vEl+ubG5fwEVZGOG2OycGICdGVXvHgbYGi4+uFnd4NWQ
         5rq74RrzVMO8QHZsuToq784rIV38PLuI/he0TAkXy7vFkMmo5YuH+Z5K5bqAkNOGiiGH
         9m7w6SjQvd1TrcJTtnSdMBTvSbsy/Mov4RRRasNdhN0ehMr/6G6wGk8nV+fQWKYO8TB+
         PwUjk2h7PwLfsUTUoQL86shHHHEN9GKCdby2JNu2GyDLUiGn1r9lYUxLxCBgOTOj1WFN
         OhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53PobnMXXIvJkI0Sukcip3xX+z8MPjzfSKWsAjYxgRo=;
        b=VN3tZ2ngTGc5apjfriM0gQyc8n15ZZ561Vxvw+UOvKoek45KZT37UrxL+n9dz9blMZ
         r6wDQnG10v84gK6qoY8hIAPifiUpovGW8xmIKDgCfRMI2O9bLtxpbUS91b/kEKF9nGI8
         OQyXdYTF1UNmG3KISyh1tcPWN0fbmtu3Dbc/6duHFOpPU6AN8pmJ3s2bGdcyxwySFnZf
         QhtVx1m+Fm0k/SxClKi76rQF0ezI6WOimaSwvKpROknY/rZ6Ue3jsAjKj7sdxy+WtT3u
         3DwbQNC83UfWXAL6sGnZfTsK4FIN0MvD+w3pCZTlm+HMTV98BTxVWwpAG4GJIWZzfL1I
         MlFQ==
X-Gm-Message-State: AOAM532jS9yxaPwcnCB/J4poqNsk1WXTHIbnnIxSOsA9CzBCxo39Mgby
        lJlKPCOrWi23yYQFp6+Gl6e8pkOEmyiEsOP44Ismoil/zAo=
X-Google-Smtp-Source: ABdhPJyvXvySh7X5u8eHUFOnPjyOmvQuRsRryDrYawjS2HM/Spf+tMTIxcPFa/wkG6k7ANF/cP6DcU4ZmmufkKBIYmQ=
X-Received: by 2002:a63:4f09:: with SMTP id d9mr20208805pgb.10.1591044209841;
 Mon, 01 Jun 2020 13:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-10-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-10-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 13:43:18 -0700
Message-ID: <CAKwvOdmgN7xra26_xBYCJo45OdOUHLNmw16ioLOE171f_HE0eA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] x86/percpu: Clean up percpu_stable_op()
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> Use __pcpu_size_call_return() to simplify this_cpu_read_stable().

Clever! As in this_cpu_read() in include/linux/percpu-defs.h.  Could
be its own patch before this, but it's fine.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Also remove __bad_percpu_size() which is now unused.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/include/asm/percpu.h | 41 ++++++++++-------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 7efc0b5c4ff0..cf2b9c2a241e 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -85,7 +85,6 @@
>
>  /* For arch-specific code, we can use direct single-insn ops (they
>   * don't give an lvalue though). */
> -extern void __bad_percpu_size(void);
>
>  #define __pcpu_type_1 u8
>  #define __pcpu_type_2 u16
> @@ -167,33 +166,13 @@ do {                                                                      \
>         (typeof(_var))(unsigned long) pfo_val__;                        \
>  })
>
> -#define percpu_stable_op(op, var)                      \
> -({                                                     \
> -       typeof(var) pfo_ret__;                          \
> -       switch (sizeof(var)) {                          \
> -       case 1:                                         \
> -               asm(op "b "__percpu_arg(P1)",%0"        \

What does the `P` do here?
https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints
says can be machine dependent integral literal in a certain range.
https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
doesn't document `P` for x86 though...

> -                   : "=q" (pfo_ret__)                  \
> -                   : "p" (&(var)));                    \
> -               break;                                  \
> -       case 2:                                         \
> -               asm(op "w "__percpu_arg(P1)",%0"        \
> -                   : "=r" (pfo_ret__)                  \
> -                   : "p" (&(var)));                    \
> -               break;                                  \
> -       case 4:                                         \
> -               asm(op "l "__percpu_arg(P1)",%0"        \
> -                   : "=r" (pfo_ret__)                  \
> -                   : "p" (&(var)));                    \
> -               break;                                  \
> -       case 8:                                         \
> -               asm(op "q "__percpu_arg(P1)",%0"        \
> -                   : "=r" (pfo_ret__)                  \
> -                   : "p" (&(var)));                    \
> -               break;                                  \
> -       default: __bad_percpu_size();                   \
> -       }                                               \
> -       pfo_ret__;                                      \
> +#define percpu_stable_op(size, op, _var)                               \
> +({                                                                     \
> +       __pcpu_type_##size pfo_val__;                                   \
> +       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")       \
> +           : [val] __pcpu_reg_##size("=", pfo_val__)                   \
> +           : [var] "p" (&(_var)));                                     \
> +       (typeof(_var))(unsigned long) pfo_val__;                        \
>  })
>
>  /*
> @@ -258,7 +237,11 @@ do {                                                                       \
>   * per-thread variables implemented as per-cpu variables and thus
>   * stable for the duration of the respective task.
>   */
> -#define this_cpu_read_stable(var)      percpu_stable_op("mov", var)
> +#define this_cpu_read_stable_1(pcp)    percpu_stable_op(1, "mov", pcp)
> +#define this_cpu_read_stable_2(pcp)    percpu_stable_op(2, "mov", pcp)
> +#define this_cpu_read_stable_4(pcp)    percpu_stable_op(4, "mov", pcp)
> +#define this_cpu_read_stable_8(pcp)    percpu_stable_op(8, "mov", pcp)
> +#define this_cpu_read_stable(pcp)      __pcpu_size_call_return(this_cpu_read_stable_, pcp)
>
>  #define raw_cpu_read_1(pcp)            percpu_from_op(1, , "mov", pcp)
>  #define raw_cpu_read_2(pcp)            percpu_from_op(2, , "mov", pcp)
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers

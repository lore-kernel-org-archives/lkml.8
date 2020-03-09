Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624FC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1789D20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPtfIydV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCIFIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:08:48 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45334 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIFIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:08:47 -0400
Received: by mail-il1-f194.google.com with SMTP id p1so3496066ils.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFl7NgmNLIN8sQCgq3SBAsrmBATnujIqCfwAlf8PKYE=;
        b=qPtfIydVgk/wqNHn9NwbDAly+4O+yXDUY3c8bmpD9FU94RbdUWiU15RLKAMG2sTn8K
         UsJEhr89um0gwKNBjJR0sqk3G9VkSWC1Dr6jPHEFRjeNJgwVifo0RaWzrg9A4nc9FMyz
         6YuhvTKJ2tU79qkYnaEcIaVmPi0BJvWgZyorroKfw/pFwALbfyBg83qdsJsOrpG77vjL
         qcxVkF19srsLMwMrq+2/8c7mjN3S9XaFtEsMeeBi1ku/2eknDOECbyA0qI8Ztpour1yI
         PTfkq6kV2ggvMI2zVGZnJy5yp9HTYIgLLvnX9tGOwiBZ/OBtnevsWtoFP+X5tqL40y4V
         kScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFl7NgmNLIN8sQCgq3SBAsrmBATnujIqCfwAlf8PKYE=;
        b=OAQAn4awuTwqfv5tWqWrvtzAETKHjbugbFXGq9K4cfOK6uSmGmme9+BarfldVHtr7y
         ya25UWRbjpD0JcWOKrofjFVFNEFZrdhGP4GIIkPSDk6cH+fmM4x0EwrElJFo2s96fBub
         /8a76re8ZxDgj8mzpXooGC+HyQRKdqBR8KZsRZuZtoVPP9hzBK63fnNtdxaTPLcYTdn9
         kQnK4FwXhu65QZNh62XQs/qFYXVinSjWUdmRwf9Q67xISBHOiJm3LdgkltHVxNIrgnON
         VAkUKO4G7jpjzkymbiKEGJEVaCNQShF8iy1IhijydNeGM1ckE1BHS65baGorgUXe7quh
         Fagg==
X-Gm-Message-State: ANhLgQ26J2J2C+H+++ybx9e2EEcX9nTAodbYCo2NR1MtbV005zwPW0eq
        7ENdMUL1FN+mtWRTvNkyRBpJo0auwNuZDIjH6w==
X-Google-Smtp-Source: ADFU+vuxb0JoiJXDiaFojwaBw6Me+xOIjGPm3wjhX0IS47/PKP326GKTKeTyid+DdxyeDhuQ+lNJhkYJYOmYqdcLdDI=
X-Received: by 2002:a92:dad0:: with SMTP id o16mr1372961ilq.27.1583730526906;
 Sun, 08 Mar 2020 22:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200308231410.905396057@linutronix.de> <20200308231718.931465601@linutronix.de>
In-Reply-To: <20200308231718.931465601@linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 9 Mar 2020 01:08:35 -0400
Message-ID: <CAMzpN2itqrztb+wA1k-KDwYMyQw3nZaMjzkHCu4GLr=t10ug=w@mail.gmail.com>
Subject: Re: [patch part-III V2 05/23] x86/entry/32: Provide macro to emit IDT
 entry stubs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 7:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> 32 and 64 bit have unnecessary different ways to populate the exception
> entry code. Provide a idtentry macro which allows to consolidate all of
> that.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>
> ---
>  arch/x86/entry/entry_32.S |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -44,6 +44,7 @@
>  #include <asm/asm.h>
>  #include <asm/smap.h>
>  #include <asm/frame.h>
> +#include <asm/trapnr.h>
>  #include <asm/nospec-branch.h>
>
>  #include "calling.h"
> @@ -726,6 +727,47 @@
>
>  .Lend_\@:
>  .endm
> +
> +#ifdef CONFIG_X86_INVD_BUG
> +.macro idtentry_push_func vector cfunc
> +       .if \vector == X86_TRAP_XF
> +               /* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
> +               ALTERNATIVE "pushl      $do_general_protection",        \
> +                           "pushl      $do_simd_coprocessor_error",    \
> +                           X86_FEATURE_XMM
> +       .else
> +               pushl $\cfunc
> +       .endif
> +.endm
> +#else
> +.macro idtentry_push_func vector cfunc
> +       pushl $\cfunc
> +.endm
> +#endif

IMHO it would be better to push this to the C code and not make the
asm more complicated.  Something like:

dotraplinkage void
do_simd_coprocessor_error(struct pt_regs *regs, long error_code)
{
#ifdef CONFIG_X86_INVD_BUG
        /* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
        if (!static_cpu_has(X86_FEATURE_XMM)) {
                do_general_protection(regs, error_code);
                return;
        }
#endif
        RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
        math_error(regs, error_code, X86_TRAP_XF);
}

--
Brian Gerst

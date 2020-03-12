Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6766E206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bjKyx+8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCLT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:29:36 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53073 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:29:35 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so2954396pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZAeG5IgI9pN69WnjsIKvEXCEiTIy5zYglja/seyzNJg=;
        b=bjKyx+8Pto3irYB6yarYr9P/spm7Ro+ti8wMP1IpJknUxTD6yvpOlsePvZ5N1/aHL2
         TGuA2mDyBo7Cp/t0PQNUygQd0udsbMtHSURgf5aoTtkaj9/t/JwyrwnhJ0k9R+ytUjUm
         uIayZkfTL63kl3RnXeEwKsje+OHWOM+/k6PuJkJw5cRDR1hQejaMqV4k79KzBxfRoTBO
         2jRq+X0qRMVJqWRzLDf8LzjrtsxsM3p94hRpzPSqi8AiISB3KKCSu1qPisOashxdVoHe
         LKVOSqdZSDHVzFjLX0Kh4jG6Yl6/a3l/36+6CtheVZD3FE+jPNuWZmjNe8R936MeVAXx
         QgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZAeG5IgI9pN69WnjsIKvEXCEiTIy5zYglja/seyzNJg=;
        b=DsfhbO3AzRUFXID9tvcjZelQsw47QxOa9SDL+d0YeGB+2AiF9WEztSrOE3pyzx0Xmd
         BOH1sA5GqDV5pgcVjwl4tZh01WR4F4qnt8ERSbMezxkN5h4UeZN9lRxGTwAR0/wGdyl9
         uOwI2UFkF44B9gbpU0jqhN1VCk5/pXMfNKH5OaO/rfWLMJaiR0gPtfNwX1WT1OEmWrEZ
         Q49jSRWFR/lfgBVPaF1arSjzTEP8mp5YHH67FH6EO34SoNtIoQu8bKcBeQ4/GqQpCWTA
         AX18Kl3u/AwTtIGFkt04o5o2S9etRsPev6ePbZTfbqPBzZuVQlKRNuvTVq2WlSSefN6H
         XGow==
X-Gm-Message-State: ANhLgQ1UI2ql0cMrcLCCwf1Gjw4RVpkeev51uhn+9NKUF2if2pls0RJh
        r0it1b1o8/dwyPUBJ65m0QaHdehfRCg=
X-Google-Smtp-Source: ADFU+vvUZ/OjKtLSL0hev3gyW11qPRxb4Ru6VTlww8kGre7BBvtMXusGWyHwsA+3b4/gBvK2seo9jw==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr9335942pln.178.1584041372412;
        Thu, 12 Mar 2020 12:29:32 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:7e0f:4c2d:a22:d693:1cde? ([2600:1010:b065:7e0f:4c2d:a22:d693:1cde])
        by smtp.gmail.com with ESMTPSA id m11sm9363036pjl.18.2020.03.12.12.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 12:29:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 03/14] x86/entry/64: Fix unwind hints in register clearing code
Date:   Thu, 12 Mar 2020 12:29:29 -0700
Message-Id: <DECA668C-B7EA-4663-8ABB-5B9E0495F498@amacapital.net>
References: <cb9b03b2a391b064573c152696d99017f76e8603.1584033751.git.jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <cb9b03b2a391b064573c152696d99017f76e8603.1584033751.git.jpoimboe@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





> On Mar 12, 2020, at 10:31 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>=20
> =EF=BB=BFThe PUSH_AND_CLEAR_REGS macro zeroes each register immediately af=
ter
> pushing it.  If an NMI or exception hits after a register is cleared,
> but before the UNWIND_HINT_REGS annotation, the ORC unwinder will
> wrongly think the previous value of the register was zero.  This can
> confuse the unwinding process and cause it to exit early.
>=20
> Because ORC is simpler than DWARF, there are a limited number of unwind
> annotation states, so it's not possible to add an individual unwind hint
> after each push/clear combination.  Instead, the register clearing
> instructions need to be consolidated and moved to after the
> UNWIND_HINT_REGS annotation.

I don=E2=80=99t suppose you know how bad t he performance hit is on a non-PT=
I machine?

>=20
> Fixes: 3f01daecd545 ("x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macr=
o")
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> arch/x86/entry/calling.h | 40 +++++++++++++++++++++-------------------
> 1 file changed, 21 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 0789e13ece90..1c7f13bb6728 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -98,13 +98,6 @@ For 32-bit we have the following conventions - kernel i=
s built with
> #define SIZEOF_PTREGS    21*8
>=20
> .macro PUSH_AND_CLEAR_REGS rdx=3D%rdx rax=3D%rax save_ret=3D0
> -    /*
> -     * Push registers and sanitize registers of values that a
> -     * speculation attack might otherwise want to exploit. The
> -     * lower registers are likely clobbered well before they
> -     * could be put to use in a speculative execution gadget.
> -     * Interleave XOR with PUSH for better uop scheduling:
> -     */
>    .if \save_ret
>    pushq    %rsi        /* pt_regs->si */
>    movq    8(%rsp), %rsi    /* temporarily store the return address in %rs=
i */
> @@ -114,34 +107,43 @@ For 32-bit we have the following conventions - kerne=
l is built with
>    pushq   %rsi        /* pt_regs->si */
>    .endif
>    pushq    \rdx        /* pt_regs->dx */
> -    xorl    %edx, %edx    /* nospec   dx */
>    pushq   %rcx        /* pt_regs->cx */
> -    xorl    %ecx, %ecx    /* nospec   cx */
>    pushq   \rax        /* pt_regs->ax */
>    pushq   %r8        /* pt_regs->r8 */
> -    xorl    %r8d, %r8d    /* nospec   r8 */
>    pushq   %r9        /* pt_regs->r9 */
> -    xorl    %r9d, %r9d    /* nospec   r9 */
>    pushq   %r10        /* pt_regs->r10 */
> -    xorl    %r10d, %r10d    /* nospec   r10 */
>    pushq   %r11        /* pt_regs->r11 */
> -    xorl    %r11d, %r11d    /* nospec   r11*/
>    pushq    %rbx        /* pt_regs->rbx */
> -    xorl    %ebx, %ebx    /* nospec   rbx*/
>    pushq    %rbp        /* pt_regs->rbp */
> -    xorl    %ebp, %ebp    /* nospec   rbp*/
>    pushq    %r12        /* pt_regs->r12 */
> -    xorl    %r12d, %r12d    /* nospec   r12*/
>    pushq    %r13        /* pt_regs->r13 */
> -    xorl    %r13d, %r13d    /* nospec   r13*/
>    pushq    %r14        /* pt_regs->r14 */
> -    xorl    %r14d, %r14d    /* nospec   r14*/
>    pushq    %r15        /* pt_regs->r15 */
> -    xorl    %r15d, %r15d    /* nospec   r15*/
>    UNWIND_HINT_REGS
> +
>    .if \save_ret
>    pushq    %rsi        /* return address on top of stack */
>    .endif
> +
> +    /*
> +     * Sanitize registers of values that a speculation attack might
> +     * otherwise want to exploit. The lower registers are likely clobbere=
d
> +     * well before they could be put to use in a speculative execution
> +     * gadget.
> +     */
> +    xorl    %edx,  %edx    /* nospec dx  */
> +    xorl    %ecx,  %ecx    /* nospec cx  */
> +    xorl    %r8d,  %r8d    /* nospec r8  */
> +    xorl    %r9d,  %r9d    /* nospec r9  */
> +    xorl    %r10d, %r10d    /* nospec r10 */
> +    xorl    %r11d, %r11d    /* nospec r11 */
> +    xorl    %ebx,  %ebx    /* nospec rbx */
> +    xorl    %ebp,  %ebp    /* nospec rbp */
> +    xorl    %r12d, %r12d    /* nospec r12 */
> +    xorl    %r13d, %r13d    /* nospec r13 */
> +    xorl    %r14d, %r14d    /* nospec r14 */
> +    xorl    %r15d, %r15d    /* nospec r15 */
> +
> .endm
>=20
> .macro POP_REGS pop_rdi=3D1 skip_r11rcx=3D0
> --=20
> 2.21.1
>=20

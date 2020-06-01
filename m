Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74081C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400A52074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFIhRfDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgFAU1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgFAU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:27:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FFDC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:27:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v2so3982200pfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKKBckStpKkgOLaANSaIoovtMS+K8cLCAUvbu3vJ8yo=;
        b=mFIhRfDmLZ17ZUUQxO0CmHH+nP8iwupfef6nehsU6hibPTW/SJ9tyY3lvKr4sCWgcR
         +aqHS2drNMNX61zyZ73UP1s7NgMJb/u60tj84s+nPOr6LWyOzc3wm4MA7IwkwdeI9o3c
         GELFZ/077srhAheqAqDXNeZSWPBPNjtZReL/gHHHGMHLBA6hdPhS1M8A/YY13WT+wq0G
         eqimLl88ttdozi2xlmw9G/Cd8g+GKzdS970Z69AohgJdygAUosIwAi5Fahks4oqIt0b5
         VBbP/0cdIK8PvyqVBife4VwO29/WhDd707/BwzJo9TTvuOnySmQ8ByPNUPJxLlpOTbj2
         rudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKKBckStpKkgOLaANSaIoovtMS+K8cLCAUvbu3vJ8yo=;
        b=souADfQN7QDNnyLrad2/j4idSIOFgwj7eihEMIMmll0rZccF6S+jbnawgORIYcNH27
         zBwUgndx9bc6FAea9NitjbLYX+Q+8Pq4ppeGbLoxuz3rkPtT7XP0fiEqnL0bHk4FrsmV
         DtdSZ7RMbLgxM+tPAlagFULCLQp6REaDCMWcA2MNgbJp4fiQhNkuDLZhPZ2iF99GKEww
         fi4qan7hYURoPPPal4qoupl/uhRBhDSxPCbmc9eDpQullEmf5ABrwWIAuG4bkeQFHdVq
         H4GNIp7M5YATtaaIjBzeW46BIHSN2B9bzz8C+ihBB37WE61Cha+ADCPSBq2EZsCAQcXP
         7uRQ==
X-Gm-Message-State: AOAM533ECeL8epkBWeG+3OY5y3xXvDvJ+ooIB4nEnPhNo1MpnrVTxb8+
        iZ2srVvs3NQLzO2FWek0CH9AMABQwoqE5r0PzfH2gA==
X-Google-Smtp-Source: ABdhPJxk0Q4E9bOVuOJUFnM20oE1z2g/J6TW1xd2epVXauF5H/iuKAzbnjV1w3/at482EBA+kL4ycKjmv3gLOXwFkKo=
X-Received: by 2002:a62:7e95:: with SMTP id z143mr4810212pfc.108.1591043221983;
 Mon, 01 Jun 2020 13:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-11-brgerst@gmail.com>
In-Reply-To: <20200530221127.459704-11-brgerst@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Jun 2020 13:26:50 -0700
Message-ID: <CAKwvOd=-qy6whi4UCzmsyY-A_cxCiO+ndydrcHjjAX7=qFKniQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] x86/percpu: Remove unused PER_CPU() macro
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
> Also remove now unused __percpu_mov_op.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>

This cleanup looks unrelated to the series, and can be sent separately
if needed.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/percpu.h | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index cf2b9c2a241e..a3c33b79fb86 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -4,33 +4,15 @@
>
>  #ifdef CONFIG_X86_64
>  #define __percpu_seg           gs
> -#define __percpu_mov_op                movq
>  #else
>  #define __percpu_seg           fs
> -#define __percpu_mov_op                movl
>  #endif
>
>  #ifdef __ASSEMBLY__
>
> -/*
> - * PER_CPU finds an address of a per-cpu variable.
> - *
> - * Args:
> - *    var - variable name
> - *    reg - 32bit register
> - *
> - * The resulting address is stored in the "reg" argument.
> - *
> - * Example:
> - *    PER_CPU(cpu_gdt_descr, %ebx)
> - */
>  #ifdef CONFIG_SMP
> -#define PER_CPU(var, reg)                                              \
> -       __percpu_mov_op %__percpu_seg:this_cpu_off, reg;                \
> -       lea var(reg), reg
>  #define PER_CPU_VAR(var)       %__percpu_seg:var
>  #else /* ! SMP */
> -#define PER_CPU(var, reg)      __percpu_mov_op $var, reg
>  #define PER_CPU_VAR(var)       var
>  #endif /* SMP */
>
> --
> 2.25.4
>


-- 
Thanks,
~Nick Desaulniers

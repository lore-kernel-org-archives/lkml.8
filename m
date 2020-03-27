Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48289C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B38B206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="I7zcFKtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0Rpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:45:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56555 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgC0Rpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:45:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48pq5D62XgzB09ZD;
        Fri, 27 Mar 2020 18:45:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=I7zcFKtD; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jCOozahwYNFE; Fri, 27 Mar 2020 18:45:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48pq5D4ybszB09ZC;
        Fri, 27 Mar 2020 18:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585331136; bh=3SkIPgsXKkFnLTZYxtFtW0Qi2neIcyQvhkRRPwD/4fY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I7zcFKtDhk0IpK6ocRGSsfjZqfvZ+BQdfe+AqF8TVwg7TG44rKz9ZyiOsez9Pi/ZU
         16OSJrxC98HLNaPifBNdK2NW3z5SWqYNZaWm9elGT78dOMxOWssJh9mv6oulYNZgpT
         LgEEurTeP2J90RiQYJRx9t0QZ7i//9eVRfjF5Cnw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5DED68B829;
        Fri, 27 Mar 2020 18:45:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UPRfRPNn2d55; Fri, 27 Mar 2020 18:45:38 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DFD748B822;
        Fri, 27 Mar 2020 18:45:36 +0100 (CET)
Subject: Re: [PATCH v1] powerpc: Make setjmp/longjump signature standard
To:     Clement Courbet <courbet@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20200327100801.161671-1-courbet@google.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f1b85a2a-1c60-9a12-f547-13ff255f18f0@c-s.fr>
Date:   Fri, 27 Mar 2020 18:45:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327100801.161671-1-courbet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject line, change longjump to longjmp

Le 27/03/2020 à 11:07, Clement Courbet a écrit :
> Declaring setjmp()/longjmp() as taking longs makes the signature
> non-standard, and makes clang complain. In the past, this has been
> worked around by adding -ffreestanding to the compile flags.
> 
> The implementation looks like it only ever propagates the value
> (in longjmp) or sets it to 1 (in setjmp), and we only call longjmp
> with integer parameters.
> 
> This allows removing -ffreestanding from the compilation flags.
> 
> Context:
> https://lore.kernel.org/patchwork/patch/1214060
> https://lore.kernel.org/patchwork/patch/1216174
> 
> Signed-off-by: Clement Courbet <courbet@google.com>
> ---
>   arch/powerpc/include/asm/setjmp.h | 6 ++++--
>   arch/powerpc/kexec/Makefile       | 3 ---
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
> index e9f81bb3f83b..84bb0d140d59 100644
> --- a/arch/powerpc/include/asm/setjmp.h
> +++ b/arch/powerpc/include/asm/setjmp.h
> @@ -7,7 +7,9 @@
>   
>   #define JMP_BUF_LEN    23
>   
> -extern long setjmp(long *) __attribute__((returns_twice));
> -extern void longjmp(long *, long) __attribute__((noreturn));
> +typedef long *jmp_buf;

Do we need that new opaque typedef ? Why not just keep long * ?

> +
> +extern int setjmp(jmp_buf env) __attribute__((returns_twice));
> +extern void longjmp(jmp_buf env, int val) __attribute__((noreturn));
>   
>   #endif /* _ASM_POWERPC_SETJMP_H */
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 378f6108a414..86380c69f5ce 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -3,9 +3,6 @@
>   # Makefile for the linux kernel.
>   #
>   
> -# Avoid clang warnings around longjmp/setjmp declarations
> -CFLAGS_crash.o += -ffreestanding
> -
>   obj-y				+= core.o crash.o core_$(BITS).o
>   
>   obj-$(CONFIG_PPC32)		+= relocate_32.o
> 

Christophe

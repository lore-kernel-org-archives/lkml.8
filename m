Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E85DC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E67A20767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Zb3sKzT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCSBKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:10:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCSBKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:10:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48jTNB4zmfz9sPR;
        Thu, 19 Mar 2020 12:10:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584580202;
        bh=dsAYUpBIHWyRqWv4FX0udbRGa8tLjAzSdzZd9Xm8pUc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Zb3sKzT6T9ViFk6GbzMBqYOtExyqc326gRnRRFeY93+ikmdpL/2w3BjoZYonb8xdB
         zNGeceQor22vgMsAqPzV2zcAEAQUhN/6BsBts7nvjXHmHscSS+eLB8ZFbBgwCe9amv
         NacobufLfRXgHz8hrby6XyLxQ3lsJUIsOARwMvDXgt85rL5f/2LK+yI42UsqXzRn41
         Fa8suzuIUejDuskRsHDvt9HYad1CfrU9dJvQ1JQGcMp1+eLS+4qK2FiqAG9Pf99xm+
         EahjJq64zjm9cSrJ5jwNLAy+G5YP9Kfy9U56PFB4b85CGiBQZxnicbvCaM3SjNcVen
         pnT8waua6xXjw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@ozlabs.org
Subject: Re: [PATCH] powerpc/vdso: Fix multiple issues with sys_call_table
In-Reply-To: <20200306135705.7f80fcad@kryten.localdomain>
References: <20200306135705.7f80fcad@kryten.localdomain>
Date:   Thu, 19 Mar 2020 12:10:03 +1100
Message-ID: <87pnd9duac.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@ozlabs.org> writes:
> The VDSO exports a bitmap of valid syscalls. vdso_setup_syscall_map()
> sets this up, but there are both little and big endian bugs. The issue
> is with:
>
>        if (sys_call_table[i] != sys_ni_syscall)
>
> On little endian, instead of comparing pointers to the two functions,
> we compare the first two instructions of each function. If a function
> happens to have the same first two instructions as sys_ni_syscall, then
> we have a spurious match and mark the instruction as not implemented.
> Fix this by removing the inline declarations.
>
> On big endian we have a further issue where sys_ni_syscall is a function
> descriptor and sys_call_table[] holds pointers to the instruction text.
> Fix this by using dereference_kernel_function_descriptor().
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

That's some pretty epic breakage.

Is it even worth keeping, or should we just rip it out and declare that
the syscall map is junk? Userspace can hardly rely on it given it's been
this broken for so long.

If not it would be really nice to have a selftest of this stuff so we
can verify it works and not break it again in future.

cheers

> ---
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index b9a108411c0d..d186b729026e 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -17,6 +17,7 @@
>  #include <linux/elf.h>
>  #include <linux/security.h>
>  #include <linux/memblock.h>
> +#include <linux/syscalls.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
> @@ -30,6 +31,7 @@
>  #include <asm/vdso.h>
>  #include <asm/vdso_datapage.h>
>  #include <asm/setup.h>
> +#include <asm/syscall.h>
>  
>  #undef DEBUG
>  
> @@ -644,19 +646,16 @@ static __init int vdso_setup(void)
>  static void __init vdso_setup_syscall_map(void)
>  {
>  	unsigned int i;
> -	extern unsigned long *sys_call_table;
> -#ifdef CONFIG_PPC64
> -	extern unsigned long *compat_sys_call_table;
> -#endif
> -	extern unsigned long sys_ni_syscall;
> +	unsigned long ni_syscall;
>  
> +	ni_syscall = (unsigned long)dereference_kernel_function_descriptor(sys_ni_syscall);
>  
>  	for (i = 0; i < NR_syscalls; i++) {
>  #ifdef CONFIG_PPC64
> -		if (sys_call_table[i] != sys_ni_syscall)
> +		if (sys_call_table[i] != ni_syscall)
>  			vdso_data->syscall_map_64[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
> -		if (compat_sys_call_table[i] != sys_ni_syscall)
> +		if (compat_sys_call_table[i] != ni_syscall)
>  			vdso_data->syscall_map_32[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
>  #else /* CONFIG_PPC64 */

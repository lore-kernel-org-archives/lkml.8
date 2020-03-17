Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C669BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4C420757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b15C/3oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCQNof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:44:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56009 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCQNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:44:34 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so10013661pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PkOXQDz4jrui7Qy162eWehG0Q0N7Wefij/5f7hp2nyk=;
        b=b15C/3oL0j8rS0HaysU1AnHJaSOjtXhBn/3XD6tVb9tr+tqbvRJOk7+Bkmz35C3A+w
         B/bB7Q3YHJBlZeq6S0gDMHJMs0B79NX0n3qsiz7os3MqCoQKir5jUltDh6K07QxDDom2
         FPf9Fzr5zykY9Nfca9BYW/g84Wn4a2IF5R3UhpiHZOEbl/6hCfoF7LmbRwb+HgU2L3c3
         w7poXvS4oS5S3bIzMMivbOa2kQifgRRXKIV4G4/e0nHlbkV4HQ83CyxR9qXIp2S9whz7
         zdcq7rgGdYsBHPaap+50IOPiY50Wc9VQmAQ2SPO1d25EVGYnUdul8ir3n4dpFPLuLkka
         CeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkOXQDz4jrui7Qy162eWehG0Q0N7Wefij/5f7hp2nyk=;
        b=PP2DDXdhyY1bNp5qhrRsGyommQ86XekQaQSE8slfo09cLt8sy3WoCMNN+EoWZN+kWo
         UyO39eGLxWMpO6BTXGEVRSowOh1ln65dBQD+Nm72HjjyUst7gnCv8VWJ3C0IdfaIhh8I
         ZKoCt/oaLFQ6XEqJw8XHe5r8sJx/mLA3siioWMQ6ZJyEJbU6IuCYpS4yaSD43NgccTdF
         FMl94VQR/P9CxCzGEvE9f8I4U5XPIqp1CeFyuvqaPPsygoZsL5JL+wxh8E2gYOtw743J
         YKzDliJOLfuWqd2BVRnT5a1qFNouOGWIUtPw7kEpodE+SSIjJs9iJsiO463bAiOnnctz
         AlJA==
X-Gm-Message-State: ANhLgQ2vMZ7gkE9GPYskz3S9YQrurHXMATlDl33Bzim1jZ2UKCuDlc0P
        KzNw8QLcpXlcWG8df4IQ0uE=
X-Google-Smtp-Source: ADFU+vv4cl/j/I62wV8vrntSG+1oR5I54O8yTpr23I66RF+bL0QHonHBPGzLuuTcfOHTEJSHi1/w+g==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr5053111pjb.83.1584452673733;
        Tue, 17 Mar 2020 06:44:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3sm3128270pfp.167.2020.03.17.06.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:44:32 -0700 (PDT)
Date:   Tue, 17 Mar 2020 06:44:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: Fix static memory detection
Message-ID: <20200317134431.GA6282@roeck-us.net>
References: <20200131021159.9178-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131021159.9178-1-linux@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ... I still see this problem.

Guenter

On Thu, Jan 30, 2020 at 06:11:59PM -0800, Guenter Roeck wrote:
> When booting x86 images in qemu, the following warning is seen
> randomly if DEBUG_LOCKDEP is enabled.
> 
> WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1119
> 	lockdep_register_key+0xc0/0x100
> 
> static_obj() returns true if an address is between _stext and _end.
> On x86, this includes the brk memory space. Problem is that this
> memory block is not static on x86; its unused portions are released
> after init and can be allocated. This results in the observed warning
> if a lockdep object is allocated from this memory.
> 
> Solve the problem by implementing arch_is_kernel_initmem_freed()
> for x86 and have it return true if an address is within the released
> memory range.
> 
> The same problem was solved for s390 with commit 7a5da02de8d6e
> ("locking/lockdep: check for freed initmem in static_obj()"), which
> introduced arch_is_kernel_initmem_freed().
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/x86/include/asm/sections.h | 20 ++++++++++++++++++++
>  arch/x86/kernel/setup.c         |  1 -
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> index 036c360910c5..a6e8373a5170 100644
> --- a/arch/x86/include/asm/sections.h
> +++ b/arch/x86/include/asm/sections.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_SECTIONS_H
>  #define _ASM_X86_SECTIONS_H
>  
> +#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
> +
>  #include <asm-generic/sections.h>
>  #include <asm/extable.h>
>  
> @@ -14,4 +16,22 @@ extern char __end_rodata_hpage_align[];
>  
>  extern char __end_of_kernel_reserve[];
>  
> +extern unsigned long _brk_start, _brk_end;
> +
> +static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
> +{
> +	/*
> +	 * If _brk_start has not been cleared, brk allocation is incomplete,
> +	 * and we can not make assumptions about its use.
> +	 */
> +	if (_brk_start)
> +		return 0;
> +
> +	/*
> +	 * After brk allocation is complete, space between _brk_end and _end
> +	 * is available for allocation.
> +	 */
> +	return addr >= _brk_end && addr < (unsigned long)&_end;
> +}
> +
>  #endif	/* _ASM_X86_SECTIONS_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1e4c20a1efec..08f5ceed70e0 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -64,7 +64,6 @@ RESERVE_BRK(dmi_alloc, 65536);
>   * at link time, with RESERVE_BRK*() facility reserving additional
>   * chunks.
>   */
> -static __initdata
>  unsigned long _brk_start = (unsigned long)__brk_base;
>  unsigned long _brk_end   = (unsigned long)__brk_base;
>  

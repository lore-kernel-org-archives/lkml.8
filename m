Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38F5C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31B02184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="seAzFJFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgEILdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:33:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgEILdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:33:13 -0400
Received: from zn.tnic (p200300EC2F1C0C0011662200A8F28825.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:c00:1166:2200:a8f2:8825])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 229B01EC0354;
        Sat,  9 May 2020 13:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589023991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HK37wBjC6kBztcACWPbLYAQv4qnWWZXNvdT9U5Ckhp4=;
        b=seAzFJFuNK3PLTUrvfOcL1UQzZ2lXqDSz29O5ft1Eu/DE+LVSCxHn2//YXBfZeAdvGq1qi
        GZz0jZt9O0jkEcCnxwV7JwBaLgZEc5S+oAknXgggbeIPEe+Pth4qZ9pKqjgj3JgdXMJ2gC
        M+iLe+v/z2r4wujsq/eKTc8x6GtCz9s=
Date:   Sat, 9 May 2020 13:33:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Use INVPCID mnemonic in invpcid.h
Message-ID: <20200509113307.GB5893@zn.tnic>
References: <20200508092247.132147-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508092247.132147-1-ubizjak@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:22:47AM +0200, Uros Bizjak wrote:
> Current minimum required version of binutils is 2.23,
> which supports INVPCID instruction mnemonic.
> 
> Replace the byte-wise specification of INVPCID with
> this proper mnemonic.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/invpcid.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
> index 989cfa86de85..23749bbca0ad 100644
> --- a/arch/x86/include/asm/invpcid.h
> +++ b/arch/x86/include/asm/invpcid.h
> @@ -12,12 +12,9 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
>  	 * stale TLB entries and, especially if we're flushing global
>  	 * mappings, we don't want the compiler to reorder any subsequent
>  	 * memory accesses before the TLB flush.
> -	 *
> -	 * The hex opcode is invpcid (%ecx), %eax in 32-bit mode and
> -	 * invpcid (%rcx), %rax in long mode.
>  	 */
> -	asm volatile (".byte 0x66, 0x0f, 0x38, 0x82, 0x01"
> -		      : : "m" (desc), "a" (type), "c" (&desc) : "memory");
> +	asm volatile ("invpcid %1, %0"
> +		      : : "r" (type), "m" (desc) : "memory");

How about I make it even more readable when applying?

        asm volatile("invpcid %[desc], %[type]"
                     :: [desc] "m" (desc), [type] "r" (type) : "memory");

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

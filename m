Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B077EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD9206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j4F6gt+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgFJTgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFJTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:36:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92C1C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8ghC+vmTGIqK1CHqeWZt7cWGPC/FCSZFgrrDuvIqh2k=; b=j4F6gt+HuszBoawySExHD+f1aj
        o5YiNMgIcHL3B5tQ00XOFZaToObxmyGxfq9xk2xeUBcML9M1cyy1+OaYmDVJkIRGUTJwgx9oe9q+J
        83n89sPPTbRTtNk952N04YcjuhLSyr/WfPbhCEdulXyUyYjJxwA9oBKKvL8Ld/Fsm/XEjrpMtGp6q
        +sqi+UOTmz4e5knIOrVMeFVXNdHZJfUq9U0DUP6WuVYrrT7hVMrES+jm2jMC9nnNF51rCtgVzQ8Wu
        95SxKv6Z1q+hxsfry005YhQYK5U+2UdoJIb/H1ocTylpu6cVPEJUJhtFqIKGx910DaZKlGe7tWMdn
        UJRRGIRQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj6WG-0007BW-4F; Wed, 10 Jun 2020 19:36:16 +0000
Subject: Re: [PATCH] Fix undefined operation VMXOFF during reboot and crash
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20200610181254.2142-1-dpreed@deepplum.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e62c3c33-b3c4-c885-f588-577899d1d602@infradead.org>
Date:   Wed, 10 Jun 2020 12:36:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610181254.2142-1-dpreed@deepplum.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

If you happen to make a v2 of this patch, there are a few comments
that begin with "/**" but they are not kernel-doc comments, so they
should instead begin with just "/*". Please see below.

(and you did not introduce this comment style here.)

On 6/10/20 11:12 AM, David P. Reed wrote:
> 
> Signed-off-by: David P. Reed <dpreed@deepplum.com>
> ---
>  arch/x86/include/asm/virtext.h | 24 ++++++++++++----
>  arch/x86/kernel/reboot.c       | 13 ++-------
>  arch/x86/kernel/traps.c        | 52 ++++++++++++++++++++++++++++++++--
>  3 files changed, 71 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> index 9aad0e0876fb..ea2d67191684 100644
> --- a/arch/x86/include/asm/virtext.h
> +++ b/arch/x86/include/asm/virtext.h
> @@ -13,12 +13,16 @@
>  #ifndef _ASM_X86_VIRTEX_H
>  #define _ASM_X86_VIRTEX_H
>  
> +#include <linux/percpu.h>
> +
>  #include <asm/processor.h>
>  
>  #include <asm/vmx.h>
>  #include <asm/svm.h>
>  #include <asm/tlbflush.h>
>  
> +DECLARE_PER_CPU_READ_MOSTLY(int, doing_emergency_vmxoff);
> +
>  /*
>   * VMX functions:
>   */
> @@ -33,8 +37,8 @@ static inline int cpu_has_vmx(void)
>  /** Disable VMX on the current CPU

just
   /* Disable VMX on the current CPU

>   *
>   * vmxoff causes a undefined-opcode exception if vmxon was not run
> - * on the CPU previously. Only call this function if you know VMX
> - * is enabled.
> + * on the CPU previously. Only call this function directly if you know VMX
> + * is enabled *and* CPU is in VMX root operation.
>   */
>  static inline void cpu_vmxoff(void)
>  {
> @@ -47,17 +51,25 @@ static inline int cpu_vmx_enabled(void)
>  	return __read_cr4() & X86_CR4_VMXE;
>  }
>  
> -/** Disable VMX if it is enabled on the current CPU
> +/** Force disable VMX if it is enabled on the current CPU.

just
   /* Force disable VMX if it is enabled on the current CPU.

> + * Note that if CPU is not in VMX root operation this
> + * VMXOFF will fault an undefined operation fault.
> + * So the 'doing_emergency_vmxoff' percpu flag is set,
> + * the trap handler for just restarts execution after
> + * the VMXOFF instruction.
>   *
> - * You shouldn't call this if cpu_has_vmx() returns 0.
> + * You shouldn't call this directly if cpu_has_vmx() returns 0.
>   */
>  static inline void __cpu_emergency_vmxoff(void)
>  {
> -	if (cpu_vmx_enabled())
> +	if (cpu_vmx_enabled()) {
> +		this_cpu_write(doing_emergency_vmxoff, 1);
>  		cpu_vmxoff();
> +		this_cpu_write(doing_emergency_vmxoff, 0);
> +	}
>  }
>  
> -/** Disable VMX if it is supported and enabled on the current CPU
> +/** Force disable VMX if it is supported and enabled on the current CPU

ditto.


>   */
>  static inline void cpu_emergency_vmxoff(void)
>  {


thanks.
-- 
~Randy


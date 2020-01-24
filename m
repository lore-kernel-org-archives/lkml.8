Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2432FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52DD2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 05:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="i+1ZNLkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgAXFqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 00:46:30 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgAXFqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:46:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483p6W5zVMz9sNF;
        Fri, 24 Jan 2020 16:46:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579844788;
        bh=gUhlGsmxPsj7AoZY/nvO9RjsEp2BAfmFuizDcUbrgWo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i+1ZNLknNeLIspRl2aa5x3e2lpTbg88wfyCrpdxXnt8EvwW3El3+zs2qZBVm1FDcK
         TcRLmmkSc5q4TEwLXC6TqhOjfnX901H4gmhsXzQv/R3TPmIe6cDj7CakIRwiyTy+6L
         9WhV6NW9ZmZE07oOmbO9m04kgo3ift2emmVWMK1NAecX+ZoJMhXsGXMqgkOSPd730g
         BhRrJY4+wkqP8DzYxEV1OfVFHysGfy0yxHlQ1Y8L7H4YWh5hIo41AFqOhLFFHYKbkR
         NV+VIqtvStT8EdbeJtYKjVLQ1+W3zy5kGFQxeb6jJWgeoCWHtTOorJjVfbRrgsz3Tf
         +9YgFW25zZ9Hg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/irq: don't use current_stack_pointer() in check_stack_overflow()
In-Reply-To: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
References: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
Date:   Fri, 24 Jan 2020 16:46:24 +1100
Message-ID: <87d0b9iez3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> current_stack_pointer() doesn't return the stack pointer, but the
> caller's stack frame. See commit bfe9a2cfe91a ("powerpc: Reimplement
> __get_SP() as a function not a define") and commit acf620ecf56c
> ("powerpc: Rename __get_SP() to current_stack_pointer()") for details.
>
> The purpose of check_stack_overflow() is to verify that the stack has
> not overflowed.
>
> To really know whether the stack pointer is still within boundaries,
> the check must be done directly on the value of r1.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/irq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index bb34005ff9d2..4d468d835558 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -599,9 +599,8 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
>  static inline void check_stack_overflow(void)
>  {
>  #ifdef CONFIG_DEBUG_STACKOVERFLOW
> -	long sp;
> -
> -	sp = current_stack_pointer() & (THREAD_SIZE-1);
> +	register unsigned long r1 asm("r1");
> +	long sp = r1 & (THREAD_SIZE - 1);

This appears to work but seems to be "unsupported" by GCC, and clang
actually complains about it:

  /linux/arch/powerpc/kernel/irq.c:603:12: error: variable 'r1' is uninitialized when used here [-Werror,-Wuninitialized]
          long sp = r1 & (THREAD_SIZE - 1);
                    ^~

The GCC docs say:

  The only supported use for this feature is to specify registers for
  input and output operands when calling Extended asm (see Extended
  Asm).

https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Local-Register-Variables.html#Local-Register-Variables


If I do this it seems to work, but feels a little dicey:

	asm ("" : "=r" (r1));
	sp = r1 & (THREAD_SIZE - 1);


Generated code looks OK ish:

clang:

        sp = r1 & (THREAD_SIZE - 1);
    22e0:       a0 04 24 78     clrldi  r4,r1,50
        if (unlikely(sp < 2048)) {
    22e4:       ff 07 24 28     cmpldi  r4,2047
    22e8:       58 00 81 40     ble     2340 <do_IRQ+0xe0>


gcc:
	if (unlikely(sp < 2048)) {
    2eb4:	00 38 28 70 	andi.   r8,r1,14336
...
    2ecc:	24 00 82 40 	bne     c000000000002ef0 <do_IRQ+0xa0>


cheers

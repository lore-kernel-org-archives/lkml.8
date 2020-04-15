Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE3A20732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbgDOWiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:38:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:54212 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDOWiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:38:08 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03FMbmpQ029595;
        Wed, 15 Apr 2020 17:37:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 03FMblsA029594;
        Wed, 15 Apr 2020 17:37:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 15 Apr 2020 17:37:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200415223747.GX26902@gate.crashing.org>
References: <c9abd91e9bb0b3dd6e3470015e92b98bc2483780.1586942304.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9abd91e9bb0b3dd6e3470015e92b98bc2483780.1586942304.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Apr 15, 2020 at 09:25:59AM +0000, Christophe Leroy wrote:
> +#define __put_user_goto(x, ptr, label) \
> +	__put_user_nocheck_goto((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)

This line gets too long, can you break it up somehow?

> +#define __put_user_asm_goto(x, addr, label, op)			\
> +	asm volatile goto(					\
> +		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> +		EX_TABLE(1b, %l2)				\
> +		:						\
> +		: "r" (x), "m" (*addr)				\
> +		:						\
> +		: label)

Same "%Un" problem as in the other patch.  You could use "m<>" here,
but maybe just dropping "%Un" is better.

> +#ifdef __powerpc64__
> +#define __put_user_asm2_goto(x, ptr, label)			\
> +	__put_user_asm_goto(x, ptr, label, "std")
> +#else /* __powerpc64__ */
> +#define __put_user_asm2_goto(x, addr, label)			\
> +	asm volatile goto(					\
> +		"1:	stw%U1%X1 %0, %1\n"			\
> +		"2:	stw%U1%X1 %L0, %L1\n"			\
> +		EX_TABLE(1b, %l2)				\
> +		EX_TABLE(2b, %l2)				\
> +		:						\
> +		: "r" (x), "m" (*addr)				\
> +		:						\
> +		: label)
> +#endif /* __powerpc64__ */

Here, you should drop it for sure.

Rest looks fine.

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher

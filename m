Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83424206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IWB2GGrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgBLPzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:55:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=236Mw1/uA8IzDXd3kiwB4aT/6byMucMo+CkTmpwTWV4=; b=IWB2GGrr71/zFcxIvbhVH1hZXm
        ydlx9gUhkyKw9Oli8Y2DcKNQZo1bXX1ISiLawDf7LTwuduqj9WVsjHeEPjFUHMVaEKles4FJsDTdN
        T0er4IbprW9Lw4JM2KjnM2S08JjlV9l0gVEQTHhIP9RqZvX1NAVnlNluwQc1EPSu5bitIlMWELQnq
        52dpCghtlfAtfj9komDCeR9ygX9+r48vw7E80osLdNZYP9I7U+xQYQASUliWWSkRT00l9NKXXYxLd
        3tOMLJPWPyacvT2le07WKx6695JEnWanhrgTwy/xIKOyA67DPN2zbL0JFcQJuf712jLQn8fPvcJLP
        884IB6PA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1uLu-0002bQ-Hg; Wed, 12 Feb 2020 15:55:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F20D30220B;
        Wed, 12 Feb 2020 16:53:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAA6C2B49C819; Wed, 12 Feb 2020 16:55:00 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:55:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de,
        Stefan Asserhall load and store 
        <stefan.asserhall@xilinx.com>, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200212155500.GB14973@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:42:29PM +0100, Michal Simek wrote:
> From: Stefan Asserhall load and store <stefan.asserhall@xilinx.com>
> 
> Implement SMP aware atomic operations.
> 
> Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/microblaze/include/asm/atomic.h | 265 +++++++++++++++++++++++++--
>  1 file changed, 253 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/atomic.h b/arch/microblaze/include/asm/atomic.h
> index 41e9aff23a62..522d704fad63 100644
> --- a/arch/microblaze/include/asm/atomic.h
> +++ b/arch/microblaze/include/asm/atomic.h
> @@ -1,28 +1,269 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2013-2020 Xilinx, Inc.
> + */
> +
>  #ifndef _ASM_MICROBLAZE_ATOMIC_H
>  #define _ASM_MICROBLAZE_ATOMIC_H
>  
> +#include <linux/types.h>
>  #include <asm/cmpxchg.h>
> -#include <asm-generic/atomic.h>
> -#include <asm-generic/atomic64.h>
> +
> +#define ATOMIC_INIT(i)	{ (i) }
> +
> +#define atomic_read(v)	READ_ONCE((v)->counter)
> +
> +static inline void atomic_set(atomic_t *v, int i)
> +{
> +	int result, tmp;
> +
> +	__asm__ __volatile__ (
> +		/* load conditional address in %2 to %0 */
> +		"1:	lwx	%0, %2, r0;\n"
> +		/* attempt store */
> +		"	swx	%3, %2, r0;\n"
> +		/* checking msr carry flag */
> +		"	addic	%1, r0, 0;\n"
> +		/* store failed (MSR[C] set)? try again */
> +		"	bnei	%1, 1b;\n"
> +		/* Outputs: result value */
> +		: "=&r" (result), "=&r" (tmp)
> +		/* Inputs: counter address */
> +		: "r" (&v->counter), "r" (i)
> +		: "cc", "memory"
> +	);
> +}
> +#define atomic_set	atomic_set

Uuuuhh.. *what* ?!?

Are you telling me your LL/SC implementation is so bugger that
atomic_set() being a WRITE_ONCE() does not in fact work?

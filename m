Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB84206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nhwbeaui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgBLPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:48:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H38SJNh9aChtjJqMNXwFc5QbtQ8ATP9QHzL8A+pQXvI=; b=nhwbeauiIFcpogTY7q9QmpyT5b
        CipV2oluFARlDm/WLw6wS0EdMYBqT9SpCpAUvL/gEsg3sFMx+MHqpyoZBNEkzkJif+KFBOxwYPLXA
        fK7oTTPuCr80UMf8XXSqZbcU+TQWbIFtHARS+4p9hwy39ZWYwzz5Ec5eIEZOuPNTmP/5i5v6RbiZD
        S1UwNYMgMZg7LDK6SUhT4Ovat0dGJOBdOYG4i1X8OK+++3m0KffKo2ObVbcFnJEbjTsYZqCCX0O+z
        eS9m3DzFSTBYjOSKG3f7Gx56grQmSqdEw9WIVkbGl6eNT4zwvh5K72X49WW2tdbitsrzNigMkgd26
        CphbaVwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1uF4-0004I6-Cz; Wed, 12 Feb 2020 15:47:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6C91300235;
        Wed, 12 Feb 2020 16:46:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 003A42038B228; Wed, 12 Feb 2020 16:47:56 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:47:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6/7] microblaze: Implement architecture spinlock
Message-ID: <20200212154756.GY14897@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ed53474e9ca6736353afd10ebe7ea98e4c6c459e.1581522136.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed53474e9ca6736353afd10ebe7ea98e4c6c459e.1581522136.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:42:28PM +0100, Michal Simek wrote:
> From: Stefan Asserhall <stefan.asserhall@xilinx.com>
> 
> Using exclusive loads/stores to implement spinlocks which can be used on
> SMP systems.
> 
> Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++++
>  arch/microblaze/include/asm/spinlock_types.h |  25 ++
>  2 files changed, 265 insertions(+)
>  create mode 100644 arch/microblaze/include/asm/spinlock.h
>  create mode 100644 arch/microblaze/include/asm/spinlock_types.h
> 
> diff --git a/arch/microblaze/include/asm/spinlock.h b/arch/microblaze/include/asm/spinlock.h
> new file mode 100644
> index 000000000000..0199ea9f7f0f
> --- /dev/null
> +++ b/arch/microblaze/include/asm/spinlock.h
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2013-2020 Xilinx, Inc.
> + */
> +
> +#ifndef _ASM_MICROBLAZE_SPINLOCK_H
> +#define _ASM_MICROBLAZE_SPINLOCK_H
> +
> +/*
> + * Unlocked value: 0
> + * Locked value: 1
> + */
> +#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
> +
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	unsigned long tmp;
> +
> +	__asm__ __volatile__ (
> +		/* load conditional address in %1 to %0 */
> +		"1:	lwx	 %0, %1, r0;\n"
> +		/* not zero? try again */
> +		"	bnei	%0, 1b;\n"
> +		/* increment lock by 1 */
> +		"	addi	%0, r0, 1;\n"
> +		/* attempt store */
> +		"	swx	%0, %1, r0;\n"
> +		/* checking msr carry flag */
> +		"	addic	%0, r0, 0;\n"
> +		/* store failed (MSR[C] set)? try again */
> +		"	bnei	%0, 1b;\n"
> +		/* Outputs: temp variable for load result */
> +		: "=&r" (tmp)
> +		/* Inputs: lock address */
> +		: "r" (&lock->lock)
> +		: "cc", "memory"
> +	);
> +}

That's a test-and-set spinlock if I read it correctly. Why? that's the
worst possible spinlock implementation possible.

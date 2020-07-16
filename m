Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD62C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8141D21532
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGPXJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:43 -0400
Received: from kernel.crashing.org ([76.164.61.194]:38540 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgGPXJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:35 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06GMcUf3029747
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Jul 2020 17:38:33 -0500
Message-ID: <b1aa976cf9788ed7d2bf949b2b5e5e5b2e3f9776.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: Fix an out of date comment about MMIO
 ordering
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Will Deacon <willdeacon@google.com>
Cc:     mpe@ellerman.id.au, paulus@samba.org, npiggin@gmail.com,
        msuchanek@suse.de, tglx@linutronix.de, bigeasy@linutronix.de,
        jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Date:   Fri, 17 Jul 2020 08:38:29 +1000
In-Reply-To: <20200716193820.1141936-1-palmer@dabbelt.com>
References: <20200716193820.1141936-1-palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 12:38 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This primitive has been renamed, but because it was spelled incorrectly in the
> first place it must have escaped the fixup patch.  As far as I can tell this
> logic is still correct: smp_mb__after_spinlock() uses the default smp_mb()
> implementation, which is "sync" rather than "hwsync" but those are the same
> (though I'm not that familiar with PowerPC).

Typo ? That must be me ... :)

Looks fine. Yes, sync and hwsync are the same (by opposition to lwsync
which is lighter weight and doesn't order cache inhibited).

Cheers,
Ben.

> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index b3c9f15089b6..7b38b4daca93 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -357,7 +357,7 @@ _GLOBAL(_switch)
>  	 * kernel/sched/core.c).
>  	 *
>  	 * Uncacheable stores in the case of involuntary preemption must
> -	 * be taken care of. The smp_mb__before_spin_lock() in __schedule()
> +	 * be taken care of. The smp_mb__after_spinlock() in __schedule()
>  	 * is implemented as hwsync on powerpc, which orders MMIO too. So
>  	 * long as there is an hwsync in the context switch path, it will
>  	 * be executed on the source CPU after the task has performed


Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65741C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422C7206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCMOYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:24:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46883 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:24:15 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jClEP-0005kJ-Al; Fri, 13 Mar 2020 15:24:09 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6BD51100C8D; Fri, 13 Mar 2020 15:24:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <minlei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/vector: Allow to free vector for managed IRQ
In-Reply-To: <20200312205830.81796-1-peterx@redhat.com>
References: <20200312205830.81796-1-peterx@redhat.com>
Date:   Fri, 13 Mar 2020 15:24:08 +0100
Message-ID: <878sk4ib93.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> After we introduced the "managed_irq" sub-parameter for isolcpus, it's
> possible to free a kernel managed irq vector now.
>
> It can be triggered easily by booting a VM with a few vcpus, with one
> virtio-blk device and then mark some cores as HK_FLAG_MANAGED_IRQ (in
> below case, there're 4 vcpus, with vcpu 3 isolated with managed_irq):
>
> [    2.889911] ------------[ cut here ]------------
> [    2.889964] WARNING: CPU: 3 PID: 0 at arch/x86/kernel/apic/vector.c:853 free_moved_vector+0x126/0x160

<SNIP>

> [    2.890026] softirqs last disabled at (8757): [<ffffffffbb0ecccd>] irq_enter+0x4d/0x70
> [    2.890027] ---[ end trace deb5d563d2acb13f ]---

What is this backtrace for? It's completly useless as it merily shows
that the warning triggers. Also even if it'd be useful then it wants to
be trimmed properly.

> I believe the same thing will happen to bare metals.

Believe is not really relevant in engineering.

The problem has nothing to do with virt or bare metal. It's a genuine
issue.

> When allocating the IRQ for the device, activate_managed() will try to
> allocate a vector based on what we've calculated for kernel managed
> IRQs (which does not take HK_FLAG_MANAGED_IRQ into account).  However
> when we bind the IRQ to the IRQ handler, we'll do irq_startup() and
> irq_do_set_affinity(), in which we will start to consider the whole
> HK_FLAG_MANAGED_IRQ logic.  This means the chosen core can be
> different from when we do the allocation.  When that happens, we'll
> need to be able to properly free the old vector on the old core.

There's lots of 'we' in that text. We do nothing really. Please describe
things in neutral and factual language.

Also there is another way to trigger this: Offline all non-isolated CPUs
in the mask and then bring one online again.

Ming, I really have to ask why these two situations were not tested
before the final submission of that isolation patch. Both issues have
been discussed during review of the different versions. So the warning
should have triggered back then already....

> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 2c5676b0a6e7..a1142260b123 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -837,14 +837,6 @@ static void free_moved_vector(struct apic_chip_data *apicd)
>  	unsigned int cpu = apicd->prev_cpu;
>  	bool managed = apicd->is_managed;
>  
> -	/*
> -	 * This should never happen. Managed interrupts are not
> -	 * migrated except on CPU down, which does not involve the
> -	 * cleanup vector. But try to keep the accounting correct
> -	 * nevertheless.
> -	 */

While the comment is not longer correct, removing it is lame. This
should have an explanation why managed interrupts can end up here.

No need to resend. I fixed it up already.

Thanks,

        tglx

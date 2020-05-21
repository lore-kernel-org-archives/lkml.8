Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B314C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE5207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgEUODi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:03:38 -0400
Received: from foss.arm.com ([217.140.110.172]:47426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgEUODi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935A4D6E;
        Thu, 21 May 2020 07:03:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F97D3F305;
        Thu, 21 May 2020 07:03:36 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-4-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 03/11] arm64: Allow IPIs to be handled as normal interrupts
In-reply-to: <20200519161755.209565-4-maz@kernel.org>
Date:   Thu, 21 May 2020 15:03:29 +0100
Message-ID: <jhjlfllxu4u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/20 17:17, Marc Zyngier wrote:
> In order to deal with IPIs as normal interrupts, let's add
> a new way to register them with the architecture code.
>
> set_smp_ipi_range() takes a range of interrupts, and allows
> the arch code to request them as if the were normal interrupts.
                                      ^^^
                                  s/the/they/

> A standard handler is then called by the core IRQ code to deal
> with the IPI.
>
> This means that we don't need to call irq_enter/irq_exit, and
> that we don't need to deal with set_irq_regs either. So let's
> move the dispatcher into its own function, and leave handle_IPI()
> as a compatibility function.
>
> On the sending side, let's make use of ipi_send_mask, which
> already exists for this purpose.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/Kconfig           |  1 +
>  arch/arm64/include/asm/smp.h |  5 ++
>  arch/arm64/kernel/smp.c      | 92 +++++++++++++++++++++++++++++++-----
>  3 files changed, 86 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 061f60fe452f..93ba0025e7b9 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -247,6 +254,8 @@ asmlinkage notrace void secondary_start_kernel(void)
>        */
>       notify_cpu_starting(cpu);
>
> +	ipi_setup(cpu);
> +
>       store_cpu_topology(cpu);
>       numa_add_cpu(cpu);
>
> @@ -374,6 +383,8 @@ void cpu_die(void)
>
>       local_daif_mask();
>
> +	ipi_teardown(cpu);
> +

Would it make sense to move it up to say __cpu_disable()? I'm thinking it
would make sense to bunch this up with the toggling of the cpu_online_mask
bit, and FWIW it'd match with the comment atop the cpuhp callsite.

Once the CPU is set as offline, all it has left to do is to go die in
do_idle(), so AFAICT we can do that IPI teardown anywhere inbetween.

>       /* Tell __cpu_die() that this CPU is now safe to dispose of */
>       (void)cpu_report_death();
>

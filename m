Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899052075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgGJT6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:58:47 -0400
Received: from foss.arm.com ([217.140.110.172]:37538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgGJT6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:58:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32716106F;
        Fri, 10 Jul 2020 12:58:46 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 829573F819;
        Fri, 10 Jul 2020 12:58:44 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-4-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 03/17] arm64: Allow IPIs to be handled as normal interrupts
In-reply-to: <20200624195811.435857-4-maz@kernel.org>
Date:   Fri, 10 Jul 2020 20:58:42 +0100
Message-ID: <jhjo8onkuq5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Itsy bitsy nit below from re-reading this.

On 24/06/20 20:57, Marc Zyngier wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index e43a8ff19f0f..c08950cc09cc 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -76,6 +76,13 @@ enum ipi_msg_type {
>       IPI_WAKEUP
>  };
>
> +static int ipi_irq_base;
> +static int nr_ipi = NR_IPI;

If we really care, these two could be marked as __read_mostly.

> +static struct irq_desc *ipi_desc[NR_IPI];
> +
> +static void ipi_setup(int cpu);
> +static void ipi_teardown(int cpu);
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int op_cpu_kill(unsigned int cpu);
>  #else

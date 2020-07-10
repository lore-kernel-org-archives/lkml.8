Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6CDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E2C207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGJT6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:58:54 -0400
Received: from foss.arm.com ([217.140.110.172]:37574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgGJT6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:58:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14B0631B;
        Fri, 10 Jul 2020 12:58:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 668FC3F819;
        Fri, 10 Jul 2020 12:58:52 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-16-maz@kernel.org>
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
Subject: Re: [PATCH v2 15/17] arm64: Remove custom IRQ stat accounting
In-reply-to: <20200624195811.435857-16-maz@kernel.org>
Date:   Fri, 10 Jul 2020 20:58:50 +0100
Message-ID: <jhjmu47kupx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 20:58, Marc Zyngier wrote:
> Let's switch the arm64 code to the core accounting, which already
> does everything we need.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/hardirq.h |  9 ---------
>  arch/arm64/kernel/smp.c          | 24 ++++++------------------
>  2 files changed, 6 insertions(+), 27 deletions(-)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index ed8a8184e3b6..8b903ceef2be 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -991,7 +979,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>               int err;
>
>               err = request_percpu_irq(ipi_base + i, ipi_handler,
> -					 "IPI", &irq_stat);
> +					 "IPI", &cpu_number);

That pointer remains unused in ipi_handler(); I suppose it's just a matter
of cosmetics? I see that we leave it as irq_stat in arm, I suppose simply
because we don't have a cpu_number equivalent there and need *some* percpu
variable for the request to happen.

>               WARN_ON(err);
>
>               ipi_desc[i] = irq_to_desc(ipi_base + i);

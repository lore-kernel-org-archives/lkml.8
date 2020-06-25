Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544C0207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406149AbgFYS0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:26:14 -0400
Received: from foss.arm.com ([217.140.110.172]:43232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404019AbgFYS0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:26:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02B9DD6E;
        Thu, 25 Jun 2020 11:26:13 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5737C3F71E;
        Thu, 25 Jun 2020 11:26:11 -0700 (PDT)
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
Date:   Thu, 25 Jun 2020 19:26:09 +0100
Message-ID: <jhjftajgfy6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 20:58, Marc Zyngier wrote:
> @@ -801,26 +802,15 @@ void show_ipi_list(struct seq_file *p, int prec)
>       unsigned int cpu, i;
>
>       for (i = 0; i < NR_IPI; i++) {
> +		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
>               seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>                          prec >= 4 ? " " : "");
>               for_each_online_cpu(cpu)
> -			seq_printf(p, "%10u ",
> -				   __get_irq_stat(cpu, ipi_irqs[i]));
> +			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
>               seq_printf(p, "      %s\n", ipi_types[i]);

How attached are we to that custom IPI printout? AIUI we *could* give them
a "prettier" name in request_percpu_irq() and let the standard procfs
printout take the wheel.

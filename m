Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AECEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0074120781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405842AbgFYS0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:26:01 -0400
Received: from foss.arm.com ([217.140.110.172]:43192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404019AbgFYS0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:26:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4E9D6E;
        Thu, 25 Jun 2020 11:26:00 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16FF03F71E;
        Thu, 25 Jun 2020 11:25:58 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-15-maz@kernel.org>
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
Subject: Re: [PATCH v2 14/17] arm64: Kill __smp_cross_call and co
In-reply-to: <20200624195811.435857-15-maz@kernel.org>
Date:   Thu, 25 Jun 2020 19:25:56 +0100
Message-ID: <jhjh7uzgfyj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 20:58, Marc Zyngier wrote:
> @@ -852,8 +841,7 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
>  #ifdef CONFIG_IRQ_WORK
>  void arch_irq_work_raise(void)
>  {
> -	if (__smp_cross_call)
> -		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
> +	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);

AIU the following commit:

  eb631bb5bf5b ("arm64: Support arch_irq_work_raise() via self IPIs")

It seems arm64 hasn't needed that check since

  4b3dc9679cf7 ("arm64: force CONFIG_SMP=y and remove redundant #ifdefs")

Did I get that right?

>  }
>  #endif
>

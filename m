Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 23:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE92073E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFZXPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 19:15:48 -0400
Received: from foss.arm.com ([217.140.110.172]:34892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgFZXPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 19:15:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A4230E;
        Fri, 26 Jun 2020 16:15:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6B9C3F73C;
        Fri, 26 Jun 2020 16:15:45 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-16-maz@kernel.org> <jhjftajgfy6.mognet@arm.com> <d1c0d35a38844ee3907571348f3bc1fd@kernel.org>
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
In-reply-to: <d1c0d35a38844ee3907571348f3bc1fd@kernel.org>
Date:   Sat, 27 Jun 2020 00:15:40 +0100
Message-ID: <jhjd05lh10j.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/06/20 12:58, Marc Zyngier wrote:
> On 2020-06-25 19:26, Valentin Schneider wrote:
>> On 24/06/20 20:58, Marc Zyngier wrote:
>>> @@ -801,26 +802,15 @@ void show_ipi_list(struct seq_file *p, int prec)
>>>       unsigned int cpu, i;
>>>
>>>       for (i = 0; i < NR_IPI; i++) {
>>> +		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
>>>               seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
>>>                          prec >= 4 ? " " : "");
>>>               for_each_online_cpu(cpu)
>>> -			seq_printf(p, "%10u ",
>>> -				   __get_irq_stat(cpu, ipi_irqs[i]));
>>> +			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
>>>               seq_printf(p, "      %s\n", ipi_types[i]);
>>
>> How attached are we to that custom IPI printout? AIUI we *could* give
>> them
>> a "prettier" name in request_percpu_irq() and let the standard procfs
>> printout take the wheel.
>
> I wish. Unfortunately, /proc/interrupts is likely to be considered ABI,
> and I'm really worried to change this (see what happened last time we
> tried to update /proc/cpuinfo to be less braindead...).
>

Hmph, it's borderline here I think: we're not introducing a new field or
format in the file, so any tool that can parse /proc/interrupts can parse
the IPIs if they are formatted like the other "regular" interrupts. But
then said tool could die in flames when not seeing the special IPI fields
because sturdiness is overrated :(

Oh well.

>          M.

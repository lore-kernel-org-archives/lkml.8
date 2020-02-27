Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EDC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB39524695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgB0Ktb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:49:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33953 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0Ktb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:49:31 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7GjJ-0007f9-7N; Thu, 27 Feb 2020 11:49:21 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8DC7C10409C; Thu, 27 Feb 2020 11:49:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 14/18] x86: Replace setup_irq() by request_irq()
In-Reply-To: <a3116b3b1a03a943cd89efd57d2db32284c3a574.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com> <a3116b3b1a03a943cd89efd57d2db32284c3a574.1581478324.git.afzal.mohd.ma@gmail.com>
Date:   Thu, 27 Feb 2020 11:49:20 +0100
Message-ID: <87v9nsmhjj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afzal mohammed <afzal.mohd.ma@gmail.com> writes:

> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
>
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
>
> Hence replace setup_irq() by request_irq().
>
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().

Please do not copy the irrelevant parts of your boilerplate text into
individual changelogs. Changelogs should have the information which is
relevant to the patch they describe.

> @@ -104,6 +95,11 @@ void __init native_init_IRQ(void)
>  	idt_setup_apic_and_irq_gates();
>  	lapic_assign_system_vectors();
>  
> -	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs())
> -		setup_irq(2, &irq2);
> +	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
> +		/*
> +		 * IRQ2 is cascade interrupt to second interrupt controller
> +		 */
> +		if (request_irq(2, no_action, IRQF_NO_THREAD, "cascade", NULL))
> +			pr_err("request_irq() on %s failed\n", "cascade");

What's the purpose of the %s indirection here?

Also that error message is not really helpful:

     request_irq() on cascade failed

Something like:

     Failed to request irq 2 (cascade).

Hmm?

> +	}
>  }
> diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
> index d8673d8a779b..0f9cb386d71f 100644
> --- a/arch/x86/kernel/time.c
> +++ b/arch/x86/kernel/time.c
> @@ -62,19 +62,15 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction irq0  = {
> -	.handler = timer_interrupt,
> -	.flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER,
> -	.name = "timer"
> -};
> -
>  static void __init setup_default_timer_irq(void)
>  {
>  	/*
>  	 * Unconditionally register the legacy timer; even without legacy
>  	 * PIC/PIT we need this for the HPET0 in legacy replacement mode.
>  	 */
> -	if (setup_irq(0, &irq0))
> +	if (request_irq(0, timer_interrupt,
> +			IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER, "timer",
> +			NULL))

This is realy ugly.

	unsigned long flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER;

	....
     	if (request_irq(0, timer_interrupt, flags, "timer", NULL))
        	....

takes the same amount of lines, but is readable.

Thanks,

        tglx

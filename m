Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABEC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6FB2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151015;
	bh=vrhYPevSt11z/cQhMR2H+wze7oJ1VbX2mNSDSoxY0I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K2q+glhFZdppsPw75sxYstg7yJ3QN7qi0HNxu2FxgBczSJ+6a8mi3p5lsaiNyrW+w
	 QO9h0WVLQTBZ1aR6oYRovt8ifspA9bVpaYQwWAIhN6+8AiWnN5AnaUwWKRJhlslgin
	 K7hZYe9EN+CDTRkiKZGiaPyomT1hz1dAXwSfy0vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgICQgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgICQgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:36:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31F8620578;
        Thu,  3 Sep 2020 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599151011;
        bh=vrhYPevSt11z/cQhMR2H+wze7oJ1VbX2mNSDSoxY0I4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2ePBIcj4J6W1l9OFj3I6TJHpFk157TRhgtvCd+h3XP8SHKzY4usGEs51A2xaDxQDI
         cGArV6cO+Td7NSU0LA944rOnnIf5hKP3dyLXoIPhDzSC3r3clqfRFxbJGRrbW9YDV1
         4W3k2q0PqUeTOsUf6TMGXhzJ0cyjtUcM3uR7PHdA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDsED-008wYU-Im; Thu, 03 Sep 2020 17:36:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Sep 2020 17:36:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64: smp: Introduce a new IPI as
 IPI_CALL_NMI_FUNC
In-Reply-To: <1599134712-30923-2-git-send-email-sumit.garg@linaro.org>
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
 <1599134712-30923-2-git-send-email-sumit.garg@linaro.org>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <05a195374cc81008e95e258221fe7d2b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 13:05, Sumit Garg wrote:
> Introduce a new inter processor interrupt as IPI_CALL_NMI_FUNC that
> can be invoked to run special handlers in NMI context. One such handler
> example is kgdb_nmicallback() which is invoked in order to round up 
> CPUs
> to enter kgdb context.
> 
> As currently pseudo NMIs are supported on specific arm64 platforms 
> which
> incorporates GICv3 or later version of interrupt controller. In case a
> particular platform doesn't support pseudo NMIs, IPI_CALL_NMI_FUNC will
> act as a normal IPI which can still be used to invoke special handlers.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  arch/arm64/include/asm/smp.h |  1 +
>  arch/arm64/kernel/smp.c      | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/smp.h 
> b/arch/arm64/include/asm/smp.h
> index 2e7f529..e85f5d5 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -89,6 +89,7 @@ extern void secondary_entry(void);
> 
>  extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask 
> *mask);
> +extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask 
> *mask);
> 
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>  extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index b6bde26..1b4c07c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -74,6 +74,7 @@ enum ipi_msg_type {
>  	IPI_TIMER,
>  	IPI_IRQ_WORK,
>  	IPI_WAKEUP,
> +	IPI_CALL_NMI_FUNC,
>  	NR_IPI
>  };
> 
> @@ -793,6 +794,7 @@ static const char *ipi_types[NR_IPI] 
> __tracepoint_string = {
>  	S(IPI_TIMER, "Timer broadcast interrupts"),
>  	S(IPI_IRQ_WORK, "IRQ work interrupts"),
>  	S(IPI_WAKEUP, "CPU wake-up interrupts"),
> +	S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
>  };
> 
>  static void smp_cross_call(const struct cpumask *target, unsigned int 
> ipinr);
> @@ -840,6 +842,11 @@ void arch_irq_work_raise(void)
>  }
>  #endif
> 
> +void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask)
> +{
> +	smp_cross_call(mask, IPI_CALL_NMI_FUNC);
> +}
> +
>  static void local_cpu_stop(void)
>  {
>  	set_cpu_online(smp_processor_id(), false);
> @@ -932,6 +939,10 @@ static void do_handle_IPI(int ipinr)
>  		break;
>  #endif
> 
> +	case IPI_CALL_NMI_FUNC:
> +		/* nop, IPI handlers for special features can be added here. */
> +		break;
> +
>  	default:
>  		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>  		break;

I'm really not keen on adding more IPIs to the SMP code. One of the
main reasons for using these SGIs as normal IRQs was to make them
"requestable" from non-arch code as if they were standard percpu
interrupts.

What prevents you from moving that all the way to the kgdb code?

         M.
-- 
Jazz is not dead. It just smells funny...

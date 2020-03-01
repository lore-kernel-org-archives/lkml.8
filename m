Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA53C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22042468A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtkZRttB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCAQYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:24:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35849 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:24:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id j16so9447850wrt.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g1SEBumqJq81TxO2qvGmu7yktNeKNEfXhG8t+bNaQr8=;
        b=PtkZRttBCR04PMNO5fIPbIptvsEO9UA0BJTA9Nb3zzJ/HnoCIu48mqqoS8XFIH3pJ1
         PWve6+/kKCRXzM6flKzaUlyceejEQVorc7Pj4HpUVahWWAts4dKE9borqiE6Uu6RiBeV
         NnERxRbou1BJfXv8qUpx08uMspd9fSHwDYIqcInSGd2UqcZ7GElcf1raHdSW4Zs2wcHl
         9krnrs9ZHmmMmZQrCeKk2bpXqVtOh0IymcyfMDpSAL9fHY6N3un6GLKEuEtasmtWzzMO
         cDsFmRf4CNdfPd1iTNSADam5vgDSIcHzWW8b5CFzbOz3sn36MpBHM/cx8RK+o7NbKNdK
         oSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1SEBumqJq81TxO2qvGmu7yktNeKNEfXhG8t+bNaQr8=;
        b=lyjLyjJP9epGKyS+V2oy13JndRgK03mdTcbtK99I/bLS9Y/jRN5PRFnr7r33XTFlH6
         6PwHG9Qi6oc0IeWkfev9oiJq5tmir1EzGRC7MBvhxhfIIV+Anr1IAf/GjnAIL1TOo0qc
         Ck1MjefYpi1fwZcSWxF8Y+cne2rmbB5rqQfL2tvwD0jkLq1rce58E1SzVPgihDj5/Kwn
         bgBpTHoEs8NT037g3ArslD049J+Ei4W8VjYIImbq+/qFiLVcFpnUkW5ipHlHQzyhw8Wr
         k+XkJk9kfdYpNX9ee776X4jFjYcUaMV9QHpwdCDyDHKSetR76SHdw1K60u3UC+G9JjqV
         x4pg==
X-Gm-Message-State: APjAAAVIaHPGmUFCJL7fXk1s2K5hZzqlA/6mcfDqNrG4GRjfdO80yZRo
        CAyxUCF/CkfPgBFoPeNfXa4=
X-Google-Smtp-Source: APXvYqxxiXUgX0QTdUl2mT9OwCWm1oSPN8TXXbwNQZdyVZb0SU4Z/z4oweEcgioUI7wOx8Q73UXm5g==
X-Received: by 2002:a5d:526c:: with SMTP id l12mr17906156wrc.117.1583079868088;
        Sun, 01 Mar 2020 08:24:28 -0800 (PST)
Received: from [192.168.1.201] ([62.68.29.211])
        by smtp.gmail.com with ESMTPSA id d15sm19439521wrp.37.2020.03.01.08.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 08:24:27 -0800 (PST)
Subject: Re: [PATCH v3] ARM: ep93xx: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20200301122112.3847-1-afzal.mohd.ma@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <51cebbbb-3ba4-b336-82a9-abcc22f9a69c@gmail.com>
Date:   Sun, 1 Mar 2020 17:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200301122112.3847-1-afzal.mohd.ma@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal, Arnd,

as there is no dedicated tree for EP93xx, could you please
consider the below patch for your arm-soc tree?

On 01/03/2020 13:21, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> Hi sub-arch maintainers,
> 
> If the patch is okay, please take it thr' your tree.
> 
> Regards
> afzal
> 
> v3:
>  * Split out from series, also create subarch level patch as Thomas
> 	suggested to take it thr' respective maintainers
>  * Modify string displayed in case of error as suggested by Thomas
>  * Re-arrange code as required to improve readability
>  * Remove irrelevant parts from commit message & improve
>  
> v2:
>  * Replace pr_err("request_irq() on %s failed" by
>            pr_err("%s: request_irq() failed"
>  * Commit message massage
> 
>  arch/arm/mach-ep93xx/timer-ep93xx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/timer-ep93xx.c
> index de998830f534..dd4b164d1831 100644
> --- a/arch/arm/mach-ep93xx/timer-ep93xx.c
> +++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
> @@ -117,15 +117,11 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction ep93xx_timer_irq = {
> -	.name		= "ep93xx timer",
> -	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> -	.handler	= ep93xx_timer_interrupt,
> -	.dev_id		= &ep93xx_clockevent,
> -};
> -
>  void __init ep93xx_timer_init(void)
>  {
> +	int irq = IRQ_EP93XX_TIMER3;
> +	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
> +
>  	/* Enable and register clocksource and sched_clock on timer 4 */
>  	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
>  	       EP93XX_TIMER4_VALUE_HIGH);
> @@ -136,7 +132,9 @@ void __init ep93xx_timer_init(void)
>  			     EP93XX_TIMER4_RATE);
>  
>  	/* Set up clockevent on timer 3 */
> -	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
> +	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
> +			&ep93xx_clockevent))
> +		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
>  	clockevents_config_and_register(&ep93xx_clockevent,
>  					EP93XX_TIMER123_RATE,
>  					1,
> 

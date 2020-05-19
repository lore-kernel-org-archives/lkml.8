Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899DE206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOy40ns3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgESTrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:47:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13414C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:47:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p30so295799pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZGuRRRcbTaW8FWPggeFKscV8bVAevR+TD4KidxOAffU=;
        b=SOy40ns36oc3zn7ljfpnUaBI+qiGaKfHLn/p2KvVh6KGCqg988xKzHeav8r4ADi+al
         JMlzcpyMm2iAV0qQjdoFwlstcvzlPkZz7a4Ed62ly991kPw9qR3soQzvxgRHMXy11Mkt
         T5bOiSqk0MEI2lITGszqvjSMp1pDCIvfAIWSMd/2KiQMiZUszZh7AKf51496oMFhqDE8
         el2E+G1EIlVrf1LUymCs1SMnRoV299YkVmgi+QiZS6fTpG46AoJ0ipU0OuY9YEIWHOUM
         z5+t0fv/T0hrhw0bs82HPobojLUycNl7mP/2RPVf0aGmaeCzOEorMevm0S9AxXHdqhCa
         iCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGuRRRcbTaW8FWPggeFKscV8bVAevR+TD4KidxOAffU=;
        b=YFrnd6acgH1pS7bY+YvQ5BbEWGIV/VN1y4XnmlWgZEdAV5K8js9E979NWU32BiHvnH
         BlJJYMNG2UULZcnBtu0CK1r01iEO9DzmeDAy2BharmREqBW82GAp+plafcHu2mWWjbZ2
         rDe4ghOtLpi2/XBDm0BgJR+QmXfK3YDloYENCmj0PZj+GuvR0DJZDX27GiWNHlOlZqpI
         zmwZxglIrkNC86gElmBfgUv8OljcFHj1ocL1JtSwpsEu+6/RDb2X+XKEnxqjc30kCQq7
         hbTmTK30WqnQo6hK2R4LezabYPbb/e+IH3P1c4auH5ARa9NPeFz0/U2m0rpLAaOR1XyQ
         /UhA==
X-Gm-Message-State: AOAM530pPiF3mO+FiCcfZTZzViUZVdCBlf2UbbqcdOSrO6VudhJk52/7
        aHyqHGPFM7RMc5gy/bNtzQQ=
X-Google-Smtp-Source: ABdhPJxGFs2gbJfJf03BO6VSSxo3ZeuxRoEcyfB/gfuOvP36kzgTf0L+EcK96MQIwQyh25HevsllAA==
X-Received: by 2002:a63:3e46:: with SMTP id l67mr761106pga.430.1589917651467;
        Tue, 19 May 2020 12:47:31 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e18sm251091pfh.75.2020.05.19.12.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:47:30 -0700 (PDT)
Subject: Re: [PATCH 01/11] genirq: Add fasteoi IPI flow
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200519161755.209565-1-maz@kernel.org>
 <20200519161755.209565-2-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b691a46e-7461-89c8-c760-a1ef9769091f@gmail.com>
Date:   Tue, 19 May 2020 12:47:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519161755.209565-2-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2020 9:17 AM, Marc Zyngier wrote:
> For irqchips using the fasteoi flow, IPIs are a bit special.
> 
> They need to be EOId early (before calling the handler), as
> funny things may happen in the handler (they do not necessarily
> behave like a normal interrupt), and that the arch code is
> already handling the stats.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/irq.h |  1 +
>  kernel/irq/chip.c   | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 8d5bc2c237d7..726f94d8b8cc 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -621,6 +621,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
>   */
>  extern void handle_level_irq(struct irq_desc *desc);
>  extern void handle_fasteoi_irq(struct irq_desc *desc);
> +extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
>  extern void handle_edge_irq(struct irq_desc *desc);
>  extern void handle_edge_eoi_irq(struct irq_desc *desc);
>  extern void handle_simple_irq(struct irq_desc *desc);
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 41e7e37a0928..7b0b789cfed4 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -955,6 +955,32 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
>  		chip->irq_eoi(&desc->irq_data);
>  }
>  
> +/**
> + * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
> + *				     dev ids
> + * @desc:	the interrupt description structure for this irq
> + *
> + * The biggest differences with the IRQ version are that:
> + * - the interrupt is EOIed early, as the IPI could result in a context
> + *   switch, and we need to make sure the IPI can fire again
> + * - Stats are usually handled at the architecture level, so we ignore them
> + *   here
> + */
> +void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct irqaction *action = desc->action;
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	irqreturn_t res;

Should not this have a:

	if (!irq_settings_is_no_accounting(desc))
		__kstat_incr_irqs_this_cpu(desc);

here in case you are using that handler with a SGI interrupt which is
not used as an IPI?

> +
> +	if (chip->irq_eoi)
> +		chip->irq_eoi(&desc->irq_data);
> +
> +	trace_irq_handler_entry(irq, action);
> +	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
> +	trace_irq_handler_exit(irq, action, res);
> +}
> +
>  /**
>   * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
>   *				     dev ids
> 

-- 
Florian

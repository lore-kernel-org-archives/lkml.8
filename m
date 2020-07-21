Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38929C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192312073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3PTt388"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgGULCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGULCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:02:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79514C0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:02:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so2438887wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPqRjmeULxuLVoEjy9aA3UQhI9sTfnd10elbtAQrDro=;
        b=q3PTt388dGTnzDpVwzvX6J60ZQKkYn/bYlCxdn54F6eINTC2t/AidA+9Em79HiEZRt
         lavrMoQiz13W5VNdzEGkAZDZOy4WCxvC2LGYETtYQrLBrSesCPem+2KnQZNDvq9REXRL
         oOrUs7OF4A3Yr9oKdXRBigpkeKEb46CLGy2q+phezgBG+EEhywNBZqsa1oFPDlVszg8e
         iPeyiyu4ytWfy6HBiQU+IIjba9r0/2MaZ1ShQUSedgi+eIHyTVeXGn5Hc+bg+mM7MwYq
         EWe02FiTsvsrcAgW9M2u4viKWhX+d0dp4COZjIhCwTvTxY++9dLalWkh0XmV95/70I/Q
         b9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPqRjmeULxuLVoEjy9aA3UQhI9sTfnd10elbtAQrDro=;
        b=nPOoA1BWHXIS50tIv2pXcUokmRVGrrn5j1xeJDBy+Rskstr95U/yqXectPjocu778L
         JjE+1c1UZRi+vudvIHks+qfHB3LpDJgiNrXzjBJIRPhjW5FaXoQvw99VJbtlQ4eiSDY/
         3sF0WGX+L7iKjmNSvYeaiPrIBAyNoPdhg6z6N4QUXjuyOt8MFvo4si2hJKDRQjxGk7Oo
         g/28HJk34LKqi2CzxVysJzowZfvRXiKRuWFv/hU+WVG5yynuyPh+o8xNPkz7Gn79jlyS
         agC869MAZFTD21e2GHZGP8t786edwIoxNWh/4kTHdNdbabMqGbghZUEd7POqUlbKCli4
         tJeg==
X-Gm-Message-State: AOAM530K5rI6QYgX/QJYyIhzGuOpmKhnlaAl2sO9KT+njG0pqFmnPy3r
        E9MA3JsMILNcG52a6Zf66BL6AQ==
X-Google-Smtp-Source: ABdhPJw4oqzUpsLRaO3E4F0cyKC6CtdtVtcGI3tpABklcSHKMh0/ZWva0LboU9nfH9I2yu3x4fbG/A==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr3481693wmj.5.1595329366936;
        Tue, 21 Jul 2020 04:02:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3590:b402:869a:11fc? ([2a01:e34:ed2f:f020:3590:b402:869a:11fc])
        by smtp.googlemail.com with ESMTPSA id d14sm4547519wre.44.2020.07.21.04.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 04:02:46 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] clocksource/drivers: Add CLINT timer driver
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Emil Renner Berhing <kernel@esmil.dk>
References: <20200717075101.263332-1-anup.patel@wdc.com>
 <20200717075101.263332-3-anup.patel@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <63f65ddd-b7c4-b8fd-151c-a77e8c87efed@linaro.org>
Date:   Tue, 21 Jul 2020 13:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717075101.263332-3-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2020 09:50, Anup Patel wrote:
> We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
> RISC-V NoMMU kernel).
> 
> The CLINT MMIO device provides three things:
> 1. 64bit free running counter register
> 2. 64bit per-CPU time compare registers
> 3. 32bit per-CPU inter-processor interrupt registers
> 
> Unlike other timer devices, CLINT provides IPI registers along with
> timer registers. To use CLINT IPI registers, the CLINT timer driver
> provides IPI related callbacks to arch/riscv.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> ---
>  drivers/clocksource/Kconfig       |   9 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/timer-clint.c | 231 ++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h        |   1 +
>  4 files changed, 242 insertions(+)
>  create mode 100644 drivers/clocksource/timer-clint.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 91418381fcd4..e1ce0d510a03 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -658,6 +658,15 @@ config RISCV_TIMER
>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>  	  required for all RISC-V systems.
>  
> +config CLINT_TIMER
> +	bool "Timer for the RISC-V platform"
> +	depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> +	select TIMER_PROBE
> +	select TIMER_OF
> +	help
> +	  This option enables the CLINT timer for RISC-V systems. The CLINT
> +	  driver is usually used for NoMMU RISC-V systems.

V3 has a comment about fixing the Kconfig option.

[ ... ]

> +{
> +	bool *registered = per_cpu_ptr(&clint_clock_event_registered, cpu);
> +	struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
> +
> +	if (!(*registered)) {
> +		ce->cpumask = cpumask_of(cpu);
> +		clockevents_config_and_register(ce, clint_timer_freq, 200,
> +						 ULONG_MAX);
> +		*registered = true;
> +	}


I was unsure about the clockevents_config_and_register() multiple calls
when doing the comment. It seems like it is fine to call it several
times and that is done in several places like riscv or arch_arm_timer.

It is probably safe to drop the 'registered' code here, sorry for the
confusion.

> +	enable_percpu_irq(clint_timer_irq,
> +			  irq_get_trigger_type(clint_timer_irq));
> +	return 0;
> +}
> +

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39812C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09877218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgBMLCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:02:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgBMLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:02:11 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2CFW-0007Yp-CI; Thu, 13 Feb 2020 12:01:38 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 068BB1013A6; Thu, 13 Feb 2020 12:01:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>, Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v8 10/11] irqchip/sifive-plic: Initialize the plic handler when cpu comes online
In-Reply-To: <20200212014822.28684-11-atish.patra@wdc.com>
Date:   Thu, 13 Feb 2020 12:01:37 +0100
Message-ID: <87ftfe3g4u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> writes:
  
> +static void plic_handler_init(struct plic_handler *handler, u32 threshold)
> +{
> +	irq_hw_number_t hwirq;
> +
> +	/* priority must be > threshold to trigger an interrupt */
> +	writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
> +	for (hwirq = 1; hwirq < plic_irqdomain->hwirq_max; hwirq++)
> +		plic_toggle(handler, hwirq, 0);
> +}

> +
> +static int plic_starting_cpu(unsigned int cpu)
> +{
> +	u32 threshold = 0;

Pointless variable. Also you use PLIC_DISABLE_THRESHOLD down below, so
please add a proper define for enable as well.

> +	struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);

        this_cpu_ptr*&...)

The callback is guaranteed to run on the plugged in CPU.

> -			threshold = 0xffffffff;
> +			plic_handler_init(handler, PLIC_DISABLE_THRESHOLD);

Thanks,

        tglx

Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF007C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8131206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591004763;
	bh=u5k9lXSIba8wSgRxEYAEP5/ce82Baj9jWYygqw4RKcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AMH3vDB6FHYWGFM2IN9CtxSWiV6AbmeA0mjjtsU/0tUwnDz+/XXggSlV28n763cA5
	 kEWtQV36N2eMsErlNXTBX0qrkzlY/ec8Yz/TDig44eKVdKLaIZm4OS10zp9faSUdbW
	 4Nl6mfG1bhQQflWEGkXsPbWAAmTeWeOrLdDLVkDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFAJqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgFAJqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:46:02 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006152076B;
        Mon,  1 Jun 2020 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591004762;
        bh=u5k9lXSIba8wSgRxEYAEP5/ce82Baj9jWYygqw4RKcA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D3l20ti3+KyXZfguuMCKwgu0uGFohKllgeRxtBcoquifsNHypyDgGcP4HFXSOFjNf
         hgk1qGfoTzGbcC6N1kORua7kukfOCAYBCYcKKc6DolCmop+Cb1vqun7JD9sfnaczwg
         UfNcGJ/5ZPdxb+u/c1CFfoBI+gVZ5L+17QlpWVkk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jfh16-00GrqL-JE; Mon, 01 Jun 2020 10:46:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Jun 2020 10:46:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/6] clocksource/drivers/timer-riscv: Use per-CPU timer
 interrupt
In-Reply-To: <20200601091543.943678-5-anup.patel@wdc.com>
References: <20200601091543.943678-1-anup.patel@wdc.com>
 <20200601091543.943678-5-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <a20434e7c380e77e8323c11cff863f0c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 10:15, Anup Patel wrote:
> Instead of directly calling RISC-V timer interrupt handler from
> RISC-V local interrupt conntroller driver, this patch implements
> RISC-V timer interrupt as a per-CPU interrupt using per-CPU APIs
> of Linux IRQ subsystem.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/irq.h      |  2 --
>  drivers/clocksource/timer-riscv.c | 43 ++++++++++++++++++++++++++++---
>  drivers/irqchip/irq-riscv-intc.c  |  8 ------
>  3 files changed, 40 insertions(+), 13 deletions(-)

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...

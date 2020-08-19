Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB45C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E9C20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597825462;
	bh=hqtEFkUN69QVjr3/Q+VSJ3eubz0fOJkAGxBLb/UISFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PI0xU3Q96Q95q5Wwg4PHh4bFgAgHFYGx3iR0jMQFrpYfLiT4b2HuCcp3ZiccZQojH
	 YfsOSfQOnvnnxfVsfmn7Pxr3cxjjJxvWu/WoSUko9AcFb8a3sOmZfAJT0TbDmUj8QE
	 jvn7/cSU0tByNLRIEP5Ini9Z5o7vBkubAqVrDBO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHSIYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSIYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:24:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9E020738;
        Wed, 19 Aug 2020 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597825456;
        bh=hqtEFkUN69QVjr3/Q+VSJ3eubz0fOJkAGxBLb/UISFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v8Li5VZM6pbWFqrL4c4lY4Otq46S49G+uQHfS/VZIWFPjnQRvYPPqz9CuAYLCRkir
         voE/FVRQ633Wq0i/NiVbIrR2qBXsVm28tp2sj6N0eWgRSn3wY/YuadwyP7CbV/W2H1
         5xthfxV4DNJ4b5z5lBPUldYLf7H1dpdn2USr0h64=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k8JOJ-0048iI-13; Wed, 19 Aug 2020 09:24:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 09:24:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     qiuguorui1 <qiuguorui1@huawei.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, zengweilin@huawei.com,
        chenjianguo3@huawei.com
Subject: Re: [PATCH] irqchip/stm32-exti: avoid interrupts losing due to
 clearing pending bit by mistake
In-Reply-To: <20200819023931.28997-1-qiuguorui1@huawei.com>
References: <20200819023931.28997-1-qiuguorui1@huawei.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <df090a1b5884cad8196067b975447cba@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qiuguorui1@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, zengweilin@huawei.com, chenjianguo3@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 03:39, qiuguorui1 wrote:
> In the previous code, when the eoi handle of the exti clears the 
> pending
> bit of the current interrupt, it will first read the values of fpr and
> rpr, then logically OR the corresponding bit of the interrupt number,
> and finally write back to fpr and rpr.
> 
> We found through experiments that if two exti interrupts,
> we call them int1/int2, arrive almost at the same time. in our 
> scenario,
> the time difference is 30 microseconds, assuming int1 is triggered 
> first.
> 
> there will be an extreme scenario: both int's pending bit are set to 1,
> the irq handle of int1 is executed first, and eoi handle is then 
> executed,
> at this moment, all pending bits are cleared, but the int 2 has not
> finally been reported to the cpu yet, which eventually lost int2.
> 
> According to stm32's TRM description about rpr and fpr: Writing a 1 to 
> this
> bit will trigger a rising edge event on event x, Writing 0 has no
> effect.
> 
> Therefore, when clearing the pending bit, we only need to clear the
> pending bit of the irq.

Interesting findings!

> 
> Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>

This definitely needs a Fixes: tag and a Cc: stable, as lost
interrupts are not fun at all.

> ---
>  drivers/irqchip/irq-stm32-exti.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c 
> b/drivers/irqchip/irq-stm32-exti.c
> index 03a36be757d8..ee4faf5c90b8 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -26,6 +26,11 @@
> 
>  #define HWSPNLCK_TIMEOUT	1000 /* usec */
> 
> +enum reg_ops {
> +	REG_WRITE_ONLY,
> +	REG_READ_WRITE
> +};
> +
>  struct stm32_exti_bank {
>  	u32 imr_ofst;
>  	u32 emr_ofst;
> @@ -416,13 +421,14 @@ static void stm32_irq_ack(struct irq_data *d)
>  	irq_gc_unlock(gc);
>  }
> 
> -static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
> +static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg,
> enum reg_ops op)
>  {
>  	struct stm32_exti_chip_data *chip_data = 
> irq_data_get_irq_chip_data(d);
>  	void __iomem *base = chip_data->host_data->base;
> -	u32 val;
> +	u32 val = 0;
> 
> -	val = readl_relaxed(base + reg);
> +	if (op == REG_READ_WRITE)
> +		val = readl_relaxed(base + reg);
>  	val |= BIT(d->hwirq % IRQS_PER_BANK);
>  	writel_relaxed(val, base + reg);
> 
> @@ -449,9 +455,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)
> 
>  	raw_spin_lock(&chip_data->rlock);
> 
> -	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
> +	stm32_exti_set_bit(d, stm32_bank->rpr_ofst, REG_WRITE_ONLY);
>  	if (stm32_bank->fpr_ofst != UNDEF_REG)
> -		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
> +		stm32_exti_set_bit(d, stm32_bank->fpr_ofst, REG_WRITE_ONLY);
> 
>  	raw_spin_unlock(&chip_data->rlock);
> 
> @@ -478,7 +484,7 @@ static void stm32_exti_h_unmask(struct irq_data *d)
>  	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
> 
>  	raw_spin_lock(&chip_data->rlock);
> -	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
> +	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst,
> REG_READ_WRITE);
>  	raw_spin_unlock(&chip_data->rlock);
> 
>  	if (d->parent_data->chip)

I think this could be made much simpler by simply providing
an accessor that doesn't do a RMW. Something like this (untested):

diff --git a/drivers/irqchip/irq-stm32-exti.c 
b/drivers/irqchip/irq-stm32-exti.c
index 03a36be757d8..e35c5561a10d 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -416,6 +416,14 @@ static void stm32_irq_ack(struct irq_data *d)
  	irq_gc_unlock(gc);
  }

+static void stm32_exti_write_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = 
irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+
+	writel_relaxed(BIT(d->hwirq % IRQS_PER_BANK), base + reg);
+}
+
  static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
  {
  	struct stm32_exti_chip_data *chip_data = 
irq_data_get_irq_chip_data(d);
@@ -449,9 +457,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)

  	raw_spin_lock(&chip_data->rlock);

-	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
  	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);

  	raw_spin_unlock(&chip_data->rlock);

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

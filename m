Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D93C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42497206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHSMqy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:46:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3069 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbgHSMqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:46:06 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id B9E2EF04E3E9F5AFE1FB;
        Wed, 19 Aug 2020 20:46:02 +0800 (CST)
Received: from DGGEML505-MBX.china.huawei.com ([169.254.12.146]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0487.000; Wed, 19 Aug 2020 20:45:54 +0800
From:   qiuguorui <qiuguorui1@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ludovic.barre@st.com" <ludovic.barre@st.com>,
        Zengweilin <zengweilin@huawei.com>,
        chenjianguo <chenjianguo3@huawei.com>
Subject: Re: [PATCH] irqchip/stm32-exti: avoid interrupts losing due to
 clearing pending bit by mistake
Thread-Topic: [PATCH] irqchip/stm32-exti: avoid interrupts losing due to
 clearing pending bit by mistake
Thread-Index: AdZ2DMaF/HB72ziASqawGY+By7fWQg==
Date:   Wed, 19 Aug 2020 12:45:53 +0000
Message-ID: <85F0D3A887C4C146A2824A628E698AE51FFAC5E2@dggeml505-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.103.69]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 16:24, Marc Zyngier wrote:
>On 2020-08-19 03:39, qiuguorui1 wrote:
>> In the previous code, when the eoi handle of the exti clears the 
>> pending bit of the current interrupt, it will first read the values of 
>> fpr and rpr, then logically OR the corresponding bit of the interrupt 
>> number, and finally write back to fpr and rpr.
>> 
>> We found through experiments that if two exti interrupts, we call them 
>> int1/int2, arrive almost at the same time. in our scenario, the time 
>> difference is 30 microseconds, assuming int1 is triggered first.
>> 
>> there will be an extreme scenario: both int's pending bit are set to 
>> 1, the irq handle of int1 is executed first, and eoi handle is then 
>> executed, at this moment, all pending bits are cleared, but the int 2 
>> has not finally been reported to the cpu yet, which eventually lost 
>> int2.
>> 
>> According to stm32's TRM description about rpr and fpr: Writing a 1 to 
>> this bit will trigger a rising edge event on event x, Writing 0 has no 
>> effect.
>> 
>> Therefore, when clearing the pending bit, we only need to clear the 
>> pending bit of the irq.
>
>Interesting findings!
Thanks!
>
>> 
>> Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
>
>This definitely needs a Fixes: tag and a Cc: stable, as lost interrupts are not fun at all.
OK.I will do this in the 2nd version of patch.
>
>> ---
>>  drivers/irqchip/irq-stm32-exti.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-stm32-exti.c
>> b/drivers/irqchip/irq-stm32-exti.c
>> index 03a36be757d8..ee4faf5c90b8 100644
>> --- a/drivers/irqchip/irq-stm32-exti.c
>> +++ b/drivers/irqchip/irq-stm32-exti.c
>> @@ -26,6 +26,11 @@
>> 
>>  #define HWSPNLCK_TIMEOUT	1000 /* usec */
>> 
>> +enum reg_ops {
>> +	REG_WRITE_ONLY,
>> +	REG_READ_WRITE
>> +};
>> +
>>  struct stm32_exti_bank {
>>  	u32 imr_ofst;
>>  	u32 emr_ofst;
>> @@ -416,13 +421,14 @@ static void stm32_irq_ack(struct irq_data *d)
>>  	irq_gc_unlock(gc);
>>  }
>> 
>> -static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
>> +static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg,
>> enum reg_ops op)
>>  {
>>  	struct stm32_exti_chip_data *chip_data = 
>> irq_data_get_irq_chip_data(d);
>>  	void __iomem *base = chip_data->host_data->base;
>> -	u32 val;
>> +	u32 val = 0;
>> 
>> -	val = readl_relaxed(base + reg);
>> +	if (op == REG_READ_WRITE)
>> +		val = readl_relaxed(base + reg);
>>  	val |= BIT(d->hwirq % IRQS_PER_BANK);
>>  	writel_relaxed(val, base + reg);
>> 
>> @@ -449,9 +455,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)
>> 
>>  	raw_spin_lock(&chip_data->rlock);
>> 
>> -	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
>> +	stm32_exti_set_bit(d, stm32_bank->rpr_ofst, REG_WRITE_ONLY);
>>  	if (stm32_bank->fpr_ofst != UNDEF_REG)
>> -		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
>> +		stm32_exti_set_bit(d, stm32_bank->fpr_ofst, REG_WRITE_ONLY);
>> 
>>  	raw_spin_unlock(&chip_data->rlock);
>> 
>> @@ -478,7 +484,7 @@ static void stm32_exti_h_unmask(struct irq_data *d)
>>  	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
>> 
>>  	raw_spin_lock(&chip_data->rlock);
>> -	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
>> +	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst,
>> REG_READ_WRITE);
>>  	raw_spin_unlock(&chip_data->rlock);
>> 
>>  	if (d->parent_data->chip)
>
>I think this could be made much simpler by simply providing an accessor that doesn't do a RMW. Something like this (untested):
Thanks for your advice! I will optimize in the 2nd version of patch.
>
>diff --git a/drivers/irqchip/irq-stm32-exti.c
>b/drivers/irqchip/irq-stm32-exti.c
>index 03a36be757d8..e35c5561a10d 100644
>--- a/drivers/irqchip/irq-stm32-exti.c
>+++ b/drivers/irqchip/irq-stm32-exti.c
>@@ -416,6 +416,14 @@ static void stm32_irq_ack(struct irq_data *d)
>  	irq_gc_unlock(gc);
>  }
>
>+static void stm32_exti_write_bit(struct irq_data *d, u32 reg) {
>+	struct stm32_exti_chip_data *chip_data =
>irq_data_get_irq_chip_data(d);
>+	void __iomem *base = chip_data->host_data->base;
>+
>+	writel_relaxed(BIT(d->hwirq % IRQS_PER_BANK), base + reg); }
>+
>  static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
>  {
>  	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d); @@ -449,9 +457,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)
>
>  	raw_spin_lock(&chip_data->rlock);
>
>-	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
>+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
>  	if (stm32_bank->fpr_ofst != UNDEF_REG)
>-		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
>+		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
>
>  	raw_spin_unlock(&chip_data->rlock);
>
>Thanks,
>
>         M.
>--
>Jazz is not dead. It just smells funny...
>

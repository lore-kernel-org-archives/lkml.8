Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E713C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25897207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgGAJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:23:39 -0400
Received: from mail.loongson.cn ([114.242.206.163]:58090 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728776AbgGAJXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:23:39 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72oSVvxebJ5NAA--.6442S3;
        Wed, 01 Jul 2020 17:23:30 +0800 (CST)
Subject: Re: [PATCH v4 03/14] irqchip/csky-mpintc: Fix potential resource
 leaks
To:     Markus Elfring <Markus.Elfring@web.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-4-git-send-email-yangtiezhu@loongson.cn>
 <35eae701-e6b1-96af-9be4-0993330a17dc@web.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6a468fb4-74b0-4bf3-49bc-cfc62d734e24@loongson.cn>
Date:   Wed, 1 Jul 2020 17:23:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <35eae701-e6b1-96af-9be4-0993330a17dc@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx72oSVvxebJ5NAA--.6442S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1ftryDXF4DAr4DtF43KFg_yoW3trb_u3
        45CrWkWa18JFn5AF4Svw4Yqa4vgr4UWw13tFW3Aws7J3s8X3yDZrWxA343ta47tFyjvFsx
        Ga17XrW2qrnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xU4nNVDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 03:49 PM, Markus Elfring wrote:
>> exception handling. By the way, do some coding-style cleanups
> I propose to consider another bit of fine-tuning.
>
>
> …
>> +++ b/drivers/irqchip/irq-csky-mpintc.c
> …
>> @@ -270,12 +274,24 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
>>
>>   #ifdef CONFIG_SMP
>>   	ipi_irq = irq_create_mapping(root_domain, IPI_IRQ);
>> -	if (!ipi_irq)
>> -		return -EIO;
>> +	if (!ipi_irq) {
>> +		ret = -EIO;
>> +		goto err_domain_remove;
> How do you think about to use the following source code variant
> at this place?
>
> +		irq_domain_remove(root_domain);
> +		ret = -EIO;
> +		goto err_iounmap;
>
>
> Would you like to avoid the repetition of the check “#ifdef CONFIG_SMP”?

OK, thank you, it looks good to me, I will do it in v5.

>
> Regards,
> Markus


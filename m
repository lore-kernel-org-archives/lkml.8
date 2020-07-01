Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED79C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A0120747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgGAJfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:35:44 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33250 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbgGAJfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:35:43 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx72nnWPxeqKBNAA--.1635S3;
        Wed, 01 Jul 2020 17:35:36 +0800 (CST)
Subject: Re: [PATCH v4 02/14] irqchip/csky-apb-intc: Fix potential resource
 leaks
To:     Markus Elfring <Markus.Elfring@web.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-3-git-send-email-yangtiezhu@loongson.cn>
 <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1a0e007a-db94-501b-4ab9-0bb479ec093b@loongson.cn>
Date:   Wed, 1 Jul 2020 17:35:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <564ffff9-6043-7191-2458-f425dd8d0c11@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx72nnWPxeqKBNAA--.1635S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1DGr4DWw1UArWkGryfJFb_yoW8Cw15pF
        WUXrZI9rZ7t3W7Wrn7ZF97X3s8u347KFZFy34Skas7Zrn8Crn8CrW8AFnYvFn8Cw1xWa1F
        vFs5Aa4rCa15AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x07jriSQUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 04:40 PM, Markus Elfring wrote:
>> … were not released in a few error cases. …
> Another small wording adjustment:
>    … in two error cases. …

OK

>
>
> …
>> +++ b/drivers/irqchip/irq-csky-apb-intc.c
> …
>> @@ -126,10 +127,17 @@ ck_intc_init_comm(struct device_node *node, struct device_node *parent)
> …
>> +err_iounmap:
>> +	iounmap(reg_base);
>> +	return ret;
>>   }
> …
>
> How do you think about to use the statement “return -ENOMEM;”?

OK

> Can the local variable “ret” be omitted in this function implementation?

If remove the local variable "ret",  it will look like this:

diff --git a/drivers/irqchip/irq-csky-apb-intc.c 
b/drivers/irqchip/irq-csky-apb-intc.c
index 5a2ec43..7e56657 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -101,8 +101,6 @@ static inline void setup_irq_channel(u32 magic, void 
__iomem *reg_addr)
  static int __init
  ck_intc_init_comm(struct device_node *node, struct device_node *parent)
  {
-       int ret;
-
         if (parent) {
                 pr_err("C-SKY Intc not a root irq controller\n");
                 return -EINVAL;
@@ -118,18 +116,23 @@ ck_intc_init_comm(struct device_node *node, struct 
device_node *parent)
&irq_generic_chip_ops, NULL);
         if (!root_domain) {
                 pr_err("C-SKY Intc irq_domain_add failed.\n");
-               return -ENOMEM;
+               goto err_iounmap;
         }

-       ret = irq_alloc_domain_generic_chips(root_domain, 32, 1,
+       if (irq_alloc_domain_generic_chips(root_domain, 32, 1,
                         "csky_intc", handle_level_irq,
-                       IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0, 0);
-       if (ret) {
+                       IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0, 0)) {
                 pr_err("C-SKY Intc irq_alloc_gc failed.\n");
-               return -ENOMEM;
+               goto err_domain_remove;
         }

         return 0;
+
+err_domain_remove:
+       irq_domain_remove(root_domain);
+err_iounmap:
+       iounmap(reg_base);
+       return -ENOMEM;
  }

>
> Regards,
> Markus


Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88380C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F532207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 03:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgF1DXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 23:23:25 -0400
Received: from mail.loongson.cn ([114.242.206.163]:42902 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgF1DXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 23:23:24 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf98gDfheXHFLAA--.1485S3;
        Sun, 28 Jun 2020 11:23:12 +0800 (CST)
Subject: Re: [PATCH v3 04/14] irqchip/davinci-aintc: Fix potential resource
 leaks
To:     Markus Elfring <Markus.Elfring@web.de>, linux-mips@vger.kernel.org
References: <0e39761c-4673-d116-fc62-5573c2abae06@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e98e609b-1074-c57c-3b17-6fb635474762@loongson.cn>
Date:   Sun, 28 Jun 2020 11:23:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <0e39761c-4673-d116-fc62-5573c2abae06@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxf98gDfheXHFLAA--.1485S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw1kKr1kWF4fCrWrtw15twb_yoWfurX_Wr
        17Grn7Jw1UJr15GayFyrWfXas3C3y7Xa17X345XFWSgry7J39xA397Kry3Gr10gr17Ar1U
        CFZxZFZ8Zr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUj5l1PUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/2020 09:12 PM, Markus Elfring wrote:
>> There exists potential resource leaks in the error path, fix them.
> Would you like to reconsider this change description?
> https://lore.kernel.org/linux-mips/be3acb13-2963-ddf1-a867-7e30fd23a0b4@loongson.cn/
> https://lkml.org/lkml/2020/6/24/498
>
>
> …
>> +++ b/drivers/irqchip/irq-davinci-aintc.c
> …
>> @@ -160,4 +160,13 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
>>   				       irq_base + irq_off, 32);
>>
>>   	set_handle_irq(davinci_aintc_handle_irq);
>> +
>> +err_domain_remove:
> …
>
> Are you sure that you would to like to release the allocated system resources
> always in this function implementation?
>
> Otherwise, I suggest to add a return statement before the source code section
> for the desired exception handling.

Thank you! Sorry for the late reply.
I will add a return statement.

>
> Regards,
> Markus


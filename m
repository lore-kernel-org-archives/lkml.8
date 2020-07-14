Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ECC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C56D2192A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGNBkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:40:08 -0400
Received: from mail.loongson.cn ([114.242.206.163]:38956 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgGNBkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:40:07 -0400
Received: from [10.130.0.75] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cx4NboDA1fQxoEAA--.515S3;
        Tue, 14 Jul 2020 09:39:53 +0800 (CST)
Subject: Re: [PATCH v3 8/8] dt-bindings: interrupt-controller: Fix typos in
 loongson,liointc.yaml
To:     Rob Herring <robh@kernel.org>
References: <1594087972-21715-1-git-send-email-yangtiezhu@loongson.cn>
 <1594087972-21715-9-git-send-email-yangtiezhu@loongson.cn>
 <20200713214126.GA774746@bogus>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <142a1e77-d5aa-40d1-6083-1f438a426b7b@loongson.cn>
Date:   Tue, 14 Jul 2020 09:39:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200713214126.GA774746@bogus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Cx4NboDA1fQxoEAA--.515S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1UuFWfKF1kKF1kuF47twb_yoW8CrW5pF
        WkCa1DKF4jqr13Ca9Fq3WvkF13Zrs8ArnxGFsYyrW8JFZFgw18Xr4a9Fn5J3Z8Kr4xJFWj
        qryFgay09a4UAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxU2znmDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/14/2020 05:41 AM, Rob Herring wrote:
> On Tue, Jul 07, 2020 at 10:12:52AM +0800, Tiezhu Yang wrote:
>> Fix the following two typos in loongson,liointc.yaml:
>> fron -> from
>> connected -> connect
>> it's -> its
>>
>> Fixes: b6280c8bb6f5 ("dt-bindings: interrupt-controller: Add Loongson LIOINTC")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> ---
>>   .../devicetree/bindings/interrupt-controller/loongson,liointc.yaml    | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>> index b1db21e..732ad9a 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
>> @@ -51,8 +51,8 @@ properties:
>>       description: |
>>         This property points how the children interrupts will be mapped into CPU
>>         interrupt lines. Each cell refers to a parent interrupt line from 0 to 3
>> -      and each bit in the cell refers to a children interrupt fron 0 to 31.
>> -      If a CPU interrupt line didn't connected with liointc, then keep it's
>> +      and each bit in the cell refers to a children interrupt from 0 to 31.
> While at it, s/children/child/

Hi,

Since the other patches of this series have no changes and they belong to
different subsystem which are independent, could I only send v4 of this
patch separately?

Thanks,
Tiezhu

>
>> +      If a CPU interrupt line didn't connect with liointc, then keep its
>>         cell with zero.
>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>       minItems: 4
>> -- 
>> 2.1.0
>>


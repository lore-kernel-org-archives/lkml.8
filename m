Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D8DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BE820786
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgIBEFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:05:05 -0400
Received: from mail.loongson.cn ([114.242.206.163]:52274 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbgIBEFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:05:05 -0400
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT92iGE9fsg8QAA--.593S3;
        Wed, 02 Sep 2020 11:59:31 +0800 (CST)
Subject: Re: [PATCH v5 00/14] irqchip: Fix potential resource leaks
To:     Marc Zyngier <maz@kernel.org>
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
 <ab1cd9280c7892a0230945ef5ff0880c@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <02e077df-7c4e-24a7-1640-5f17894bd252@loongson.cn>
Date:   Wed, 2 Sep 2020 11:59:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <ab1cd9280c7892a0230945ef5ff0880c@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxT92iGE9fsg8QAA--.593S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry7CFWxJw45JFyDGw4DArb_yoWkJFc_GF
        Wqvrn7G34UtrnrAan2gFn8XanFgrn2gw1rJryrXa17tr1fZw15WrWqvrWIkw1rtrW0qFZx
        Gr4jqF47trn2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIAYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxU4fMaUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2020 03:30 PM, Marc Zyngier wrote:
> On 2020-07-06 02:19, Tiezhu Yang wrote:
>> When I test the irqchip code of Loongson, I read the related code of 
>> other
>> chips in drivers/irqchip and I find some potential resource leaks in the
>> error path, I think it is better to fix them.
>>
>> v2:
>>   - Split the first patch into a new patch series which
>>     includes small patches and add "Fixes" tag
>>   - Use "goto" label to handle error path in some patches
>>
>> v3:
>>   - Add missed variable "ret" in the patch #5 and #13
>>
>> v4:
>>   - Modify the commit message of each patch suggested by Markus Elfring
>>   - Make "irq_domain_remove(root_domain)" under CONFIG_SMP in patch #3
>>   - Add a return statement before goto label in patch #4
>>
>> v5:
>>   - Modify the commit messages and do some code cleanups
>
> Please stop replying to Markus Elfring, and give people who actually
> care a chance to review this code. Elfring will keep asking you to make
> absolutely pointless changes until you are blue in the face

Hi Marc,

Any comments?
Could you please apply this patch series?

Thanks,
Tiezhu

>
>
> Thanks,
>
>         M.


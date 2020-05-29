Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95C420707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbgE2ECT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:02:19 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55640 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388127AbgE2ECP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:02:15 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx32k9idBeRpA6AA--.1622S3;
        Fri, 29 May 2020 12:02:06 +0800 (CST)
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about
 hisi_reset_init()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
 <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com>
 <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn>
 <159070775347.69627.5841986835404441281@swboyd.mtv.corp.google.com>
 <be070b91-4954-c66c-970c-a64f72eb54dc@loongson.cn>
 <159072469537.69627.2358538167030427315@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0936ce03-935d-d863-0bd1-a005ba1d40e0@loongson.cn>
Date:   Fri, 29 May 2020 12:02:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <159072469537.69627.2358538167030427315@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx32k9idBeRpA6AA--.1622S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rJw13Jw4xZFWkCw4xCrg_yoW8tr17pr
        18GFWYkr4Uur17X3y2vr4rA342vFyxKr1UXr18tws7Awn8Krs7Jr4rK3W5urZ5urW7Ga45
        Jr48KFWSvayDAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUj0eHDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2020 11:58 AM, Stephen Boyd wrote:
> Quoting Tiezhu Yang (2020-05-28 19:03:54)
>> On 05/29/2020 07:15 AM, Stephen Boyd wrote:
>>> Quoting Tiezhu Yang (2020-05-27 19:27:42)
>>>> On 05/28/2020 03:06 AM, Stephen Boyd wrote:
>>>>> Quoting Tiezhu Yang (2020-05-27 07:39:21)
>>>>>> The return value about hisi_reset_init() is not correct, fix it.
>>>>>>
>>>>>> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer dereference")
>>>>> hisi_reset_init() returns NULL on error in that commit. This patch
>>>>> doesn't make sense.
>>>> Hi Stephen,
>>>>
>>>> The initial aim of this patch is to use correct return value about
>>>> hisi_reset_init(), maybe NULL is OK, but the return value in this
>>>> patch is more accurate.
>>> The implementation of hisi_reset_init() that I see is this:
>>>
>>>
>>>        struct hisi_reset_controller *rstc;
>>>
>>>        rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
>>>        if (!rstc)
>>>                return NULL;
>>>
>>>        rstc->membase = devm_platform_ioremap_resource(pdev, 0);
>>>        if (IS_ERR(rstc->membase))
>>>                return NULL;
>>>
>>>        spin_lock_init(&rstc->lock);
>>>        rstc->rcdev.owner = THIS_MODULE;
>>>        rstc->rcdev.ops = &hisi_reset_ops;
>>>        rstc->rcdev.of_node = pdev->dev.of_node;
>>>        rstc->rcdev.of_reset_n_cells = 2;
>>>        rstc->rcdev.of_xlate = hisi_reset_of_xlate;
>>>        reset_controller_register(&rstc->rcdev);
>>>
>>>        return rstc;
>>>
>>> And that returns NULL on an error and a valid pointer on success.
>>> Changing the code to check the return value of hisi_reset_init() for an
>>> error pointer is simply wrong without updating hisi_reset_init() to
>>> return an error pointer on error. Where is the patch that changes
>>> hisi_reset_init() to return an error pointer?
>> Hi Stephen,
>>
>> Do you mean the following changes?
> Yes where is this change?

ERR_PTR(-ENOMEM) and ERR_CAST(rstc->membase)


  	rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
  	if (!rstc)
- return NULL;
+ return ERR_PTR(-ENOMEM);
  
  	rstc->membase = devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(rstc->membase))
- return NULL;
+ return ERR_CAST(rstc->membase);




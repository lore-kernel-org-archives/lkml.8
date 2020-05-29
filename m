Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604142072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 06:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE2Go1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 02:44:27 -0400
Received: from mail.loongson.cn ([114.242.206.163]:54912 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgE2Go1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 02:44:27 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxXetEr9BeYp86AA--.6S3;
        Fri, 29 May 2020 14:44:21 +0800 (CST)
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
 <0936ce03-935d-d863-0bd1-a005ba1d40e0@loongson.cn>
 <159072670557.69627.15526584762592289463@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8e60fafd-724a-c4ef-b0a0-53e092ad6bdc@loongson.cn>
Date:   Fri, 29 May 2020 14:44:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <159072670557.69627.15526584762592289463@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxXetEr9BeYp86AA--.6S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DtryrCF1kur45JryDGFg_yoW5Ww48pr
        1xGayYyF4Uur17JF42vr4rAryjvF1fKF1UXr18Kws7Awn8KFs7Jr4rKr1UuFZ8ur4xG3W5
        Jr40kFWfua4DAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUzpBfUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2020 12:31 PM, Stephen Boyd wrote:
> Quoting Tiezhu Yang (2020-05-28 21:02:05)
>> On 05/29/2020 11:58 AM, Stephen Boyd wrote:
>>> Quoting Tiezhu Yang (2020-05-28 19:03:54)
>>>> On 05/29/2020 07:15 AM, Stephen Boyd wrote:
>>>>> Quoting Tiezhu Yang (2020-05-27 19:27:42)
>>>>>> On 05/28/2020 03:06 AM, Stephen Boyd wrote:
>>>>>>> Quoting Tiezhu Yang (2020-05-27 07:39:21)
>>>>>>>> The return value about hisi_reset_init() is not correct, fix it.
>>>>>>>>
>>>>>>>> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer dereference")
>>>>>>> hisi_reset_init() returns NULL on error in that commit. This patch
>>>>>>> doesn't make sense.
>>>>>> Hi Stephen,
>>>>>>
>>>>>> The initial aim of this patch is to use correct return value about
>>>>>> hisi_reset_init(), maybe NULL is OK, but the return value in this
>>>>>> patch is more accurate.
>>>>> The implementation of hisi_reset_init() that I see is this:
>>>>>
>>>>>
>>>>>         struct hisi_reset_controller *rstc;
>>>>>
>>>>>         rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
>>>>>         if (!rstc)
>>>>>                 return NULL;
>>>>>
>>>>>         rstc->membase = devm_platform_ioremap_resource(pdev, 0);
>>>>>         if (IS_ERR(rstc->membase))
>>>>>                 return NULL;
>>>>>
>>>>>         spin_lock_init(&rstc->lock);
>>>>>         rstc->rcdev.owner = THIS_MODULE;
>>>>>         rstc->rcdev.ops = &hisi_reset_ops;
>>>>>         rstc->rcdev.of_node = pdev->dev.of_node;
>>>>>         rstc->rcdev.of_reset_n_cells = 2;
>>>>>         rstc->rcdev.of_xlate = hisi_reset_of_xlate;
>>>>>         reset_controller_register(&rstc->rcdev);
>>>>>
>>>>>         return rstc;
>>>>>
>>>>> And that returns NULL on an error and a valid pointer on success.
>>>>> Changing the code to check the return value of hisi_reset_init() for an
>>>>> error pointer is simply wrong without updating hisi_reset_init() to
>>>>> return an error pointer on error. Where is the patch that changes
>>>>> hisi_reset_init() to return an error pointer?
>>>> Hi Stephen,
>>>>
>>>> Do you mean the following changes?
>>> Yes where is this change?
>> ERR_PTR(-ENOMEM) and ERR_CAST(rstc->membase)
>>
> I think you didn't understand my question. I'm asking where is this
> patch applied to the kernel and what commit is it? I don't see it in the
> clk tree.

Sorry for that, actually I do not quite understand what you mean.

In my opinion, after the following commit,  when devm_ioremap_resource()
is called in hisi_reset_init(), hisi_reset_init() still returns NULL and 
it only returns
-ENOMEM when call hisi_reset_init() failed, I think it may returns 
-EINVAL, -EBUSY
or -ENOMEM if failed, this is what I want to fix.

"reset: hisilicon: fix potential NULL pointer dereference"
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/drivers/clk/hisilicon/reset.c?h=clk-next&id=e9a2310fb689151166df7fd9971093362d34bd79



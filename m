Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEB8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0101A206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgE2KUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:20:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:40296 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE2KUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:20:21 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx32rb4dBe67U6AA--.122S3;
        Fri, 29 May 2020 18:20:12 +0800 (CST)
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
 <8e60fafd-724a-c4ef-b0a0-53e092ad6bdc@loongson.cn>
 <159074496638.69627.15702116074645440806@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f11b46d7-0d94-b4b3-350a-19e5a98d5289@loongson.cn>
Date:   Fri, 29 May 2020 18:20:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <159074496638.69627.15702116074645440806@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx32rb4dBe67U6AA--.122S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45Kw15uw45WFy8Xr1rXrb_yoW8XrWUpr
        WxGayYgrs8Ar17AFsxZa10kFy5ZFn3Gay5Cw18Cwn3Cr15WFW8Xr4SgFWI9F98urZ3Ga15
        tF4rKFyUua4qyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjhL0UUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2020 05:36 PM, Stephen Boyd wrote:
> Quoting Tiezhu Yang (2020-05-28 23:44:20)
>> On 05/29/2020 12:31 PM, Stephen Boyd wrote:
>>> Quoting Tiezhu Yang (2020-05-28 21:02:05)
>>> I think you didn't understand my question. I'm asking where is this
>>> patch applied to the kernel and what commit is it? I don't see it in the
>>> clk tree.
>> Sorry for that, actually I do not quite understand what you mean.
>>
>> In my opinion, after the following commit,  when devm_ioremap_resource()
>> is called in hisi_reset_init(), hisi_reset_init() still returns NULL and
>> it only returns
>> -ENOMEM when call hisi_reset_init() failed, I think it may returns
>> -EINVAL, -EBUSY
>> or -ENOMEM if failed, this is what I want to fix.
>>
>> "reset: hisilicon: fix potential NULL pointer dereference"
>> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/drivers/clk/hisilicon/reset.c?h=clk-next&id=e9a2310fb689151166df7fd9971093362d34bd79
>>
> This commit doesn't change the value that is returned by
> hisi_reset_init() on an error. It still returns NULL when an error
> happens.

Yes, I agree, but after this commit e9a2310fb689 ("reset:
hisilicon: fix potential NULL pointer dereference"), the
return value of hisi_reset_init() is not so correct because
it replaces devm_ioremap() with devm_ioremap_resource().

Do you think the code of this patch is OK but the "Fixes:" commit
is not accurate? If so, can we remove the "Fixes:" tag?


Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F144C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D902084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgE1C1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:27:53 -0400
Received: from mail.loongson.cn ([114.242.206.163]:56000 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgE1C1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:27:53 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn96eIc9elfE5AA--.1049S3;
        Thu, 28 May 2020 10:27:44 +0800 (CST)
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about
 hisi_reset_init()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
 <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn>
Date:   Thu, 28 May 2020 10:27:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn96eIc9elfE5AA--.1049S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr47Gw43Aw1xGF4rAF18Xwb_yoW8ArWxpr
        WxGFWS9r4Fqr17XrsxJa18CFs0v3Wfta1Yyry8Awn3Aan8JrWUAr4UGFy09FyrCFWUK3W5
        tr4FkryrAayDJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUgVyxUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2020 03:06 AM, Stephen Boyd wrote:
> Quoting Tiezhu Yang (2020-05-27 07:39:21)
>> The return value about hisi_reset_init() is not correct, fix it.
>>
>> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer dereference")
> hisi_reset_init() returns NULL on error in that commit. This patch
> doesn't make sense.

Hi Stephen,

The initial aim of this patch is to use correct return value about
hisi_reset_init(), maybe NULL is OK, but the return value in this
patch is more accurate.

In the current code, it always returns -ENOMEM when call function
hisi_reset_init() failed which is not proper, because in the function
hisi_reset_init(), devm_platform_ioremap_resource() may returns -EINVAL,
-EBUSY or -ENOMEM if failed.

devm_platform_ioremap_resource()
         devm_ioremap_resource()
                 __devm_ioremap_resource()


static void __iomem *
__devm_ioremap_resource(struct device *dev, const struct resource *res,
             enum devm_ioremap_type type)
{
     resource_size_t size;
     void __iomem *dest_ptr;

     BUG_ON(!dev);

     if (!res || resource_type(res) != IORESOURCE_MEM) {
         dev_err(dev, "invalid resource\n");
         return IOMEM_ERR_PTR(-EINVAL);
     }

     size = resource_size(res);

     if (!devm_request_mem_region(dev, res->start, size, dev_name(dev))) {
         dev_err(dev, "can't request region for resource %pR\n", res);
         return IOMEM_ERR_PTR(-EBUSY);
     }

     dest_ptr = __devm_ioremap(dev, res->start, size, type);
     if (!dest_ptr) {
         dev_err(dev, "ioremap failed for resource %pR\n", res);
         devm_release_mem_region(dev, res->start, size);
         dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
     }

     return dest_ptr;
}

Thanks,
Tiezhu Yang

>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>


Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B7CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39122075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404738AbgE2CEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:04:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60268 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390805AbgE2CD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:03:58 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP2iKbdBeCYM6AA--.1603S3;
        Fri, 29 May 2020 10:03:55 +0800 (CST)
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about
 hisi_reset_init()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn>
 <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com>
 <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn>
 <159070775347.69627.5841986835404441281@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <be070b91-4954-c66c-970c-a64f72eb54dc@loongson.cn>
Date:   Fri, 29 May 2020 10:03:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <159070775347.69627.5841986835404441281@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxP2iKbdBeCYM6AA--.1603S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw48WFy5Aw18ArWUtr47urg_yoW5GFyUpr
        1xGayakr4F9r17X3y7AF45Aa43ZF1fKw4UJr1rXws3Aw15GrWkAr4rKa48urZ5urW7Gay5
        tr4SkF4rZayqyaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xF
        o4CEbIxvr21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfU0GYLUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2020 07:15 AM, Stephen Boyd wrote:
> Quoting Tiezhu Yang (2020-05-27 19:27:42)
>> On 05/28/2020 03:06 AM, Stephen Boyd wrote:
>>> Quoting Tiezhu Yang (2020-05-27 07:39:21)
>>>> The return value about hisi_reset_init() is not correct, fix it.
>>>>
>>>> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer dereference")
>>> hisi_reset_init() returns NULL on error in that commit. This patch
>>> doesn't make sense.
>> Hi Stephen,
>>
>> The initial aim of this patch is to use correct return value about
>> hisi_reset_init(), maybe NULL is OK, but the return value in this
>> patch is more accurate.
> The implementation of hisi_reset_init() that I see is this:
>
>
> 	struct hisi_reset_controller *rstc;
>
> 	rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
> 	if (!rstc)
> 		return NULL;
>
> 	rstc->membase = devm_platform_ioremap_resource(pdev, 0);
> 	if (IS_ERR(rstc->membase))
> 		return NULL;
>
> 	spin_lock_init(&rstc->lock);
> 	rstc->rcdev.owner = THIS_MODULE;
> 	rstc->rcdev.ops = &hisi_reset_ops;
> 	rstc->rcdev.of_node = pdev->dev.of_node;
> 	rstc->rcdev.of_reset_n_cells = 2;
> 	rstc->rcdev.of_xlate = hisi_reset_of_xlate;
> 	reset_controller_register(&rstc->rcdev);
>
> 	return rstc;
>
> And that returns NULL on an error and a valid pointer on success.
> Changing the code to check the return value of hisi_reset_init() for an
> error pointer is simply wrong without updating hisi_reset_init() to
> return an error pointer on error. Where is the patch that changes
> hisi_reset_init() to return an error pointer?

Hi Stephen,

Do you mean the following changes?

diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17..c733e2e 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -93,11 +93,11 @@  struct hisi_reset_controller *hisi_reset_init(struct platform_device *pdev)
  
  	rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
  	if (!rstc)
- return NULL;
+ return ERR_PTR(-ENOMEM);
  
  	rstc->membase = devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(rstc->membase))
- return NULL;
+ return ERR_CAST(rstc->membase);
  
  	spin_lock_init(&rstc->lock);
  	rstc->rcdev.owner = THIS_MODULE;


devm_platform_ioremap_resource()
          devm_ioremap_resource()
                  __devm_ioremap_resource()

By the way, we can see the comment of devm_ioremap_resource():

Usage example:

          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
          base = devm_ioremap_resource(&pdev->dev, res);
          if (IS_ERR(base))
                  return PTR_ERR(base);



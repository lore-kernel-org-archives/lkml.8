Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1128E20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgE0CtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:49:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46070 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbgE0CtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:49:24 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD2oq1c1ernk5AA--.481S3;
        Wed, 27 May 2020 10:49:15 +0800 (CST)
Subject: Re: [PATCH 1/2] clk: hisilicon: Use correct return value about
 hisi_reset_init()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <1590377516-32117-1-git-send-email-yangtiezhu@loongson.cn>
 <159053414719.88029.3577704206897582789@swboyd.mtv.corp.google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3cf9f657-8471-43e2-0bf2-0cf86d85e284@loongson.cn>
Date:   Wed, 27 May 2020 10:49:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <159053414719.88029.3577704206897582789@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxD2oq1c1ernk5AA--.481S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5Kw47Xw1kKw1kGw13CFg_yoW8GrW8pr
        48JFWayFy5JrW7JFnrXr4Yyry5Z3W2gFW8KrWkZ3s8Zrn8GFyUAr1xu348Aa48Jr4fKF4F
        9F48Cr4ruayqyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfU5vtCUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/2020 07:02 AM, Stephen Boyd wrote:
> Quoting Tiezhu Yang (2020-05-24 20:31:55)
>> The return value about hisi_reset_init() is not correct, fix it.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/clk/hisilicon/clk-hi3519.c      | 4 ++--
>>   drivers/clk/hisilicon/crg-hi3516cv300.c | 4 ++--
>>   drivers/clk/hisilicon/crg-hi3798cv200.c | 4 ++--
>>   drivers/clk/hisilicon/reset.c           | 4 ++--
>>   4 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
>> index ad0c7f3..803fa66 100644
>> --- a/drivers/clk/hisilicon/clk-hi3519.c
>> +++ b/drivers/clk/hisilicon/clk-hi3519.c
>> @@ -149,8 +149,8 @@ static int hi3519_clk_probe(struct platform_device *pdev)
>>                  return -ENOMEM;
>>   
>>          crg->rstc = hisi_reset_init(pdev);
>> -       if (!crg->rstc)
>> -               return -ENOMEM;
>> +       if (IS_ERR(crg->rstc))
>> +               return PTR_ERR(crg->rstc);
>>   
>>          crg->clk_data = hi3519_clk_register(pdev);
>>          if (IS_ERR(crg->clk_data)) {
> The code I see is returning NULL or a valid pointer from
> hisi_reset_init(). Can you add a "Fixes" tag to this patch so we can
> figure out which patch changed the behavior and where this patch needs
> to be backported to?

OK, I will check the git log to add a Fixes tag and then send v2.

Thanks,
Tiezhu Yang



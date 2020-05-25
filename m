Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD667C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE3F2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbgEYMfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:35:33 -0400
Received: from mail.loongson.cn ([114.242.206.163]:51048 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390504AbgEYMfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:35:32 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx32qFu8teZuk4AA--.634S3;
        Mon, 25 May 2020 20:35:18 +0800 (CST)
Subject: Re: [PATCH 2/2] phy: Remove CONFIG_ARCH_ROCKCHIP check for subdir
 rockchip
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1590379739-18729-1-git-send-email-yangtiezhu@loongson.cn>
 <1590379739-18729-2-git-send-email-yangtiezhu@loongson.cn>
 <2687194.6AVWON70EC@diego>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bf02bc5c-84e8-d699-e0fe-8bcf1bbd1030@loongson.cn>
Date:   Mon, 25 May 2020 20:35:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2687194.6AVWON70EC@diego>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx32qFu8teZuk4AA--.634S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4fGF1UuF4xtrW3Xr1DZFb_yoW8WryDpw
        s5trWUCF95XF4jkFy2va98uFZ5tws3trWvgrW3X3W5XF98GrW3W3ZIgrWUXF4xXr4UArWx
        K3Z3Ga43uF15Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1fgA7
        UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2020 06:48 PM, Heiko Stübner wrote:
> Am Montag, 25. Mai 2020, 06:08:59 CEST schrieb Tiezhu Yang:
>> If CONFIG_ARCH_ROCKCHIP is not set but COMPILE_TEST is set, the file in
>> the subdir rockchip can not be built due to CONFIG_ARCH_ROCKCHIP check
>> in drivers/phy/Makefile.
>>
>> Since the related configs in drivers/phy/rockchip/Kconfig depend on
>> ARCH_ROCKCHIP, so remove CONFIG_ARCH_ROCKCHIP check for subdir rockchip
>> in drivers/phy/Makefile.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> wouldn't this make more sense to do for all subdirs?
>
> - allwinner: also has arch_sunxi || compile_test in its Kconfig
> - amlogic: same
> - mediatek: same
> - renesas: same
> - tega: same
>
> So I think the right way would be to drop all the obj-$(CONFIG_ARCH_...)
> options and group the separate directories into the generic subdir
> listing below them.

Hi Heiko,

Thanks for your suggestions. I will check it and then send v2.

Thanks,
Tiezhu Yang

>
> Heiko
>
>> ---
>>   drivers/phy/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index 310c149..e5b4f58 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -12,7 +12,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
>>   obj-$(CONFIG_ARCH_MESON)		+= amlogic/
>>   obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
>>   obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
>> -obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
>> +obj-y					+= rockchip/
>>   obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
>>   obj-y					+= broadcom/	\
>>   					   cadence/	\
>>
>
>


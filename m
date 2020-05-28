Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34ACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925F4208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgE1CNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:13:36 -0400
Received: from out28-5.mail.aliyun.com ([115.124.28.5]:35673 "EHLO
        out28-5.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1CNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:13:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0747892|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0187187-0.000297441-0.980984;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.HecKNKN_1590632008;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HecKNKN_1590632008)
          by smtp.aliyun-inc.com(10.147.44.145);
          Thu, 28 May 2020 10:13:29 +0800
Subject: Re: [PATCH v12 7/7] clk: X1000: Add FIXDIV for SSI clock of X1000.
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
 <20200527175635.5558-8-zhouyanjie@wanyeetech.com>
 <159062837338.69627.14365746093599072888@swboyd.mtv.corp.google.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <5e0f2920-b503-d1c1-26d9-fc3fcf7394ba@wanyeetech.com>
Date:   Thu, 28 May 2020 10:13:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <159062837338.69627.14365746093599072888@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

在 2020/5/28 上午9:12, Stephen Boyd 写道:
> Quoting Zhou Yanjie (2020-05-27 10:56:35)
>> @@ -40,8 +43,47 @@
>>   #define OPCR_SPENDN0           BIT(7)
>>   #define OPCR_SPENDN1           BIT(6)
>>   
>> +/* bits within the USBPCR register */
>> +#define USBPCR_SIDDQ           BIT(21)
>> +#define USBPCR_OTG_DISABLE     BIT(20)
>> +
>>   static struct ingenic_cgu *cgu;
>>   
>> +static int x1000_usb_phy_enable(struct clk_hw *hw)
>> +{
>> +       void __iomem *reg_opcr          = cgu->base + CGU_REG_OPCR;
>> +       void __iomem *reg_usbpcr        = cgu->base + CGU_REG_USBPCR;
>> +
>> +       writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
> Please include linux/io.h for writel/readl.


Sure, I'll add it.


>> +       writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, reg_usbpcr);
>> +       return 0;
>> +}
>> +
>> +static void x1000_usb_phy_disable(struct clk_hw *hw)
>> +{
>> +       void __iomem *reg_opcr          = cgu->base + CGU_REG_OPCR;
>> +       void __iomem *reg_usbpcr        = cgu->base + CGU_REG_USBPCR;
>> +
>> +       writel(readl(reg_opcr) & ~OPCR_SPENDN0, reg_opcr);
>> +       writel(readl(reg_usbpcr) | USBPCR_OTG_DISABLE | USBPCR_SIDDQ, reg_usbpcr);
>> +}
>> +
>> +static int x1000_usb_phy_is_enabled(struct clk_hw *hw)
>> +{
>> +       void __iomem *reg_opcr          = cgu->base + CGU_REG_OPCR;
>> +       void __iomem *reg_usbpcr        = cgu->base + CGU_REG_USBPCR;
>> +
>> +       return (readl(reg_opcr) & OPCR_SPENDN0) &&
>> +               !(readl(reg_usbpcr) & USBPCR_SIDDQ) &&
>> +               !(readl(reg_usbpcr) & USBPCR_OTG_DISABLE);
>> +}
>> +
>> +static const struct clk_ops x1000_otg_phy_ops = {
>> +       .enable         = x1000_usb_phy_enable,
>> +       .disable        = x1000_usb_phy_disable,
>> +       .is_enabled     = x1000_usb_phy_is_enabled,
>> +};
>> +
>>   static const s8 pll_od_encoding[8] = {
>>          0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
>>   };
>> @@ -277,4 +377,4 @@ static void __init x1000_cgu_init(struct device_node *np)
>>   
>>          ingenic_cgu_register_syscore_ops(cgu);
>>   }
>> -CLK_OF_DECLARE(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);
>> +CLK_OF_DECLARE_DRIVER(x1000_cgu, "ingenic,x1000-cgu", x1000_cgu_init);
> Why does this change to DECLARE_DRIVER? Can you please add a comment
> here in the code indicating what other driver is probing this compatible
> string?


Yes, CGU has some children devices, this is useful for probing children 
devices in the case where the device node is compatible with 
"simple-mfd" (see commit 03d570e1a4dc for a reference).

Thanks and best regards!



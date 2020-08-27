Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D532FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A31B2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc5nsMjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH0OFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgH0Nqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:46:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31614C061264;
        Thu, 27 Aug 2020 06:46:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so3550021pfd.1;
        Thu, 27 Aug 2020 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=trl3ejZxIzsH2m05TMvOHIC113SXT6U//VHjhE8HmPo=;
        b=Nc5nsMjj64/EXzj68L6FYaIJN7o6oh65oemNpKbD/M0QhWT/joMtIEIsqcZ2Do67kn
         mqalmaTFng3effWg1XKkvg/tg4guRRsZ54wcN8ZtTUKL0YiLn4P2rkzOY2VW85ZqgmN4
         VEQuNnlmY4Cb3v+PvCk5IPlasLTfx6+8zWl7WSex1ZUM0OQ6eh5M1vXmaicDY3fcZru9
         ogUz5JO1y7vKmkGVYSPuJFJH8USGY4/UXDF6+g41zkicsAjjA322HeQ+wL0uCjR043Cp
         zWC/Y5KeTPRkfguUtbFnYFbVaA8O51eBDFArc8owWwhWEGUfhOWCrOiicbWHipZKIc3Z
         4yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=trl3ejZxIzsH2m05TMvOHIC113SXT6U//VHjhE8HmPo=;
        b=TJ16M0s0ZuBmzNdY4Qjy3xcsYcB0zh/xtosk2/2SCALKWaUqSNthvBCkNRWVt8bO3R
         qJOjtN1WXKQPasqbf+YAPlov0N/xlJjUKz5vlrhfVTHa0tgmVrIw7mXg1RLHIBV/XkwS
         TL/YIbVag3JJLxu5z8D+5asA9ipkee+QkdB3jHxMj36foLzOLN9OPZ4DsUu60+Ue/VEg
         n00coKDRGgQlh4WKRx8So1pKMrtGV6MXau8XJCcjVg7a0wTIPnGu5paDfkCCNeJkGU2g
         VmlFrlZE6ZVfnnOUml5px1A13UBhUBhbSiYO7kCJsx1ErBWZ3Qhi+7D/HC8Vuht9u6n8
         Sk/Q==
X-Gm-Message-State: AOAM532pHSv3tvHoEjjjdvjbscef+VcOXZ5JmUZoghcGyMsVIFk6aqVp
        ce4HYvltehhtJp7AVJZVJuJL3Hm9Mxw=
X-Google-Smtp-Source: ABdhPJxCpbfi2oMwHOJOE83v9J/BClUJcy3jXIiZgQeyNRJQgh2MrmwExBYvsQ+NCrky0WjpOi96Uw==
X-Received: by 2002:a17:902:8f82:: with SMTP id z2mr1834609plo.177.1598536006820;
        Thu, 27 Aug 2020 06:46:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z1sm3031165pff.178.2020.08.27.06.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:46:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] usb typec: mt6360: Add support for mt6360 Type-C
 driver
To:     =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1598503859-29620-1-git-send-email-u0084500@gmail.com>
 <1598515415.21253.22.camel@mhfsdcap03>
 <CADiBU3_CpOVTWM7JO78=DGw5J_dYNVUK=eH8ywQiMk2Gtk5Bsw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <283c9452-996d-d1ce-90a0-28fbd55c291d@roeck-us.net>
Date:   Thu, 27 Aug 2020 06:46:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADiBU3_CpOVTWM7JO78=DGw5J_dYNVUK=eH8ywQiMk2Gtk5Bsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 4:32 AM, 啟原黃 wrote:
> Chunfeng Yun <chunfeng.yun@mediatek.com> 於 2020年8月27日 週四 下午4:05寫道：
>>
>> On Thu, 2020-08-27 at 12:50 +0800, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
>>> It works with Type-C Port Controller Manager to provide USB PD
>>> and USB Type-C functionalities.
>>>
>>> Add fix to Prevent the race condition from interrupt and tcpci port unregister
>>> during module remove.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  drivers/usb/typec/tcpm/Kconfig        |   8 ++
>>>  drivers/usb/typec/tcpm/Makefile       |   1 +
>>>  drivers/usb/typec/tcpm/tcpci_mt6360.c | 213 ++++++++++++++++++++++++++++++++++
>> Can you avoid using special SoC name in file name?
>> It's not clear if you later support new SoC in the driver, e.g. mt63xx?
> Okay, I will rename it to mt636x. From our SubPMIC generation,
> currently, naming will be 6360/62/67, etc..

What if 6361 or 6365 or 6369 will require a different driver ?
What if 6371 will, in the future, be supported by the same driver ?
Or, for that matter, 7360 ? 6537 ?

We usually try to avoid "x" in driver names because it can never be
guaranteed that it will apply to x={0..9}. The current file name is
just fine; it is customary to name drivers after the first chip they
support.

Guenter

>>From our SOC roadmap, one generation can be used for one to two more years.
> I think the name MT636x is enough.
> For the next one, I can submit the patch to make it compatible with this driver.
> Thanks for you comment.
>>
>>>  3 files changed, 222 insertions(+)
>>>  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
>>>
>>> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
>>> index fa3f393..58a64e1 100644
>>> --- a/drivers/usb/typec/tcpm/Kconfig
>>> +++ b/drivers/usb/typec/tcpm/Kconfig
>>> @@ -27,6 +27,14 @@ config TYPEC_RT1711H
>>>         Type-C Port Controller Manager to provide USB PD and USB
>>>         Type-C functionalities.
>>>
>>> +config TYPEC_MT6360
>>> +     tristate "Mediatek MT6360 Type-C driver"
>>> +     depends on MFD_MT6360
>>> +     help
>>> +       Mediatek MT6360 is a multi-functional IC that includes
>>> +       USB Type-C. It works with Type-C Port Controller Manager
>>> +       to provide USB PD and USB Type-C functionalities.
>>> +
>>>  endif # TYPEC_TCPCI
>>>
>>>  config TYPEC_FUSB302
>>> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
>>> index a5ff6c8..7592ccb 100644
>>> --- a/drivers/usb/typec/tcpm/Makefile
>>> +++ b/drivers/usb/typec/tcpm/Makefile
>>> @@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_WCOVE)     += typec_wcove.o
>>>  typec_wcove-y                        := wcove.o
>>>  obj-$(CONFIG_TYPEC_TCPCI)    += tcpci.o
>>>  obj-$(CONFIG_TYPEC_RT1711H)  += tcpci_rt1711h.o
>>> +obj-$(CONFIG_TYPEC_MT6360)   += tcpci_mt6360.o
>>> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
>>> new file mode 100644
>>> index 00000000..a381b5d
>>> --- /dev/null
>>> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
>>> @@ -0,0 +1,213 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +//
>>> +// Copyright (C) 2020 MediaTek Inc.
>>> +//
>>> +// Author: ChiYuan Huang <cy_huang@richtek.com>
>> Use /* */ except SPDX?
> Yes, sure.
>>
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/usb/tcpm.h>
>>> +
>>> +#include "tcpci.h"
>>> +
>>> +#define MT6360_REG_VCONNCTRL1        0x8C
>>> +#define MT6360_REG_MODECTRL2 0x8F
>>> +#define MT6360_REG_SWRESET   0xA0
>>> +#define MT6360_REG_DEBCTRL1  0xA1
>>> +#define MT6360_REG_DRPCTRL1  0xA2
>>> +#define MT6360_REG_DRPCTRL2  0xA3
>>> +#define MT6360_REG_I2CTORST  0xBF
>>> +#define MT6360_REG_RXCTRL2   0xCF
>>> +#define MT6360_REG_CTDCTRL2  0xEC
>>> +
>>> +/* MT6360_REG_VCONNCTRL1 */
>>> +#define MT6360_VCONNCL_ENABLE        BIT(0)
>>> +/* MT6360_REG_RXCTRL2 */
>>> +#define MT6360_OPEN40M_ENABLE        BIT(7)
>>> +/* MT6360_REG_CTDCTRL2 */
>>> +#define MT6360_RPONESHOT_ENABLE      BIT(6)
>>> +
>>> +struct mt6360_tcpc_info {
>>> +     struct tcpci_data tdata;
>>> +     struct tcpci *tcpci;
>>> +     struct device *dev;
>>> +     int irq;
>>> +};
>>> +
>>> +static inline int mt6360_tcpc_read16(struct regmap *regmap,
>>> +                                  unsigned int reg, u16 *val)
>>> +{
>>> +     return regmap_raw_read(regmap, reg, val, sizeof(u16));
>>> +}
>>> +
>>> +static inline int mt6360_tcpc_write16(struct regmap *regmap,
>>> +                                   unsigned int reg, u16 val)
>>> +{
>>> +     return regmap_raw_write(regmap, reg, &val, sizeof(u16));
>>> +}
>>> +
>>> +static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>>> +{
>>> +     struct regmap *regmap = tdata->regmap;
>>> +     int ret;
>>> +
>>> +     ret = regmap_write(regmap, MT6360_REG_SWRESET, 0x01);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* after reset command, wait 1~2ms to wait IC action */
>>> +     usleep_range(1000, 2000);
>>> +
>>> +     /* write all alert to masked */
>>> +     ret = mt6360_tcpc_write16(regmap, TCPC_ALERT_MASK, 0);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* config I2C timeout reset enable , and timeout to 200ms */
>>> +     ret = regmap_write(regmap, MT6360_REG_I2CTORST, 0x8F);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* config CC Detect Debounce : 26.7*val us */
>>> +     ret = regmap_write(regmap, MT6360_REG_DEBCTRL1, 0x10);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* DRP Toggle Cycle : 51.2 + 6.4*val ms */
>>> +     ret = regmap_write(regmap, MT6360_REG_DRPCTRL1, 4);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* DRP Duyt Ctrl : dcSRC: /1024 */
>>> +     ret = mt6360_tcpc_write16(regmap, MT6360_REG_DRPCTRL2, 330);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Enable VCONN Current Limit function */
>>> +     ret = regmap_update_bits(regmap, MT6360_REG_VCONNCTRL1, MT6360_VCONNCL_ENABLE,
>>> +                              MT6360_VCONNCL_ENABLE);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Enable cc open 40ms when pmic send vsysuv signal */
>>> +     ret = regmap_update_bits(regmap, MT6360_REG_RXCTRL2, MT6360_OPEN40M_ENABLE,
>>> +                              MT6360_OPEN40M_ENABLE);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Enable Rpdet oneshot detection */
>>> +     ret = regmap_update_bits(regmap, MT6360_REG_CTDCTRL2, MT6360_RPONESHOT_ENABLE,
>>> +                              MT6360_RPONESHOT_ENABLE);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Set shipping mode off, AUTOIDLE on */
>>> +     return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
>>> +}
>>> +
>>> +static irqreturn_t mt6360_irq(int irq, void *dev_id)
>>> +{
>>> +     struct mt6360_tcpc_info *mti = dev_id;
>>> +
>>> +     return tcpci_irq(mti->tcpci);
>>> +}
>>> +
>>> +static int mt6360_tcpc_probe(struct platform_device *pdev)
>>> +{
>>> +     struct mt6360_tcpc_info *mti;
>>> +     int ret;
>>> +
>>> +     mti = devm_kzalloc(&pdev->dev, sizeof(*mti), GFP_KERNEL);
>>> +     if (!mti)
>>> +             return -ENOMEM;
>>> +
>>> +     mti->dev = &pdev->dev;
>>> +
>>> +     mti->tdata.regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>> +     if (!mti->tdata.regmap) {
>>> +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
>>> +             return -ENODEV;
>>> +     }
>>> +
>>> +     mti->irq = platform_get_irq_byname(pdev, "PD_IRQB");
>>> +     if (mti->irq < 0) {
>>> +             dev_err(&pdev->dev, "Failed to get PD_IRQB irq\n");
>> No need add error log, platform_get_irq_byname will print it
> I'll remove it in the next revision. Thanks
>>
>>> +             return mti->irq;
>>> +     }
>>> +
>>> +     mti->tdata.init = mt6360_tcpc_init;
>>> +     mti->tcpci = tcpci_register_port(&pdev->dev, &mti->tdata);
>>> +     if (IS_ERR_OR_NULL(mti->tcpci)) {
>> Use IS_ERR()? it seems not return NULL
>>> +             dev_err(&pdev->dev, "Failed to register tcpci port\n");
>>> +             return PTR_ERR(mti->tcpci);
>> If return NULL, this may return 0?
> Remove it later. you're right.
>>
>>> +     }
>>> +
>>> +     ret = devm_request_threaded_irq(mti->dev, mti->irq, NULL, mt6360_irq, IRQF_ONESHOT,
>>> +                                     dev_name(&pdev->dev), mti);
>>> +     if (ret) {
>>> +             dev_err(mti->dev, "Failed to register irq\n");
>>> +             tcpci_unregister_port(mti->tcpci);
>>> +             return ret;
>>> +     }
>>> +
>>> +     device_init_wakeup(&pdev->dev, true);
>>> +     platform_set_drvdata(pdev, mti);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int mt6360_tcpc_remove(struct platform_device *pdev)
>>> +{
>>> +     struct mt6360_tcpc_info *mti = platform_get_drvdata(pdev);
>>> +
>>> +     disable_irq(mti->irq);
>> need sync?
> Yes, sync must be considered to wait interrupt is really finished.
> And disable_irq already the sync version.
>>
>>> +     tcpci_unregister_port(mti->tcpci);
>>> +     return 0;
>>> +}
>>> +
>>> +static int __maybe_unused mt6360_tcpc_suspend(struct device *dev)
>>> +{
>>> +     struct mt6360_tcpc_info *mti = dev_get_drvdata(dev);
>>> +
>>> +     if (device_may_wakeup(dev))
>>> +             enable_irq_wake(mti->irq);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int __maybe_unused mt6360_tcpc_resume(struct device *dev)
>>> +{
>>> +     struct mt6360_tcpc_info *mti = dev_get_drvdata(dev);
>>> +
>>> +     if (device_may_wakeup(dev))
>>> +             disable_irq_wake(mti->irq);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static SIMPLE_DEV_PM_OPS(mt6360_tcpc_pm_ops, mt6360_tcpc_suspend, mt6360_tcpc_resume);
>>> +
>>> +static const struct of_device_id __maybe_unused mt6360_tcpc_of_id[] = {
>>> +     { .compatible = "mediatek,mt6360-tcpc", },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, mt6360_tcpc_of_id);
>>> +
>>> +static struct platform_driver mt6360_tcpc_driver = {
>>> +     .driver = {
>>> +             .name = "mt6360-tcpc",
>>> +             .pm = &mt6360_tcpc_pm_ops,
>>> +             .of_match_table = mt6360_tcpc_of_id,
>>> +     },
>>> +     .probe = mt6360_tcpc_probe,
>>> +     .remove = mt6360_tcpc_remove,
>>> +};
>>> +module_platform_driver(mt6360_tcpc_driver);
>>> +
>>> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
>>> +MODULE_DESCRIPTION("MT6360 USB Type-C Port Controller Interface Driver");
>>> +MODULE_LICENSE("GPL v2");
>>


Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3723C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13D0207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVxBAghH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgH1OtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgH1Os7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:48:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BFC061264;
        Fri, 28 Aug 2020 07:48:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls14so599793pjb.3;
        Fri, 28 Aug 2020 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GwsJK12F/RO3TxV8DL1QHEyRAdItfHxC7ojNdGJazTI=;
        b=ZVxBAghHGheQcnCpCUTauZpnptW7RVAxlmJDMKuCA7iIDe5ETmEImECQ9Jvmm02dRX
         T4MU583V9ZKesh7713tJxKze+vdNFvA40Hq87T3tevYQtp7jV8Nd5NSzKJXELNcRPV3H
         Y1S3vt9sy1JrZK8GodFt74OByaJii4IONE3KVY+8NEry1TRm0W9RqNFL6bpk0KybHvi8
         LIL7YTQOhBKX8mqUgLjCR+n4upgy3Em8KKwYyxacXs2YmuMiNpbQqU/nQ5LdeWf+As+n
         QlnjmOdRh/xsYWsTz98yc9F2JM0lWmGaTf3IZ77RIW8BrQ8MBmxNqTd0998Rf+3/tGz/
         4hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GwsJK12F/RO3TxV8DL1QHEyRAdItfHxC7ojNdGJazTI=;
        b=iWIBjPfhDzgl2DEB/x9QHzkAZiDjyzowKRcwY8VFxqU6AMoyoCqfNGee4giF06l76P
         DCUUOXjPhpGaSLvF5eB7X0bdIjMBNf2PpFB/HIcrGCkfTPTM2uGMXI9CD6JkT9eiokIL
         oYq2Jym8X2te/VjsV07x/N2rx4nSYINqqtgsJj4XCG5G+aKb4bBU3P0VRyIiA8lmuk8T
         MWEqVq34q9keYqq4kYJG2Dung/E3zvo/OXmV94qmJ5enVlpZzyH4d6589Nux5NlzoJum
         V649n1V9s1Q0rA7lncP6wB1vCud2ctJQqumORv/wxNnpBYCcy74SF7FW2Rv8ip7iUALQ
         wm+g==
X-Gm-Message-State: AOAM532sPYr/IuhcTTGp1rY7d1W7L8mvGLSDaN7MkOsJyMcBHIB+zQiQ
        tIwwvEJ4mBOu0BbVxOEPhhxAqSpqId0=
X-Google-Smtp-Source: ABdhPJyb+pG0Wk74bLWhX8DcPqkmUTC9YoFj3AX5iklc5Qnyy9Hg1smucBxCDLJ+Ti74vRo4D6DvVA==
X-Received: by 2002:a17:902:8e85:: with SMTP id bg5mr1567021plb.306.1598626138765;
        Fri, 28 Aug 2020 07:48:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4sm1901303pgi.49.2020.08.28.07.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 07:48:58 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] usb typec: mt6360: Add support for mt6360 Type-C
 driver
To:     ChiYuan Huang <u0084500@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com>
 <1598616616.7054.3.camel@mhfsdcap03>
 <CADiBU3_-Jvk8ORu1MxrccJkdK0_1WdH4Yd8AR-cGyDMEA3Htpw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6a66d52d-5f30-5982-e14c-12d81863f684@roeck-us.net>
Date:   Fri, 28 Aug 2020 07:48:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADiBU3_-Jvk8ORu1MxrccJkdK0_1WdH4Yd8AR-cGyDMEA3Htpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 7:33 AM, ChiYuan Huang wrote:
> Chunfeng Yun <chunfeng.yun@mediatek.com> 於 2020年8月28日 週五 下午8:11寫道：
>>
>> On Thu, 2020-08-27 at 19:18 +0800, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
>>> It works with Type-C Port Controller Manager to provide USB PD
>>> and USB Type-C functionalities.
>>>
>>> v1 to v2
>>> 1. Add fix to Prevent the race condition from interrupt and tcpci port
>>> unregister during module remove.
>>>
>>> v2 to v3
>>> 1. Change comment style for the head of source code.
>>> 2. No need to print error for platform_get_irq_byname.
>>> 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
>>> 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
>>> 5. Rename DT binding documents from mt6360 to mt636x.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  drivers/usb/typec/tcpm/Kconfig        |   8 ++
>>>  drivers/usb/typec/tcpm/Makefile       |   1 +
>>>  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 221 insertions(+)
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
>>> index 00000000..f1bd9e0
>>> --- /dev/null
>>> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
>>> @@ -0,0 +1,212 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (C) 2020 MediaTek Inc.
>>> + *
>>> + * Author: ChiYuan Huang <cy_huang@richtek.com>
>>> + */
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
>> Wonder why access some register by 2bytes, and others 4bytes?
>> can we access them all by 4bytes?
> 
> Actually, the access bus is still I2C.
> Each register is still one byte only.
> Register address like as TCPC_ALERT_MASK are continuous two byte used
> as IRQ MASK.
> That's why it's used wirte16 function to access.
> 
> Actually, you also can divided into two bytes write into one byte
> access by two times.
> For I2C bus efficiency, it seems bad.

For MT6360_REG_DRPCTRL2, it might also be racy, since the two i2c addresses
are really one register containing a 10-bit value. I would probably not matter
here (afaics the value is changed from the default 327 to 330), but in general
it seems safer to write such a value with a single 16-bit i2c write.

Guenter

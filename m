Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B6C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3373420748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txx/cRoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGJMNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:13:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A557DC08C5CE;
        Fri, 10 Jul 2020 05:13:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so5673922wrw.12;
        Fri, 10 Jul 2020 05:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lz304gbSx8L5RL8kaOXzcYT3h+ClGbxc3fD8gzQkw7Q=;
        b=Txx/cRoF1yR8sjLlXNDaaiSbOsGuzWdysOALInXqojy5Z6AiiZjq3+XU7VfBNsMFIn
         kE7wL7G7par5Px8kjCpKEhcBU7WWd0NqLwUhtCSFPD7KdojrYaaBXuHraKWVJFpxwtLQ
         aMFSkiBxsni1NVr9f77zGSUahmmFhYozs8WutsWOA13eUcAH36oSQJYfMP08SV8XCXFS
         Y7hU8tAMxeb+uFgb+v27mXgEokJmxKMdBkDcRTplCtLVN8B8IvZvurhI1c5U3lWtdsuf
         RomLJ18UY7vh3fjxtitI/YHdwK8txXhEZkL7rSMxzgR9HFtjOCN0CT97juBO3x1p9n/C
         CJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lz304gbSx8L5RL8kaOXzcYT3h+ClGbxc3fD8gzQkw7Q=;
        b=D3gJCVXMAV/t2e9S+sGH+XoGrv/An65tOxvAcHLBGij3dyl9sp9I98lRt7av/FTyV5
         Ctpzq+lK7kuu/P6aR9JvgfQwkcZoq7NJS90YcNc0pgkWRDgbTu7K6S0IqPypT3TnXl8C
         8LKq+0bi5BzptzuQ6CUjXML+TgMeCg4N09PKizPLfH2DrBWWxuhOB2TZmHhF3EKqfZAF
         biApOkuuXNlDgtw+VVLhv+hSWFE0QT+Jm75ryvD46NrYl5YpJbisnod3nAV7mkp/vUIf
         SfeOJ0qOdjgI3ELIVbSelag7NjeXGV7zoN9NWDUFmXJ4/7R3bXb7RSaYODkw5VnETEHB
         9K8Q==
X-Gm-Message-State: AOAM530PP5Sz24ZONOD1TistqPDQZg3rb5U9p2d4KpECi7vLoN0ICqFD
        kgv/4EIShg4JuU1+f+Q6hxs=
X-Google-Smtp-Source: ABdhPJxypVqVZDg3Y2gOe7xMACkjjtTBEY+HTN4OJRyNmMFlS2yZHoAjBrtYbRCdmYUfEEjIm+hMcw==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr71907881wrq.351.1594383193956;
        Fri, 10 Jul 2020 05:13:13 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id g144sm21561421wme.2.2020.07.10.05.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 05:13:12 -0700 (PDT)
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6779 driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, wsd_upstream@mediatek.com
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
 <1594027693-19530-3-git-send-email-neal.liu@mediatek.com>
 <f3cf4ef4-8c85-8921-5457-cef7a3006690@gmail.com>
 <1594107170.20820.84.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <922d93be-0243-bd7e-81fd-e0068a90ef4b@gmail.com>
Date:   Fri, 10 Jul 2020 14:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594107170.20820.84.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 09:32, Neal Liu wrote:
> Hi Matthias,
> 
> Thanks for your review.
> 
> On Mon, 2020-07-06 at 13:27 +0200, Matthias Brugger wrote:
>> CC linux-mediatek
>>
>> Please you ./scripts/get_maintainers.pl to find out to whom you should send the
>> series.
> 
> Yes, I already find out from get_maintainers.pl. But I forgot to add it
> into cc list...
> 
>>
>> On 06/07/2020 11:28, Neal Liu wrote:
>>> MT6779 bus frabric provides TrustZone security support and data
>>> protection to prevent slaves from being accessed by unexpected
>>> masters.
>>> The security violations are logged and sent to the processor for
>>> further analysis or countermeasures.
>>>
>>> Any occurrence of security violation would raise an interrupt, and
>>> it will be handled by devapc-mt6779 driver. The violation
>>> information is printed in order to find the murderer.
>>>
>>
>> Please describe in more detail how this HW works.
> 
> "devapc" means Device Access Permission Control.
> This hardware can control which bus masters are allowed or disallowed to
> access bus slaves. And it will generate interrupts if someone violates
> the rules.
> You can check binding for more details.
> 
>>
>>> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
>>> ---
>>
>> copying my comments from the last revision, which weren't answered and are not
>> addressed here. If you are not OK with my sugguestions, no problem but please
>> provide your arguments so that we can come up with a solution. Otherwise you are
>> just wasting your and my time:
> 
> Sorry for not replying your previous comments. I think your most
> comments are really helpful and I already revised and applied it in this
> patch.
> Let's discuss the part I missed.
> 
>>
>> Please review your data structures and try to group the information in logical
>> structs. For example I don't understand why we need mtk_devapc_context. It seems
>> to me that all the values in there are SoC specific.
>>
> 
> Yes, you are right. mtk_devapc_context dedicated to SoC specific.
> 
>> Why void __iomem *devapc_pd_base isn't part of the device_info?
>>
> 
> device_info stores slaves' info which are controlled by devapc.
> devapc_pd_base stores devapc_pd based register which is used to control
> and dump violation information.
> 
>>
>>
>>>   drivers/soc/mediatek/Kconfig                |    6 +
>>>   drivers/soc/mediatek/Makefile               |    1 +
>>>   drivers/soc/mediatek/devapc/Kconfig         |   17 +
>>>   drivers/soc/mediatek/devapc/Makefile        |   10 +
>>>   drivers/soc/mediatek/devapc/devapc-mt6779.c | 1111 +++++++++++++++++++++++++++
>>
>>  From the answers of the last revision it seems that this driver will be used for
>> more then one SoC. So we should not name it devapc-mt6779.c but for example
>> mtk-devapc.c.
> 
> Okay, we could use mtk-devapc.c for first patch. If we upstream next
> SoC, then we could separate SoC specific part.
> 
>>
>> By the way, what does the devapc stands for? It's not clear from the commit
>> message nor from the binding description.
> 
> It already described in binding title.
> title: MediaTek MT6779 Device Access Permission Control driver
> 
>>
>>>   drivers/soc/mediatek/devapc/devapc-mt6779.h |   99 +++
>>>   6 files changed, 1244 insertions(+)
>>>   create mode 100644 drivers/soc/mediatek/devapc/Kconfig
>>>   create mode 100644 drivers/soc/mediatek/devapc/Makefile
>>>   create mode 100644 drivers/soc/mediatek/devapc/devapc-mt6779.c
>>>   create mode 100644 drivers/soc/mediatek/devapc/devapc-mt6779.h
>>>
>>> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>>> index 59a56cd..2c9ad1f 100644
>>> --- a/drivers/soc/mediatek/Kconfig
>>> +++ b/drivers/soc/mediatek/Kconfig
>>> @@ -51,4 +51,10 @@ config MTK_MMSYS
>>>   	  Say yes here to add support for the MediaTek Multimedia
>>>   	  Subsystem (MMSYS).
>>>   
>>> +menu "Security"
>>> +
>>> +source "drivers/soc/mediatek/devapc/Kconfig"
>>> +
>>> +endmenu # Security
>>> +
>>>   endmenu
>>> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
>>> index 01f9f87..d6717a81 100644
>>> --- a/drivers/soc/mediatek/Makefile
>>> +++ b/drivers/soc/mediatek/Makefile
>>> @@ -1,5 +1,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>   obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>>> +obj-$(CONFIG_MTK_DEVAPC) += devapc/
>>
>> Why do we need a new folder for the driver?
> 
> Currently, we don't need it. But once it support multiple platforms, we
> would like to group it. Does it make sense?
> 
>>
>>>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>>>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>>>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>>> diff --git a/drivers/soc/mediatek/devapc/Kconfig b/drivers/soc/mediatek/devapc/Kconfig
>>> new file mode 100644
>>> index 0000000..b0f7d0e
>>> --- /dev/null
>>> +++ b/drivers/soc/mediatek/devapc/Kconfig
>>> @@ -0,0 +1,17 @@
>>> +config MTK_DEVAPC
>>> +	tristate "Mediatek Device APC Support"
>>> +	help
>>> +	  Device APC is a HW IP controlling internal device security.
>>> +	  MediaTek bus frabric provides TrustZone security support and data
>>> +	  protection to prevent slaves from being accessed by unexpected
>>> +	  bus masters.
>>> +	  Device APC prevents malicious access to internal devices.
>>> +
>>> +config DEVAPC_MT6779
>>> +	tristate "Mediatek MT6779 Device APC driver"
>>> +	select MTK_DEVAPC
>>> +	help
>>> +	  Say yes here to enable support Mediatek MT6779 Device APC driver.
>>> +	  This driver mainly used to handle the violation with 1 DEVAPC AO/PDs.
>>> +	  The violation information are logged for further analysis or
>>> +	  countermeasures.
>>> diff --git a/drivers/soc/mediatek/devapc/Makefile b/drivers/soc/mediatek/devapc/Makefile
>>> new file mode 100644
>>> index 0000000..0336c1d
>>> --- /dev/null
>>> +++ b/drivers/soc/mediatek/devapc/Makefile
>>> @@ -0,0 +1,10 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +ifeq ($(CONFIG_MTK_GCOV_KERNEL),y)
>>> +GCOV_PROFILE := y
>>> +endif
>>> +
>>> +obj-$(CONFIG_MTK_DEVAPC) := devapc.o
>>> +
>>> +# Platform
>>> +devapc-$(CONFIG_DEVAPC_MT6779) += devapc-mt6779.o
>>> diff --git a/drivers/soc/mediatek/devapc/devapc-mt6779.c b/drivers/soc/mediatek/devapc/devapc-mt6779.c
>>> new file mode 100644
>>> index 0000000..a28b9f3
>>> --- /dev/null
>>> +++ b/drivers/soc/mediatek/devapc/devapc-mt6779.c
>>> @@ -0,0 +1,1111 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2020 MediaTek Inc.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/of_address.h>
>>> +
>>> +#include "devapc-mt6779.h"
>>> +
>>> +static struct mtk_device_info mt6779_devices_infra[] = {
>>
>> Looks like a candidate to put into the *.h file.
>>
> 
> should be okay.
> 
>>> +	/* sys_idx, ctrl_idx, vio_idx */
>>> +	/* 0 */
>>> +	{0, 0, 0},
>>> +	{0, 1, 1},
>>> +	{0, 2, 2},
>>> +	{0, 3, 3},
>>> +	{0, 4, 4},
>>> +	{0, 5, 5},
>>> +	{0, 6, 6},
>>> +	{0, 7, 7},
>>> +	{0, 8, 8},
>>> +	{0, 9, 9},
>>> +
>>> +	/* 10 */
>>> +	{0, 10, 10},
>>> +	{0, 11, 11},
>>> +	{0, 12, 12},
>>> +	{0, 13, 13},
>>> +	{0, 14, 14},
>>> +	{0, 15, 15},
>>> +	{0, 16, 16},
>>> +	{0, 17, 17},
>>> +	{0, 18, 18},
>>> +	{0, 19, 19},
>>> +
>>> +	/* 20 */
>>> +	{0, 20, 20},
>>> +	{0, 21, 21},
>>> +	{0, 22, 22},
>>> +	{0, 23, 23},
>>> +	{0, 24, 24},
>>> +	{0, 25, 25},
>>> +	{0, 26, 26},
>>> +	{0, 27, 27},
>>> +	{0, 28, 28},
>>> +	{0, 29, 29},
>>> +
>>> +	/* 30 */
>>> +	{0, 30, 30},
>>> +	{0, 31, 31},
>>> +	{0, 32, 32},
>>> +	{0, 33, 77},
>>> +	{0, 34, 78},
>>> +	{0, 35, 79},
>>> +	{0, 35, 80},
>>> +	{0, 37, 37},
>>> +	{0, 38, 38},
>>> +	{0, 39, 39},
>>> +
>>> +	/* 40 */
>>> +	{0, 40, 40},
>>> +	{0, 41, 41},
>>> +	{0, 42, 42},
>>> +	{0, 43, 43},
>>> +	{0, 44, 44},
>>> +	{0, 45, 45},
>>> +	{0, 46, 46},
>>> +	{0, 47, 47},
>>> +	{0, 48, 48},
>>> +	{0, 49, 49},
>>> +
>>> +	/* 50 */
>>> +	{0, 50, 50},
>>> +	{0, 51, 51},
>>> +	{0, 52, 52},
>>> +	{0, 53, 53},
>>> +	{0, 54, 54},
>>> +	{0, 55, 55},
>>> +	{0, 56, 56},
>>> +	{0, 57, 57},
>>> +	{0, 58, 58},
>>> +	{0, 59, 59},
>>> +
>>> +	/* 60 */
>>> +	{0, 60, 60},
>>> +	{0, 61, 61},
>>> +	{0, 62, 62},
>>> +	{0, 63, 63},
>>> +	{0, 64, 64},
>>> +	{0, 65, 70},
>>> +	{0, 66, 71},
>>> +	{0, 67, 72},
>>> +	{0, 68, 73},
>>> +	{0, 70, 81},
>>> +
>>> +	/* 70 */
>>> +	{0, 71, 82},
>>> +	{0, 72, 83},
>>> +	{0, 73, 84},
>>> +	{0, 74, 85},
>>> +	{0, 75, 86},
>>> +	{0, 76, 87},
>>> +	{0, 77, 88},
>>> +	{0, 78, 89},
>>> +	{0, 79, 90},
>>> +	{0, 80, 91},
>>> +
>>> +	/* 80 */
>>> +	{0, 81, 92},
>>> +	{0, 82, 93},
>>> +	{0, 83, 94},
>>> +	{0, 84, 95},
>>> +	{0, 85, 96},
>>> +	{0, 86, 97},
>>> +	{0, 87, 98},
>>> +	{0, 88, 99},
>>> +	{0, 89, 100},
>>> +	{0, 90, 101},
>>> +
>>> +	/* 90 */
>>> +	{0, 91, 102},
>>> +	{0, 92, 103},
>>> +	{0, 93, 104},
>>> +	{0, 94, 105},
>>> +	{0, 95, 106},
>>> +	{0, 96, 107},
>>> +	{0, 97, 108},
>>> +	{0, 98, 109},
>>> +	{0, 110, 110},
>>> +	{0, 111, 111},
>>> +
>>> +	/* 100 */
>>
>> Comments maybe not needed, at least of added, they should represent the code.
> 
> This comments represent index of mt6779_devices_infra.
> It's helpful to check total numbers of slaves.
> 
>>
>>> +	{0, 112, 112},
>>> +	{0, 113, 113},
>>> +	{0, 114, 114},
>>> +	{0, 115, 115},
>>> +	{0, 116, 116},
>>> +	{0, 117, 117},
>>> +	{0, 118, 118},
>>> +	{0, 119, 119},
>>> +	{0, 120, 120},
>>> +	{0, 121, 121},
>>> +
>>> +	/* 110 */
>>> +	{0, 122, 122},
>>> +	{0, 123, 123},
>>> +	{0, 124, 124},
>>> +	{0, 125, 125},
>>> +	{0, 126, 126},
>>> +	{0, 127, 127},
>>> +	{0, 128, 128},
>>> +	{0, 129, 129},
>>> +	{0, 130, 130},
>>> +	{0, 131, 131},
>>> +
>>> +	/* 120 */
>>> +	{0, 132, 132},
>>> +	{0, 133, 133},
>>> +	{0, 134, 134},
>>> +	{0, 135, 135},
>>> +	{0, 136, 136},
>>> +	{0, 137, 137},
>>> +	{0, 138, 138},
>>> +	{0, 139, 139},
>>> +	{0, 140, 140},
>>> +	{0, 141, 141},
>>> +
>>> +	/* 130 */
>>> +	{0, 142, 142},
>>> +	{0, 143, 143},
>>> +	{0, 144, 144},
>>> +	{0, 145, 145},
>>> +	{0, 146, 146},
>>> +	{0, 147, 147},
>>> +	{0, 148, 148},
>>> +	{0, 149, 149},
>>> +	{0, 150, 150},
>>> +	{0, 151, 151},
>>> +
>>> +	/* 140 */
>>> +	{0, 152, 152},
>>> +	{0, 153, 153},
>>> +	{0, 154, 154},
>>> +	{0, 155, 155},
>>> +	{0, 156, 156},
>>> +	{0, 157, 157},
>>> +	{0, 158, 158},
>>> +	{0, 159, 159},
>>> +	{0, 160, 160},
>>> +	{0, 161, 161},
>>> +
>>> +	/* 150 */
>>> +	{0, 162, 162},
>>> +	{0, 163, 163},
>>> +	{0, 164, 164},
>>> +	{0, 165, 165},
>>> +	{0, 166, 166},
>>> +	{0, 167, 167},
>>> +	{0, 168, 168},
>>> +	{0, 169, 169},
>>> +	{0, 170, 170},
>>> +	{0, 171, 171},
>>> +
>>> +	/* 160 */
>>> +	{0, 172, 172},
>>> +	{0, 173, 173},
>>> +	{0, 174, 174},
>>> +	{0, 175, 175},
>>> +	{0, 176, 176},
>>> +	{0, 177, 177},
>>> +	{0, 178, 178},
>>> +	{0, 179, 179},
>>> +	{0, 180, 180},
>>> +	{0, 181, 181},
>>> +
>>> +	/* 170 */
>>> +	{0, 182, 182},
>>> +	{0, 183, 183},
>>> +	{0, 184, 184},
>>> +	{0, 185, 185},
>>> +	{0, 186, 186},
>>> +	{0, 187, 187},
>>> +	{0, 188, 188},
>>> +	{0, 189, 189},
>>> +	{0, 190, 190},
>>> +	{0, 191, 191},
>>> +
>>> +	/* 180 */
>>> +	{0, 192, 192},
>>> +	{0, 193, 193},
>>> +	{0, 194, 194},
>>> +	{0, 195, 195},
>>> +	{0, 196, 196},
>>> +	{0, 197, 197},
>>> +	{0, 198, 198},
>>> +	{0, 199, 199},
>>> +	{0, 200, 200},
>>> +	{0, 201, 201},
>>> +
>>> +	/* 190 */
>>> +	{0, 202, 202},
>>> +	{0, 203, 203},
>>> +	{0, 204, 204},
>>> +	{0, 205, 205},
>>> +	{0, 206, 206},
>>> +	{0, 207, 207},
>>> +	{0, 208, 208},
>>> +	{0, 209, 209},
>>> +	{0, 210, 210},
>>> +	{0, 211, 211},
>>> +
>>> +	/* 200 */
>>> +	{0, 212, 212},
>>> +	{0, 213, 213},
>>> +	{0, 214, 214},
>>> +	{0, 215, 215},
>>> +	{0, 216, 216},
>>> +	{0, 217, 217},
>>> +	{0, 218, 218},
>>> +	{0, 219, 219},
>>> +	{0, 220, 220},
>>> +	{0, 221, 221},
>>> +
>>> +	/* 210 */
>>> +	{0, 222, 222},
>>> +	{0, 223, 223},
>>> +	{0, 224, 224},
>>> +	{0, 225, 225},
>>> +	{0, 226, 226},
>>> +	{0, 227, 227},
>>> +	{0, 228, 228},
>>> +	{0, 229, 229},
>>> +	{0, 230, 230},
>>> +	{0, 231, 231},
>>> +
>>> +	/* 220 */
>>> +	{1, 0, 232},
>>> +	{1, 1, 233},
>>> +	{1, 2, 234},
>>> +	{1, 3, 235},
>>> +	{1, 4, 236},
>>> +	{1, 5, 237},
>>> +	{1, 6, 238},
>>> +	{1, 7, 239},
>>> +	{1, 8, 240},
>>> +	{1, 9, 241},
>>> +
>>> +	/* 230 */
>>> +	{1, 10, 242},
>>> +	{1, 11, 243},
>>> +	{1, 12, 244},
>>> +	{1, 13, 245},
>>> +	{1, 14, 246},
>>> +	{1, 15, 247},
>>> +	{1, 16, 248},
>>> +	{1, 17, 249},
>>> +	{1, 18, 250},
>>> +	{1, 19, 251},
>>> +
>>> +	/* 240 */
>>> +	{1, 20, 252},
>>> +	{1, 21, 253},
>>> +	{1, 22, 254},
>>> +	{1, 23, 255},
>>> +	{1, 24, 256},
>>> +	{1, 25, 257},
>>> +	{1, 26, 258},
>>> +	{1, 27, 259},
>>> +	{1, 28, 260},
>>> +	{1, 29, 261},
>>> +
>>> +	/* 250 */
>>> +	{1, 30, 262},
>>> +	{1, 31, 263},
>>> +	{1, 32, 264},
>>> +	{1, 33, 265},
>>> +	{1, 34, 266},
>>> +	{1, 35, 267},
>>> +	{1, 36, 268},
>>> +	{1, 37, 269},
>>> +	{1, 38, 270},
>>> +	{1, 39, 271},
>>> +
>>> +	/* 260 */
>>> +	{1, 40, 272},
>>> +	{1, 41, 273},
>>> +	{1, 42, 274},
>>> +	{1, 43, 275},
>>> +	{1, 44, 276},
>>> +	{1, 45, 277},
>>> +	{1, 46, 278},
>>> +	{1, 47, 279},
>>> +	{1, 48, 280},
>>> +	{1, 49, 281},
>>> +
>>> +	/* 270 */
>>> +	{1, 50, 282},
>>> +	{1, 51, 283},
>>> +	{1, 52, 284},
>>> +	{1, 53, 285},
>>> +	{1, 54, 286},
>>> +	{1, 55, 287},
>>> +	{1, 56, 288},
>>> +	{1, 57, 289},
>>> +	{1, 58, 290},
>>> +	{1, 59, 291},
>>> +
>>> +	/* 280 */
>>> +	{1, 60, 292},
>>> +	{1, 61, 293},
>>> +	{1, 62, 294},
>>> +	{1, 63, 295},
>>> +	{1, 64, 296},
>>> +	{1, 65, 297},
>>> +	{1, 66, 298},
>>> +	{1, 67, 299},
>>> +	{1, 68, 300},
>>> +	{1, 69, 301},
>>> +
>>> +	/* 290 */
>>> +	{1, 70, 302},
>>> +	{1, 71, 303},
>>> +	{1, 72, 304},
>>> +	{1, 73, 305},
>>> +	{1, 74, 306},
>>> +	{1, 75, 307},
>>> +	{1, 76, 308},
>>> +	{1, 77, 309},
>>> +	{1, 78, 310},
>>> +	{1, 79, 311},
>>> +
>>> +	/* 300 */
>>> +	{1, 80, 312},
>>> +	{1, 81, 313},
>>> +	{1, 82, 314},
>>> +	{1, 83, 315},
>>> +	{1, 84, 316},
>>> +	{1, 85, 317},
>>> +	{1, 86, 318},
>>> +	{1, 87, 319},
>>> +	{1, 88, 320},
>>> +	{1, 89, 321},
>>> +
>>> +	/* 310 */
>>> +	{1, 90, 322},
>>> +	{1, 91, 323},
>>> +	{1, 92, 324},
>>> +	{1, 93, 325},
>>> +	{1, 94, 326},
>>> +	{1, 95, 327},
>>> +	{1, 96, 328},
>>> +	{1, 97, 329},
>>> +	{1, 98, 330},
>>> +	{1, 99, 331},
>>> +
>>> +	/* 320 */
>>> +	{1, 100, 332},
>>> +	{1, 101, 333},
>>> +	{1, 102, 334},
>>> +	{1, 103, 335},
>>> +	{1, 104, 336},
>>> +	{1, 105, 337},
>>> +	{1, 106, 338},
>>> +	{1, 107, 339},
>>> +	{1, 108, 340},
>>> +	{1, 109, 341},
>>> +
>>> +	/* 330 */
>>> +	{1, 110, 342},
>>> +	{1, 111, 343},
>>> +	{1, 112, 344},
>>> +	{1, 113, 345},
>>> +	{1, 114, 346},
>>> +	{1, 115, 347},
>>> +	{1, 116, 348},
>>> +	{1, 117, 349},
>>> +	{1, 118, 350},
>>> +	{1, 119, 351},
>>> +
>>> +	/* 340 */
>>> +	{1, 120, 352},
>>> +	{1, 121, 353},
>>> +	{1, 122, 354},
>>> +	{1, 123, 355},
>>> +	{1, 124, 356},
>>> +	{1, 125, 357},
>>> +	{1, 126, 358},
>>> +	{1, 127, 359},
>>> +	{1, 128, 360},
>>> +	{1, 129, 361},
>>> +
>>> +	/* 350 */
>>> +	{1, 130, 362},
>>> +	{1, 131, 363},
>>> +	{1, 132, 364},
>>> +	{1, 133, 365},
>>> +	{1, 134, 366},
>>> +	{1, 135, 367},
>>> +	{1, 136, 368},
>>> +	{1, 137, 369},
>>> +	{1, 138, 370},
>>> +	{1, 139, 371},
>>> +
>>> +	/* 360 */
>>> +	{1, 140, 372},
>>> +	{1, 141, 373},
>>> +	{1, 142, 374},
>>> +	{1, 143, 375},
>>> +	{1, 144, 376},
>>> +	{1, 145, 377},
>>> +	{1, 146, 378},
>>> +	{1, 147, 379},
>>> +	{1, 148, 380},
>>> +	{1, 149, 381},
>>> +
>>> +	/* 370 */
>>> +	{1, 150, 382},
>>> +	{1, 151, 383},
>>> +	{1, 152, 384},
>>> +	{1, 153, 385},
>>> +	{1, 154, 386},
>>> +	{1, 155, 387},
>>> +	{1, 156, 388},
>>> +	{1, 157, 389},
>>> +	{1, 158, 390},
>>> +	{1, 159, 391},
>>> +
>>> +	/* 380 */
>>> +	{1, 160, 392},
>>> +	{1, 161, 393},
>>> +	{1, 162, 394},
>>> +	{1, 163, 395},
>>> +	{1, 164, 396},
>>> +	{1, 165, 397},
>>> +	{1, 166, 398},
>>> +	{1, 167, 399},
>>> +	{1, 168, 400},
>>> +	{1, 169, 401},
>>> +
>>> +	/* 390 */
>>> +	{1, 170, 402},
>>> +	{1, 171, 403},
>>> +	{1, 172, 404},
>>> +	{1, 173, 405},
>>> +	{1, 174, 406},
>>> +	{1, 175, 407},
>>> +	{1, 176, 408},
>>> +	{1, 177, 409},
>>> +	{1, 178, 410},
>>> +	{1, 179, 411},
>>> +
>>> +	/* 400 */
>>> +	{1, 180, 412},
>>> +	{1, 181, 413},
>>> +	{1, 182, 414},
>>> +	{1, 183, 415},
>>> +	{1, 184, 416},
>>> +	{1, 185, 417},
>>> +	{1, 186, 418},
>>> +	{1, 187, 419},
>>> +	{1, 188, 420},
>>> +	{1, 189, 421},
>>> +
>>> +	/* 410 */
>>> +	{1, 190, 422},
>>> +	{1, 191, 423},
>>> +	{1, 192, 424},
>>> +	{1, 193, 425},
>>> +	{1, 194, 426},
>>> +	{1, 195, 427},
>>> +	{1, 196, 428},
>>> +	{1, 197, 429},
>>> +	{1, 198, 430},
>>> +	{1, 199, 431},
>>> +
>>> +	/* 420 */
>>> +	{1, 200, 432},
>>> +	{1, 201, 433},
>>> +	{1, 202, 434},
>>> +	{1, 203, 435},
>>> +	{1, 204, 436},
>>> +	{1, 205, 437},
>>> +	{1, 206, 438},
>>> +	{1, 207, 439},
>>> +	{1, 208, 440},
>>> +	{1, 209, 441},
>>> +
>>> +	/* 430 */
>>> +	{1, 210, 442},
>>> +	{1, 211, 443},
>>> +	{1, 212, 444},
>>> +	{1, 213, 445},
>>> +	{1, 214, 446},
>>> +	{1, 215, 447},
>>> +	{1, 216, 448},
>>> +	{1, 217, 449},
>>> +	{1, 218, 450},
>>> +	{1, 219, 451},
>>> +
>>> +	/* 440 */
>>> +	{1, 220, 452},
>>> +	{1, 221, 453},
>>> +	{1, 222, 454},
>>> +	{1, 223, 455},
>>> +	{1, 224, 456},
>>> +	{1, 225, 457},
>>> +	{1, 226, 458},
>>> +	{1, 227, 459},
>>> +	{1, 228, 460},
>>> +	{1, 229, 461},
>>> +
>>> +	/* 450 */
>>> +	{1, 230, 462},
>>> +	{1, 231, 463},
>>> +	{1, 232, 464},
>>> +	{1, 233, 465},
>>> +	{1, 234, 466},
>>> +	{1, 235, 467},
>>> +	{1, 236, 468},
>>> +	{1, 237, 469},
>>> +	{1, 238, 470},
>>> +	{1, 239, 471},
>>> +
>>> +	/* 460 */
>>> +	{1, 240, 472},
>>> +	{1, 241, 473},
>>> +	{1, 242, 474},
>>> +	{1, 243, 475},
>>> +	{1, 244, 476},
>>> +	{1, 245, 477},
>>> +	{1, 246, 478},
>>> +	{-1, -1, 479},
>>> +	{-1, -1, 480},
>>> +	{-1, -1, 481},
>>> +
>>> +	/* 470 */
>>> +	{-1, -1, 482},
>>> +	{-1, -1, 483},
>>> +	{-1, -1, 484},
>>> +	{-1, -1, 485},
>>> +	{-1, -1, 486},
>>> +	{-1, -1, 487},
>>> +	{-1, -1, 488},
>>> +	{-1, -1, 489},
>>> +	{-1, -1, 490},
>>> +	{-1, -1, 491},
>>> +
>>> +	/* 480 */
>>> +	{-1, -1, 492},
>>> +	{-1, -1, 493},
>>> +	{-1, -1, 494},
>>> +	{-1, -1, 495},
>>> +	{-1, -1, 496},
>>> +	{-1, -1, 497},
>>> +	{-1, -1, 498},
>>> +	{-1, -1, 499},
>>> +	{-1, -1, 500},
>>> +	{-1, -1, 501},
>>> +
>>> +	/* 490 */
>>> +	{-1, -1, 502},
>>> +	{-1, -1, 503},
>>> +	{-1, -1, 504},
>>> +	{-1, -1, 505},
>>> +	{-1, -1, 506},
>>> +	{-1, -1, 507},
>>> +	{-1, -1, 508},
>>> +	{-1, -1, 509},
>>> +	{-1, -1, 510},
>>> +
>>> +};
>>> +
>>> +static struct mtk_device_num mtk6779_devices_num[] = {
>>> +	{SLAVE_TYPE_INFRA, VIO_SLAVE_NUM_INFRA},
>>> +};
>>> +
>>> +static int mtk_vio_mask_sta_num[] = {
>>> +	VIO_MASK_STA_NUM_INFRA,
>>> +};
>>> +
>>> +static const struct mtk_infra_vio_dbg_desc mt6779_vio_dbgs = {
>>> +	.vio_dbg_mstid = INFRA_VIO_DBG_MSTID,
>>> +	.vio_dbg_mstid_start_bit = INFRA_VIO_DBG_MSTID_START_BIT,
>>> +	.vio_dbg_dmnid = INFRA_VIO_DBG_DMNID,
>>> +	.vio_dbg_dmnid_start_bit = INFRA_VIO_DBG_DMNID_START_BIT,
>>> +	.vio_dbg_w_vio = INFRA_VIO_DBG_W_VIO,
>>> +	.vio_dbg_w_vio_start_bit = INFRA_VIO_DBG_W_VIO_START_BIT,
>>> +	.vio_dbg_r_vio = INFRA_VIO_DBG_R_VIO,
>>> +	.vio_dbg_r_vio_start_bit = INFRA_VIO_DBG_R_VIO_START_BIT,
>>> +	.vio_addr_high = INFRA_VIO_ADDR_HIGH,
>>> +	.vio_addr_high_start_bit = INFRA_VIO_ADDR_HIGH_START_BIT,
>>> +};
>>> +
>>> +static const u32 mt6779_devapc_pds[] = {
>>> +	PD_VIO_MASK_OFFSET,
>>> +	PD_VIO_STA_OFFSET,
>>> +	PD_VIO_DBG0_OFFSET,
>>> +	PD_VIO_DBG1_OFFSET,
>>> +	PD_APC_CON_OFFSET,
>>> +	PD_SHIFT_STA_OFFSET,
>>> +	PD_SHIFT_SEL_OFFSET,
>>> +	PD_SHIFT_CON_OFFSET,
>>> +};
>>> +
>>> +static u32 mt6779_shift_group_get(u32 vio_idx)
>>> +{
>>> +	if (vio_idx >= 0 && vio_idx <= 32)
>>> +		return 0;
>>> +	else if (vio_idx >= 33 && vio_idx <= 109)
>>> +		return 1;
>>> +	else if ((vio_idx >= 110 && vio_idx <= 121) ||
>>> +		 (vio_idx >= 470 && vio_idx <= 472))
>>> +		return 2;
>>> +	else if (vio_idx == 122 || vio_idx == 500)
>>> +		return 3;
>>> +	else if (vio_idx == 123)
>>> +		return 4;
>>> +	else if (vio_idx == 124)
>>> +		return 5;
>>> +	else if ((vio_idx >= 125 && vio_idx <= 155) ||
>>> +		 (vio_idx >= 486 && vio_idx <= 488))
>>> +		return 6;
>>> +	else if ((vio_idx >= 156 && vio_idx <= 157) ||
>>> +		 (vio_idx >= 159 && vio_idx <= 165))
>>> +		return 7;
>>> +	else if ((vio_idx >= 166 && vio_idx <= 181) ||
>>> +		 (vio_idx >= 473 && vio_idx <= 475))
>>> +		return 8;
>>> +	else if ((vio_idx >= 182 && vio_idx <= 197) ||
>>> +		 (vio_idx >= 476 && vio_idx <= 478))
>>> +		return 9;
>>> +	else if ((vio_idx >= 198 && vio_idx <= 205) ||
>>> +		 (vio_idx >= 479 && vio_idx <= 481))
>>> +		return 10;
>>> +	else if ((vio_idx >= 214 && vio_idx <= 229) ||
>>> +		 (vio_idx >= 482 && vio_idx <= 484))
>>> +		return 11;
>>> +	else if (vio_idx == 230)
>>> +		return 12;
>>> +	else if (vio_idx == 158)
>>> +		return 13;
>>> +	else if (vio_idx == 231 || vio_idx == 382)
>>> +		return 14;
>>> +	else if (vio_idx >= 232 && vio_idx <= 244)
>>> +		return 15;
>>> +	else if (vio_idx >= 245 && vio_idx <= 478)
>>> +		return 16;
>>> +	else if (vio_idx >= 504 && vio_idx <= 505)
>>> +		return 17;
>>> +	else if (vio_idx == 494)
>>> +		return 18;
>>> +	else if (vio_idx == 503)
>>> +		return 19;
>>> +	else if (vio_idx == 501)
>>> +		return 20;
>>> +	else if (vio_idx == 502)
>>> +		return 21;
>>> +	else if (vio_idx == 506)
>>> +		return 22;
>>> +	else if (vio_idx == 507)
>>> +		return 23;
>>> +	else if (vio_idx == 508)
>>> +		return 24;
>>> +	else if ((vio_idx >= 206 && vio_idx <= 213) ||
>>> +		 (vio_idx >= 498 && vio_idx <= 500))
>>> +		return 25;
>>> +
>>> +	return 31;
>>> +}
>>> +
>>> +/*
>>> + * mtk_devapc_pd_get - get devapc pd_types of register address.
>>> + *
>>> + * Returns the value of reg addr
>>> + */
>>> +static void __iomem *mtk_devapc_pd_get(struct mtk_devapc_context *devapc_ctx,
>>> +				       int slave_type,
>>> +				       enum DEVAPC_PD_REG_TYPE pd_reg_type,
>>> +				       u32 index)
>>> +{
>>> +	const u32 *devapc_pds = mt6779_devapc_pds;
>>> +	void __iomem *reg;
>>> +
>>> +	reg = devapc_ctx->devapc_pd_base[slave_type] + devapc_pds[pd_reg_type];
>>> +
>>> +	if (pd_reg_type == VIO_MASK || pd_reg_type == VIO_STA)
>>> +		reg += 0x4 * index;
>>> +
>>> +	return reg;
>>> +}
>>> +
>>> +static int check_vio_mask_sta(struct mtk_devapc_context *devapc_ctx,
>>> +			      int slave_type, u32 module, int pd_reg_type)
>>> +{
>>> +	u32 apc_register_index, apc_set_index;
>>> +	void __iomem *reg;
>>> +	u32 value;
>>> +
>>> +	apc_register_index = module / (MOD_NM_IN_1_DEVAPC * 2);
>>> +	apc_set_index = module % (MOD_NM_IN_1_DEVAPC * 2);
>>> +
>>> +	if (apc_register_index < mtk_vio_mask_sta_num[slave_type])
>>> +		reg = mtk_devapc_pd_get(devapc_ctx, slave_type, pd_reg_type,
>>> +					apc_register_index);
>>> +	else
>>> +		return -EOVERFLOW;
>>
>> How could that happen?
>>
> 
> Currently, all components are inside this driver. This is not necessary
> at all. I'll remove it.
> 
>>> +
>>> +	value = (readl(reg) & (0x1 << apc_set_index)) >> apc_set_index;
>>> +
>>> +	return value;
>>
>> value = readl(reg);
>> return ((value >> apc_set_index) & 0x1);
> 
> Is it for readability?
> 
>>
>>
>>> +}
>>> +
>>> +static int check_vio_mask(struct mtk_devapc_context *devapc_ctx, int slave_type,
>>> +			  u32 module)
>>> +{
>>> +	return check_vio_mask_sta(devapc_ctx, slave_type, module, VIO_MASK);
>>> +}
>>> +
>>> +static int check_vio_status(struct mtk_devapc_context *devapc_ctx,
>>> +			    int slave_type, u32 module)
>>> +{
>>> +	return check_vio_mask_sta(devapc_ctx, slave_type, module, VIO_STA);
>>> +}
>>> +
>>> +static void clear_vio_status(struct mtk_devapc_context *devapc_ctx,
>>> +			     int slave_type, u32 module)
>>> +{
>>> +	u32 apc_register_index, apc_set_index;
>>> +	void __iomem *reg;
>>> +
>>> +	apc_register_index = module / (MOD_NM_IN_1_DEVAPC * 2);
>>> +	apc_set_index = module % (MOD_NM_IN_1_DEVAPC * 2);
>>
>> What does MOD_NM_IN_1_DEVAPC stands for? Why do you define it with 16 when
>> afterwards you only use it with value 32? Do I understand correctly that this
>> calculates the register offset and bit in the register to write to?
> 
> Yes! Each module violation index stands for 1 bit, so there are 32
> modules in 1 devapc register.
> I think MOD_NUM_IN_1_DEVAPC is not necessary, I'll remove it and
> hardcode "32" for this calculation.
> 
>>
>>> +
>>> +	if (apc_register_index < mtk_vio_mask_sta_num[slave_type]) {
>>
>> mtk_vio_mask_sta_num[slave_type] == maximum of registers that can be accessed?
> 
> Yap. This code is not necessary.
> Ditto.
> 
>>
>>> +		reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_STA,
>>> +					apc_register_index);
>>> +		writel(0x1 << apc_set_index, reg);
>>> +
>>> +	} else {
>>> +		pr_err(PFX "%s: Out Of Boundary, slave_type:0x%x, module_index:0x%x\n",
>>> +		       __func__, slave_type, module);
>>
>> Only used internally by the driver, why can't we suppose that the driver does
>> not implement module number outside of the accessible registers? I think this
>> can be dropped.
>>
> 
> Ditto
> 
>>> +		return;
>>> +	}
>>> +
>>> +	if (check_vio_status(devapc_ctx, slave_type, module))
>>> +		pr_err(PFX "%s: Clear failed, slave_type:0x%x, module_index:0x%x\n",
>>> +		       __func__, slave_type, module);
>>> +}
>>> +
>>> +static void mask_module_irq(struct mtk_devapc_context *devapc_ctx,
>>> +			    int slave_type, u32 module, bool mask)
>>> +{
>>> +	u32 apc_register_index, apc_set_index;
>>> +	void __iomem *reg;
>>> +
>>> +	apc_register_index = module / (MOD_NM_IN_1_DEVAPC * 2);
>>> +	apc_set_index = module % (MOD_NM_IN_1_DEVAPC * 2);
>>
>> Better add a macro for this and rename set_index into register_offset?
> 
> I agree.
> Do you suggest to include variable declaration into marco? Or just
> calculation only?
> 
>>
>>> +
>>> +	if (apc_register_index < mtk_vio_mask_sta_num[slave_type]) {
>>> +		reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_MASK,
>>> +					apc_register_index);
>>
>> I don't like this code all over the place, could add the correct offset to
>> mtk_device_info and just add it in readl/writel directly?
> 
> Ditto.
> 
>>
>>> +
>>> +		if (mask)
>>> +			writel(readl(reg) | (1 << apc_set_index), reg);
>>> +		else
>>> +			writel(readl(reg) & (~(1 << apc_set_index)), reg);
>>
>> value = readl(reg);
>>
>> if (mask)
>> 	value |= (0x1 << apc_set_index);
>> else
>> 	value &= ~(0x1 << apc_set_index);
>>
>> writel(value);
>>
> 
> Is it for readability?
> 
>>> +
>>> +	} else {
>>> +		pr_err(PFX "%s: Out Of Boundary, slave_type:0x%x, module_index:0x%x, mask:%s\n",
>>> +		       __func__, slave_type, module, mask ? "true" : "false");
>>> +	}
>>> +}
>>> +
>>> +/*
>>> + * sync_vio_dbg - start to get violation information by selecting violation
>>> + *		  group and enable violation shift.
>>> + *
>>> + * Returns sync done or not
>>> + */
>>> +static u32 sync_vio_dbg(struct mtk_devapc_context *devapc_ctx, int slave_type,
>>> +			u32 shift_bit)
>>> +{
>>> +	void __iomem *pd_vio_shift_sta_reg;
>>> +	void __iomem *pd_vio_shift_sel_reg;
>>> +	void __iomem *pd_vio_shift_con_reg;
>>> +	u32 shift_count;
>>> +	u32 sync_done;
>>> +
>>> +	pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_STA, 0);
>>> +	pd_vio_shift_sel_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_SEL, 0);
>>> +	pd_vio_shift_con_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_CON, 0);
>>> +
>>> +	writel(0x1 << shift_bit, pd_vio_shift_sel_reg);
>>> +	writel(0x1, pd_vio_shift_con_reg);
>>> +
>>> +	for (shift_count = 0; (shift_count < 100) &&
>>> +	     ((readl(pd_vio_shift_con_reg) & 0x3) != 0x3);
>>> +	     ++shift_count)
>>
>> Use read_poll_timeout here, we don't want to depend on the time 100 reads need,
>> as from my understanding this depends on the (dynamic) clock frequency.
>>
> 
> Okay, I'll try read_poll_timeout here.
> 
>>> +		;
>>> +
>>> +	if ((readl(pd_vio_shift_con_reg) & 0x3) == 0x3)
>>
>> We can read the value via readl_poll_timeout. No need to read it again here.
> 
> Ditto.
> 
>>
>>> +		sync_done = 1;
>>> +	else
>>> +		sync_done = 0;
>>> +
>>> +	/* Disable shift mechanism */
>>
>> What is the "shift mechanism"?
> 
> "shift mechanism" is depends on devapc hardware design.
> We set multiple slaves as a group. When violation is triggered,
> violation information is kept inside hardware. (Cannot get full
> information from registers.)
> We have to do "shift mechanism" to shift violation information to
> VIO_DBG0, VIO_DBG1 registers.
> 
> You can see we have to do sync_vio_dbg() before getting full violation
> information (devapc_extract_vio_dbg()).
> 
>>
>>> +	writel(0x0, pd_vio_shift_con_reg);
>>> +	writel(0x0, pd_vio_shift_sel_reg);
>>> +	writel(0x1 << shift_bit, pd_vio_shift_sta_reg);
>>> +
>>> +	return sync_done;
>>> +}
>>> +
>>> +static void devapc_vio_info_print(struct mtk_devapc_context *devapc_ctx)
>>> +{
>>> +	struct mtk_devapc_vio_info *vio_info = devapc_ctx->vio_info;
>>> +
>>> +	/* Print violation information */
>>> +	if (vio_info->write)
>>> +		pr_info(PFX "Write Violation\n");
>>> +	else if (vio_info->read)
>>> +		pr_info(PFX "Read Violation\n");
>>> +
>>> +	pr_info(PFX "%s%x, %s%x, %s%x, %s%x\n",
>>> +		"Vio Addr:0x", vio_info->vio_addr,
>>> +		"High:0x", vio_info->vio_addr_high,
>>> +		"Bus ID:0x", vio_info->master_id,
>>> +		"Dom ID:0x", vio_info->domain_id);
>>> +}
>>> +
>>> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *devapc_ctx,
>>> +				   int slave_type)
>>> +{
>>> +	void __iomem *vio_dbg0_reg, *vio_dbg1_reg;
>>> +	const struct mtk_infra_vio_dbg_desc *vio_dbgs;
>>> +	struct mtk_devapc_vio_info *vio_info;
>>> +	u32 dbg0;
>>> +
>>> +	vio_dbg0_reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_DBG0, 0);
>>> +	vio_dbg1_reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_DBG1, 0);
>>> +
>>> +	vio_dbgs = &mt6779_vio_dbgs;
>>> +	vio_info = devapc_ctx->vio_info;
>>> +
>>> +	/* Extract violation information */
>>> +	dbg0 = readl(vio_dbg0_reg);
>>> +	vio_info->vio_addr = readl(vio_dbg1_reg);
>>> +
>>> +	vio_info->master_id = (dbg0 & vio_dbgs->vio_dbg_mstid) >>
>>> +			      vio_dbgs->vio_dbg_mstid_start_bit;
>>> +	vio_info->domain_id = (dbg0 & vio_dbgs->vio_dbg_dmnid) >>
>>> +			      vio_dbgs->vio_dbg_dmnid_start_bit;
>>> +	vio_info->write = ((dbg0 & vio_dbgs->vio_dbg_w_vio) >>
>>> +			   vio_dbgs->vio_dbg_w_vio_start_bit) == 1;
>>> +	vio_info->read = ((dbg0 & vio_dbgs->vio_dbg_r_vio) >>
>>> +			  vio_dbgs->vio_dbg_r_vio_start_bit) == 1;
>>
>> We can have read and write violation at a time?
> 
> No, but it keeps independently.
> 
>>
>>> +	vio_info->vio_addr_high = (dbg0 & vio_dbgs->vio_addr_high) >>
>>> +				  vio_dbgs->vio_addr_high_start_bit;
>>> +
>>> +	devapc_vio_info_print(devapc_ctx);
>>> +}
>>> +
>>> +/*
>>> + * mtk_devapc_dump_vio_dbg - shift & dump the violation debug information.
>>> + */
>>> +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *devapc_ctx,
>>> +				    int slave_type, int *vio_idx, int *index)
>>> +{
>>> +	const struct mtk_device_info **device_info;
>>> +	const struct mtk_device_num *ndevices;
>>> +	void __iomem *pd_vio_shift_sta_reg;
>>> +	u32 shift_bit;
>>> +	int i;
>>> +
>>> +	if (!vio_idx)
>>> +		return NULL;
>>> +
>>> +	device_info = devapc_ctx->device_info;
>>> +	ndevices = mtk6779_devices_num;
>>> +
>>> +	pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_STA, 0);
>>> +
>>> +	for (i = 0; i < ndevices[slave_type].vio_slave_num; i++) {
>>> +		*vio_idx = device_info[slave_type][i].vio_index;
>>> +
>>> +		if (check_vio_mask(devapc_ctx, slave_type, *vio_idx))
>>> +			continue;
>>> +
>>> +		if (check_vio_status(devapc_ctx, slave_type, *vio_idx) <= 0)
>>> +			continue;
>>> +
>>> +		shift_bit = mt6779_shift_group_get(*vio_idx);
>>
>> shift_bit should be part of mtk_device_info data structure.
>> You can create two macros to define mtk_device_info entries, one which sets the
>> shift bit to 31 and another one, that allows for setting the bit explicitely.
> 
> This is another way to get shift bit. What benefit could we get?
> I could only imagine array indexing is more efficient than function
> call. But we do not really care the performance impact since the
> violation scenario is unexpected.
> 

It makes the code more readable.
It will allow us to add more SoC support in the future, as we don't have SoC 
specific functions we need to call.

>>
>>> +
>>> +		if (!sync_vio_dbg(devapc_ctx, slave_type, shift_bit))
>>> +			continue;
>>> +
>>> +		devapc_extract_vio_dbg(devapc_ctx, slave_type);
>>> +		*index = i;
>>> +
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) will dump
>>> + *			  violation information including which master violates
>>> + *			  access slave.
>>> + */
>>> +static irqreturn_t devapc_violation_irq(int irq_number,
>>> +					struct mtk_devapc_context *devapc_ctx)
>>> +{
>>> +	const struct mtk_device_info **device_info = devapc_ctx->device_info;
>>> +	int vio_idx = -1;
>>> +	int index = -1;
>>> +	int slave_type;
>>> +
>>> +	for (slave_type = 0; slave_type < SLAVE_TYPE_NUM; slave_type++) {
>>> +		if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slave_type, &vio_idx,
>>> +					     &index))
>>> +			continue;
>>> +
>>> +		/* Ensure that violation info are written before
>>> +		 * further operations
>>> +		 */
>>> +		smp_mb();
>>> +
>>> +		mask_module_irq(devapc_ctx, slave_type, vio_idx, true);
>>> +
>>> +		clear_vio_status(devapc_ctx, slave_type, vio_idx);
>>> +
>>> +		pr_info(PFX "Violation - slave_type:0x%x, sys_index:0x%x, ctrl_index:0x%x, vio_index:0x%x\n",
>>> +			slave_type,
>>> +			device_info[slave_type][index].sys_index,
>>> +			device_info[slave_type][index].ctrl_index,
>>> +			device_info[slave_type][index].vio_index);
>>
>> How will that then be used? Will there some kind of user-space daemon which will
>> parse the kernel log to see if a violation happens? What will it do with this
>> information?
>>
>> I still don't understand why we need to do that in the kernel instead of in
>> TF-A. Can you please explain?
>>
> 
> We would do different extra handle for different bus masters internally.

Does this mean that this is only one part of the whole story? Are you planning 
to hook into that code internally to implement the handling?
In that we would need to support the whole thing in upstream. And this sounds 
like you will need a new subsystem for bus firewall (or how you want to name 
it). Which allows you to easily add support for other vendors SoCs.

> Basically, different bus masters have different debug mechanism.
> And different customers have different severity about devapc violation.
> For example, kernel exception, external exception, warning, don't
> care,...
> 
> I list 2 reason why I put it in kernel instead of ATF.
> 1. Rich OS such as Linux kernel has more debug mechanism and tools to
> find murderer.

But you can access porgram counter from EL3 as well, so you could print all the 
info you need in TF-A.

> 2. If interrupt has to be handled in ATF, GIC intr would be set as G0S
> (Group 0 Secure). For our interrupt routing, G0S intr would be fiq. When
> we handle it in EL3, it would mask all EL1 irq temporarily. We do not
> treat devapc interrupt as such critical.

But you said "violation scenario is unexpected" so actually you don't expect it 
to happen.

> 
> Doe it make sense? Or do you have any reason that it should be handled
> in ATF?
> 

My reasoning is that you bring a security mechanism into the kernel, which is in 
none-secure state. That's a contradiction.

Regards,
Matthias

>>
>>> +
>>> +		mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
>>> +	}
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +/*
>>> + * start_devapc - initialize devapc status and start receiving interrupt
>>> + *		  while devapc violation is triggered.
>>> + */
>>> +static void start_devapc(struct mtk_devapc_context *devapc_ctx)
>>> +{
>>> +	const struct mtk_device_info **device_info;
>>> +	const struct mtk_device_num *ndevices;
>>> +	void __iomem *pd_vio_shift_sta_reg;
>>> +	void __iomem *pd_apc_con_reg;
>>> +	int slave_type, vio_idx, i;
>>> +	u32 vio_shift_sta;
>>> +
>>> +	devapc_ctx->device_info[0] = mt6779_devices_infra;
>>
>> One element arry should be a simple pointer.
>> mt6779_devices_infra should be DT data for the mt6779 compatible.
> 
> Yes, you are right. It's no need to use element array. I'll try it could
> put into DT data or not.
> 
>>
>>> +	device_info = devapc_ctx->device_info;
>>> +	ndevices = mtk6779_devices_num;
>>> +
>>> +	for (slave_type = 0; slave_type < SLAVE_TYPE_NUM; slave_type++) {
>>
>> For loop not needed, we ony have one SLAVE_TYPE.
> 
> Yes, I'll fix it.
> 
>>
>>> +		pd_apc_con_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						   APC_CON, 0);
>>> +		pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +							 VIO_SHIFT_STA, 0);
>>> +
>>> +		if (!pd_apc_con_reg || !pd_vio_shift_sta_reg)
>>> +			return;
>>> +
>>> +		/* Clear devapc violation status */
>>> +		writel(BIT(31), pd_apc_con_reg);
>>> +
>>> +		/* Clear violation shift status */
>>> +		vio_shift_sta = readl(pd_vio_shift_sta_reg);
>>> +		if (vio_shift_sta)
>>> +			writel(vio_shift_sta, pd_vio_shift_sta_reg);
>>> +
>>> +		/* Clear slave violation status */
>>> +		for (i = 0; i < ndevices[slave_type].vio_slave_num; i++) {
>>> +			vio_idx = device_info[slave_type][i].vio_index;
>>> +
>>> +			clear_vio_status(devapc_ctx, slave_type, vio_idx);
>>> +
>>> +			mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static int mt6779_devapc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device_node *node = pdev->dev.of_node;
>>> +	struct mtk_devapc_context *devapc_ctx;
>>> +	struct clk *devapc_infra_clk;
>>> +	u32 devapc_irq;
>>> +	int ret;
>>> +
>>> +	if (IS_ERR(node))
>>> +		return -ENODEV;
>>> +
>>> +	devapc_ctx = devm_kzalloc(&pdev->dev, sizeof(struct mtk_devapc_context),
>>> +				  GFP_KERNEL);
>>> +	if (!devapc_ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	devapc_ctx->vio_info = devm_kzalloc(&pdev->dev,
>>> +					    sizeof(struct mtk_devapc_vio_info),
>>> +					    GFP_KERNEL);
>>> +	if (!devapc_ctx->vio_info)
>>> +		return -ENOMEM;
>>> +
>>> +	devapc_ctx->devapc_pd_base[0] = of_iomap(node, 0);
>>
>> No array needed, we only have one element...
> 
> Ditto.
> 
>>
>>> +	if (!devapc_ctx->devapc_pd_base[0])
>>> +		return -EINVAL;
>>> +
>>> +	devapc_irq = irq_of_parse_and_map(node, 0);
>>> +	if (!devapc_irq)
>>> +		return -EINVAL;
>>> +
>>> +	devapc_infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
>>> +
>>
>> No new line here, please check conding style and apply to all the code.
> 
> Yes, I'll fix it.
> 
>>
>>> +	if (IS_ERR(devapc_infra_clk))
>>> +		return -EINVAL;
>>> +
>>> +	if (clk_prepare_enable(devapc_infra_clk))
>>> +		return -EINVAL;
>>> +
>>> +	start_devapc(devapc_ctx);
>>> +
>>> +	ret = devm_request_irq(&pdev->dev, devapc_irq,
>>> +			       (irq_handler_t)devapc_violation_irq,
>>> +			       IRQF_TRIGGER_NONE, "devapc", devapc_ctx);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mt6779_devapc_remove(struct platform_device *dev)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id mt6779_devapc_dt_match[] = {
>>> +	{ .compatible = "mediatek,mt6779-devapc" },
>>> +	{},
>>> +};
>>> +
>>> +static struct platform_driver mt6779_devapc_driver = {
>>> +	.probe = mt6779_devapc_probe,
>>> +	.remove = mt6779_devapc_remove,
>>> +	.driver = {
>>> +		.name = KBUILD_MODNAME,
>>> +		.of_match_table = mt6779_devapc_dt_match,
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(mt6779_devapc_driver);
>>> +
>>> +MODULE_DESCRIPTION("Mediatek MT6779 Device APC Driver");
>>> +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/soc/mediatek/devapc/devapc-mt6779.h b/drivers/soc/mediatek/devapc/devapc-mt6779.h
>>> new file mode 100644
>>> index 0000000..8c0e4e7
>>> --- /dev/null
>>> +++ b/drivers/soc/mediatek/devapc/devapc-mt6779.h
>>> @@ -0,0 +1,99 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020 MediaTek Inc.
>>> + */
>>> +
>>> +#ifndef __DEVAPC_MT6779_H__
>>> +#define __DEVAPC_MT6779_H__
>>> +
>>> +#define PFX			"[DEVAPC]: "
>>> +#define MOD_NM_IN_1_DEVAPC	16
>>> +
>>> +enum DEVAPC_SLAVE_TYPE {
>>> +	SLAVE_TYPE_INFRA = 0,
>>> +	SLAVE_TYPE_NUM,
>>> +};
>>> +
>>> +enum DEVAPC_PD_REG_TYPE {
>>> +	VIO_MASK = 0,
>>> +	VIO_STA,
>>> +	VIO_DBG0,
>>> +	VIO_DBG1,
>>> +	APC_CON,
>>> +	VIO_SHIFT_STA,
>>> +	VIO_SHIFT_SEL,
>>> +	VIO_SHIFT_CON,
>>> +	PD_REG_TYPE_NUM,
>>> +};
>>> +
>>> +enum DEVAPC_VIO_MASK_STA_NUM {
>>> +	VIO_MASK_STA_NUM_INFRA = 17,
>>
>> #define instead of enum
> 
> Okay, I'll fix it. Put it into DT data might be better way.
> 
>>
>>> +};
>>> +
>>> +enum DEVAPC_VIO_SLAVE_NUM {
>>> +	VIO_SLAVE_NUM_INFRA = 499,
>>
>> #define instead of enum.
>>
> 
> Ditto.
> 
>>> +};
>>> +
>>> +enum DEVAPC_PD_OFFSET {
>>> +	PD_VIO_MASK_OFFSET = 0x0,
>>> +	PD_VIO_STA_OFFSET = 0x400,
>>> +	PD_VIO_DBG0_OFFSET = 0x900,
>>> +	PD_VIO_DBG1_OFFSET = 0x904,
>>> +	PD_APC_CON_OFFSET = 0xF00,
>>> +	PD_SHIFT_STA_OFFSET = 0xF10,
>>> +	PD_SHIFT_SEL_OFFSET = 0xF14,
>>> +	PD_SHIFT_CON_OFFSET = 0xF20,
>>
>> #define instead of enum
>> I think this should be part of mtk_device_info on a per SoC base (provided via
>> DT data).
>>
> 
> Ditto.
> 
>>> +};
>>> +
>>> +struct mtk_device_num {
>>> +	int slave_type;
>>> +	u32 vio_slave_num;
>>> +};
>>> +
>>> +struct mtk_devapc_vio_info {
>>> +	bool read;
>>> +	bool write;
>>> +	u32 vio_addr;
>>> +	u32 vio_addr_high;
>>> +	u32 master_id;
>>> +	u32 domain_id;
>>> +};
>>> +
>>> +struct mtk_infra_vio_dbg_desc {
>>> +	u32 vio_dbg_mstid;
>>> +	u8 vio_dbg_mstid_start_bit;
>>> +	u32 vio_dbg_dmnid;
>>> +	u8 vio_dbg_dmnid_start_bit;
>>> +	u32 vio_dbg_w_vio;
>>> +	u8 vio_dbg_w_vio_start_bit;
>>> +	u32 vio_dbg_r_vio;
>>> +	u8 vio_dbg_r_vio_start_bit;
>>> +	u32 vio_addr_high;
>>> +	u8 vio_addr_high_start_bit;
>>> +};
>>> +
>>> +struct mtk_device_info {
>>> +	int sys_index;
>>> +	int ctrl_index;
>>> +	int vio_index;
>>
>> A quick check showed me that the vio_index == the index in the array. Drop it.
>>
> 
> No, vio_index is different from index of the array.
> 
>>> +};
>>> +
>>> +struct mtk_devapc_context {
>>> +	void __iomem *devapc_pd_base[SLAVE_TYPE_NUM];
>>> +	const struct mtk_device_info *device_info[SLAVE_TYPE_NUM];
>>> +	struct mtk_devapc_vio_info *vio_info;
>>> +};
>>> +
>>> +/* For Infra VIO_DBG */
>>> +#define INFRA_VIO_DBG_MSTID			0x0000FFFF
>>> +#define INFRA_VIO_DBG_MSTID_START_BIT		0
>>> +#define INFRA_VIO_DBG_DMNID			0x003F0000
>>> +#define INFRA_VIO_DBG_DMNID_START_BIT		16
>>> +#define INFRA_VIO_DBG_W_VIO			0x00400000
>>> +#define INFRA_VIO_DBG_W_VIO_START_BIT		22
>>> +#define INFRA_VIO_DBG_R_VIO			0x00800000
>>> +#define INFRA_VIO_DBG_R_VIO_START_BIT		23
>>> +#define INFRA_VIO_ADDR_HIGH			0x0F000000
>>> +#define INFRA_VIO_ADDR_HIGH_START_BIT		24
>>> +
>>> +#endif /* __DEVAPC_MT6779_H__ */
>>>
> 

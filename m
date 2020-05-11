Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DD5C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1385C206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hxY1wVVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgEKUCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:02:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:02:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BK2YDk093707;
        Mon, 11 May 2020 15:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589227354;
        bh=Nbw5S0nlz0IKqlpjtqgO4SfYIFZYmYYUYfxzJYCueho=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hxY1wVVJO5z5aZxvXkJSUzcJhaNnifY0kKqtoUzkl1UOvKMYihMunyLW01a5tpHZ+
         ojxi/JN+ILiZGZ9qEzt436nONhUj7OQJ/7gksDH49CFYNMGZwoaokNSGLqydTi32OT
         epDzLdBtBEs3pqkAi1ueD/bG4FFvhM/BHtlYnF/I=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BK2Y7p008391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 15:02:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 15:02:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 15:02:34 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BK2V0L119216;
        Mon, 11 May 2020 15:02:31 -0500
Subject: Re: [PATCH v3 2/2] soc: ti: add k3 platforms chipid module driver
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        DTML <devicetree@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <20200508100100.20740-1-grygorii.strashko@ti.com>
 <20200508100100.20740-3-grygorii.strashko@ti.com>
 <CAK8P3a0vewSiFc4rXu43_bs_A85EYx12_YuyBaU3PYJ1HszE=w@mail.gmail.com>
 <6614f29d-1796-18d9-9b78-214f56964a35@ti.com>
 <CAK8P3a19RC1hPZkLiGCEHFuHDNxNLiAg34RdbBZ=gxDhRg4RpA@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <71c11d42-9645-7b93-9cf3-3139d35befc9@ti.com>
Date:   Mon, 11 May 2020 23:02:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a19RC1hPZkLiGCEHFuHDNxNLiAg34RdbBZ=gxDhRg4RpA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 11/05/2020 15:43, Arnd Bergmann wrote:
> On Mon, May 11, 2020 at 1:11 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>> Hi Arnd,
>>
>> On 09/05/2020 01:17, Arnd Bergmann wrote:
>>> On Fri, May 8, 2020 at 12:01 PM Grygorii Strashko
>>> <grygorii.strashko@ti.com> wrote:
>>>
>>>> +static int __init k3_chipinfo_init(void)
>>>> +{
>>>> +       struct soc_device_attribute *soc_dev_attr;
>>>> +       struct soc_device *soc_dev;
>>>> +       struct device_node *node;
>>>> +       struct regmap *regmap;
>>>> +       u32 partno_id;
>>>> +       u32 variant;
>>>> +       u32 jtag_id;
>>>> +       u32 mfg;
>>>> +       int ret;
>>>> +
>>>> +       node = of_find_compatible_node(NULL, NULL, "ti,am654-chipid");
>>>> +       if (!node)
>>>> +               return -ENODEV;
>>>
>>> This will fail the initcall and print a warning when the kernel runs on any
>>> other SoC. Would it be possible to just make this a platform_driver?
>>>
>>> If not, I think you should silently return success when the device
>>> node is absent.
>>
>> Thank you for your report.
>> Can' make it platform drv., as the SoC info need to be accessible by divers early.
> 
> Which drivers in particular? In most cases you should be able to still do this
> right by relying on initcall ordering as long as this one can only be built-in
> (or possibly only a module for compile-testing).

Thanks for you review.

As I'm aware of right now, it's going to be: ringacc, dma, net drv and mmc.
So, It seems should work with platform_driver and subsys_initcall.
I'll try it.

-- 
Best regards,
grygorii

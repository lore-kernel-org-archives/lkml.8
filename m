Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34167C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1386320829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UFeyzBSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgG3Aan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgG3Aan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:30:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5473C061794;
        Wed, 29 Jul 2020 17:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=k3VcDycZsXhB43FKH6fx87shOxXnFVYdJfbp6APBdDY=; b=UFeyzBSwMc1lvdJ0bDk0iTuqcz
        UHJWHWlbmXpFKA1iGKIt3GH2vaJFIXmiEB4Fw28Ic75EcDi4/NWotnnSCiaQOcohUqg861nmoS8xH
        iukPNVGFZvGlVb9C3bFrDSKadBS6dAoxms+5AgtCn6r+J7piWLatep6aABbsvD08wMKIWX0bWkIQw
        aTIES75hu+r0pe9szSDYzGKjRTHA8G11Fyea65331ppWsAuu28Yupi5itfphg3hdC7ramQdEXQ4iT
        skKLOtVKMr2dyQ68ALn8c2Xx8qU9geiFac2CCX+ffSe0nkRaNo9xk4OqJW2iVNLA/fStIlvHWWZaG
        j1chOjXg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0wSv-0006h9-Hu; Thu, 30 Jul 2020 00:30:35 +0000
Subject: Re: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
 32-bit value by 31 bits
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com>
 <1596034117-24246-2-git-send-email-Anson.Huang@nxp.com>
 <86ae1d4e-27c9-07e4-73be-37d490cb0063@infradead.org>
 <DB3PR0402MB3916559F7E1908D76B47FE66F5700@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <34161e5c-0e83-97de-3cb6-1040d8abdc71@infradead.org>
Date:   Wed, 29 Jul 2020 17:30:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916559F7E1908D76B47FE66F5700@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 4:51 PM, Anson Huang wrote:
> Hi, Randy
> 
> 
>> Subject: Re: [PATCH V7 1/6] clk: imx6sl: Use BIT(x) to avoid shifting signed
>> 32-bit value by 31 bits
>>
>> On 7/29/20 7:48 AM, Anson Huang wrote:
>>> Use readl_relaxed() instead of __raw_readl(), and use BIT(x) instead
>>> of (1 << X) to fix below build warning reported by kernel test robot:
>>>
>>> drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
>>> value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>>>      while (!(__raw_readl(anatop_base + PLL_ARM) &
>> BM_PLL_ARM_LOCK))
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> ---
>>> Changes since V6:
>>> 	- improve the subject.
>>> ---
>>>  drivers/clk/imx/clk-imx6sl.c | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/clk/imx/clk-imx6sl.c
>>> b/drivers/clk/imx/clk-imx6sl.c index 0f647d1..e69dba1 100644
>>> --- a/drivers/clk/imx/clk-imx6sl.c
>>> +++ b/drivers/clk/imx/clk-imx6sl.c
>>> @@ -3,6 +3,7 @@
>>>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
>>>   */
>>>
>>> +#include <linux/bitfield.h>
>>
>> Hi,
>> I think you want
>> #include <linux/bits.h>
>>
>> for BIT() usage.
> 
> Actually, the linux/of.h already includes linux/bitops.h and linux/bitops.h includes
> linux/bits.h, so I will just drop linux/bitfield.h and send a V8.

or you could read Documentation/process/submit-checklist.rst,
where rule #1 says:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


-- 
~Randy


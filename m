Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87506C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792BA206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD0UAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:00:54 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48608 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgD0UAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:00:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 499wcw00Whz1s0RZ;
        Mon, 27 Apr 2020 22:00:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 499wcv5FBWz1r5QD;
        Mon, 27 Apr 2020 22:00:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UwhZWkhUHdp5; Mon, 27 Apr 2020 22:00:45 +0200 (CEST)
X-Auth-Info: JMpryoad1q4gMYykW9V1aNyztGd9wWfmqkL03f1OojI=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 27 Apr 2020 22:00:45 +0200 (CEST)
Subject: Re: [PATCH v2 04/12] mtd: rawnand: stm32_fmc2: manage all errors
 cases at probe time
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Christophe Kerello <christophe.kerello@st.com>, richard@nod.at,
        vigneshr@ti.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-5-git-send-email-christophe.kerello@st.com>
 <20200427194747.224a2402@xps13>
 <40a9bac7-9ed4-b781-f2c2-2d90b4e82749@denx.de>
 <20200427200848.722f4c56@xps13>
From:   Marek Vasut <marex@denx.de>
Message-ID: <3527f3b8-225d-6e5a-dd8a-0421d475f70b@denx.de>
Date:   Mon, 27 Apr 2020 21:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427200848.722f4c56@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 8:08 PM, Miquel Raynal wrote:
[...]
>>>>  	/* FMC2 init routine */
>>>>  	stm32_fmc2_init(fmc2);
>>>> @@ -1997,7 +2001,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>>>  	/* Scan to find existence of the device */
>>>>  	ret = nand_scan(chip, nand->ncs);
>>>>  	if (ret)
>>>> -		goto err_scan;
>>>> +		goto err_dma_setup;
>>>>  
>>>>  	ret = mtd_device_register(mtd, NULL, 0);
>>>>  	if (ret)
>>>> @@ -2010,7 +2014,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>>>  err_device_register:
>>>>  	nand_cleanup(chip);
>>>>  
>>>> -err_scan:
>>>> +err_dma_setup:
>>>>  	if (fmc2->dma_ecc_ch)
>>>>  		dma_release_channel(fmc2->dma_ecc_ch);
>>>>  	if (fmc2->dma_tx_ch)
>>>> @@ -2021,6 +2025,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>>>  	sg_free_table(&fmc2->dma_data_sg);
>>>>  	sg_free_table(&fmc2->dma_ecc_sg);
>>>>  
>>>> +err_clk_disable:
>>>>  	clk_disable_unprepare(fmc2->clk);
>>>>  
>>>>  	return ret;  
>>>
>>> I didn't spot it during my earlier reviews but I really prefer using
>>> labels explaining what you do than having the same name of the function
>>> which failed. This way you don't have to rework the error path when
>>> you handle an additional error.
>>>
>>> So, would you mind doing this in two steps:
>>>
>>> 1/
>>> Replace
>>>
>>>     err_scan:
>>>
>>> with, eg.
>>>
>>>     release_dma_objs:  
>>
>> The ^err_ prefix in failpath labels is useful, since it's easily
>> possible to match on it with regexes ; not so much on arbitrary label name.
> 
> I guess so, but is it actually useful to catch labels in a regex? (real
> question)

I find it useful to have a unified way to find those labels, e.g.
err_because_foo:
err_because_bar:
err_last_one:
is much nicer than:
foo_failed:
bar_also_failed:
its_total_randomness:

> Any way I suppose catching ":\n" is already a good approximation to
> find labels?

Not very practical with git grep (^err.*: works nicely though)

>> btw would it make sense to split the first three patches of this series
>> into a separate series ? This rawnand part seems more like an unrelated
>> cleanup.
> 
> As it seems that the MFD discussion can take longer, then I would say
> yes, at least for the cleanup/misc changes part.
Right

-- 
Best regards,
Marek Vasut

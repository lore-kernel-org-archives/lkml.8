Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC2C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70EB20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgD0R7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:59:43 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41022 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgD0R7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:59:42 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 499sx50vRCz1qsjt;
        Mon, 27 Apr 2020 19:59:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 499sx46dKXz1r5Pw;
        Mon, 27 Apr 2020 19:59:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cP7Ci3_fzOg3; Mon, 27 Apr 2020 19:59:35 +0200 (CEST)
X-Auth-Info: 3Q/kzkEfkeKb3xddfAmFowML8Maab4nXQx8zhUFn5rA=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 27 Apr 2020 19:59:35 +0200 (CEST)
Subject: Re: [PATCH v2 04/12] mtd: rawnand: stm32_fmc2: manage all errors
 cases at probe time
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Christophe Kerello <christophe.kerello@st.com>
Cc:     richard@nod.at, vigneshr@ti.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-5-git-send-email-christophe.kerello@st.com>
 <20200427194747.224a2402@xps13>
From:   Marek Vasut <marex@denx.de>
Message-ID: <40a9bac7-9ed4-b781-f2c2-2d90b4e82749@denx.de>
Date:   Mon, 27 Apr 2020 19:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427194747.224a2402@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 7:47 PM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
> 2020 17:57:28 +0200:
> 
>> This patch defers its probe when the expected reset control is not
>> yet ready. This patch also handles properly all errors cases at probe
>> time.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
>>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> index b6d45cd..0a96797 100644
>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>> @@ -1967,7 +1967,11 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	rstc = devm_reset_control_get(dev, NULL);
>> -	if (!IS_ERR(rstc)) {
>> +	if (IS_ERR(rstc)) {
>> +		ret = PTR_ERR(rstc);
>> +		if (ret == -EPROBE_DEFER)
>> +			goto err_clk_disable;
>> +	} else {
>>  		reset_control_assert(rstc);
>>  		reset_control_deassert(rstc);
>>  	}
>> @@ -1975,7 +1979,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>  	/* DMA setup */
>>  	ret = stm32_fmc2_dma_setup(fmc2);
>>  	if (ret)
>> -		return ret;
>> +		goto err_dma_setup;
>>  
>>  	/* FMC2 init routine */
>>  	stm32_fmc2_init(fmc2);
>> @@ -1997,7 +2001,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>  	/* Scan to find existence of the device */
>>  	ret = nand_scan(chip, nand->ncs);
>>  	if (ret)
>> -		goto err_scan;
>> +		goto err_dma_setup;
>>  
>>  	ret = mtd_device_register(mtd, NULL, 0);
>>  	if (ret)
>> @@ -2010,7 +2014,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>  err_device_register:
>>  	nand_cleanup(chip);
>>  
>> -err_scan:
>> +err_dma_setup:
>>  	if (fmc2->dma_ecc_ch)
>>  		dma_release_channel(fmc2->dma_ecc_ch);
>>  	if (fmc2->dma_tx_ch)
>> @@ -2021,6 +2025,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
>>  	sg_free_table(&fmc2->dma_data_sg);
>>  	sg_free_table(&fmc2->dma_ecc_sg);
>>  
>> +err_clk_disable:
>>  	clk_disable_unprepare(fmc2->clk);
>>  
>>  	return ret;
> 
> I didn't spot it during my earlier reviews but I really prefer using
> labels explaining what you do than having the same name of the function
> which failed. This way you don't have to rework the error path when
> you handle an additional error.
> 
> So, would you mind doing this in two steps:
> 
> 1/
> Replace
> 
>     err_scan:
> 
> with, eg.
> 
>     release_dma_objs:

The ^err_ prefix in failpath labels is useful, since it's easily
possible to match on it with regexes ; not so much on arbitrary label name.

btw would it make sense to split the first three patches of this series
into a separate series ? This rawnand part seems more like an unrelated
cleanup.

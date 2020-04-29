Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8A2C83008
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8BB2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Q/iE+AzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD2JmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:42:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48449 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgD2JmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:42:04 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T9cVTx011957;
        Wed, 29 Apr 2020 11:41:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Y6cvWswz1Mzq73LWAYc3OJKVnI3lC/DlwlbZJw8qHzA=;
 b=Q/iE+AzML7Uf13ArJzgtnO7um7NTj07VGlQLwmZt2apTXJFOzOonUxcQHeLWc/armZpR
 NOsLWuDH2sRfcHH6MKYhSAErZn5Z0uK8GZTo5nML52v/UowfkHi23A4ymp76APRS3u+i
 JXOwzucflb0kgQT8z/z2e99xWSnqt8yFMLNj68vAO6mTpWspmLOV0ZT9XcXFnRpZ3XGZ
 rfUFx8KiUJit3JlZPQ+8SxK9COW8erjCXdcQOKOXAegkv/f+1ZkLFqcwKwEsZkg74kTK
 YXcpXvR4eYtBErI22ocWNQbmjv1neMXRB87rEObcq8ww1h5tQBQfInxDWo8pC9A2qJfr Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhcc5fhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 11:41:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D80C510002A;
        Wed, 29 Apr 2020 11:41:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B97F820B1C5;
        Wed, 29 Apr 2020 11:41:46 +0200 (CEST)
Received: from [10.211.9.35] (10.75.127.46) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Apr
 2020 11:41:45 +0200
Subject: Re: [PATCH v2 06/12] mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS
 for timeouts
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-7-git-send-email-christophe.kerello@st.com>
 <20200427202212.0235d987@xps13> <0e2c9a6a-aa21-7814-9af8-629de6568fab@st.com>
 <20200429113529.5ddc3ad9@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <b6b31f36-8e8f-4042-2587-0dcad82aafc5@st.com>
Date:   Wed, 29 Apr 2020 11:41:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200429113529.5ddc3ad9@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_03:2020-04-28,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/20 11:35 AM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 29 Apr
> 2020 11:27:43 +0200:
> 
>> Hi Miquèl,
>>
>> On 4/27/20 8:22 PM, Miquel Raynal wrote:
>>> Hi Christophe,
>>>
>>> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
>>> 2020 17:57:30 +0200:
>>>    
>>>> This patch removes the constant FMC2_TIMEOUT_US.
>>>> FMC2_TIMEOUT_MS is set to 5 seconds and this constant is used
>>>> each time that we need to wait (except when the timeout value
>>>> is set by the framework)
>>>>
>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>>> ---
>>>>    drivers/mtd/nand/raw/stm32_fmc2_nand.c | 11 +++++------
>>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>> index ab53314..f159c39 100644
>>>> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
>>>> @@ -37,8 +37,7 @@
>>>>    /* Max ECC buffer length */
>>>>    #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)
>>>>    >> -#define FMC2_TIMEOUT_US			1000
>>>> -#define FMC2_TIMEOUT_MS			1000
>>>> +#define FMC2_TIMEOUT_MS			5000
>>>>    >>   /* Timings */
>>>>    #define FMC2_THIZ			1
>>>> @@ -525,9 +524,9 @@ static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
>>>>    	u32 sr, heccr;
>>>>    	int ret;
>>>>    >> -	ret = readl_relaxed_poll_timeout(fmc2->io_base + FMC2_SR,
>>>> -					 sr, sr & FMC2_SR_NWRF, 10,
>>>> -					 FMC2_TIMEOUT_MS);
>>>> +	ret = readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR,
>>>> +						sr, sr & FMC2_SR_NWRF, 1,
>>>> +						1000 * FMC2_TIMEOUT_MS);
>>>
>>> Is the _atomic suffix needed here? If yes it would deserve a separate
>>> patch with Fixes/Stable tags.
>>>    
>>
>> I have currently not seen any issues. So, I will remove this modification as we will move to regmap_read_poll_timeout in patch 10.
>>
>>>>    	if (ret) {
>>>>    		dev_err(fmc2->dev, "ham timeout\n");
>>>>    		return ret;
>>>> @@ -1315,7 +1314,7 @@ static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
>>>>    	/* Check if there is no pending requests to the NAND flash */
>>>>    	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
>>>>    					      sr & FMC2_SR_NWRF, 1,
>>>> -					      FMC2_TIMEOUT_US))
>>>> +					      1000 * FMC2_TIMEOUT_MS))
>>>>    		dev_warn(fmc2->dev, "Waitrdy timeout\n");
>>>>    >>   	/* Wait tWB before R/B# signal is low */
>>>
>>> You change the timeouts from 1ms to 5s.
>>>
>>> Maybe 5s is a little bit too much IMHO but we don't really care as this
>>> is a timeout. However 1ms is tight. If you are changing this value
>>> because it triggers error (eg. when the machine is loaded), then it is
>>> a fix and should appear like it.
>>>
>>> Thanks,
>>> Miquèl
>>>    
>>
>> No errors currently happens.
>> During our stress tests, in a overloaded system, we have seen that we could be close to 1 second, even if we never met this value.
>> So, to be safe, I have set this timeout to 5 seconds.
>> As it is just a timeout value, I have not seen any side effect.
>> I am using the same timeout constant to avoid to have one timeout per cases.
> 
> Something is wrong in my mind:
> You say you observe delays of almost up to 1 second, but the polling
> currently happens on 1000 us = 1ms, either you had timeouts or I
> misread something?
> 
> Thanks,
> Miquèl
> 

Hi Miquèl,

My fault. For this polling, we never met 1 ms.
The 1 second observed was on the sequencer when we read/write a page (as 
it the same timeout value that is used)

Regards,
Christophe Kerello.

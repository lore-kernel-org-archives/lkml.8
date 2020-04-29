Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A05C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B113C20775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Na+Wj74z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgD2Jb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:31:29 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11630 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:31:28 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T9QQA7009878;
        Wed, 29 Apr 2020 11:31:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=DRjQYztleGVSiDwTizC2lxz1DCDBXrRlNa50jKUHHJc=;
 b=Na+Wj74zfR2NIBXfPk/efWyfHb+B7utgS3kgr6bnLeGH3k+bB3soaIG7zA3YhDiXZP1S
 s3gPfT4pA3WHL+dhLEEh/dVakow4UAXkG2RtytHlC3cxF12fK7ISJb1C8NkvBzcQaOoq
 NTsNQE62FcpzG7mABhYo5lekMkFJS+sJtfZMNbdt6hdR/yM2OJe2SdPs9CldkARVdU6f
 5CZNnznzgnlHQjK7yuCLOw2aN1cf1LiaYX5mXAs/NdvQRsQzqG4ERNeR/4KqIFXNfbiX
 20+pC7ySrt7TMAdTYDkAQchy7dAnR49j0rCsxvsKwy4yuE7ltYSBeXFv8OZuGmF2eele HQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhq65djh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 11:31:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0BD1710002A;
        Wed, 29 Apr 2020 11:31:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E6209207570;
        Wed, 29 Apr 2020 11:31:09 +0200 (CEST)
Received: from [10.211.9.35] (10.75.127.44) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Apr
 2020 11:31:08 +0200
Subject: Re: [PATCH v2 07/12] mtd: rawnand: stm32_fmc2: cleanup
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-8-git-send-email-christophe.kerello@st.com>
 <20200427203314.798b3c4e@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <bb4a6377-2cbd-f990-0c55-cb393292aee9@st.com>
Date:   Wed, 29 Apr 2020 11:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200427203314.798b3c4e@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_03:2020-04-28,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On 4/27/20 8:33 PM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
> 2020 17:57:31 +0200:
> 
>> This patch renames functions and local variables to be ready to use
>> stm32_fmc2 structure.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
> 
>> -static int stm32_fmc2_setup_interface(struct nand_chip *chip, int chipnr,
>> -				      const struct nand_data_interface *conf)
>> +static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>> +					  const struct nand_data_interface *cf)
> 
> I suppose you s/conf/cf/ because of the 80 chars boundary. In this case
> I don't mind crossing it, I don't think it is better to rename the
> conf parameter for this reason.
> 

Yes, you are right. I have modified it because of 80 chars boundary.
I will keep conf in v3.

>>   {
>>   	const struct nand_sdr_timings *sdrt;
>>   
>> -	sdrt = nand_get_sdr_timings(conf);
>> +	sdrt = nand_get_sdr_timings(cf);
>>   	if (IS_ERR(sdrt))
>>   		return PTR_ERR(sdrt);
>>   
>>   	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>>   		return 0;
>>   
>> -	stm32_fmc2_calc_timings(chip, sdrt);
>> -	stm32_fmc2_timings_init(chip);
>> +	stm32_fmc2_nfc_calc_timings(chip, sdrt);
>> +	stm32_fmc2_nfc_timings_init(chip);
>>   
>>   	return 0;
>>   }
>>   
> 
> [...]
> 
>>   
>> -static struct platform_driver stm32_fmc2_driver = {
>> -	.probe	= stm32_fmc2_probe,
>> -	.remove	= stm32_fmc2_remove,
>> +static struct platform_driver stm32_fmc2_nfc_driver = {
>> +	.probe	= stm32_fmc2_nfc_probe,
>> +	.remove	= stm32_fmc2_nfc_remove,
>>   	.driver	= {
>> -		.name = "stm32_fmc2_nand",
>> -		.of_match_table = stm32_fmc2_match,
>> -		.pm = &stm32_fmc2_pm_ops,
>> +		.name = "stm32_fmc2_nfc",
>> +		.of_match_table = stm32_fmc2_nfc_match,
>> +		.pm = &stm32_fmc2_nfc_pm_ops,
>>   	},
>>   };
>> -module_platform_driver(stm32_fmc2_driver);
>> +module_platform_driver(stm32_fmc2_nfc_driver);
>>   
>> -MODULE_ALIAS("platform:stm32_fmc2_nand");
>> +MODULE_ALIAS("platform:stm32_fmc2_nfc");
>>   MODULE_AUTHOR("Christophe Kerello <christophe.kerello@st.com>");
>> -MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 nand driver");
>> +MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 nfc driver");
> 
> I would prefer: s/nfc/NFC/ here please.
> 

It will be modified in v3.

Regards,
Christophe Kerello.

>>   MODULE_LICENSE("GPL v2");
> 
> With these two nits,
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl
> 

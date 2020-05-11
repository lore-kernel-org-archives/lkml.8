Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132DAC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E79207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RV1hQdYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEKMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:47:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48752 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgEKMrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:47:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BCgaSN000396;
        Mon, 11 May 2020 14:47:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=q1p+Flxy4LUjmNbbMr/xBwFdwk21NI1E4pInfOilbgA=;
 b=RV1hQdYSrj2zbLFttnfrnSqexDNAj/rQjhPSvvQ95lXBkVuQg1ZD9RKlV+1lJtWwMrTZ
 J0S+OO7GEvSjx4SncBS6TWYvGPLgLBti2qCVz+e8apP95MukPQN2EKHCXI/wU92Gh6uU
 AT2E8FvmXviqWufcpbA3V9MYEpPivjiD3kbDEQ+Eq4BHfs4STtRE4RtT1ad733W+qWh/
 iH0CPNiBYIZUc9AzdK+hrwqi5bSa0KiFozXMx93oMgCXbQt2MaB5FSe2w2Gt848oez1X
 /22NZiT3pHq/81ktr36J1z8ydvItor0+xGEqJbeDxgVi6JIVvminPNjq0DQtok42gngV Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30wkdgt30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 14:47:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CBBCF10002A;
        Mon, 11 May 2020 14:47:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ADEBB2B5E8D;
        Mon, 11 May 2020 14:47:11 +0200 (CEST)
Received: from [10.211.5.64] (10.75.127.49) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 May
 2020 14:47:10 +0200
Subject: Re: [PATCH v4 10/10] mtd: rawnand: stm32_fmc2: get resources from
 parent node
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <1588756279-17289-11-git-send-email-christophe.kerello@st.com>
 <20200511111855.48216940@xps13> <3377adc6-3e5e-b9b7-12be-c7aa44bfac82@st.com>
 <20200511135926.3e5c622d@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <0c704fea-f2a6-2cec-8741-d322acf6afd5@st.com>
Date:   Mon, 11 May 2020 14:47:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200511135926.3e5c622d@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 5/11/20 1:59 PM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Mon, 11 May
> 2020 12:21:03 +0200:
> 
>> Hi Miquel,
>>
>> On 5/11/20 11:18 AM, Miquel Raynal wrote:
>>> Hi Christophe,
>>>
>>> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
>>> 11:11:19 +0200:
>>>    
>>>> FMC2 EBI support has been added. Common resources (registers base
>>>> and clock) are now shared between the 2 drivers. It means that the
>>>> common resources should now be found in the parent device when EBI
>>>> node is available.
>>>>
>>>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>>>> ---
>>>
>>> [...]
>>>    
>>>> +
>>>> +static bool stm32_fmc2_nfc_check_for_parent(struct platform_device *pdev)
>>>> +{
>>>> +	u32 i;
>>>> +	int nb_resources = 0;
>>>> +
>>>> +	/* Count the number of resources in reg property */
>>>> +	for (i = 0; i < pdev->num_resources; i++) {
>>>> +		struct resource *res = &pdev->resource[i];
>>>> +
>>>> +		if (resource_type(res) == IORESOURCE_MEM)
>>>> +			nb_resources++;
>>>> +	}
>>>> +
>>>> +	/* Each CS needs 3 resources defined (data, cmd and addr) */
>>>> +	if (nb_resources % 3)
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>
>>> This function looks fragile. Why not just checking the compatible
>>> string of the parent node?
>>>    
>>
>> Yes, it is another way to check that we have an EBI parent node.
>>
>> In this implementation, I was checking the number of reg tuples.
>> In case we have 6, it means that the register base address is defined in the parent node (EBI node).
>> In case we have 7, it means that the register base address is defined in the current node (NFC node).
> 
> Yes, I understand what you are doing, but I kind of dislike the logic.
> Relying on the number of reg tuples is something that can be done (I
> used it myself one time), but I think this is more a hack that you do
> when you have no other way to differentiate. I guess the proper way
> would be to look at the parent's compatible. If it matches what you
> expect, then you can store the dev->of_node->parent->dev somewhere in
> your controller's structure and then use it to initialize the clock and
> regmap. This way you don't have to move anything else in the probe path.
> 

OK, I will check the compatible string of the parent device using 
of_device_is_compatible API in v5.
In case of the parent is found, I will add it in the structure of the 
controller (dev_parent).
I will rely on this field only to get the common resources (the register 
base address and the clock) in the NFC node or in the EBI node.

Regards,
Christophe Kerello.

> 
> Thanks,
> Miquèl
> 

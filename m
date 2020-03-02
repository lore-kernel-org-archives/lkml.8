Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8904B2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="exSa+YIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgCBK3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:29:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49754 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgCBK3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:29:43 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022ANQDP005577;
        Mon, 2 Mar 2020 11:29:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=zkytL5nVEwPnsSSru/KymaDUr/ha+HwULMX9F6zIoyc=;
 b=exSa+YIJRpOznMWRg+X11gkj5wmZyPmRg08IYzfFup7xEtPRjr6hWuETdT4oWSeRj3gy
 wg3QhBQp7WTFiMxpDmBLYzfUI0Z4kea/DHRf82bFxgz48iJsg368pvRH6M0FBQQJNvm2
 0YtY1DCoULu5mT1lJ0lgrxwVHyC9zPpFuF/GYQlx5zjVBJ/TepQqiOoRZEw0lYD/5ZxJ
 /1s50RY+qf7NVfQdXBcYlsg6gkidy+IpOg0GatzRrm3hdSfJPdQ+5+F/QNciTNbLBRYc
 d/EGAvKYG+5A3T82naPax11ZVINz1N2f98HRIsLxjAIZH2hM78fSz8U2ZnViQc3sIiEi XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yffqpjscd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 11:29:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C81410002A;
        Mon,  2 Mar 2020 11:29:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 610342B881B;
        Mon,  2 Mar 2020 11:29:30 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Mar
 2020 11:29:29 +0100
Subject: Re: [PATCH 2/3] ARM: dts: stm32: add STM32MP1-based Linux Automation
 MC-1 board
To:     Lucas Stach <l.stach@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20200226143826.1146-1-a.fatoum@pengutronix.de>
 <20200226143826.1146-2-a.fatoum@pengutronix.de>
 <244a4502-03e0-836c-2ce2-7fa6cef3c188@st.com>
 <fbba971d7501c774ce0081f22dcff4ef74002a4d.camel@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e227de9a-7440-7e1f-2928-5648cbbe44c1@st.com>
Date:   Mon, 2 Mar 2020 11:29:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fbba971d7501c774ce0081f22dcff4ef74002a4d.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_03:2020-02-28,2020-03-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas

On 3/2/20 11:18 AM, Lucas Stach wrote:
> On Mo, 2020-03-02 at 11:06 +0100, Alexandre Torgue wrote:
>> Hi Ahmad
>>
>> Thanks for adding a new STM32 board. Some minor comments.
>>
>> On 2/26/20 3:38 PM, Ahmad Fatoum wrote:
>>> The Linux Automation MC-1 is a SBC built around the Octavo Systems
>>> OSD32MP15x SiP. The SiP features up to 1 GB DDR3 RAM, EEPROM and
>>> a PMIC. The board has eMMC and a SD slot for storage and GbE
>>> for both connectivity and power.
>>>
>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de
>>> ---
> [...]
>>> +
>>> +&gpu {
>>> +	status = "okay";
>>> +};
> 
> This question is more to the ST guys than this specific DT: Why is the
> GPU marked as disabled in the SoC dtsi file? This device is always
> present on the SoC and AFAICS there are no board level dependencies, so
> there is no reason to have it disabled by default, right? Removing the
> status property from the dtsi would remove the need for this override
> on the board DT.

You are right. With new stm32 device tree diversity, it makes no longer 
sens to disable GPU node in stm32mp157 dtsi file. Indeed, we use now 
dedicated files for each SoC (stm32mp151 / stm32mp153 /stm32mp157).

Ahmad, can you add this modification in your series please ?

regards
Alex


> 
> Regards,
> Lucas
> 

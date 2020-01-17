Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A97C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E016E2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="j8vTRWms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAQPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:25:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728780AbgAQPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:25:03 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HFMOt4010203;
        Fri, 17 Jan 2020 16:24:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=CJb3tob82/wP4pbaxou0kNBLJitRDfQp4z4aVDs/O7o=;
 b=j8vTRWms+edgNbGbpLlYd5xXj9xcYsGwu1eXYUayEEhuBGjRCMK2XmfQXbrWrxAEX44a
 ejNgmfJ1YVBLYxI/2PTzjtvBoJEdKrxGydRlYhvjphd5ojveOlQe91dSZ2vL4+k/4u4g
 ZlBsHHWvRo885uaTxUCophDiXcgKpoJ+b5qqGo3VLi/38UkD2/cSIGAAG1/3QqpWI9Mz
 fRelayznU5yA2zL3gkbhjWnll8wORSWKd4FE1E9urpSFs7f3HGrehTMpIdilWaME2fi9
 2IkbZ/Vm8ZJUT04YRVMJFZnFnQ43wPmft+jn/1LujJx9VcKPmHtZV8BMPMG1MIhdqL2A Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xk0rkc6hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jan 2020 16:24:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9F6910002A;
        Fri, 17 Jan 2020 16:24:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A97962C38DA;
        Fri, 17 Jan 2020 16:24:50 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 17 Jan
 2020 16:24:50 +0100
Subject: Re: [PATCHv2 1/2] dt-bindings: usb: dwc2: add support for STM32MP15
 SoCs USB OTG HS and FS
To:     Rob Herring <robh@kernel.org>
CC:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
References: <20200116144524.16070-1-amelie.delaunay@st.com>
 <20200116144524.16070-2-amelie.delaunay@st.com>
 <20200117144837.GA27455@bogus>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <5eca6d14-27d8-0ac9-5c4f-9e0bc40d7f93@st.com>
Date:   Fri, 17 Jan 2020 16:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117144837.GA27455@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_03:2020-01-16,2020-01-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 3:48 PM, Rob Herring wrote:
> On Thu, Jan 16, 2020 at 03:45:23PM +0100, Amelie Delaunay wrote:
>> Add the specific compatible string for the DWC2 IP found in the STM32MP15
>> SoCs.
>> STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
>> ID pin state. usb33d-supply described the regulator supplying Vbus and ID
>> sensing comparators.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
>> index 71cf7ba32237..0b86250b97a9 100644
>> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
>> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
>> @@ -58,6 +58,8 @@ properties:
>>         - const: st,stm32f4x9-fsotg
>>         - const: st,stm32f4x9-hsotg
>>         - const: st,stm32f7-hsotg
>> +      - const: st,stm32mp15-fsotg
>> +      - const: st,stm32mp15-hsotg
>>         - const: samsung,s3c6400-hsotg
>>   
>>     reg:
>> @@ -103,6 +105,10 @@ properties:
>>     vusb_a-supply:
>>       description: phandle to voltage regulator of analog section.
>>   
>> +  vusb33d_supply:
> 
> Not a valid regulator property.
> 

arrgh, was ok in the v1 in .txt. Will send a v3 fixing it with 
vusb33d-supply instead.

>> +    description: reference to the external VBUS and ID sensing comparators, in
>> +      order to perform OTG operation, used on STM32MP15 SoCs.
> 
> Are they external or part of the SoC? When we have Vbus sense and ID
> GPIOs, those go in the connector node, so this probably should too if
> these are board components.
> 

Yes, they are part of the SoC but external of the DWC2 IP. You can find 
them in the box "3V3 USB Detector" of PWR block diagram of STM32MP15x 
[1]. In OTG block diagram also, it corresponds to "OTG detection" box.
Behind this vusb33d supply, it is a regulator provided by PWR regulator 
driver. Maybe I should say "reference to the VBUS and ID sensing 
comparators *supply*.

[1] 
https://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/51/ba/9e/5e/78/5b/4b/dd/DM00327659/files/DM00327659.pdf/jcr:content/translations/en.DM00327659.pdf

Regards,
Amelie

> Rob
> 

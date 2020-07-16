Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE48C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C382074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DER8KaZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGPJUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:20:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28500 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgGPJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:20:48 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G9K6Dk012022;
        Thu, 16 Jul 2020 11:20:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=YYdEfJ7VryBj+oIRISl+0NE3XQm3xJF36O7Hxx33TUo=;
 b=DER8KaZgqXYt5QUIc87g+W9oYIbTIn83sSD4i0qGguy2ESL9oD2R2WZsxE/bYVL+29Qd
 wbyUSel97hEh2/DEJJYZRUNthWVqIPRKvovDSurABIXK4Olo1K1PshVG53lXUKc4RkcP
 cFHAqG3kFlwM4wn8Y5oImbyLjpsRNE5yLF8l4wlSaaQWx8sg9fI5H96b7K16ZPZmoiHi
 UUi/vkX6jl9MKfeSLVoXBsAA9zaXIUdh4MaMIWsiMhCQ+T8vjQNyrYsfAQXRmytyFN2W
 3qveZEdYGAkz57tzoQoFTMfsjldkJglAX7qiRv6aYOra4qIOm8cLz7f/bQVY7sMX7XJ6 0A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 327btt1asu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 11:20:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7BE7510002A;
        Thu, 16 Jul 2020 11:20:28 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5976F2AD9EB;
        Thu, 16 Jul 2020 11:20:28 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 16 Jul
 2020 11:20:27 +0200
Subject: Re: [PATCH 1/6] dt-bindings: connector: add power-opmode optional
 property to usb-connector
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
References: <20200615161512.19150-1-amelie.delaunay@st.com>
 <20200615161512.19150-2-amelie.delaunay@st.com>
 <20200715181916.GA551920@bogus>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <f186558e-210c-ff11-29e0-fc653d4b865b@st.com>
Date:   Thu, 16 Jul 2020 11:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715181916.GA551920@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_05:2020-07-16,2020-07-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/15/20 8:19 PM, Rob Herring wrote:
> On Mon, Jun 15, 2020 at 06:15:07PM +0200, Amelie Delaunay wrote:
>> Power operation mode may depends on hardware design, so, add the optional
>> property power-opmode for usb-c connector to select the power operation
>> mode capability.
>> 
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>  .../devicetree/bindings/connector/usb-connector.yaml  | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> index 9bd52e63c935..cd7feb2d4984 100644
>> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
>> @@ -88,6 +88,17 @@ properties:
>>        - device
>>        - dual
>>  
>> +  power-opmode:
>> +    description: Determines the power operation mode that the Type C connector
>> +      will support.
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#definitions/string
>> +    enum:
>> +      - default
> 
> Wouldn't this just be no property?

No because the aim of this optional property is to re-configure the 
Type-C controller power operation mode. So, when using power-opmode = 
"default", the use can re-configure it to the 'default' USB power 
operation mode - 500mA for USB2 or 900mA for USB3.

> 
>> +      - 1.5A
>> +      - 3.0A
> 
> You'll need to explain these better.
>

Ok I'll add a description in V2.

>> +      - usb_power_delivery
> 
> I would have thought 'default' would be USB-PD. Though I thought Type-C
> was always USB-PD.
> 

In fact, the DT property matches the typec_pwr_opmode enum and 
typec_pwr_opmodes strings tab:
static const char * const typec_pwr_opmodes[] = {
	[TYPEC_PWR_MODE_USB]	= "default",
	[TYPEC_PWR_MODE_1_5A]	= "1.5A",
	[TYPEC_PWR_MODE_3_0A]	= "3.0A",
	[TYPEC_PWR_MODE_PD]	= "usb_power_delivery",
};
The same is done for data-role and power-role properties.

So, I would keep "default", "1.5A", "3.0A" and "usb_power_delivery", and 
I'll add a description for each. Is it OK for you ?

Regards,
Amelie

>> +
>>    # The following are optional properties for "usb-c-connector" with power
>>    # delivery support.
>>    source-pdos:
>> -- 
>> 2.17.1
>> 

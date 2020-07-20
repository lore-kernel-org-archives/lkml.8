Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97335C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9CD208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="knABtIz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgGTSXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:23:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56624 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTSXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:23:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KIMUOE102100;
        Mon, 20 Jul 2020 13:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595269350;
        bh=Sd5hnnt4GxFptLwg5tfzZnZe3N/CSbSSNwGUNJiJjGg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=knABtIz/jmMhBngJ8jfzuvoe4eXBXcBKN9jwGnl956ycWLGE3iCkivm5pbdn7z7EI
         bUagy0Zdls//uoybpGBdhCDWIQgjneSVPXgxA23XPixpPAjFgX9+2jzSIRc7ltuLl2
         h9dwtNHeUQ5T7iOfp0qRJ+8rjAkLemRu0JNemaz8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KIMU0x103198;
        Mon, 20 Jul 2020 13:22:30 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 13:22:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 13:22:30 -0500
Received: from [10.250.32.229] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KIMUVZ080357;
        Mon, 20 Jul 2020 13:22:30 -0500
Subject: Re: [PATCH 4/4] dt-bindings: tas2562: Convert the tas2562 binding to
 yaml
To:     Rob Herring <robh@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200626154143.20351-1-dmurphy@ti.com>
 <20200626154143.20351-4-dmurphy@ti.com> <20200715201522.GA740682@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e61b54bf-f77c-cb4d-c256-fb0c15f18993@ti.com>
Date:   Mon, 20 Jul 2020 13:22:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715201522.GA740682@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

On 7/15/20 3:15 PM, Rob Herring wrote:
> On Fri, Jun 26, 2020 at 10:41:43AM -0500, Dan Murphy wrote:
>> Convert the TAS2562 text file to yaml format.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../devicetree/bindings/sound/tas2562.txt     | 37 ---------
>>   .../devicetree/bindings/sound/tas2562.yaml    | 77 +++++++++++++++++++
>>   2 files changed, 77 insertions(+), 37 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
>> deleted file mode 100644
>> index dc6d7362ded7..000000000000
>> --- a/Documentation/devicetree/bindings/sound/tas2562.txt
>> +++ /dev/null
>> @@ -1,37 +0,0 @@
>> -Texas Instruments TAS2562 Smart PA
>> -
>> -The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
>> -efficiently driving high peak power into small loudspeakers.
>> -Integrated speaker voltage and current sense provides for
>> -real time monitoring of loudspeaker behavior.
>> -
>> -Required properties:
>> - - #address-cells  - Should be <1>.
>> - - #size-cells     - Should be <0>.
>> - - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
>> - - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
>> - - ti,imon-slot-no:- TDM TX current sense time slot.
>> - - ti,vmon-slot-no:- TDM TX voltage sense time slot. This slot must always be
>> -		     greater then ti,imon-slot-no.
>> -
>> -Optional properties:
>> -- interrupt-parent: phandle to the interrupt controller which provides
>> -                    the interrupt.
>> -- interrupts: (GPIO) interrupt to which the chip is connected.
>> -- shut-down-gpio: GPIO used to control the state of the device.
>> -
>> -Examples:
>> -tas2562@4c {
>> -        #address-cells = <1>;
>> -        #size-cells = <0>;
>> -        compatible = "ti,tas2562";
>> -        reg = <0x4c>;
>> -
>> -        interrupt-parent = <&gpio1>;
>> -        interrupts = <14>;
>> -
>> -	shut-down-gpio = <&gpio1 15 0>;
>> -        ti,imon-slot-no = <0>;
>> -        ti,vmon-slot-no = <1>;
>> -};
>> -
>> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
>> new file mode 100644
>> index 000000000000..1fb467e14d4c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> Same licensing comment here as tas2770

OK I will fix it like I did with the other TAS2770 patches


>> +# Copyright (C) 2019 Texas Instruments Incorporated
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Texas Instruments TAS2562 Smart PA
>> +
>> +maintainers:
>> +  - Dan Murphy <dmurphy@ti.com>
>> +
>> +description: |
>> +  The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
>> +  efficiently driving high peak power into small loudspeakers.
>> +  Integrated speaker voltage and current sense provides for
>> +  real time monitoring of loudspeaker behavior.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,tas2562
>> +      - ti,tas2563
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: |
>> +       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
>> +
>> +  shut-down-gpio:
>> +    description: GPIO used to control the state of the device.
>> +    deprecated: true
> Why do we need this as the driver never worked?

Not sure what you are asking.

Driver has been fixed for this specific binding in sound for-next.

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/sound/soc/codecs/tas2562.c?h=for-next&id=bc07b54459cbb3a572a78b5c200ff79ef11b8158

>
>> +
>> +  shutdown-gpio:
>> +    description: GPIO used to control the state of the device.
> -gpios is the preferred form: shutdown-gpios

So the plural form of gpio is preferred even if the gpio is singular?  I 
would think gpio would be plural if this was an array of gpios.

I am waiting for the yaml to be accepted before adding this shutdown 
property to the driver.

Dan


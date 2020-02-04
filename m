Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA0C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55A42082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBDPi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:38:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:38:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3E90428DBA5
Subject: Re: [PATCH] dt-bindings: convert extcon-usbc-cros-ec.txt
 extcon-usbc-cros-ec.yaml
To:     Rob Herring <robh@kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     devicetree@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, mark.rutland@arm.com, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
References: <20200122151313.11782-1-dafna.hirschfeld@collabora.com>
 <20200203121849.GA8196@bogus>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <46068846-5d7d-8de6-3950-3b0a0d8b60a2@collabora.com>
Date:   Tue, 4 Feb 2020 16:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200203121849.GA8196@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna, Rob,

On 3/2/20 13:18, Rob Herring wrote:
> On Wed, Jan 22, 2020 at 04:13:13PM +0100, Dafna Hirschfeld wrote:
>> convert the binding file extcon-usbc-cros-ec.txt to yaml format
>> This was tested and verified on ARM with:
>> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> ---
>>  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 -----------
>>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 42 +++++++++++++++++++
>>  2 files changed, 42 insertions(+), 24 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>> deleted file mode 100644
>> index 8e8625c00dfa..000000000000
>> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>> +++ /dev/null
>> @@ -1,24 +0,0 @@
>> -ChromeOS EC USB Type-C cable and accessories detection
>> -
>> -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
>> -able to detect the state of external accessories such as display adapters
>> -or USB devices when said accessories are attached or detached.
>> -
>> -The node for this device must be under a cros-ec node like google,cros-ec-spi
>> -or google,cros-ec-i2c.
>> -
>> -Required properties:
>> -- compatible:		Should be "google,extcon-usbc-cros-ec".
>> -- google,usb-port-id:	Specifies the USB port ID to use.
>> -
>> -Example:
>> -	cros-ec@0 {
>> -		compatible = "google,cros-ec-i2c";
>> -
>> -		...
>> -
>> -		extcon {
>> -			compatible = "google,extcon-usbc-cros-ec";
>> -			google,usb-port-id = <0>;
>> -		};
>> -	}
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>> new file mode 100644
>> index 000000000000..78779831282a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> Surely Google is the only copyright holder on the old file and would be 
> okay with dual licensing here?
> 
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ChromeOS EC USB Type-C cable and accessories detection
>> +
>> +maintainers:
>> +  - MyungJoo Ham <myungjoo.ham@samsung.com>
>> +  - Chanwoo Choi <cw00.choi@samsung.com>
> 
> Usually this is someone that knows the h/w, not who applies the patch. 
> I'd expect a Google person.
> 

I'd say that the driver author should be the maintainer, but if you don't know
who is the maintainer because is not specified you can add Benson and me as
maintainers (as chrome-platform maintainers we take care of this and all cros-ec
related drivers)

Benson Leung <bleung@chromium.org>
Enric Balletbo i Serra <enric.balletbo@collabora.com>

>> +
>> +description: |
>> +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
>> +  able to detect the state of external accessories such as display adapters
>> +  or USB devices when said accessories are attached or detached.
>> +  The node for this device must be under a cros-ec node like google,cros-ec-spi
>> +  or google,cros-ec-i2c.
>> +
>> +properties:
>> +  compatible:
>> +    const: google,extcon-usbc-cros-ec
>> +
>> +  google,usb-port-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      the port id
> 
> Any range of values allowed? ~0 is okay?
> 

From hardware point of view, the port id, is a number from 0 to 255. The typical
usage is have two ports with port id 0 and port id 1.


>> +required:
>> +  - compatible
>> +  - google,usb-port-id
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    cros-ec@0 {
>> +        compatible = "google,cros-ec-i2c";
>> +        extcon {
>> +            compatible = "google,extcon-usbc-cros-ec";
>> +            google,usb-port-id = <0>;
>> +        };
>> +    };
>> -- 
>> 2.17.1
>>

Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EB521927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGNDxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:53:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:45375 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbgGNDxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:53:20 -0400
IronPort-SDR: 6IKo3vnKIbd4dde/+ZQw0l4ZpIrPJUlVJN1yOTWoOhN8jC5/l9X8N/fHMAGp3ipBp079nMsCKG
 l7ZhvLPU5IkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150227649"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="150227649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 20:53:20 -0700
IronPort-SDR: 3q0YHQnxsGP2UJIF2mejmJWN0IYuu5eZtpSM4v9rhMJzcLqSwQlVVypGc4efSwSsshzkvYZvkL
 msI6dyceyvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="299406499"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 13 Jul 2020 20:53:20 -0700
Received: from [10.255.133.45] (vramuthx-MOBL1.gar.corp.intel.com [10.255.133.45])
        by linux.intel.com (Postfix) with ESMTP id BAA5758080E;
        Mon, 13 Jul 2020 20:53:12 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: Add USB PHY support for Intel
 LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, andriy.shevchenko@intel.com,
        balbi@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        yin1.li@intel.com
References: <20200713085453.7353-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200713085453.7353-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200713150818.GB184301@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <46bd1140-bf8f-757f-399a-4ed05e93d867@linux.intel.com>
Date:   Tue, 14 Jul 2020 11:53:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713150818.GB184301@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13/7/2020 11:08 pm, Rob Herring wrote:
> On Mon, Jul 13, 2020 at 04:54:52PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add the dt-schema to support USB PHY on Intel LGM SoC
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>> new file mode 100644
>> index 000000000000..0fc76cd23774
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/usb/intel,lgm-usb-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel LGM USB PHY Device Tree Bindings
>> +
>> +maintainers:
>> +  - Vadivel Murugan Ramuthevar <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,lgm-usb-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    items:
>> +      - description: USB PHY and Host controller reset
>> +      - description: APB BUS reset
>> +      - description: General Hardware reset
>> +
>> +  reset-names:
>> +    items:
>> +      - const: phy
>> +      - const: apb
>> +      - const: phy31
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - reg
>> +  - resets
>> +  - reset-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    usb_phy: usb_phy@e7e00000 {
> 
> usb-phy@...
Noted, will updated.
Thanks!
> 
>> +        compatible = "intel,lgm-usb-phy";
>> +        reg = <0xe7e00000 0x10000>;
>> +        clocks = <&cgu0 153>;
>> +        resets = <&rcu 0x70 0x24>,
>> +                 <&rcu 0x70 0x26>,
>> +                 <&rcu 0x70 0x28>;
>> +        reset-names = "phy", "apb", "phy31";
>> +    };
>> -- 
>> 2.11.0
>>

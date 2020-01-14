Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6652EC33CAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C22084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgANC4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:56:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:21322 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgANC4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:56:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 18:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="247893351"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jan 2020 18:56:20 -0800
Received: from [10.226.38.20] (unknown [10.226.38.20])
        by linux.intel.com (Postfix) with ESMTP id 2325A5802B1;
        Mon, 13 Jan 2020 18:56:17 -0800 (PST)
Subject: Re: [PATCH v10 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191217015658.23017-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_Jsq+qcR=3y1TQ+qrbfNW=_3kJ92eZP5eYvGYgteYWHyDVPw@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <6d8b0b3d-f501-26d5-f48b-5e3e58b86f93@linux.intel.com>
Date:   Tue, 14 Jan 2020 10:56:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+qcR=3y1TQ+qrbfNW=_3kJ92eZP5eYvGYgteYWHyDVPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/1/2020 1:55 AM, Rob Herring wrote:
> On Mon, Dec 16, 2019 at 7:57 PM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 56 ++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> new file mode 100644
>> index 000000000000..ff7959c21af0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +description: |+
>> +  Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
>> +  node is used to reference the base address of eMMC phy registers.
>> +
>> +  The eMMC PHY node should be the child of a syscon node with the
>> +  required property:
>> +
>> +  - compatible:         Should be one of the following:
>> +                        "intel,lgm-syscon", "syscon"
>> +  - reg:
>> +      maxItems: 1
>> +
>> +properties:
>> +  compatible:
>> +      const: intel,lgm-emmc-phy
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +examples:
>> +  - |
>> +    sysconf: chiptop@e0200000 {
>> +      compatible = "intel,lgm-syscon", "syscon";
>> +      reg = <0xe0200000 0x100>;
>> +
>> +      emmc-phy: emmc-phy@a8 {
> This fails in linux-next. Please run 'make dt_binding_check' and fix:
>
> Error: Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.example.dts:21.19-20
> syntax error
> FATAL ERROR: Unable to parse input tree
Sorry for the trouble, will fix it .
>
> The problem is labels can't have '-'.
Thanks for the direction.
Regards
vadivel
>
> Rob

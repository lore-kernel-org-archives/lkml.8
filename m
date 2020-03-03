Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03F8214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgCCJYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:24:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:40045 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgCCJYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:24:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 01:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="438653408"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 03 Mar 2020 01:24:18 -0800
Received: from [10.226.39.43] (unknown [10.226.39.43])
        by linux.intel.com (Postfix) with ESMTP id 5A0A8580274;
        Tue,  3 Mar 2020 01:24:16 -0800 (PST)
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add YAML schemas for Intel
 Combophy
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <9f049a5fccd080bd5d8e9a697b96d4c40a413a0a.1583127977.git.eswara.kota@linux.intel.com>
 <20200303015051.GA780@bogus>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <5b71670d-91a6-9760-f4da-1b6f014a1ea2@linux.intel.com>
Date:   Tue, 3 Mar 2020 17:24:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200303015051.GA780@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/2020 9:50 AM, Rob Herring wrote:
> On Mon, Mar 02, 2020 at 04:43:24PM +0800, Dilip Kota wrote:
>> Combophy subsystem provides PHY support to various
>> controllers, viz. PCIe, SATA and EMAC.
>> Adding YAML schemas for the same.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>> Changes on v4:
>>    No changes.
...
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/phy/phy-intel-combophy.h>
>> +    combophy@d0a00000 {
>> +        compatible = "intel,combophy-lgm", "intel,combo-phy";
>> +        clocks = <&cgu0 1>;
>> +        reg = <0xd0a00000 0x40000>,
>> +              <0xd0a40000 0x1000>;
>> +        reg-names = "core", "app";
>> +        resets = <&rcu0 0x50 6>,
>> +                 <&rcu0 0x50 17>;
>> +        reset-names = "phy", "core";
>> +        intel,syscfg = <&sysconf 0>;
>> +        intel,hsio = <&hsiol 0>;
>> +        intel,phy-mode = <COMBO_PHY_PCIE>;
>> +
>> +        phy@0 {
> You need a 'reg' property to go with a unit-address.
>
> Really, I'd just simplify this to make parent 'resets' be 4 entries and
> put '#phy-cells = <1>;' in the parent. Then you don't need these child
> nodes.
If child nodes are not present, use case like PCIe controller-0 using 
phy@0 and PCIe controller-1 using phy@1 wont be possible.
>
>> +            compatible = "intel,phydev";
>> +            #phy-cells = <0>;
>> +            resets = <&rcu0 0x50 23>;
>> +        };
>> +
>> +        phy@1 {
>> +            compatible = "intel,phydev";
>> +            #phy-cells = <0>;
>> +            resets = <&rcu0 0x50 24>;
>> +        };
>> +    };
>> diff --git a/include/dt-bindings/phy/phy-intel-combophy.h b/include/dt-bindings/phy/phy-intel-combophy.h
>> new file mode 100644
>> index 000000000000..bd7f6377f4ef
>> --- /dev/null
>> +++ b/include/dt-bindings/phy/phy-intel-combophy.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _DT_BINDINGS_INTEL_COMBOPHY
>> +#define _DT_BINDINGS_INTEL_COMBOPHY
>> +
>> +#define COMBO_PHY_PCIE	0
>> +#define COMBO_PHY_XPCS	1
>> +#define COMBO_PHY_SATA	2
> Use the PHY_TYPE_* defines we already have and extend as you need to.

Sure, will do the same.

Regards,
Dilip

>
>> +
>> +#endif /* _DT_BINDINGS_INTEL_COMBOPHY*/
>> -- 
>> 2.11.0
>>

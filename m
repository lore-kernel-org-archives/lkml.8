Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2094DC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB212072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cOy6vGiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCTF6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:58:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTF6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:58:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02K5wanm012081;
        Fri, 20 Mar 2020 00:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584683916;
        bh=GviAYJ/cIsQXwZWzxrbuwydm5DG3/0LKWJF5jH3tp7c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cOy6vGiJ64ESd8D8igN1+9cjN1llolyMo3JnX0ogHecAn/GAhaWJI6pC2yOSzKpIe
         2SZYMZWWW3BJ/9YoyxXNMF88vvHyaBkRIT1G6Ni3Sdg46bhFNg90BelISlyf9zl7tO
         jvYUiKtL5aU/GJpYfmTT1d8qzPrIPbY1pcQXs+to=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02K5wa1D077568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Mar 2020 00:58:36 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Mar 2020 00:58:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Mar 2020 00:58:36 -0500
Received: from [10.250.133.193] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02K5wXfQ016043;
        Fri, 20 Mar 2020 00:58:34 -0500
Subject: Re: [PATCH 1/2] dt-bindings: phy: intel: Add documentation for Keem
 Bay eMMC PHY
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200316103726.16339-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200316103726.16339-2-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3de03bba-9e18-d388-7d56-634f74234bac@ti.com>
Date:   Fri, 20 Mar 2020 11:28:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200316103726.16339-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/16/2020 4:07 PM, Wan Ahmad Zainie wrote:
> Document Intel Keem Bay eMMC PHY DT bindings.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

Need Rob's Ack on this patch.

Thanks
Kishon
> ---
>  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> new file mode 100644
> index 000000000000..af1d62fc8323
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay eMMC PHY
> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,keembay-emmc-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: emmcclk
> +
> +  intel,syscon:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description:
> +      A phandle to a syscon device used to access core/phy configuration
> +      registers.
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - intel,syscon
> +  - "#phy-cells"
> +
> +examples:
> +  - |
> +    mmc_phy_syscon: syscon@20290000 {
> +          compatible = "simple-mfd", "syscon";
> +          reg = <0x0 0x20290000 0x0 0x54>;
> +    };
> +
> +    emmc_phy: mmc_phy@20290000 {
> +          compatible = "intel,keembay-emmc-phy";
> +          reg = <0x0 0x20290000 0x0 0x54>;
> +          clocks = <&mmc>;
> +          clock-names = "emmcclk";
> +          intel,syscon = <&mmc_phy_syscon>;
> +          #phy-cells = <0>;
> +    };
> 

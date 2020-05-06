Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D834C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300E02076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lFQlkU6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgEFTVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:21:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47920 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgEFTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:21:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046JLgZS028342;
        Wed, 6 May 2020 14:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588792902;
        bh=z5KTFZ7VsGaMFwyM2iAcVcZw6DjwHKoZZe2pBriK/n0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lFQlkU6ESPbepNcpPREgDX19r22YhEr5KgjPoE2oAgCvRtppWkQ13Yq6td+xP64mk
         y/fXD1yb1m/ZSTMa17u2i1xMmejfT1k15jOtKkJ0fU/VA88etCpUONoD2MjnQXmVdi
         583O4CnEh4Eqb4pMj7OSLkLEn08t43l3/Xmw/9mQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046JLglC023628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 14:21:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 14:21:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 14:21:41 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046JLbBp056569;
        Wed, 6 May 2020 14:21:39 -0500
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: ti: add binding for k3 platforms
 chipid module
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <devicetree@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
References: <20200505193417.2112-1-grygorii.strashko@ti.com>
 <20200505193417.2112-2-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a523caa4-bd34-35e3-8e3a-7668a168931d@ti.com>
Date:   Wed, 6 May 2020 22:21:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505193417.2112-2-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 05/05/2020 22:34, Grygorii Strashko wrote:
> Add DT binding for Texas Instruments K3 Multicore SoC platforms chipid
> module which is represented by CTRLMMR_xxx_JTAGID register and contains
> information about SoC id and revision.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>   .../bindings/soc/ti/k3-socinfo.yaml           | 40 +++++++++++++++++++
>   1 file changed, 40 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml b/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
> new file mode 100644
> index 000000000000..a1a8423b2e2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/ti/k3-socinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 Multicore SoC platforms chipid module
> +
> +maintainers:
> +  - Tero Kristo <t-kristo@ti.com>
> +  - Nishanth Menon <nm@ti.com>
> +
> +description: |
> +  Texas Instruments (ARM64) K3 Multicore SoC platforms chipid module is
> +  represented by CTRLMMR_xxx_JTAGID register which contains information about
> +  SoC id and revision.
> +
> +properties:
> +  $nodename:
> +    pattern: "^chipid@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - const: ti,am654-chipid
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    chipid@43000014 {
> +        compatible = "ti,am654-chipid";
> +        reg = <0x43000014 0x4>;
> +    };
> 

Rob, Do you have any comments here?

-- 
Best regards,
grygorii

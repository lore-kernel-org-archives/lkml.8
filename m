Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B823AC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9785F206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lbf9qoq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgEDJim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:38:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58410 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgEDJil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:38:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0449cUal125935;
        Mon, 4 May 2020 04:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588585110;
        bh=+cbr2QlNAaibYB5T0a54zsT/SDvBAOzBQ5jH0LGi8Y0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Lbf9qoq4Jk0OowNS2ngnfusqKPqnL9Obkrk7KFF+xBVDdk2RtsXgK1uTsdo6hYGkW
         g41z1b0+4k5UB4N2R92yGWGzY2lp9X948/d8cJqg3kad2k9HSiWHIWrjHEXZOMutKu
         2Y+HVo0bqqKuzpzYm6Cqx/xGuoZ/hGsTY2aTv0jM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0449cTdd116394;
        Mon, 4 May 2020 04:38:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 May
 2020 04:38:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 May 2020 04:38:29 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0449cPB8118676;
        Mon, 4 May 2020 04:38:26 -0500
Subject: Re: [PATCH 1/5] dt-bindings: soc: ti: add binding for k3 platforms
 chipid module
To:     Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200423180545.13707-1-grygorii.strashko@ti.com>
 <20200423180545.13707-2-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0c677af8-5a5a-8b34-0670-c63f9dfe7f2f@ti.com>
Date:   Mon, 4 May 2020 12:38:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423180545.13707-2-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 23/04/2020 21:05, Grygorii Strashko wrote:
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

Do you have any comments here?

-- 
Best regards,
grygorii

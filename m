Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFFC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FA024676
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aDm+V9KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgBMJRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:17:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44832 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgBMJRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:17:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01D9GugY083260;
        Thu, 13 Feb 2020 03:16:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581585416;
        bh=HD8xpFq6QBHByMPfQUEirTRxNYqt9sNUI9YHw9LUwuA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aDm+V9KX1LvxWGQqO+fXi+inYSFZoo+xo8hTQyEtf4v2AlBfCWq6rE1Zra68n0B0m
         P8Vn81aGeakUc51CirbhuRjWKomks8vMUK+hfcTzTSJ3WjE37P2m2v9uzaTXv7HU7j
         UK7tLncslZhU7AUCndEyok7mZeADMXRBZA0TmoR0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01D9GuSS062922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Feb 2020 03:16:56 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 13
 Feb 2020 03:16:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 13 Feb 2020 03:16:55 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01D9Gp4Q021263;
        Thu, 13 Feb 2020 03:16:52 -0600
Subject: Re: [PATCH v5 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings.
To:     Yuti Amonkar <yamonkar@cadence.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <maxime@cerno.tech>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>
CC:     <praneeth@ti.com>, <jsarha@ti.com>, <mparab@cadence.com>,
        <sjakhade@cadence.com>
References: <1581481604-24499-1-git-send-email-yamonkar@cadence.com>
 <1581481604-24499-2-git-send-email-yamonkar@cadence.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <b97283b0-e4a5-4b96-e509-b9b5cdd78991@ti.com>
Date:   Thu, 13 Feb 2020 11:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581481604-24499-2-git-send-email-yamonkar@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 06:26, Yuti Amonkar wrote:
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../bindings/display/bridge/cdns,mhdp.yaml    | 125 ++++++++++++++++++
>   1 file changed, 125 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 000000000000..e7f84ed1d2da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence MHDP bridge
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8546
> +      - ti,j721e-mhdp8546
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of mhdptx apb registers upto PHY mapped area(AUX_CONFIG_P).

"up to". Add space before (.

> +          The AUX and PMA registers are mapped to associated phy driver.
> +      - description:
> +          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: mhdptx
> +      - const: j721e-intg
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      DP bridge clock, it's used by the IP to know how to translate a number of
> +      clock cycles into a time (which is used to comply with DP standard timings
> +      and delays).
> +
> +  phys:
> +    description: Phandle to the DisplyPort phy.

"Display"

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

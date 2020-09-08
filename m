Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF13C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3984420658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NTWdq1Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbgIHTzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47486 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbgIHPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088DtRWe035750;
        Tue, 8 Sep 2020 08:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599573327;
        bh=WH8rBcZDG+qiXS6giP11GremPXxA0Xt/2RHYWB7S/GA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NTWdq1JaDDimXcMCV9Ki565pQkwum8+bXe25HrW03Peqn1A2j69gRH+F9Z3TaXT/n
         hLX9R7ZihR4qDLzM2p2EVE2r9dsBZM1nMMFYOoPu89MAV4Cf2CAiOAECGxPRsxWMPy
         pqGGt0GQnZfWMe3SwKGp+RXY5lVZPq3cIEd0y6yk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088DtRe9091229;
        Tue, 8 Sep 2020 08:55:27 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 08:55:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 08:55:26 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088DtQJ6068912;
        Tue, 8 Sep 2020 08:55:26 -0500
Subject: Re: [PATCH v3 2/2] dt-bindings: leds: Add bindings for MT6360 LED
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gene_chen@richtek.com>,
        <Wilma.Wu@mediatek.com>, <shufan_lee@richtek.com>,
        <cy_huang@richtek.com>, <benjamin.chao@mediatek.com>
References: <1599474459-20853-1-git-send-email-gene.chen.richtek@gmail.com>
 <1599474459-20853-3-git-send-email-gene.chen.richtek@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <35d5b52c-36ff-d636-7838-be46e43b0387@ti.com>
Date:   Tue, 8 Sep 2020 08:55:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599474459-20853-3-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gene

On 9/7/20 5:27 AM, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
>
> Add bindings document for LED support on MT6360 PMIC
>
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   .../devicetree/bindings/leds/leds-mt6360.yaml      | 105 +++++++++++++++++++++
>   1 file changed, 105 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-mt6360.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-mt6360.yaml b/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
> new file mode 100644
> index 0000000..72914c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-mt6360.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-mt6360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MT6360 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Gene Chen <gene_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6360 MFD device.
> +  The LED controller is represented as a sub-node of the PMIC node on
> +  the device tree.
> +  This device has six current sinks.
> +

A bit of a nitpick but wouldn't the commit message in patch 1/2 be a 
better description of the hardware then this?

Other wise

Reviewed-by: Dan Murphy <dmurphy@ti.com>


Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA6C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E16208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tb1G6zW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEHIko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:40:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgEHIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:40:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488egeS093286;
        Fri, 8 May 2020 03:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588927242;
        bh=gZlYn3dCrf0VoY50ZppmTvzvKC4kayfAELfhPMA8pSc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tb1G6zW/XUK4EdCgosWwIGIgo17kwhJ/5fRe8ieHBx2PC33eC0X89zCGDd6v7G2/z
         rkNK4icyU44By8uZGYeyfexEBLwMXin8Y4kiAzHNMiQRsva+pUGb7UQTICHYnb+rAW
         cDgvB0hRJLbyFAe54vdBYQbAHgRH/2WpwFH6neN8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488egrK113953;
        Fri, 8 May 2020 03:40:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:40:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:40:42 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488ed4Q002444;
        Fri, 8 May 2020 03:40:39 -0500
Subject: Re: [PATCH v3 1/7] dt-bindings: syscon: Add TI's J721E specific
 compatible string
To:     Roger Quadros <rogerq@ti.com>, <t-kristo@ti.com>
CC:     <robh@kernel.org>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200508082937.14171-1-rogerq@ti.com>
 <20200508082937.14171-2-rogerq@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6efa9374-e8f2-4054-3f35-6cacead783b8@ti.com>
Date:   Fri, 8 May 2020 14:10:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508082937.14171-2-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/8/2020 1:59 PM, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Add TI's J721E SoC specific compatible string.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

This patch should be dropped given that patch 2 adds a new binding for the
compatible added here.

Thanks
Kishon

> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 39375e4313d2..f9aac75d423a 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -38,6 +38,7 @@ properties:
>            - allwinner,sun8i-h3-system-controller
>            - allwinner,sun8i-v3s-system-controller
>            - allwinner,sun50i-a64-system-controller
> +          - ti,j721e-system-controller
>  
>          - const: syscon
>  
> 

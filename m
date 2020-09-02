Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3CAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AAC2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KiuvTsiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIBEOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:14:32 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38304 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgIBEO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:14:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0824EPAR085042;
        Tue, 1 Sep 2020 23:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599020065;
        bh=N1Dv4Lx/HyZg0+8tlySZf5Ek6eBkodl4OCUmWKl/jXA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KiuvTsiJJcCqWAP9SJynNfjEcZ8QewhAaHL+JYGoPmtDI2ndS/mef+BfDOh2K4x+v
         /RzccjRGSG5t4RDy6UtPo4GZYvN94biRHjAZHchgHhkJtA5GF/z7hjbzF4jwaeePaa
         KRUN7ysu36iDpmmtiYanHaIfAJ+mpfD/V6NoW5K4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0824EP17103193;
        Tue, 1 Sep 2020 23:14:25 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 23:14:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 23:14:25 -0500
Received: from [10.250.33.196] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0824EO5w057320;
        Tue, 1 Sep 2020 23:14:24 -0500
Subject: Re: [PATCH 4/7] arm64: dts: ti: k3-am65-base-board Use generic camera
 for node name instead of ov5640
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-5-nm@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <cf468b1c-2717-b579-93d5-2ca0b8a97f93@ti.com>
Date:   Tue, 1 Sep 2020 23:14:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901223059.14801-5-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 5:30 PM, Nishanth Menon wrote:
> Use camera@ naming for nodes following standard conventions of device
> tree (section 2.2.2 Generic Names recommendation in [1]).
> 
> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
> 
> Suggested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index b8a8a0fcb8af..86c9074cb070 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -257,7 +257,7 @@
>  	pinctrl-0 = <&main_i2c1_pins_default>;
>  	clock-frequency = <400000>;
>  
> -	ov5640@3c {
> +	ov5640: camera@3c {
>  		compatible = "ovti,ov5640";
>  		reg = <0x3c>;
>  
> 


Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E8C22B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgHDIP3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgHDIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:15:28 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k2s6M-0003dI-1b; Tue, 04 Aug 2020 10:15:14 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k2s6L-00031T-0C; Tue, 04 Aug 2020 10:15:13 +0200
Message-ID: <053da16ed682cc016b0a66a834fb58d4d9410dc2.camel@pengutronix.de>
Subject: Re: [v2,3/6] dt-binding: reset-controller: ti: add generic-reset to
 compatible
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Crystal Guo <crystal.guo@mediatek.com>, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        seiya.wang@mediatek.com, stanley.chu@mediatek.com,
        yingjoe.chen@mediatek.com, fan.chen@mediatek.com,
        yong.liang@mediatek.com, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 04 Aug 2020 10:15:12 +0200
In-Reply-To: <20200803061511.29555-4-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-4-crystal.guo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-03 at 14:15 +0800, Crystal Guo wrote:
> The TI syscon reset controller provides a common reset management,
> and should be suitable for other SOCs. Add compatible "generic-reset",
> which denotes to use a common reset-controller driver.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> index d551161ae785..e36d3631eab2 100644
> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> @@ -25,6 +25,7 @@ Required properties:
>  			    "ti,k2l-pscrst"
>  			    "ti,k2hk-pscrst"
>  			    "ti,syscon-reset"
> +			    "generic-reset", "ti,syscon-reset"
>   - #reset-cells		: Should be 1. Please see the reset consumer node below
>  			  for usage details
>   - ti,reset-bits	: Contains the reset control register information
> -- 
> 2.18.0

My understanding is that it would be better to add a mtk specific
compatible instead of adding this "generic-reset", especially since we
can't guarantee this binding will be considered generic in the future.
I think there is nothing wrong with specifying
	compatible = "mtk,your-compatible", "ti,syscon-reset";
in your device tree if your hardware is indeed compatible with the
specified "ti,syscon-reset" binding, but I may be wrong: Therefore,
please add devicetree@vger.kernel.org to Cc: for binding changes.

regards
Philipp

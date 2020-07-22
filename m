Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62414C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A19C2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgGVXNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:13:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48888 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVXNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:13:45 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyNvg-0006Rv-PO; Thu, 23 Jul 2020 01:13:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: rockchip: Add ROCKPi 4B binding
Date:   Thu, 23 Jul 2020 01:13:39 +0200
Message-ID: <3893924.cuH9TW0V3R@phil>
In-Reply-To: <20200722190949.215656-3-jagan@amarulasolutions.com>
References: <20200722190949.215656-1-jagan@amarulasolutions.com> <20200722190949.215656-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Mittwoch, 22. Juli 2020, 21:09:46 CEST schrieb Jagan Teki:
> Add dt-bindings for ROCKPi 4B which is similar to 4A with
> additional AP6256 Wifi/BT, PoE.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 36057c9e4b83..7250adb43d24 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -448,6 +448,12 @@ properties:
>            - const: radxa,rockpi4a
>            - const: rockchip,rk3399
>  
> +      - description: Radxa ROCK Pi 4B
> +        items:
> +          - const: radxa,rockpi4
> +          - const: radxa,rockpi4b
> +          - const: rockchip,rk3399
> +

Please do all RockPi4 variants into one entry, so we want something like:

      - description: Radxa ROCK Pi 4
        items:
          - enum:
              - radxa,rockpi4a
              - radxa,rockpi4b
              - radxa,rockpi4c
          - const: radxa,rockpi4
          - const: rockchip,rk3399

And as the {a,b,c} variant is the most specific it also should be the
first entry, not the second.


Heiko

>        - description: Radxa ROCK Pi N8
>          items:
>            - const: radxa,rockpi-n8
> 





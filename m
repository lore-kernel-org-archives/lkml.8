Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5FEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED18222C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgCAAmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:42:40 -0500
Received: from gloria.sntech.de ([185.11.138.130]:56122 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgCAAmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:42:40 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8CgT-00052P-9b; Sun, 01 Mar 2020 01:42:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add doc for pine64 Pinebook Pro
Date:   Sun, 01 Mar 2020 01:42:16 +0100
Message-ID: <2852313.2ZqhBMtFLq@phil>
In-Reply-To: <20200229144817.355678-2-t.schramm@manjaro.org>
References: <20200229144817.355678-1-t.schramm@manjaro.org> <20200229144817.355678-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 29. Februar 2020, 15:48:16 CET schrieb Tobias Schramm:
> This commit adds a compatible for the Pinebook Pro.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

The old patch from Emmanuel already got an

Reviewed-by: Rob Herring <robh@kernel.org>

and as this is the same binding, this should just be kept :-)

[Mainly for me to remember as well]

Heiko

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 874b0eaa2a75..482a0cbfb18a 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -402,6 +402,11 @@ properties:
>            - const: phytec,rk3288-phycore-som
>            - const: rockchip,rk3288
>  
> +      - description: Pine64 Pinebook Pro
> +        items:
> +          - const: pine64,pinebook-pro
> +          - const: rockchip,rk3399
> +
>        - description: Pine64 Rock64
>          items:
>            - const: pine64,rock64
> 





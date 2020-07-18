Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F64C433F8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938082073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGRQwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 12:52:23 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44712 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgGRQwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:52:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E1245FB03;
        Sat, 18 Jul 2020 18:52:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wM7kdGGFcpcI; Sat, 18 Jul 2020 18:52:16 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 13A4A42576; Sat, 18 Jul 2020 18:52:16 +0200 (CEST)
Date:   Sat, 18 Jul 2020 18:52:16 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Fix example in nwl-dsi.yaml
Message-ID: <20200718165215.GA26122@bogon.m.sigxcpu.org>
References: <20200703114717.2140832-1-megous@megous.com>
 <20200703114717.2140832-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200703114717.2140832-2-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jul 03, 2020 at 01:47:16PM +0200, Ondrej Jirman wrote:
> The example is now validated against rocktech,jh057n00900 schema
> that was ported to yaml, and didn't validate with:
> 
> - '#address-cells', '#size-cells', 'port@0' do not match any of
>   the regexes: 'pinctrl-[0-9]+'
> - 'vcc-supply' is a required property
> - 'iovcc-supply' is a required property
> - 'reset-gpios' is a required property
> 
> Fix it.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/display/bridge/nwl-dsi.yaml      | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> index 8aff2d68fc33..2c4c34e3bc29 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -165,6 +165,7 @@ examples:
>   - |
>  
>     #include <dt-bindings/clock/imx8mq-clock.h>
> +   #include <dt-bindings/gpio/gpio.h>
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     #include <dt-bindings/reset/imx8mq-reset.h>
>  
> @@ -191,12 +192,12 @@ examples:
>                phy-names = "dphy";
>  
>                panel@0 {
> -                      #address-cells = <1>;
> -                      #size-cells = <0>;
>                        compatible = "rocktech,jh057n00900";
>                        reg = <0>;
> -                      port@0 {
> -                           reg = <0>;
> +                      vcc-supply = <&reg_2v8_p>;
> +                      iovcc-supply = <&reg_1v8_p>;
> +                      reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> +                      port {
>                             panel_in: endpoint {
>                                       remote-endpoint = <&mipi_dsi_out>;
>                             };

Reviewed-by: Guido Günther <agx@sigxcpu.org>
 -- Guido

Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E930C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE722072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgFJQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFJQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:24:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF35DC03E96B;
        Wed, 10 Jun 2020 09:24:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D979F2A12AF
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: Add DT binding for
 cros-ec-regulator
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20200610090748.45908-1-pihsun@chromium.org>
 <20200610090748.45908-2-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <09ef2a68-1770-0b03-0cb1-4de38c5c5106@collabora.com>
Date:   Wed, 10 Jun 2020 18:24:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200610090748.45908-2-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

Thank you for your patch. Some few/trivial comments below

On 10/6/20 11:07, Pi-Hsun Shih wrote:
> Add DT binding documentation for cros-ec-regulator, a voltage regulator
> controlled by ChromeOS EC.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v2:
> * No change
> 
> Changes from v1:
> * Change compatible string to google,regulator-cros-ec.
> * Use reg property in device tree.
> * Change license for dt binding according to checkpatch.pl.
> ---
>  .../bindings/regulator/cros-ec-regulator.yaml | 43 +++++++++++++++++++


The vendor should be part of the binding name, google,cros-ec-regulator.yaml

>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
> new file mode 100644
> index 000000000000..e677614dcdf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/cros-ec-regulator.yaml#

Remember also to change the name here.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC controlled voltage regulators
> +
> +maintainers:
> +  - Pi-Hsun Shih <pihsun@chromium.org>
> +
> +description:
> +  Any property defined as part of the core regulator binding, defined in
> +  regulator.yaml, can also be used.
> +
> +allOf:
> +  - $ref: "regulator.yaml#"
> +
> +properties:
> +  compatible:
> +    const: google,regulator-cros-ec
> +
> +  reg:
> +    maxItems: 1
> +    description: Identifier for the voltage regulator to ChromeOS EC.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |

Please use a full example,

    spi0 {
      #address-cells = <1>;
      #size-cells = <0>;

      cros_ec: ec@0 {
        compatible = "google,cros-ec-spi";
        reg = <0>;


> +    cros-ec {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      regulator@0 {
> +        compatible = "regulator-cros-ec";

The compatible should be "google,cros-ec-regulator"

> +        regulator-min-microvolt = <1800000>;
> +        regulator-max-microvolt = <3300000>;
> +        reg = <0>;
> +      };
> +    };
> +...
> 

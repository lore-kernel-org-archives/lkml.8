Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9019AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758A42074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFKIOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:14:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgFKIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:14:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 15F9D2A183B
Subject: Re: [PATCH v4 1/2] dt-bindings: regulator: Add DT binding for
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
References: <20200611080505.140731-1-pihsun@chromium.org>
 <20200611080505.140731-2-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <13c64346-b80b-9903-37fa-76b8fa47c01d@collabora.com>
Date:   Thu, 11 Jun 2020 10:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200611080505.140731-2-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun,

Thank you for the patch, one minor nitpick that in my opinion would be good to
address.

On 11/6/20 10:04, Pi-Hsun Shih wrote:
> Add DT binding documentation for cros-ec-regulator, a voltage regulator
> controlled by ChromeOS EC.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v3:
> * Fix dt bindings file name.
> * Add full example.
> 
> Changes from v2:
> * No change
> 
> Changes from v1:
> * Change compatible string to google,regulator-cros-ec.
> * Use reg property in device tree.
> * Change license for dt binding according to checkpatch.pl.
> ---
>  .../regulator/google,cros-ec-regulator.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
> new file mode 100644
> index 000000000000..7e341b65b2dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/google,cros-ec-regulator.yaml#
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


Could we use "google,cros-ec-regulator" as compatible, so we are aligned with
the driver name and other cros-ec drivers? If you're agree you need to do
changes here, in the example and in the of table id.

In any case the file binding name should match the compatible name and that's
not the case now, as the file is google,cros-ec-regulator and the compatible is
google,regulator-cros-ec. So either fix the file binding name or the compatible
(I'd prefer the second).

Thanks,
  Enric

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
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cros_ec: ec@0 {
> +            compatible = "google,cros-ec-spi";
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            regulator@0 {
> +                compatible = "google,regulator-cros-ec";
> +                regulator-min-microvolt = <1800000>;
> +                regulator-max-microvolt = <3300000>;
> +                reg = <0>;
> +            };
> +        };
> +    };
> +...
> 

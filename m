Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6313DC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F13206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMQ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:26:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54986 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCMQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:26:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7AD87297056
Subject: Re: [PATCH v4 1/4] dt-bindings: Add cros-ec Type C port driver
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20200312225719.14753-1-pmalani@chromium.org>
 <20200312225719.14753-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a2a08abd-ce6b-d045-5e56-1dd9c0a3360c@collabora.com>
Date:   Fri, 13 Mar 2020 17:26:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312225719.14753-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 12/3/20 23:57, Prashant Malani wrote:
> Some Chrome OS devices with Embedded Controllers (EC) can read and
> modify Type C port state.
> 
> Add an entry in the DT Bindings documentation that lists out the logical
> device and describes the relevant port information, to be used by the
> corresponding driver.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes in v4:
> - Rebased on top of usb-connector.yaml file, so the â€œconnectorâ€ property
>   now directly references the â€œusb-connectorâ€ DT binding.
> 
> Changes in v3:
> - Fixed license identifier.
> - Renamed "port" to "connector".
> - Made "connector" be a "usb-c-connector" compatible property.
> - Updated port-number description to explain min and max values,
>   and removed $ref which was causing dt_binding_check errors.
> - Fixed power-role, data-role and try-power-role details to make
>   dt_binding_check pass.
> - Fixed example to include parent EC SPI DT Node.
> 
> Changes in v2:
> - No changes. Patch first introduced in v2 of series.
> 
>  .../bindings/chrome/google,cros-ec-typec.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> new file mode 100644
> index 0000000000000..6668d678dbcb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Could you use dual licensing here (GPL-2.0-only OR BSD-2-Clause). In general
Google is fine with it for bindings.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chrome OS EC(Embedded Controller) Type C port driver.
> +
> +maintainers:
> +  - Benson Leung <bleung@chromium.org>
> +  - Prashant Malani <pmalani@chromium.org>
> +
> +description:
> +  Chrome OS devices have an Embedded Controller(EC) which has access to
> +  Type C port state. This node is intended to allow the host to read and
> +  control the Type C ports. The node for this device should be under a
> +  cros-ec node like google,cros-ec-spi.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-typec
> +
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |+
> +    cros_ec: ec {
> +      compatible = "google,cros-ec-spi";
> +

I guess that it will trigger some warnings once google,cros-ec.yaml is merged.
Use a full example.

+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            reg = <0>;


> +      typec {
> +        compatible = "google,cros-ec-typec";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        connector@0 {
> +          compatible = "usb-c-connector";
> +          reg = <0>;
> +          power-role = "dual";
> +          data-role = "dual";
> +          try-power-role = "source";
> +        };
> +      };
> +    };
> 

Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA59C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2B720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgBKK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:28:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgBKK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:28:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9F6E22909F8
Subject: Re: [PATCH v2 1/4] dt-bindings: Add cros-ec Type C port driver
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, bleung@chromium.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20200207203752.209296-1-pmalani@chromium.org>
 <20200207203752.209296-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <dd9a8fa7-db6b-87a0-889d-b56a626a3078@collabora.com>
Date:   Tue, 11 Feb 2020 11:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200207203752.209296-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 7/2/20 21:37, Prashant Malani wrote:
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
> Changes in v2:
> - No changes. Patch first introduced in v2 of series.
> 
>  .../bindings/chrome/google,cros-ec-typec.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> new file mode 100644
> index 00000000000000..46ebcbe76db3c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0

I think that Google is fine with the dual licensing here. Would be good if this
can be (GPL-2.0-only OR BSD-2-Clause)

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
> +  port:
> +    description: A node that represents a physical Type C port on the
> +      device.
> +    type: object
> +    properties:
> +      port-number:
> +        description: The number used by the Chrome OS EC to identify
> +          this type C port.
> +        $ref: /schemas/types.yaml#/definitions/uint32

Any range of values allowed? 0 is okay?

> +      power-role:

Sorry if this question is silly, aren't this and below properties the same as
provided by usb-connector?  Can't this be usb-c-connector?

Documentation/devicetree/bindings/connector/usb-connector.txt

> +        description: Determines the power role that the Type C port will
> +          adopt.
> +        oneOf:
> +          - items:
> +            - const: sink
> +            - const: source
> +            - const: dual
> +      data-role:
> +        description: Determines the data role that the Type C port will
> +          adopt.
> +        oneOf:
> +          - items:
> +            - const: host
> +            - const: device
> +            - const: dual
> +      try-power-role:
> +        description: Determines the preferred power role of the Type C port.
> +        oneOf:
> +          - items:
> +            - const: sink
> +            - const: source
> +            - const: dual
> +
> +    required:
> +      - port-number
> +      - power-role
> +      - data-role
> +      - try-power-role
> +
> +required:
> +  - compatible
> +  - port
> +
> +examples:
> +  - |+

Rob can confirm, but I think is a good practice add the parent node, so add the
cros-ec-spi node here?

> +    typec {
> +      compatible = "google,cros-ec-typec";
> +
> +      port@0 {

You can run:

  make dt_binding_check DT_SCHEMA_FILES=<...>/chrome/google,cros-ec-typec.yaml

And you'll get an error:

 typec: 'port' is a required property

> +        port-number = <0>;
> +        power-role = "dual";
> +        data-role = "dual";
> +        try-power-role = "source";
> +      };
> +    };
> 
Thanks,

 Enric

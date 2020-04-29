Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D978C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CC62076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgD2WNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:13:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2WNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:13:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E1D992A0994
Subject: Re: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, twawrzynczak@chromium.org,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20200422222242.241699-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bc570981-be55-a34e-b40d-54640a1c496b@collabora.com>
Date:   Thu, 30 Apr 2020 00:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422222242.241699-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the patch.

On 23/4/20 0:22, Prashant Malani wrote:
> Add properties for mode, orientation and USB data role switches for
> Type C connectors. When available, these will allow the Type C connector
> class port driver to configure the various switches according to USB PD
> information (like orientation, alt mode etc.) provided by the Chrome OS
> EC controller.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

This patch still needs a review from Rob.

> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> index 6d7396ab8bee..b5814640aa32 100644
> --- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -21,7 +21,21 @@ properties:
>      const: google,cros-ec-typec
>  
>    connector:
> -    $ref: /schemas/connector/usb-connector.yaml#
> +    allOf:
> +      - $ref: /schemas/connector/usb-connector.yaml#
> +      - type: object
> +        properties:
> +          mode-switch:
> +            description: Reference to a DT node for the USB Type C Multiplexer
> +              controlling the data lines routing for this connector.
> +
> +          orientation-switch:
> +            description: Reference to a DT node for the USB Type C orientation
> +              switch for this connector.
> +
> +          usb-role-switch:
> +            description: Reference to a DT node for the USB Data role switch
> +              for this connector.
>  
>  required:
>    - compatible
> @@ -49,6 +63,17 @@ examples:
>              data-role = "dual";
>              try-power-role = "source";
>            };
> +
> +          connector@1 {
> +            compatible = "usb-c-connector";
> +            reg = <1>;
> +            power-role = "dual";
> +            data-role = "host";
> +            try-power-role = "source";
> +            mode-switch = <&typec_mux>;
> +            orientation-switch = <&typec_orientation_switch>;
> +            usb-role-switch = <&typec_mux>;
> +          };
>          };
>        };
>      };
> 

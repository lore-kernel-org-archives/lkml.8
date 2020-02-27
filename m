Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBFDC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF6824688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgB0PMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:12:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:7443 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbgB0PMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:12:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 07:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="350704878"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 27 Feb 2020 07:12:17 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 27 Feb 2020 17:12:16 +0200
Date:   Thu, 27 Feb 2020 17:12:16 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@chromium.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
Message-ID: <20200227151216.GA18240@kuha.fi.intel.com>
References: <20200220003102.204480-1-pmalani@chromium.org>
 <20200220003102.204480-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220003102.204480-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 19, 2020 at 04:30:55PM -0800, Prashant Malani wrote:
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
>  .../bindings/chrome/google,cros-ec-typec.yaml | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> new file mode 100644
> index 00000000000000..97fd982612f120
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0-only
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
> +    description: A node that represents a physical Type C connector port
> +      on the device.
> +    type: object
> +    properties:
> +      compatible:
> +        const: usb-c-connector
> +      port-number:
> +        description: The number used by the Chrome OS EC to identify
> +          this type C port. Valid values are 0 - (EC_USB_PD_MAX_PORTS - 1).
> +      power-role:
> +        description: Determines the power role that the Type C port will
> +          adopt.
> +        maxItems: 1
> +        contains:
> +          enum:
> +            - sink
> +            - source
> +            - dual
> +      data-role:
> +        description: Determines the data role that the Type C port will
> +          adopt.
> +        maxItems: 1
> +        contains:
> +          enum:
> +            - host
> +            - device
> +            - dual
> +      try-power-role:
> +        description: Determines the preferred power role of the Type C port.
> +        maxItems: 1
> +        contains:
> +          enum:
> +            - sink
> +            - source
> +            - dual
> +
> +    required:
> +      - port-number
> +      - power-role
> +      - data-role
> +      - try-power-role

Do you really need to redefine those?

I think you just need to mention that there is a required sub-node
"connector", and the place where it's described. So something
like this:

        Required sub-node:
        - connector : The "usb-c-connector". The bindings of the
          connector node are specified in:

                Documentation/devicetree/bindings/connector/usb-connector.txt


Then you just need to define the Chrome OS EC specific properties, so
I guess just the "port-number".


thanks,

-- 
heikki

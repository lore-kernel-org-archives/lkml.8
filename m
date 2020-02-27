Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35915C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004F82467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GOcmXDtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgB0IlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:41:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51361 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgB0IlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:41:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so838689pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Afd+MLvDplTwBwSna/EVUGN2UMhtqB+M1tf64vivxQ0=;
        b=GOcmXDtHK6x5imPHf36gVCdj1C0whSvvQ3d9iB2ylXzQwirR8/8TXXAR7tAeyy2F5x
         cOCueeFM6EjiXAI6+8tW0Kk7NFibH8C8A/Ocu82A6CqQgJSyEgW3FTz20l83xzK+IE3s
         nevtKPeH6JP5CQ7AVuHx7HWEhUh1NzohjMpUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Afd+MLvDplTwBwSna/EVUGN2UMhtqB+M1tf64vivxQ0=;
        b=V2zCJzT/RzJ5jXLRnwgMZKpnaO0LF5QTbtdIO1/NRux1hrKSDRUGtnSU9sw2Q4XX48
         OyHxkdgVnktbOODtgGf85WMOuks2aXU9mvf1Com1lkYogSB1cKNpzeLEC357fwcD5tkC
         VFMZnYFectjphgnx0LbPrLNrvqgVvOB5fm5B2JCPvNNrH12VAlqvRjiDtR6GsxHVZywk
         eD0HFHUI7UHYilAaqPnYXil0P4AOlKYIRmiBu3qFov5e6ciqoqON6vaGqL442sGy4YwH
         i7TINzuJIACJ8aGxKxCQIkkVvQh/RIwLZkgLxVG9pAC+n6Q2cSoIFgYu9jsCeUoQLcZA
         R4bg==
X-Gm-Message-State: APjAAAVBCuFdDS2Kv0Yzh6QS48/syEUqM/8pQwkd92sO/gDdvQHb4IYe
        N46RKx8nXEt2UDKGMIFfjnxJZg==
X-Google-Smtp-Source: APXvYqyhpBXPC6ndBBst5Cm9v9oUJ2DimOJeFcJjFWTEHd/fqj144NkFQbKzUIRGGz+i33odUNvfkw==
X-Received: by 2002:a17:90a:f496:: with SMTP id bx22mr3761595pjb.115.1582792874540;
        Thu, 27 Feb 2020 00:41:14 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u12sm5634137pgr.3.2020.02.27.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 00:41:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200220003102.204480-2-pmalani@chromium.org>
References: <20200220003102.204480-1-pmalani@chromium.org> <20200220003102.204480-2-pmalani@chromium.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: Add cros-ec Type C port driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Feb 2020 00:41:13 -0800
Message-ID: <158279287307.177367.4599344664477592900@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know what happened but my MUA can't seem to thread these patches.
I wonder if something got messed up during send?

Quoting Prashant Malani (2020-02-19 16:30:55)
> Some Chrome OS devices with Embedded Controllers (EC) can read and
> modify Type C port state.
>=20
> Add an entry in the DT Bindings documentation that lists out the logical
> device and describes the relevant port information, to be used by the
> corresponding driver.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>=20
> Changes in v3:
> - Fixed license identifier.
> - Renamed "port" to "connector".
> - Made "connector" be a "usb-c-connector" compatible property.
> - Updated port-number description to explain min and max values,
>   and removed $ref which was causing dt_binding_check errors.
> - Fixed power-role, data-role and try-power-role details to make
>   dt_binding_check pass.
> - Fixed example to include parent EC SPI DT Node.
>=20
> Changes in v2:
> - No changes. Patch first introduced in v2 of series.
>=20
>  .../bindings/chrome/google,cros-ec-typec.yaml | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-=
ec-typec.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-type=
c.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> new file mode 100644
> index 00000000000000..97fd982612f120
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Can it be GPL or BSD 2 clause?

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
> +          this type C port. Valid values are 0 - (EC_USB_PD_MAX_PORTS - =
1).

What is EC_USB_PD_MAX_PORTS? Can this be done through a reg property
instead?

> +      power-role:
> +        description: Determines the power role that the Type C port will
> +          adopt.
> +        maxItems: 1

I don't think this is necessary with enum below. schema can figure out
that max is 1.

> +        contains:
> +          enum:
> +            - sink
> +            - source
> +            - dual

Other bindings have newlines between properties. Can you please add them
to improve readability?

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
> +        description: Determines the preferred power role of the Type C p=
ort.

How does this interact with power-role above? Is it different?

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
> +
> +required:
> +  - compatible
> +  - connector
> +
> +examples:
> +  - |+
> +    cros_ec: ec@0 {
> +      compatible =3D "google,cros-ec-spi";
> +
> +      typec {
> +        compatible =3D "google,cros-ec-typec";
> +
> +        usb_con: connector {
> +          compatible =3D "usb-c-connector";
> +          port-number =3D <0>;
> +          power-role =3D "dual";
> +          data-role =3D "dual";
> +          try-power-role =3D "source";
> +        };

I thought that perhaps this would be done with the OF graph APIs instead
of being a child of the ec node. I don't see how the usb connector is
anything besides a child of the top-level root node because it's
typically on the board. We put board level components at the root.

Yes, the connector is intimately involved with the EC here, but I would
think that we would have an OF graph connection from the USB controller
on the SoC to the USB connector, traversing through anything that may be
in that path, such as a USB hub. Maybe the connector node itself can
point to the EC type-c controller with some property like

	connector {
		...
		type-c-manager =3D <&phandle_to_typec_manager>
	};

So in the end it would look like this (note that the ec doesn't have a sub-=
node
to make a driver probe):

	/ {
		connector@0 {
			compatible =3D "usb-c-connector";
			label =3D "left";
			reg =3D <0>;
			power-role =3D "dual";
			type-c-manager =3D <&cros_ec>;
			...

			ports {=20
				#address-cells =3D <1>;
				#size-cells =3D <0>;

				port@0 {
					reg =3D <0>;
					left_ufp: endpoint {
						remote-endpoint =3D <&usb_controller0>;
					};
				};
			};
		};

		connector@1 {
			compatible =3D "usb-c-connector";
			label =3D "right";
			reg =3D <1>;
			power-role =3D "dual";
			type-c-manager =3D <&cros_ec>;
			...

			ports {=20
				#address-cells =3D <1>;
				#size-cells =3D <0>;

				port@0 {
					reg =3D <0>;
					right_ufp: endpoint {
						remote-endpoint =3D <&usb_controller1>;
					};
				};
			};
		};

		soc@0 {
			#address-cells =3D <1>;
			#size-cells =3D <0>;

			spi@a000000 {
				compatible =3D "soc,spi-controller";
				reg =3D <0xa000000 0x1000>;
				cros_ec: ec@0 {
					compatible =3D "google,cros-ec-spi";
					reg =3D <0>;
				};
			};

			usb@ca00000 {
				compatible =3D "soc,dwc3-controller";
				reg =3D <0xca00000 0x1000>;

				ports {
					port@0 {
						reg =3D <0>;
						usb_controller0: endpoint {
							remote-endpoint =3D <&left_ufp>;
						};
					};
				};
			};

			usb@ea00000 {
				compatible =3D "soc,dwc3-controller";
				reg =3D <0xea00000 0x1000>;

				ports {
					port@0 {
						reg =3D <0>;
						usb_controller1: endpoint {
							remote-endpoint =3D <&right_ufp>;
						};
					};
				};
			};
		};
	};

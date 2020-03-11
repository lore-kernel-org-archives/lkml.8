Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:46575
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKHjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:39:18 -0400
From: Peng Fan <peng.fan@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: RE: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Date: Wed, 11 Mar 2020 07:39:14 +0000
Message-ID:
 <AM0PR04MB4481494EE01E944F7000BA1288FC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582099197-20327-2-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311073914.lFYN0oyGcHXG7HS3BWmdCiKfclF5HgU7h1InEDGPWak@z>

Hi Rob,

> Subject: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding doc

Would you help Ack if you are fine with this patch?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX7ULP Power Management Controller binding doc
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32
> ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> new file mode 100644
> index 000000000000..992a5ea29d39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id:
> http://devicetree.org/schemas/bindings/arm/freescale/imx7ulp_pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX7ULP Power Management Controller(PMC) Device Tree Bindings
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx7ulp-pmc0
> +          - fsl,imx7ulp-pmc1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    pmc0: pmc0@410a1000 {
> +        compatible =3D "fsl,imx7ulp-pmc0";
> +        reg =3D <0x410a1000 0x1000>;
> +    };
> +...
> --
> 2.16.4


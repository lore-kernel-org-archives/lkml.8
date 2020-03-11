Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D5C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E151B20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oZIP3sJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgCKHjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:39:18 -0400
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:46575
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgCKHjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:39:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpNJ34XLPBoZ33wnZ4woWHzV5c65lwqO29voRV4lD2NT/5OmrtGefupWwBB0CGFORjPlX5Ea5RRf6/NoYINvFski3uigp/P15YmgdomVvXf8UjGSnUQQ1kgfC+A01zikPmdUWn16lAClpsJVJlqZRvsuHglfsIWW4OmPj3Rt3sduMJa6J+ksTkAogg4lYNQjPklC8S94h/v4bB0QP63Ck11CiEgHkwtqoVTQCnl9jVsdDpUU+NesafKrelE+rk5BZXi4z8ndnCOzvHhdevwVmktt3m939MQUxHBmuFTmFOzh95Ky6t2uOIueMgyvXpjTanmov7tvXRGAz/CXsL6qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X3dSggdw2zV0k3YqLvekqhW3g/nXy7gqCOhy4khT0c=;
 b=f6qHSeT7+H7Bnq7sm1GAqeOtesX5NZJ5kJu4ktC3gMRusi21mIWmgP+VAgug7ciKjoIPuxMuVlawVxyNJuOnXnlRPYoAHrnfeTIbkr8FZ52QzCtkBizD7ZDMMCPo8fqN1qDb7Ff64li6O93WYoJE9o9b8N11HHKFVsOfMMnGHFyuTrj+NjeqQ1pjfoDZVa6Ktt8zGfB/zJm7rbA5p4uZTD3YEiYuDU0awBhmi8bng9IAyhlck02UdX3CTRJNjYXFWLo5/kaOByv2hYmTd4ddlNvlyLNyph5ca7mnQTaZDH0VMC4L+OTuyTaCk4+PuC8fdQp/L2+vLQddSKslgYerMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X3dSggdw2zV0k3YqLvekqhW3g/nXy7gqCOhy4khT0c=;
 b=oZIP3sJ6/mwJYlmyzerSlQCUdBx9hQXk+VoB/8uE2Vq4YR/P1tPjSE/J7QSMUGpufV8DvyXOVboXxfc8Ghgk9VOY4/3BJyzoulFDGgCLf41Q6CEZeOh2MU2i6NOFfjyHo2jwz5f3Qx/zEp+6alckY88oH+vnRTCGbrnbOseL6ZE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6961.eurprd04.prod.outlook.com (52.132.212.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Wed, 11 Mar 2020 07:39:14 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 07:39:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
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
Thread-Topic: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Index: AQHV5vtwRU1Nn7bH00qi32AibjM/SahDIicQ
Date:   Wed, 11 Mar 2020 07:39:14 +0000
Message-ID: <AM0PR04MB4481494EE01E944F7000BA1288FC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582099197-20327-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75c7569a-3e20-4550-3361-08d7c58f4c60
x-ms-traffictypediagnostic: AM0PR04MB6961:|AM0PR04MB6961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB69615BE7313D4B4F93DF62E388FC0@AM0PR04MB6961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:254;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(186003)(2906002)(54906003)(66556008)(33656002)(7416002)(66946007)(66476007)(66446008)(76116006)(64756008)(8936002)(71200400001)(5660300002)(9686003)(316002)(966005)(4326008)(55016002)(478600001)(7696005)(8676002)(6506007)(44832011)(52536014)(86362001)(81156014)(81166006)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6961;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sB1trWY+/25YY6EsknvGP14hrR2SUYhTHszhwZ8jc+gCqmkT0bIc8n9XsUqtmvuqp0OYlM2R35EMN8loZEQGgWudOI7Jb2XBGSI30101Arso6he+7LzHDNnwHZly13++meeUwM2gx9Ue9ifUH2ElJABf11mtuwnOoUrLU2XChg9tBChtgwGKzljJUliHfJ8IvmNQHk4IHlaaSjw4NJcOBptthtbRvrs/tDS3+KTvuSnNBn9SCF/pMEouWG/Ti7rZowDmAhLf7/Gk2dDQw7rO7+ej6AoXmAUtDGASWGzeAAlbkb18Iy893xYB8dzdvT4XbP2jH3zJstNtYvPreT7BwjIlUeB+UHvUpwe9SihXF9bDBRIEhcGMBWJ7YK0Mkbe5Kcgh+CeDEF4/JRLWhpxvzEeSRXvyALurpxAFVNJVAxt5dCd8WZGLoO2MIG9Of040X7ZECTNefDfRBB56iYQxl+AXcZXP5655YCXZrmreeyhpD6ld184k1Vks8rQNpMcHx52bwB7DHojOW3FiraWzlQ==
x-ms-exchange-antispam-messagedata: rRfBg8bmYxzz5PKYGIgQkrlmF808YMramVV9uvge7BIhSNEyijszIqIfEQzwvsUX9UGHZ0vfxMzFCN+rknVF/ZxXjcbPzObVS2pY+7rK2yocKOC+dEf1+wPW5/4S1A9FjeWaRKe5bKC18T6KG7odwg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c7569a-3e20-4550-3361-08d7c58f4c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 07:39:14.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIM0wHb0DEbWjB/Afr7DPHgflaubCnLjZsHsRee+AHZfdzQl/ihGs27leLiG+6sfUWAo/GpfjdXX7Cr2ZDv2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


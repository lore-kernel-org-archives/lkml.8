Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC2DC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507A520757
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e1sVRcZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgELCgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:36:05 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:4993
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727892AbgELCgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:36:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igQkySrJVBkr4s1JF6TrRAHaxsgfQXuisnokC3GRGd3SUd5mjxJ/m8DC2AeVMi8AVF7zStheAMNzSF6/eCMR6I10nCn7s2zK7JJxCKlxZbxRACESuR7P80Gqkxjtc2xWv3XKR7dXThgmJBwbeLtDh4C5MoCtoqM5GyzE9Ck0FKC3F6l1WtuBSbAiGUzfW637EnrOugq11Pw3DG6hQ0Z14k1gc+dtp9Mo76brWs5T/uQ13aDRPNJN0QRIqM2OoR5/9cJaQFJwL/qIC36J47N04Yk29KmVTStqKIPWwydGP2dQ1pgfXmbz79mudUAgRxGgXD8T6P872PziGTlc2miHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4fnxoXxjG/c1cP7weVq002E8gWnrBGssBy/cw2ku2A=;
 b=iWSjot1PrDHqlxckcJV5JvWieVPBcmFwqsHX8K5dv7uHVT/5jflrKT2XUz1j7uIiAA2Kp+wERnkOsVJLxAQEsD2sOvcHHOYvYdvUHwot+OkOfHjZspfcKhdmX2NXGwhmSBDfBGKpuCw/phrn/iMk5IQ+8u9byzLbJkjf7pfZ+VqOYryoVP7gaNcLwzzxcM/YIOi98o9+thU8+enbFYClbBhnQMX/HArItY6DPC8btCgro/ufzmcpqJt/ShbaE7mE4lfYVKqfFnUuGhny2Q/n7Zrh6FH/+MnDLSd4QfDj0bcl0YT+NBI/OS1HeVUzG4DwmFos8FdttFHO+pDZGcr+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4fnxoXxjG/c1cP7weVq002E8gWnrBGssBy/cw2ku2A=;
 b=e1sVRcZ8M+SfeRCq//PdIzQ1p3TZ6rpm4biIw8rQIHPwLs9gQWMun6/rcBUAkL5emaBktqR0gZc5wefBnR/S32MDDx5xBx+0bcpuhpZxCJHzPhXWaMYBOQ6HAASI4KGWKrOxzvwlqs7+jWRrfKYPBn48jJWYKN80ttiUv7sS58A=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 02:36:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 02:36:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V4 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Topic: [PATCH V4 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Index: AQHWEyRB6p299pXyrka3JlX8v+jW0aij5bXw
Date:   Tue, 12 May 2020 02:36:00 +0000
Message-ID: <DB6PR0402MB276087B375F073FA6989076488BE0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
 <1586954449-17463-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1586954449-17463-2-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea52583c-94da-4edb-0071-08d7f61d3552
x-ms-traffictypediagnostic: DB6PR0402MB2757:|DB6PR0402MB2757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB27576970EC5E3A0AE944319D88BE0@DB6PR0402MB2757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RED6GRc+VJ2K3mFiPTorTunniph9nvdF5IqGI6wk9qu8HBwhm3aMYc7ysezA8vH8CbNYxpy/awB9msooMrvcr+IAE7wYIwGaZGYWV7aHGQth90RyQuyygNbzOLNLLF3r0qheD1Krz7q0QIiYb3N7JEpXRvM46jn7uq0X2YWKf3+t3duBDSOIJiwrAukwEd2+CJgdpacqPhF3MmpWkQWBAsvYMnA0BTNk85AwSWSP6Bs50p1hdSx5LoPE+Cn8yjAKl3lHCkgDLox+OILoKkRvmF0BiDzu2Xmp8H/l1CTPwKgCykKaPCWEhwSEY/dTaXT2sN0DtLM3OzdN2Zdhm05bcB5Uh6FAih7sOfzRkiFwdVQOAe9p0KltY5njrdIxZMUrvsUGXwjAAoH7TrG5SfyU9HNpk5SOFt3F5pcgK3jJudzailMPbXCdUEmeXAkk7Rje7aZq7FKb+kZKD343WEoCJp4J2uRPGQjtN878ofKMr05fBEAXtSebQrtkBmVhzcB86LFt4shP2F9T9E19jMt++C4u7xcdirERLnp4d5o4Y3phL7ysYBMtLN0jqBk3+JJR0UBaH0WGA5Fnt8MnFayAKNQpBpunYOpU3ht3/9ZLnZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(33430700001)(4326008)(966005)(5660300002)(33656002)(44832011)(9686003)(33440700001)(8676002)(55016002)(2906002)(8936002)(66476007)(66556008)(7696005)(66446008)(64756008)(478600001)(76116006)(71200400001)(316002)(86362001)(54906003)(110136005)(26005)(186003)(66946007)(6506007)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 66l/1OnH6Ju80A1Ae0sQsSTHtvqsFB8C2sjTzroVwmHe1lOmWWl7NxFRue/XyTAoSEQ4KoGDQUvPirXC8QhgGGtPSnUC0ArurRm5KfB8aIf9gvIIj8g36ofljHZVSwpocD/a7fYzeCX9rL19cmFmeW465BPS+1cwCGINAmjG91Y0AshumL+0uycUKpb4Ztd/lcEFUrYTR7HF1OKp+RcMk9EVHg0sWDFdLm5mJYOlFo5Z/z0k6NrAq957fsmXdk9MbdzlRLtAuZKoKKLjPJ6oKeChPdqy4dn8EW7djHYY5If0/SY4XDkRPrL+zorxBQ+vtMjXbOx4RrvvWs78vCP4ihAw3i5lA9YIi3BrOSRIq7PqEFteeg9SIZCRkMQAJI0qIRfDlPQmwOt57vVeEkVkdBrqBJ3o93CnesaQv2GY3GuUdNgbRRe7LskL4DPQcaAkYmUvqxyUftRqvWtqeCq9wQAXGL/o/XKXS2Drp0aaUG/7u+pGTv1CjakhMmaW/k3S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea52583c-94da-4edb-0071-08d7f61d3552
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 02:36:00.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEVLbAWZ4r48BConsYGQtCO8VbKUKdZTWaTecqAWMyMZ3I/VU4UEFOsiy0ohCQDSjgAcr52HkCnYA4Lqd85NJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: [PATCH V4 1/4] dt-bindings: fsl: add i.MX7ULP PMC binding doc

Could I have your A-b for this patch?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX7ULP Power Management Controller binding doc
> pmc0 is used by M4, pmc1 is used by A7, they have different register name
> and usage.
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
> index 000000000000..c60903039718
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/imx7ulp_pmc.yaml#
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


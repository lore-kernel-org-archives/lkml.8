Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C8DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76552208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcd8ZiDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504208AbgDPJsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:48:36 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:6093
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503681AbgDPJsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQeeI7eZBkfa1ZQuJX+L59uLVHRriYug/9Mzb8/euEUxSHw2jOzaaWjeSZGj2LRTtjsymEQ5hmiQnUNMsPkv7CD1LlIdbbFLFi9X8OVqV5OD+qYHu/gImS3EW+W1263EoA+l99m2GLUBFn9RFw/O3Q6S7XriGLvx5hm6DI2vLWpToJ6gO4HIbkLsnz2eC1XMpHvYAPhxMzJZnjhi+ckE+ZsnvvawJTZ5StIvxvt244BykbMwmLOPgVN6+o8GFgW37ftFB/o+lxEgy9co5ipDoTcSiVQFuckc7nDOSlWobgaIDVyNP0Faf4NPkp1FQfuRljkXEitWKqum0PD4MXvBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFfEtUxSBPOydsEfgtacQJUVTWrwXzNvpGFy+kBIHQ0=;
 b=l1bjRyJpie2TWgiVJdpSpmD5spgBEK+rYY4mdTBfqmhvQOiGylMy7DCpzZsZitFsloDXr22R5ON8yWM8SkgK5tUtFq/yC4bONbdHYLH++n6WixqSPke9Ni3Dcj5ELkvuzA0FgfGbeNoqXYnW2da05qXtlztkNKWnLg7zlks8DYwvwFu0ExNAH+85xKg5PXj4Hur+QMbSYdF98wI4zVXnb+DkdyqvlHdHcpjiezUVetN3yEgdAvnCMafNPkrkW2Icm8I6FqbWIdFMVIN9KH8csEgKBTPjWMBZlZI41m2HwYsGd9KVv9Ym3PbrA7WnhpYQMYs/WZ8eC5BY/nrfVZeV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFfEtUxSBPOydsEfgtacQJUVTWrwXzNvpGFy+kBIHQ0=;
 b=gcd8ZiDnW05jnUctg55DlQUbddOGz2aFyI97X+nNTYl3l/nnnVHSGyBfVAwEg7QJEoI2F4V/S4lAFHt5Y67qgnHDGJ0tgBdE3SGZIsJb83ZduLLRm9hlpxf4ZD+n12fp5N4nG4rWV1/O1tFbeokrV8pUJeUEqtfQI87LAaMr5Hw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 09:48:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 09:48:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Thread-Topic: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Thread-Index: AQHWE7rnIXhaMxmp60Ko8ImmCqNkpah7fmcAgAABvHA=
Date:   Thu, 16 Apr 2020 09:48:08 +0000
Message-ID: <DB3PR0402MB391613C2B53CEE067E1C7EC7F5D80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587019158-12143-1-git-send-email-Anson.Huang@nxp.com>
 <20200416093932.2mkcyv4rs6v6a24a@pengutronix.de>
In-Reply-To: <20200416093932.2mkcyv4rs6v6a24a@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ffe423e-96f6-4af8-9fa4-08d7e1eb44c2
x-ms-traffictypediagnostic: DB3PR0402MB3835:|DB3PR0402MB3835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38359FDD559D28C5B83269C8F5D80@DB3PR0402MB3835.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66946007)(55016002)(478600001)(8676002)(6506007)(81156014)(52536014)(44832011)(2906002)(316002)(966005)(66476007)(64756008)(71200400001)(6916009)(76116006)(9686003)(33656002)(7696005)(86362001)(66446008)(66556008)(4326008)(26005)(8936002)(7416002)(53546011)(54906003)(5660300002)(186003)(45080400002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFC3t3xPdJIqatY5bWbHkmeUhvJr2J91SIX2/q+iF3DtpBpe2jdJyW4IQzglHJv234f4D0OSaCJ1Lu3Bd/TIg0Vfk7YgTeb5BsZRauGu5ihRUrE0MzcMA3ivvqlii3+lpeDXx+fAMlcfflYYfH8O1xaLXYy7hElA0aw0MnY8e4XIDaDwJ3j4g6UO1A+kVntW/0lOGCFSnFtRhg+yL/XSSF5GI/CdQV2/eSKRB6j7qkjqsHmN208sVo7VECCTDi+we27HcrWN6rUwTCStyTm6RI9a4A0bR6MKln16VZZzV9DgvLSJbAB9M19+IZxefapKzgPzPKfaZMvVjl237Up8LRNQfAa/fRj8Ulbtjup1nqriEix3qn6eUHL3WVz51bxtuQzZB0ePjEsQFwQ6EpltndvslHLF7eg04NVADVV9nXRuCQq6pK4/P4N5JU0ncxAt+j5uHM3WFHXECEFjBKDpm2cO93ShfXNFO9SRbxuje84=
x-ms-exchange-antispam-messagedata: DREShWuCI91PlTnjNctWATwdxgbeRRN9F4iTcFNVkNfFsPPAVVCO1A2qUszjsGFDAbHDqugZ6Fzbv/e4zRe9AytnbqDpeBJj5Ej3bqqddS0B+FqsDwZbKp2nigvFSQxSONMtAA0o2ejPb9kyMrvXkA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffe423e-96f6-4af8-9fa4-08d7e1eb44c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 09:48:08.2774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/ajJoEvi6ABGG05EKfLaGqksNVnPoeySRdFyf5nkZERwQIzEWcAOuj9pgKtoaSmrCsUhihatert3OUU9jHmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marco

> Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
> json-schema
>=20
> Hi Anson,
>=20
> On 20-04-16 14:39, Anson Huang wrote:
>=20
> ...
>=20
> > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > new file mode 100644
> > index 0000000..1c6e600
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tr
> ee.org%2Fschemas%2Fclock%2Fimx6q-clock.yaml%23&amp;data=3D02%7C01%
> 7Canson.huang%40nxp.com%7Ca840fd5be8c94d4d950608d7e1ea16a2%7C6
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637226267845578228&
> amp;sdata=3DIw1CkVBMqw3m6sox6C3khcMy0BHNCQ9v2k72q3CM6Xs%3D&a
> mp;reserved=3D0
> > +$schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice=
tr
> ee.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Canson.hu
> ang%40nxp.com%7Ca840fd5be8c94d4d950608d7e1ea16a2%7C686ea1d3bc2
> b4c6fa92cd99c5c301635%7C0%7C1%7C637226267845578228&amp;sdata=3DP
> Be2CEoDdMo9I1m3DHbITCyYxB4GF%2FigP%2FNd7YCopCQ%3D&amp;reserve
> d=3D0
> > +
> > +title: Clock bindings for Freescale i.MX6 Quad
> > +
> > +maintainers:
> > +  - Anson Huang <Anson.Huang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx6q-ccm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 2
>=20
> IMHO I would force them to have exactly two so we need
> minItems: 2 too here.

Actually, those 2 interrupts are NOT necessary for some platforms, such as =
i.MX platforms
do NOT enable them at all, so is it OK to force them to be '2' here?

Thanks,
Anson

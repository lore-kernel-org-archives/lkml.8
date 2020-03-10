Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D5C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEC92071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O9brKjw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgCJF45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:56:57 -0400
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:28067
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgCJF45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 01:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McaAmuj7Q0QvIbGaPH7s/ASgjyLrGh/RFI3BCCpNt7kbR6/wZ8Puk1laiCqTlIExFV8E2bq2Yey4oNQUNrUlQ+uTGbh5KreOzDPp6lr6jMHLigIy2b96aH+MTzx2GYqjd/ZnRA31UflDI5yfaGP//FI4tn/tdxEjyqStO/87MgD18QMTVNq0lCCh62Ud3mvZ0WDmf1UfU3WAbBWTf0/Jwe7HEM1/Sjaons/8Qqh8oHnsnLIQiR4BgeCTu6W6nVmPOFTRvAERfcrD2HJKS3fXghjcCcFOzJKMXv8jr24Vyxze4QdR6eiqZT3PhgCkZ/89CLzW/5BEb28tFn2yeoygGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcMgt5+FjbuSQIGgmIgrW9oVTFecoVxza5focuKAM3o=;
 b=QpcPCiHVu22TDb8OBHi+00HPw/jqSIzJaq8tO7GgB5Q2LSiteUIjGja3MaJYHTq8XhjYFM4Q9bGpb0aHRrk3rQ1JZcnsS3zCyX89cn15B1a0VEYzbSgZeJarBqUE2NjeEMypkyB8/VvjiIKJ9SKglCkjbFwExFTiTSGDuiOjRelzHhs0ctD16usScJto/6bhK/0Bsqw4/F4dW5ajemvvfIhp5AdavMWGAec3prNjTUC9NoQLuVu2duDwJ3TVXSUkE55RDP/v82X/4g8pMnXJAJ6sD+Y1b+UzAEd1oTY3lvrPbr6OIlNIOEUKC2erF62BuBKeMAaIHlKmaFx4p2cg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcMgt5+FjbuSQIGgmIgrW9oVTFecoVxza5focuKAM3o=;
 b=O9brKjw0t6sDXcO0hiFt2lc4WoVo6p4aK2bRUWTob5N2OlpSfDbJYwjQpMeSiCtgxZkHoZjs/P+Gm2BgteJvBHz+fThVHeCz5S7I3xl5YUIeCtvzCoVeVUPs9jRCLNTLoI17Jorv/EQTkh8zImJXgYu7bnTh2zqTABw1QDm1/4U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5443.eurprd04.prod.outlook.com (20.178.114.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 05:56:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 05:56:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Topic: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding doc
Thread-Index: AQHV5vtwRU1Nn7bH00qi32AibjM/SahBcXEAgAABWCA=
Date:   Tue, 10 Mar 2020 05:56:53 +0000
Message-ID: <AM0PR04MB4481C57A58B8FEC9DAC8C4A288FF0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-2-git-send-email-peng.fan@nxp.com>
 <20200310054945.GE15729@dragon>
In-Reply-To: <20200310054945.GE15729@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51ea4389-a3db-495d-5594-08d7c4b7d53f
x-ms-traffictypediagnostic: AM0PR04MB5443:|AM0PR04MB5443:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5443E46A8D7318EC492E16AA88FF0@AM0PR04MB5443.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(45080400002)(4326008)(478600001)(86362001)(66446008)(2906002)(66556008)(66476007)(64756008)(76116006)(8676002)(66946007)(71200400001)(7696005)(6506007)(9686003)(44832011)(55016002)(52536014)(186003)(54906003)(8936002)(33656002)(6916009)(26005)(7416002)(5660300002)(316002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5443;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QYv6osvwjJxva0ImmwlD0T3fj6nhGDrJney/zyJEFYBcIY5//HjU9qHTmPQjnllk1e+at6d02JAtb7XFmI+TNXav7+YxH1+9Tc8sW927OBEGPODedZ6CUz3IF1Q2bOiQI0L0nfb+JrEkEEBycdPtQbaGB/g5Nj3MPDW12C8z/Zj0RgOE0ZNQgTL1/QR2xCGqOysNeQVUBZvQinv1BC24KB4eKqfBUnOYktHw5KtDrjaF8hgkFP0NCt4zoKDp8Euu+glP5nEmzwQtQt3hv6DtZ5+3Ny7gd7O0wGV+Tp0EVIFrcAYmY8cwp4q3g8pYl6rzL8y+wLdizrKxl5FWmk5Y6AHu7hYabFKB2GzPUtGAHyucJ2AsGX1OgeQvarLT/IVHJ4ouJYogTYax5K91I+WafCH034SYIk/n75Lk8R9rsHPK7Ynshf+PPJIJ89T9v8Q6T0AJhG46Hld2FY07IJyEvDY5RdsSB1YMj7TjWFPIzyfOq0V0OzHic44W/pmNRQ+T6IWsYSsSfJdUGjl6gYWDhL/iRBsa7ttSR73e5DrwJfDCqpfCYUY67hin4ApB+SZEczcOHWLmT2ZLZ2LQny7+WcNIpqbfnahgbhbuc0Kl2ehdXTVWPC/AhcdksAdYi+EP
x-ms-exchange-antispam-messagedata: 0Ed2x27prJ4CVOffXEAJ8zzOHPnAeTSokKb4RuxTkQxWe9YzScIHBe2KzQJs1mLSkKF2jIVw1w2OxpyMisdZfRYqy6ZKdf0hvxx2sFWrKylFz/tP6z/5VWPREMbWbx3iKuWvQ11B0z+UpHS0dSYjZQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ea4389-a3db-495d-5594-08d7c4b7d53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 05:56:53.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cv7RKoMc+Rgib1cIBRCggFKARx3Qnv+x5N/b7PgfMB1OlIrqgOz5wHkk69M4uBd2xyslGR0sYBbBizcAy5Mpsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5443
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH v2 01/14] dt-bindings: fsl: add i.MX7ULP PMC binding =
doc
>=20
> On Wed, Feb 19, 2020 at 03:59:44PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX7ULP Power Management Controller binding doc
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> This is a new binding, and I would like get an ACK from Rob on it.

Rob,

Would you help Ack if you are fine with this patch?

>=20
> > ---
> >  .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32
> ++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> > b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> > new file mode 100644
> > index 000000000000..992a5ea29d39
> > --- /dev/null
> > +++
> b/Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fbindings%2Farm%2Ffreescale%2Fimx7ulp_pmc.y
> aml%
> >
> +23&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7Cc1a27bc0347845099
> 80908d7c4
> >
> +b6dbe3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63719416
> 196456308
> >
> +7&amp;sdata=3DEJausMj4W3mpgP%2BGdKpHpyTmZY4ipbxyUAurDVTKj5A%3
> D&amp;rese
> > +rved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cpe
> ng.fan%
> >
> +40nxp.com%7Cc1a27bc034784509980908d7c4b6dbe3%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C637194161964563087&amp;sdata=3D2UJYpLt69cd
> NiA%2BGA
> > +CI%2Bdqme0BFkqx%2FLrdt1fm3TzlM%3D&amp;reserved=3D0
> > +
> > +title: i.MX7ULP Power Management Controller(PMC) Device Tree Bindings
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - fsl,imx7ulp-pmc0
> > +          - fsl,imx7ulp-pmc1
>=20
> We usually do not encode number suffix in the compatible string.  Do they
> really have different programming model?

The register layout is different and some has different name/meaning.
And pmc0 is used by M4, pmc1 is used by Linux.

A brief intro about pmc0/1.
The PMC 0 has the following features:
 a high-power (HP) and a low-power (LP) Core Regulator;
 a high-power (HP) and a low-power (LP) Array Regulator;
 a high-power (HP) and a low-power (LP) 1.2V Low Voltage Detector (LVD)
monitor (in regulator input);
 a high-power (HP) 1.8V High Voltage Detector (HVD) monitor (in regulator
supply);
 a bandgap;
 a forward back bias (FBB) and a reverse back bias (RBB) regulator.
 a temperature sensor.
The PMC 1 has the following features:
 a high-power (HP) and a low-power (LP) Linear LDO regulator;
 a set of power switches;
 a high-power (HP) and a low-power (LP) Low Voltage Detector (LVD) monitor;
 a high-power (HP) 1.2V High Voltage Detector (HVD) monitor;
 configurable LVD/HVD sense point between regulator supply and regulator ou=
tput;
 a forward back bias (FBB) and a reverse back bias (RBB) regulator.

Thanks,
Peng.
>=20
> Shawn
>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    pmc0: pmc0@410a1000 {
> > +        compatible =3D "fsl,imx7ulp-pmc0";
> > +        reg =3D <0x410a1000 0x1000>;
> > +    };
> > +...
> > --
> > 2.16.4
> >

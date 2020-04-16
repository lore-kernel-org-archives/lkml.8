Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3561C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF272208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MblH+6m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505941AbgDPK75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:59:57 -0400
Received: from mail-vi1eur05on2075.outbound.protection.outlook.com ([40.107.21.75]:6037
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505897AbgDPK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvoDWYg4XxEueYcVKvrcCgmI6Z6O3+cP1l6AsWuHtjqg4S2TTsfMw11HhfB8IvG+0g22tL5y2SbnBUa4BrFquw6eKIyvYxQlZAVGArt/wCntc6rBaH7HQBZbuHoezdfI+pwYwD4OAuFTuEtsWobvRaHk95h+90pJsmdI/szkchW3BzzMoCp5VjAhd3YM3Q4Yv5xKnZs8s0l/0HRbWUUc0dwdylM2Yyz7gdhe3L+rKCHpED0iO92z30+ajHS8GCG/zdu+0aiy1imKriAkvsXbbWlTA62c4cyXYMHB/s+jy2bl7/DXvph/PLQsPNytkEsKMqkoUWReYJzNY1zK+DbaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvZ3UqyB84w50xqC6DmjHMedefp1hAc+hk2HOry1Lj4=;
 b=Lc4uQv4yUpSDhATE4TdUwpibtIQH98yISnssHs+2sBYwpN+K4cd+193J/7W26FQ/UMsq+rlJt50E+XwFmzTN+LTyaz0UOpYLwJKIhHGxSuL6+3G/x4a2/bif7DoZdegn9hLUBAdyt2tLHRHl6neaYY+ScbrjAliMKy41p/Lq18to67TkAa4N4DJYngacv9gU53TfGpVttI71USSptmTlCrEXVMxyDaucXifZDlOvNkykKbbTGEeCtsio73vetxcj8VGetWT22IuB1FzpOAu1xvrqdddTEdiZrmPaXZjecPQ6wJBohbXaF52Y6N6j19wQBXXoLrVPnuQBnS2sWfGdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvZ3UqyB84w50xqC6DmjHMedefp1hAc+hk2HOry1Lj4=;
 b=MblH+6m/R8ImZpZOKmx0lRznK7ngROCG9vs1J7zn7WamE+Ujn1TTEvRt7ERQmFobMqeH4SpyQoglqNzbFjMhE60P46c9rVW1wbBwdTUvbHzNNZdCTjkxK9xOu42LgNDjsxNX51wsawXpK8xkvbcs4Xbyu20V9SaBuhU56j2WEWQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3785.eurprd04.prod.outlook.com (2603:10a6:8:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 10:41:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 10:41:10 +0000
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
Thread-Index: AQHWE7rnIXhaMxmp60Ko8ImmCqNkpah7fmcAgAABvHCAAA6dgIAAAKhA
Date:   Thu, 16 Apr 2020 10:41:10 +0000
Message-ID: <DB3PR0402MB391655808CDD7AF9250671F7F5D80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587019158-12143-1-git-send-email-Anson.Huang@nxp.com>
 <20200416093932.2mkcyv4rs6v6a24a@pengutronix.de>
 <DB3PR0402MB391613C2B53CEE067E1C7EC7F5D80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20200416103803.eifgth77wi44pejc@pengutronix.de>
In-Reply-To: <20200416103803.eifgth77wi44pejc@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98f7f9fe-e233-4e91-4945-08d7e1f2ad51
x-ms-traffictypediagnostic: DB3PR0402MB3785:|DB3PR0402MB3785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3785019C6A777219185E7E23F5D80@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(966005)(7696005)(316002)(44832011)(478600001)(83080400001)(53546011)(26005)(6506007)(2906002)(71200400001)(7416002)(86362001)(33656002)(186003)(81156014)(8936002)(8676002)(54906003)(9686003)(64756008)(52536014)(76116006)(66556008)(66476007)(6916009)(66946007)(55016002)(4326008)(5660300002)(66446008)(45080400002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyRlFdgpdl+Mjbh4h7wm/t20x+DQmyRlm08bII2E8/BkVrS0amSlRyZ/gkoiFo8bAxcOgms0XqZeJYS1zX6oA03CRXIbe8/y6YFkyYDGRRD8AJ+u8R1cRT7qFvZBPJqIUlgwfIjccITdwX2NdD3hYoCzj+n9xD+QgTtnipVy/jOwRg/EFA2PMxbjdcc6FVlZLjvFlzzqmOPzQkmPX6J7jv8jtYAlBzorCTVWJ0aWVqQUkya0hY76QMiDCnnU0m7ewus2quez/7bM1njE+SXxDj3YeJs5rG9WgKvXvVn0AQpskVvh0p23nQH0N353DG+/IVBUb/weNvlwK1mO5TjNpx7UktFZf9WFLtvY1aXEe3ShIAWVgfqG5fBolz76LTMqRShSkgQ52ynswI0BjipgF4qPna4oORjwNOf/C1LKIenPxrfzMhim2sJCRdrOhDWOqi/BMCz+0zWgl4UWFwjqergoKFv05AAipeJjR3mNC+XELNgTnAuYeVBVeFareeLavOci0UrFWt2mxSBOfSjblA==
x-ms-exchange-antispam-messagedata: /MBGvdcXpNWPkTllpIMPLWTmknw1v/8+l7O84lE+TYP7DTypBOocnT/1zfHQiDl6Q/3WyaxINNFArqzZ/TggaAnZgOr9O8n8rw6EswB0jxwQWA46mKFyMuVSMjwAiKFxZliN1LvomTQflJ+9x5V4GA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f7f9fe-e233-4e91-4945-08d7e1f2ad51
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 10:41:10.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UN+NDisR/hkdZHwsyaO26j/u0sM0NhuJeodsrxj6suHIzgWYwHRmzlmi8Hy53d6DRPFP34jo2HEtCbLOwWEwnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
> json-schema
>=20
> On 20-04-16 09:48, Anson Huang wrote:
> > Hi, Marco
> >
> > > Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock
> > > to json-schema
> > >
> > > Hi Anson,
> > >
> > > On 20-04-16 14:39, Anson Huang wrote:
> > >
> > > ...
> > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > > new file mode 100644
> > > > index 0000000..1c6e600
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > > @@ -0,0 +1,66 @@
> > > > +# SPDX-License-Identifier: GPL-2.0 %YAML 1.2
> > > > +---
> > > > +$id:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde=
v
> > > icetr
> > >
> ee.org%2Fschemas%2Fclock%2Fimx6q-clock.yaml%23&amp;data=3D02%7C01%
> > >
> 7Canson.huang%40nxp.com%7Ca840fd5be8c94d4d950608d7e1ea16a2%7C6
> > >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637226267845578228&
> > >
> amp;sdata=3DIw1CkVBMqw3m6sox6C3khcMy0BHNCQ9v2k72q3CM6Xs%3D&a
> > > mp;reserved=3D0
> > > > +$schema:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde=
v
> > > icetr
> > >
> ee.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Canson.hu
> > >
> ang%40nxp.com%7Ca840fd5be8c94d4d950608d7e1ea16a2%7C686ea1d3bc2
> > >
> b4c6fa92cd99c5c301635%7C0%7C1%7C637226267845578228&amp;sdata=3DP
> > >
> Be2CEoDdMo9I1m3DHbITCyYxB4GF%2FigP%2FNd7YCopCQ%3D&amp;reserve
> > > d=3D0
> > > > +
> > > > +title: Clock bindings for Freescale i.MX6 Quad
> > > > +
> > > > +maintainers:
> > > > +  - Anson Huang <Anson.Huang@nxp.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: fsl,imx6q-ccm
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 2
> > >
> > > IMHO I would force them to have exactly two so we need
> > > minItems: 2 too here.
> >
> > Actually, those 2 interrupts are NOT necessary for some platforms,
> > such as i.MX platforms do NOT enable them at all, so is it OK to force =
them
> to be '2' here?
>=20
> Why do we list them as required if they are not required? Currently all
> 5 platforms adding both irqs so this won't break anything here.

OK, I will make the minItem/maxItem to 2 in next version.

Thanks,
Anson

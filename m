Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B70C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C173A206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FCnnCnIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD1BIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:08:18 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:21312
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbgD1BIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:08:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnp0pI95npxur8b1v8V0pnSANjZjdW8jTemYgZuzrrhA/Xmc9F8qxMwNUc34QSGVbYVSXUtyW4HPwKhpw1UIskei/Wp61ONREdVUxhhoRCpyuFpbo3Vde+D/p8KFnhnYD67eH/zn6IHV6YnkYZ//tuhIX81lS4aAodQ2OBceUsf5ygmC/L+Vcz40L9AvCunxRpZ28ACk4tTfq/tT7lAwGfME++XETC/lF8hHAoVob9FgTwuiGkvjryYDDqWgu/fd9HFH0FuBEHcu7iVe5qhuEBQkQkrTrKIqmDWvQzkue7K68ECRHZJi/PcIkIZV0prxJJKOPN/4KlM8morEb03iBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbCAKYXzXLvUpEIshvpVq1AbAwGgFLNoxHJqs4pwWOE=;
 b=T2IO/ha6exrEriZIve4QTziuz24XGFWPUiF06YpaI8FTCDi/9YyRH3gc8tmnp5xSmWIGk9zGJxGFg4LsHqJKLDwhXxGD9OAlW4XTjalzbk6QOpzstM6KtO/krLe6np7rHms8CaKsxanB4G61DX7yAC5OgXT98SAmwTclq4ulhpSmTyDQ+gbyCfjl5IJh2SPZ+4d6yQcgRjnrcg6Zc2V4R2IeFDX5X4hDWPYCXZapq9hxHlRzcLh8qxy25skiMFo04t67VZ2mQwG6rZrVxXRnbT098aUtnX81Ng629KYloT6nF2+8cePZGtmemfq0P5TvTGdSGvLbuGLd860Ef180Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbCAKYXzXLvUpEIshvpVq1AbAwGgFLNoxHJqs4pwWOE=;
 b=FCnnCnInWauVp3U66IKKZqQ9BT8qb3u9xhdzA6280Rrh8t5T3Gx28/YXt2X2KcHd36TaSEjGEBoDg44Plp58J5iHaR1garXACHM5dAvbFahsRp1yJB5Am8CCCN/gyvsrcwHGgS0HSEd1ji0u65SOwwsieX8dAeV1goWwiA3JMHM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2759.eurprd04.prod.outlook.com (2603:10a6:4:a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 01:08:13 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.020; Tue, 28 Apr 2020
 01:08:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Topic: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Thread-Index: AQHV+FjOyMJp4JjxAkWF8jtS4KMMQqiOAaZg
Date:   Tue, 28 Apr 2020 01:08:12 +0000
Message-ID: <DB6PR0402MB2760D005442F4AF283F89B1B88AC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB69418E9348D5765B4AE01D18EED00@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760726D128E4BA868F03D9488AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <VI1PR04MB694162B89953B58266395091EEAF0@VI1PR04MB6941.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB694162B89953B58266395091EEAF0@VI1PR04MB6941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 758498ee-021a-4f91-7c6a-08d7eb109fef
x-ms-traffictypediagnostic: DB6PR0402MB2759:|DB6PR0402MB2759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2759C2D32F87CE0FBDF3B16488AC0@DB6PR0402MB2759.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(6636002)(86362001)(186003)(26005)(4326008)(52536014)(33656002)(478600001)(55016002)(71200400001)(81156014)(66946007)(7416002)(2906002)(8936002)(316002)(66476007)(5660300002)(9686003)(54906003)(66446008)(7696005)(8676002)(6506007)(66556008)(64756008)(76116006)(110136005)(44832011)(53546011);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNDXW13XYMw/17h+OTPs7qz949PkmudYbWXrxVrwHa09XHgkfmLZ2GviS8X4/WxmgSycAkL+ulGoSUQG+AvSET1oA/BKhLYbk9Gf2mpJDM1mzHwPPn56U6swIaUNNfBjIVN0okLJ/7xs7HCelyaB+bhy5sPdmyHqL+D+fawd+7+03H8TYZx/O+YOYWLTZPfLXV5oYQF7mCtj8NhsLYaI+Ouj3dB8IhvAZh3CdusYEG96XZsF5Hi+KyUOgnEDH4e5Flyo32zT5SQ1ojUuAEvptpGGIxP9ye6nXsvDzd1FJADOhvVVDFzVpsUEp1bSnchEsZCvVNJtljfGcyRnEQB+Edo6iCxHFn37SUB6wJ+w2T3BwABAa9/GNxkiIlTp8z6HwvQx/HN9D3GJ6W7rOdBHoFVrTGzVBz7vjZM2EkevlDo5/nJmRRqfKv+IVM21tTFi
x-ms-exchange-antispam-messagedata: pPpdlJhqdIF4DFqVJbFm1CEA6b3guUXjBUwFEEYGyOD6sHPH70igUJOOeMiVz1zxYUx4yX46DYaUSreiFP8QLfDt7GjzweW6ARtDl+zjP6oT3OY+066qS/CCjCsTi/J9WJb3dt6ybbWFzA9eDub2WKrkzU9qyDYFFiW/E30mQzX/vYwOkqhKFvuXF56tU/qMFIMS/WxT08i6aln9RxuHsNtBXMcBoLySIUwCDoBGtYeCaLIHbS+LHU98aGoQdWpjMmfh0iz2HunyuKCbEq+e4IVFCkPdwDkNHlbNiDpK9G6O6H+xkdmm5wvnAehsVaOiG4a3xW4+a3AhKKi3/melrNL8Jelh+jMDZLf4MPXS/gEYvUMGJoYIq5Lgz2P/vfeW+tm+z6KNOY1fHKWOiRULVDu1W/HO/OKEqh2kw4IvUyqtVVT6j5KAlgVBZs3ph5XHiwGJwXP1E5oM0d8dSD73SUsrJbApoSfOnuUEs4W5wghOo9CeO5sufWhEUZx4Z8+tI8fSTCZNWLgsUnOCorFCXgQkjMSSr8QErkbsDLEMrCP2qDk1dnXv6vf+x7gO2kLuMrYWGVjJtbx2SSGe391F/TCAXkRxKx0gDPSsPL/1Vd9WHxRKVtaGu9wHBbNm9ODrRo1vHcjZTye7Gr84TtA2sm3iLPq2BnuIXFkUYcugNrn2eF5mKnjcF9Mb+Iu+BP5b9Z3wBYLNRdSp0DqPIBadBQNU52aTO3V3fmfn6nwh/dwY71uqUnpquUcVuSWMlkYYJwYqiZ+MOwt0wBq+DCYHv8lUkdQd91NLqMGQRpc7dA8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758498ee-021a-4f91-7c6a-08d7eb109fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 01:08:12.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Prmns/pJxcugQFHNNNBS3P3ft323GBjiAw5dl3Hd2LF55N2gMUXCQ9ajBv452MXloLquxUh7wXnYZ8VPYU/txA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite
> clk
>=20
> On 2020-04-27 12:15 PM, Peng Fan wrote:
> >> Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M
> >> composite clk
> >>
> >> On 2020-03-12 12:27 PM, Peng Fan wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> The CORE/BUS root slice has following design, simplied graph:
> >>> The difference is core not have pre_div block.
> >>> A composite core/bus clk has 8 inputs for mux to select, saying clk[0=
-7].
> >>>
> >>>               SEL_A  GA
> >>>               +--+  +-+
> >>>               |  +->+ +------+
> >>> CLK[0-7]--->+  |  +-+      |
> >>>          |    |  |      +----v---+    +----+
> >>>          |    +--+      |pre_diva+---->    |  +---------+
> >>>          |              +--------+    |mux +--+post_div |
> >>>          |    +--+      |pre_divb+--->+    |  +---------+
> >>>          |    |  |      +----^---+    +----+
> >>>          +--->+  |  +-+      |
> >>>               |  +->+ +------+
> >>>               +--+  +-+
> >>>               SEL_B  GB
> >>>
> >>> There will be system hang, when doing the following steps:
> >>> 1. switch mux from clk0 to clk1
> >>> 2. gate off clk0
> >>> 3. swtich from clk1 to clk2, or gate off clk1
> >>>
> >>> Step 3 triggers system hang.
> >>>
> >>> If we skip step2, keep clk0 on, step 3 will not trigger system hang.
> >>> However we have CLK_OPS_PARENT_ENABLE flag, which will unprepare
> >>> disable the clk0 which will not be used.
> >>
> >> As far as I understand when switching from clk1 to clk2 this is done
> >> by temporarily switching the rightmost SELECT mux to whatever was in
> >> the spare SEL, which is essentially arbitrary from linux POV.
> >
> > No. The fixes in this patches has been confirmed by IC design owner
> >
> >>
> >> This is quite unexpected but in theory it might be desirable to use a
> >> third parent as a fallback.
> >
> > No. this will make things complicated. To CCM SEL_A and SEL_B, it is
> > controlled by a hardware counter. Saying you write n times to the
> > target interface.
> >
> > The mux will use n % 2 to choose SEL_A or SEL_B. write twice to make
> > sure SEL_A and SEL_B has the same value.
>=20
> What if SEL_A and SEL_B have different values on boot? The first time lin=
ux
> does set_parent it will switch to the other SEL_X which might be off.

If SEL_A and SEL_B has different values on boot, SEL_A or SEL_B will
be effective according internal counter. There must be one
chosen for mux usage whether SEL_A or SEL_B.

The CCM ROOT slice only has SEL_A and SEL_B, no SEL_X. SEL_A and SEL_B
both have 7 mux inputs.

Thanks,
Peng.

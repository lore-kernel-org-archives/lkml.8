Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7DB20738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+yly9yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFBF0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:26:41 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:48196
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbgFBF0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ4iXWHY4j1b0IEiicipu+8EImJMKFWgGrHeFSTKc7hZUJn+AdrdkKoP64+SO0Kq6hFiyq6yi2FAi+HKhYNlyokOIYJeCIHVnUSWVuCZUQWBSSsdLG3wpmu0Qk4KTY0u3GtpuVJ+rP3iS8utrpmakauquu0Fydjh2QnJoRSYaE4snbxGMFAsAACCQ8vlCfCPZd0clXOhnxbio2LQiZ7nHQ0A4im8HX3ckq8jyamZkXOLl3VzjP7ZtrLlJXgev0jcQaRh+gcgjz4sMhzEjnt7f6Eqr+KnhS/V2YgBkjNW1lWFdP00vFIHELX2zQQbmsz+x0JYTH77Xp2ekFgOgV54xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKVhJhd3Xi+yW1wLT3bWz9pe5zueKTCki1C1UcCv0uc=;
 b=dGkgpAg1lpmzqgXp/a0NTZCSakHqHlh1WfnGTDhD9xTmGA/YbbxN2rA7anBdXEVHB/phGZL97KnFsLoGXEFhVdvuR+lGqo7pO/q7HfoiRHr8K6rgqOik3ZG6QOjy0jXZgEDGP8KJZ2bDcUUK8/wiKQ4UiWJa4axxY6idQOLsFDqtxXqIwjF94XSye4Bzf1KIzmFJuszaGyQkGWIulGoYphQWe1+gRJd5oAkmfqdOV/rD8RS/dyEmCJ3gKWNKkcw33PHWQLKqtfYywdV0NbglJ0ELPqcCiu3IZ5jC/as+2FaJq2V97wXEdJh/Y4O3GN3zKRVx5L0b40S/M0Mo2/yIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKVhJhd3Xi+yW1wLT3bWz9pe5zueKTCki1C1UcCv0uc=;
 b=g+yly9yjTgqVUijquJ9iwe1dMV1VcWRicIM7EtNUcoZCph0gULr1lEzdJGrURw5IKQCteldufb/GATvUzt68DtwsrY6d5RX44tn48W6nn0TMXI6tBbX+5hTSPLQh3mBRverce/lKh3D3qN9k/ATD3nv4Mie0w2P7CMuqOesfZNE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2887.eurprd04.prod.outlook.com (2603:10a6:4:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 05:26:35 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 05:26:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Topic: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Thread-Index: AQHWN+7rKaBs4BAoiEu6e8UDHht806jEzGYAgAAAQRA=
Date:   Tue, 2 Jun 2020 05:26:35 +0000
Message-ID: <DB6PR0402MB27606610A4606A7336E8E764888B0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
 <1590999602-29482-2-git-send-email-peng.fan@nxp.com>
 <20200602052448.fxepmwltc4465q4i@pengutronix.de>
In-Reply-To: <20200602052448.fxepmwltc4465q4i@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5504a5e9-39fc-4d5b-ab10-08d806b5845c
x-ms-traffictypediagnostic: DB6PR0402MB2887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2887930F968BB4586EC47DFD888B0@DB6PR0402MB2887.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DtKyt+Lb1zzCZB0oSBYBQBZ3wPWyKfWNoYGLQj9da8SxzWWI74qlmoszqekf8lqyZ+Zz8AynvfZcenM3VzC0qJ+obIpC2T1q76E4Ch3hG714XFVh3vw+DRqFb2ODP7zxUuso6x9+QZ/mFvpvG69HN3MAi+0Ww2iMTH9wnSWRUs6LkKtvs01Vbu5OMlHBr36M0dJTrQlAlGmnKtk5DUH+lBjEnwogla4LYwt6QhFFymQ16C1f9Al2ojivVgwJSTEWV8oXRCBm8hfqvtWACJVP2JQNfRn9FE3wIQAXfJRLUgW6E1wHAtVDxwWUOvGfgg6ouA2TsvLJEpnutPba/QuIXdNZ/fRHz3WAek8TsZLyIIdBYdQRHMqbL+56WS2iW2DfQ8ymP7zrEfi718Ney9gD3soiWk4GAzWJyHrbhiJAec1c7GNnyYaPJn9HpgezKZPPJH5P8aw/uZNjeDoCcyx8xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(55016002)(44832011)(33656002)(7696005)(8936002)(86362001)(6916009)(54906003)(66556008)(66946007)(9686003)(15650500001)(478600001)(966005)(2906002)(186003)(66446008)(64756008)(66476007)(52536014)(5660300002)(71200400001)(6506007)(26005)(83380400001)(7416002)(8676002)(4326008)(316002)(76116006)(83080400001)(15585785002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /IcnyGqny95ZGbaizuoWQkqSHoyODkX2wf6r8r4eNNLly2pj5mhKXTipaZK9WPN4X77jNhhe9N6iFcIae5+7WpG+vUKp8H+2MMQLj5SUlfhPIZ7BG5U6kkp6qrQe25bxe6kutZ2P7jE09tiCXS3oiSfmxdnacrsPRKUsCKUsEC/yBEuBU0PHfl8m0ok0sglreDiKoqxoJkZTqoP2Lb2wkuo85F44A6H2twMuv2QMA0VO5STFLyVOHYSLSnqYBopc5AFa4Mji6psEE7eZqM2cX++L/Mb6KghtDL8nD1sF4fOdBTeGR5GuVsVJUDGXAamZA2J3PhYKH/IVOFhE0OM3m1YCifKaLgKAsuKhNTKi4WqorYbTCXM/4BmfjGWzFv6Zdy+GOuS0p/oJj5XoQHpRrf9V87pLfUTpR+A2w7BIBbqBdbQsZjDEdkqqUWQ24iRr+O601TaV3q65bsAciq53WoB4gouCvIRbxGIJby8UgfvB81uZ5k4HEoKpgqH9l/yh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5504a5e9-39fc-4d5b-ab10-08d806b5845c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 05:26:35.1378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGOnjIbvDVxjOOKRc0wqbY6s90sUfNXO2RdeAOIN8jV6d9hbFfp6/JBD+bRatYaoxrcgHqZ0kFhFUovB/vjjFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NpaiwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvM10gZHQtYmluZGluZ3M6
IG1haWxib3g6IGlteC1tdTogc3VwcG9ydCBpLk1YOE0NCj4gDQo+IE9uIE1vbiwgSnVuIDAxLCAy
MDIwIGF0IDA0OjIwOjAwUE0gKzA4MDAsIHBlbmcuZmFuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJv
bTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgaS5NWDhNUS9NL04v
UCBjb21wYXRpYmxlIHN0cmluZyB0byBzdXBwb3J0IGkuTVg4TSBTb0NzDQo+ID4NCj4gPiBSZXZp
ZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvZnNsLG11LnR4dCB8IDMgKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJv
eC9mc2wsbXUudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFp
bGJveC9mc2wsbXUudHh0DQo+ID4gaW5kZXggMjZiN2E4OGMyZmVhLi45MDYzNzdhY2YyY2QgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gv
ZnNsLG11LnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L2ZzbCxtdS50eHQNCj4gPiBAQCAtMTgsNyArMTgsOCBAQCBNZXNzYWdpbmcgVW5pdCBE
ZXZpY2UgTm9kZToNCj4gPiAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiA+ICAtIGNvbXBhdGlibGUgOglzaG91bGQgYmUgImZzbCw8Y2hpcD4tbXUiLCB0
aGUgc3VwcG9ydGVkIGNoaXBzIGluY2x1ZGUNCj4gPiAtCQlpbXg2c3gsIGlteDdzLCBpbXg4cXhw
LCBpbXg4cW0uDQo+ID4gKwkJaW14NnN4LCBpbXg3cywgaW14OHF4cCwgaW14OHFtLCBpbXg4bXEs
IGlteDhtbSwgaW14OG1uLA0KPiA+ICsJCWlteDhtcC4NCj4gPiAgCQlUaGUgImZzbCxpbXg2c3gt
bXUiIGNvbXBhdGlibGUgaXMgc2VlbiBhcyBnZW5lcmljIGFuZCBzaG91bGQNCj4gPiAgCQliZSBp
bmNsdWRlZCB0b2dldGhlciB3aXRoIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlLg0KPiA+ICAJCVRo
ZXJlIGlzIGEgdmVyc2lvbiAxLjAgTVUgb24gaW14N3VscCwgdXNlICJmc2wsaW14N3VscC1tdSIN
Cj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQo+ID4NCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBUaGUg
ZnNsLG11LnlhbWwgd2FzIGFscmVhZHkgdGFrZW4gYnkgUm9iLCBzbyBvbmUgb3Igb3RoZXIgcGF0
Y2ggd2lsbCBicmVhayBieQ0KPiBtZXJnZS4gSSBhc3N1bWUgeW91IHNob3VsZCBkcm9wIHRoaXMg
Y2hhbmdlLg0KDQpZZXMuIEknbGwgcmViYXNlIHRoaXMgcGF0Y2ggYmFzZWQgb24gUm9iJ3MgdHJl
ZS4gVGhhbmtzIGZvciByZW1pbmRpbmcgbWUuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IA0K
PiBSZWdhcmRzLA0KPiBPbGVrc2lqDQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+IHwNCj4gU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAg
ICAgICAgICAgICAgIHwNCj4gaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZS8gIHwNCj4gMzExMzcg
SGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6DQo+ICs0OS01MTIx
LTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAg
ICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo=

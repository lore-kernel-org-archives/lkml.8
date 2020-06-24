Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB889C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8952077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T2wMo6Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbgFXCgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:36:23 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:34238
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387719AbgFXCgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:36:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikuMIyoXDvE93ygEoHh7dBnasxJCIg/Jy8Jq0bqSb7nDBPkl4rhizsduUlbqtv4OOuJwdRg5RvBY+8K26ViczXt6MJLH+YP1kSCMCSGNs7qdGfHohmmIN4TzuPdUE0L9iW6kazWAdX0Qbt+5hmTgT+ajc62JN+161o3aiTnMzOh4l/davtVUa2giopYmLxv1f+rdDyp4wSyq3upDaUWN9J3PL0eRld3Us20RVEcBdenZJrB5ubnkRisA+aa4coWMzwsJ82cEaZ8pkW/QvqxyrNzbh0xFRnxiXuBkCvqh0y6dojdWGZ3/81bPtKk3KnloF4KFkdoBxg+wvsSBqDj3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn0w2iPCoVw8STP6mjixMSCj+ZpvnoSY/ePl7yiVyhc=;
 b=MLX9EUiex1VHMpqaQO1gg0WRnwusMrr6PwMwNS65qJK5S1deKjXq/AoCtER/Ri/KIodJxy50EE3fhloXEs3b1vNKdxBqqs17PeVMVyEVl7apqhGyc4Rp22CGS4W4/jLmCT7pbnLdUvm/sEMn1i2GyIxvRGO9j2Hj2z0zxU/QY+UGNnpTr8YScwS8xJe2lc19lcsTcAlWIkJG814Th0ZTMBFcISQwNVBngWn1MxKV8vD+62rUC3j/rK32rIlumt3cMvlFmZKvWqO1LI+sR+mxta6gpnjiStBuYXGDjAMwNtLPx0UiuRc/vRGl40qcZyp7jioR8MUWMGhj0MFap7x1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn0w2iPCoVw8STP6mjixMSCj+ZpvnoSY/ePl7yiVyhc=;
 b=T2wMo6XqDktUoqNGTmemd51EZFz4d8SX59dVZfj5KnjYkV/A1V/j9HE6T4Gtfgf9K6D4U0k23+EQp2mKUwE0y1vrW8LW9G0ioBZWNva4H7kUt7D3lBuBFfLIi+7Ebobd9LgN4xM9BZKz1u9SY5cl/3+EyCN2Ph+odQbiqs2EpuM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB5660.eurprd04.prod.outlook.com (2603:10a6:10:a5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 24 Jun
 2020 02:36:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 02:36:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGlTieDV0WYc0SOGNv5XMQ0F6jcrBWAgAAcNCCAAONagIADPYYAgAS7CoCAAFGNAIAAB26AgAELZ4CAABbpgIAAA6hg
Date:   Wed, 24 Jun 2020 02:36:16 +0000
Message-ID: <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7218024-b6ec-4697-902a-08d817e75eba
x-ms-traffictypediagnostic: DB8PR04MB5660:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5660EFD2EC558D283545363DF5950@DB8PR04MB5660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZZ94fnX9c3biqUB7j6dhgPOvT35d3m4epj8BGVjuYpPBIdxVixA1Wyj3h+Hwr8pwSXB/2tIXoIfw2CK1gLhCQfM2gPkrErSLxNu61uDPRMd8BPwvYKrukmia3PLKbXxAdcF1TDSUqwTBWN18Arw4AcossRyj/IzHX+CC7jL7UzHR3jJe1+0gJREZf2Mr9S5fCRfBUGoZSmkp3P2kDYN9D4sWT0uQpGeivsjWYLWnwico6P4TMaQPApH0GpvWZife6rylLjx/4cPydK8dMexZDlSTqoZLDfNf8uhP4uD45JnnVdhAmQh04gLpkpuJoY5A9eE2DZEXwyCllq3tbJvzOh33gmrwt4AlvJDI/DNoM/Xv9bxwuPILZuUe1sNE0L3I83/T6VkwSDskuSNlc5S3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(478600001)(316002)(5660300002)(44832011)(8936002)(52536014)(7416002)(9686003)(110136005)(4326008)(55016002)(83380400001)(8676002)(76116006)(66476007)(26005)(66946007)(66446008)(7696005)(33656002)(6506007)(71200400001)(186003)(66556008)(53546011)(64756008)(2906002)(86362001)(921003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8dZJk0/shMWWU6mWnzhd67BbGEJcmkT4q5LQDe5xVvuVu/QCBllbn3oSmO13TiyqSZwp37eea8shgpEHJ0oCrTN7pj4GV3Gt/mear7GIiSwjRrjXyNioPcQkPg+oArcvUrouVbwnZazUBQCKlrRjzN+832AWRyq9uzlav/UwwkvkTb9TWyG6OzbGL3Pfzc+tqjjiX0ysqg8TM15GBNUA+mab1epoptmu/P4B4WeeIN/oeDh7QptBG2l1w6cehe5MswZwfZj4jpBsxu8xEUi9AmBQ1X1aQDKPVKd62G1Qi9bbvCEhwq38CozeiLWn9IGck+QfWJ9LYBAP3hYV65ffryDPP021cISBLa5P/vARYq3cvU83a3WxVlPjfIVCGlaooOaIYL8lVUOKbjy3Yjdgp1KeUoW1rJROVDvucAqmTT8jh+3CPelReoXDWlub8aoKrqUWMq0ccuu+QJaa889EXAnnccoSkfm6UnxGsmPyJqU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7218024-b6ec-4697-902a-08d817e75eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 02:36:16.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26OhHdnF8MAeLR2pYYXVUvchPVr1QUrzLsjPQTkOC87oYpKGJefM4mIwMohZhdvzrHtGNe/ycm3ghrNDOniKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMiAzLzldIGNsazogaW14OiBTdXBwb3J0IGJ1aWxk
aW5nIFNDVSBjbG9jayBkcml2ZXIgYXMNCj4gbW9kdWxlDQo+IA0KPiA+IEZyb206IFN0ZXBoZW4g
Qm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjQsIDIw
MjAgODo1OCBBTQ0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85XSBjbGs6IGlteDogU3Vw
cG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiBkcml2ZXIgYXMgbW9kdWxlDQo+ID4NCj4gPiBR
dW90aW5nIEFpc2hlbmcgRG9uZyAoMjAyMC0wNi0yMyAwMjowMDo0NykNCj4gPiA+ID4gRnJvbTog
U3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBK
dW5lIDIzLCAyMDIwIDQ6MzQgUE0NCj4gPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCBWMiAzLzld
IGNsazogaW14OiBTdXBwb3J0IGJ1aWxkaW5nIFNDVSBjbG9jaw0KPiA+ID4gPiBkcml2ZXIgYXMg
bW9kdWxlDQo+ID4gPiA+DQo+ID4gPiA+IFF1b3RpbmcgQWlzaGVuZyBEb25nICgyMDIwLTA2LTIy
IDIwOjQyOjE5KQ0KPiA+ID4gPiA+ID4gRnJvbTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwu
b3JnPg0KPiA+ID4gPiA+ID4gU2VudDogU2F0dXJkYXksIEp1bmUgMjAsIDIwMjAgMTE6MjggQU0N
Cj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85XSBjbGs6IGlteDogU3VwcG9y
dCBidWlsZGluZyBTQ1UNCj4gPiA+ID4gPiA+IGNsb2NrIGRyaXZlciBhcyBtb2R1bGUNCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBRdW90aW5nIEFpc2hlbmcgRG9uZyAoMjAyMC0wNi0xNyAxODo1
ODo1MSkNCj4gPiA+ID4gPiA+ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhw
LmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0g
bXhjLWNsay1zY3Uubw0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IExpa2Ug
aS5NWCBwaW5jdHJsLCBJJ20gbm90IHN1cmUgaWYgaXQncyByZWFsbHkgbmVjZXNzYXJ5DQo+ID4g
PiA+ID4gPiA+ID4gPiB0byBidWlsZCBjb3JlIGxpYnJhcmllcyBhcyBtb2R1bGVzLiBQcm9iYWJs
eSB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IHNpbXBsZXN0IHdheSBpcyBvbmx5IGJ1aWxkaW5nIHBs
YXRmb3JtIGRyaXZlcnMgcGFydCBhcw0KPiA+ID4gPiA+ID4gPiA+ID4gbW9kdWxlLiBBbmQgbGVh
dmUgdGhvc2UgY29yZSBsaWJyYXJpZXMNCj4gPiA+ID4gPiA+IGJ1aWx0IGluIGtlcm5lbC4NCj4g
PiA+ID4gPiA+ID4gPiA+IFRoaXMgbWF5IG1ha2UgdGhlIGNvZGUgYSBiaXQgY2xlYW5lci4NCj4g
PiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBXaWxsIGRp
c2N1c3MgdGhpcyB3aXRoIExpbmFybyBndXlzIGFib3V0IGl0LCBwcmV2aW91cw0KPiA+ID4gPiA+
ID4gPiA+IHJlcXVpcmVtZW50IEkgcmVjZWl2ZWQgaXMgYWxsIFNvQyBzcGVjaWZpYyBtb2R1bGVz
IG5lZWQgdG8NCj4gPiA+ID4gPiA+ID4gPiBiZSBidWlsdCBhcw0KPiA+ID4gPiBtb2R1bGUuDQo+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gT2theS4gQUZBSUsg
aXQncyBub3QgY29uZmxpY3QuDQo+ID4gPiA+ID4gPiA+IFlvdSBzdGlsbCBtYWtlIGRyaXZlcnMg
aW50byBtb2R1bGVzLg0KPiA+ID4gPiA+ID4gPiBPbmx5IGRpZmZlcmVuY2UgaXMgZm9yIHRob3Nl
IGNvbW1vbiBsaWJyYXJpZXMgcGFydCwgd2UgZG9uJ3QNCj4gPiA+ID4gPiA+ID4gY29udmVydCB0
aGVtIGludG8gbW9kdWxlIFdoaWNoIGlzIGxlc3MgbWVhbmluZ2xlc3MuDQo+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gV2hhdCBpcyB0aGUgYmVuZWZpdCBvZiBtYWtpbmcg
dGhlIGNvcmUgcGFydCBvZiB0aGUgU29DIGRyaXZlcg0KPiA+ID4gPiA+ID4gbm90IGENCj4gPiBt
b2R1bGU/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBVc3VhbGx5IHdlIGNvdWxkIHRyeSB0byBidWls
ZCBpdCBhcyBtb2R1bGUgaWYgaXQncyBub3QgaGFyZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9u
ZSBxdWVzdGlvbiBpcyBzb21ldGltZXMgdGhvc2UgY29yZSBwYXJ0IGFyZSBzaGFyZWQgd2l0aCBz
b21lDQo+ID4gPiA+ID4gcGxhdGZvcm1zDQo+ID4gPiA+IHdoaWNoIGNhbid0IGJ1aWx0IGFzIG1v
ZHVsZS4NCj4gPiA+ID4gPiBGb3IgaS5NWCBjYXNlLCBpdCdzIG1haW5seSBwYXRjaCA0Og0KPiA+
ID4gPiA+IFtWMiw0LzldIGNsazogaW14OiBTdXBwb3J0IGJ1aWxkaW5nIGkuTVggY29tbW9uIGNs
b2NrIGRyaXZlciBhcw0KPiA+ID4gPiA+IG1vZHVsZQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBUaG9zZSBsaWJyYXJpZXMgYXJlIGFsc28gdXNlZCBieSBpLk1YNiY3IHdoaWNoIGNh
bid0IGJ1aWxkIGFzIG1vZHVsZS4NCj4gPiA+ID4gPiBTbyB3ZSBuZWVkIGFuIGV4dHJhIHdvcmth
cm91bmQgcGF0Y2ggdG8gZm9yY2VseSAnc2VsZWN0JyBpdA0KPiA+ID4gPiA+IHVuZGVyIGFyY2gv
YXJtL21hY2gtaW14L0tjb25maWcgW1YyLDIvOV0gQVJNOiBpbXg6IFNlbGVjdA0KPiA+ID4gPiA+
IE1YQ19DTEsgZm9yIEFSQ0hfTVhDIFRoZW4gdGhlIHVzZXJzIGNhbid0IGNvbmZpZ3VyZSBpdCBh
cyBtb2R1bGUNCj4gPiA+ID4gPiBpbiBvcmRlciB0byBub3QgYnJlYWsgYnVpbGQuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBJZiBidWlsZC1pbiB0aG9zZSBjb21tb24gbGlicmFyaWVzLCB0aGUgaW1w
bGVtZW50YXRpb24gY291bGQgYmUNCj4gPiA+ID4gPiBhIGJpdCBlYXNpZXINCj4gPiA+ID4gYW5k
IGNsZWFuZXIuDQo+ID4gPiA+ID4gU28gSSdtIG5vdCBzdXJlIGlmIHdlIHN0aWxsIGhhdmUgdG8g
YnVpbGQgdGhlbSBhcyBtb2R1bGUuDQo+ID4gPiA+ID4gSG93IHdvdWxkIHlvdSBzdWdnZXN0IGZv
ciBzdWNoIGNhc2U/DQo+ID4gPiA+DQo+ID4gPiA+IFN0b3AgdXNpbmcgJ3NlbGVjdCBNWENfQ0xL
JyB3aGVuIHJlcXVpcmluZyB0aGUgY29yZSBsaWJyYXJ5IGNvZGU/DQo+ID4gPiA+IEluc3RlYWQs
IG1ha2UgaXQgYSAnZGVwZW5kcycgYW5kIHRoZW4gdGhhdCB3aWxsIG1ha2UgZGVwZW5kaW5nDQo+
ID4gPiA+IG1vZHVsZXMgKGkuZS4gdGhlIFNvQyBmaWxlcykgdGhhdCB3YW50IHRvIGJlIGJ1aWx0
aW4gZm9yY2UgdGhlDQo+ID4gPiA+IGNvcmUgbW9kdWxlIHRvIGJlIGJ1aWx0aW4gdG9vLiBPdGhl
ciBtb2R1bGFyIGNvbmZpZ3MgdGhhdCBkZXBlbmQNCj4gPiA+ID4gb24gdGhlIGNvcmUgd2lsbA0K
PiA+IHN0aWxsIGJlIG1vZHVsYXIuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSXQgc2VlbXMgbm90
IHdvcmsuDQo+ID4gPiBQYXRjaCA0IGFscmVhZHkgY2hhbmdlcyBpdCB0byBkZXBlbmQgb24gQVJD
SF9NWEMgd2hpY2ggY2FuIG9ubHkgYmUgJ1knLg0KPiA+ID4gW1YyLDQvOV0gY2xrOiBpbXg6IFN1
cHBvcnQgYnVpbGRpbmcgaS5NWCBjb21tb24gY2xvY2sgZHJpdmVyIGFzDQo+ID4gPiBtb2R1bGUg
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9LY29uZmlnDQo+ID4gPiBiL2RyaXZlcnMvY2xr
L2lteC9LY29uZmlnIGluZGV4IGRlZDA2NDMuLjY3ODExM2IgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL2Nsay9pbXgvS2NvbmZpZw0KPiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L0tjb25m
aWcNCj4gPiA+IEBAIC0xLDggKzEsOCBAQA0KPiA+ID4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjANCj4gPiA+ICAjIGNvbW1vbiBjbG9jayBzdXBwb3J0IGZvciBOWFAgaS5NWCBT
b0MgZmFtaWx5Lg0KPiA+ID4gIGNvbmZpZyBNWENfQ0xLDQo+ID4gPiAtICAgICAgIGJvb2wNCj4g
PiA+IC0gICAgICAgZGVmX2Jvb2wgQVJDSF9NWEMNCj4gPiA+ICsgICAgICAgdHJpc3RhdGUgIklN
WCBjbG9jayINCj4gPiA+ICsgICAgICAgZGVwZW5kcyBvbiBBUkNIX01YQw0KPiA+ID4NCj4gPiA+
IEJ1dCB1c2VyIGNhbiBzdGlsbCBzZXQgTVhDX0NMSyB0byBiZSBtLCBlaXRoZXIgdmlhIG1ha2Ug
bWVudWNvbmZpZw0KPiA+ID4gb3INCj4gPiBkZWZjb25maWcuDQo+ID4NCj4gPiBJc24ndCB0aGF0
IHdoYXQgd2Ugd2FudD8NCj4gDQo+IE5vLCBpZiB1c2VyIHNldCBNWENfQ0xLIHRvIG0sIHRoZSBi
dWlsZCB3aWxsIGJyZWFrIGZvciBpLk1YNiY3Lg0KPiANCj4gPiBXaHkgZG9lcyBBUkNIX01YQyBi
ZWluZyBlbmFibGVkIG1hbmRhdGUgdGhhdCBpdCBpcyBidWlsdGluPyBJcyBzb21lDQo+ID4gYXJj
aGl0ZWN0dXJlIGxldmVsIGNvZGUgY2FsbGluZyBpbnRvIHRoZSBjbGsgZHJpdmVyPw0KPiANCj4g
DQo+IEl0J3MgbWFpbmx5IGJlY2F1c2UgdGhlcmUncyBubyBLY29uZmlnIG9wdGlvbnMgZm9yIGku
TVg2ICY3IGNsb2NrIGRyaXZlcnMuDQo+IEl0IGp1c3QgcmV1c2VzIEFSQ0ggY29uZmlnIENPTkZJ
R19TT0NfWFhYIHdoaWNoIGNhbiBvbmx5IGJlIHkuDQo+IGUuZy4NCj4gb2JqLSQoQ09ORklHX1NP
Q19JTVg2USkgICs9IGNsay1pbXg2cS5vDQo+IG9iai0kKENPTkZJR19TT0NfSU1YNlNMKSArPSBj
bGstaW14NnNsLm8NCj4gb2JqLSQoQ09ORklHX1NPQ19JTVg3VUxQKSArPSBjbGstaW14N3VscC5v
DQo+IG9iai0kKENPTkZJR19TT0NfVkY2MTApICArPSBjbGstdmY2MTAubw0KPiAuLg0KPiANCj4g
SWYgc2V0dGluZyBNWENfQ0xLIHRvIG0sIHRoZSBwbGF0Zm9ybSBjbG9jayBkcml2ZXJzIHdpbGwg
ZmFpbCB0byBidWlsZCBkdWUgdG8NCj4gbWlzcyB0byBmaW5kIHN5bWJvbHMgZGVmaW5lZCBpbiB0
aGUgY29tbW9uIGNsb2NrIGxpYnJhcnkgYnkNCj4gQ09ORklHX01YQ19DTEsuDQo+IFNvIHdlIGhh
dmUgdG8gYXZvaWQgdXNlcnMgdG8gYmUgYWJsZSB0byBjb25maWcgTVhDX0NMSyB0byBtIGZvciBp
Lk1YNiY3Lg0KPiBPbmx5IGRlcGVuZHMgb24gQVJDSF9NWEMgbWVhbiB1c2VyIHN0aWxsIGNhbiBz
ZXQgaXQgdG8gbS4NCg0KSSB0aGluayBmb3IgaS5NWDYvNywgYWx0aG91Z2ggTVhDX0NMSyBpcyB0
cmlzdGF0ZSwgYnV0IGl0IGlzIHNlbGVjdGVkIGJ5IEFSQ0hfTVhDIHdoaWNoDQppcyBhbHdheXMg
InkiLCBzbyBNWENfQ0xLIGNhbiBPTkxZIGJlICJ5IiBldmVuIGl0IGlzIGV4cGxpY2l0bHkgc2V0
IHRvICJtIiBpbiBpbXhfdjZfdjdfZGVmY29uZmlnDQpmaWxlLiBTbyB0aGF0IG1lYW5zIE1YQ19D
TEsgY2FuIE9OTFkgc3VwcG9ydCBidWlsdC1pbiBmb3IgaS5NWDYvNyBTb0NzLCBhbmQgdGhhdCBp
cyB3aGF0DQp3ZSB3YW50Pw0KDQpBbnNvbg0K

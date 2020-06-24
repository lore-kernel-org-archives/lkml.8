Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0333720874
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gN0a+k9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbgFXCT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:19:57 -0400
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:9920
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387855AbgFXCT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:19:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMTYTc6ZuCnHg5wKpkyM2kyzyaucpLG4s3G6JWCgd5hvN01CxIivy9vZFxMMl98UQ+Mka288MTgGDZK3jHrCdYexZnrYga2CA1p0SkoE7bm5KtOXp3qf3QYipNKnKp+9t5mqXcUAPuXHNPUCM2GXjRLlYJGwCiPXbyzIZn+s9b426Pck74wp0eVV5TLinvWP/Z1iWes2YlDoiMcy+a077xAHhcA91pEy6kd7+RFlcKTE8CceY9qMsoCm8YU6XSQw84u64/N69rjVqGaax0uc2XEij9m/op3sN+jODnk13jt9Avkg2HfBfFugYunrl/qjCP6SHBOi4goWObU9cM1XSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+l83VyL3VZ/BhA8XymDwRpNGEUOJE16kw3dq/PVe/E=;
 b=YZGUk2IQKfb0yYapaHkxcq/6uu/5ico77Fnc3AN/F2TFoff4tFbvex/KKLz6cMo8a4Rlptl0CkON2OXKYlROxaFuW1+3g0P4Nf9YsOIMfcKVXDiNyKXaDoYZ4pKbIUUSeeVolQeE2ClQOMopDDnWAiu1l/IoUv7Y6s/V5OI2/oUkvsGPl0x63lcL8P4/hgedwZ16MeMasWrF+zcvkKwdwfbPp3NnujMgJtatCV8A0CQWdo83TxLYZNi7Ubh/C1JnP3V7GfFpiDDJVQtFCEi9zWUDvrXU+hJvqhLWzD+prWu50EoXmGjYdhTlPIFIa34sYe4nSro1b7LltcLedzyzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+l83VyL3VZ/BhA8XymDwRpNGEUOJE16kw3dq/PVe/E=;
 b=gN0a+k9a2LPJbxxs5OldmFoALdGWk4ViDsFxXiRR7wTNjH0JPhe4ZGGSpmW69NpQ2aCsY9xftu7wQ6Gc36y7v8iiotziV3bwPkIs4FtmF8SO4w+TTogfWSRiHZFlAqG1bEOVHtVDgQvZmLnfbsTCCLX014FGMyyacxqfUIjjxKU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5349.eurprd04.prod.outlook.com (2603:10a6:20b:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 02:19:51 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 02:19:51 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
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
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAIADPk4AgASxvPCAAFrbAIAAAT6wgAERl4CAABTeEA==
Date:   Wed, 24 Jun 2020 02:19:51 +0000
Message-ID: <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
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
In-Reply-To: <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e33d1d0-87d3-4542-eedf-08d817e51379
x-ms-traffictypediagnostic: AM6PR04MB5349:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5349BD21D81B46B0FE87B04E80950@AM6PR04MB5349.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Pnc6XOMGF9HiDKrFhKEQ0btde7jRlbnDJ7HxvanDILoA499lGKsfiSjYTargHhat0NrAtxU//hWYpvCfETS3v3O9eDKJgqqxc4xh15iSC8KmmEhpGQfiu47QfYu6rga5Pbw8XgZJFcJQdw1lIgWnlAMc3i5oOFpvrYnm0uK4O1FGWQljrgQaPjBPYigtLrFHsie1Q5hoQzosQ4O4m9U954oW2nH0Ewez/45rv+8RTcnDxaDXfD4ry+gHGBRFd0H0jmtekuUyUr/aplyMrKKaTyyX1k0hUxH3RcRx0bY4xefC5sXc2Bd5F90qSdU/i6O8Ez4JkgPTv56AtkGAN58sBTzVdxOgQxCedEGNMn/6XnwrAjG/hm/FH4ed5TBspP4ObWEgsplDjgS9vEnx13jPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(52536014)(7696005)(53546011)(5660300002)(71200400001)(316002)(86362001)(9686003)(110136005)(7416002)(6506007)(478600001)(4326008)(8936002)(76116006)(66446008)(64756008)(33656002)(66946007)(66476007)(8676002)(66556008)(44832011)(26005)(83380400001)(186003)(2906002)(55016002)(921003)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: YAFm7iVWPKLuvYSadUGd9fwD6n6hxDU3BIy9c7P/MZI07id5m7sSn3cRNvYSBcOG3mBxCHzHPxBFXVR5cqb6e5uEpBDYNFsDimBsz5GNZsReYRb4QB+V1Np1TOpwI41ikpPkodC6z9K36d8tlx2wwwJVs5SywPyUxKCyCt2EH3ngc2daFopHo7T7zbEsFr7wJV0j+hnUbtls97+3VLA9HEFcP/NdEZIpYoePkc6fiG4GHfrsaMlMvUSZkL+D0HWjpfLobKsfhquPbOJV61ZbP17SKGtrQcvhoOnljydN1P80kW991QbqClP1QI+cVDZ1k2V7EfmI4Yq+dhrIZYPIw3gwR/MGzz9c2+KpcB5vnal0EP8RaEsy7qR80NmuJs3xQu9aoR9j/6yUsZTdK9UaXMiAGrlXi5Jf4hYFEbc9BLmR3bhbiQSv7U04OJttQqbEl3ThCURsC+nwwewZjCSMbHgW70SVVrUe42ZaahAW0uQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e33d1d0-87d3-4542-eedf-08d817e51379
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 02:19:51.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8UD1U73WDTpNCfLyzIbXjel9UCLCvBSZsZFYkD8038tiGpkN1wK1JkypWRwuUUXKRmbhxod64B3jS60QXklAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVuZSAyNCwgMjAyMCA4OjU4IEFNDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85XSBj
bGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0K
PiANCj4gUXVvdGluZyBBaXNoZW5nIERvbmcgKDIwMjAtMDYtMjMgMDI6MDA6NDcpDQo+ID4gPiBG
cm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5
LCBKdW5lIDIzLCAyMDIwIDQ6MzQgUE0NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85
XSBjbGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiA+IGRyaXZlciBhcyBt
b2R1bGUNCj4gPiA+DQo+ID4gPiBRdW90aW5nIEFpc2hlbmcgRG9uZyAoMjAyMC0wNi0yMiAyMDo0
MjoxOSkNCj4gPiA+ID4gPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+
ID4gPiA+ID4gU2VudDogU2F0dXJkYXksIEp1bmUgMjAsIDIwMjAgMTE6MjggQU0NCj4gPiA+ID4g
PiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDMvOV0gY2xrOiBpbXg6IFN1cHBvcnQgYnVpbGRpbmcg
U0NVIGNsb2NrDQo+ID4gPiA+ID4gZHJpdmVyIGFzIG1vZHVsZQ0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gUXVvdGluZyBBaXNoZW5nIERvbmcgKDIwMjAtMDYtMTcgMTg6NTg6NTEpDQo+ID4gPiA+ID4g
PiA+IEZyb206IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gPiA+ID4g
PiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0gbXhjLWNsay1zY3Uubw0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gTGlrZSBpLk1YIHBpbmN0cmwsIEknbSBub3Qgc3Vy
ZSBpZiBpdCdzIHJlYWxseSBuZWNlc3NhcnkNCj4gPiA+ID4gPiA+ID4gPiB0byBidWlsZCBjb3Jl
IGxpYnJhcmllcyBhcyBtb2R1bGVzLiBQcm9iYWJseSB0aGUgc2ltcGxlc3QNCj4gPiA+ID4gPiA+
ID4gPiB3YXkgaXMgb25seSBidWlsZGluZyBwbGF0Zm9ybSBkcml2ZXJzIHBhcnQgYXMgbW9kdWxl
LiBBbmQNCj4gPiA+ID4gPiA+ID4gPiBsZWF2ZSB0aG9zZSBjb3JlIGxpYnJhcmllcw0KPiA+ID4g
PiA+IGJ1aWx0IGluIGtlcm5lbC4NCj4gPiA+ID4gPiA+ID4gPiBUaGlzIG1heSBtYWtlIHRoZSBj
b2RlIGEgYml0IGNsZWFuZXIuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gV2lsbCBkaXNjdXNzIHRoaXMgd2l0aCBMaW5hcm8gZ3V5cyBhYm91dCBpdCwgcHJl
dmlvdXMNCj4gPiA+ID4gPiA+ID4gcmVxdWlyZW1lbnQgSSByZWNlaXZlZCBpcyBhbGwgU29DIHNw
ZWNpZmljIG1vZHVsZXMgbmVlZCB0bw0KPiA+ID4gPiA+ID4gPiBiZSBidWlsdCBhcw0KPiA+ID4g
bW9kdWxlLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9rYXkuIEFG
QUlLIGl0J3Mgbm90IGNvbmZsaWN0Lg0KPiA+ID4gPiA+ID4gWW91IHN0aWxsIG1ha2UgZHJpdmVy
cyBpbnRvIG1vZHVsZXMuDQo+ID4gPiA+ID4gPiBPbmx5IGRpZmZlcmVuY2UgaXMgZm9yIHRob3Nl
IGNvbW1vbiBsaWJyYXJpZXMgcGFydCwgd2UgZG9uJ3QNCj4gPiA+ID4gPiA+IGNvbnZlcnQgdGhl
bSBpbnRvIG1vZHVsZSBXaGljaCBpcyBsZXNzIG1lYW5pbmdsZXNzLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFdoYXQgaXMgdGhlIGJlbmVmaXQgb2YgbWFraW5nIHRoZSBjb3Jl
IHBhcnQgb2YgdGhlIFNvQyBkcml2ZXIgbm90IGENCj4gbW9kdWxlPw0KPiA+ID4gPg0KPiA+ID4g
PiBVc3VhbGx5IHdlIGNvdWxkIHRyeSB0byBidWlsZCBpdCBhcyBtb2R1bGUgaWYgaXQncyBub3Qg
aGFyZC4NCj4gPiA+ID4NCj4gPiA+ID4gT25lIHF1ZXN0aW9uIGlzIHNvbWV0aW1lcyB0aG9zZSBj
b3JlIHBhcnQgYXJlIHNoYXJlZCB3aXRoIHNvbWUNCj4gPiA+ID4gcGxhdGZvcm1zDQo+ID4gPiB3
aGljaCBjYW4ndCBidWlsdCBhcyBtb2R1bGUuDQo+ID4gPiA+IEZvciBpLk1YIGNhc2UsIGl0J3Mg
bWFpbmx5IHBhdGNoIDQ6DQo+ID4gPiA+IFtWMiw0LzldIGNsazogaW14OiBTdXBwb3J0IGJ1aWxk
aW5nIGkuTVggY29tbW9uIGNsb2NrIGRyaXZlciBhcw0KPiA+ID4gPiBtb2R1bGUNCj4gPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gVGhvc2UgbGlicmFyaWVzIGFyZSBhbHNvIHVzZWQgYnkgaS5NWDYm
NyB3aGljaCBjYW4ndCBidWlsZCBhcyBtb2R1bGUuDQo+ID4gPiA+IFNvIHdlIG5lZWQgYW4gZXh0
cmEgd29ya2Fyb3VuZCBwYXRjaCB0byBmb3JjZWx5ICdzZWxlY3QnIGl0IHVuZGVyDQo+ID4gPiA+
IGFyY2gvYXJtL21hY2gtaW14L0tjb25maWcgW1YyLDIvOV0gQVJNOiBpbXg6IFNlbGVjdCBNWENf
Q0xLIGZvcg0KPiA+ID4gPiBBUkNIX01YQyBUaGVuIHRoZSB1c2VycyBjYW4ndCBjb25maWd1cmUg
aXQgYXMgbW9kdWxlIGluIG9yZGVyIHRvDQo+ID4gPiA+IG5vdCBicmVhayBidWlsZC4NCj4gPiA+
ID4NCj4gPiA+ID4gSWYgYnVpbGQtaW4gdGhvc2UgY29tbW9uIGxpYnJhcmllcywgdGhlIGltcGxl
bWVudGF0aW9uIGNvdWxkIGJlIGENCj4gPiA+ID4gYml0IGVhc2llcg0KPiA+ID4gYW5kIGNsZWFu
ZXIuDQo+ID4gPiA+IFNvIEknbSBub3Qgc3VyZSBpZiB3ZSBzdGlsbCBoYXZlIHRvIGJ1aWxkIHRo
ZW0gYXMgbW9kdWxlLg0KPiA+ID4gPiBIb3cgd291bGQgeW91IHN1Z2dlc3QgZm9yIHN1Y2ggY2Fz
ZT8NCj4gPiA+DQo+ID4gPiBTdG9wIHVzaW5nICdzZWxlY3QgTVhDX0NMSycgd2hlbiByZXF1aXJp
bmcgdGhlIGNvcmUgbGlicmFyeSBjb2RlPw0KPiA+ID4gSW5zdGVhZCwgbWFrZSBpdCBhICdkZXBl
bmRzJyBhbmQgdGhlbiB0aGF0IHdpbGwgbWFrZSBkZXBlbmRpbmcNCj4gPiA+IG1vZHVsZXMgKGku
ZS4gdGhlIFNvQyBmaWxlcykgdGhhdCB3YW50IHRvIGJlIGJ1aWx0aW4gZm9yY2UgdGhlIGNvcmUN
Cj4gPiA+IG1vZHVsZSB0byBiZSBidWlsdGluIHRvby4gT3RoZXIgbW9kdWxhciBjb25maWdzIHRo
YXQgZGVwZW5kIG9uIHRoZSBjb3JlIHdpbGwNCj4gc3RpbGwgYmUgbW9kdWxhci4NCj4gPiA+DQo+
ID4NCj4gPiBJdCBzZWVtcyBub3Qgd29yay4NCj4gPiBQYXRjaCA0IGFscmVhZHkgY2hhbmdlcyBp
dCB0byBkZXBlbmQgb24gQVJDSF9NWEMgd2hpY2ggY2FuIG9ubHkgYmUgJ1knLg0KPiA+IFtWMiw0
LzldIGNsazogaW14OiBTdXBwb3J0IGJ1aWxkaW5nIGkuTVggY29tbW9uIGNsb2NrIGRyaXZlciBh
cyBtb2R1bGUNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L0tjb25maWcgYi9kcml2
ZXJzL2Nsay9pbXgvS2NvbmZpZyBpbmRleA0KPiA+IGRlZDA2NDMuLjY3ODExM2IgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9p
bXgvS2NvbmZpZw0KPiA+IEBAIC0xLDggKzEsOCBAQA0KPiA+ICAjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wDQo+ID4gICMgY29tbW9uIGNsb2NrIHN1cHBvcnQgZm9yIE5YUCBpLk1Y
IFNvQyBmYW1pbHkuDQo+ID4gIGNvbmZpZyBNWENfQ0xLDQo+ID4gLSAgICAgICBib29sDQo+ID4g
LSAgICAgICBkZWZfYm9vbCBBUkNIX01YQw0KPiA+ICsgICAgICAgdHJpc3RhdGUgIklNWCBjbG9j
ayINCj4gPiArICAgICAgIGRlcGVuZHMgb24gQVJDSF9NWEMNCj4gPg0KPiA+IEJ1dCB1c2VyIGNh
biBzdGlsbCBzZXQgTVhDX0NMSyB0byBiZSBtLCBlaXRoZXIgdmlhIG1ha2UgbWVudWNvbmZpZyBv
cg0KPiBkZWZjb25maWcuDQo+IA0KPiBJc24ndCB0aGF0IHdoYXQgd2Ugd2FudD8gDQoNCk5vLCBp
ZiB1c2VyIHNldCBNWENfQ0xLIHRvIG0sIHRoZSBidWlsZCB3aWxsIGJyZWFrIGZvciBpLk1YNiY3
Lg0KDQo+IFdoeSBkb2VzIEFSQ0hfTVhDIGJlaW5nIGVuYWJsZWQgbWFuZGF0ZSB0aGF0IGl0IGlz
DQo+IGJ1aWx0aW4/IElzIHNvbWUgYXJjaGl0ZWN0dXJlIGxldmVsIGNvZGUgY2FsbGluZyBpbnRv
IHRoZSBjbGsgZHJpdmVyPw0KDQoNCkl0J3MgbWFpbmx5IGJlY2F1c2UgdGhlcmUncyBubyBLY29u
ZmlnIG9wdGlvbnMgZm9yIGkuTVg2ICY3IGNsb2NrIGRyaXZlcnMuDQpJdCBqdXN0IHJldXNlcyBB
UkNIIGNvbmZpZyBDT05GSUdfU09DX1hYWCB3aGljaCBjYW4gb25seSBiZSB5Lg0KZS5nLg0Kb2Jq
LSQoQ09ORklHX1NPQ19JTVg2USkgICs9IGNsay1pbXg2cS5vDQpvYmotJChDT05GSUdfU09DX0lN
WDZTTCkgKz0gY2xrLWlteDZzbC5vDQpvYmotJChDT05GSUdfU09DX0lNWDdVTFApICs9IGNsay1p
bXg3dWxwLm8NCm9iai0kKENPTkZJR19TT0NfVkY2MTApICArPSBjbGstdmY2MTAubw0KLi4NCg0K
SWYgc2V0dGluZyBNWENfQ0xLIHRvIG0sIHRoZSBwbGF0Zm9ybSBjbG9jayBkcml2ZXJzIHdpbGwg
ZmFpbCB0byBidWlsZCBkdWUgdG8gbWlzcw0KdG8gZmluZCBzeW1ib2xzIGRlZmluZWQgaW4gdGhl
IGNvbW1vbiBjbG9jayBsaWJyYXJ5IGJ5IENPTkZJR19NWENfQ0xLLg0KU28gd2UgaGF2ZSB0byBh
dm9pZCB1c2VycyB0byBiZSBhYmxlIHRvIGNvbmZpZyBNWENfQ0xLIHRvIG0gZm9yIGkuTVg2Jjcu
DQpPbmx5IGRlcGVuZHMgb24gQVJDSF9NWEMgbWVhbiB1c2VyIHN0aWxsIGNhbiBzZXQgaXQgdG8g
bS4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K

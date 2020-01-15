Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7FC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0992467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P10F9TwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAOCil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:38:41 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:5952
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728862AbgAOCil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKYpTwJuAK0qhP1/sTGg8RGPtuX5/W2aaxMpJfOcJICvOq/UfRkyY2BfgzjHxUss3BKBBRYVtTN2BF3x5gOGJGvteE8ig9A6nVBbPdwT6rCWRwTgD3LsZNPDiVYjR4cLeWysxaskQZ3Iu11yujey3nDH76GMS8/OzOlGivjGFMHv+w8Wg9Po7hG4CZJpDr6joonff3gR7qAgHtv1ETfaUndCojU9jy62YnSFGwe1/e4IKHx1r07Ta1TK2XJ6GD/JiVFnxGxlI6EAdxOrZa/GfWfpBo3AdjCLALJHSYjwt/Oxi+DHYTlp1nJYCm6bHy7ssufdadlRDTu8TjYZqw94Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmft/DpZVCuOg3VemCuvIcc0dupm5is4CqP5szubq7I=;
 b=JhCKzFXQou+Fe7WDiQdzu9Qlej3/HUMs8wg9H+bWlz5gzd0hrirMZbA1Cf6q4bBnFlf9mnjYAddrYo+ADqamnqCADycZ81E9MKhHfmEQqI+WtjWau3Uiz3h6pJ2hx5zKi2UAu7vEcctkm2jgziakdDmQB14sKE0d1aG0yc+WAC1zq6pYU9CGiKYiK/jtuoCGSeeXbPTexkoIF9jpUCOpQxHYfZc8UtDOnyR92ix+DMeX/AVTaVM+m7rqC6/8UjCvSQ2Xr7X91ePW0yoKvhRkNBy5ofl6x/0XnZzduEafrjShUJY+YC8xcpY7ffmFUPKFAxGGWu/0I8LLwUK0U0llUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cmft/DpZVCuOg3VemCuvIcc0dupm5is4CqP5szubq7I=;
 b=P10F9TwCXmAcd0tEPVUs4kzeGKPh+Zct7xv6bBI8RoKoXrSjLTNyDPFxqx3+9IuBKQafJ+uNoIjktdahDHTLcSkVDm+EFPByc10i8/Z/1MQinWgFyB++wwBTA5opyxHjJ2ZC07ktixt3JZ10Cds2jGmJqTiGSzOyD2DfU4Jf+mA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5220.eurprd04.prod.outlook.com (20.176.215.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 02:38:36 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 02:38:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
Thread-Topic: [PATCH] soc: imx: Makefile: only build soc-imx8 when
 CONFIG_ARM64
Thread-Index: AQHVyrHXB0HrD3qW50ui9P9S7z/H8qfp0NaAgAADRlCAACnrAIABBSNw
Date:   Wed, 15 Jan 2020 02:38:35 +0000
Message-ID: <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de>
 <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
In-Reply-To: <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17a718b9-4476-4d7b-2971-08d799640555
x-ms-traffictypediagnostic: AM0PR04MB5220:|AM0PR04MB5220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5220B5668AF1E9ACCD47ABD788370@AM0PR04MB5220.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(199004)(189003)(55016002)(9686003)(26005)(44832011)(6506007)(316002)(4326008)(33656002)(86362001)(6916009)(53546011)(52536014)(66556008)(66446008)(81156014)(81166006)(71200400001)(8676002)(5660300002)(76116006)(186003)(2906002)(54906003)(64756008)(7696005)(66946007)(478600001)(66476007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5220;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jweSHFCwI4tMjVFpGptBzzyKshVw5Tj3o6sSXNdkkGziXi42SR+sL9Hi3Nm9BLrcXU8kVsKv+ZPOnNF/2Ab6+7FCL7rl7C4Jb07xyt7Jok9wmIu/wkAC+Rp+xmUpPGkeI5unlNwSJK6H5PrNNvpsLaRyEkG+/8KJhCIDGLN6sWarR3deAt1Sws1Qfqihk3WFBJ7Z1b/4l+5GCpBq6la6k+8K4hqjIsuIkQAeh1o8Hl0ao3cb3S948Y2R0sn8lV10IZfnUgT3Y/fRI11ST8dDuTzEuR8xCgZYVxF6JVjGvQklpmGCNLj25Kp8r1XOncxwmrCMfq+/gc1Pu01G0fHwxJ6mjhtQDNUAc0c3TgCbw41P+KgNPQdwE4uit4RC8OIHazf/FNjUTu56GQfwbO3Wqqhqib7cOTeuJkP0PjAnLZbVpRa+yt2xZM33D8kSQ+gs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a718b9-4476-4d7b-2971-08d799640555
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 02:38:36.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtWpFr6fdRhmey6NEj67tIRqHkrvcSGQASBYCXGVXVxSSoQDTRMlw+z9kqGjSR8Jzf9KW8Y/ZjpJhiNL9p579Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2M6IGlteDogTWFrZWZpbGU6IG9u
bHkgYnVpbGQgc29jLWlteDggd2hlbg0KPiBDT05GSUdfQVJNNjQNCj4gDQo+IE9uIFR1ZSwgSmFu
IDE0LCAyMDIwIGF0IDk6MzIgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IE1ha2VmaWxlOiBvbmx5IGJ1aWxk
IHNvYy1pbXg4IHdoZW4NCj4gPiA+IENPTkZJR19BUk02NA0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwg
SmFuIDE0LCAyMDIwIGF0IDA4OjA4OjQ1QU0gKzAwMDAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+ID4g
PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gT25s
eSBuZWVkIHRvIGJ1aWxkIHNvYy1pbXg4LmMgd2hlbiBDT05GSUdfQVJNNjQgZGVmaW5lZCwgbm8g
bmVlZA0KPiA+ID4gPiB0byBidWlsZCBpdCBmb3IgQ09ORklHX0FSTTMyIGN1cnJlbnRseS4NCj4g
PiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9zb2MvaW14L01ha2VmaWxlIHwgMiArKw0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlIGIvZHJpdmVycy9zb2MvaW14
L01ha2VmaWxlDQo+ID4gPiA+IGluZGV4DQo+ID4gPiA+IGNmOWNhNDJmZjczOS4uY2ZjYmM2MmIx
MWQ3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3NvYy9pbXgvTWFrZWZpbGUNCj4gPiA+
ID4gKysrIGIvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlDQo+ID4gPiA+IEBAIC0xLDUgKzEsNyBA
QA0KPiA+ID4gPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4g
PiA+ICBvYmotJChDT05GSUdfSEFWRV9JTVhfR1BDKSArPSBncGMubw0KPiA+ID4gPiAgb2JqLSQo
Q09ORklHX0lNWF9HUENWMl9QTV9ET01BSU5TKSArPSBncGN2Mi5vDQo+ID4gPiA+ICtpZmRlZiBD
T05GSUdfQVJNNjQNCj4gPiA+ID4gIG9iai0kKENPTkZJR19BUkNIX01YQykgKz0gc29jLWlteDgu
bw0KPiA+ID4gPiArZW5kaWYNCj4gPiA+DQo+ID4gPiBGb3IgZWFybGllciBTb0NzIHdlIGhhZCBr
Y29uZmlnIHN5bWJvbHMgbGlrZSBTT0NfSU1YMjUuIEFjdHVhbGx5DQo+ID4gPiBTT0NfSU1YOCB3
b3VsZCBiZSB0aGUgcmlnaHQgb25lIHRvIGRlY2lkZSBhYm91dCBzb2MtaW14OC5jIHRvIGJlDQo+
ID4gPiBjb21waWxlZCwgaXQgd291bGQgYmUgZWFzaWVyIHRvIHJlYWQgYW5kIHZlcmlmeSB0aGFu
IHRoZSBzdWdnZXN0ZWQNCj4gPiA+ICJBUk02NCAmJiBBUkNIX01YQyIgYW5kIGl0IHdvdWxkIHN0
YXkgcmlnaHQgb25jZSBOWFAgcHJlc2VudHMgaXQncw0KPiA+ID4gbmV4dCA2NC1iaXQgU29DIGku
TVg5Lg0KPiA+DQo+ID4gVGhlcmUgaXMgbm8gU09DX0lNWDggY3VycmVudGx5LiBOZWVkIHRvIGlu
dHJvZHVjZSBvbmUgaW4NCj4gPiBhcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zLiBCdXQgSSBu
b3Qgc2VlIG90aGVyIHZlbmRvcnMgaW50cm9kdWNlDQo+ID4gb3B0aW9ucyBsaWtlIFNPQ19YWC4g
SXMgdGhpcyB0aGUgcmlnaHQgZGlyZWN0aW9uIHRvIGFkZCBvbmUgaW4NCj4gPiBLY29uZmlnLnBs
YXRmb3Jtcz8NCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgbW9yZSBjb25zaXN0ZW50IHdpdGgg
dGhlIG90aGVyIHBsYXRmb3JtcyB0byBoYXZlIGEgc3ltYm9sDQo+IGluIGRyaXZlcnMvc29jL2lt
eC9LY29uZmlnIHRvIGNvbnRyb2wgd2hldGhlciB3ZSBidWlsZCB0aGF0IGRyaXZlci4NCg0KT2ss
IEknbGwgYWRkIEtjb25maWcgZW50cnkgaW4gZHJpdmVycy9zb2MvaW14L0tjb25maWcgZm9yIHZh
cmlvdXMgaS5NWCBTb0NzLg0KDQo+IA0KPiBJZiB0aGUgZHJpdmVyIGlzIHdlbGwgd3JpdHRlbiwg
aXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIGFsbG93IGNvbXBpbGUgdGVzdGluZyBpdCBvbg0KPiBh
bnkgYXJjaGl0ZWN0dXJlIChwbGVhc2UgdGVzdCB0aGlzLCBhdCBsZWFzdCBvbiB4ODYpLg0KDQpZ
ZXMuDQoNCj4gDQo+IEZvciBzb21lIFNvQ3MsIHdlIGFsc28gYWxsb3cgcnVubmluZyAzMi1iaXQg
a2VybmVscywgc28gaXQgd291bGQgbm90IGJlIHdyb25nDQo+IHRvIGFsbG93IGVuYWJsaW5nIHRo
ZSBzeW1ib2wgb24gMzItYml0IEFSTSBhcyB3ZWxsLCBidXQgdGhpcyBpcyBwcm9iYWJseQ0KPiBz
b21ldGhpbmcgd2hlcmUgeW91IHdhbnQgdG8gY29uc2lkZXIgdGhlIGJpZ2dlciBwaWN0dXJlIHRv
IHNlZSBpZiB5b3Ugd2FudA0KPiB0byBzdXBwb3J0IHRoYXQgY29uZmlndXJhdGlvbiBvciBub3Qu
DQoNCkRvZXMgdGhlIGN1cnJlbnQgdXBzdHJlYW0ga2VybmVsIHN1cHBvcnQgMzJiaXQga2VybmVs
cyBvbiBBUk02NCBwbGF0Zm9ybXMNCndpdGhvdXQgdmVuZG9yIHNwZWNpZmljIHN0dWZmLiBJIHJl
Y2FsbGVkIHRoYXQgc2V2ZXJhbCB5ZWFycyBhZ28sIE5YUCBwZW9wbGUNCnRyaWVkIHRvIHVwc3Ry
ZWFtIDMyYml0IGtlcm5lbCBzdXBwb3J0LCBidXQgcmVqZWN0ZWQgYnkgeW91Lg0KDQpTbyBJcyB0
aGVyZSBhbnkgcGxhbiB0byBzdXBwb3J0IDMyYml0IGtlcm5lbCBvbiBBQVJDSDY0IGluIHVwc3Ry
ZWFtIGtlcm5lbD8NCk9yIGFueSBzdWdnZXN0aW9ucz8NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gICAgICAgQXJuZA0K

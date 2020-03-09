Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C5C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D47620873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sSSUpw9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCIN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:28:40 -0400
Received: from mail-am6eur05on2042.outbound.protection.outlook.com ([40.107.22.42]:29852
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgCIN2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:28:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfKTG5u5lsukCJyGlx8NHs7Xghkl3pOXOgOcx+QmIyPsGFZcFiT/PyyfCpsBfXhPAzrhNoSSIS39qbpClf01U0uez9bBv01OzRgQ+CUioWtYltPQaIKvvgpwtNSjELRDPNv76eHsY2gQCsc3+vVBvDnt0H9lylj9cKUpY0RKNunLvxGJFsu2Ii4H3saZLpZygl//P5fG+dNqgvqSvaOissxqJHQEb+m3bSfe5e1QH+PJCdo+/wlDb6UkA3noWo+F5rHxbkQBpw7p8U/oQhgLFcgculPM8w5pP7+7LT6KPSZHMl/DhXXOQhX0MS33Re4bcqAQJzTVBvXf0mSJ0vjdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KiMQjdhKshysxHpWF2uKsXIN9uhFZ0MEIK7BPmSOfc=;
 b=WBxnxrQrrexMRCUhKlAQ5g9CtfzK3PohE0JF4M2FmMJ+0t38jBuk5vL/7I/x6FCCsVbhe6nPCqVxwfI909+R5XJqclWVgFPZ9UFVQVZr2gLk/m9SKL9ixDWpdvZPJwWWdQjWYointZR/GkxUCV7UrY4WqBWc9sPalMyRCgwxlqlpS2l03BBLY6FG1+ixbjJpML2b9QpB4kkP3Yg16BFl3LUUDesJHQKyiVrGy9AKe/BVqE2fMdOhCTUtJpyKM53E8V4L1e2eA8tz3ZArrQbQu7zIO3draQ4v67M5cn1xvQ9z/w5rsca8roRAQttFoEkt8LMVSFD1m5TC+FGXZF5E+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KiMQjdhKshysxHpWF2uKsXIN9uhFZ0MEIK7BPmSOfc=;
 b=sSSUpw9SEnuJyvsIUcCifAD9fFc2EfMQFkU1LG/hBZY88RoqzqoquoYLJRwAjLDfe6/lgZUKIMCZyHILRvNBfpy3sYrOWPHMmuYNZSs3EvVFceck8LLOqUUgV4fYyJUvFOfH65Vw74HM7NGIYYGwAu0Ed0Av6FZ4VqjL68IjURc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Mon, 9 Mar 2020 13:28:33 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 13:28:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Adam Ford <aford173@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: imx: Makefile: only build soc-imx8 when CONFIG_ARM64
Thread-Topic: [PATCH] soc: imx: Makefile: only build soc-imx8 when
 CONFIG_ARM64
Thread-Index: AQHVyrHXB0HrD3qW50ui9P9S7z/H8qfp0NaAgAADRlCAACnrAIABBSNwgACHbgCADn0MAIAEANYwgAAfBYCAQm8QcA==
Date:   Mon, 9 Mar 2020 13:28:32 +0000
Message-ID: <AM0PR04MB44813F8292A36D84B3F80AEA88FE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1578989048-10162-1-git-send-email-peng.fan@nxp.com>
 <20200114081751.3wjbbnaem7lbnn3v@pengutronix.de>
 <AM0PR04MB4481A2FB7E2C56C2386297E888340@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a3x55A8y9kR34zy8YyRhto8uay7PZGbDAufupiNS3+ihA@mail.gmail.com>
 <AM0PR04MB44813A1D55659658E3FA203188370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a29=KWrhO8uu7mMS2gbeCGpkL7Q-xaaUVO2wcVD9MN93g@mail.gmail.com>
 <CAHCN7xKtfKVQeaAg9sjvc3cHjLoAqAX6F-JyvkG5u23w1OG8CA@mail.gmail.com>
 <AM0PR04MB4481B8BDAD2CD7376208B5F2880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a2gOq=qv5C6_0QwBXPuENqhBinK_KkzL5AcAEJtTDyB1w@mail.gmail.com>
In-Reply-To: <CAK8P3a2gOq=qv5C6_0QwBXPuENqhBinK_KkzL5AcAEJtTDyB1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a2849fe-c318-40d2-1761-08d7c42dc392
x-ms-traffictypediagnostic: AM0PR04MB4353:|AM0PR04MB4353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4353351F992C13ACF00113DA88FE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(86362001)(26005)(8936002)(2906002)(6506007)(478600001)(53546011)(44832011)(8676002)(71200400001)(33656002)(66946007)(76116006)(66446008)(7696005)(316002)(66476007)(81156014)(64756008)(81166006)(66556008)(4326008)(9686003)(55016002)(6916009)(52536014)(186003)(54906003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4353;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEiKaUaU9TFwvl2CJ338VPh8kkpc0rj2iuYskq8zt9eSYKuWk1Kz3eycL5RcJQQfeLTkZGqFx3ArN1sCVtqhEojZtNVVmZkVqPbbiX6uRizoLNzUsz8tz9Yz9O7owzTiV+sXbDdLHaFFIygJhxzNl8UQX3XyGgaeQMTe2HE7zu81Prznh6br251Xo3J/nv3KVqDXBOxKFX3iZXWLmR/oSUXiYVx00lDeJGta5mqbhWsLDroFCYndVa7ErbDyM1Hs77vP9GwAgX69Bolh1SI1AZk+Mq1W3l4m52HlA25i+L57F3n1Xgem60qGKtuMxIMxCyGivVBjRKoy3vrQqtLKwStwjGWZI8MmZU4KZvE+xRkql2qToqhrhRt0Uuu9+6m9rNhcJhHldlbQ409lA8Shbuf3Kpp3NVpj2uZz/DaquGU29PEp0/IJ35Kz2BUVgy3F
x-ms-exchange-antispam-messagedata: EyqSxMuOOBS5n9Bn0WEdzewEbd7lYM2Fn5OL0q6g+/2HRHwBXAAXOvqd38iDhBIjI1BYuoeV6m+D0AI60dDg+9a5xfS0Io3eBCPOi6pYwDfbD0gDdcM247+kAN3YKvSSbUqcQM9ViBykLkryAeCFxQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2849fe-c318-40d2-1761-08d7c42dc392
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 13:28:32.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AUFQk54uAG48aeC+8W8uTSF/yi4zhFC+hGU8o1GCaKorhCaraPE7v8IYY7ErLxLNiiCD883elGt12dsObQ0mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2M6IGlteDogTWFrZWZpbGU6IG9u
bHkgYnVpbGQgc29jLWlteDggd2hlbg0KPiBDT05GSUdfQVJNNjQNCj4gDQo+IE9uIE1vbiwgSmFu
IDI3LCAyMDIwIGF0IDY6MDUgQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0K
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXg6IE1ha2VmaWxlOiBvbmx5IGJ1aWxk
IHNvYy1pbXg4IHdoZW4NCj4gPiA+IERvZXMgYW55b25lIGhhdmUgYW55IHN1Z2dlc3Rpb25zIG9u
IHdoZXJlIEkgbWlnaHQgZmluZCBzb21lIGdlbmVyaWMNCj4gPiA+IHN0dWZmIGZvciBlaXRoZXIg
aU1YOE0gb3IgZ2VuZXJpYyBBUk12OCBkb2NzIGZvciBkb2luZyBzb21ldGhpbmcgbGlrZQ0KPiB0
aGlzPw0KPiA+DQo+ID4gV2UgZGlkIGEgcG9ydGluZyBmb3Igb25lIGN1c3RvbWVyLCBidXQgY29k
ZSBpcyBub3QgcHVibGljIGF2YWlsYWJsZS4NCj4gPg0KPiA+IEZpcnN0IGxldCB1Ym9vdCBzd2l0
Y2ggdG8gQUFSQ0gzMiBtb2RlIHdoZW4gYm9vdGluZyBMaW51eCwgdGhpcyBpcw0KPiA+IGFscmVh
ZHkgc3VwcG9ydGVkIGJ5IHVib290IG1haWxpbmUuDQo+ID4NCj4gPiBTZWNvbmQsIGNyZWF0ZSBh
IG1hY2gtaW14OG0uYyB1bmRlciBhcmNoL2FybS9tYWNoLWlteCB0byBoYW5kbGUNCj4gaS5NWDhN
DQo+ID4ganVzdCBsaWtlIG90aGVyIGkubXggYXJtMzIgc29jcy4gVGhpcyBpcyBub3QgcHJlZmVy
cmVkIGJ5IExpbnV4IGNvbW11bml0eS4NCj4gPg0KPiA+IDNyZCwgYnVpbGQgaS5NWDhNIGRyaXZl
cnMgd2hlbiB1c2luZyBpbXhfdjdfZGVmY29uZmlnKCBvcg0KPiA+IGlteF92Nl92N19kZWZjb25m
aWcgaW4gdXBzdHJlYW0pDQo+IA0KPiBJIHRoaW5rIHRoZSB0aGlyZCBwYXJ0IGlzIHNvbWV0aGlu
ZyB3ZSBjYW4gY2xlYXJseSBkbyBvbmNlIGl0IGFjdHVhbGx5IGJvb3RzLg0KPiANCj4gQ2FuIHlv
dSBwb3N0IHRoZSBwYXRjaCBmb3IgdGhlIHNlY29uZCBwYXJ0IGZvciByZWZlcmVuY2U/IEluIHRo
ZW9yeSBub3RoaW5nDQo+IHNob3VsZCBiZSBuZWNlc3NhcnkgdGhlcmUsIHNvIEkgd29uZGVyIHdo
YXQgSSdtIG1pc3NpbmcgKGFzIHdlIG5lZWQgbm8gY29kZQ0KPiBmb3IgYXJjaC9hcm02NCkgYW5k
IHdoYXQgd2UgY2FuIGRvIGRpZmZlcmVudGx5IHRvIG1ha2UgaXQgd29yayBvdXQgb2YgdGhlDQo+
IGJveC4NCj4gDQo+IElzIHRoZSBwcm9ibGVtIHRoYXQgdGhlIFNNUCBicmluZ3VwIHVzaW5nIFBT
Q0kgZm9yIGFybTY0IGRvZXNuJ3Qgd29yayB3aXRoDQo+IHRoZSAzMi1iaXQga2VybmVsIGZvciBz
b21lIHJlYXNvbj8NCg0KU29ycnkgZm9yIGxvbmcgdGltZSBkZWxheS4gSSBmb3Jnb3QgeW91ciBt
YWlsLiBJIGRpZCBzb21lIHRyeSBhZ2Fpbiwgc2VlbXMgb25seSBuZWVkDQp0aGUgZm9sbG93aW5n
IHBpZWNlIGNvZGUgdG8gbWFrZSBpdCBib290LCBhbHNvIHNlbGVjdCBHSUNfVjMgYW5kIGRyb3Ag
c29tZSBBUk02NA0KZGVwZW5kZW5jaWVzIGluIEtjb25maWcgZm9yIHNvbWUgaS5NWCBkcml2ZXJz
Lg0KTmVlZCBzb21lIGFkZGl0aW9uIHdvcmsgaW4gQVRGL1UtQm9vdA0KdG8gbWFrZSBzbXAgd29y
aywgdGhhdCBpcyBub3QgTGludXggcmVsYXRlZC4NCg0KK3N0YXRpYyBjb25zdCBjaGFyICpjb25z
dCBpbXg4bW1fZHRfY29tcGF0W10gX19pbml0Y29uc3QgPSB7DQorICAgICAgICJmc2wsaW14OG1t
IiwNCisgICAgICAgTlVMTCwNCit9Ow0KKw0KKyNpbmNsdWRlIDxhc20vbWFjaC9hcmNoLmg+DQor
RFRfTUFDSElORV9TVEFSVChJTVg3RCwgIkZyZWVzY2FsZSBpLk1YOE1NIChEZXZpY2UgVHJlZSki
KQ0KKyAgICAgICAuZHRfY29tcGF0ICAgICAgPSBpbXg4bW1fZHRfY29tcGF0LA0KK01BQ0hJTkVf
RU5EDQoNCg0KQXJlIHlvdSBvayB3ZSBhZGQgc3VjaCBwaWVjZSBjb2RlIGluIGRyaXZlcnMvc29j
L2lteC9zb2MtaW14OC5jIHRvIHN1cHBvcnQNCmFhcmNoMzIgbGludXg/DQoNClRoYW5rcywNClBl
bmcuDQo+IA0KPiAgICAgICBBcm5kDQo=

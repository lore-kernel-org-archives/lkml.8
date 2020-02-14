Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBA1C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972F82467C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IdwDqQTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgBNFuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:50:52 -0500
Received: from mail-vi1eur05on2075.outbound.protection.outlook.com ([40.107.21.75]:6220
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728723AbgBNFuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzAfv8x++OBSe6CMFj3GjOGuNDFKD+2ZFKQCYOqkCQhIi8X+Yl1I5znigadDU8AqmRLndT+WrEPksUptOvfUOtikTfmtLzcpMeHCp2fWTAKehiNluJYB5gCYrCCkIlW3z7ilErSmlaZuq2ODnMvYphpaFZugkSqpY9M6OSlxiSn+DanRqyMP0irDfZX3BwoxTGUNAo0ywJswDLhC+hWXE8RFHGyKVhNq9GSAtAM1Oycf5Muvid3bsCpZ/D+GYjJ9tZiyDWzVZ/MTvFxYLMxFazgdxIf/4jN5breGrxl7P18+He8ogc2dbp9r4TfcnLKuUAjoXw1crTnbp+6P/9NaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBYVTcpskVpyfpUjthsRwrJt6PoN8C17tRiBKNc+dOA=;
 b=XoVc+3hhy5AUEZN1M7uteijNYv2P5b6RE0SpeiC3p0boaoHpyJXXstocLGMc2KkEt/UbA7Ybiws/AOvhZV/lT/NyDdVzjMM6qx+0hbryoemnVE1HNalc76YeaM2a9+ykCJzwoMCt0pUmGrjGKJQcAwujytMoH6FHmfyc9+7UGesN+SjsKXKrJwa0o1h7bTCJn02ZC4pcZampP1wfpGSV3sQ1aynavKYZnIsw4pt3aFpDzN9MYNib9eUZmYdxlZ0s7opIQTzklAdEteMjC6XjIyurUS6EJNhn19KwJWIwJZ2rK3vF+vFfnx2kNnlR+PVnYrZjeUTv6kPnJtuWTGdGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBYVTcpskVpyfpUjthsRwrJt6PoN8C17tRiBKNc+dOA=;
 b=IdwDqQTjo12dREo4t+9Gr6iFRgI4tbTVuJTnkYBzFnfd7WPkrYj3vFXBKTfyiCVC68PLoy81zuu2fmPgps36qUzRlPbMjziW0hi+TgjJhE8v2MXohMI/hOcXzb+87piMVH0hlxcqXnsF2bx8QTZhzjaJ749lDj+TwWPANyPhHr4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6179.eurprd04.prod.outlook.com (20.179.32.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Fri, 14 Feb 2020 05:50:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5024:13e2:7000:3c2]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5024:13e2:7000:3c2%6]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 05:50:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Oliver Graute <oliver.graute@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: clk: imx: clock driver for imx8qm?
Thread-Topic: clk: imx: clock driver for imx8qm?
Thread-Index: AQHV4oK4jf4Yk7gIB0yfade2LGWp9agZS8HggAAZIYCAAMrjIA==
Date:   Fri, 14 Feb 2020 05:50:48 +0000
Message-ID: <AM0PR04MB42111BF00621C1949E1FBA9080150@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20200213153151.GB6975@optiplex>
 <AM0PR04MB4211AC5AB9F6A055F36040A2801A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20200213174225.GA11566@ripley>
In-Reply-To: <20200213174225.GA11566@ripley>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0c76625-6bd1-4fb6-6cde-08d7b111d772
x-ms-traffictypediagnostic: AM0PR04MB6179:|AM0PR04MB6179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6179D8EB11A07D470CE9864B80150@AM0PR04MB6179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(52536014)(6506007)(76116006)(316002)(66946007)(33656002)(8676002)(64756008)(66446008)(66476007)(66556008)(8936002)(110136005)(54906003)(81166006)(81156014)(5660300002)(4744005)(7696005)(26005)(44832011)(9686003)(2906002)(478600001)(86362001)(4326008)(186003)(71200400001)(55016002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6179;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRWl9YofXZBDWRPc12wQ7dYdKigBQJbgEQ+HJa8p/e8xsHZxU5F/A9mQAEpOHf5CdxLsLqMHhRCr/zW80WNvQAply0b5UTz4bqTxEgIVcE4mX23LF2RNtJ0qIENFfpOm8xwvnjhhEm/45iEOUsqTeQgnoKzgmjoQJqdbRO7w38k/lN4QeKrDx8eAuTEl5RZ+lYRn6q2XZEa4hha5HVLEpWDSYUwj8cFViQWj5XZttgy9zPO5FxO+uKZ4EplrBx0RMGQ748IwgIiyehcu0Z8c81/qeR/Ba2y3bYniJmYoaB/EkiGbU44ppXDiaX9ZVJHoODbl5dfFkU9g4/LFnQe9acYEbKZ2prJ2sYwgaPEIqMdEBz0GP5RkNToRTJO9YOifcrWm6vH+eTbRpkF0/ClNCiilYfh9F/vrIas7z9J+gZOILjHFlkZ/SMcGPslvShQNHtaWOMiMH3y6aFUV88GMOc92o/w8FIfEi9OSCI49cS8=
x-ms-exchange-antispam-messagedata: yt0Lg71fH5jNFEixeXaUbsggGukQyIxNXygyPcKBHNnMXAdJqzueTHOjtv12RULiU+o7ABIyxvo7/6Vyb5GK5Foiz0AQ6wHlsi7xorSEYb2cZXk2fjs6lp9vvC2SfLc9/lpB8SVgSkPMIkK5P7iw6w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c76625-6bd1-4fb6-6cde-08d7b111d772
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 05:50:48.2335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwn5zDijSBvSFoqAr9ueTpOpoxYuio8VLKMJiirZd7rIrFYVaX39OcN+jPt56wtrJ/rntZ7OnM997bGjGN5zGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBPbGl2ZXIgR3JhdXRlIDxvbGl2ZXIuZ3JhdXRlQGdtYWlsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAxNCwgMjAyMCAxOjQyIEFNDQo+IA0KPiBPbiAxMy8wMi8yMCwgQWlz
aGVuZyBEb25nIHdyb3RlOg0KPiA+IEhpIE9saXZlciwNCj4gPg0KPiA+ID4NCj4gPiA+IGlzIHNv
bWVvbmUgd29ya2luZyBvbiBjbG9jayBkcml2ZXIgZm9yIGlteDhxbT8gSSBtaXNzIGF0IGxlYXN0
IGENCj4gPiA+IGNsay1pbXg4cW0uYyBpbiB0aGUgZHJpdmVycy9pbXgvY2xrLyBkaXJlY3Rvcnku
IEkgc2F3IHRoYXQgeW91IGFyZQ0KPiA+ID4gd29ya2luZyBpbiB0aGlzIGFyZWEgYW5kIHBlcmhh
cHMgeW91IGNhbiBnaXZlIG1lIHNvbWUgaW5zaWdodHMgd2hhdCBpcw0KPiBuZWVkZWQgaGVyZS4N
Cj4gPiA+DQo+ID4NCj4gPiBNWDhRTS9RWFAgYXJlIHVzaW5nIHRoZSBzYW1lIGNsb2NrIGRyaXZl
ciBjbGstaW14OHF4cC5jDQo+IA0KPiBvayB0aHgsIGZvciB0aGF0IGNsYXJpZmljYXRpb24uDQo+
IA0KPiA+DQo+ID4gW1BBVENIIFJFU0VORCBWNSAwMC8xMV0gY2xrOiBpbXg4OiBhZGQgbmV3IGNs
b2NrIGJpbmRpbmcgZm9yIGJldHRlciBwbQ0KPiA+IFRoZSByZXZpZXcgb2YgdGhhdCBwYXRjaCBz
ZXJpZXMgaXMgcGVuZGluZyBmb3IgYSBjb3VwbGUgb2YgbW9udGhzLg0KPiANCj4geWVzIHRoYXQg
aXMgd2hhdCBJIGN1cnJlbnRseSB1c2UuIFNvIGZ1cnRoZXIgaW14OHFtIGRldmVsb3BtZW50IGNh
biBoYXBwZW4gaWYNCj4gdGhpcyBpcyBpbnRlZ3JhdGVkPw0KDQpZZXMsIGl0IGJsb2NrcyB0aGUg
bW9zdCBmb2xsb3dpbmcgTVg4UVhQL1FNIHdvcmsuDQpMZXQgbWUgbG9vcCBpbiBTaGF3biB0byBz
ZWUgaWYgYW55IHN1Z2dlc3Rpb25zLg0KDQpTaGF3biwNCkFueSBpZGVhcz8NCg0KUmVnYXJkcw0K
QWlzaGVuZw0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IA0KPiBPbGl2ZXINCg==

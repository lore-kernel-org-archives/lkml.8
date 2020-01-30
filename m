Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FBC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88D0206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="iKfMYj8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgA3Lf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:35:28 -0500
Received: from mail-eopbgr140128.outbound.protection.outlook.com ([40.107.14.128]:24449
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbgA3Lf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcF6Ut6rZgQ+lz9J4Fw1mrL/F6WVaIoq2moj9QdSa/3tQv6F1xjYUNxyNqPfcZulEjB5GVBevFAnFTu8gKxq1FSTkN74bSfjbfstMvH8EZbZYbeIFiCPyzp3B/o4AvkpUTOk7XdhsoWsNyS3zfzamp5j7xib65rPiO9CNFds4kXgIDgUeA6LYm5mMkOQH97FS0UgnfGDovE2hYfn+j7ifAgborcouyw7fsWWd0s2PIq0aYRsDh6Ou/nJqDsQzVGjUcuKYU9qorTbvmmtNzMf9PIQwu8UWk4AcNPekG0w2f7BweNV6kcRFwiFE38HKGGQJjGnN9cBYnooRdo3BpiTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVZ238uqztJzFIIjeMmknp4LvunONIXBq+2sDryVdgA=;
 b=a+O/o6ji3FsRZ7chnAdNXQkx+mHyptghD2Jk1xxzXMby8jxBWJQL37ToPilHcT074vLwQIjNz9VJtxM2jj3g5xWigau8A5UgOYMaU0DXr/ibJl4cj4Nqlz0H5Prgz5t0qzc9j/7T2v3+ip2cwCmgH4bPAaymnTxT5lTkpLj4BaMLLoat9absRp6glvZyB5JwXGXNgGk4CWUoyALv5Hw3buphhC9UwK6hI+4qTVanS/nVclKLRwtgsJMdWnT7LU7nUggtsVW+22V4syb7f7xlmegSOuAFNfODzOZOzojNIAbc6+lzx21sXloEKmFqWM2+nWhoV880hplfmRX25xQuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVZ238uqztJzFIIjeMmknp4LvunONIXBq+2sDryVdgA=;
 b=iKfMYj8xa4up2g1S/3G3TsSlACDKACfQuNXXgKewgZLtLI15OnWjNGKovsGXGESoipUP6UO09hUtSWb4FnlfWG4k5ows9MZi9SLT5LM7gSFJKmNXrFD/thm6aXbaI53LeLlfX8Lo36nNuO70SL78QvtMZD35dIwpU0w6YRorrHw=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB4117.eurprd05.prod.outlook.com (52.135.160.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 11:35:21 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 11:35:20 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx7-colibri: add gpio-line-names
Thread-Topic: [PATCH] ARM: dts: imx7-colibri: add gpio-line-names
Thread-Index: AQHV1u6T6Au7sACMnESk84HTgdWk3KgDFNYA
Date:   Thu, 30 Jan 2020 11:35:20 +0000
Message-ID: <44749d26e921bee56d23eba10158160841e741da.camel@toradex.com>
References: <20200129215336.417431-1-stefan@agner.ch>
In-Reply-To: <20200129215336.417431-1-stefan@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a13122f-b977-4d95-d0a3-08d7a5787d18
x-ms-traffictypediagnostic: AM6PR05MB4117:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB411741D8E1166DD6EF46877DF4040@AM6PR05MB4117.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(54906003)(36756003)(478600001)(6506007)(6512007)(110136005)(5660300002)(8936002)(86362001)(6486002)(26005)(186003)(7416002)(44832011)(76116006)(91956017)(4326008)(66446008)(66946007)(66476007)(2616005)(316002)(66556008)(64756008)(71200400001)(81166006)(81156014)(2906002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4117;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJWUFq82Vrx1hlgRikqK8I2vW8BgN3kjyjoJZVD4EDqqHAyqQnjFJXDI8Jje8VTZU6pY5jB1NgzqFDOnvwEXjosUKVTNqlLCe8dnuQvfN8StWcC2cI5STz3p7YHLBHE+FY5tntA+ZNWl5vyyF6Wj4eWpqVhCaJsbJFnIu3KZ1fUFU5r9P58m/oKllz+GNKZ5bvYEXUiAwfADCUWYCTkdAPpCWfXWmddhb5bPcRp1RwRHnTXU3yi3beOi/RP2zr+e/wkZRubgYGpwd0w7jPA4gNbzTQdxovex/csFvyv//KuBVqH2YNiAOyVa+8uTZTZm/EOU9uKhe8uFuyC5qBAstloUJY4/2TqHUQcou6Y1b1mDZM0vvhZiKqeOslVLwHfWjkZ+2MyYiqxyWivGBc7QgBGmU/8xju5s9uf/BunI60CefirzbPcQhsnrHBH1oD+Z
x-ms-exchange-antispam-messagedata: V1iRwMeeZgB6x5yeidyAVhViZJUt2h1PURDRhNFQaWt93t0L7pQmyvSYygixCF5x9205CHK0wLyL8Xi5WjLI2YzMotzX8cq3hhOzNKoKsSkzVaZg2NYtwhL9l9Bx5L4nljk/OsPKgNh3L53KFgbn/w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <03481DAB07273745B91714928981943B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a13122f-b977-4d95-d0a3-08d7a5787d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 11:35:20.8352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUmvhweFM6HMiF4E3MMD0+w0mWkZ3EIvZ1+BV/dYajRoeP518thm94Xnlqx3xUJtWRm9B9OD39Pv6+cXBuwOTcEs/oBrN+e5mKvNluJzxm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTI5IGF0IDIyOjUzICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IEZyb206IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KPiANCj4gQWRk
IENvbGlicmkgU09ESU1NIG51bWJlcnMgYXMgR1BJTyBsaW5lIG5hbWVzIG9uIG1vZHVsZSBsZXZl
bC4gVGhlDQo+IEdQSU8NCj4gbGluZXMgd2l0aCBhIG5hbWUgYXJlIGFsbCBhdmFpbGFibGUgb24g
dGhlIFNPRElNTSBlZGdlIGNvbm5lY3RvciBvZg0KPiB0aGUNCj4gQ29saWJyaSBpTVg3IG1vZHVs
ZSBhbmQgdGhlcmVmb3JlIGEgY3VzdG9tZXIgbWlnaHQgdXNlIGl0IGFzIGEgR1BJTy4NCj4gVGhl
DQo+IFRvcmFkZXggRXZhbHVhdGlvbiBCb2FyZCBoYXMgdGhlIFNPRElNTSBudW1iZXJzIHByaW50
ZWQgb24gdGhlIHNpbGstDQo+IHNjcmVlbi4gVGhpcyBhbGxvd3MgYSBjdXN0b21lciB0byBxdWlj
a2x5IGNvbnRyb2wgYSBHUElPIG9uIGEgcGluLQ0KPiBoZWFkZXINCj4gYnkgdXNpbmcgdGhlIG5h
bWUgcHJpbnRlZCBuZXh0IHRvIGl0Lg0KPiANCj4gUHV0dGluZyB0aGUgR1BJTyBsaW5lIG5hbWUg
b24gbW9kdWxlIGxldmVsIG1ha2VzIHN1cmUgdGhhdCBhIGN1c3RvbWVyDQo+IGdldHMgYSByZWFz
b25hYmxlIGRlZmF1bHQuIElmIG1vcmUgbWVhbmluZ2Z1bCBuYW1lcyBhcmUgYXZhaWxhYmxlIG9u
IGENCj4gY3VzdG9tIGNhcnJpZXIgYm9hcmQsIHRoZSB1c2VyIGNhbiBvdmVyd3JpdGUgdGhlIGxp
bmUgbmFtZXMgaW4gYQ0KPiBjYXJyaWVyDQo+IGJvYXJkIGxldmVsIGRldmljZSB0cmVlLg0KPiAN
Cj4gVGhlIGVNTUMgYmFzZWQgbW9kdWxlcyBzaGFyZSBhbGwgR1BJTyBuYW1lcyBleGNlcHQgdHdv
IEdQSU9zIG9uIGJhbmsgNg0KPiB3aGljaCBhcmUgbm90IGF2YWlsYWJsZSBvbiB0aGUgcmF3IE5B
TkQgZGV2aWNlcy4gSGVuY2Ugb3ZlcndyaXRlIEdQSU8NCj4gbGluZSBuYW1lcyBvZiBiYW5rIDYg
aW4gdGhlIGVNTUMgc3BlY2lmaWMgZGV2aWNlIHRyZWUgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KDQpSZXZpZXdlZC1i
eTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQo+
IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kgICAgICAgfCAxNzgN
Cj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QtY29s
aWJyaS1lbW1jLmR0c2kgfCAgMjYgKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMDQgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJy
aS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gaW5kZXgg
ZDA1YmUzZjBlMmE3Li4xMGQ4ODgwZThkMTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDctY29saWJyaS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29s
aWJyaS5kdHNpDQo+IEBAIC0xMzAsNiArMTMwLDE4NCBAQCAmZmxleGNhbjIgew0KPiAgCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICB9Ow0KPiAgDQo+ICsmZ3BpbzEgew0KPiArCWdwaW8tbGluZS1u
YW1lcyA9ICJTT0RJTU1fNDMiLA0KPiArCQkJICAiU09ESU1NXzQ1IiwNCj4gKwkJCSAgIlNPRElN
TV8xMzUiLA0KPiArCQkJICAiU09ESU1NXzIyIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICIiLA0K
PiArCQkJICAiU09ESU1NXzM3IiwNCj4gKwkJCSAgIlNPRElNTV8yOSIsDQo+ICsJCQkgICJTT0RJ
TU1fNTkiLA0KPiArCQkJICAiU09ESU1NXzI4IiwNCj4gKwkJCSAgIlNPRElNTV8zMCIsDQo+ICsJ
CQkgICJTT0RJTU1fNjciLA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICJTT0RJ
TU1fMTg4IiwNCj4gKwkJCSAgIlNPRElNTV8xNzgiOw0KPiArfTsNCj4gKw0KPiArJmdwaW8yIHsN
Cj4gKwlncGlvLWxpbmUtbmFtZXMgPSAiU09ESU1NXzExMSIsDQo+ICsJCQkgICJTT0RJTU1fMTEz
IiwNCj4gKwkJCSAgIlNPRElNTV8xMTUiLA0KPiArCQkJICAiU09ESU1NXzExNyIsDQo+ICsJCQkg
ICJTT0RJTU1fMTE5IiwNCj4gKwkJCSAgIlNPRElNTV8xMjEiLA0KPiArCQkJICAiU09ESU1NXzEy
MyIsDQo+ICsJCQkgICJTT0RJTU1fMTI1IiwNCj4gKwkJCSAgIlNPRElNTV85MSIsDQo+ICsJCQkg
ICJTT0RJTU1fODkiLA0KPiArCQkJICAiU09ESU1NXzEwNSIsDQo+ICsJCQkgICJTT0RJTU1fMTUy
IiwNCj4gKwkJCSAgIlNPRElNTV8xNTAiLA0KPiArCQkJICAiU09ESU1NXzk1IiwNCj4gKwkJCSAg
IlNPRElNTV8xMjYiLA0KPiArCQkJICAiU09ESU1NXzEwNyIsDQo+ICsJCQkgICJTT0RJTU1fMTE0
IiwNCj4gKwkJCSAgIlNPRElNTV8xMTYiLA0KPiArCQkJICAiU09ESU1NXzExOCIsDQo+ICsJCQkg
ICJTT0RJTU1fMTIwIiwNCj4gKwkJCSAgIlNPRElNTV8xMjIiLA0KPiArCQkJICAiU09ESU1NXzEy
NCIsDQo+ICsJCQkgICJTT0RJTU1fMTI3IiwNCj4gKwkJCSAgIlNPRElNTV8xMzAiLA0KPiArCQkJ
ICAiU09ESU1NXzEzMiIsDQo+ICsJCQkgICJTT0RJTU1fMTM0IiwNCj4gKwkJCSAgIlNPRElNTV8x
MzMiLA0KPiArCQkJICAiU09ESU1NXzEwNCIsDQo+ICsJCQkgICJTT0RJTU1fMTA2IiwNCj4gKwkJ
CSAgIlNPRElNTV8xMTAiLA0KPiArCQkJICAiU09ESU1NXzExMiIsDQo+ICsJCQkgICJTT0RJTU1f
MTI4IjsNCj4gK307DQo+ICsNCj4gKyZncGlvMyB7DQo+ICsJZ3Bpby1saW5lLW5hbWVzID0gIlNP
RElNTV81NiIsDQo+ICsJCQkgICJTT0RJTU1fNDQiLA0KPiArCQkJICAiU09ESU1NXzY4IiwNCj4g
KwkJCSAgIlNPRElNTV84MiIsDQo+ICsJCQkgICJTT0RJTU1fOTMiLA0KPiArCQkJICAiU09ESU1N
Xzc2IiwNCj4gKwkJCSAgIlNPRElNTV83MCIsDQo+ICsJCQkgICJTT0RJTU1fNjAiLA0KPiArCQkJ
ICAiU09ESU1NXzU4IiwNCj4gKwkJCSAgIlNPRElNTV83OCIsDQo+ICsJCQkgICJTT0RJTU1fNzIi
LA0KPiArCQkJICAiU09ESU1NXzgwIiwNCj4gKwkJCSAgIlNPRElNTV80NiIsDQo+ICsJCQkgICJT
T0RJTU1fNjIiLA0KPiArCQkJICAiU09ESU1NXzQ4IiwNCj4gKwkJCSAgIlNPRElNTV83NCIsDQo+
ICsJCQkgICJTT0RJTU1fNTAiLA0KPiArCQkJICAiU09ESU1NXzUyIiwNCj4gKwkJCSAgIlNPRElN
TV81NCIsDQo+ICsJCQkgICJTT0RJTU1fNjYiLA0KPiArCQkJICAiU09ESU1NXzY0IiwNCj4gKwkJ
CSAgIlNPRElNTV81NyIsDQo+ICsJCQkgICJTT0RJTU1fNjEiLA0KPiArCQkJICAiU09ESU1NXzEz
NiIsDQo+ICsJCQkgICJTT0RJTU1fMTM4IiwNCj4gKwkJCSAgIlNPRElNTV8xNDAiLA0KPiArCQkJ
ICAiU09ESU1NXzE0MiIsDQo+ICsJCQkgICJTT0RJTU1fMTQ0IiwNCj4gKwkJCSAgIlNPRElNTV8x
NDYiOw0KPiArfTsNCj4gKw0KPiArJmdwaW80IHsNCj4gKwlncGlvLWxpbmUtbmFtZXMgPSAiU09E
SU1NXzM1IiwNCj4gKwkJCSAgIlNPRElNTV8zMyIsDQo+ICsJCQkgICJTT0RJTU1fMzgiLA0KPiAr
CQkJICAiU09ESU1NXzM2IiwNCj4gKwkJCSAgIlNPRElNTV8yMSIsDQo+ICsJCQkgICJTT0RJTU1f
MTkiLA0KPiArCQkJICAiU09ESU1NXzEzMSIsDQo+ICsJCQkgICJTT0RJTU1fMTI5IiwNCj4gKwkJ
CSAgIlNPRElNTV85MCIsDQo+ICsJCQkgICJTT0RJTU1fOTIiLA0KPiArCQkJICAiU09ESU1NXzg4
IiwNCj4gKwkJCSAgIlNPRElNTV84NiIsDQo+ICsJCQkgICJTT0RJTU1fODEiLA0KPiArCQkJICAi
U09ESU1NXzk0IiwNCj4gKwkJCSAgIlNPRElNTV85NiIsDQo+ICsJCQkgICJTT0RJTU1fNzUiLA0K
PiArCQkJICAiU09ESU1NXzEwMSIsDQo+ICsJCQkgICJTT0RJTU1fMTAzIiwNCj4gKwkJCSAgIlNP
RElNTV83OSIsDQo+ICsJCQkgICJTT0RJTU1fOTciLA0KPiArCQkJICAiU09ESU1NXzY3IiwNCj4g
KwkJCSAgIlNPRElNTV81OSIsDQo+ICsJCQkgICJTT0RJTU1fODUiLA0KPiArCQkJICAiU09ESU1N
XzY1IjsNCj4gK307DQo+ICsNCj4gKyZncGlvNSB7DQo+ICsJZ3Bpby1saW5lLW5hbWVzID0gIlNP
RElNTV82OSIsDQo+ICsJCQkgICJTT0RJTU1fNzEiLA0KPiArCQkJICAiU09ESU1NXzczIiwNCj4g
KwkJCSAgIlNPRElNTV80NyIsDQo+ICsJCQkgICJTT0RJTU1fMTkwIiwNCj4gKwkJCSAgIlNPRElN
TV8xOTIiLA0KPiArCQkJICAiU09ESU1NXzQ5IiwNCj4gKwkJCSAgIlNPRElNTV81MSIsDQo+ICsJ
CQkgICJTT0RJTU1fNTMiLA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICJTT0RJ
TU1fOTgiLA0KPiArCQkJICAiU09ESU1NXzE4NCIsDQo+ICsJCQkgICJTT0RJTU1fMTg2IiwNCj4g
KwkJCSAgIlNPRElNTV8yMyIsDQo+ICsJCQkgICJTT0RJTU1fMzEiLA0KPiArCQkJICAiU09ESU1N
XzEwMCIsDQo+ICsJCQkgICJTT0RJTU1fMTAyIjsNCj4gK307DQo+ICsNCj4gKyZncGlvNiB7DQo+
ICsJZ3Bpby1saW5lLW5hbWVzID0gIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwNCj4gKwkJ
CSAgIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICIi
LA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwNCj4g
KwkJCSAgIlNPRElNTV8xNjkiLA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICIi
LA0KPiArCQkJICAiU09ESU1NXzc3IiwNCj4gKwkJCSAgIlNPRElNTV8yNCIsDQo+ICsJCQkgICIi
LA0KPiArCQkJICAiU09ESU1NXzI1IiwNCj4gKwkJCSAgIlNPRElNTV8yNyIsDQo+ICsJCQkgICJT
T0RJTU1fMzIiLA0KPiArCQkJICAiU09ESU1NXzM0IjsNCj4gK307DQo+ICsNCj4gKyZncGlvNyB7
DQo+ICsJZ3Bpby1saW5lLW5hbWVzID0gIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiU09ESU1N
XzYzIiwNCj4gKwkJCSAgIlNPRElNTV81NSIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwNCj4g
KwkJCSAgIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiU09ESU1NXzE5NiIsDQo+ICsJCQkgICJT
T0RJTU1fMTk0IiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICJTT0RJTU1fOTkiLA0KPiArCQkJICAi
IiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICJTT0RJTU1fMTM3IjsNCj4gK307DQo+ICsNCj4gICZn
cG1pIHsNCj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCXBpbmN0cmwtMCA9IDwm
cGluY3RybF9ncG1pX25hbmQ+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
N2QtY29saWJyaS1lbW1jLmR0c2kNCj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3ZC1jb2xpYnJp
LWVtbWMuZHRzaQ0KPiBpbmRleCA4OThmNGI4ZDc0MjEuLmFmMzllNTM3MGZhMSAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QtY29saWJyaS1lbW1jLmR0c2kNCj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14N2QtY29saWJyaS1lbW1jLmR0c2kNCj4gQEAgLTEzLDYgKzEz
LDMyIEBAIG1lbW9yeUA4MDAwMDAwMCB7DQo+ICAJfTsNCj4gIH07DQo+ICANCj4gKyZncGlvNiB7
DQo+ICsJZ3Bpby1saW5lLW5hbWVzID0gIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwNCj4g
KwkJCSAgIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkg
ICIiLA0KPiArCQkJICAiIiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICIiLA0KPiArCQkJICAiIiwN
Cj4gKwkJCSAgIlNPRElNTV8xNjkiLA0KPiArCQkJICAiU09ESU1NXzE1NyIsDQo+ICsJCQkgICIi
LA0KPiArCQkJICAiU09ESU1NXzE2MyIsDQo+ICsJCQkgICJTT0RJTU1fNzciLA0KPiArCQkJICAi
U09ESU1NXzI0IiwNCj4gKwkJCSAgIiIsDQo+ICsJCQkgICJTT0RJTU1fMjUiLA0KPiArCQkJICAi
U09ESU1NXzI3IiwNCj4gKwkJCSAgIlNPRElNTV8zMiIsDQo+ICsJCQkgICJTT0RJTU1fMzQiOw0K
PiArfTsNCj4gKw0KPiAgJnVzYm90ZzIgew0KPiAgCWRyX21vZGUgPSAiaG9zdCI7DQo+ICB9Ow0K

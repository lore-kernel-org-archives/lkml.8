Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1880C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9683020736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TaWmONN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDXBIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:08:04 -0400
Received: from mail-vi1eur05on2078.outbound.protection.outlook.com ([40.107.21.78]:57823
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgDXBIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FezgzLHPiw3GkayyDYZy80M24JfbrzFW2KFjvvWNKQmh6EXc8UAkF+yk5/tvOFzPuEYWTBtL4Wez88GpcWvgzlx7G8arVkRaJkSQoaBLZ5IwI13+M3Yg6eY57ADrNwPzahY0OHZcczQ2Gm+RE0TnN/FqqmQMN7WIwKKiposRJ56MbO5FdhybYxzbFTjUI0PMdwHUqMJSPYUcHAgbpISDkeoE/fZiy7gt5P/6dgUVP68You2RSO4Utwzd4HRS+rAaqN0FgCe3S+2N/auhsODggMTnAltCo+yG+0f6rAM525KUbDpNOhRKxGO/ud2VUiW7TgGej2im7l9A8XKQ/Eb/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQoaPGaEPYSi2okK5Or44UGTAhnfj8NNMz+htQ35Sw=;
 b=DzOAAn8zFjw+NYeirMmu3EAPG2T374RuVNY+8yz5jbQUOGn1xFMej4vtb9Bg06oZEY0BxNA9dBX6szcUh2RsXMhhSz6N4PzrDIAbDmRz1bg9qY/GclBEGDk0jRd3zuORQ104snZlkzZUaGO0LmezpzLrjTRldMB3nuY5AoEs8yW7A4+uMZL4yxlvNtzc7MuVYUCF72BIBvsDTNP611WROB3z169Gks6DVcLX5IPXnXp6RDBayW/EXldeZgjjBwjza+8UKr97FsuCAP5UBzhcfbbtc8wwbmBbKP1R10riY1HluVWx8cJ/OEIEzgcuIWqXl7iQiZVrzLoBgKnarSI8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQoaPGaEPYSi2okK5Or44UGTAhnfj8NNMz+htQ35Sw=;
 b=TaWmONN4vs6o9XbefU/lMHkIQnEmmk5fhzjd5QxjFFfX8r2s+IvttphXFUF44oOvQ2R2+4+p3XiItR6ZBNU+TM53thYNWiBlLWylm2IN8Zdt1Y5a1PYypc30zH4dRoWH3Xzdayh3YQl2OkdOjMbn95tXbYeJSETyfb3YeOrZzsQ=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2709.eurprd04.prod.outlook.com (2603:10a6:4:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 01:07:58 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 01:07:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Topic: [PATCH] clk: imx: introduce imx_clk_hw_critical
Thread-Index: AQHWGTz1S3ryZr4eI06QzGNLele1k6iGhU2AgAACxjCAADVJgIAAt/hg
Date:   Fri, 24 Apr 2020 01:07:58 +0000
Message-ID: <DB6PR0402MB276068E21E36BFCCA91728D088D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <AM6PR04MB4966460FE849E557FDA754F980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966460FE849E557FDA754F980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a64d53da-d671-4c90-1fc2-08d7e7ebedac
x-ms-traffictypediagnostic: DB6PR0402MB2709:|DB6PR0402MB2709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2709BCA51A956E0FD0EF7EDF88D00@DB6PR0402MB2709.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(54906003)(8676002)(81156014)(26005)(8936002)(316002)(478600001)(966005)(7696005)(110136005)(2906002)(6506007)(44832011)(186003)(4326008)(66556008)(66946007)(66446008)(66476007)(64756008)(76116006)(53546011)(86362001)(5660300002)(71200400001)(55016002)(52536014)(33656002)(9686003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2aUlqTKdnHfkY4uyOgKEMCU0zylxhcNzW/GbMEWH22c91msvYebGb5xDR3/mVfJpa6B8rdS2PS3L6FLTVITjUIqjmNsLUz6xnhqy9wSKHJ3aSUG9Mn905+dL//r3tYeU9zYm5JO7pjlhwRAOjquXlITW2s55FTBPsE8jTz7JAHZGNO/hi3XbAshJClK2O8pin4gMc+5LmOibqgDw02880ylTeSm5alxVqhivpTOSI4+wppub0Nv8pcQaY7O3ek6N/wGjVfy5bNh9d12PUYdVEfr8imtntzYCcU4DoK5cH/zXpkqos0dXVTSbbIROv2KOS8Ex39YFLTEr21QBnwG0GgDicW0VCR+U/AmHCikMYLpFmtn/nKtxojccs0evVEvn/Ip0VfjLfgUtbiKqTa6gfBXTOduBq1JR2WAsvD9lpLc0z8xeTu1MMOnHMowu74HKZrKjLtD43F5e2m/4hRIskyXKJ6Lm5rzfrGBW5U9kR5aLxIDELTGLlHT72ZwT+EM8GpLeQcXT0Kg+2OeZKJPWA==
x-ms-exchange-antispam-messagedata: rsNlWvTSFopi4L11XNoq/p51voOoNeRhjVq6hq5qXxjK/nwGLuX8Jz97Utn5yOAnTMkAtuurowGnbIA0W47Aisxrd4RUWFDgAy15IPx38ofhIgJWqlOx+KFIAD5PO1vzq3whY7FG22uj88t/5yDGpg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64d53da-d671-4c90-1fc2-08d7e7ebedac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 01:07:58.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixYebc5HrfNtsv2AE/MVYGVeVhLqOxBuycCoSF1xHIuxuoVJX19Gx3Y5LK7J8DDucA8bjM50+OhpfsVjGHcp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IGlteDogaW50cm9kdWNlIGlteF9jbGtfaHdfY3Jp
dGljYWwNCj4gDQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDY6NTQgUE0NCj4gPg0KPiA+ID4gU3ViamVjdDog
UkU6IFtQQVRDSF0gY2xrOiBpbXg6IGludHJvZHVjZSBpbXhfY2xrX2h3X2NyaXRpY2FsDQo+ID4g
Pg0KPiA+ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4gU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDI6NTIgUE0NCj4gPiA+ID4NCj4gPiA+ID4gVG8g
aS5NWDhNIFNvQywgdGhlcmUgaXMgYW4gY2FzZSBpcyB3aGVuIHJ1bm5pbmcgZHVhbCBPU2VzIHdp
dGgNCj4gPiA+ID4gaHlwZXJ2aXNvciwgdGhlIGNsayBvZiB0aGUgaGFyZHdhcmUgdGhhdCBwYXNz
dGhyb3VnaCB0byB0aGUgMm5kIE9TDQo+ID4gPiA+IG5lZWRzIHRvIGJlIHNldHVwIGJ5IDFzdCBM
aW51eCBPUy4NCj4gPiA+ID4gU28gZGV0ZWN0IGNsb2NrLWNyaXRpY2FsIGZyb20gY2NtIG5vZGUg
YW5kIGVuYWJsZSB0aGUgY2xvY2tzIHRvDQo+ID4gPiA+IGxldCB0aGUgMm5kIE9TIGNvdWxkIHVz
ZSB0aGUgaGFyZHdhcmUgd2l0aG91dCB0b3VjaCBDQ00gbW9kdWxlLg0KPiA+ID4gPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLmMgfCAxOSArKysrKysrKysrKysrKysrKysr
DQo+ID4gPiA+IGRyaXZlcnMvY2xrL2lteC9jbGsuaA0KPiA+ID4gPiB8ICAxDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5jIGIvZHJpdmVycy9jbGsvaW14
L2Nsay5jIGluZGV4DQo+ID4gPiA+IDg3YWI4ZGIzZDI4Mi4uZWM3ZDQyMjU0MGMxIDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVy
cy9jbGsvaW14L2Nsay5jDQo+ID4gPiA+IEBAIC0xNzcsMyArMTc3LDIyIEBAIHN0YXRpYyBpbnQg
X19pbml0IGlteF9jbGtfZGlzYWJsZV91YXJ0KHZvaWQpDQo+ID4gPiA+ICAJcmV0dXJuIDA7DQo+
ID4gPiA+ICB9DQo+ID4gPiA+ICBsYXRlX2luaXRjYWxsX3N5bmMoaW14X2Nsa19kaXNhYmxlX3Vh
cnQpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICtpbnQgaW14X2Nsa19od19jcml0aWNhbChzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wLCBzdHJ1Y3QgY2xrX2h3ICoNCj4gPiA+ID4gK2NvbnN0DQo+ID4gPiA+
ICtod3NbXSkgew0KPiA+ID4gPiArCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsNCj4gPiA+ID4gKwlj
b25zdCBfX2JlMzIgKmN1cjsNCj4gPiA+ID4gKwl1MzIgaWR4Ow0KPiA+ID4gPiArCWludCByZXQ7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoIW5wIHx8ICFod3MpDQo+ID4gPiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJb2ZfcHJvcGVydHlfZm9yX2VhY2hfdTMy
KG5wLCAiY2xvY2stY3JpdGljYWwiLCBwcm9wLCBjdXIsIGlkeCkgew0KPiA+ID4NCj4gPiA+IElz
IHRoZXJlIGEgYmluZGluZyBmb3IgaXQgYWxyZWFkeT8NCj4gPg0KPiA+IEkgdGhpbmsgY2xvY2st
Y3JpdGljYWwgaXMgYSBjb21tb24gYmluZGluZ3M/IFNlZSBvZl9jbGtfZGV0ZWN0X2NyaXRpY2Fs
Lg0KPiA+IFBsZWFzZSByZXZpZXcgd2hldGhlciB0aGlzIGFwcHJvYWNoIGlzIGFjY2VwdGFibGUs
IGlmIGRvIG5lZWQNCj4gPiBiaW5kaW5ncywgSSBjb3VsZCBhZGQgdGhhdCBpbiB2Mi4NCj4gPg0K
PiANCj4gSSdtIG9rIGlmIGl0J3MgYSBjb21tb24gYmluZGluZyBhbHJlYWR5IHN1cHBvcnRlZCBi
eSBjdXJyZW50IGNsayBmcmFtZXdvcmsuDQo+IEJ1dCBpdCBzZWVtcyB0byBiZSBtb3JlIGxpa2Ug
YSBjb21tb24gY2xrIGZlYXR1cmUgcmF0aGVyIHRoYW4gcGxhdGZvcm0NCj4gZmVhdHVyZS4NCg0K
SGVyZSBpcyB0byB1c2UgaXQgZm9yIGR1YWwgTGludXggY2FzZSBydW5uaW5nIG9uIGkuTVggcGxh
Zm9ybXMuDQpJdCBpcyB0byByZXBsYWNlIHRoZSBpbml0LW9uLWFycmF5IHByb3BlcnR5IGluIGRv
d25zdHJlYW0ga2VybmVsLg0KDQpUaGUgcmVjb21tZW5kZWQgY3JpdGljYWwgY2xvY2sgaXMgdXNp
bmcgQ0xLX0lTX0NSSVRJQ0FMIGZsYWcgaW4gY2xrIGRyaXZlciwNCm5vdCB1c2UgY2xvY2stY3Jp
dGljYWwgcHJvcGVydHkuDQoNCkJ1dCBoZXJlLCB3ZSBjb3VsZCBub3QgdXNlIENMS19JU19DUklU
SUNBTCwgYmVjYXVzZSB3aGVuIHN1cHBvcnQNCmR1YWwgT1NlcywgaXQgaXMgbm90IGZsZXhpYmxl
LCBhbmQgaXQgd2lsbCBhZmZlY3Qgbm9uIGh5cGVydmlzb3IgY2FzZS4NCg0KPiBBbHNvIGEgYml0
IHN0cmFuZ2UgdGhhdCB3aHkgSSBkaWQgbm90IGZpbmQgdGhlIGJpbmRpbmcgZG9jIGluIGxhdGVz
dCBrZXJuZWwuDQo+IE1heWJlIFN0ZXBoZW4gY291bGQgY29tbWVudCBtb3JlLg0KDQpJdCBpcyB1
c2VkIGhlcmUuDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS43LXJjMi9zb3Vy
Y2UvZHJpdmVycy9jbGsvY2xrLmMjTDQ4OTENCg0KPiANCj4gQlRXLCBpZiB1c2luZyB0aGlzIGZv
ciBkdWFsIE9TZXMgY2FzZSwgd2lsbCB0aG9zZSBjcml0aWNhbCBjbG9ja3MgYWZmZWN0IHRoZSBu
b3JtYWwNCj4gdXNlcnMgdGhhdCBub3QgYm9vdGluZyB0aGUgc2Vjb25kIE9TPw0KDQpOby4gZHVh
bCBvcyB1c2luZyB4LXJvb3QuZHRzLCBub3QgeC5kdHMuIGNyaXRpY2FsLWNsb2NrIHdpbGwgYmUg
cHVzaCBpbiB4LXJvb3QuZHRzLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBSZWdhcmRzDQo+
IEFpc2hlbmcNCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcuDQo+ID4NCj4gPiA+DQo+ID4gPiBS
ZWdhcmRzDQo+ID4gPiBBaXNoZW5nDQo+ID4gPg0KPiA+ID4gPiArCQlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoaHdzW2lkeF0tPmNsayk7DQo+ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ICsJ
CQlyZXR1cm4gcmV0Ow0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiAw
Ow0KPiA+ID4gPiArfQ0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5o
IGIvZHJpdmVycy9jbGsvaW14L2Nsay5oIGluZGV4DQo+ID4gPiA+IGQ0ZWExNjA5YmNiNy4uNzAx
ZDc0NDBmOThjIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLmgNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiA+IEBAIC05LDYgKzksNyBA
QCBleHRlcm4gc3BpbmxvY2tfdCBpbXhfY2NtX2xvY2s7DQo+ID4gPiA+DQo+ID4gPiA+ICB2b2lk
IGlteF9jaGVja19jbG9ja3Moc3RydWN0IGNsayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQp
Ow0KPiA+ID4gPiB2b2lkIGlteF9jaGVja19jbGtfaHdzKHN0cnVjdCBjbGtfaHcgKmNsa3NbXSwg
dW5zaWduZWQgaW50IGNvdW50KTsNCj4gPiA+ID4gK2ludCBpbXhfY2xrX2h3X2NyaXRpY2FsKHN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHN0cnVjdCBjbGtfaHcgKg0KPiA+ID4gPiArY29uc3QgaHdz
W10pOw0KPiA+ID4gPiAgdm9pZCBpbXhfcmVnaXN0ZXJfdWFydF9jbG9ja3Moc3RydWN0IGNsayAq
KiBjb25zdCBjbGtzW10pOyAgdm9pZA0KPiA+ID4gPiBpbXhfbW1kY19tYXNrX2hhbmRzaGFrZSh2
b2lkIF9faW9tZW0gKmNjbV9iYXNlLCB1bnNpZ25lZCBpbnQNCj4gY2huKTsNCj4gPiA+ID4gdm9p
ZCBpbXhfdW5yZWdpc3Rlcl9jbG9ja3Moc3RydWN0IGNsayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQN
Cj4gPiA+ID4gY291bnQpOw0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjE2LjQNCg0K

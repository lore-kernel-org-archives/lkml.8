Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CCEC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F8B20715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YyX3K2Jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDXCAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:00:46 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:37428
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbgDXCAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7iydBW6lHuFisHprSdgOj+LSNE0Qwaf8hD1TKWul1RLv8aXUPMb5qcl4fncTEd0b8kp+FOeh36QC7wbqQ97FJkjJ6GA30JWk7HRGCh6hkhoamp5P80YX2wCL4rFX+VPcR13bGhpz/D9u3jzf2IdMF2mlujK9Y1Vdz3MQpVT2EjXwj/jcWKRweixVHIYrK19rv0lAOEweSl3r8JnzT9dCkqgkdxIL90+olYZ5ftQMNsfmQo00JcqDk+jBsoHoM9CavuZ4wTShgW7RWKX6ZtiQ4yLZMge+F/u9Bil8Jnx7HX3zQn3wLeuZ2mvdi4oOgdJPbMrh2R69MnQaI6LGdi5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuy9geXnC9nAEj0Wpc//Eboz+dERgk1UiSlQtz+68IQ=;
 b=TIkKAFVirMu9MHSCyHnjYq1IwYxQxRmebghU4NVuNP+pJlfBOS3xNsE/dN/0QswKI8+D9m4eHkhItj0UKjPWqZ/MNX/ckTLNrBnrVTzrsUSOeA/dbHjvWeD8y8DPHpNvS5wAnTmd0Yx43D3Kw69/xrGq4n2kOmFyf5m5GkKZy1CTCJ97zG0eq/I25p3w7OFi78bzoBFJuwCwGnyfw5NMweFBOR3GHJFI43U0EeceO8LCw77CeoUbzAyjCnTqdskWYd8FAV1h8q6JEt8QHv9piWw6Z0QzP9n8pyqG0FyL1VsW86gc65EBvRNr5SvFdL2t1B1ZAiG9Sah6EGCETwZC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuy9geXnC9nAEj0Wpc//Eboz+dERgk1UiSlQtz+68IQ=;
 b=YyX3K2JgY5XYKQWhv8bCsfRsBprRlMka4WdMdLEO8O4D1MdeFemztspf0eM1xW8l9ju3NEu7IDFYABzYvzTByShwF20T/dOTj3zPgjEflbtWoSgNqCziv7uHwRloRI70uvFnd9nPXZJEF19dKfaRXdA2uKIXpp64ttnqGHY0n58=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6328.eurprd04.prod.outlook.com (2603:10a6:20b:b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 01:59:02 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 01:59:02 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
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
Thread-Index: AQHWGTz23ipTFSUpC02goIyCROLLPKiGhOhwgAADf4CAADHRcIAAvOMAgAAM6xA=
Date:   Fri, 24 Apr 2020 01:59:02 +0000
Message-ID: <AM6PR04MB49665A599A06623160EB592980D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587624748-27228-1-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966934EE0411F7C3FF5AA2F80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB2760793865AA2E67E1C33F4488D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <AM6PR04MB4966460FE849E557FDA754F980D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276068E21E36BFCCA91728D088D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB276068E21E36BFCCA91728D088D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 810c2ee4-1380-4178-bc1e-08d7e7f30fb5
x-ms-traffictypediagnostic: AM6PR04MB6328:|AM6PR04MB6328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB63288430082A1C44DFD2D9E680D00@AM6PR04MB6328.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(81156014)(8676002)(64756008)(8936002)(71200400001)(86362001)(66476007)(2906002)(966005)(5660300002)(76116006)(478600001)(66946007)(4326008)(33656002)(55016002)(7696005)(110136005)(52536014)(54906003)(9686003)(66556008)(316002)(26005)(186003)(6506007)(53546011)(44832011)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXPJFVtBjmRO3Yjf9+2WI3CyyINzoTO3yvWrKHqCYe8NNG/CZAVRf5U/7u3hJGv9m2MVC5oWxB1d2WKFvRS5BsNa1QsAWuM8brS9jUvG+TPkiCXjK70F5uFcCf4pI1PkUwoPU8IeNFPr6TMBJmTNImUDAaa9aG9XCLKbUbXUfCbWkM2oN2RzFm4QXu+P9bxX3JGLMlCOfVd7Ja6+OANKRZ+RTM5ZiQ9XszG3LbnAM/psxm8thPgiSuRJ3FVrJYzYseWdYK8yp2N2eowqomu9HJtJut9VbDPE1jjadON8oyRCgddHOhXHGyIEfIYCQDec/BUN62OWcIIxDNh/GIuSIVaILAdvUAiokD5+FbyBNRCW5Au1pdblr4VwJDORbOEOtgFhoPodnfoa0UevNNHCRgG6yh+J7PBvKRPiYTz3YQAm3WNs6dAMbe54cyw0Hb+KV4uKsdSgmO+eueqNwoqy6onUY5nWhaUFOMvFmsOUAv2knQH4/px3oy3yEVsf5cLjnGoeY+t04H8AVJtRjtzopw==
x-ms-exchange-antispam-messagedata: ailYHvJMCcn01pGS3fzKBMOsw4zbyBQyiH1SWGqAhFPpnAYHTstcji7LUgYibiTysy6icZG9mENtVsSSAb1HYLWuVX8N1mw0GV6/x/1SSTSrlNzczZePPUY4Kp35+/MNTkf82+yY3yJBqu1Rd1Fl8A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c2ee4-1380-4178-bc1e-08d7e7f30fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 01:59:02.1564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBm2KT8tYNKSloLqzEGViBCJ3s2OKx2EC4G2/8ecJ/so92G87ELNDHUYCqDSuseCvzcMIxAUooh53WtOdN7HUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJp
bCAyNCwgMjAyMCA5OjA4IEFNDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGNsazogaW14
OiBpbnRyb2R1Y2UgaW14X2Nsa19od19jcml0aWNhbA0KPiA+DQo+ID4gPiBGcm9tOiBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMywgMjAy
MCA2OjU0IFBNDQo+ID4gPg0KPiA+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBjbGs6IGlteDog
aW50cm9kdWNlIGlteF9jbGtfaHdfY3JpdGljYWwNCj4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4gPiBTZW50OiBUaHVyc2RheSwgQXBy
aWwgMjMsIDIwMjAgMjo1MiBQTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVG8gaS5NWDhNIFNvQywg
dGhlcmUgaXMgYW4gY2FzZSBpcyB3aGVuIHJ1bm5pbmcgZHVhbCBPU2VzIHdpdGgNCj4gPiA+ID4g
PiBoeXBlcnZpc29yLCB0aGUgY2xrIG9mIHRoZSBoYXJkd2FyZSB0aGF0IHBhc3N0aHJvdWdoIHRv
IHRoZSAybmQNCj4gPiA+ID4gPiBPUyBuZWVkcyB0byBiZSBzZXR1cCBieSAxc3QgTGludXggT1Mu
DQo+ID4gPiA+ID4gU28gZGV0ZWN0IGNsb2NrLWNyaXRpY2FsIGZyb20gY2NtIG5vZGUgYW5kIGVu
YWJsZSB0aGUgY2xvY2tzIHRvDQo+ID4gPiA+ID4gbGV0IHRoZSAybmQgT1MgY291bGQgdXNlIHRo
ZSBoYXJkd2FyZSB3aXRob3V0IHRvdWNoIENDTSBtb2R1bGUuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4gPiAt
LS0NCj4gPiA+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay5jIHwgMTkgKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gPiA+IGRyaXZlcnMvY2xrL2lteC9jbGsuaA0KPiA+ID4gPiA+IHwgIDENCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGsuYyBi
L2RyaXZlcnMvY2xrL2lteC9jbGsuYyBpbmRleA0KPiA+ID4gPiA+IDg3YWI4ZGIzZDI4Mi4uZWM3
ZDQyMjU0MGMxIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0K
PiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGsuYw0KPiA+ID4gPiA+IEBAIC0xNzcs
MyArMTc3LDIyIEBAIHN0YXRpYyBpbnQgX19pbml0IGlteF9jbGtfZGlzYWJsZV91YXJ0KHZvaWQp
DQo+ID4gPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ICBsYXRlX2lu
aXRjYWxsX3N5bmMoaW14X2Nsa19kaXNhYmxlX3VhcnQpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiAraW50IGlteF9jbGtfaHdfY3JpdGljYWwoc3RydWN0IGRldmljZV9ub2RlICpucCwgc3RydWN0
IGNsa19odyAqDQo+ID4gPiA+ID4gK2NvbnN0DQo+ID4gPiA+ID4gK2h3c1tdKSB7DQo+ID4gPiA+
ID4gKwlzdHJ1Y3QgcHJvcGVydHkgKnByb3A7DQo+ID4gPiA+ID4gKwljb25zdCBfX2JlMzIgKmN1
cjsNCj4gPiA+ID4gPiArCXUzMiBpZHg7DQo+ID4gPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiArCWlmICghbnAgfHwgIWh3cykNCj4gPiA+ID4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlvZl9wcm9wZXJ0eV9mb3JfZWFjaF91MzIo
bnAsICJjbG9jay1jcml0aWNhbCIsIHByb3AsIGN1ciwgaWR4KQ0KPiA+ID4gPiA+ICt7DQo+ID4g
PiA+DQo+ID4gPiA+IElzIHRoZXJlIGEgYmluZGluZyBmb3IgaXQgYWxyZWFkeT8NCj4gPiA+DQo+
ID4gPiBJIHRoaW5rIGNsb2NrLWNyaXRpY2FsIGlzIGEgY29tbW9uIGJpbmRpbmdzPyBTZWUgb2Zf
Y2xrX2RldGVjdF9jcml0aWNhbC4NCj4gPiA+IFBsZWFzZSByZXZpZXcgd2hldGhlciB0aGlzIGFw
cHJvYWNoIGlzIGFjY2VwdGFibGUsIGlmIGRvIG5lZWQNCj4gPiA+IGJpbmRpbmdzLCBJIGNvdWxk
IGFkZCB0aGF0IGluIHYyLg0KPiA+ID4NCj4gPg0KPiA+IEknbSBvayBpZiBpdCdzIGEgY29tbW9u
IGJpbmRpbmcgYWxyZWFkeSBzdXBwb3J0ZWQgYnkgY3VycmVudCBjbGsgZnJhbWV3b3JrLg0KPiA+
IEJ1dCBpdCBzZWVtcyB0byBiZSBtb3JlIGxpa2UgYSBjb21tb24gY2xrIGZlYXR1cmUgcmF0aGVy
IHRoYW4gcGxhdGZvcm0NCj4gPiBmZWF0dXJlLg0KPiANCj4gSGVyZSBpcyB0byB1c2UgaXQgZm9y
IGR1YWwgTGludXggY2FzZSBydW5uaW5nIG9uIGkuTVggcGxhZm9ybXMuDQo+IEl0IGlzIHRvIHJl
cGxhY2UgdGhlIGluaXQtb24tYXJyYXkgcHJvcGVydHkgaW4gZG93bnN0cmVhbSBrZXJuZWwuDQo+
IA0KPiBUaGUgcmVjb21tZW5kZWQgY3JpdGljYWwgY2xvY2sgaXMgdXNpbmcgQ0xLX0lTX0NSSVRJ
Q0FMIGZsYWcgaW4gY2xrIGRyaXZlciwgbm90DQo+IHVzZSBjbG9jay1jcml0aWNhbCBwcm9wZXJ0
eS4NCj4gDQoNCkNsb2NrLWNyaXRpY2FsIHByb3BlcnR5IHNlZW1zIERUIHVzYWdlIG9mIENMS19J
U19DUklUSUNBTCBmbGFnIGFuZCBwdXJlIHBsYXRmb3JtIGluZGVwZW5kZW50Lg0KU28gSSB3b25k
ZXIgaWYgdGhpcyBmZWF0dXJlIGNvdWxkIGJlIGFkZGVkIGludG8gb2ZfY2xrX2FkZF9od19wcm92
aWRlci4NCg0KPiBCdXQgaGVyZSwgd2UgY291bGQgbm90IHVzZSBDTEtfSVNfQ1JJVElDQUwsIGJl
Y2F1c2Ugd2hlbiBzdXBwb3J0IGR1YWwgT1NlcywNCj4gaXQgaXMgbm90IGZsZXhpYmxlLCBhbmQg
aXQgd2lsbCBhZmZlY3Qgbm9uIGh5cGVydmlzb3IgY2FzZS4NCj4gDQoNCkEgYml0IGNvbmZ1aW5n
IGJlY2F1c2UgeW91IHNhaWQgdGhlIGNyaXRpY2FsLWNsb2NrIHByb3BlcnR5IHdpbGwgb25seSBi
ZSB1c2VkIGJ5DQpIeXBlcnZpc29yIGR0cywgdGhlbiBob3cgdG8gYWZmZWN0IG5vbiBoeXBlcnZp
c29yIGNhc2VzPw0KDQo+ID4gQWxzbyBhIGJpdCBzdHJhbmdlIHRoYXQgd2h5IEkgZGlkIG5vdCBm
aW5kIHRoZSBiaW5kaW5nIGRvYyBpbiBsYXRlc3Qga2VybmVsLg0KPiA+IE1heWJlIFN0ZXBoZW4g
Y291bGQgY29tbWVudCBtb3JlLg0KPiANCj4gSXQgaXMgdXNlZCBoZXJlLg0KPiBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC92NS43LXJjMi9zb3VyY2UvZHJpdmVycy9jbGsvY2xrLmMj
TDQ4OTENCg0KWWVzLCBJIGFsc28gc2F3IGl0LCBidXQgZGlkbid0IGZpbmQgYmluZGluZyBkb2Mu
DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gPg0KPiA+IEJUVywgaWYgdXNpbmcgdGhpcyBm
b3IgZHVhbCBPU2VzIGNhc2UsIHdpbGwgdGhvc2UgY3JpdGljYWwgY2xvY2tzDQo+ID4gYWZmZWN0
IHRoZSBub3JtYWwgdXNlcnMgdGhhdCBub3QgYm9vdGluZyB0aGUgc2Vjb25kIE9TPw0KPiANCj4g
Tm8uIGR1YWwgb3MgdXNpbmcgeC1yb290LmR0cywgbm90IHguZHRzLiBjcml0aWNhbC1jbG9jayB3
aWxsIGJlIHB1c2ggaW4geC1yb290LmR0cy4NCj4gDQo+IFRoYW5rcywNCj4gUGVuZy4NCj4gDQo+
ID4NCj4gPiBSZWdhcmRzDQo+ID4gQWlzaGVuZw0KPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBQ
ZW5nLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gUmVnYXJkcw0KPiA+ID4gPiBBaXNoZW5nDQo+
ID4gPiA+DQo+ID4gPiA+ID4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGh3c1tpZHhdLT5j
bGspOw0KPiA+ID4gPiA+ICsJCWlmIChyZXQpDQo+ID4gPiA+ID4gKwkJCXJldHVybiByZXQ7DQo+
ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiA+
ID4gK30NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay5oIGIvZHJp
dmVycy9jbGsvaW14L2Nsay5oIGluZGV4DQo+ID4gPiA+ID4gZDRlYTE2MDliY2I3Li43MDFkNzQ0
MGY5OGMgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4g
PiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay5oDQo+ID4gPiA+ID4gQEAgLTksNiArOSw3
IEBAIGV4dGVybiBzcGlubG9ja190IGlteF9jY21fbG9jazsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ICB2b2lkIGlteF9jaGVja19jbG9ja3Moc3RydWN0IGNsayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQg
Y291bnQpOw0KPiA+ID4gPiA+IHZvaWQgaW14X2NoZWNrX2Nsa19od3Moc3RydWN0IGNsa19odyAq
Y2xrc1tdLCB1bnNpZ25lZCBpbnQNCj4gPiA+ID4gPiBjb3VudCk7DQo+ID4gPiA+ID4gK2ludCBp
bXhfY2xrX2h3X2NyaXRpY2FsKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsIHN0cnVjdCBjbGtfaHcg
Kg0KPiA+ID4gPiA+ICtjb25zdCBod3NbXSk7DQo+ID4gPiA+ID4gIHZvaWQgaW14X3JlZ2lzdGVy
X3VhcnRfY2xvY2tzKHN0cnVjdCBjbGsgKiogY29uc3QgY2xrc1tdKTsNCj4gPiA+ID4gPiB2b2lk
IGlteF9tbWRjX21hc2tfaGFuZHNoYWtlKHZvaWQgX19pb21lbSAqY2NtX2Jhc2UsIHVuc2lnbmVk
DQo+ID4gPiA+ID4gaW50DQo+ID4gY2huKTsNCj4gPiA+ID4gPiB2b2lkIGlteF91bnJlZ2lzdGVy
X2Nsb2NrcyhzdHJ1Y3QgY2xrICpjbGtzW10sIHVuc2lnbmVkIGludA0KPiA+ID4gPiA+IGNvdW50
KTsNCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMTYuNA0KDQo=

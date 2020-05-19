Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95694207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T6oBsuKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgESC54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:57:56 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:6110
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbgESC5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:57:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw53O0Dr949F+wdiRt/fwUrWlS4gI/pBB60/QG8Da2jJnw9HHn2668pYYExQg83hMidNO6VdPRQwun7b4qULZj84BGPBCLLkFAljJ4vHEiLQgsFKyPXeBlALTT52hVMb+ZLIKT5HjNwBsB3ylKuHHRGnhFNMuPOiIsD7WqgJjAqh2ApZfjPo+UZxB1NDhaX2vUpcP5pAqSYrWE2jUc0TDcPpcH0a7a8zd+D5R5WlP6dxJhuY/uqWj8FD4FJMmzCLEnDTkVItlDy5+kDLF8OqyU0D+OFY7JV+eNeCnYHjl9MfNB1Ewv2aWASRG/92hjq+pVi7b/1PMimAyLeAY/dS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FqfzCkNPv6P1SA8zyiUDiZVONX64ldFekpYC0QvnxU=;
 b=SZPZI0i2QmMkBDkNchX9iDr1eLbci3eOBjgFC/lryh5ZxJJYM34Qmj80UIFT1h0O/21xXkeIhI/dKdNtgbvOWj8Lunbjyv7U3XHskTDH4E+RLelvcq5buf7tHjFijO7deJeKQubtIkoltfwwNp/i9FJMuOda3/Qp/o9h+JaZ9KKkpotvxONJPy13kUrOnVjK09d+2jYx/Vw/kQrdKbJE2ZSKtNoF2DLVlYTYB5yIVxCrG7TVN+BscXcmSjctvD6C0Raxh+GJ9MyfI9gVG1DYfwyhS9q6jAAw+O93MUy+i8522moxb0AN73+U+iV14GV25D+vwgr/BTdl92QvcUAyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FqfzCkNPv6P1SA8zyiUDiZVONX64ldFekpYC0QvnxU=;
 b=T6oBsuKBLAiFWwVlAOwY2dgVCFLJZrQvCpNlya8QG+SNkoc9EgnwIZyJfkgTanL0JaK7viqTUcMIGJh6Jj4WtlxcJXHDPi2MwrQd173l7aM5qGlvhPQ2kZBOugnqJmebIK82U9IyTo611del1C5Lb6dqpIOtqwE+AZ+6+hpKU14=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3673.eurprd04.prod.outlook.com (2603:10a6:8:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 02:57:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:57:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: clock: Convert i.MX7D clock to
 json-schema
Thread-Topic: [PATCH V2] dt-bindings: clock: Convert i.MX7D clock to
 json-schema
Thread-Index: AQHWLSVULubEBF9aZ0ekkgAtmYRNgqiuqIEAgAAPYyA=
Date:   Tue, 19 May 2020 02:57:51 +0000
Message-ID: <DB3PR0402MB391638F2EBABD4B50D42648BF5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589813554-20929-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B101D3E0A0820FAD4CDC80B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966B101D3E0A0820FAD4CDC80B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27053483-8a11-4208-c4a7-08d7fba06bb1
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3673CF9E3B5B2E9A0AFCF3EEF5B90@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BbFbyOU5DaHSSERAkGxUshBr8+eC4fEvXOUjQfDm27WwTC8VHBvlTjzVd9rOodP2VzEPMqw5mPqpti2XetR/mOXWlE0AMKhcBdX4PgQ8tJ8CHy2ym+y17s9zUZsEohda/3wbjMDVhRLg+TliIbsZL17DHgBrokvAedzIFFSUd9sdDz98glPXghZOaXmseB3tW85xbiBXAArG9q5KvpfUn8p4yOmEVsckVqInh+yz/FUD39Fhi4VGMyaG3FfTNIbGD0heE4XYU5BOHLO+HKWUE/IPp2yAfC5P9odbL5lmqCkUe1cmm5T2cHRXEJOHeUKDvFHQtnE5s2u4rdyv4xMqCprp5zmnoEgSQkKhXe3XS6wHqdsiAIQzBprPtWzuYIWSlJfhOlPK2RKqRpYe+wPUaUTCYy4sm5b+qJ18SjmdxH2zcF5qhmiZ9RfSnzBXMWXl6onNQ+koXttO4wkLQEdPC5u2lmj/MFGOuFTeyyG3ikE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(55016002)(9686003)(76116006)(71200400001)(6506007)(66476007)(66556008)(64756008)(66446008)(44832011)(66946007)(2906002)(186003)(26005)(5660300002)(4326008)(52536014)(478600001)(8936002)(110136005)(7416002)(33656002)(86362001)(316002)(7696005)(8676002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /wAdVmRrkJqflt5xoSoPSBg/GIMEkWNxKlV8sINpvmTcg2NFbJriRDanuf7MG9ypzyWME6nhYDORMOsyErAvMjjA/pDI+O1UD+pk8gQJt/CRw8tXJyf4hiPmaDQb4cJ8/4dLmFEOFTNDNRHiVpEB9ErEiF3qYrH64NEYxJFq7Nw+coUm7grU1dZxE+PGqPctrd2e5oJvi37eXqcQJy92z3WIsq1y2gZ/LBQTMXhfRsDYrPMbqSTMR4YtdV3YiYmndgCPI4ZBgOf7dDdVdIJ4aRNpT+wbfMdlu+nnhwo9SjseXDAhivnA2PSfiAQxBUdZK98bprP4GA0/YEe7eZ5X9ATUcs9ytHxzsPyeGn0/w+9Wg+/z97k79ye4IBpWgroXODYmuYHq+veHi92OjaZOJPP4ORjwUnMO9vW6QHp/FB/bFwLwhrkaZK7A55Le9aKf5xj4dPKaFstlVfdYRtMTYzIoZ1oiFnuuIEbpQUuOjty6Ye+WnMs+kD5mTNy7/c39
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27053483-8a11-4208-c4a7-08d7fba06bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:57:51.5106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44k/R3D0Ic8lBXTu2cm0kFCKt8Pp0Hq3G8UIT3nH4DDfPjBkNvKOgKYU6bFyA8S5qT4gBh4bCkKTgnms0TCbrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCBWMl0gZHQtYmluZGluZ3M6IGNsb2NrOiBDb252ZXJ0
IGkuTVg3RCBjbG9jayB0bw0KPiBqc29uLXNjaGVtYQ0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIE1heSAxOCwgMjAyMCAx
MDo1MyBQTQ0KPiA+DQo+ID4gQ29udmVydCB0aGUgaS5NWDdEIGNsb2NrIGJpbmRpbmcgdG8gRFQg
c2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMg
c2luY2UgVjE6DQo+ID4gCS0gVXBkYXRlIG1haW50YWluZXIncyBlLW1haWwgYWRkcmVzcy4NCj4g
PiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14N2QtY2xvY2sudHh0
ICAgICAgfCAxMyAtLS0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3
ZC1jbG9jay55YW1sICAgICB8IDY0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKSAgZGVsZXRl
IG1vZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L2lteDdkLWNsb2NrLnR4dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14N2QtY2xvY2sueWFtbA0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg3
ZC1jbG9jay50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9j
ay9pbXg3ZC1jbG9jay50eHQNCj4gPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCA5ZDMwMjZkLi4wMDAwMDAwDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Nsb2NrL2lteDdkLWNsb2NrLnR4dA0KPiA+ICsrKyAvZGV2L251bGwNCj4gPiBAQCAt
MSwxMyArMCwwIEBADQo+ID4gLSogQ2xvY2sgYmluZGluZ3MgZm9yIEZyZWVzY2FsZSBpLk1YNyBE
dWFsDQo+ID4gLQ0KPiA+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+IC0tIGNvbXBhdGlibGU6
IFNob3VsZCBiZSAiZnNsLGlteDdkLWNjbSINCj4gPiAtLSByZWc6IEFkZHJlc3MgYW5kIGxlbmd0
aCBvZiB0aGUgcmVnaXN0ZXIgc2V0DQo+ID4gLS0gI2Nsb2NrLWNlbGxzOiBTaG91bGQgYmUgPDE+
DQo+ID4gLS0gY2xvY2tzOiBsaXN0IG9mIGNsb2NrIHNwZWNpZmllcnMsIG11c3QgY29udGFpbiBh
biBlbnRyeSBmb3IgZWFjaA0KPiA+IHJlcXVpcmVkDQo+ID4gLSAgZW50cnkgaW4gY2xvY2stbmFt
ZXMNCj4gPiAtLSBjbG9jay1uYW1lczogc2hvdWxkIGluY2x1ZGUgZW50cmllcyAiY2tpbCIsICJv
c2MiDQo+ID4gLQ0KPiA+IC1UaGUgY2xvY2sgY29uc3VtZXIgc2hvdWxkIHNwZWNpZnkgdGhlIGRl
c2lyZWQgY2xvY2sgYnkgaGF2aW5nIHRoZQ0KPiA+IGNsb2NrIC1JRCBpbiBpdHMgImNsb2NrcyIg
cGhhbmRsZSBjZWxsLiAgU2VlDQo+ID4gaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg3ZC1j
bG9jay5oDQo+ID4gLWZvciB0aGUgZnVsbCBsaXN0IG9mIGkuTVg3IER1YWwgY2xvY2sgSURzLg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2sv
aW14N2QtY2xvY2sueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Nsb2NrL2lteDdkLWNsb2NrLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAuLjhjZDA1NzMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2lteDdkLWNsb2NrLnlhbWwNCj4gPiBA
QCAtMCwwICsxLDY0IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
LW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKw0KPiA+ICt0
aXRsZTogQ2xvY2sgYmluZGluZ3MgZm9yIEZyZWVzY2FsZSBpLk1YNyBEdWFsDQo+ID4gKw0KPiA+
ICttYWludGFpbmVyczoNCj4gPiArICAtIEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+
ICsgIC0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gKw0KPiA+ICtkZXNj
cmlwdGlvbjogfA0KPiA+ICsgIFRoZSBjbG9jayBjb25zdW1lciBzaG91bGQgc3BlY2lmeSB0aGUg
ZGVzaXJlZCBjbG9jayBieSBoYXZpbmcgdGhlDQo+ID4gK2Nsb2NrDQo+ID4gKyAgSUQgaW4gaXRz
ICJjbG9ja3MiIHBoYW5kbGUgY2VsbC4gU2VlDQo+ID4gK2luY2x1ZGUvZHQtYmluZGluZ3MvY2xv
Y2svaW14N2QtY2xvY2suaA0KPiA+ICsgIGZvciB0aGUgZnVsbCBsaXN0IG9mIGkuTVg3IER1YWwg
Y2xvY2sgSURzLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgY29uc3Q6IGZzbCxpbXg3ZC1jY20NCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDQ00gaW50ZXJydXB0IHJlcXVlc3QgMQ0KPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDQ00gaW50ZXJydXB0IHJlcXVlc3QgMg0KPiANCj4gRG8g
d2UgaGF2ZSBhIG1vcmUgc3BlY2lmaWMgZGVzY3JpcHRpb24gZnJvbSBSTT8NCj4gT3RoZXJ3aXNl
LCBJJ20gZmluZSB3aXRoIHRoaXMgcGF0Y2guDQoNCkkgY2hlY2tlZCBib3RoIFJNIGFuZCBkZXNp
Z24gZG9jIGJlZm9yZSwgY2FuIE5PVCBmaW5kIGFueSBkZXNjcmlwdGlvbiBhYm91dA0KdGhlc2Ug
MiBpbnRlcnJ1cHRzLCBzbyBJIGRpZCBOT1QgYWRkIGRldGFpbCBkZXNjcmlwdGlvbnMgZm9yIHRo
ZW0uDQoNCkFuc29uDQo=

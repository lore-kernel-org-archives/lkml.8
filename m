Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66826C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C876205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="TIo6NaLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgGOKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:23:51 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:27329
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728132AbgGOKXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:23:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh+OnCKXlojKRuydC92DXV0ZAPsuGLgG4FD/ldfaTSi8YMC0RtWTyiMceME5l05EVvDpcp+tMWSVNcQ2987ClufccQDbUQAaQhVJV8oYN3Z3rriQbz1Z92Y6CQE27Tvr5tQCaup4DqI4QC80eapCxVlWFs07QkFnkcThwU9k5SKD0+a/oUqfMd7YwoCjvB02sZyFOIVnxTZYD7F7NpboLpwpJHBvonRZXjrOb4yWHYPBrXkkqyokMCFbYzI7M9sC75fmBPbvUx19bLL1Ep9znRYFpAlXlxw6gg0AkALAoG5dWlDewsjygnIPQr7lXR4sE2zqbFEyC7i/gyVvxPqOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfNsCcycx6W0X5eCr6pm+4h6ep2HJ2ebNkTLYTRaZqs=;
 b=DYG2mLobBEACFuSuuoatX8ZaFEKObjT1OjDHEY3f/55HS3AFeOtCPzQ9CjGPeWnuupEnxjzfTJbfO2683e89pMgFqutPZVqSV9z+SjHYyVsGeJ2OnrhPzM9RKT9dSU4D+xooY+LZ12kvleaUf0/vUY2yr2ZtwBcZt7zT8Bbf3YANB3QgnUiuyDshVf8JQ+S5Qgf/xBjDHHJEN6u+DybGrJtH2b7XuYL+PxTpZUjr7WpHRNaTvBOZM+kpOw5z8ik2YvDNk0ko5J17Pxjieq1yu3bkIXbIeQBbzuQ1U3suHZsSh8ctMAu+keXO9hMZ38x9Rt3JBpxIYCoM29bNAIz19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfNsCcycx6W0X5eCr6pm+4h6ep2HJ2ebNkTLYTRaZqs=;
 b=TIo6NaLVDehlIn8PmLWVwsYIqMXpbz3gkAGUlTWeI1yicBdMqxOReY62NsKb3oAmZorEAPBfNhJAbEIibTQ1yhoLZ+bEPqRSbPdZEWrKk02cXItfggkloKPBESy/3xMFGbUYMGc1AyCGtjEF6kkurV3C7dl4XFThAUVCSc7O6JM=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB5799.eurprd05.prod.outlook.com (2603:10a6:20b:93::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 10:23:45 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.018; Wed, 15 Jul 2020
 10:23:45 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIMLexdmM4+M0C6zPGY8HP2U6kH0FqAgACfygA=
Date:   Wed, 15 Jul 2020 10:23:45 +0000
Message-ID: <08251297f72fe745be43205d0a73631f009681cc.camel@toradex.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
         <20200714151822.250783-2-philippe.schenker@toradex.com>
         <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c899d077-cda1-471a-057f-08d828a927c6
x-ms-traffictypediagnostic: AM6PR05MB5799:
x-microsoft-antispam-prvs: <AM6PR05MB579905F7C31B2B1B0B446F14F47E0@AM6PR05MB5799.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LFzGRkqCDUgqS6tadD+6DaeocC2hjDn3iiCeJcMIdqxYFPjGm6qOdbijCMeJJcRX+Xo2Z9Sph/Kg6P2qyW6iVktxbVcgxu2XMPbaFZzMMSf5agJd1Z9PjICxKuP1IE/jhQGamgPZpvg/7R5ugRXYO2wybqVT43tQavNSqBzvHjvDw6gV+1QP8cSZH5EIPxximMSqEIA0imQdCt4IRX9CC8HKuvLSgW2D+6Nz4jesmFmgtLkQuThePoCFKENDkw0LgMxwW15BdRyscOe6UZ0KnLNcfEasivBvlwPD6Kx0E4423e3JgkawpLhZCNG5NkvaovZp0WBcEJLaxsMwbMJV9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(36756003)(6486002)(110136005)(54906003)(5660300002)(8936002)(6506007)(44832011)(316002)(7416002)(86362001)(2906002)(66946007)(4326008)(66476007)(64756008)(66446008)(2616005)(91956017)(478600001)(8676002)(83380400001)(186003)(6512007)(26005)(76116006)(66556008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LqPrDxD3LFgSg7OFXm23NnnezDo6jW4uQrGv9DrKmo6wv1b9JD3+3CNYWCKQ5om45GFdWiRHs1dNZqurhsJ1ebfNksKH4YlxFUK619LuE6obr5NaspinRaHy13p5NqRUjCtfCZZqjiONXbrcRnqPToTiWrhyZ4A4Ax9wHIwh6ZEkT3HTGbRCm3h2tPCEsONFFlS8/j6peJWx4qHXyUbLFGKODB8r+7zAcUCjdNtZ9jroWbfFeCBH4Hkns+jMkza/iS96Xu3dptPB7NICuEAXDDWbmvrEKMoNR1oBlgWSj/OF5X4z6QrS2CpVb3kFSCevkZL0J5e7d+MRluvubEbBE/0RpbXpS98BCRfNdE0H85ghHHvL5c4tzoIwxYdREmKO1EdE0MSYebB8oDby68JiS0TsZzP3/F8oS1ALKIKBo2svhPAT3Hf51XK08AZKlCmbF6doaA8fCgLDBaGIi/M8fIU5ui+pzB0l4R8IaCfFX40=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E76D1AC8E0C2194098F356273D293434@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c899d077-cda1-471a-057f-08d828a927c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 10:23:45.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDsL+PVHs/D/yvIXmQ51JDdhNU0mxhAA+UoiYpf/5IzxXNNGezwB+mp1snYKgQ1U8wKnNFYzks/8272Oj/Afwrj+8qsFdqBa32L/bDgW+oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTE1IGF0IDAwOjUxICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiAg
DQo+ID4gVGhlIFRvcmFkZXggQ29saWJyaSBpTVg2VUxMIGJvYXJkIGhhcyBhIHNwZWNpYWwgVVNC
IGhhcmR3YXJlIGRlc2lnbi4NCj4gPiBXaXRoIHJ1bnRpbWUtcG0gZW5hYmxlZCBVU0IgcmVzZXQg
aXRzZWxmIGNvbnRpbnVvdXNseS4gRnVydGhlcm1vcmUNCj4gPiB0aGUgT1RHIHBvcnQNCj4gPiBp
cyBhbHNvIG5vdCBlbnVtZXJhdGluZyBkZXZpY2VzIGlmIHRoZSBDaGlwaWRlYSBJUCBpcyBpbiBy
dW50aW1lDQo+ID4gc2xlZXAgbW9kZSBhbmQgYQ0KPiA+IGRldmljZSBvciBob3N0IGdldHMgcGx1
Z2dlZCBpbi4NCj4gPiANCj4gDQo+IEhpIFBoaWxpcHBlLA0KPiANCj4gWW91IG1heSBkZXNjcmli
ZSB0aGUgZGV0YWlsIHdoYXQncyB0aGUgc3BlY2lhbCBVU0IgaGFyZHdhcmUgZGVzaWduIGZvcg0K
PiB5b3VyIGJvYXJkLA0KDQpJZiBJIG9ubHkga25ldyB0aGUgcm9vdC1jYXVzZSBvZiB0aGF0IHBy
b2JsZW0gLSB1bmZvcnR1bmF0ZWx5IEkgZG9uJ3QuDQpUaGF0J3MgYWxzbyB3aHkgSSBoYXZlIHN1
Y2ggYSBoYXJkIHRpbWUgdG8gZGVzY3JpYmUgaXQuDQoNCj4gYW5kIHdoeSBpdCBjYXVzZXMgdGhl
IHByb2JsZW0sIGFuZCB3aHkgZGlzYWJsZSBydW50aW1lIHBtIGNvdWxkIGZpeA0KPiB0aGlzIGlz
c3VlLCB0aGVuLA0KDQpJIGNhbm5vdCBwcm92aWRlIHRoZSAnd2h5JyBwYXJ0IHlldC4gSSdsbCB0
cnkgc29tZXRoaW5nIG1vcmUgYW5kIGhvcGUgSQ0KY2FuIHByb3ZpZGUgeW91IGd1eXMgd2l0aCB0
aGUgZXhhY3QgZGVzY3JpcHRpb24uDQoNCj4gdGhlIG90aGVyIHVzZXJzIGNvdWxkIGtub3cgaWYg
aXQgY291bGQgYXBwbHkgdG8gdGhlaXIgcGxhdGZvcm1zIG9yIG5vdA0KPiBpbiBmdXR1cmUuDQoN
Ckkgb25seSBmb3VuZCBvdXQgYWJvdXQgaXQgYmVjYXVzZSB5b3Ugd2VyZSBwb2ludGluZyBtZSBp
biB0aGF0DQpkaXJlY3Rpb24uIEkgZGVidWdnZWQgZm9yIGhvdXJzIG5vdyBhbmQgZGlkbid0IGNh
bWUgdG8gdGhlIHJvb3QtY2F1c2Ugb2YNCnRoZSBpc3N1ZS4gSSB0aGluayB0byByZWFsbHkgdW5k
ZXJzdGFuZCBpdCBJIHdvdWxkIG5lZWQgdG8ga25vdyBtdWNoDQptb3JlIGFib3V0IHRoZSBDaGlw
aWRlYSBJUC4NCg0KSSdsbCBnZXQgYmFjayB0byB5b3UgZ3V5cyB3aXRoIGEgcHJvcG9zYWwgZm9y
IGEgbmV3IGRlc2NyaXB0aW9uLg0KDQpQaGlsaXBwZQ0KDQo+IA0KPiBQZXRlcg0KPiANCj4gPiBU
aGlzIHBhdGNoIGFkZHMgdGhlIG9wcG9ydHVuaXR5IHRvIGRpc2FibGUgUnVudGltZSBQb3dlciBN
YW5hZ2VtZW50DQo+ID4gZnJvbQ0KPiA+IGRldmljZXRyZWUNCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+
ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAtIENoYW5nZSBjb21t
aXQgbWVzc2FnZSB0byB0ZWxsIHRoZSB1c2UgY2FzZSBmb3IgQ29saWJyaSBpTVg2VUxMDQo+ID4g
DQo+ID4gIGRyaXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14LmMgfCAzICsrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2NoaXBpZGVhL2NpX2hkcmNfaW14LmMNCj4gPiBiL2RyaXZlcnMvdXNiL2NoaXBp
ZGVhL2NpX2hkcmNfaW14LmMNCj4gPiBpbmRleCA1YWUxNjM2OGEwYzcuLjUwNzhkMDY5NWViNyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jaV9oZHJjX2lteC5jDQo+ID4g
KysrIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY2lfaGRyY19pbXguYw0KPiA+IEBAIC00MzQsNiAr
NDM0LDkgQEAgc3RhdGljIGludCBjaV9oZHJjX2lteF9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJdXNiX3BoeV9pbml0KHBkYXRhLnVzYl9waHkpOw0KPiA+
ICAJfQ0KPiA+IA0KPiA+ICsJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImRpc2FibGUt
cnVudGltZS1wbSIpKQ0KPiA+ICsJCXBkYXRhLmZsYWdzICY9IH5DSV9IRFJDX1NVUFBPUlRTX1JV
TlRJTUVfUE07DQo+ID4gKw0KPiA+ICAJaWYgKHBkYXRhLmZsYWdzICYgQ0lfSERSQ19TVVBQT1JU
U19SVU5USU1FX1BNKQ0KPiA+ICAJCWRhdGEtPnN1cHBvcnRzX3J1bnRpbWVfcG0gPSB0cnVlOw0K
PiA+IA0KPiA+IC0tDQo+ID4gMi4yNy4wDQo=

Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F07207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eIjHCrCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgE1CBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:01:43 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:64434
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726451AbgE1CBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:01:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEsU3CDVfHsHfM/fjCHrfLKEOua+8A9IhFNJPoLjBkb2sDOGpb42R60Xk74iBM/DB7VBfHc2tGKJsinsjIoQboC/IeQsT5RAkZAVBCI+gWT6YDwy4m9Ud5L4KLZxC5ldxL97MqyR6+XAbzV9R25hzklvZwXxDl7P5uIYtiAj1samMLd3xJbXOMwNlBts+Nl9U7cd6mlxRqpv/920CfvK9wuk6tRB8OrCm5Mu8JA6ejPnHqzMU93znYi9SKC/IwvODt0gXTGVdX4Nql85ZR4L01kCaBO2gIWWArH01a5R6o/e4ocG/6C1Z/Sm9OBP3gIdH71rr3m+jMi0UW3mrMkjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thoDXsXrKALIEn5T5mZHBEgfmWUC3RVaqx3h11VH+/U=;
 b=KtqHzD4LUkPJ79bJ8mxInYLD0e6PXz8zWbAKkJJPCHJ11uaI9BDLExq4GqCLhCewpuiaBwKBy3I12kNvTaFfgdry4qOyiqgbV8MsK8WogbP+55KV41+AxotAy2V3EwfD4AvgT4rLpKvunM7O8Uo8sUJdyEkqS+YrBb27GDK9cW82Vp22Ld/tOCpyOhVlSj8YGlJ+9w29uZXvSbU53k3C1PJQ7e6YT/cdn9c3PgLVX1Yl0ovHHTgomqk2tu/vOHAyJ5JcUC4egYVnUGKjHEU4pCiAoReDXwFFbU/rZhg3Q2KdqsQZd1CtmU3efLOSPyUr71SecjhKX7UOXAICTNNBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thoDXsXrKALIEn5T5mZHBEgfmWUC3RVaqx3h11VH+/U=;
 b=eIjHCrCNR+x8A6LJe5JkeO1sf/cNw8dBCIGr56m7Zwg+ySkEqeogvibhlXL3l9E39DnjtpWeCwwr/2ZLrkvs2Uu7Aw+V+ZFGtkLpq/by5niKZdNvr1ij0//Ev/M0BMIfjtohYimaZC3Ioyt8q34264nA+pClG9KDt5sH6swTJ9k=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3900.eurprd04.prod.outlook.com (2603:10a6:8:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 02:01:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 02:01:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: Support runtime PM
Thread-Topic: [PATCH] mailbox: imx: Support runtime PM
Thread-Index: AQHWEY+/xCVMpCFwWEOKIpvxyYiJiah3AcmAgAAEhbCARf4/QA==
Date:   Thu, 28 May 2020 02:01:38 +0000
Message-ID: <DB3PR0402MB39160D61A38D56E7F416CCFDF58E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1586780730-6117-1-git-send-email-Anson.Huang@nxp.com>
 <eb0eae78-35e9-1496-0869-94b48270f544@pengutronix.de>
 <DB3PR0402MB3916D05B44D776E5242434B1F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916D05B44D776E5242434B1F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3c1d09c-5de3-45b6-c6e8-08d802ab0ebc
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB39009BFABFE6C16F31D64898F58E0@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qXIsbQVzB65BPho2EW5WZMs13jAwAnhxdiRd0LY9F/cEB9zDJ9XTcBTBQXDiWsvZHWG/oSQ1Dm67+HTltc3o4Cx6tV8qNR5J51feUCPdhC8wZP8rz5ig9hQM6KIoehuwpuYLTLXG+mFENR+cNqhyrVEaUt+2/Sar2hntWTdzRbCkFe8pME7rkuXhOtQMJiSGjMdxY7Q5LDY7tYojsVCYztvdO9It1du2c2tCHNuKaHDC/W+nBR8U6LEgjzoioHTipxo2nFUglc69vzWyevqC6ONukrgm9uM9pMvNXQY3JX1oVwoFYt6bNBA0uin+l/iKfPie6JRNIuXs5yrheK4lWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(83380400001)(71200400001)(110136005)(15650500001)(478600001)(66556008)(66476007)(44832011)(66446008)(76116006)(52536014)(64756008)(66946007)(5660300002)(6506007)(8676002)(53546011)(186003)(26005)(7696005)(33656002)(4326008)(55016002)(2906002)(86362001)(8936002)(9686003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zo+RXDZ6GG69izufcnivuJcwhvpiX3JCOjzA0et0PziF68CUYe37BconhJSUjCHjZLtCQxeRgoQgUL5zMX3PZKgOa9tV1UfQVBEa7Zb0jaCQOvkSNAfb2Sf5QnVzZkUPQNWooGpIYzgyZf+Qu2blDthJ+9b89cq0Vglrsyr4XD43PvCZ+W6oqDhu2CQVb5Pn8riVPcKuMAJfAfpEbvmOfHvGVCPKrm9Rf+rzUPGRAVau4/qPYd7lCweVx4wqwfSsfE+FBZlMZHkeySywpIZR4wABptoJp9wWM1oI7T3YMbDB7pb48NVM0hFLC3Z94WAJuFZ6y3N36RLtLdIcFYGtBbIBrKoawf5gU8rvOQxHK+vuHSGsQ7e0WoTH9yaQfXgDfswEA0F6V3Yh/AYvGDu1fom3wp1rVN9JD1xMAM5RxxLQoHtKv3W2drKw5K/Oai6Yn0AZ7SatT2XPC8ldXLU6R+EM+U9VjdhoKWL35+gXd1bf3toWULMFOwi7Ia57VBJR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c1d09c-5de3-45b6-c6e8-08d802ab0ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 02:01:38.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd1aSv28sktC6ce5ze0eoBmPnRe4wboihCKAk7tzV3fCikUiuPScoSkhidl95BCpFrULNs3ccHQov1jVf+C6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIG1haWxib3g6IGlteDog
U3VwcG9ydCBydW50aW1lIFBNDQo+IA0KPiBIaSwgTWFyYw0KPiANCj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBtYWlsYm94OiBpbXg6IFN1cHBvcnQgcnVudGltZSBQTQ0KPiA+DQo+ID4gT24gNC8x
My8yMCAyOjI1IFBNLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+IFNvbWUgcG93ZXIgaHVuZ3J5
IHN1Yi1zeXN0ZW1zIGxpa2UgVlBVIGhhcyBpdHMgb3duIE1VcyB3aGljaCBhbHNvDQo+ID4gPiB1
c2UgbWFpbGJveCBkcml2ZXIsIGN1cnJlbnQgbWFpbGJveCBkcml2ZXIgdXNlcyBwbGF0Zm9ybSBk
cml2ZXINCj4gPiA+IG1vZGVsIGFuZCBNVSdzIHBvd2VyIHdpbGwgYmUgT04gYWZ0ZXIgZHJpdmVy
IHByb2JlZCBhbmQgbGVmdCBPTg0KPiA+ID4gdGhlcmUsIGl0IG1heSBjYXVzZSB0aGUgd2hvbGUg
c3ViLXN5c3RlbSBjYW4gTk9UIGVudGVyIGxvd2VyIHBvd2VyDQo+ID4gPiBtb2RlLCB0YWtlIFZQ
VSBkcml2ZXIgZm9yIGV4YW1wbGUsIGl0IGhhcyBydW50aW1lIFBNIHN1cHBvcnQsIGJ1dA0KPiA+
ID4gZHVlIHRvIGl0cyBNVSBhbHdheXMgT04sIHRoZSBWUFUgc3ViLXN5c3RlbSB3aWxsIGJlIGFs
d2F5cyBPTiBhbmQNCj4gPiA+IGNvbnN1bWUgbWFueSBwb3dlciBkdXJpbmcga2VybmVsIGlkbGUu
DQo+ID4gPg0KPiA+ID4gVG8gc2F2ZSBwb3dlciBpbiBrZXJuZWwgaWRsZSwgbWFpbGJveCBkcml2
ZXIgbmVlZHMgdG8gc3VwcG9ydA0KPiA+ID4gcnVudGltZSBQTSBpbiBvcmRlciB0byBwb3dlciBv
ZmYgTVUgd2hlbiBpdCBpcyB1bnVzZWQuIEhvd2V2ZXIsIHRoZQ0KPiA+ID4gcnVudGltZSBzdXNw
ZW5kL3Jlc3VtZSBjYW4gT05MWSBiZSBpbXBsZW1lbnRlZCBpbiBtYWlsYm94J3MNCj4gPiA+IC5z
aHV0ZG93bi8uc3RhcnR1cCBjYWxsYmFjaywgc28gaXRzIGNvbnN1bWVyIG5lZWRzIHRvIGNhbGwN
Cj4gPiA+IG1ib3hfcmVxdWVzdF9jaGFubmVsKCkvbWJveF9mcmVlX2NoYW5uZWwoKSBpbiBjb25z
dW1lciBkcml2ZXIncw0KPiA+ID4gcnVudGltZSBQTSBjYWxsYmFjaywgdGhlbiB0aGUgTVUncyBw
b3dlciB3aWxsIGJlIE9OL09GRiBhbG9uZyB3aXRoDQo+ID4gPiBjb25zdW1lcidzIHJ1bnRpbWUg
UE0gc3RhdHVzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9tYWlsYm94L2lteC1t
YWlsYm94LmMgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiA+ID4gYi9kcml2ZXJz
L21haWxib3gvaW14LW1haWxib3guYyBpbmRleCA3OTA2NjI0Li45N2JmMGFjIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4gPiBAQCAtMTIsNiArMTIsNyBAQA0KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaD4gICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4NCj4gPiA+ICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiA+ICsjaW5j
bHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
DQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgSU1YX01VX3hTUl9HSVBuKHgpCUJJVCgyOCArICgzIC0g
KHgpKSkNCj4gPiA+IEBAIC0yODcsNiArMjg4LDcgQEAgc3RhdGljIGludCBpbXhfbXVfc3RhcnR1
cChzdHJ1Y3QgbWJveF9jaGFuDQo+ICpjaGFuKQ0KPiA+ID4gIAlzdHJ1Y3QgaW14X211X2Nvbl9w
cml2ICpjcCA9IGNoYW4tPmNvbl9wcml2Ow0KPiA+ID4gIAlpbnQgcmV0Ow0KPiA+ID4NCj4gPiA+
ICsJcG1fcnVudGltZV9nZXRfc3luYyhwcml2LT5kZXYpOw0KPiA+ID4gIAlpZiAoY3AtPnR5cGUg
PT0gSU1YX01VX1RZUEVfVFhEQikgew0KPiA+ID4gIAkJLyogVHggZG9vcmJlbGwgZG9uJ3QgaGF2
ZSBBQ0sgc3VwcG9ydCAqLw0KPiA+ID4gIAkJdGFza2xldF9pbml0KCZjcC0+dHhkYl90YXNrbGV0
LCBpbXhfbXVfdHhkYl90YXNrbGV0LCBAQA0KPiAtMzIzLDYNCj4gPiA+ICszMjUsNyBAQCBzdGF0
aWMgdm9pZCBpbXhfbXVfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gPiA+DQo+
ID4gPiAgCWlmIChjcC0+dHlwZSA9PSBJTVhfTVVfVFlQRV9UWERCKSB7DQo+ID4gPiAgCQl0YXNr
bGV0X2tpbGwoJmNwLT50eGRiX3Rhc2tsZXQpOw0KPiA+ID4gKwkJcG1fcnVudGltZV9wdXRfc3lu
Yyhwcml2LT5kZXYpOw0KPiA+ID4gIAkJcmV0dXJuOw0KPiA+ID4gIAl9DQo+ID4gPg0KPiA+ID4g
QEAgLTM0MSw2ICszNDQsNyBAQCBzdGF0aWMgdm9pZCBpbXhfbXVfc2h1dGRvd24oc3RydWN0IG1i
b3hfY2hhbg0KPiA+ICpjaGFuKQ0KPiA+ID4gIAl9DQo+ID4gPg0KPiA+ID4gIAlmcmVlX2lycShw
cml2LT5pcnEsIGNoYW4pOw0KPiA+ID4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKHByaXYtPmRldik7
DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1ib3hfY2hhbl9v
cHMgaW14X211X29wcyA9IHsgQEAgLTUwOCw3ICs1MTIsMjcNCj4gPiBAQA0KPiA+ID4gc3RhdGlj
IGludCBpbXhfbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+DQo+
ID4gPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHByaXYpOw0KPiA+ID4NCj4gPiA+IC0J
cmV0dXJuIGRldm1fbWJveF9jb250cm9sbGVyX3JlZ2lzdGVyKGRldiwgJnByaXYtPm1ib3gpOw0K
PiA+ID4gKwlyZXQgPSBkZXZtX21ib3hfY29udHJvbGxlcl9yZWdpc3RlcihkZXYsICZwcml2LT5t
Ym94KTsNCj4gPiA+ICsJaWYgKHJldCkNCj4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiArDQo+
ID4gPiArCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gPiArDQo+ID4NCj4gPiBGaXJzdCBy
ZWdpc3RlcmluZyBhdCB0aGUgc3lzdGVtIGFuZCB0aGVuIHNldHRpbmcgdXAgdGhlIHBvd2VyDQo+
ID4gbWFuYWdlbWVudCBsb29rcyByYWN5LiBEb24ndCBrbm93IGlmIHRoaXMgaXMgc2VyaWFsaXpl
ZCBieSBzb21lIG90aGVyDQo+IG1lYW5zLg0KPiANCj4gRG9uJ3QgaGF2ZSBvdGhlciBtZWFucywg
anVzdCByZWZlciB0bw0KPiBkcml2ZXJzL21haWxib3gvb21hcC1tYWlsYm94LmMsIGl0IGhhcyBz
YW1lIHNlcXVlbmNlLCBOT1Qgc3VyZSBpZiB0aGVyZSBpcw0KPiBzcGVjaWFsIHJlcXVpcmVtZW50
IGFib3V0IHRoaXMgc2VxdWVuY2UuDQo+IA0KPiBUaGFua3MsDQo+IEFuc29uDQo=

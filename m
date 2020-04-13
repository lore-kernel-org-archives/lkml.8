Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FDAC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3430F2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lygYX7S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgDMNNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:13:33 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:40668
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729765AbgDMNNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:13:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5ZNyWyYC3bVavvk0ht4exgWWU98Wqx7iZ27hREBJPsxnWtFTE74gcgGf2Z/cIwykLZ3O+fWbi8nNo48szyjTysuRXTYAvwSq5LLxw0dt0X4D/M/FTLmeJHzH2C14rbAe8zq1ZK7J+bDFW1LX6UXQrmtgcno92payNix5ngWZ1GPsSJS0S710NsjORw6cPYTwLyjQcbSeH0i+/UwmhglAJHqIWCiBtFJy3Pvybpva/8TMrsOw2QBCHkStfRNSQPe04CQpJQWeF4Wo8bhDEqMi6x9o16nAf0LtXICzT/UC79nd9E9uJecoLwf9ij857NM3C+HB5yJV8pIwIDF8DHTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAYt4QuHIGNrVJA5lk48MVy08csP6tNMhtTpvsA//io=;
 b=GnAIOiT/Mmv9DoTbrQH6adPHVlqucQK6aC9oLvAkm3i6OaWCwHQT6Sa9ObXewp6NK2+5YpnKKnbW4YQG4NOlzb7b0cG+5c3pW5G9SRcWhFYioxzA9u7bneiu8MfNmAWXAUkStejaxQ2OfIFHzvg1OhvYc7rGcWa2AGntg0BDJ8PAA2tC+8alEHOxck5azyFo8fE382OgSavG7S5HPK/XLoETmI8NHQ3pDHnM7U4Od+UblwSe5jAqnciLKZGuQM+7fjiDwpLQtVV7FX4M4CRoUdkbk1Px9kMlXvW9M9dvaorSN1DWVc5CKMOFtn2Qbe6TLe8ZO9wdaQxlFK9/L7CfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAYt4QuHIGNrVJA5lk48MVy08csP6tNMhtTpvsA//io=;
 b=lygYX7S7hvhJM2ZnkQsXLrEj3VYxSUDqIKI08wGLa3wHgjDX11n2hnvGYVeGnUoaJQ1JZj1gwoMKbbEUfp6JHzgSm+OJbC1uIy11NMgJO8U3kdZh89C1oVKwfPYNEveIadBz4uzudyAyjVUDegtrmEn4hkU5uW3uEsnN38L9hp0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3835.eurprd04.prod.outlook.com (2603:10a6:8:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 13:13:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 13:13:28 +0000
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
Thread-Index: AQHWEY+/xCVMpCFwWEOKIpvxyYiJiah3AcmAgAAEhbA=
Date:   Mon, 13 Apr 2020 13:13:28 +0000
Message-ID: <DB3PR0402MB3916D05B44D776E5242434B1F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1586780730-6117-1-git-send-email-Anson.Huang@nxp.com>
 <eb0eae78-35e9-1496-0869-94b48270f544@pengutronix.de>
In-Reply-To: <eb0eae78-35e9-1496-0869-94b48270f544@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da4fc591-4a88-443a-4457-08d7dfac74e6
x-ms-traffictypediagnostic: DB3PR0402MB3835:|DB3PR0402MB3835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3835EA9BA1A98A68EED34BD5F5DD0@DB3PR0402MB3835.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(81156014)(66946007)(76116006)(6506007)(55016002)(64756008)(316002)(2906002)(44832011)(52536014)(9686003)(8676002)(7696005)(66476007)(66556008)(71200400001)(478600001)(33656002)(86362001)(66446008)(4326008)(26005)(53546011)(5660300002)(15650500001)(110136005)(186003)(8936002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6L/M8ZYaBwjQI7aTzn+6y0Us3AX7TYqI1mIgi3YWuQ/zGlfTOvS5hduB5KcAq0x6lX8PAo2RBmr2HavYsZSeo9oMySNUJmSTRhMdZ1gCrtjAvXQ/oqIWlN2mN0m3aUH1X5gUwvjXhABfXiQo+IvvXQR0RxYwsCrJfWYBoAIkcNr5FH1fOaJ7L+ntsEthST+eX8EzB10PHcOTo9ShKARdMsDhG9/BiliiTmd9ZZ3DUChYQp/H1apZmfJN7G9ZTLBrXyKTJsMEa5Zp756Fk2NRUmM15MkdHnWEr22CLv1CNRxJbgVBonraIjTvx37Q4auW4I0+6IUPAazmv25C1AAXXniV28Jj+OGAaskihRWofks4wnowETLXIo31rz7LaKX+X9aZkMjerbpRc2gT+VB0RlIRku5nNaDv2OAkNlFQESOki0Rrd+YIt8xVpN+9qOQA
x-ms-exchange-antispam-messagedata: zFmZrbqAoRq8BMqZ/K6SHCLSHMXjFdyKhGPwtXduLHeYQX5w+EP49o2rbIDAz2f+MOSE+Ta7cJQ58B4CpXQ4PiFfEjobcAoCcmHS6iq+YAyhaTD9FQKBKSSQpSvqCcHCUesBIHhSclC016MgSrOETw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4fc591-4a88-443a-4457-08d7dfac74e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 13:13:28.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0rtf/QQ5XbzxgJibuzqZZ2ihYqv2UgAIgY4XB+3p127ns/W2InmKduNbnz5jJoNK6/sTaIYs/nw/vDzl/BY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmMNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtYWlsYm94OiBpbXg6IFN1cHBvcnQg
cnVudGltZSBQTQ0KPiANCj4gT24gNC8xMy8yMCAyOjI1IFBNLCBBbnNvbiBIdWFuZyB3cm90ZToN
Cj4gPiBTb21lIHBvd2VyIGh1bmdyeSBzdWItc3lzdGVtcyBsaWtlIFZQVSBoYXMgaXRzIG93biBN
VXMgd2hpY2ggYWxzbyB1c2UNCj4gPiBtYWlsYm94IGRyaXZlciwgY3VycmVudCBtYWlsYm94IGRy
aXZlciB1c2VzIHBsYXRmb3JtIGRyaXZlciBtb2RlbCBhbmQNCj4gPiBNVSdzIHBvd2VyIHdpbGwg
YmUgT04gYWZ0ZXIgZHJpdmVyIHByb2JlZCBhbmQgbGVmdCBPTiB0aGVyZSwgaXQgbWF5DQo+ID4g
Y2F1c2UgdGhlIHdob2xlIHN1Yi1zeXN0ZW0gY2FuIE5PVCBlbnRlciBsb3dlciBwb3dlciBtb2Rl
LCB0YWtlIFZQVQ0KPiA+IGRyaXZlciBmb3IgZXhhbXBsZSwgaXQgaGFzIHJ1bnRpbWUgUE0gc3Vw
cG9ydCwgYnV0IGR1ZSB0byBpdHMgTVUNCj4gPiBhbHdheXMgT04sIHRoZSBWUFUgc3ViLXN5c3Rl
bSB3aWxsIGJlIGFsd2F5cyBPTiBhbmQgY29uc3VtZSBtYW55IHBvd2VyDQo+ID4gZHVyaW5nIGtl
cm5lbCBpZGxlLg0KPiA+DQo+ID4gVG8gc2F2ZSBwb3dlciBpbiBrZXJuZWwgaWRsZSwgbWFpbGJv
eCBkcml2ZXIgbmVlZHMgdG8gc3VwcG9ydCBydW50aW1lDQo+ID4gUE0gaW4gb3JkZXIgdG8gcG93
ZXIgb2ZmIE1VIHdoZW4gaXQgaXMgdW51c2VkLiBIb3dldmVyLCB0aGUgcnVudGltZQ0KPiA+IHN1
c3BlbmQvcmVzdW1lIGNhbiBPTkxZIGJlIGltcGxlbWVudGVkIGluIG1haWxib3gncyAuc2h1dGRv
d24vLnN0YXJ0dXANCj4gPiBjYWxsYmFjaywgc28gaXRzIGNvbnN1bWVyIG5lZWRzIHRvIGNhbGwN
Cj4gPiBtYm94X3JlcXVlc3RfY2hhbm5lbCgpL21ib3hfZnJlZV9jaGFubmVsKCkgaW4gY29uc3Vt
ZXIgZHJpdmVyJ3MNCj4gPiBydW50aW1lIFBNIGNhbGxiYWNrLCB0aGVuIHRoZSBNVSdzIHBvd2Vy
IHdpbGwgYmUgT04vT0ZGIGFsb25nIHdpdGgNCj4gPiBjb25zdW1lcidzIHJ1bnRpbWUgUE0gc3Rh
dHVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIHwgMjcg
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
YWlsYm94L2lteC1tYWlsYm94LmMNCj4gPiBiL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5j
IGluZGV4IDc5MDY2MjQuLjk3YmYwYWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94
L2lteC1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0K
PiA+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tYWlsYm94X2NvbnRy
b2xsZXIuaD4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAjaW5jbHVkZSA8bGludXgv
b2ZfZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4NCj4gPiAgI2RlZmluZSBJTVhfTVVfeFNSX0dJUG4o
eCkJQklUKDI4ICsgKDMgLSAoeCkpKQ0KPiA+IEBAIC0yODcsNiArMjg4LDcgQEAgc3RhdGljIGlu
dCBpbXhfbXVfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+ICAJc3RydWN0IGlt
eF9tdV9jb25fcHJpdiAqY3AgPSBjaGFuLT5jb25fcHJpdjsNCj4gPiAgCWludCByZXQ7DQo+ID4N
Cj4gPiArCXBtX3J1bnRpbWVfZ2V0X3N5bmMocHJpdi0+ZGV2KTsNCj4gPiAgCWlmIChjcC0+dHlw
ZSA9PSBJTVhfTVVfVFlQRV9UWERCKSB7DQo+ID4gIAkJLyogVHggZG9vcmJlbGwgZG9uJ3QgaGF2
ZSBBQ0sgc3VwcG9ydCAqLw0KPiA+ICAJCXRhc2tsZXRfaW5pdCgmY3AtPnR4ZGJfdGFza2xldCwg
aW14X211X3R4ZGJfdGFza2xldCwgQEAgLTMyMyw2DQo+ID4gKzMyNSw3IEBAIHN0YXRpYyB2b2lk
IGlteF9tdV9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+DQo+ID4gIAlpZiAo
Y3AtPnR5cGUgPT0gSU1YX01VX1RZUEVfVFhEQikgew0KPiA+ICAJCXRhc2tsZXRfa2lsbCgmY3At
PnR4ZGJfdGFza2xldCk7DQo+ID4gKwkJcG1fcnVudGltZV9wdXRfc3luYyhwcml2LT5kZXYpOw0K
PiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPg0KPiA+IEBAIC0zNDEsNiArMzQ0LDcgQEAgc3Rh
dGljIHZvaWQgaW14X211X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4NCj4gKmNoYW4pDQo+ID4g
IAl9DQo+ID4NCj4gPiAgCWZyZWVfaXJxKHByaXYtPmlycSwgY2hhbik7DQo+ID4gKwlwbV9ydW50
aW1lX3B1dF9zeW5jKHByaXYtPmRldik7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IG1ib3hfY2hhbl9vcHMgaW14X211X29wcyA9IHsgQEAgLTUwOCw3ICs1MTIsMjcNCj4g
QEANCj4gPiBzdGF0aWMgaW50IGlteF9tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+DQo+ID4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBwcml2KTsNCj4gPg0K
PiA+IC0JcmV0dXJuIGRldm1fbWJveF9jb250cm9sbGVyX3JlZ2lzdGVyKGRldiwgJnByaXYtPm1i
b3gpOw0KPiA+ICsJcmV0ID0gZGV2bV9tYm94X2NvbnRyb2xsZXJfcmVnaXN0ZXIoZGV2LCAmcHJp
di0+bWJveCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+
ICsJcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiArDQo+IA0KPiBGaXJzdCByZWdpc3Rlcmlu
ZyBhdCB0aGUgc3lzdGVtIGFuZCB0aGVuIHNldHRpbmcgdXAgdGhlIHBvd2VyIG1hbmFnZW1lbnQN
Cj4gbG9va3MgcmFjeS4gRG9uJ3Qga25vdyBpZiB0aGlzIGlzIHNlcmlhbGl6ZWQgYnkgc29tZSBv
dGhlciBtZWFucy4NCg0KRG9uJ3QgaGF2ZSBvdGhlciBtZWFucywganVzdCByZWZlciB0bw0KZHJp
dmVycy9tYWlsYm94L29tYXAtbWFpbGJveC5jLCBpdCBoYXMgc2FtZSBzZXF1ZW5jZSwgTk9UIHN1
cmUgaWYgdGhlcmUgaXMNCnNwZWNpYWwgcmVxdWlyZW1lbnQgYWJvdXQgdGhpcyBzZXF1ZW5jZS4N
Cg0KVGhhbmtzLA0KQW5zb24NCg==

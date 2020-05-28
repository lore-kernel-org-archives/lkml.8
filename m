Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C650C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37528207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJPN56P2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgE1Bz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:55:26 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:14606
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgE1BzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/olEDBitOBjAp5uBGWVWIcDif6Ti3072VIm/5wzYZXBVPSRnDXOzaDLiqvHSrO+haxcUj//YUJsTPDYyXeZE3pnK7QLQ8uPTuVSjO5gGuL8e7PTtrCncSpjp6YovbdGwtXxt6d5fzOyvtIG1LWKKQWG71YIjDexcg8j6szx21C3Rv2iwBG01CSgXvxEctYVMl+d7MdoM1k7CzlcpYgVJikFVp9tRgWVN60XjeCzi1etXyVUoGL2lOidMhkC65ScyOzfTDkZAg7n5j9HnK7FEliNEZKdSF+3KzLEIYj2j0ZEdd4F147aobnmVHrWvZW7iMGFhiwSkAR3c2uxQxNv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sOXvUs1LVqeFhqxoAH47DKdiuBNMOCtkCaTSJ+8W5g=;
 b=YUP2yElRYGgY2YhWmxnnNT7zhHbcxKaIYz02OoSJJPB0eProRrCOS9tsOl5SzvSIB9F7IhMgc70VrpiSzjlwYwvrxr2LS5r4ipVL74eM+mNC5wTCLorkF1uYMlGd21bxePcQAz3d0rb/Mp+CQ/RfVSLKlMfnGPYE849U8+RqGTqKsTsVjRqZo9jVN5q/dS9yYfYXxNap+c4X5Tl4LWWpmHp44qUGdpd/Fk27BFunoi8cb9zT3aEfzp2G2T9BCyNC9gI0RIUNNPdI0o9BuPC3jePu4mxS3fXL6Ph1JgqOkIGqxuDKBcEUbBazNKDPCFHMXty5QdoEVfK1omEMuE+zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sOXvUs1LVqeFhqxoAH47DKdiuBNMOCtkCaTSJ+8W5g=;
 b=RJPN56P2X8jY0rWkWzPlRWB7kHr04zsXekMC1ZWmI0JcsJ/uz9yGhN6Ai8Iir3/DFN/2Gfp0BBRN31VF+PmlrwDaMl3Ao2BvWhDE6guEEmCfbZRvR0g/EXWcT7Rx2ptGzbcu0/75pBEDFv9YxDgP8O6PzYV+HmorZrodX+dNiRc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3644.eurprd04.prod.outlook.com (2603:10a6:8:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 01:55:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 01:55:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: Add context save/restore for suspend/resume
Thread-Topic: [PATCH] mailbox: imx: Add context save/restore for
 suspend/resume
Thread-Index: AQHWGcRI3NaCUTtP70667RBGRFojq6iHjCeAgAAAeYCAAAouAIAAAIOwgDVbDzA=
Date:   Thu, 28 May 2020 01:55:21 +0000
Message-ID: <DB3PR0402MB3916BD0FCF482C124E21D3B1F58E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916D588A9432A9F1D1F99BAF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496671BFF3496FD1C4C51E7E80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39164CB0791AB259CE62EC4EF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164CB0791AB259CE62EC4EF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 092e8a2f-58f3-4bd8-b43c-08d802aa2e2c
x-ms-traffictypediagnostic: DB3PR0402MB3644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3644E2AC403D3620A7FA4DB0F58E0@DB3PR0402MB3644.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SY750VhbuIFCCso59v+fQHK35Wny8JDAT2701AtZ8FK0BfZmDTRP7iOUnkwhhQ1lqdBV5vU19tp2L1EvAS4y24gJeEfsLY7HzcF5GCcfG+xnNATwUthJeKzJoxuOqafSgqm/1Uh6cgIg4R8gucLATJXu7zNEMvh1y1rFQVqpvV5W0Xz5Vur2yjw981/VPUZeQGKtcGEs6TrfDMo1yl8xX9QCEpvPNXMjLFawWl45AlKYXfuOo7LxrL8HdBZy0WZuWiJaR4s1TEs70bwzy/XivtIJp9nrChwTK1SJZ/xkX8Abu2xe8paV2g9a/ibq33wNOVywrpD9aa0tr19Gl3J9xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(33656002)(86362001)(8936002)(6506007)(8676002)(44832011)(7696005)(5660300002)(76116006)(64756008)(66556008)(66946007)(26005)(66476007)(83380400001)(186003)(66446008)(71200400001)(55016002)(2906002)(478600001)(15650500001)(52536014)(110136005)(316002)(4326008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tkUjQA6QxLJjZvdJ7t1KZNemNygDoElzKN7iDWGhtZF7EVicKQb+b8ccb4r+ucw17HtkECmb2foESrKP29FDbzPOvvCDzwAM+eYkztLuvsoK2ROr91FAmFIsEXQ015YhPhoGDPDuCXOfvooKYRJTu+ChA9s0NI1Yz36pEN/S9mxWjXy1tQtw9eiliJrAdIPDOMoqDvWPkgc9Hd7OOBA5a0gMfQen4W2V6BEtaSMloF4Kfr8tuiE7tglgWg0zcNcnSnMYf++8EOR1h9soeqURnrJ7dD8s/ayOBCoITYXZd2KLvZvKmXeGCEuxc/m1uRH4G/09n9djxc9QPPaXw6jKXUAecHWxt7hdEkiFQovgyrCfGd35dH5p1lghfcIFEE15HjWIWKxzg1XTmv0ukJ+J41Va5J1tPI58UcMxXG2C7DHi9eB20Lw7u/dOdnXcyf6Sk6ifPtwSUBT3gA+08zcvrsSICXBzG23wWGLOMxQWzytqaDVIx8xlMRFQRe1H7vnE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092e8a2f-58f3-4bd8-b43c-08d802aa2e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 01:55:21.4173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tz0h0cRS9Yuor/nryvoaSADchFfp44Gzs1l+aWohsXxBTkpVpuv0uzBE/zQmq2T2eCGNRTifl0ZUeXi7kC2EZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIG1haWxib3g6IGlteDog
QWRkIGNvbnRleHQgc2F2ZS9yZXN0b3JlIGZvcg0KPiBzdXNwZW5kL3Jlc3VtZQ0KPiANCj4gDQo+
IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIG1haWxib3g6IGlteDogQWRkIGNvbnRleHQgc2F2
ZS9yZXN0b3JlIGZvcg0KPiA+IHN1c3BlbmQvcmVzdW1lDQo+ID4NCj4gPiA+IEZyb206IEFuc29u
IEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBBcHJpbCAy
NCwgMjAyMCAxMDozMyBBTQ0KPiA+ID4NCj4gPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gbWFp
bGJveDogaW14OiBBZGQgY29udGV4dCBzYXZlL3Jlc3RvcmUgZm9yDQo+ID4gPiA+IHN1c3BlbmQv
cmVzdW1lDQo+ID4gPiA+DQo+ID4gPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4gPiA+ID4gU2VudDogRnJpZGF5LCBBcHJpbCAyNCwgMjAyMCA3OjAxIEFN
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGb3IgIm1lbSIgbW9kZSBzdXNwZW5kIG9uIGkuTVg4IFNv
Q3MsIE1VIHNldHRpbmdzIGNvdWxkIGJlIGxvc3QNCj4gPiA+ID4gPiBiZWNhdXNlIGl0cyBwb3dl
ciBpcyBvZmYsIHNvIHNhdmUvcmVzdG9yZSBpcyBuZWVkZWQgZm9yIE1VDQo+ID4gPiA+ID4gc2V0
dGluZ3MgZHVyaW5nDQo+ID4gPiA+IHN1c3BlbmQvcmVzdW1lLg0KPiA+ID4gPiA+IEhvd2V2ZXIs
IHRoZSByZXN0b3JlIGNhbiBPTkxZIGJlIGRvbmUgd2hlbiBNVSBzZXR0aW5ncyBhcmUNCj4gPiA+
ID4gPiBhY3R1YWxseSBsb3N0LCBmb3IgdGhlIHNjZW5hcmlvIG9mIHNldHRpbmdzIE5PVCBsb3N0
IGluICJmcmVlemUiDQo+ID4gPiA+ID4gbW9kZSBzdXNwZW5kLCBzaW5jZSB0aGVyZSBjb3VsZCBi
ZSBzdGlsbCBJUEMgZ29pbmcgb24gbXVsdGlwbGUNCj4gPiA+ID4gPiBDUFVzLCByZXN0b3Jpbmcg
dGhlIE1VIHNldHRpbmdzIGNvdWxkIG92ZXJ3cml0ZSB0aGUgVElFIGJ5DQo+ID4gPiA+ID4gbWlz
dGFrZSBhbmQgY2F1c2Ugc3lzdGVtIGZyZWV6ZSwgc28gbmVlZCB0byBtYWtlIHN1cmUgT05MWQ0K
PiA+ID4gPiA+IHJlc3RvcmUgdGhlIE1VIHNldHRpbmdzIHdoZW4gaXQgaXMNCj4gPiA+ID4gcG93
ZXJlZCBvZmYuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQXMgbWVudGlvbmVkIGJl
Zm9yZSwgd2UnZCBiZXR0ZXIga2VlcCB0aGUgb3JpZ2luYWwgYXV0aG9yLg0KPiA+ID4gPg0KPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyB8IDM1
DQo+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiA+ID4gPiA+IGIv
ZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMgaW5kZXggOTdiZjBhYy4uYjUzY2Y2MyAxMDA2
NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4gPiA+ID4gQEAgLTY3
LDYgKzY3LDggQEAgc3RydWN0IGlteF9tdV9wcml2IHsNCj4gPiA+ID4gPiAgCXN0cnVjdCBjbGsJ
CSpjbGs7DQo+ID4gPiA+ID4gIAlpbnQJCQlpcnE7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArCXUz
MiB4Y3I7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICAJYm9vbAkJCXNpZGVfYjsNCj4gPiA+ID4g
PiAgfTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEBAIC01ODMsMTIgKzU4NSw0NSBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiA+ID4gPiA+IGlteF9tdV9kdF9pZHNbXSA9IHsg
IH07ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfbXVfZHRfaWRzKTsNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+ICtzdGF0aWMgaW50IGlteF9tdV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2Ug
KmRldikgew0KPiA+ID4gPiA+ICsJc3RydWN0IGlteF9tdV9wcml2ICpwcml2ID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJcHJpdi0+eGNyID0gaW14X211
X3JlYWQocHJpdiwgcHJpdi0+ZGNmZy0+eENSKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwly
ZXR1cm4gMDsNCj4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIGlu
dCBpbXhfbXVfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ID4gPiA+ICsJ
c3RydWN0IGlteF9tdV9wcml2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiArCSAqIE9OTFkgcmVzdG9yZSBNVSB3aGVu
IGNvbnRleHQgbG9zdCwgdGhlIFRJRSBjb3VsZA0KPiA+ID4gPiA+ICsJICogYmUgc2V0IGR1cmlu
ZyBub2lycSByZXN1bWUgYXMgdGhlcmUgaXMgTVUgZGF0YQ0KPiA+ID4gPiA+ICsJICogY29tbXVu
aWNhdGlvbiBnb2luZyBvbiwgYW5kIHJlc3RvcmUgdGhlIHNhdmVkDQo+ID4gPiA+ID4gKwkgKiB2
YWx1ZSB3aWxsIG92ZXJ3cml0ZSB0aGUgVElFIGFuZCBjYXVzZSBNVSBkYXRhDQo+ID4gPiA+ID4g
KwkgKiBzZW5kIGZhaWxlZCwgbWF5IGxlYWQgdG8gc3lzdGVtIGZyZWV6ZS4gVGhpcyBpc3N1ZQ0K
PiA+ID4gPiA+ICsJICogaXMgb2JzZXJ2ZWQgYnkgdGVzdGluZyBmcmVlemUgbW9kZSBzdXNwZW5k
Lg0KPiA+ID4gPiA+ICsJICovDQo+ID4gPiA+ID4gKwlpZiAoIWlteF9tdV9yZWFkKHByaXYsIHBy
aXYtPmRjZmctPnhDUikpDQo+ID4gPiA+ID4gKwkJaW14X211X3dyaXRlKHByaXYsIHByaXYtPnhj
ciwgcHJpdi0+ZGNmZy0+eENSKTsNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBjb3VsZCBiZSBzZXBh
cmF0ZSBwYXRjaCBpZiBpdCBhaW1zIHRvIGZpeCBhIHNwZWNpZmljIGNvcm5lciBjYXNlLg0KPiA+
ID4NCj4gPiA+IFRoaXMgaXMgTk9UIGNvcm5lciBjYXNlLCBpdCBjYW4gYmUgcmVwcm9kdWNlZCB3
aXRoIG91ciBpbXhfNS40LnkNCj4gPiA+IHZlcnkgZWFzaWx5LCBhbmQgdGhpcyBpc3N1ZSBjYXVz
ZSBtZSBtYW55IGRheXMgdG8gZGVidWcuLi5BbHNvIGNhdXNlDQo+ID4gPiBDbGFyaydzIGVmZm9y
dCB0byBoZWxwIHRlc3QgaXQgYSBsb3QgZm9yIG1hbnkgZGF5cy4uLg0KPiA+ID4NCj4gPg0KPiA+
IElzIHRoaXMgaXNzdWUgb25seSBoYXBwZW4gZm9yIG5vbi1zdGF0ZSBsb3N0IGNhc2UgKGVnLiBG
cmVlemUgbW9kZSk/DQo+ID4gSWYgeWVzLCBpdCdzIGEgc3BlY2lmaWMgY2FzZSBhbmQgd29ydGgg
YSBzZXBhcmF0ZSBwYXRjaCB0byBoaWdobGlnaHQgaXQgSU1ITy4NCj4gPg0KPiA+IEJUVywgaXQg
c2VlbXMgbW9zdCBkcml2ZXJzIGhhdmUgdGhpcyBpc3N1ZSBpbiBjdXJyZW50IGtlcm5lbCBiZWNh
dXNlDQo+ID4gdGhleSBkb24ndCBrbm93IHdoZXRoZXIgdGhlIHN0YXRlIGFyZSByZWFsbHkgbG9z
dCwgaXQgc2VlbXMgbGlrZQ0KPiA+IGtlcm5lbCBzdGlsbCBkb2Vzbid0IHN1cHBvcnQgdGhpcyB3
ZWxsLg0KPiA+DQo+ID4gPiBJIGRvIE5PVCB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBmaXJzdCBz
ZW5kIG91dCB5b3VyIHBhdGNoIHdpdGggYnVnDQo+ID4gPiBmb3IgcmV2aWV3LCBBbmQgdGhlbiBh
ZGQgYW5vdGhlciBwYXRjaCB0byBmaXggaXQuIDEgcGF0Y2ggaXMgZW5vdWdoDQo+ID4gPiBmb3Ig
dGhpcw0KPiA+IGZlYXR1cmUuDQo+ID4gPg0KPiA+DQo+ID4gQW55d2F5LCBpZiB5b3UgcmVhbGx5
IHdhbnQgdG8gZ28gd2l0aCBvbmUgcGF0Y2gsIGZvciB0aGlzIGNhc2UsIHdlDQo+ID4gdXN1YWxs
eSBjb3VsZCBrZWVwIG9yaWdpbmFsIGF1dGhvciBhbmQgYWRkIGEgc21hbGwgZml4IG5vdGUgaW4g
Y29tbWl0DQo+IG1lc3NhZ2UuDQo+ID4gKFlvdSBjb3VsZCBzZWUgbWFueSBjb21tdW5pdHkgZ3V5
cyBkbyBsaWtlIHRoaXMgaWYgeW91IHNlYXJjaCBrZXJuZWwNCj4gPiBjb21taXQNCj4gPiBsb2cp
DQo+ID4NCj4gPiBCYXNpY2FsbHkgd2UgdHJ5IG91ciBiZXN0IHRvIGtlZXAgb3JpZ2luIGF1dGhv
ciBpbiBvcmRlciB0byByZXNwZWN0DQo+ID4gb3RoZXJzJyB3b3JrIGZvciBjb21tdW5pdHkgd29y
ay4NCj4gDQo+IEkgYW0gZmluZSB3aXRoIHdob2V2ZXIgaXMgdGhlIGF1dGhvciwgbXkgZm9jdXMg
aXMgdGhlIGlzc3VlIGZpeCBhbmQgZWFzeSByZWJhc2UuDQo+IElmIG1haW50YWluZXIgYWdyZWVz
IHRoYXQgaW50cm9kdWNlIGEgcGF0Y2ggd2l0aCBidWcgYW5kIGFkZCBhbm90aGVyIHBhdGNoIHRv
DQo+IGZpeCBpcyBPSywgdGhlbiBJIGNhbiByZXdvcmsgdGhlIHBhdGNoIGludG8gMiBwYXRjaGVz
Lg0KPiANCj4gQW5zb24NCg0K

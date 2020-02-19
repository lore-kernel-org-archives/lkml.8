Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD2C34052
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFEE2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nbj0qzyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSPkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:40:53 -0500
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:29595
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbgBSPkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:40:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cscKC8aJ7yAhwi0afb5Z6TMbmxjd1xeFprOFTc37ujFaKs9X4jVOMCC+wwSbRBBbRxBDIyrKV0onZH2aiW7SNfJwkegI2xFpVBtCnc0B3nkWDvtFSE1BNtFNFbnv6ceYWTHw0GHP31u9L97AxMJGuSkXQH+QdWOuz31ot1AeP7MMqKrTAeNo8eEu7FVKUCG6DoiLbrS1ivi4O06WVhA6yeaKjixOu2n9aXr0LQobzGnSVfJjVrFrPNz1qsKjW3jCp7oBGQg61a0oOf73C3P1T2gBVCxNXyYfq6KkIVm5Ou0QzVZz5LA9NbgA9HgVqr+0ay2ALWLprTTMC2uwz3YiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO0BlFh1YtDNLvXsSac06e52t95pKUx+6j/HrVZE3LY=;
 b=ZCJzAS1JPbFq+YNM4Jqt1oeg5xi8WPwryu0l9G7G4eVNiyRTchhoiaqUXYDMZnHVpxN29ylQ56zaGSnOrDiIdey446wCCiAtuJtinELLGSfhOXmZ5CU0CZwn1Ddpk0e2eOj+S7dvRLHMzrH7Z6wR2cxvA7a/Cwbw2Rp6tg62LgxtGTULx/fK81e0uwXQL2BiQ8ln9/n+BLh6EI9Of3d7LSRefD7qDR6D1qZ+nuNU/WE6Wd3E+mxVHo1++Mtv5Cmc1dU7cbQbMuSv7mOia4A7+U4WysoS28YzXQQZ5Ajf6qvAj3XonHfirQIrhdjQvlfK+2gol3GjWGQGTvXcTjwKEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO0BlFh1YtDNLvXsSac06e52t95pKUx+6j/HrVZE3LY=;
 b=Nbj0qzyVsdPm//+rLWwLOb2ckchtThqOBJKPvhbgLfYt1X2labnsQqxIV4lq/6+NPjnGqkKuA/VhfgPPWd3qL1Fp1iMoGaHkmH+KjUJHshNNvohdx6IiDGVhQgMIEFxigsWh5uJ2Bf/mOjk4fWAafIYaeMadI08OEMLvscd8CEI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4179.eurprd04.prod.outlook.com (52.134.126.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 15:40:47 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 15:40:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/9] remoteproc: add support to skip firmware load when
 recovery
Thread-Topic: [PATCH 3/9] remoteproc: add support to skip firmware load when
 recovery
Thread-Index: AQHV5vbtBcsi7uUDB0+hcFvNM8RaVqgilukAgAAQEwA=
Date:   Wed, 19 Feb 2020 15:40:46 +0000
Message-ID: <AM0PR04MB4481F7E58E9D09F1779E279988100@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <1582097265-20170-4-git-send-email-peng.fan@nxp.com>
 <0d90b2c2-cb02-d052-57cb-b11c5f815f07@st.com>
In-Reply-To: <0d90b2c2-cb02-d052-57cb-b11c5f815f07@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d400722c-34c8-4186-8bbc-08d7b55216c1
x-ms-traffictypediagnostic: AM0PR04MB4179:|AM0PR04MB4179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4179A6729086C4D3A4B6054488100@AM0PR04MB4179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(189003)(199004)(76116006)(9686003)(2906002)(8936002)(71200400001)(55016002)(6506007)(5660300002)(54906003)(7696005)(478600001)(53546011)(186003)(64756008)(4326008)(44832011)(66556008)(33656002)(66476007)(66946007)(7416002)(66446008)(86362001)(110136005)(316002)(52536014)(8676002)(81166006)(26005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4179;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXGVApwSkXVriQrqLiZtwH9VhQ1Lav+myN3QZ8PKHNk4c0br56JQOohLZQliG8jD6YhKSk1Ay3vzgi+s4V4HiSMTlyF5Fl2miMgXItr0Df1RjajE7yF6ZeudD49E2dgDv0SqEwcOw9IHDWPevH/B0HG6eedsmEQ2kjIQzq0inonZu34UXuZAu9NcLdag8bILU7lRX/RFtLFSyp5sz69UNVLiW8dHiJm2aznYQrtjaFc/TUoHk68NlnuhMc6RBIELBnglHdIMVgYyOgcVoeufdNdYOClEOHz707sXxsm4vUMJZ479z1EiHhfCcdMfMUIACuqSuklcze94sbOUezyY+BrVMQRhdq3BxB+Y8gH9Ui1F7WC56IoI6cttOieq7zBgUqFgmzR05M5yZ/bv34nQ847rPdri8sN7GF+3aFs3FUQoT2V1ejMhxvzKiFfQCA5C
x-ms-exchange-antispam-messagedata: cnRDhjl7JjH8qzHcEaXgtPi8cjnRJLkbx/xOtxGJ/8JT0pnVeRynnHQvjQbgdKRS1fgMi4fvG3sYY4dD2KK6ThhI8dilzB5099sJ6JRgXtgzedOng3HccWaMT/cuAbfzg+zC4vOh1qC9TsOHpSJcaQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d400722c-34c8-4186-8bbc-08d7b55216c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 15:40:46.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vxr73GQTcuQMMhjrVV+wgW6th6JnLOTFKRsOzQtt5LVGuIDhOfIgkl3i5nCfSNwxBmrAhDrJEbLRzqVFxVRetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy85XSByZW1vdGVwcm9jOiBhZGQgc3VwcG9ydCB0byBz
a2lwIGZpcm13YXJlIGxvYWQgd2hlbg0KPiByZWNvdmVyeQ0KPiANCj4gSGksDQo+IA0KPiBPbiAy
LzE5LzIwIDg6MjcgQU0sIHBlbmcuZmFuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBSZW1vdGUgcHJvY2Vzc29yIHN1Y2ggYXMg
TTQgaW5zaWRlIGkuTVg4UVhQIGlzIG5vdCBoYW5kbGVkIGJ5IExpbnV4DQo+ID4gd2hlbiBpdCBp
cyBjb25maWd1cmVkIHRvIHJ1biBpbnNpZGUgaXRzIG93biBoYXJkd2FyZSBwYXJ0aXRpb24gYnkN
Cj4gPiBzeXN0ZW0gY29udHJvbCB1bml0KFNDVSkuIFNvIGV2ZW4gcmVtb3RlIHByb2Nlc3NvciBj
cmFzaCByZXNldCwgaXQgaXMNCj4gPiBoYW5kbGVkIGJ5IFNDVSwgbm90IGxpbnV4LiBUbyBzdWNo
IGNhc2UsIGZpcm13YXJlIGxvYWQgc2hvdWxkIGJlDQo+ID4gaWdub3JlZCwgU28gaW50cm9kdWNl
IHNraXBfZndfbG9hZF9yZWNvdmVyeSBhbmQgcGxhdGZvcm0gZHJpdmVyIHNob3VsZA0KPiA+IHNl
dCBpdCBpZiBuZWVkZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2Nf
Y29yZS5jIHwgMTkgKysrKysrKysrKystLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3JlbW90
ZXByb2MuaCAgICAgICAgICAgfCAgMSArDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Jl
bW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPiBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1v
dGVwcm9jX2NvcmUuYw0KPiA+IGluZGV4IDg3NmI1NDIwYTMyYi4uY2EzMTBlMzU4MmJmIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+IEBAIC0xNjc4LDIw
ICsxNjc4LDIzIEBAIGludCBycHJvY190cmlnZ2VyX3JlY292ZXJ5KHN0cnVjdCBycHJvYyAqcnBy
b2MpDQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCWdvdG8gdW5sb2NrX211dGV4Ow0KPiA+DQo+ID4g
LQkvKiBnZW5lcmF0ZSBjb3JlZHVtcCAqLw0KPiA+IC0JcnByb2NfY29yZWR1bXAocnByb2MpOw0K
PiA+ICsJaWYgKCFycHJvYy0+c2tpcF9md19sb2FkX3JlY292ZXJ5KSB7DQo+ID4gKwkJLyogZ2Vu
ZXJhdGUgY29yZWR1bXAgKi8NCj4gPiArCQlycHJvY19jb3JlZHVtcChycHJvYyk7DQo+ID4NCj4g
PiAtCS8qIGxvYWQgZmlybXdhcmUgKi8NCj4gPiAtCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZp
cm13YXJlX3AsIHJwcm9jLT5maXJtd2FyZSwgZGV2KTsNCj4gPiAtCWlmIChyZXQgPCAwKSB7DQo+
ID4gLQkJZGV2X2VycihkZXYsICJyZXF1ZXN0X2Zpcm13YXJlIGZhaWxlZDogJWRcbiIsIHJldCk7
DQo+ID4gLQkJZ290byB1bmxvY2tfbXV0ZXg7DQo+ID4gKwkJLyogbG9hZCBmaXJtd2FyZSAqLw0K
PiA+ICsJCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZpcm13YXJlX3AsIHJwcm9jLT5maXJtd2Fy
ZSwgZGV2KTsNCj4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ICsJCQlkZXZfZXJyKGRldiwgInJl
cXVlc3RfZmlybXdhcmUgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gPiArCQkJZ290byB1bmxvY2tf
bXV0ZXg7DQo+ID4gKwkJfQ0KPiANCj4gQW55IHNwZWNpZmljIHJlYXNvbiB0byBub3QgcmV1c2Ug
c2tpcF9md19sb2FkIGhlcmU/DQoNCkp1c3QgdGhvdWdodCBmaXJtd2FyZSBuZWVkcyB0byBiZSBs
b2FkZWQgYnkgTGludXggd2hlbiByZW1vdGUNCnByb2Nlc3NvciBjcmFzaCwgZXZlbiBpZiBpdCBp
bml0aWFsbHkgYm9vdGVkIGVhbHkuDQoNCnNraXBfZndfbG9hZCBqdXN0IGhhbmRsZXMgZmlyc3Qg
Ym9vdCB3aGljaCBubyBuZWVkIGZpcm13YXJlLg0KQnV0IGlmIHJlY292ZXJ5IGJvb3QgbmVlZHMg
Zmlyd2FyZW0sIHNraXBfZndfbG9hZCB3aWxsIG5vdCBoYW5kbGUuDQoNClNvIEkgYWRkIHRoaXMg
bmV3IGJvb2wuDQoNCkFjdHVhbGx5IHRvIG15IHBsYXRmb3JtLCBza2lwX2Z3X2xvYWQgY291bGQg
d29yayB3aGVuIHJlY292ZXJ5LA0KSSBqdXN0IHRoaW5rIG90aGVyIHBsYXRmb3JtcyBtaWdodCBu
ZWVkIGZpcndhcmUgbG9hZCB3aGVuIHJlY292ZXJ5Lg0KDQpSZWdhcmRzLA0KUGVuZy4gDQoNCj4g
RllJIGknbSByZXdvcmtpbmcgdGhlIExvaWMncyBwYXRjaCBhbmQgaSBwbGFuIHRvIGltcGxlbWVu
dCB0aGUgcmVjb3ZlcnkgcGFydA0KPiB1c2luZyBza2lwX2Z3X2xvYWQuLi4NCg0KDQoNCj4gDQo+
IFJlZ2FyZHMNCj4gQXJuYXVkDQo+IA0KPiA+ICAJfQ0KPiA+DQo+ID4gIAkvKiBib290IHRoZSBy
ZW1vdGUgcHJvY2Vzc29yIHVwIGFnYWluICovDQo+ID4gIAlyZXQgPSBycHJvY19zdGFydChycHJv
YywgZmlybXdhcmVfcCk7DQo+ID4NCj4gPiAtCXJlbGVhc2VfZmlybXdhcmUoZmlybXdhcmVfcCk7
DQo+ID4gKwlpZiAoIXJwcm9jLT5za2lwX2Z3X2xvYWRfcmVjb3ZlcnkpDQo+ID4gKwkJcmVsZWFz
ZV9maXJtd2FyZShmaXJtd2FyZV9wKTsNCj4gPg0KPiA+ICB1bmxvY2tfbXV0ZXg6DQo+ID4gIAlt
dXRleF91bmxvY2soJnJwcm9jLT5sb2NrKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9yZW1vdGVwcm9jLmggYi9pbmNsdWRlL2xpbnV4L3JlbW90ZXByb2MuaA0KPiA+IGluZGV4IDRm
ZDViZWRhYjRmYS4uZmU2ZWUyNTNiMzg1IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgv
cmVtb3RlcHJvYy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9yZW1vdGVwcm9jLmgNCj4gPiBA
QCAtNTE0LDYgKzUxNCw3IEBAIHN0cnVjdCBycHJvYyB7DQo+ID4gIAlib29sIGhhc19pb21tdTsN
Cj4gPiAgCWJvb2wgYXV0b19ib290Ow0KPiA+ICAJYm9vbCBza2lwX2Z3X2xvYWQ7DQo+ID4gKwli
b29sIHNraXBfZndfbG9hZF9yZWNvdmVyeTsNCj4gPiAgCXN0cnVjdCBsaXN0X2hlYWQgZHVtcF9z
ZWdtZW50czsNCj4gPiAgCWludCBuYl92ZGV2Ow0KPiA+ICB9Ow0KPiA+DQo=

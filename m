Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5548C38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46CC21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cdfq9APS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDRMkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:40:03 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:34528
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgDRMkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWcItMsYOPC9QDwCwe0RTcNBkqVT6W69Af7dv+FJW0wdnqqOt6Y/HSn9q6YPy8nkTGaLS23/PHtAZFILmRF5MLR8ITwSettHBQYcN1TWI6ftE5mkOftGlS/MIOMwQ/eBJKB/7r4jP3iYVLQEKsGI/k1KvlkVO0kcmzSReaSDfHPcurXA+iCYXo44/8YpjCKdVtkiEcnFcbs0Ih3vVQerCmtAnz+O768rvPq5vKTgTe5FZlX15EaaOmXDab9Pc111YfbsMiRIjDrlnMzv7r3w20yVNNy9E3whqawLsLNaOqEf0VuSaP1rgu55gPGeZOaRLMElAkEzJbSSBq6nWLEJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgzj0EPdQ6+1VipzqgvCpBatmaeafTHiCELdzqBsxl4=;
 b=fJqlWUw3Nq2iFRJ+9sa75Eh7tOAOzaat05fFjV803fb/S5CAXlVIuCiR27DtOKeEBacsIJ8U1AUQLmweCDmZuNPjZZTpa8rhHltTDH2Wst9ddY3a03e9iUOHGSZcZUsF79UEB1RO84H52ww2ooMOyOrAq+IRXkb1RXHfqXEXUm4bXDR+oha/XJ5D1OQlEHY/P3MquNHZtwoN7LsSsWbaScAjrJp0DXJRjU2OHagrsGelvZSje3rPkuV3w8goIbHaGvv5rrEHaM3eErOZZOoiA7JLc8gUvlldRlGmi2Orl0XhwBGOHSTgPlZrhOPn68qWuQQbVkN4GBwH1GxtJoy38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgzj0EPdQ6+1VipzqgvCpBatmaeafTHiCELdzqBsxl4=;
 b=cdfq9APSrT5B3VhyjplZyV9LZDngqI3R2KHOiSUQobPumBAgVRulCIZV1c9f4B3l7qNqXtdVoycTpncwGDPwr/vQS47+ef83QsOQu4dQCaSaL8nFrsIS0GBWmDwSTBjclConm5HCL+BMrtT+I+QGaQENAo5F5RmdRjFoakvzNaQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3643.eurprd04.prod.outlook.com (2603:10a6:8:5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Sat, 18 Apr
 2020 12:39:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2900.028; Sat, 18 Apr 2020
 12:39:58 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Thread-Topic: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Thread-Index: AQHWFHuqDS+qjcBTvkSC+6fN5KRxoKh+0MaAgAAB9+A=
Date:   Sat, 18 Apr 2020 12:39:57 +0000
Message-ID: <DB3PR0402MB3916E212269C5D5BD6E12D21F5D60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587101946-19495-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB496663AED27DFD38E648169C80D60@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496663AED27DFD38E648169C80D60@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81e307c4-b874-4691-fb90-08d7e3959aad
x-ms-traffictypediagnostic: DB3PR0402MB3643:|DB3PR0402MB3643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB364308271DA3850B448215BAF5D60@DB3PR0402MB3643.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(8676002)(2906002)(71200400001)(7696005)(81156014)(6506007)(76116006)(33656002)(44832011)(966005)(5660300002)(478600001)(186003)(26005)(52536014)(64756008)(4326008)(66476007)(66946007)(86362001)(9686003)(66556008)(66446008)(55016002)(316002)(110136005)(8936002)(21314003)(921003)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VuWkPveEAGTPGc1xRqXnYySu9mjM8SThMoXzQtjTClAGKKlOJN+XaZBykF7aka6xAh/Ky4soyP0mX6LxlrhEmuGgp5kCnUCJ+vbXDui6DU/LB8MufwLFXxGcNj1sDkmXnHNW9SiX5uhpW47F8d++7KOd9rfuZ4K1Bptf2ykk7zzwLCWX1Tje2lFzauELYe153j5oUtPJ2OS5U3Jzv11Q3sT+EqAROrkKh9XjDTLeopfQ8Xgk9rGeSr1KK17VwedKshUUx0YPv8fM0EVUuV7PeJHMPkS7qMyyiJ9N+8TwXUTv47OTLDvrtKgjzfc73Slrh2Jr3Pvy9YwUe2zrtdHGtHdGgh/In3Xa07uPxnJcYJwNd36U4+5I1ZJyU72Zs4DGaYKnFp9uKD+9kErItrOjoJxQnEgNsfEZQLbAXtJoOKeB4FRTZxpnRnUkucRVgQOzwitYwTXtpBbuZMNcNi4e+sJxtbDAFqKcuSXJBVZ1/LxJjEAY97MLkKHFROX5g3fW31il+7sJUlDC/7ABFEWpyx0o0UIhxRroPkIr6r6E50HOXBSvJn5MTpoJJMQlcCjPVBQ6IQi0OpjsEeR0J/fnF28bU0250BvM2IR9cojARU=
x-ms-exchange-antispam-messagedata: YdE/4hEjySUHbfVNyeostdOTtpLCkuD22UPsucV2nNV7o7+HEOgjiYNn1RurbZAlUwzOAuCJosk1haeO1EAzQfOo6qvPt7gt+B3uxU5oJStTAyThfcD4ZLMR4IGb+M68I1QvQAZ2owyh9d5X26DsLdAX06hiwlkx9Yd2oEzOgZlsAr3sjCGKtQDsWipU4dem2ZFtBt+D/UsY5yjVFYbMXkpJIVR/iYReXWR03hIZCBgemFifqlTLUvI9+97f3ledQTOHkHTrCUnlmGUgyefrk4YKCGkTLUN2C4BHe4JHKslBRuF+bCJo4iYP9kGuEfP2IM014atnxO6TtLn9Rghs7Hpk5zkRyFJOEkpjNQw30/4OVqb1iJd4Hvx90zQX/zpuLtBEXubKx0zjykppDociMFbry44DUVvZIgCNR/eexe+QB6BMfou/JxdnzvyZQ6vIgvlKqAA9N6jT6DN/J1F2w3FZzAri45FpkgGA2tMr09D/d8VCydRNFR4mdYfBd/lQ7xO9Kffd6ZAwz4sClGqm5ukkBhAkh0VEkeARkg3xO9PHSvqttL9FwZKYCUdU4Lx3s+ttaHaKlpQHMyNLeS8DwS2AN1XTqQVvmZKWz1rjo87ZH/GJUdn1UjDC90v7Be0cWBvLHx4QsOp/DdZitOJF/M4NyC+JjcKpTJ3HEyqtOQjirdaY00NV9nz3CF2vEQbtpHkg8nUGlbxxaIIHYvHDx+tn4JrNWRy7D3PiBXfToUvWzq49cnYeyOCj2BWYtmFfX0KYmjvvY2N7oXiMadO1OVx19etyOhK6yn1hwPb7T98=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e307c4-b874-4691-fb90-08d7e3959aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 12:39:58.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otHPEVWQDTKW+AHRzaVsE0utMqZ853oGLCpbBOamlFF6QwSgMRPNxVF5ClzzFhDMObnr7LBS0yYNtMr8FMQzbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIGFybTY0OiBkdHM6IGlteDhxeHAtbWVrOiBT
b3J0IGxhYmVscyBhbHBoYWJldGljYWxseQ0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIEFwcmlsIDE3LCAyMDIwIDE6Mzkg
UE0NCj4gPg0KPiA+IFNvcnQgdGhlIGxhYmVscyBhbHBoYWJldGljYWxseSBmb3IgY29uc2lzdGVu
Y3kuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgbWVhbmluZ2xlc3MgYXMgc3Vic3lzIHByZWZpeCAo
ZS5nLiBhZG1hX3h4eCkgd2lsbCBiZSByZW1vdmVkDQo+IGxhdGVyIGFuZCBkZXZpY2VzIG5vZGVz
IGFsbCBtb3ZlZCBpbnRvIHN1YnN5cyBkdHNpLg0KPiBJJ3ZlIHJlcGxpZWQgdGhpcyBiZWZvcmU6
DQo+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzMvMTYvMjQ0DQoNCkkga25ldyB5b3UgcmVw
bGllZCB0aGlzIGJlZm9yZSwgYnV0IGRvIHlvdSBoYXZlIGFuIGV4YWN0IGRheSBvZiB3aGVuIHN1
YnN5cyBkdHNpIHdpbGwgYmUgaW1wbGVtZW50ZWQ/DQpNYW55IHByZXZpb3VzIHBhdGNoZXMgb2Yg
bXkgbWluZSB0byBhZGQgZmVhdHVyZXMgdG8gRFRTIGZpbGUsIEkgaGF2ZSBiZWVuIGFza2VkIGJ5
IFNoYXduIHRvDQphZGQgYSBuZXcgcGF0Y2ggdG8gaGVscCBzb3J0IHRoZSBsYWJlbHMsIEkgdGhp
bmsgdGhpcyBpcyBzb21lIG1haW50YWluZXJzJyBob2JieSwgc28gaWYgU2hhd24gdGhpbmtzIG5v
DQpuZWVkIHRoaXMgZm9yIDhRWFAsIEkgY2FuIGRyb3AgdGhpcyBwYXRjaC4NCg0KQW5zb24NCg0K
DQo+IA0KPiBSZWdhcmRzDQo+IEFpc2hlbmcNCj4gDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cyB8IDYwDQo+ID4gKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAz
MCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4cXhwLW1lay5kdHMNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiA+IGluZGV4IDEzNDYwYTMuLjJlZDdhYmEgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsuZHRz
DQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC1tZWsuZHRz
DQo+ID4gQEAgLTMwLDI5ICszMCw4IEBADQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gLSZh
ZG1hX2xwdWFydDAgew0KPiA+IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAtCXBp
bmN0cmwtMCA9IDwmcGluY3RybF9scHVhcnQwPjsNCj4gPiAtCXN0YXR1cyA9ICJva2F5IjsNCj4g
PiAtfTsNCj4gPiAtDQo+ID4gLSZmZWMxIHsNCj4gPiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+ID4gLQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmVjMT47DQo+ID4gLQlwaHktbW9kZSA9
ICJyZ21paS1pZCI7DQo+ID4gLQlwaHktaGFuZGxlID0gPCZldGhwaHkwPjsNCj4gPiAtCWZzbCxt
YWdpYy1wYWNrZXQ7DQo+ID4gKyZhZG1hX2RzcCB7DQo+ID4gIAlzdGF0dXMgPSAib2theSI7DQo+
ID4gLQ0KPiA+IC0JbWRpbyB7DQo+ID4gLQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gLQkJ
I3NpemUtY2VsbHMgPSA8MD47DQo+ID4gLQ0KPiA+IC0JCWV0aHBoeTA6IGV0aGVybmV0LXBoeUAw
IHsNCj4gPiAtCQkJY29tcGF0aWJsZSA9ICJldGhlcm5ldC1waHktaWVlZTgwMi4zLWMyMiI7DQo+
ID4gLQkJCXJlZyA9IDwwPjsNCj4gPiAtCQl9Ow0KPiA+IC0JfTsNCj4gPiAgfTsNCj4gPg0KPiA+
ICAmYWRtYV9pMmMxIHsNCj4gPiBAQCAtMTMxLDYgKzExMCwzNSBAQA0KPiA+ICAJfTsNCj4gPiAg
fTsNCj4gPg0KPiA+ICsmYWRtYV9scHVhcnQwIHsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfbHB1YXJ0MD47DQo+ID4gKwlzdGF0
dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmZmVjMSB7DQo+ID4gKwlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZlYzE+Ow0K
PiA+ICsJcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPiA+ICsJcGh5LWhhbmRsZSA9IDwmZXRocGh5
MD47DQo+ID4gKwlmc2wsbWFnaWMtcGFja2V0Ow0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+
ICsNCj4gPiArCW1kaW8gew0KPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsJCSNz
aXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArCQlldGhwaHkwOiBldGhlcm5ldC1waHlAMCB7
DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LWllZWU4MDIuMy1jMjIiOw0KPiA+
ICsJCQlyZWcgPSA8MD47DQo+ID4gKwkJfTsNCj4gPiArCX07DQo+ID4gK307DQo+ID4gKw0KPiA+
ICsmc2N1X2tleSB7DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+
ICAmdXNkaGMxIHsNCj4gPiAgCWFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWF9DT05OX1NESEMw
X0NMSz47DQo+ID4gIAlhc3NpZ25lZC1jbG9jay1yYXRlcyA9IDwyMDAwMDAwMDA+Ow0KPiA+IEBA
IC0yMjksMTEgKzIzNywzIEBADQo+ID4gIAkJPjsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4gLQ0K
PiA+IC0mYWRtYV9kc3Agew0KPiA+IC0Jc3RhdHVzID0gIm9rYXkiOw0KPiA+IC19Ow0KPiA+IC0N
Cj4gPiAtJnNjdV9rZXkgew0KPiA+IC0Jc3RhdHVzID0gIm9rYXkiOw0KPiA+IC19Ow0KPiA+IC0t
DQo+ID4gMi43LjQNCg0K

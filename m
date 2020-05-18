Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8322081A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yi+9pAZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgERJ5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:57:39 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:38127
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgERJ5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVY9nS90+ipMp33vWCtYJWQOxk4I62roKlPQxOWOpk1yflGJo+7b8RJ0svq4vc6LhLFPQcnROiNPGlrEBJqbyGgUR9S2nnAAjEJOZfnmWwjOxq/5ysJVUAdmv+fNRvNopQE7LQitmlu3oX/luw97nssyYJF6Nj0fYvc2O6OFKwOkCAiMHwZmoT3leX9cnZUMRWCDYp+qIpSLlvzR2jI+a77UoCdeBgdruS9L5kffnJccHc6eKygd/Z4TEusdzmQPuJmFjwMjl224Zg9APlv8f6wQD1P1VhdB0j5bAFvY3DQGI3/tiBrXU31lAFz4LvvAH24I1snu+SGJtz9SqWdVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RGQbqCAO950wpxFmLsgDj7UGeEmPT/FZOgufmsiFJM=;
 b=KehAtH0VD+H68gy0e0GOkJ6uE/qRXT95F8kyBIhxqg1jY21RcXh+NSzFSM+hlCQFs+hbFfD1Gd4EBjrVcY8RRW98HzNDu5JeleFNyZ/YdUYUZqVTwUqvUfOAFBav2K/kxGY7exYDQceCAN4+aonQ9CpheLQlvJeAsVsv1++mAxk2se+F9/ugpKeHfvEglzYVBTLA7H2jWn0cAlvAYBxJZmbBhCZ2OZ/Lk60KwJwW8y7ggWPdbtaaegmA2eNvD3ofO81mYflHCETzxdcY1UIkeeEQf4lxTngHORrV6h1FXVFPyQm4rt1LaCpMLOV+oceLOTD1bPvaQwf502RD+EUKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RGQbqCAO950wpxFmLsgDj7UGeEmPT/FZOgufmsiFJM=;
 b=Yi+9pAZx/gJs+mwt3rMpJAuACUOpQUHWu/z4D2wYtDKuqW8TMXbYleVolIZtcY3RPtLcP1TOByXw3svt7alBnnL0+nSZbnnHQkuLkcdngOBJeRJL/hfBRSxaBoQEkIJiO+EZlUna5X/WjdN8loGCHW1ogbL1gyaVA822Dc5rrDg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3945.eurprd04.prod.outlook.com (2603:10a6:8:3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 09:57:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:57:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: reset: Convert i.MX reset to json-schema
Thread-Topic: [PATCH] dt-bindings: reset: Convert i.MX reset to json-schema
Thread-Index: AQHWKAWfz/hL/av3lkeqLSh6w78ioaitl5SAgAADGFA=
Date:   Mon, 18 May 2020 09:57:32 +0000
Message-ID: <DB3PR0402MB39161E59A62C9802E8794E33F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589250194-29441-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB496643088C27DB303166ED0D80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496643088C27DB303166ED0D80B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7241fa5-54cd-448f-bcb3-08d7fb11e27d
x-ms-traffictypediagnostic: DB3PR0402MB3945:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3945883BD54561CDA9976BDAF5B80@DB3PR0402MB3945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56tSm1AMfdtXx0iJcHh3ZdedNCYwNIQRzZ6neABsSDdAitkbfBxbIroSJbh6gjhPr2ftldhSTDHI19fNAqBYJRwGAaAZcK2D4Nddocy6SRx50D1i+6D+/vLVi4duLjlhYEAyKUGwCRB2VahMAtfSmlfLHEQGjEJ1eCeqdBNUhc0uKGlbZs/7F9jckqtkV7JzOyeRdgnjHwpg4K8hriI+DEN1wRDZ7pTusBF4jRWTF6vNXNDEqKl+wKfP4cjfUHPQgCLB6paiAMqxKbmzPUgaenPuU9Bz5lKt7svYDGGegbeMDOkMMm0TLbsikVk5OoRXngxDyj1r2e2w00CoWxXS2lDIadUwXC6ZYzrx/ZP3ntl/uhUav9AKN92wpNe0nkqdBQjgBWgnhHJVDkoseUDuYvcgLkNT15Gx3SngH9BUokxMr8SK6ZRJzUChV4gKq8ZM60Opltf25Bn8lMjv55tAwyNWBeRXdt3GJZjPmhhPloE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(26005)(5660300002)(71200400001)(186003)(2906002)(7696005)(8936002)(55016002)(44832011)(66946007)(76116006)(66556008)(66476007)(33656002)(86362001)(52536014)(66446008)(110136005)(316002)(478600001)(4326008)(6506007)(9686003)(64756008)(8676002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uQ1KgHUzRkQvNtORMwYiwg1Ajrm/pZ7Y5+WB/opl2OSVeIZ4HaAsLH12z1YVc+ROfm/REaZRpU80qmnENswSBCvoCfntBmHdXEzKtdU0bio+2drEdDpLbbEPavA3tA2FjSVKnRR4FU9p+lXxocOCbER4yWzjkQoPOPcOYztGlFdfrFDetZ0VX7WsOuohFGpJR68xg6VvsmVwzkT2kPMSOhBNfZ8HWUmtB8j88IQRVj0ld7i8H/yub931cyVKFF7Vreg8FPl9ZFrURZUPMrT7Ar3jJ0Ctwm+v7+b9PyJqo3aoucwkFHo5fL/BuWqZO+Wfkbj8xhmZxXP61SvZFtvoyKCuCSc+zaL+dEKxq7VLPr7EgIGL2/YYSiMMLlEt+1iJY2nCZqrZEMp8J+4qTZQD2CLsCYCFiLBDUC7agaABA6onsdK5ojw3WPID+t/Mp0RoMJKU4dINobci+HzW+cPFFv95l0gWviF07sbCe9/JgUnjVB0vD3jmWBtBz3tsC9eI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7241fa5-54cd-448f-bcb3-08d7fb11e27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 09:57:32.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNbGxSkfACYU93QWTCyKijCe36wbxxLzPBV3aLY1wPsbAGBRdAa8Cl3FGnNKeVJhCZsr8ijRgQ/YURd2bu285Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3945
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IHJlc2V0OiBDb252ZXJ0IGku
TVggcmVzZXQgdG8ganNvbi1zY2hlbWENCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgTWF5IDEyLCAyMDIwIDEwOjIzIEFN
DQo+ID4NCj4gPiBDb252ZXJ0IHRoZSBpLk1YIHJlc2V0IGJpbmRpbmcgdG8gRFQgc2NoZW1hIGZv
cm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1
YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy50eHQgICAgICB8IDQ5IC0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy55YW1sICAg
ICB8IDU4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDU4IGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUNCj4gPiAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnR4
dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvZnNsLGlteC1zcmMueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy50eHQNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy50
eHQNCj4gPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCA2ZWQ3OWU2Li4wMDAw
MDAwDQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L2Zz
bCxpbXgtc3JjLnR4dA0KPiA+ICsrKyAvZGV2L251bGwNCj4gPiBAQCAtMSw0OSArMCwwIEBADQo+
ID4gLUZyZWVzY2FsZSBpLk1YIFN5c3RlbSBSZXNldCBDb250cm9sbGVyDQo+ID4gLT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gLQ0KPiA+IC1QbGVhc2UgYWxzbyBy
ZWZlciB0byByZXNldC50eHQgaW4gdGhpcyBkaXJlY3RvcnkgZm9yIGNvbW1vbiByZXNldA0KPiA+
IC1jb250cm9sbGVyIGJpbmRpbmcgdXNhZ2UuDQo+ID4gLQ0KPiA+IC1SZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KPiA+IC0tIGNvbXBhdGlibGU6IFNob3VsZCBiZSAiZnNsLDxjaGlwPi1zcmMiDQo+ID4g
LS0gcmVnOiBzaG91bGQgYmUgcmVnaXN0ZXIgYmFzZSBhbmQgbGVuZ3RoIGFzIGRvY3VtZW50ZWQg
aW4gdGhlDQo+ID4gLSAgZGF0YXNoZWV0DQo+ID4gLS0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRh
aW4gU1JDIGludGVycnVwdCBhbmQgQ1BVIFdET0cgaW50ZXJydXB0LA0KPiA+IC0gIGluIHRoaXMg
b3JkZXIuDQo+ID4gLS0gI3Jlc2V0LWNlbGxzOiAxLCBzZWUgYmVsb3cNCj4gPiAtDQo+ID4gLWV4
YW1wbGU6DQo+ID4gLQ0KPiA+IC1zcmM6IHNyY0AyMGQ4MDAwIHsNCj4gPiAtICAgICAgICBjb21w
YXRpYmxlID0gImZzbCxpbXg2cS1zcmMiOw0KPiA+IC0gICAgICAgIHJlZyA9IDwweDAyMGQ4MDAw
IDB4NDAwMD47DQo+ID4gLSAgICAgICAgaW50ZXJydXB0cyA9IDwwIDkxIDB4MDQgMCA5NiAweDA0
PjsNCj4gPiAtICAgICAgICAjcmVzZXQtY2VsbHMgPSA8MT47DQo+ID4gLX07DQo+ID4gLQ0KPiA+
IC1TcGVjaWZ5aW5nIHJlc2V0IGxpbmVzIGNvbm5lY3RlZCB0byBJUCBtb2R1bGVzDQo+ID4gLT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiAtDQo+ID4g
LVRoZSBzeXN0ZW0gcmVzZXQgY29udHJvbGxlciBjYW4gYmUgdXNlZCB0byByZXNldCB0aGUgR1BV
LCBWUFUsIC1JUFUsDQo+ID4gYW5kIE9wZW5WRyBJUCBtb2R1bGVzIG9uIGkuTVg1IGFuZCBpLk1Y
NiBJQ3MuIFRob3NlIGRldmljZSAtbm9kZXMNCj4gPiBzaG91bGQgc3BlY2lmeSB0aGUgcmVzZXQg
bGluZSBvbiB0aGUgU1JDIGluIHRoZWlyIHJlc2V0cyAtcHJvcGVydHksDQo+ID4gY29udGFpbmlu
ZyBhIHBoYW5kbGUgdG8gdGhlIFNSQyBkZXZpY2Ugbm9kZSBhbmQgYSAtUkVTRVRfSU5ERVgNCj4g
PiBzcGVjaWZ5aW5nIHdoaWNoIG1vZHVsZSB0byByZXNldCwgYXMgZGVzY3JpYmVkIGluIC1yZXNl
dC50eHQNCj4gPiAtDQo+ID4gLWV4YW1wbGU6DQo+ID4gLQ0KPiA+IC0gICAgICAgIGlwdTE6IGlw
dUAyNDAwMDAwIHsNCj4gPiAtICAgICAgICAgICAgICAgIHJlc2V0cyA9IDwmc3JjIDI+Ow0KPiA+
IC0gICAgICAgIH07DQo+ID4gLSAgICAgICAgaXB1MjogaXB1QDI4MDAwMDAgew0KPiA+IC0gICAg
ICAgICAgICAgICAgcmVzZXRzID0gPCZzcmMgND47DQo+ID4gLSAgICAgICAgfTsNCj4gPiAtDQo+
ID4gLVRoZSBmb2xsb3dpbmcgUkVTRVRfSU5ERVggdmFsdWVzIGFyZSB2YWxpZCBmb3IgaS5NWDU6
DQo+ID4gLUdQVV9SRVNFVCAgICAgMA0KPiA+IC1WUFVfUkVTRVQgICAgIDENCj4gPiAtSVBVMV9S
RVNFVCAgICAyDQo+ID4gLU9QRU5fVkdfUkVTRVQgMw0KPiA+IC1UaGUgZm9sbG93aW5nIGFkZGl0
aW9uYWwgUkVTRVRfSU5ERVggdmFsdWUgaXMgdmFsaWQgZm9yIGkuTVg2Og0KPiA+IC1JUFUyX1JF
U0VUICAgIDQNCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Jlc2V0L2ZzbCxpbXgtc3JjLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwLi4yNzZhNTMzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14LXNyYy55
YW1sDQo+ID4gQEAgLTAsMCArMSw1OCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+
ICt0aXRsZTogRnJlZXNjYWxlIGkuTVggU3lzdGVtIFJlc2V0IENvbnRyb2xsZXINCj4gPiArDQo+
ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRy
b25peC5kZT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhlIHN5c3RlbSBy
ZXNldCBjb250cm9sbGVyIGNhbiBiZSB1c2VkIHRvIHJlc2V0IHRoZSBHUFUsIFZQVSwNCj4gPiAr
ICBJUFUsIGFuZCBPcGVuVkcgSVAgbW9kdWxlcyBvbiBpLk1YNSBhbmQgaS5NWDYgSUNzLiBUaG9z
ZSBkZXZpY2UNCj4gPiArICBub2RlcyBzaG91bGQgc3BlY2lmeSB0aGUgcmVzZXQgbGluZSBvbiB0
aGUgU1JDIGluIHRoZWlyIHJlc2V0cw0KPiA+ICsgIHByb3BlcnR5LCBjb250YWluaW5nIGEgcGhh
bmRsZSB0byB0aGUgU1JDIGRldmljZSBub2RlIGFuZCBhDQo+ID4gKyAgUkVTRVRfSU5ERVggc3Bl
Y2lmeWluZyB3aGljaCBtb2R1bGUgdG8gcmVzZXQsIGFzIGRlc2NyaWJlZCBpbg0KPiA+ICsgIHJl
c2V0LnR4dA0KPiA+ICsNCj4gPiArICBUaGUgZm9sbG93aW5nIFJFU0VUX0lOREVYIHZhbHVlcyBh
cmUgdmFsaWQgZm9yIGkuTVg1Og0KPiA+ICsgICAgR1BVX1JFU0VUICAgICAwDQo+ID4gKyAgICBW
UFVfUkVTRVQgICAgIDENCj4gPiArICAgIElQVTFfUkVTRVQgICAgMg0KPiA+ICsgICAgT1BFTl9W
R19SRVNFVCAzDQo+ID4gKyAgVGhlIGZvbGxvd2luZyBhZGRpdGlvbmFsIFJFU0VUX0lOREVYIHZh
bHVlIGlzIHZhbGlkIGZvciBpLk1YNjoNCj4gPiArICAgIElQVTJfUkVTRVQgICAgNA0KPiA+ICsN
Cj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgaXRlbXM6DQo+
ID4gKyAgICAgIC0gY29uc3Q6ICJmc2wsaW14NTEtc3JjIg0KPiANCj4gV2hhdCBhYm91dCBteDY/
DQoNCldpbGwgYWRkIGFsbCBpLk1YNiBjb21wYXRpYmxlIGFjY29yZGluZyB0byBEVC4NCg0KPiAN
Cj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAg
aW50ZXJydXB0czoNCj4gDQo+IE5lZWQgZGVzY3JpcHRpb24gaGVyZQ0KDQpPSy4NCg0KPiANCj4g
PiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogMg0KPiA+ICsNCj4gPiArICAn
I3Jlc2V0LWNlbGxzJzoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoN
Cj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0K
PiA+ICsgIC0gJyNyZXNldC1jZWxscycNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBzcmNA
NzNmZDAwMDAgew0KPiANCj4gcy9zcmMvcmVzZXQtY29udHJvbGxlcg0KDQpPSy4NCg0KQW5zb24N
Cg==

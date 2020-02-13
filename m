Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E4C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F94921734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TrGCtVI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgBMJSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:18:15 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:52577
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729526AbgBMJSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:18:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce7RXmGxnYJFXSb6byLbeNXq7weZUafKaficMg7QgPLwgqvioonq4x3PqyYyhNJnsLP3PPsTvDBnLUrKxn5Z8AkNYTMG1+x6TTHy8rKPbAw9M4FuMI0Bxqxx1uImzoWgtenqBAywNgXRdGbcIAnYMUVXrrwka2qhklrkxDD5bBLjEh+qTT7xLrPFDyvasOsIOWMNWgurYghZquheieEU5fMn4+Czea+yAI+F+KZKj4XYU9nHJKaNh3yM8xZizXF8WJUDvWRtvNIWj0jfobpCnXnOSVLe+pq7e3D1DlGzxFJcNli3q7aw2JGrg1dIUOe6J7T8ZzyJ1xPGWZI7KiDzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39UQtUx2h5ebjmkJQW49ZE9Pc1d9ojpG/U5Xe7u7xsw=;
 b=EPkvwZJtnVOkn9sFEZNc/Yj2enATO7udMS2zLGylLHWLqd37+Xg2+K4cFlBD7bv/asECVXXFiRo6Qnbp/t8blCWmJcBfjRdgSzjsVLXMco0QIiVLjVQPenpmhMAqEW3MW5LlBuSHmWUDpvVdyXnEPsNH6vVMbdX8SwK78fmNvWGA/vNOvKNwfmlETt2bMCAzCveXcRaI7RuB91LXr/zhEAMZd3NQ+0JBWfT9bzFdbwoZP+G0mz19h+VvGwdB/9pFmoLpqQ4vrLo9mysDS30ZU26svnS9JVTmI1kyHBBEJ0tNecT/DF+Co8d7pVMhg6SsyaQGo2kTF10uqr9YhBqc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39UQtUx2h5ebjmkJQW49ZE9Pc1d9ojpG/U5Xe7u7xsw=;
 b=TrGCtVI3Lx13QDfSNkEFScy/xT2QUsg1kzwTQeB0s4WrGbjuMhWLQApK727UxZDBolw2tkEaHdLh7Qrm1SAQZ0z5f04cX1XGbVfadK1lc/0LRh9k70T8R7P4ikP72hCiGrILAZIJWMNO+TCrHzGcBYvIBwMP0y8X0tS0Chqd5DQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (52.134.71.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 09:18:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 09:18:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6sx: Add missing uart mux function
Thread-Topic: [PATCH] ARM: dts: imx6sx: Add missing uart mux function
Thread-Index: AQHV4jmkBGoJScQ3+kWiDMpfJDDuQ6gYuY4AgAAdYTA=
Date:   Thu, 13 Feb 2020 09:18:10 +0000
Message-ID: <DB3PR0402MB39163A56BF6AA37E3C691964F51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1581576189-20490-1-git-send-email-Anson.Huang@nxp.com>
 <20200213072710.4snwbo3i7vfbroqy@pengutronix.de>
In-Reply-To: <20200213072710.4snwbo3i7vfbroqy@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26b4144a-d991-40ae-8a3d-08d7b065a550
x-ms-traffictypediagnostic: DB3PR0402MB3915:|DB3PR0402MB3915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3915A0046A472F384B7EC34AF51A0@DB3PR0402MB3915.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(199004)(189003)(9686003)(55016002)(5660300002)(52536014)(66946007)(81156014)(186003)(64756008)(76116006)(8676002)(66476007)(66556008)(66446008)(81166006)(54906003)(6916009)(316002)(2906002)(6506007)(33656002)(7416002)(26005)(86362001)(8936002)(478600001)(7696005)(4326008)(71200400001)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b3dS10JGOXV+6H5QOYxC1qRATqYp824SOQmlO/n4fDSVWSjEaQaabqteMHFN7dbXWvBxgWsch8/SpDU5+6/U7IL3pbe/2d+06ofvgAKZYlKHpohcIjgOH13DOQ+zIetozDjZ8oaoiUsWS8oR69vwQYQf9WF0uu3/VxAQc0ziVxzr9vnduw/ZCpjQS5Qoy9LcTR+78LF71xQ+Nf+9zQYOpGxS9aUTPL71FB1zTCJluMPWjXSR+tHv9qAAZEr8SPEp73ccRwokLNg3c+JuG02my1sT0TeX7iQ+tfwBtt1pS4l3WcBpkz8DimJZeUyuJhfF/3szP2Fb/aHZVHxLX8XDZbTHvwyHIVM9g8RgwVcnj+iMjc7RACKBzBBXvEzxBz6UXvzcwCBF9ca+XzWvr3PFBE0gT088oEs6imXQy64xhQEY/HxrWHjxzpHzVN74AVSfs2b2OSehX69hPhgwEyfA/8yttscEvEfBSwbI8Ch+2lOhxRT58Brc+r3gxHArr3AE
x-ms-exchange-antispam-messagedata: N+CfxQ3Acg0U6ybGy4cjXWr48bYgQoYtC0Zn4lTEFRK1YWvWivhg4pzAZAEq7V0AAeYUQDeyQFidmCTBXEx6vALTHN9mftCz0uhsLTzl7NfdzBm4xTcCm5vVyWG2BqawDZvpsscA8YZKXhpJ9HoVDA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b4144a-d991-40ae-8a3d-08d7b065a550
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:18:10.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yXQ3HWCi+G3zJal+Y2oJH/gRBPcFo2Fv1RRS9C+lzh4oLQCOhVJeyyRMCNj21DkdSWci+MudS68atjScfJMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFV3ZQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBpbXg2c3g6IEFkZCBt
aXNzaW5nIHVhcnQgbXV4IGZ1bmN0aW9uDQo+IA0KPiBPbiBUaHUsIEZlYiAxMywgMjAyMCBhdCAw
Mjo0MzowOVBNICswODAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBGcm9tOiBBbnNvbiBIdWFu
ZyA8YjIwNzg4QGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBVcGRhdGUgaS5NWDZTWCBwaW5mdW5j
IGhlYWRlciB0byBhZGQgdWFydCBtdXggZnVuY3Rpb24uDQo+IA0KPiBJJ20gYXdhcmUgeW91IGFk
ZCB0aGUgbWFjcm9zIGluIGEgY29uc2lzdGVudCB3YXkgdG8gdGhlIGFscmVhZHkgZXhpc3RpbmcN
Cj4gc3R1ZmYuIFN0aWxsIEkgdGhpbmsgdGhlcmUgaXMgc29tZXRoaW5nIHRvIGltcHJvdmUgaGVy
ZS4gV2Ugbm93IGhhdmUNCj4gZGVmaW5pdGlvbnMgbGlrZToNCj4gDQo+IAlNWDZTWF9QQURfR1BJ
TzFfSU8wNl9fVUFSVDFfUlRTX0INCj4gCU1YNlNYX1BBRF9HUElPMV9JTzA2X19VQVJUMV9DVFNf
Qg0KPiANCj4gCU1YNlNYX1BBRF9HUElPMV9JTzA3X19VQVJUMV9DVFNfQg0KPiAJTVg2U1hfUEFE
X0dQSU8xX0lPMDdfX1VBUlQxX1JUU19CDQo+IA0KPiB3aGVyZSAoaWdub3Jpbmcgb3RoZXIgcGlu
cyB0aGF0IGNvdWxkIGJlIHVzZWQpIG9ubHkgdGhlIGZvbGxvd2luZw0KPiBjb21iaW5hdGlvbnMg
YXJlIHZhbGlkOg0KPiANCj4gCU1YNlNYX1BBRF9HUElPMV9JTzA0X19VQVJUMV9UWA0KPiAJTVg2
U1hfUEFEX0dQSU8xX0lPMDVfX1VBUlQxX1JYDQo+IAlNWDZTWF9QQURfR1BJTzFfSU8wNl9fVUFS
VDFfUlRTX0INCj4gCU1YNlNYX1BBRF9HUElPMV9JTzA3X19VQVJUMV9DVFNfQg0KPiANCj4gKGlu
IERDRSBtb2RlKSBhbmQNCj4gDQo+IAlNWDZTWF9QQURfR1BJTzFfSU8wNF9fVUFSVDFfUlgNCj4g
CU1YNlNYX1BBRF9HUElPMV9JTzA1X19VQVJUMV9UWA0KPiAJTVg2U1hfUEFEX0dQSU8xX0lPMDZf
X1VBUlQxX0NUU19CDQo+IAlNWDZTWF9QQURfR1BJTzFfSU8wN19fVUFSVDFfUlRTX0INCj4gDQo+
IChpbiBEVEUgbW9kZSkuDQoNCklzIGl0IHBvc3NpYmxlIHRoZSB1c2luZyBiZWxvdyBjb21iaW5h
dGlvbiwgaWYgcG9zc2libGUsIHRoZW4gSSB0aGluayB0aGUgcHJlZml4ICJEVEUvRENFIiBhcmUN
Ck5PVCBpbXBhY3RpbmcgcmVhbCBmdW5jdGlvbnMsIHRoZXkgYXJlIGp1c3QgZGlmZmVyZW50IG5h
bWVzIGZvciBiZXR0ZXIgaWRlbnRpZmljYXRpb246DQoNCk1YNlNYX1BBRF9HUElPMV9JTzA0X19V
QVJUMV9UWA0KTVg2U1hfUEFEX0dQSU8xX0lPMDVfX1VBUlQxX1JYDQpNWDZTWF9QQURfR1BJTzFf
SU8wNl9fVUFSVDFfQ1RTX0INCk1YNlNYX1BBRF9HUElPMV9JTzA3X19VQVJUMV9SVFNfQg0KDQo+
IA0KPiBGb3IgaS5NWDZTTEwsIGkuTVg2VUwsIGlteDZVTEwgYW5kIGkuTVg3IHRoZSBuYW1pbmcg
Y29udmVudGlvbiBpcyBzYW5lciwgYQ0KPiB0eXBpY2FsIGRlZmluaXRpb24gdGhlcmUgaXM6DQo+
IA0KPiAJTVg3RF9QQURfTFBTUl9HUElPMV9JTzA0X19VQVJUNV9EVEVfUlRTDQo+IA0KPiB3aGVy
ZSB0aGUgbmFtZSBpbmNsdWRlcyBEVEUgYW5kIHdoZXJlIGlzIGl0IChtb3JlKSBvYnZpb3VzIHRo
YXQgdGhpcyBjYW5ub3QNCj4gYmUgY29tYmluZWQgd2l0aA0KPiANCj4gCU1YN0RfUEFEX0xQU1Jf
R1BJTzFfSU8wN19fVUFSVDVfRENFX1RYDQo+IA0KPiAuDQo+IA0KPiBJIHN1Z2dlc3QgdG8gYWRh
cHQgdGhlIGxhdHRlciBuYW1pbmcgY29udmVudGlvbiBhbHNvIGZvciB0aGUgb3RoZXIgaS5NWA0K
PiBwaW5mdW5jIGhlYWRlcnMsIHByb2JhYmx5IHdpdGggaW50cm9kdWNpbmcgZGVmaW5lcyBmb3Ig
bm90IGJyZWFraW5nIGV4aXN0aW5nDQo+IGR0cyBmaWxlcy4NCg0KSWYgdG8gaW1wcm92ZSB0aGUg
bmFtZSwganVzdCBjaGFuZ2UgdGhlIGV4aXN0aW5nIGR0cyBmaWxlcyB3aGljaCB1c2UgdGhlbSBz
aG91bGQgYmUgT0ssDQphcyB0aGlzIGhlYWRlciBmaWxlIE9OTFkgdXNlZCBieSBEVCBhbmQgc2hv
dWxkIGJlIG5vIGNvbXBhdGlibGUgaXNzdWVzLiBTbyBzaG91bGQgSQ0KY2hhbmdlIHRoZSBkdHMg
ZmlsZXMgdG9nZXRoZXI/DQoNClRoYW5rcywNCkFuc29uDQoNCg0K

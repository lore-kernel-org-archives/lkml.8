Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDFEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D07207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dtRSM8fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgCFJqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:46:50 -0500
Received: from mail-eopbgr40111.outbound.protection.outlook.com ([40.107.4.111]:51078
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbgCFJqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:46:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnvPHQawvoKpPfFLdx6UO8tcu1B7k8wkKbwp5LfFJ6pzCrTBkJBFRfTrvJON2Q+K86abXubf/UhOhpE0t84hgsJP5HnDqtatZMh913KGAob0Fmoc0sFkkMOPYhHiBvz+h/39MNi19gOnc3nVUlkzUPCkMgw8FrDkaHXk21oBvQ8ipS2876OyZ21HTIVjLs6AggCKJZQcUN4B6IU0e4CMbdOkZwo+RcVtxG6CaMT8xMgonHixAx21uayHFGnT2rUTtmq61d2HzmLzojvz73+5w+Yh0RBzCFZbSxDsCiP9Z7Pq5hikHZ1sLkB19wfTVnP2Vvcx7AQiSvxvEWbkFi4Ruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rScmlI4XLMvsemQZCdFFeyxskqmFoeXVwn/W+wdJPY=;
 b=PjFoKreK3m7uVCZ9D5eai9ccLiEoU9T1n6r52qtCEtmEfbwKigs7q2nIAm34HgqXqpCaeaSIa5x8ptcak1yGSnW+93epAVIi0679G0ND6ffsMZ/TSBwRrNBpAGmexGknsaK0xoqyoRyoTU5MigvPU/tp7vR0uGTI1yA5B0g3AMIPJaRhV2z1GZzj5LEOJUavXo9zx22Jj/LJzYortnheD/v0/vu/0FjK1Pgw38vOO0byUxGkFoX2ZkiVki0WOd7eMy64mGPmbd0Mcc/gtoor1imNXttDoVQ3Wg51pmemBpcGioELDH1WCbqUjNxKD5pEAZbF0SoD4+UoEc80DXV8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rScmlI4XLMvsemQZCdFFeyxskqmFoeXVwn/W+wdJPY=;
 b=dtRSM8fwFjdTYsU7ADEzd9L1JR3FGRV7aXWCG34I42Y1HLrQvq0zX2heDR1t3hoGLp0TK+99W3b+URKkuEyvFpilR/nURKZrTanLLqrR7JgkQYCDOY8A0VHcVx9VUr8SgmS28NEbPDoJYBqVMN7SueYCWlW4cPzoxYVLJ7sAkiM=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB6102.eurprd05.prod.outlook.com (20.179.3.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Fri, 6 Mar 2020 09:46:45 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 09:46:45 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Topic: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Index: AQHV8vTsfP1BktnxKEy+q0EhrXMNZqg6EXKAgAAlWYCAAPjzgIAAIqIA
Date:   Fri, 6 Mar 2020 09:46:45 +0000
Message-ID: <4e48d56f184ed56d15d2ae6706fdb29e4c849132.camel@toradex.com>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
         <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
         <20200305165145.GA25183@lunn.ch>
         <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
In-Reply-To: <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e8547b2-3274-4ff8-d117-08d7c1b34866
x-ms-traffictypediagnostic: AM6PR05MB6102:
x-microsoft-antispam-prvs: <AM6PR05MB6102DC9C9F3EC5172D52D598F4E30@AM6PR05MB6102.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(189003)(199004)(76116006)(44832011)(6512007)(4326008)(110136005)(2616005)(54906003)(71200400001)(66446008)(36756003)(91956017)(64756008)(66556008)(86362001)(316002)(66946007)(66476007)(81156014)(81166006)(8676002)(5660300002)(26005)(7416002)(186003)(6486002)(478600001)(2906002)(53546011)(8936002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB6102;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLiLrTzjFXNd9HcY8W11u+V4bk0J9+VSvGvPfIUjy1iwzzEOsRAAbv9oOyEnHqw6WSacenvXYDjqXI/AYwWBLjco11PdmrtiZPVuZeudCx+YEgfBJjNGoxvzelrlVV7jHerpN5D2sQ+kLG2GnV40V9LlROWBDc8GCsaVleDOl8zs84hCJKJJGDqRe0Og0qV1nH19iS6abP2FmaxOUr6LX9jSAnZ1uydDP+Hjjjp42O3DpkFG/h5JgeLCjU2GtcJEOc+xzNaxZVPtGZE6oOG0/bihDb/2V9PdrDoTTUohv1RrdD0AL96mIzfqEYK52n+UWZhjH0S9omWufz5b8xS202ZUr4MZr7RrJWZikXsfhyJfn2OZ92J+lRvBZxQLfPRBgxNECgjUmc5fISFdbkuSDmn87fDFHiYQ0qVwTKv//0x2lXuWs3e5mdtVIISm7uD3
x-ms-exchange-antispam-messagedata: 4Z+pr5U7LjrJZoKwpQj1+ZV7Ow1sSxB678Gh3wD83hwVlePCejCRie62NbrShkdOtg3OLdmHzQJq9bKUL/rVjTAWD46yYMAWvfUQa9ykw6wsIq0pO7Bo/DDlXICF4v4R+GyR5IZNKOmeGYyrYy6Gxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06986D4805B93044B50C2EA22F62AB35@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8547b2-3274-4ff8-d117-08d7c1b34866
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 09:46:45.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqwb/ZYa33gEpRA8FTnN13WZtvPp4qlhYV5/+KyulWvmQE/GlZr3XlDVVvaL1G50/TAj6uwBwa/lgnV48Rv1/lqvYpoy7GcZsMGAqB+gnCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDA4OjQyICswMTAwLCBBaG1hZCBGYXRvdW0gd3JvdGU6DQo+
IEhlbGxvIEFuZHJldywNCj4gDQo+IE9uIDMvNS8yMCA1OjUxIFBNLCBBbmRyZXcgTHVubiB3cm90
ZToNCj4gPiBPbiBUaHUsIE1hciAwNSwgMjAyMCBhdCAwMzozODowNVBNICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gPiA+IEhpIFBoaWxpcHBlLA0KPiA+ID4gDQo+ID4gPiBPbiBUaHUs
IE1hciAwNSwgMjAyMCBhdCAwMjo0OToyOFBNICswMTAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gPiA+ID4gVGhlIE1BQyBvZiB0aGUgaS5NWDYgU29DIGlzIGNvbXBsaWFudCB3aXRoIFJH
TUlJIHYxLjMuIFRoZQ0KPiA+ID4gPiBLU1o5MTMxIFBIWQ0KPiA+ID4gPiBpcyBsaWtlIEtTWjkw
MzEgYWRoZXJpbmcgdG8gUkdNSUkgdjIuMCBzcGVjaWZpY2F0aW9uLiBUaGlzIG1lYW5zDQo+ID4g
PiA+IHRoZQ0KPiA+ID4gPiBNQUMgc2hvdWxkIHByb3ZpZGUgYSBkZWxheSB0byB0aGUgVFhDIGxp
bmUuIEJlY2F1c2UgdGhlIGkuTVg2DQo+ID4gPiA+IE1BQyBkb2VzDQo+ID4gPiA+IG5vdCBwcm92
aWRlIHRoaXMgZGVsYXkgdGhpcyBoYXMgdG8gYmUgZG9uZSBpbiB0aGUgUEhZLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIGJ5IGRlZmF1bHQgfjEuNm5zIGRlbGF5IHRvIHRoZSBU
WEMgbGluZS4gVGhpcw0KPiA+ID4gPiBzaG91bGQNCj4gPiA+ID4gYmUgZ29vZCBmb3IgYWxsIGJv
YXJkcyB0aGF0IGhhdmUgdGhlIFJHTUlJIHNpZ25hbHMgcm91dGVkIHdpdGgNCj4gPiA+ID4gdGhl
DQo+ID4gPiA+IHNhbWUgbGVuZ3RoLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIEtTWjkxMzEgaGFz
IHJlbGF0aXZlbHkgaGlnaCB0b2xlcmFuY2VzIG9uIHNrZXcgcmVnaXN0ZXJzDQo+ID4gPiA+IGZy
b20NCj4gPiA+ID4gTU1EIDIuNCB0byBNTUQgMi44LiBUaGVyZWZvcmUgdGhlIG5ldyBETEwtYmFz
ZWQgZGVsYXkgb2YgMm5zIGlzDQo+ID4gPiA+IHVzZWQNCj4gPiA+ID4gYW5kIHRoZW4gYXMgbGl0
dGxlIGFzIHBvc3NpYmx5IHN1YnRyYWN0ZWQgZnJvbSB0aGF0IHNvIHdlIGdldA0KPiA+ID4gPiBt
b3JlDQo+ID4gPiA+IGFjY3VyYXRlIGRlbGF5LiBUaGlzIGlzIGFjdHVhbGx5IG5lZWRlZCBiZWNh
dXNlIHRoZSBpLk1YNiBTb0MNCj4gPiA+ID4gaGFzDQo+ID4gPiA+IGFuIGFzeW5jaHJvbiBza2V3
IG9uIFRYQyBmcm9tIC0xMDBwcyB0byA5MDBwcywgdG8gZ2V0IGFsbCBSR01JSQ0KPiA+ID4gPiB2
YWx1ZXMgd2l0aGluIHNwZWMuDQo+ID4gPiANCj4gPiA+IFRoaXMgY29uZmlndXJhdGlvbiBoYXMg
bm90aGluZyB0byBkbyBpbiBtYWNoLWlteC8qIEl0IGJlbG9uZ3MgdG8NCj4gPiA+IHRoZQ0KPiA+
ID4gYm9hcmQgZGV2aWNldHJlZS4gUGxlYXNlIHNlZSBEVCBiaW5kaW5nIGRvY3VtZW50YXRpb24g
Zm9yIG5lZWRlZA0KPiA+ID4gcHJvcGVydGllczoNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvbWljcmVsLWtzejkweDEudHh0DQo+ID4gDQo+ID4gSXQgcHJvYmFi
bHkgZG9lcyBub3QgZXZlbiBuZWVkIHRoYXQuIEp1c3QNCj4gPiANCj4gPiBwaHktbW9kZSA9IDxy
Z21paS10eGlkPg0KPiANCj4gTG9va3MgdG8gbWUgbGlrZSB0aGlzIGlzbid0IHN1cHBvcnRlZCBi
eSB0aGUgTWljcmVsIFBIWSBkcml2ZXIgb3IgYW0NCj4gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4g
DQo+IENoZWVycw0KPiBBaG1hZA0KPiANCkhpIEFuZHJldyBhbmQgQWhtYWQsIHRoYW5rcyBmb3Ig
eW91ciBjb21tZW50cy4gSSB0b3RhbGx5IGZvcmdvdCBhYm91dA0KdGhvc2UgbW9yZSBzcGVjaWZp
YyBwaHktbW9kZXMuIEJ1dCBqdXN0IGJlY2F1c2Ugbm9uZSBvZiBvdXIgZHJpdmVyDQpzdXBwb3J0
cyB0aGF0LiBFaXRoZXIgdGhlIGkuTVg2IGZlYy1kcml2ZXIgYXMgd2VsbCBhcyB0aGUgbWljcmVs
LmMgUEhZDQpkcml2ZXIgc3VwcG9ydHMgdGhpcyB0YWdzLg0KDQpXaGF0IGRvIHlvdSBndXlzIHN1
Z2dlc3QgdGhlbiBob3cgSSBzaG91bGQgaW1wbGVtZW50IHRoYXQgc2tldyBzdHVmZj8NCg0KVGhl
IHByb2JsZW0gaXMgdGhhdCBpLk1YNiBoYXMgYW4gYXN5bmNocm9uaWMgc2tldyBvZiAtMTAwIHRv
IDkwMHBzIG9ubHkNCmVuYWJsaW5nIHRoZSBQSFktZGVsYXkgb24gVFhDIGFuZCBSWEMgaXMgbm90
IGluIGFsbCBjYXNlcyB3aXRoaW4gdGhlDQpSR01JSSB0aW1pbmcgc3BlY3MuIFRoYXQncyB3aHkg
SSBpbXBsZW1lbnRlZCB0aGlzICd3ZWlyZCcgbnVtYmVycy4NCg0KUGhpbGlwcGUNCg==

Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC138C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0362467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VzLqhcP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB1QwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:52:20 -0500
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com ([40.107.21.91]:61409
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbgB1QwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:52:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MStW2V07vuHSt3obiB3lwBi96g+hz/BG/xygsmMNUj9jV0DMA4obH03Amp2rHzgvpzjKN3MERHYMnbwXyCHcr1alLgKnBRR9WiDoqY/Hokf45FJUT3H6cg8bdCnPkBce25u26nzNoT8yT8x+EYtjQBinPk+AIeRfBmXm+5wTEJpY6PJcVgs/Xo9YTFXaeG8IOMDwJLYOs3mE6Rsim2gogt+X/EmGelf3STWwrHPFyq0rTX2yZWvEHy275ZCxByauFtyP1n+a5r5//hnO7ahe4ye3s04rbIckusiHQqgrzWJvBMgXeLphSzTJV6HN44xmTuvloi0e0jIyCgEOJpszmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWLYQ/8UGxRfFX2kz6IiJmXHrxcVCgTMolg1A+Gliwg=;
 b=EU9h8Al/FEv2pBvny2JyWZ5AZOBWrU9XU5pr6PEuBDFs2/S8loLc4zOuRQ2Aa3LFgOSI1/WrQ1o6owaXf7dG+lXQB9aqAE73e618YYyLVph5lmvHgUje0Yhy8xXiUcDsZyRcasJmbn5V0XdgfpCmKN3NeFXisws58cofz/NDM1/w5Rts2CckV0GLpEItHNabEcSwkYYW6e9io/wt/8R56C/1ynrZTsNfo0Rxjj0zWNNG+6Ht3321tt6VKhd7PAhqcb3PW45fy2YSo+RyMOxymi16mjaxtGv53C4Rcl3i7hdxZg2Cr1v32+KUWf0nErnkfl7jno1UPKt8+NmCrJUgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWLYQ/8UGxRfFX2kz6IiJmXHrxcVCgTMolg1A+Gliwg=;
 b=VzLqhcP1SqARvQcGKBKwb6C8COqtw5UdFw7OWhNmW4XK66vGVcC0OLDJjM209iftQAyOFtnhpAk1pCcjU1pujYnyXXqZtMZ/z2t4x66ISW/g9/x0Mq3v10cYN+HmVvyhcEn2sHBj2/5qJLixfH5yqVhmr7BQlr64gVFOiqz7DgQ=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB5566.eurprd05.prod.outlook.com (20.177.203.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Fri, 28 Feb 2020 16:52:16 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 16:52:16 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] arm: dts: vf: toradex: use SPDX-License-Identifier
Thread-Topic: [PATCH v1 3/5] arm: dts: vf: toradex: use
 SPDX-License-Identifier
Thread-Index: AQHV6zhtATEDMdsmbUWxVIV3P3KFSagw2GqA
Date:   Fri, 28 Feb 2020 16:52:15 +0000
Message-ID: <c9eecab5fa2c0ae3228bfcb8350a9f08d431497a.camel@toradex.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
         <1582565548-20627-3-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-3-git-send-email-igor.opaniuk@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.74.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a69a40ac-de89-4dc4-6689-08d7bc6e90f4
x-ms-traffictypediagnostic: VI1PR05MB5566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB55666265D500424C8D99AD3BFBE80@VI1PR05MB5566.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39850400004)(366004)(136003)(376002)(189003)(199004)(5660300002)(2906002)(8936002)(44832011)(110136005)(6512007)(71200400001)(316002)(6486002)(81156014)(81166006)(2616005)(7416002)(36756003)(8676002)(54906003)(86362001)(66556008)(6506007)(4326008)(66476007)(66446008)(66946007)(26005)(91956017)(64756008)(76116006)(478600001)(186003)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5566;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GvH5GSZdVD8bNcxsNvFBftBuBZrp+sfbFYbZHXx4dtcGn44rzhLjSdrhjXUY+mG+GmiJjBrviHSDoAQcpRjoOsdGW6gmfDnwS41wwcTW0txv+NqsMen5GAclNExwlX3KiDeCEazEHnxPIad3aZ1m48M8aphe/QpFM0CiQ4YSwxzZ58d8Xr4voSGK9eBu7Qv8Yi+y9+QHOWS2KKNOTWitZpkKcHQxB2ZcuTXFvsxeYgq+l4N7pQNUEDnlvZrTWpug+m0PLN3sUkWJDLanUaDx1zczCZt1bBn6ozgXp+KnsDrfRbL6IYW/mDT7XJ5+lGwrWwa/kuclCDwmsuhrg8Cmxx9x/t9bCp53nXOLvMaHz6JLIrAjOifNXRyIJlOfleZPru9twi8JjLK1dJeYsxVviEvnou6i5744XoyhWyPmJXhwSNvNt3ND1vod0ZeP7QaKPsf2as2lPWeUN9bIg703uKlT0VtJReVuxK/n5XZbQE=
x-ms-exchange-antispam-messagedata: HaXSwYSdR9E12qYYvtQGDjsMiCa6cGwLRQotljm1h5ATmG1FZ86u2e25szJ+pLOjz2l7ORZLFRFqS0ygDM/oLSif6u24iYNcv5syyMP9ZPc/QMsahKh1tDoFAGUeuHYDmJ+/OzLo6KonRmVsF9ObqA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CE4B1D5C44BE5408AB8C21CD37D82A0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69a40ac-de89-4dc4-6689-08d7bc6e90f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 16:52:15.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +X0zmq7XJOAZhZ+WpC4r05I5eB6I/JAXJd//yEHkrRUH9/iX+mzFUtPUktfYJdkXgm+5Gu1YEUkpIMQpXQtqfn4sJIMO5m9T2F+aQQXdADo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWdvcg0KDQpPbiBNb24sIDIwMjAtMDItMjQgYXQgMTk6MzIgKzAyMDAsIElnb3IgT3Bhbml1
ayB3cm90ZToNCj4gRnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+
DQo+IA0KPiAxLiBSZXBsYWNlIGJvaWxlciBwbGF0ZSBsaWNlbnNlcyB0ZXh0cyB3aXRoIHRoZSBT
UERYIGxpY2Vuc2UNCj4gaWRlbnRpZmllcnMgaW4gVG9yYWRleCBWeWJyaWQtYmFzZWQgU29NIGRl
dmljZSB0cmVlcy4NCj4gMi4gQXMgWDExIGlzIGlkZW50aWNhbCB0byB0aGUgTUlUIExpY2Vuc2Us
IGJ1dCB3aXRoIGFuIGV4dHJhIHNlbnRlbmNlDQo+IHRoYXQgcHJvaGliaXRzIHVzaW5nIHRoZSBj
b3B5cmlnaHQgaG9sZGVycycgbmFtZXMgZm9yIGFkdmVydGlzaW5nIG9yDQo+IHByb21vdGlvbmFs
IHB1cnBvc2VzIHdpdGhvdXQgd3JpdHRlbiBwZXJtaXNzaW9uLCB1c2UgTUlUIGxpY2Vuc2UNCj4g
aW5zdGVhZA0KPiBvZiBYMTEgKCdzL1gxMS9NSVQvZycpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+DQo+IC0tLQ0KPiANCj4gIGFy
Y2gvYXJtL2Jvb3QvZHRzL3ZmLWNvbGlicmktZXZhbC12My5kdHNpICAgfCA0MCArKy0tLS0tLS0t
LS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3ZmLWNvbGlicmku
ZHRzaSAgICAgICAgICAgfCAzOSArKy0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvdmY1MDAtY29saWJyaS1ldmFsLXYzLmR0cyB8IDQwICsrLS0tLS0t
LS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdmY1MDAtY29s
aWJyaS5kdHNpICAgICAgICB8IDQwICsrLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0K
PiAgYXJjaC9hcm0vYm9vdC9kdHMvdmY2MTAtY29saWJyaS1ldmFsLXYzLmR0cyB8IDQwICsrLS0t
LS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdmY2MTAt
Y29saWJyaS5kdHNpICAgICAgICB8IDQwICsrLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0t
LQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdmY2MTBtNC1jb2xpYnJpLmR0cyAgICAgICB8IDM5ICst
LS0tLS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKyksIDI2NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy92Zi1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L3ZmLWNvbGlicmktZXZhbC12My5kdHNpDQo+IGluZGV4IGUyZGExMjIuLmJkNzUyMTEgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3ZmLWNvbGlicmktZXZhbC12My5kdHNpDQo+ICsr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3ZmLWNvbGlicmktZXZhbC12My5kdHNpDQo+IEBAIC0xLDQy
ICsxLDYgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wIE9SIE1JVA0K
DQpVc2UgR1BMLTIuMCsgT1IgTUlULg0KDQo+ICAvKg0KPiAtICogQ29weXJpZ2h0IDIwMTQgVG9y
YWRleCBBRw0KPiAtICoNCj4gLSAqIFRoaXMgZmlsZSBpcyBkdWFsLWxpY2Vuc2VkOiB5b3UgY2Fu
IHVzZSBpdCBlaXRoZXIgdW5kZXIgdGhlIHRlcm1zDQo+IC0gKiBvZiB0aGUgR1BMIG9yIHRoZSBY
MTEgbGljZW5zZSwgYXQgeW91ciBvcHRpb24uIE5vdGUgdGhhdCB0aGlzDQo+IGR1YWwNCj4gLSAq
IGxpY2Vuc2luZyBvbmx5IGFwcGxpZXMgdG8gdGhpcyBmaWxlLCBhbmQgbm90IHRoaXMgcHJvamVj
dCBhcyBhDQo+IC0gKiB3aG9sZS4NCj4gLSAqDQo+IC0gKiAgYSkgVGhpcyBmaWxlIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcg0KPiAtICogICAgIG1vZGlm
eSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlDQo+
IC0gKiAgICAgdmVyc2lvbiAyIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3Vu
ZGF0aW9uLg0KPiAtICoNCj4gLSAqICAgICBUaGlzIGZpbGUgaXMgZGlzdHJpYnV0ZWQgaW4gdGhl
IGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4gLSAqICAgICBidXQgV0lUSE9VVCBBTlkg
V0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eQ0KPiBvZg0KPiAtICog
ICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZSB0aGUNCj4gLSAqICAgICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBk
ZXRhaWxzLg0KPiAtICoNCj4gLSAqIE9yLCBhbHRlcm5hdGl2ZWx5LA0KPiAtICoNCj4gLSAqICBi
KSBQZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBl
cnNvbg0KPiAtICogICAgIG9idGFpbmluZyBhIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNz
b2NpYXRlZA0KPiBkb2N1bWVudGF0aW9uDQo+IC0gKiAgICAgZmlsZXMgKHRoZSAiU29mdHdhcmUi
KSwgdG8gZGVhbCBpbiB0aGUgU29mdHdhcmUgd2l0aG91dA0KPiAtICogICAgIHJlc3RyaWN0aW9u
LCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uIHRoZSByaWdodHMgdG8gdXNlLA0KPiAtICog
ICAgIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2Us
IGFuZC9vcg0KPiAtICogICAgIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBl
cm1pdCBwZXJzb25zIHRvIHdob20NCj4gdGhlDQo+IC0gKiAgICAgU29mdHdhcmUgaXMgZnVybmlz
aGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcNCj4gLSAqICAgICBjb25kaXRp
b25zOg0KPiAtICoNCj4gLSAqICAgICBUaGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhp
cyBwZXJtaXNzaW9uIG5vdGljZSBzaGFsbA0KPiBiZQ0KPiAtICogICAgIGluY2x1ZGVkIGluIGFs
bCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlDQo+IFNvZnR3YXJlLg0KPiAt
ICoNCj4gLSAqICAgICBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBX
QVJSQU5UWSBPRiBBTlkNCj4gS0lORCwNCj4gLSAqICAgICBFWFBSRVNTIE9SIElNUExJRUQsIElO
Q0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8gVEhFDQo+IFdBUlJBTlRJRVMNCj4gLSAqICAgICBP
RiBNRVJDSEFOVEFCSUxJVFksIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORA0K
PiAtICogICAgIE5PTklORlJJTkdFTUVOVC4gSU4gTk8gRVZFTlQgU0hBTEwgVEhFIEFVVEhPUlMg
T1IgQ09QWVJJR0hUDQo+IC0gKiAgICAgSE9MREVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwg
REFNQUdFUyBPUiBPVEhFUiBMSUFCSUxJVFksDQo+IC0gKiAgICAgV0hFVEhFUiBJTiBBTiBBQ1RJ
T04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HDQo+IC0gKiAgICAgRlJP
TSwgT1VUIE9GIE9SIElOIENPTk5FQ1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSBP
Ug0KPiAtICogICAgIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4NCj4gKyAqIENvcHly
aWdodCAyMDE0LTIwMjAgVG9yYWRleCBBRw0KDQpBbmQgZHJvcCB0aGUgQUcuDQoNCkRpdG8gZm9y
IG90aGVyIGZpbGVzLg0KDQpUaGFua3MhDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

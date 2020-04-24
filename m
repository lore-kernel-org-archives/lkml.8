Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0395AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3FE2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="noDwsAoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDXC1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:27:11 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6083
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbgDXC1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:27:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4jaj/iCpsZ5Hqz3ZkENkQtKUC8/aDYuxOiChC5S5D0eRfBHaydUhHj6yVDNB70A6qWtnYIlJ2jnPcfJIM0yzTWk5Ah3pca2G+W+v633RQ4MpE4rc1SGvRJ+XyaqdKNFBQabAy/2GNZyw4Rb4PZADTsalW2bJK3qkGgnZZ1RWg48Y14PlUv0LAhyoylP3fLVB/1TOo9UZfTdUjPVwqdUDY0cm3FjoSs9KD0jcd58HVr9dOHB10q7alIeW3qXUxBqGpT/yA5+3RQZ5gC9KMKaYqOq1FqhZI1Dqpid7AdAYMBN2iNT2dGloMVUS1lcNmqqpgfN+tcqEZD3pJzCH4asSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHyEBYvH+gKg6lCQ8nJ70p4EWcyd4SPmag2QP66CIjE=;
 b=D3yyzkWIEgTmneKXtTE831SkvNlXG+97DWB3Ddnp95sg5a6+Okmf2bom0z7KxA9aH4/6mA5erJuyklTn4hs6iaZHzTZYAStttOFnOpRLl+rCovhr5XpeJGsbMxhVuuc0BEZoYFg+C8MifQedvZFys+pdAsI2NZnTyYgCnBRFZEOiCqgEAcmWYVG+qgF10Q6B5hUH63DAs66ncFQVMHYt6Z/ij8pEPBQbKE8wgTqpNQRyCNDeNk1ZO0ZchG4wIdva4YoHNS6wC+VPggOn0KeVan2k/MwR9rV8Rv247ZpKQxNCEh7LZDOSJ/PYbsxBTSxMUYH8cjhcibbjhG33tLUcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHyEBYvH+gKg6lCQ8nJ70p4EWcyd4SPmag2QP66CIjE=;
 b=noDwsAoq8FYOTITglk04YQ2x6eAvWlk6yt7k6cDH3MgGb7qgVPJrXrtmtlDQ8LKVW5eLMfBZdRw4VRS8Hs2DbXjvCDhjvRNE2brouvvLnZxGovma3cukIgx3r9Yq3NgQpK7FbhaGWUMURtn0nNYJDrJuY82wqpnLbfEygy0Mq9U=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6439.eurprd04.prod.outlook.com (2603:10a6:20b:d8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 02:27:05 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 02:27:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
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
Thread-Index: AQHWGcRIgrxdUkc8WEWRmowVEyQEl6iHi5TQ
Date:   Fri, 24 Apr 2020 02:27:05 +0000
Message-ID: <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d33d994-4d81-41ac-246a-08d7e7f6fb26
x-ms-traffictypediagnostic: AM6PR04MB6439:|AM6PR04MB6439:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6439285793C3F1D26731A6AF80D00@AM6PR04MB6439.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(7696005)(316002)(15650500001)(26005)(8676002)(8936002)(81156014)(186003)(110136005)(478600001)(44832011)(6506007)(2906002)(64756008)(66556008)(76116006)(9686003)(66446008)(66476007)(4326008)(66946007)(55016002)(33656002)(52536014)(5660300002)(86362001)(71200400001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pB+KBOBaZvfP7EzdKNemiyIsB9zly9q2egt000MKIreFCJh5Tec1LO0kJRgveu7VNxTxXYJISLQYI4D7irmSxkqRS93VikXsDUDowCExI9m6oBri1fzCwBl8TpEM+eU0lqVNaqPU5ZtorWIFfpsiEW5hNCwTIuaHAwkMwSbhKYyhkc4f3wqp8Kp+RNVczxrjDNMC1Lr7LFnUJxYLWxpLFpvyFbs+Pwu0sb6424+5sRIHUXhENWJ/mrSpy6vyqn7tw2yJcBwv5BKitusdvy4vWRMKHKdBjR23NV/jJu+jlhOL0pT6ymI/CsGuh+H3MMFZaixDTLKlouPapW9MBgAAPCkQnx/LUtWZwW+euU/P3G0waAPJAmb8A/dUBHmvffTe9gI1DUZsukdnY4X+/0YGFgBsBhN68AIFAk66TkoQh0XePt8XIkoVImwrU07eD8WG
x-ms-exchange-antispam-messagedata: uxJxI9plfMMIaR86zwFCTlZy7NT3OtEG5FxQmnz1jmO4nxh+r5qT7dWHug1FNHN4sJK+S7gLu/8Ylh34h0bYkij0cSoFS37OrjhnzmbZgc+6w0iglkwaBWDzi6MISYUM9Bo9CQzqv1/9zPt8kXopZw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d33d994-4d81-41ac-246a-08d7e7f6fb26
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:27:05.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbvZbKSUv0Hgryw8EOHYFRgrEDMzDydTHys3Xh/LCSAsL3yzJ0mZ/XIZ+Ft4mYW/l2CV/nrPENPb9LBRGT9cnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAyNCwgMjAyMCA3OjAxIEFNDQo+IA0KPiBGb3IgIm1lbSIgbW9kZSBzdXNwZW5kIG9u
IGkuTVg4IFNvQ3MsIE1VIHNldHRpbmdzIGNvdWxkIGJlIGxvc3QgYmVjYXVzZSBpdHMNCj4gcG93
ZXIgaXMgb2ZmLCBzbyBzYXZlL3Jlc3RvcmUgaXMgbmVlZGVkIGZvciBNVSBzZXR0aW5ncyBkdXJp
bmcgc3VzcGVuZC9yZXN1bWUuDQo+IEhvd2V2ZXIsIHRoZSByZXN0b3JlIGNhbiBPTkxZIGJlIGRv
bmUgd2hlbiBNVSBzZXR0aW5ncyBhcmUgYWN0dWFsbHkgbG9zdCwgZm9yDQo+IHRoZSBzY2VuYXJp
byBvZiBzZXR0aW5ncyBOT1QgbG9zdCBpbiAiZnJlZXplIiBtb2RlIHN1c3BlbmQsIHNpbmNlIHRo
ZXJlIGNvdWxkIGJlDQo+IHN0aWxsIElQQyBnb2luZyBvbiBtdWx0aXBsZSBDUFVzLCByZXN0b3Jp
bmcgdGhlIE1VIHNldHRpbmdzIGNvdWxkIG92ZXJ3cml0ZSB0aGUNCj4gVElFIGJ5IG1pc3Rha2Ug
YW5kIGNhdXNlIHN5c3RlbSBmcmVlemUsIHNvIG5lZWQgdG8gbWFrZSBzdXJlIE9OTFkgcmVzdG9y
ZSB0aGUNCj4gTVUgc2V0dGluZ3Mgd2hlbiBpdCBpcyBwb3dlcmVkIG9mZi4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KDQpBcyBtZW50aW9u
ZWQgYmVmb3JlLCB3ZSdkIGJldHRlciBrZWVwIHRoZSBvcmlnaW5hbCBhdXRob3IuDQoNCj4gLS0t
DQo+ICBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyB8IDM1DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIGIvZHJp
dmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gaW5kZXggOTdiZjBhYy4uYjUzY2Y2MyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gKysrIGIvZHJpdmVy
cy9tYWlsYm94L2lteC1tYWlsYm94LmMNCj4gQEAgLTY3LDYgKzY3LDggQEAgc3RydWN0IGlteF9t
dV9wcml2IHsNCj4gIAlzdHJ1Y3QgY2xrCQkqY2xrOw0KPiAgCWludAkJCWlycTsNCj4gDQo+ICsJ
dTMyIHhjcjsNCj4gKw0KPiAgCWJvb2wJCQlzaWRlX2I7DQo+ICB9Ow0KPiANCj4gQEAgLTU4Mywx
MiArNTg1LDQ1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9tdV9kdF9p
ZHNbXSA9DQo+IHsgIH07ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfbXVfZHRfaWRzKTsN
Cj4gDQo+ICtzdGF0aWMgaW50IGlteF9tdV9zdXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRl
dikgew0KPiArCXN0cnVjdCBpbXhfbXVfcHJpdiAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiArDQo+ICsJcHJpdi0+eGNyID0gaW14X211X3JlYWQocHJpdiwgcHJpdi0+ZGNmZy0+eENS
KTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGlteF9tdV9y
ZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ICsJc3RydWN0IGlteF9tdV9wcml2
ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwkvKg0KPiArCSAqIE9OTFkg
cmVzdG9yZSBNVSB3aGVuIGNvbnRleHQgbG9zdCwgdGhlIFRJRSBjb3VsZA0KPiArCSAqIGJlIHNl
dCBkdXJpbmcgbm9pcnEgcmVzdW1lIGFzIHRoZXJlIGlzIE1VIGRhdGENCj4gKwkgKiBjb21tdW5p
Y2F0aW9uIGdvaW5nIG9uLCBhbmQgcmVzdG9yZSB0aGUgc2F2ZWQNCj4gKwkgKiB2YWx1ZSB3aWxs
IG92ZXJ3cml0ZSB0aGUgVElFIGFuZCBjYXVzZSBNVSBkYXRhDQo+ICsJICogc2VuZCBmYWlsZWQs
IG1heSBsZWFkIHRvIHN5c3RlbSBmcmVlemUuIFRoaXMgaXNzdWUNCj4gKwkgKiBpcyBvYnNlcnZl
ZCBieSB0ZXN0aW5nIGZyZWV6ZSBtb2RlIHN1c3BlbmQuDQo+ICsJICovDQo+ICsJaWYgKCFpbXhf
bXVfcmVhZChwcml2LCBwcml2LT5kY2ZnLT54Q1IpKQ0KPiArCQlpbXhfbXVfd3JpdGUocHJpdiwg
cHJpdi0+eGNyLCBwcml2LT5kY2ZnLT54Q1IpOw0KDQpUaGlzIGNvdWxkIGJlIHNlcGFyYXRlIHBh
dGNoIGlmIGl0IGFpbXMgdG8gZml4IGEgc3BlY2lmaWMgY29ybmVyIGNhc2UuDQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgZGV2X3BtX29wcyBpbXhfbXVfcG1fb3BzID0gew0KPiArCVNFVF9OT0lSUV9TWVNU
RU1fU0xFRVBfUE1fT1BTKGlteF9tdV9zdXNwZW5kX25vaXJxLA0KPiArCQkJCSAgICAgIGlteF9t
dV9yZXN1bWVfbm9pcnEpDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2Ry
aXZlciBpbXhfbXVfZHJpdmVyID0gew0KPiAgCS5wcm9iZQkJPSBpbXhfbXVfcHJvYmUsDQo+ICAJ
LnJlbW92ZQkJPSBpbXhfbXVfcmVtb3ZlLA0KPiAgCS5kcml2ZXIgPSB7DQo+ICAJCS5uYW1lCT0g
ImlteF9tdSIsDQo+ICAJCS5vZl9tYXRjaF90YWJsZSA9IGlteF9tdV9kdF9pZHMsDQo+ICsJCS5w
bSA9ICZpbXhfbXVfcG1fb3BzLA0KPiAgCX0sDQo+ICB9Ow0KPiAgbW9kdWxlX3BsYXRmb3JtX2Ry
aXZlcihpbXhfbXVfZHJpdmVyKTsNCj4gLS0NCj4gMi43LjQNCg0K

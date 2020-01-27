Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B88BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA78217BA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 13:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R51faMw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA0NW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:22:58 -0500
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:45962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgA0NW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:22:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+aJVzmoQipPL31NcLsh8UsgJwMEdrxofAwVG1K8bDOG41r7yJwOQlwRy7x3E6n4TKiRwdxYHGNiBITTJ7OO/zFcXf7gqB9ClDcS/+5fVn/K45j2Ub/MKA1EaFo2LgocGBm5GzmOdgg4n/D3oTY0GltHKgkpAyopzhLBWgs8kTCOLKKOQQqIBW7QHQE+x2TwLuETIFC/iwnaNxCeyZWqQLlndDxlN6XGohio7HM7dCUox+xxFpuXRHOBUo6shE+a2hilvC9rmQhstZAI5qeSzgk1l2l8nZWFb0WqPmw8GkKslMVSMUcUZcE3tL5eLY5o5odaYDWagjJxVfCDl4MQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxMIAojZu43RRmkYhgJxTBK9QzwwhpLoDoSU4tY1GHY=;
 b=SUIwa8J0KrDPhK05s2EhfLE8FhUMrFT+Ep5NM9F0Yw1FI94Xb7AXp64jyJnSsJhNJw/2p4IWZE07MQ/UpsjLcJRhR7uilbE7KdtscJ9PRIJBHxCZc1LZMssqihZUw/kftv9UEU66pXgb+e0S4ZJ/4d2H8eusxaVoGQE9qNIG9Oy8RJDuoOK7r1QEpvsRmUfB1xvUzQtVaWlkhrgwKE2ekqFUrpN9xeXK7GdwvyKlDiH4PwQEFY1Vs6c0zNQuGU4+RshpdZN8iZod1l/Jcbsb+6RIQwlwXzBwq0b8PMsgKjMKVFQ5fvSEDbQYsSf4P3GNE+s4TZeJd6DI4AKO24aV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxMIAojZu43RRmkYhgJxTBK9QzwwhpLoDoSU4tY1GHY=;
 b=R51faMw8oG6/ThzDEawqodkncsl7pHE6Vds5mCc1fM23tWOaQPZm8hp0RZq7ZEwVzs8LF1AF3pXv4x0NOE2rrdiMnHmdFT/hwijcZ2O7DIjw1Gapwid2Zkt+fUDD7EOGK6awA4srT4xVjfC6e9QhjbElwQhXgwcAHyFf25sX/cA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7121.eurprd04.prod.outlook.com (10.186.130.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 13:22:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 13:22:54 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Topic: [PATCH V2 0/5] soc: imx: increase build coverage for imx8 soc
 driver
Thread-Index: AQHV1PZk+mGdzzCjckexq+nG+OcySqf+VfQAgAAbviCAAAtGAIAAAVtA
Date:   Mon, 27 Jan 2020 13:22:54 +0000
Message-ID: <AM0PR04MB4481724FC5F8345502860B08880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580117979-4629-1-git-send-email-peng.fan@nxp.com>
 <CAK8P3a2YLo4rNBXu9NhvKv6QOFUcZhCVXNR4XJe_0Kc_RJ=ubA@mail.gmail.com>
 <AM0PR04MB4481E1AACAC4285D49E721AD880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAK8P3a30vieqOdend-o+_1AesAQCN97cW6KtQmAgV3uhDWi_jw@mail.gmail.com>
In-Reply-To: <CAK8P3a30vieqOdend-o+_1AesAQCN97cW6KtQmAgV3uhDWi_jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c203ab9d-ba29-4168-e377-08d7a32c048f
x-ms-traffictypediagnostic: AM0PR04MB7121:|AM0PR04MB7121:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7121320F450199558DD2DF5A880B0@AM0PR04MB7121.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(6916009)(8676002)(66476007)(5660300002)(86362001)(186003)(66946007)(66446008)(64756008)(44832011)(8936002)(66556008)(54906003)(7416002)(7696005)(4326008)(76116006)(81156014)(316002)(9686003)(55016002)(26005)(53546011)(33656002)(71200400001)(478600001)(6506007)(52536014)(2906002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7121;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Jei/WM6JTS1JvAQnyNDE7p5hvC4A6/mjv1mLiqcoHzDuiZVSDGEnpc0ZhJHHI40TgQf4YjRkiYtB+VvvYKf0VYE8offFER+6ebHp0KSS8+oXZ5oHKL8+hwwoEQUQEQFUY9vCOfTySJ9ENtxlX+me0A84z3EpkODypFST8LaEVp3Y+mvrHE63CjjxZvi3UTqhKVUPbgn3TgNHqcEIhJ1L8lSjClVF9woJMgLOSs6OJpdXIlvYCerJGQUOfWHR6YKn+g+zMvYkXWZk6u/N0D4VyFsg/ssJuoLfpKL8c5yBUMBm0eh2HObwjiJ1AzTilpKZyTBfcyF2uqrMGqKqZFcZl+snuhtCcmM+D1sZbsvv9va0IHWbQ2FRNgJMmgzcDPWhoDcKMdB5d/mlidMsUGes3eQhbbpXO1lejgPUOERlnQLYaDcmzwVSFF48LzHBS/d
x-ms-exchange-antispam-messagedata: 7Mn8HQtmYXS/AVMHAHhfHEi3atNLgB5WD/fOs71hhl39p25ss8Di4I4FvnNp8PE4smw8ToAVuVxyS+LJpr67BtrZs7DO4kwXquFHcmavwlLSrjzXSc8CDcESwZoSel8sSrM/rZypaokh00i8tNydeQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c203ab9d-ba29-4168-e377-08d7a32c048f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 13:22:54.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpLzGa563Yq45H3T0ZzSjodhDHs/MNBQG8HSN66/GUEJH6eYblr6pFkIVI+0Mx/5EbQBamYvwtc+rucvxrJMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvNV0gc29jOiBpbXg6IGluY3JlYXNlIGJ1aWxkIGNv
dmVyYWdlIGZvciBpbXg4IHNvYw0KPiBkcml2ZXINCj4gDQo+IE9uIE1vbiwgSmFuIDI3LCAyMDIw
IGF0IDE6MzMgUE0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
SGkgQXJuZCwNCj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAwLzVdIHNvYzogaW14
OiBpbmNyZWFzZSBidWlsZCBjb3ZlcmFnZSBmb3INCj4gPiA+IGlteDggc29jIGRyaXZlcg0KPiA+
ID4NCj4gPiA+IE9uIE1vbiwgSmFuIDI3LCAyMDIwIGF0IDEwOjQ0IEFNIFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBl
bmcuZmFuQG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFYyOg0KPiA+ID4gPiAg
SW5jbHVkZSBMZW9uYXJkJ3MgcGF0Y2ggdG8gZml4IGJ1aWxkIGJyZWFrIGFmdGVyIGVuYWJsZSBj
b21waWxlDQo+ID4gPiA+IHRlc3QgQWRkIExlb25hcmQncyBSLWIgdGFnDQo+ID4gPiA+DQo+ID4g
PiA+IFJlbmFtZSBzb2MtaW14OC5jIHRvIHNvYy1pbXg4bS5jIHdoaWNoIGlzIGZvciBpLk1YOE0g
ZmFtaWx5IEFkZA0KPiA+ID4gPiBTT0NfSU1YOE0gZm9yIGJ1aWxkIGdhdGUgc29jLWlteDhtLmMg
SW5jcmVhc2UgYnVpbGQgY292ZXJhZ2UgZm9yDQo+ID4gPiA+IGkuTVggU29DIGRyaXZlcg0KPiA+
ID4NCj4gPiA+IFRoZSBjaGFuZ2VzIGFsbCBsb29rIGdvb2QgdG8gbWUsIGJ1dCBJJ2QganVzdCBk
byBpdCBhbGwgaW4gb25lDQo+ID4gPiBjb21iaW5lZCBwYXRjaCwgYXMgdGhlIGNoYW5nZXMgYXJl
IGFsbCBsb2dpY2FsbHkgcGFydCBvZiB0aGUgc2FtZQ0KPiA+ID4gdGhpbmcuIFlvdSBjYW4gbGVh
dmUgTGVvbmFyZCdzIGZpeCBhcyBhIFtQQVRDSCAxLzJdICBpZiB5b3Ugd2FudCwgYnV0IHRoZQ0K
PiByZXN0IHNob3VsZCBjbGVhcmx5IGJlIGEgc2luZ2xlIGNoYW5nZS4NCj4gPg0KPiA+IFRoZXJl
IGlzIGEgYXJtNjQgZGVmY29uZmlnIGNoYW5nZSwgc2hvdWxkIGl0IGJlIGFsc28gaW5jbHVkZWQg
aW4gdGhlIHNpbmdsZQ0KPiBjaGFuZ2U/DQo+IA0KPiBHb29kIHBvaW50LCB0aGF0IG9uZSBpcyBw
cm9iYWJseSBiZXR0ZXIgbGVmdCBzZXBhcmF0ZSBpbmRlZWQuDQoNClNpbmNlIHRoZSBkZWZjb25m
aWcgY2hhbmdlIG5lZWRzIHN0YXkgYWxvbmUgaW4gYSBwYXRjaCwNCm1lcmdlIG90aGVyIHBhdGNo
ZXMgaW50byBvbmUgbWlnaHQgbm90IGJlIGdvb2QuIFRoZSBwYXRjaHNldA0KSSBkaWQgaXMgdG8g
bWFrZSBzdXJlIHRoZSBzb2MtaW14OG0uYyBjb3VsZCBhbHdheXMgYmUgYnVpbHQuIElmDQpJIG1l
cmdlIHRoZSBvdGhlcnMgaW50byBvbmUsIHdpdGhvdXQgdGhlIGRlZmNvbmZpZyBwYXRjaCBzZXQg
Q09ORklHDQpvcHRpb24gdG8geSwgc29jLWlteDhtLmMgd2lsbCBub3QgYmUgYnVpbHQuIFRoaXMg
bWlnaHQgYnJlYWsgZ2l0IGJpc2VjdA0KdG8gY2hlY2sgdGhlIHNvYy1pbXg4bS5jDQoNClNvIEkg
cHJlZmVyIG5vdCB0byBtZXJnZSB0aGUgb3RoZXJzIGludG8gb25lIHBhdGNoLiBEbyB5b3UgYWdy
ZWU/DQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+ICAgICAgIEFybmQNCg==

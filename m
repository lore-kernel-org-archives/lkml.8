Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8AC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FBD20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fClpkkAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgCPGbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:31:35 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:51854
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729381AbgCPGbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:31:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqR8waHcN+u0owd0rLZtcGFz45jnECP7rl8nTun4XB1zbD07C9JVzHp1aJBTZpiwibOvP2pb4YN6IUMwA/yfY9SkhRdAnK9q+59cqJ5UZGaB1YKNB7uVhLN0IFtxLy8joqG7PjjMhMmw1+0wJznIO9BTdddnzHcapIoKgxHQSwueCxGIxgmyoaSicILHGksAMIb6kcBYe2fL6ACzbpqsRKntADNzah5HnPcApVlBIf0M4aRycBbV+A9ENZ97xgMZNqYqcROlxJAbqK7fSFtM8mYLq3emtgNyDwO4mlMU7UO8DVRYlIb8OisQ48KACtISZCNYd53uq5BHLucMSk5CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjws3a9134Qnb0izpZ03iZAL20gLA1TvGePcAttjQDM=;
 b=NV60EDVyklVJQG5ckjZ734TRWsrdBqIvt13EN75zfKtNoBvOqfvNYjxafv5sagCHgYdvJD53XBGgO+8gHZDk7N1ctmdSERwPcICxsSpNeHy+DHS8RQUhqMwaIr5q086XZmyuY02WhiP5iVuqMVOO26BPvORXYujHjc0IvS6UlHFjlEmxjavqFyAWAXmqKvhOZi3Fak1apbFbHZVMctokRVkM45vGQGgupT0c+JMdNEzviEIURXCv0Cmrl3Zyn0Y9HdBbPxfJM+5se8Y7gNlsAGus56RAmw4dgA6vt52SOD50M5oBv2JM7sTJridEFZEQ/CSi6dK7ZWKUALorYLednQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjws3a9134Qnb0izpZ03iZAL20gLA1TvGePcAttjQDM=;
 b=fClpkkAh7RHQ23wL4KQgutgxJhNdPjI3YRMgqEUKoWhyPj6p70Kgy/55eZcsHjexS0SuLGVH+YcRtmcLaJ42MWjXk86M/w6cxi6Pd5gJzlwLihKpLUz/54hiTYKo1OGbaOF9FnloYKiR0a2OO4BxHSganVlFCpz6eRwFNeKSkrw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Mon, 16 Mar 2020 06:31:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 06:31:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Thread-Topic: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Thread-Index: AQHV+zLk/B9B6rSt+kytjJn72vnzQ6hKufmAgAAIHNA=
Date:   Mon, 16 Mar 2020 06:31:21 +0000
Message-ID: <DB3PR0402MB3916C7F4D25024A30FF4EABDF5F90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
 <20200316060024.GG17221@dragon>
In-Reply-To: <20200316060024.GG17221@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 336e48fc-4fd9-4b04-ba47-08d7c973a4b1
x-ms-traffictypediagnostic: DB3PR0402MB3867:|DB3PR0402MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3867DE882FD79B397CD6540DF5F90@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(76116006)(9686003)(64756008)(66476007)(55016002)(66946007)(66446008)(66556008)(81166006)(8676002)(33656002)(44832011)(81156014)(26005)(186003)(8936002)(7696005)(54906003)(71200400001)(316002)(6506007)(478600001)(4326008)(52536014)(5660300002)(2906002)(86362001)(6916009)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zHeZaIdAeG4stka3oyfdun+MrPn1RdJTJyQ8JBYeIxRq9w+wGI3q7o/rBQaJ+NML7EMkmIgHl5ToU3ZLFcYqmqqrV8vxUzyCxdfA5lLvfCEFZZS2UN5zav1llw2dlWYJQx1mKfmEyb5Bx95v55PiPEYhBSBYu/Oj5tEHdNs7zLXOF7bfsFEh3PfZtF71tklGOuAOPcSAmxPhSnddGUmJTgx/jTfj9yQeRh8g0Eyrcl516N+nsGAi63fOoM8exdImj49HdPspXrH09HWCCfbXgrUms1H8DgMasXw1tftGTTOZJZat/1XsRBlD6tQDVbrwPP/aRNNKNrC7FPOccK6a4TywybigIXl6lssKaq7DYjmwxKvan9K3hqTBvdhSMeMK4IJNCip3r3ktqwmd74cwyINDIYXihpFVu3lWzp8gNmh5F4JPFhqk/J0eDdAFi9NOTWG1mqFcjsvaMtyoEhLY96h1xjUzFyHY2tfQ4jTBrxhqXGl7tbvA9lyTgBtjP/eRpP97qC9MwfmZY4A3HlQuAw==
x-ms-exchange-antispam-messagedata: gSTEjttzZKLpamMJXGsWuKKL6ggXN62JcVDKjwDSyTU6PltDVM9ng6L6Lw/0urqQ5NHLsAee0N5tzStRp5HmHNqZ45dccnVmjUwx7JEa949GMXkDz8KsrP7985kuKIComwGoCT0gZjJM4xMMvskElA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336e48fc-4fd9-4b04-ba47-08d7c973a4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 06:31:21.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kwoCqYRy1p7iGYGQgLVGAW90MyXVpz09VQWaWpMAmhAQn5TpYtmYdGZfzgI+FJLxbVRTBS9cpZwbKfizxG/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAxLzJdIGFybTY0OiBkdHM6IGlt
eDhxeHAtbWVrOiBTb3J0IGxhYmVscw0KPiBhbHBoYWJldGljYWxseQ0KPiANCj4gT24gTW9uLCBN
YXIgMTYsIDIwMjAgYXQgMDk6MjY6MzJBTSArMDgwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4g
U29ydCB0aGUgbGFiZWxzIGFscGhhYmV0aWNhbGx5IGZvciBjb25zaXN0ZW5jeS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4gCS0gUmViYXNlIHRvIGxhdGVzdCBicmFuY2gs
IG5vIGNvZGUgY2hhbmdlLg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4cXhwLW1lay5kdHMgfCA1MA0KPiA+ICsrKysrKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OHF4cC1tZWsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhw
LW1lay5kdHMNCj4gPiBpbmRleCBkM2QyNmNjLi5iMWJlZmRiIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiA+IEBAIC0zMCwx
OCArMzAsNyBAQA0KPiA+ICAJfTsNCj4gPiAgfTsNCj4gPg0KPiA+IC0mYWRtYV9scHVhcnQwIHsN
Cj4gPiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gLQlwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfbHB1YXJ0MD47DQo+ID4gLQlzdGF0dXMgPSAib2theSI7DQo+ID4gLX07DQo+ID4gLQ0K
PiA+IC0mZmVjMSB7DQo+ID4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+IC0JcGlu
Y3RybC0wID0gPCZwaW5jdHJsX2ZlYzE+Ow0KPiA+IC0JcGh5LW1vZGUgPSAicmdtaWktaWQiOw0K
PiA+IC0JcGh5LWhhbmRsZSA9IDwmZXRocGh5MD47DQo+ID4gLQlmc2wsbWFnaWMtcGFja2V0Ow0K
PiA+ICsmYWRtYV9kc3Agew0KPiA+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+DQo+ID4gIAltZGlv
IHsNCj4gDQo+IEhlcmUgaXMgYSByZWJhc2UgaXNzdWUsIGkuZS4gYWRtYV9kc3Agc2hvdWxkbid0
IGdldCBhIG1kaW8gY2hpbGQgbm9kZS4NCj4gSXQgY2FtZSBmcm9tIHRoZSBjb25mbGljdCB3aXRo
IG9uZSBjb21taXQgb24gbXkgZml4ZXMgYnJhbmNoLiAgSSBkZWNpZGVkIHRvDQo+IGRyb3AgdGhl
IHNlcmllcyBmb3IgdGhlIGNvbWluZyBtZXJnZSB3aW5kb3cuICBMZXQncyBzdGFydCBvdmVyIGFn
YWluIGFmdGVyDQo+IDUuNy1yYzEgYmVjb21lcyBhdmFpbGFibGUuDQoNCk9LLCBJIGFtIGFsc28g
Y29uZnVzZWQgYnkgdGhpcyBjb25mbGljdCwgSSBub3JtYWxseSBkbyB0aGUgcGF0Y2ggYmFzZWQg
b24geW91cg0KZm9yLW5leHQgYnJhbmNoLCBhbmQgSSBkaWQgTk9UIG1lZXQgdGhlIGNvbmZsaWN0
IGF0IGFsbCwgdGhlbiBJIHJlZG8gaXQgYmFzZWQgb24NCnlvdXIgZHQgYnJhbmNoIEkgbWV0IHRo
ZSBjb25mbGljdCBhbmQgZml4IGl0Li4uDQoNClNvLCBkbyBJIG5lZWQgdG8gcmVzZW5kIHRoZSBw
YXRjaCBzZXJpZXMgbGF0ZXIgd2hlbiA1LjctcmMxIGF2YWlsYWJsZT8NCg0KQW5zb24NCg==

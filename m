Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651FBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332B420658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="l620lAHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCFQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:30:41 -0500
Received: from mail-eopbgr00113.outbound.protection.outlook.com ([40.107.0.113]:37038
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgCFQak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:30:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5aIJNa4jgmTybSxfJ8kN2MJzrQieaUmRpOUzH6uwsx8KJPuAuf3Zat4sKcQtr5iSwresrohf7pROYVM/YZrc1DAY9hST6Rx6q1YnhuxEcwwSfaYDCxtpPP0Zub/DHtbV25xH6p04tMy08Y5ErmOPISgj60z4mgxmZoDlzBfOhXoZvrYcMAvRxgka9ja31oMHA1NSislqItr8W+jumDujsYPlCAG17JvLoqQR3IInQ9axp1cntpRBv7Vv6exfDqmzSdK5fVk4ikzHAfvaUdzZuqmIG69tkIDVJwBpY3BSZCPFvNKOfCkj2zaqcTq8myqm8gpGAdhQPcGoAzuprs4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB0RhFgI4t4x5kuSBsFBZgGBO6WuEBL5DdqmhjNotfQ=;
 b=RItKnctkUgLo/y/5dixw4rUTJ/vheqVemp1RrbXH8QIu2XltUnlahbgMq7evYk//q5lp5vON3Br8Um36jReV1XFPoOl8NpWNkyZoZpJpQEC0en1BeY5geac7wkXckWqKVaElPg916YZFNcj/1uEB8nc7tX4XaHeZu9PDNd86BK9L/0bItssg9lQ0eJuzNlkUy+SRF3amxLkalObgrEvV4q+o9ReNnOQ32zDEGzm58MaaG0XfAbegWjABzHiRzh3iS2W/4kO4OCA9Wi1S7+HpmJgLVLBk3pfBPwMg3iArwYalPf1HuDsU1zfJX8XG6tGw5aaVqBiYRIS+ChoNfTvM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB0RhFgI4t4x5kuSBsFBZgGBO6WuEBL5DdqmhjNotfQ=;
 b=l620lAHQ7CFoBBHzVGfupUml+OTi9pOh/e1WIdLcKOna4gVNolCFDF+fpsKszquGTZUPJjmkKCGhWc5/mxUiZWgwABC7flYxn8hp6pJFXA+lFsiLoVhNHH45HPXzPT6BtNnLqtTQ/BWC1U6sGfG7mV6bBwTrwCOMFsB9/KMpJiw=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (20.179.1.217) by
 AM6PR05MB4389.eurprd05.prod.outlook.com (52.135.160.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Fri, 6 Mar 2020 16:30:37 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::dee:ffa2:1d09:30e%4]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 16:30:37 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Topic: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
Thread-Index: AQHV8vTsfP1BktnxKEy+q0EhrXMNZqg6EXKAgAAlWYCAAPjzgIAAY3kAgAAwAAA=
Date:   Fri, 6 Mar 2020 16:30:37 +0000
Message-ID: <a1a966cb14641dc33647750cfa2f7fa1fde6e47b.camel@toradex.com>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
         <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
         <20200305165145.GA25183@lunn.ch>
         <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
         <20200306133848.GB18310@lunn.ch>
In-Reply-To: <20200306133848.GB18310@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57cbdc44-8243-4125-b123-08d7c1ebb3be
x-ms-traffictypediagnostic: AM6PR05MB4389:
x-microsoft-antispam-prvs: <AM6PR05MB43898C3E5F2CA245166903C8F4E30@AM6PR05MB4389.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(189003)(199004)(5660300002)(110136005)(8936002)(81156014)(54906003)(8676002)(81166006)(6486002)(71200400001)(6512007)(316002)(7416002)(186003)(2906002)(44832011)(2616005)(26005)(478600001)(66946007)(6506007)(4326008)(86362001)(91956017)(76116006)(64756008)(36756003)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR05MB4389;H:AM6PR05MB6120.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PlX9aTnTei6MNEI7x3bley79UgrEB7BAUG8evtr1rE5nk2XPK30bN83yEKqYDElhADO5TMTD25cANnQHob5T1WwJL8ybZwI/b8I9Hldkkssxc6AAZ3+S2zpFCjDk9Fiy5TZO90hqf03gjoA1NzCs7rPmMPi4rz0ZKx3f3jHSS38yk0lgIFrvjaM/aLypqg21snIvTUb944HoOr1bRZW4thJ8bWFF+ZmmBD3YA4iGj97smZ37eCcuXzj+dHxYM5rw/u83g5iORGTHtdd65LI9pLZ2blyYYkg4/BVQzR7hrB4WRScCyS4YbR75L2q8uav53tBaAWVrtm1Zj6p2X0XHiPMEMtaP4ho99zpGNNlQd66i3+ePYFIP1doZAaxIKvNRj/LOEkgmqsInn4Mnrl625KBiJETgawCTV1ofyuIn3K2HAS/EYGLwmZeDmNeSzWCp
x-ms-exchange-antispam-messagedata: qHEHz4klFu9MFA7FLO54mEsQBa1ikqubC9utS59GaP80XhqeRyJDNILmR+rqQd+fUeGSsq8NU4urpY0RUy4/na0QHLJ6M8qrx4I8u3JLT6ftJxNH5Cox1/behs9Hc/YweH3tYVr0ugOkiaNBCTFRiA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66F9D872AB9D754CA9139BB4119C9A24@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cbdc44-8243-4125-b123-08d7c1ebb3be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 16:30:37.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHh+lwP4ivRIezr3BqAnBxvyrfDYcCyVXts7ARmi2i6rEBUCMoW+dr6OcwtsMIYyjvyCAaB5DA9+mgqVLyy7odvaJBeUkW4HesCgrj5mqng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDE0OjM4ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiA+IEl0IHByb2JhYmx5IGRvZXMgbm90IGV2ZW4gbmVlZCB0aGF0LiBKdXN0DQo+ID4gPiANCj4g
PiA+IHBoeS1tb2RlID0gPHJnbWlpLXR4aWQ+DQo+ID4gDQo+ID4gTG9va3MgdG8gbWUgbGlrZSB0
aGlzIGlzbid0IHN1cHBvcnRlZCBieSB0aGUgTWljcmVsIFBIWSBkcml2ZXIgb3IgYW0NCj4gPiBJ
IG1pc3Npbmcgc29tZXRoaW5nPw0KPiANCj4gQWgsIHlvdSBhcmUgY29ycmVjdC4gSXQganVzdCBo
YXM6DQo+IA0KPiAgICAgICAgIGlmIChvZl9ub2RlKSB7DQo+ICAgICAgICAgICAgICAgICBrc3o5
MDIxX2xvYWRfdmFsdWVzX2Zyb21fb2YocGh5ZGV2LCBvZl9ub2RlLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBNSUlfS1NaUEhZX0NMS19DT05UUk9MX1BBRF9TS0VXLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAidHhlbi1za2V3LXBzIiwgInR4
Yy1za2V3LXBzIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJ4ZHYt
c2tldy1wcyIsICJyeGMtc2tldy1wcyIpOw0KPiAgICAgICAgICAgICAgICAga3N6OTAyMV9sb2Fk
X3ZhbHVlc19mcm9tX29mKHBoeWRldiwgb2Zfbm9kZSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTUlJX0tTWlBIWV9SWF9EQVRBX1BBRF9TS0VXLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAicnhkMC1za2V3LXBzIiwgInJ4ZDEtc2tldy1wcyIs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyeGQyLXNrZXctcHMiLCAi
cnhkMy1za2V3LXBzIik7DQo+ICAgICAgICAgICAgICAgICBrc3o5MDIxX2xvYWRfdmFsdWVzX2Zy
b21fb2YocGh5ZGV2LCBvZl9ub2RlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNSUlfS1NaUEhZX1RYX0RBVEFfUEFEX1NLRVcsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJ0eGQwLXNrZXctcHMiLCAidHhkMS1za2V3LXBzIiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInR4ZDItc2tldy1wcyIsICJ0eGQzLXNrZXct
cHMiKTsNCj4gICAgICAgICB9DQo+IA0KPiBhbmQgbm8gc3VwcG9ydCBmb3IgcGh5ZGV2LT5pbnRl
cmZhY2UuDQo+IA0KPiBBdCBtaW5pbXVtLCB5b3Ugc2hvdWxkIHVzZSB0aGVzZSBEVCBwcm9wZXJ0
aWVzLCBub3QgYSBwbGF0Zm9ybSBmaXh1cC4NCg0KQXMgSSBzYWlkLCBJIHN0aWxsIHRoaW5rIGl0
IGlzIGEgZ29vZCBpZGVhIHRvIGhhdmUgc2ltaWxhciBzb2x1dGlvbnMgYXQNCnRoZSBzYW1lIHBs
YWNlLCBlc3BlY2lhbGx5IGZvciBhIHN1Y2Nlc3NvciBQSFkuDQoNCkkgYWxzbyBzZWUgdGhlIGRv
d25zaWRlcyBzbyBJJ2xsIGdvIHdpdGggeW91ciBwcm9wb3NlZCBzb2x1dGlvbi4NCg0KVGhhbmtz
IGV2ZXJ5b25lIGZvciB0aGUgZGlzY3Vzc2lvbiENCg0KUGhpbGlwcGUNCj4gDQo+IElmIHlvdSB3
YW50IHRvLCB5b3UgY2FuIGFkZCBzdXBwb3J0IGZvciByZ21paS1pZCwgZXRjLiBUaGVyZSBhcmUg
Zml2ZQ0KPiBtb2RlcyB5b3UgbmVlZCB0byBzdXBwb3J0Og0KPiANCj4gICAgICAgICBQSFlfSU5U
RVJGQUNFX01PREVfTkEsDQo+ICAgICAgICAgUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJLA0KPiAg
ICAgICAgIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSV9JRCwNCj4gICAgICAgICBQSFlfSU5URVJG
QUNFX01PREVfUkdNSUlfUlhJRCwNCj4gICAgICAgICBQSFlfSU5URVJGQUNFX01PREVfUkdNSUlf
VFhJRCwNCj4gDQo+IE5BIG1lYW5zICJkb24ndCB0b3VjaCIuIExlYXZlIHRoZSBSR01JSSBkZWxh
eXMgYWxvbmUsIGFzIGNvbmZpZ3VyZWQgYnkNCj4gaGFyZHdhcmUgZGVmYXVsdCwgc3RyYXBwaW5n
LCBib290bG9hZGVyLCBldGMuDQo+IA0KPiAJIEFuZHJldw0K

Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96639C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723E82054F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l23FYPZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDRNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:45:34 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:35739
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbgDRNpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9wNvIAl68Zi0Y2MyOu8BmtNK0+isHWtzAwTfc7KFTODO7tCBz3jXbR7Bti6jiaFBM0i0e0UzZcuVaXeBsWOyLBe/5k5hLxB0IbWOB3XTAlKGRGgJPbeI+REHHjhdsNssVOC1RB5+qMkzcglIODGkvwUbThWfsfQBDHFSZhcGBcCep6DR+/Y0Lyu9Wmgg36N1wSdTV+f2PGrivh+KFXGz3+56degcp+eoCWinj/1aueDYs72n06v9OnbvUmG2ZEMqY4och6HC3hL4UTQ2co1SDDrjaMtKbYi9M5qde+NHWShIhBn/eEmKiWUlng7G6FtnF1D8roh1W/L+MPKQNaDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhtzkTQVsS9svm8dICitdmRoaUrC8j4RAH8OuQhVmE0=;
 b=jjQJSu9J3R5wf8QkJbUCIaJFemdCbGp2bfXayyZyvJHgNWORTtZHUSlLzEjlcDVp5Eky7L/KqVVSiOp6wRX6oa2sS4tccMtqRadQv2jS/ei9rRWS5eD6NYzEorif98NzJmjUzJpSIaH5F4ry2wi6jL9rI2cI0FS2GRt8asYOzlfN6BRFG2d1m07qbKprag/Sp9DhdKFF1iIZU0McThFVqfZQXfuKfJR3lYzWmOQKp5jbeuBCd2HmtR67/McdpcGEcSRwyP888kg9CHd9F7Q9UbFlfjsFRHbmi5qhmfRhhQil1RUpY0GaTrKh4mUcp3qpOpcsx/yCR9tmLMrth5ahhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhtzkTQVsS9svm8dICitdmRoaUrC8j4RAH8OuQhVmE0=;
 b=l23FYPZpZmrFyC0trm3v+2oaKxiVx3GjcDErRtusvEm7GRExEAPI9w/ljxDBDqBwsDd3zhhk7QEffW74t4J4oGIJkW+hTYnPJB/IKL06QwLQ27x0/oYYhKaXBdNMZRdWwB+fy9jqcaQNZPammK5FLzJNvfu6LGrdRZq2dh8Eiuw=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2902.eurprd04.prod.outlook.com (2603:10a6:4:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Sat, 18 Apr
 2020 13:45:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 13:45:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Topic: [PATCH V2 00/10] clk: imx: fixes and improve for i.MX8M
Thread-Index: AQHV+FiylUv3TAYoQ06tNnE7fjyGF6h/HlpQ
Date:   Sat, 18 Apr 2020 13:45:28 +0000
Message-ID: <DB6PR0402MB27608E9A3D273DCFF6D90AE888D60@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [180.107.26.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e678752-015c-403a-15c9-08d7e39ec174
x-ms-traffictypediagnostic: DB6PR0402MB2902:|DB6PR0402MB2902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2902B11D0888DA77A6FE96DD88D60@DB6PR0402MB2902.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(44832011)(66946007)(66476007)(6506007)(9686003)(76116006)(8676002)(55016002)(316002)(86362001)(8936002)(186003)(81156014)(33656002)(71200400001)(26005)(7696005)(5660300002)(2906002)(54906003)(6636002)(4326008)(52536014)(66446008)(64756008)(66556008)(478600001)(966005)(7416002)(110136005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2PSYuUcolINvOPgkiHt3Bo0m7WR1RfV+AiS1qNfCHJcWLmhUXWact58DV16dVkk4IpoZbtvPctHKlmT+eioh7JxMeOevdO5Nu3lxrnW0/JqwVvPvzI10otiVL4vhVgBN1u11bbSTSpHdXcURQXpctY83l9XeVzMAm2x5o1iyVn/NwYKNq5yPCgWd6cWSfNC7OHm4/stEbVxMU+2VMA9HVRpCt30yqUsdwbz3EeDOiAOtxYq2VMLjtl29qff9prSPF/jJ24dM0i3AQSAbIMGJ+LhOkwiaLuGYqhykH8QNQDd1Qs9u53ZHBM7+MVWf8joD8pHUrq3LABVw7FqgOovohzQ9Bj54HVuttLG1xaqhoYGlq++5ROFvS5c6KBKr93Hf1SMseCIsD/kMtWX6UCezDe2AUUqr+Y7TIsCcSNFsK2nF8nSPK/YWUw6fcCLkzx68jD52TSsWdHLXKOs5hzbt6Mhml4NdfCi8tUYbYtJbBknPSj8mtwi7G4+VcAdHrcEKURPSNeegxeihYnAB0G1wPw==
x-ms-exchange-antispam-messagedata: QS8/E94+PSuCFyNVBFrGZkjKcMCD7eEPQkQXEYM2XArcSe9w8NtK8CtB17ip+azSnDJC3E7z+oZDT0igYMhlakX5DAjJpckNUcKH9pwIZIt42ebD7dJ6qVgt/D9e6XlxJqbXuK2tSBf0lZL8XEHZxg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e678752-015c-403a-15c9-08d7e39ec174
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 13:45:28.4833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofQecd0jysXl6XcvInEVV/wj9b4w8Qc7/ZpAIzMNGKTpdb+0IjM9LSxO00Z0QOw9ILBTy+ppKczBFSpg15GtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggVjIgMDAvMTBdIGNsazogaW14OiBmaXhlcyBhbmQgaW1wcm92ZSBm
b3IgaS5NWDhNDQoNClBpbmcuLi4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gRnJvbTogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBQYXRjaGVzIGJhc2VkIG9uIGZvci1uZXh0
DQo+IA0KPiBWMjoNCj4gIFBhdGNoIDcsIGRyb3Agd2FpdCBhZnRlciB3cml0ZSwgYWRkIG9uZSBs
aW5lIGNvbW1lbnQgZm9yIHdyaXRlIHR3aWNlDQo+IA0KPiBWMToNCj4gUGF0Y2ggMSwyIGlzIHRv
IGZpeCB0aGUgbG9ja2RlcCB3YXJuaW5nIHJlcG9ydGVkIGJ5IExlb25hcmQgUGF0Y2ggMyBpcyB0
byBmaXggcGxsDQo+IG11eCBiaXQgUGF0Y2ggNCBpcyBhbGlnbiB3aXRoIG90aGVyIGkuTVg4TSB1
c2luZyBnYXRlIFBhdGNoIDUgaXMgdG8gc2ltcGxpZnkNCj4gaS5NWDhNUCBjbGsgcm9vdCB1c2lu
ZyBjb21wb3NpdGUNCj4gDQo+IFBhdGNoIDN+NSBpcyBhY3R1YWxseSBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzExNDAyNzYxLw0KPiB3aXRoIGEgbWluaW1hbCBjaGFuZ2UgdG8g
cGF0Y2ggNSBoZXJlLg0KPiANCj4gUGF0Y2ggNiBpcyB0byB1c2UgY29tcG9zaXRlIGNvcmUgY2xr
IGZvciBBNTMgY2xrIHJvb3QgUGF0Y2ggNyw4LDkgaXMgYWN0dWFsbHkgdG8NCj4gZml4IENPUkUv
QlVTIGNsayBzbGljZSBpc3N1ZS4NCj4gIFRoaXMgaXNzdWUgaXMgdHJpZ2dlcnJlZCBhZnRlciB3
ZSB1cGRhdGUgVS1Cb290IHRvIGluY2x1ZGUgIHRoZSBBNTMgY2xrIGZpeGVzDQo+IHRvIHNvdXJj
ZXMgZnJvbSBQTEwsIG5vdCBmcm9tIEE1MyByb290IGNsaywgIGJlY2F1c2Ugb2YgdGhlIHNpZ25v
ZmYgdGltaW5nIGlzDQo+IDFHSHouIFUtQm9vdCBzZXQgdGhlIEE1MyByb290ICBtdXggdG8gMiwg
c3lzIHBsbDIgNTAwTUh6LiBLZXJuZWwgd2lsbCBzZXQNCj4gdGhlIEE1MyByb290IG11eCB0byAg
NCwgc3lzIHBsbDEgODAwTUh6LCB0aGVuIGdhdGUgb2ZmIHN5cyBwbGwyIDUwME1Iei4gVGhlbg0K
PiBrZXJuZWwgIHdpbGwgZ2F0ZSBvZmYgQTUzIHJvb3QgYmVjYXVzZSBjbGtfaWdub3JlX3Vuc2Vk
LCBBNTMgZGlyZWN0bHkgc291cmNlcw0KPiBQTEwsIHNvIGl0IGlzIG9rIHRvIGdhdGUgb2ZmIEE1
MyByb290LiBIb3dldmVyIHdoZW4gZ2F0ZSBvZmYgQTUzICByb290IGNsaywNCj4gc3lzdGVtIGhh
bmcsIGJlY2F1c2UgdGhlIG9yaWdpbmFsIG11eCBzeXMgcGxsMiA1MDBNSHogIGdhdGVkIG9mZiB3
aXRoDQo+IENMS19PUFNfUEFSRU5UX0VOQUJMRSBmbGFnLg0KPiANCj4gIEl0IGlzIGx1Y2t5IHRo
YXQgd2Ugbm90IG1ldCBpc3N1ZSBmb3Igb3RoZXIgY29yZS9idXMgY2xrIHNsaWNlICBleGNlcHQg
QTUzDQo+IFJPT1QgY29yZSBzbGljZS4gQnV0IGl0IGlzIGFsd2F5cyB0cmlnZ2VycmVkIGFmdGVy
ICBVLUJvb3QgYW5kIExpbnV4IGJvdGgNCj4gc3dpdGNoIHRvIHVzZSBBUk0gUExMIGZvciBBNTMg
Y29yZSwgYnV0ICBoYXZlIGRpZmZlcmVudCBtdXggc2V0dGluZ3MgZm9yIEE1Mw0KPiByb290IGNs
ayBzbGljZS4NCj4gDQo+ICBTbyB0aGUgdGhyZWUgcGF0Y2hlcyBpcyB0byBhZGRyZXNzIHRoaXMg
aXNzdWUuDQo+IA0KPiBQYXRjaCAxMCBpcyBtYWtlIG1lbXJlcGFpciBhcyBjcml0aWNhbC4NCj4g
DQo+IFBlbmcgRmFuICgxMCk6DQo+ICAgYXJtNjQ6IGR0czogaW14OG06IGFzc2lnbiBjbG9ja3Mg
Zm9yIEE1Mw0KPiAgIGNsazogaW14OG06IGRyb3AgY2xrX2h3X3NldF9wYXJlbnQgZm9yIEE1Mw0K
PiAgIGNsazogaW14OiBpbXg4bXA6IGZpeCBwbGwgbXV4IGJpdA0KPiAgIGNsazogaW14OG1wOiBE
ZWZpbmUgZ2F0ZXMgZm9yIHBsbDEvMiBmaXhlZCBkaXZpZGVycw0KPiAgIGNsazogaW14OG1wOiB1
c2UgaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9jb3JlIHRvIHNpbXBsaWZ5IGNvZGUNCj4gICBjbGs6
IGlteDhtOiBtaWdyYXRlIEE1MyBjbGsgcm9vdCB0byB1c2UgY29tcG9zaXRlIGNvcmUNCj4gICBj
bGs6IGlteDogYWRkIG11eCBvcHMgZm9yIGkuTVg4TSBjb21wb3NpdGUgY2xrDQo+ICAgY2xrOiBp
bXg6IGFkZCBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2J1cw0KPiAgIGNsazogaW14OiB1c2UgaW14
OG1fY2xrX2h3X2NvbXBvc2l0ZV9idXMgZm9yIGkuTVg4TSBidXMgY2xrIHNsaWNlDQo+ICAgY2xr
OiBpbXg4bXA6IG1hcmsgbWVtcmVwYWlyIGNsb2NrIGFzIGNyaXRpY2FsDQo+IA0KPiAgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCAgMTAgKy0NCj4gYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kgfCAgMTAgKy0NCj4gYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kgfCAgMTEgKystDQo+ICBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSB8ICAgOSArLQ0KPiAgZHJpdmVycy9jbGsvaW14
L2Nsay1jb21wb3NpdGUtOG0uYyAgICAgICAgfCAgNjcgKysrKysrKysrKysrLQ0KPiAgZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg4bW0uYyAgICAgICAgICAgICAgfCAgMjcgKysrLS0tDQo+ICBkcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jICAgICAgICAgICAgICB8ICAyNSArKystLQ0KPiAgZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg4bXAuYyAgICAgICAgICAgICAgfCAxNTANCj4gKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jICAg
ICAgICAgICAgICB8ICAyOSArKystLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGsuaCAgICAgICAg
ICAgICAgICAgICAgIHwgICA3ICsrDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDht
cC1jbG9jay5oICB8ICAyOCArKysrKy0NCj4gIDExIGZpbGVzIGNoYW5nZWQsIDI0MCBpbnNlcnRp
b25zKCspLCAxMzMgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjE2LjQNCg0K

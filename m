Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F08C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4EF21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQ36jw2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgBYJRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:17:35 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:42150
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbgBYJRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:17:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISrWzpzEEHvcQ2tTU8+YzPVzjRcztibLUAyQuBp0JM3iK1YfR8y+AxLncKqWJCmVCRvwk9wIr0yQZ5R9t7fPQKZdttoLzg+7uFNmYQaTu2acQB/N7Cviw+pJWWfUGRaTAT9awA80mTD3U4w2m1QorgthEGNFzDflWom59pNpW5kq8k5uwNWE37PNj3PRVPuOlY2CkpZmSUFeaNHlDcyRYvQXGBHSF2an8UWS1xsZ1Au2tIt2ef9Czgpzlqyf5Bo+Kja+2e0wCUGSUn7joXjX1fH7uzVYNg31swznBqx5ZrPu+FslCthIdnhZJmKUJGyykXyLYIukNQXioGf31TZPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxJB/KTQmkcZNCA5oK4QO++JzMeiP00SUso+Hrkt1Os=;
 b=ML0UZcFnq0I4tmR59jQy1JlAygRLbwYFuJ8rYk/MpCCjaGRrHi6CQRYzbXasZ3M0l+/9EYbiXouHAuZABBAoCpPKDkw9na8gmtXGEQbmqiSaH8/Bj4hwwPEMjH3Day6vU9KqzGKBE8OYA2/Y7aBIzuCicRj6ZirTUU2UrhCt0v4U6euc2ql27Ke8kzIStwfxvnmqqVIVRJKLJYSqS/hCTz/JzVSZmhQaAwmD5YZlrpUej5I+SA9lLY3us6mp58t+lDbsO5kq11TYuWTsig9bLxg+b/UsHftgYuePTpinzrAEAcHYVyyPUhZtuRnWRyRx+3ate/jd8QURKMEQDFzUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxJB/KTQmkcZNCA5oK4QO++JzMeiP00SUso+Hrkt1Os=;
 b=GQ36jw2Fwe5g3257twM0/2EPdXk0wHs1r8nmWTIU2keU3kqaGDcJ3MW2okJ6tQ/nlHkiMIymnnEMNIxZRoJYhFrGwcODFZBHhT5/VxEOHAg/FWGgeGpk7X5w04ZlYNBISj1aDwBvodpuAeejdDjJrz8gl+agKk7I2485rM7zICo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 09:17:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e44d:fa34:a0af:d96%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:17:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Thread-Topic: [PATCH 1/4] clk: imx8mn: A53 core clock no need to be critical
Thread-Index: AQHV67lWYlwi4heaT0+36i2d6OFDc6grnAMAgAAEkTA=
Date:   Tue, 25 Feb 2020 09:17:29 +0000
Message-ID: <DB3PR0402MB39160C67665B2A101F2B0885F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1582620554-32689-1-git-send-email-Anson.Huang@nxp.com>
 <65500dc7-dc03-7dc1-92cd-5557cd73232e@nxp.com>
In-Reply-To: <65500dc7-dc03-7dc1-92cd-5557cd73232e@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebbd52ec-2b1d-491c-81a8-08d7b9d389cb
x-ms-traffictypediagnostic: DB3PR0402MB3658:|DB3PR0402MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3658591EC1E4187B39866E30F5ED0@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(8936002)(44832011)(81156014)(8676002)(76116006)(316002)(81166006)(478600001)(33656002)(5660300002)(71200400001)(2906002)(4326008)(110136005)(52536014)(186003)(86362001)(26005)(66946007)(9686003)(53546011)(6506007)(55016002)(7696005)(66476007)(64756008)(66556008)(66446008)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3658;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yF6bHjdAtRua/kYS48I90xIrcel/ZWQHFw9IxX7EeT5WgPEVOCpXxQe5tZvp6Z81WHNbPTsDOJO6p93f22IrikFhd/lRG06F1bZBGQWrgO3jDUc/3v+JCL6FwM46nYIeMzRnUHYETmxSQ5obweCY4KNCDn9Kry0BZ+m9XrUKgKHEaHVt3JwbGlOV8axuRs2vixX6keOEnSuWsi3w43KNdoaCLwazLZLoH6VUuEmsbNdsB2h1DBlIyVZIPIVo11Pgopbj2jygGhLDup7Xp+vPQgv2DGxvIOIEPY1Gy9EL47Sq3KpVBB8Pmnf3+hA0BYWGpmPL2k/O3MMkaKaHznb9tIEhqAjK9dTGDBZMjUDIfb+OVKcg7lMP7FpeGttpweRxM8Lq/KSQMdDsROBNWi7tiMMPzP+f4IwgDj8ruuDBx7Bw4KYq3GjRpnERD+5SVuuIr8fr645yaduhvVN+93GaqKlIDWxX+4oSmzU6RuEdKXp/fS023124WVEuFafCEE7BLcJ2ZAH+stsevNiC19VUcQ==
x-ms-exchange-antispam-messagedata: V13pJgZ17A/Qfsu6sG4+wfZ2+Q3KhKJGFp2WF9vtLPtAi0zeP4mDM92N7BNbX8+mtGh+A9nUq/DD0b9kedDivLBi1+SKeIJuFFhu0y8XK/iBjc8GW20uqSxlKu+NlMzeliomeb91bnjZtdvW0f2HCQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbd52ec-2b1d-491c-81a8-08d7b9d389cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 09:17:29.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoqwFmDyfsBO5vuSGpZWOGoSAv3Qk1g/OnBNZBnAHwnHjpSVgvii5M/VbSpmgVTgNFmYEnhcQA+fmipMQbocsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBjbGs6IGlteDhtbjogQTUz
IGNvcmUgY2xvY2sgbm8gbmVlZCB0byBiZSBjcml0aWNhbA0KPiANCj4gSGkgQW5zb24sDQo+IA0K
PiBPbmUgY29tbWVudCBpbmxpbmU6DQo+IA0KPiBPbiAyNS4wMi4yMDIwIDEwOjQ5LCBBbnNvbiBI
dWFuZyB3cm90ZToNCj4gPiAnQTUzX0NPUkUnIGlzIGp1c3QgYSBtdXggYW5kIG5vIG5lZWQgdG8g
YmUgY3JpdGljYWwsIGJlaW5nIGNyaXRpY2FsDQo+ID4gd2lsbCBjYXVzZSBpdHMgcGFyZW50IGNs
b2NrIGFsd2F5cyBPTiB3aGljaCBkb2VzIE5PVCBtYWtlIHNlbnNlLCB0bw0KPiA+IG1ha2Ugc3Vy
ZSBDUFUncyBoYXJkd2FyZSBjbG9jayBzb3VyY2UgTk9UIGJlaW5nIGRpc2FibGVkIGR1cmluZyBj
bG9jaw0KPiA+IHRyZWUgc2V0dXAsIG5lZWQgdG8gbW92ZSB0aGUgJ0E1M19TUkMnLydBNTNfQ09S
RScgcmVwYXJlbnQgb3BlcmF0aW9ucw0KPiA+IHRvIGFmdGVyIGNyaXRpY2FsIGNsb2NrICdBUk1f
Q0xLJyBzZXR1cCBmaW5pc2hlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jbGsvaW14L2Ns
ay1pbXg4bW4uYyB8IDggKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4bW4uYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYyBpbmRl
eCA4MzYxOGFmLi4wYmM3MDcwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1uLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbi5jDQo+ID4gQEAg
LTQyOCw3ICs0MjgsNyBAQCBzdGF0aWMgaW50IGlteDhtbl9jbG9ja3NfcHJvYmUoc3RydWN0DQo+
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgIAlod3NbSU1YOE1OX0NMS19HUFVfU0hBREVS
X0RJVl0gPQ0KPiBod3NbSU1YOE1OX0NMS19HUFVfU0hBREVSXTsNCj4gPg0KPiA+ICAgCS8qIENP
UkUgU0VMICovDQo+ID4gLQlod3NbSU1YOE1OX0NMS19BNTNfQ09SRV0gPQ0KPiBpbXhfY2xrX2h3
X211eDJfZmxhZ3MoImFybV9hNTNfY29yZSIsIGJhc2UgKyAweDk4ODAsIDI0LCAxLA0KPiBpbXg4
bW5fYTUzX2NvcmVfc2VscywgQVJSQVlfU0laRShpbXg4bW5fYTUzX2NvcmVfc2VscyksDQo+IENM
S19JU19DUklUSUNBTCk7DQo+ID4gKwlod3NbSU1YOE1OX0NMS19BNTNfQ09SRV0gPSBpbXhfY2xr
X2h3X211eDIoImFybV9hNTNfY29yZSIsDQo+IGJhc2UgKw0KPiA+ICsweDk4ODAsIDI0LCAxLCBp
bXg4bW5fYTUzX2NvcmVfc2VscywNCj4gPiArQVJSQVlfU0laRShpbXg4bW5fYTUzX2NvcmVfc2Vs
cykpOw0KPiA+DQo+ID4gICAJLyogQlVTICovDQo+ID4gICAJaHdzW0lNWDhNTl9DTEtfTUFJTl9B
WEldID0NCj4gPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2NyaXRpY2FsKCJtYWluX2F4aSIsIGlt
eDhtbl9tYWluX2F4aV9zZWxzLA0KPiBiYXNlDQo+ID4gKyAweDg4MDApOyBAQCAtNTU5LDE1ICs1
NTksMTUgQEAgc3RhdGljIGludCBpbXg4bW5fY2xvY2tzX3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPg0KPiA+ICAgCWh3c1tJTVg4TU5fQ0xLX0RSQU1fQUxUX1JP
T1RdID0NCj4gPiBpbXhfY2xrX2h3X2ZpeGVkX2ZhY3RvcigiZHJhbV9hbHRfcm9vdCIsICJkcmFt
X2FsdCIsIDEsIDQpOw0KPiA+DQo+ID4gLQljbGtfaHdfc2V0X3BhcmVudChod3NbSU1YOE1OX0NM
S19BNTNfU1JDXSwNCj4gaHdzW0lNWDhNTl9TWVNfUExMMV84MDBNXSk7DQo+ID4gLQljbGtfaHdf
c2V0X3BhcmVudChod3NbSU1YOE1OX0NMS19BNTNfQ09SRV0sDQo+IGh3c1tJTVg4TU5fQVJNX1BM
TF9PVVRdKTsNCj4gDQo+IA0KPiBXaHkgZG8geW91IG5lZWQgdG8gbW92ZSB0aGlzIGNvZGU/IElm
IHRoZXJlIGlzIGEgcmVhc29uIHBsZWFzZSBhZGQgYQ0KPiBzZXBhcmF0ZSBwYXRjaCBhbmQgZXhw
bGFpbiB3aHkuDQoNCkkgaGF2ZSBleHBsYWluZWQgdGhlIHJlYXNvbiBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UsIG1heWJlIE5PVCBkZXRhaWwgZW5vdWdoDQpmb3IgeW91LCBpZiB0aGVzZSB0d28gc2V0
IHBhcmVudCBpcyBwdXQgYmVmb3JlIEFSTV9DTEsgcmVnaXN0ZXIsIGl0IHdpbGwgY2F1c2UgQVJN
X1BMTA0KYmVpbmcgZGlzYWJsZWQgYXMgbm8gY29uc3VtZXIgdXNpbmcgaXQsIHNvIHRoZSBjaGFu
Z2VzIG11c3QgYmUgZG9uZSBpbiB0aGlzIHBhdGNoLg0KQWZ0ZXIgQVJNX0NMSyByZWdpc3RlciBk
b25lLCBhcyBpdCBpcyBjcml0aWNhbCwgaXRzIHBhcmVudCB3aWxsIGJlIGFsd2F5cyBPTiwgaGVu
Y2UgcmUtcGFyZW50DQppcyBPSy4gDQoNClRoYW5rcywNCkFuc29uDQoNCj4gDQo+ID4gLQ0KPiA+
ICAgCWh3c1tJTVg4TU5fQ0xLX0FSTV0gPSBpbXhfY2xrX2h3X2NwdSgiYXJtIiwgImFybV9hNTNf
Y29yZSIsDQo+ID4gICAJCQkJCSAgIGh3c1tJTVg4TU5fQ0xLX0E1M19DT1JFXS0+Y2xrLA0KPiA+
ICAgCQkJCQkgICBod3NbSU1YOE1OX0NMS19BNTNfQ09SRV0tPmNsaywNCj4gPiAgIAkJCQkJICAg
aHdzW0lNWDhNTl9BUk1fUExMX09VVF0tPmNsaywNCj4gPiAgIAkJCQkJICAgaHdzW0lNWDhNTl9D
TEtfQTUzX0RJVl0tPmNsayk7DQo+ID4NCj4gPiArCWNsa19od19zZXRfcGFyZW50KGh3c1tJTVg4
TU5fQ0xLX0E1M19TUkNdLA0KPiBod3NbSU1YOE1OX1NZU19QTEwxXzgwME1dKTsNCj4gPiArCWNs
a19od19zZXRfcGFyZW50KGh3c1tJTVg4TU5fQ0xLX0E1M19DT1JFXSwNCj4gPiAraHdzW0lNWDhN
Tl9BUk1fUExMX09VVF0pOw0KPiA+ICsNCj4gPiAgIAlpbXhfY2hlY2tfY2xrX2h3cyhod3MsIElN
WDhNTl9DTEtfRU5EKTsNCj4gPg0KPiA+ICAgCXJldCA9IG9mX2Nsa19hZGRfaHdfcHJvdmlkZXIo
bnAsIG9mX2Nsa19od19vbmVjZWxsX2dldCwNCj4gPiBjbGtfaHdfZGF0YSk7DQo+IA0KDQo=

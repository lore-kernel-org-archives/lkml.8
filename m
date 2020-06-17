Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378CE20739
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bkb+/t6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgFQKoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:44:21 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:23928
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbgFQKoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhbjZf08GVxQSgbBFhll3euWtF0BM3Rof6lq80FWjOemqUV9Z3I717dMgX428kOqNf8tMcZRbRw3b/T73pqhBe37e8gzRQBmhL+MO4+KE04OQvnGPhcSEMKkG3o2LzJmVn3E+s/aj7YzW0sm6EhGnOBugkzr0oaL1i/MRJC7DUP+tj2QRjlKW3uVzruxRGF+Ri33n4h7y4Lod3me3HT11Fz7VIuxoEUk+CBPn5xTsDizaZuv8GPjw0VsHTYLhCbHfIWSD5ESaVY035Izt++ByRbdxGR+wuWCCx8J3Yo8mOYlaRIskJFcNaONa7pSQJdQFLF2xiNsHvQ3tqJUEedrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hj3cuyTV5MBkzhjZampMaqACKV9cL5YasgewBL6onc=;
 b=nKMecTDGCk5XJS5DqrQic3gc5Oke8JbVd8bXKTRq4pp0s9g04VGMG4yR4DnzlSAqR2PV6wsx+kaexqq5ppW7CSVqIt5crUk1leMp9TgP9Vt92Tu1jB1Tl0+r7xLpAaCcqock20jANpbXAhQYrfOO9+QDZPBX1dP8087uU3PaKEPVz3lnB2qj4XoRGyEnWBNT5cvB5Uf/1xBgNWiXow+PEB/XxOOf72j8yJVvDzjqjJjfksB2tVZZ2TItMN50/qSW7tXbZpe7ghFnsaUanj8P4ECXLbBBe1zRXKfS2JuL/O2pbs7Js6+wmFq0VXTbrHCAv6WhkxGN0GwOTTXewyTM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hj3cuyTV5MBkzhjZampMaqACKV9cL5YasgewBL6onc=;
 b=bkb+/t6R1iPJ6zZj7hrF8xn8ewIxfTP6wBcvauL8y2MeLOrYE+DZiiZlR1whjsqYraNn9ZnAY++5jwova+gRkh7/dgRaIy+qJc0kQpaS8MccC68rBlhg2Tg4cJctaTxU7wf/GIL4ZYEJQ2sZjB5M72iN3ZDZZpxfr5O/2WuZa0I=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4024.eurprd04.prod.outlook.com (2603:10a6:209:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 17 Jun
 2020 10:44:11 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 10:44:11 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQ
Date:   Wed, 17 Jun 2020 10:44:11 +0000
Message-ID: <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbdfcbb6-ef9d-49a9-00c2-08d812ab5f1e
x-ms-traffictypediagnostic: AM6PR04MB4024:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4024B8F1D8F5832A0787AA67809A0@AM6PR04MB4024.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+RB3mR6AptGQaNf6Bs5jKF5/MpIY0dhF+JaINcPZe0XxH7HF5X0KO36vpM4pFsZIb7WVgjtymOJ2q91B9JEPVjoKZpFsIFMkSyZTwvb59XALs055TWLPwjiWeupDOOWanu1yf/clUXBhZBqtaUIlcjmtuPnWbgvBaZLamJKZl92GeLtBxt5tsD/NsAMEoveHT1VIvTCSl04gQysFPNgPnjkk1RgNYsYxEZrwacWtiypbz274NIyoAxFVLDP5YGO011UM+2fhHMf9Woe2IV/1BBazB9/XcmeSuVqitHjvsik0vzDFS9Hlcdu28vD0j4gscg5XgaPmnSLQB/4a3/C4CENVOdYELmHWauIXYo+qunqR8+7ek0+aNuBBfu/r1Q5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(66446008)(76116006)(66946007)(66476007)(66556008)(64756008)(86362001)(7416002)(5660300002)(52536014)(4326008)(44832011)(33656002)(55016002)(7696005)(83380400001)(478600001)(9686003)(2906002)(186003)(316002)(8936002)(26005)(6506007)(110136005)(71200400001)(8676002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NQXvhplBvUss9fLMoB3Dqz392Bgh0nCu/p+9sfEx2oEW7HVEO8r5txi9QgG83Ct4VhIrySbLQf+rsgD0Kmi7SO63SX+P9UxAfG79vllkXwhwG20DHXIubGuy7TUKfCZfrWvoUFsdm68cVFOzNwmfR5KdzVV6YZQqv6RX2IJKJ+UoltGzResYc9SzAYqTBLl/6ThchlFCnM3b+7sfmbpdHvBM4NdjuLtGlyGbcJVHoYJDxbWUxdHKUtXDUyFqpEi/jxLUmktZOu4k/7gSnGa6HSaac/sYbtLQFZ/sbO2vCDJKN/VWRy4gA6TTFkLJebQZ0af6bu8d5hRvvrpLh+xqUjeEungMaClPqMzI+a084LTZiaIXi8NmDaOAqj4cG8S9/HBrVI+3D8Vfrtc8v76NfFuCK6o9kKOVLw8vnbvjFig2h/JTPZ3Kqg1rGysQHiEqlMAiSmf9CmdW8xltmUpThH7UYzxLA6W8CGYPuQv+BXV3zR+VU0sRN4t6mWJYkOGP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdfcbb6-ef9d-49a9-00c2-08d812ab5f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 10:44:11.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYgtebLVRgM1T1zsdXckoo/XYrvfW2DWOh6D+735clslBXpNUvxjNpDy3d2/D6T6TpZ3Z27ngLgrEhsPdb7RxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVuZSA5LCAyMDIwIDM6MzIgUE0NCj4gDQo+IFRoZXJlIGFyZSBtb3JlIGFuZCBtb3JlIHJl
cXVpcmVtZW50cyBvZiBidWlsZGluZyBTb0Mgc3BlY2lmaWMgZHJpdmVycyBhcw0KPiBtb2R1bGVz
LCBhZGQgc3VwcG9ydCBmb3IgYnVpbGRpbmcgU0NVIGNsb2NrIGRyaXZlciBhcyBtb2R1bGUgdG8g
bWVldCB0aGUNCj4gcmVxdWlyZW1lbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgVjE6DQo+IAkt
IGFkZCBBUkNIX01YQyB0byBidWlsZCBkZXBlbmRlbmN5IHRvIGF2b2lkIGJ1aWxkIGZhaWwgb24g
eDg2IGFyY2g7DQo+IAktIG1vdmUgY2xrLWxwY2ctc2N1LmMgY2hhbmdlIGluIHRvIHRoaXMgcGF0
Y2guDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvaW14L0tjb25maWcgICAgICAgIHwgNCArKy0tDQo+
ICBkcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUgICAgICAgfCA1ICsrLS0tDQo+ICBkcml2ZXJzL2Ns
ay9pbXgvY2xrLWxwY2ctc2N1LmMgfCAxICsNCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstc2N1LmMg
ICAgICB8IDUgKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZyBi
L2RyaXZlcnMvY2xrL2lteC9LY29uZmlnIGluZGV4DQo+IGRiMDI1M2YuLmRlZDA2NDMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lt
eC9LY29uZmlnDQo+IEBAIC01LDggKzUsOCBAQCBjb25maWcgTVhDX0NMSw0KPiAgCWRlZl9ib29s
IEFSQ0hfTVhDDQo+IA0KPiAgY29uZmlnIE1YQ19DTEtfU0NVDQo+IC0JYm9vbA0KPiAtCWRlcGVu
ZHMgb24gSU1YX1NDVQ0KDQpLZWVwIHRoaXMgbGluZSBhcyBpdCBpcw0KDQo+ICsJdHJpc3RhdGUg
IklNWCBTQ1UgY2xvY2siDQoNCmkuTVggU0NVIENsb2NrIGNvcmUgZHJpdmVyDQoNCj4gKwlkZXBl
bmRzIG9uIEFSQ0hfTVhDICYmIElNWF9TQ1UNCj4gDQo+ICBjb25maWcgQ0xLX0lNWDhNTQ0KPiAg
CWJvb2wgIklNWDhNTSBDQ00gQ2xvY2sgRHJpdmVyIg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvaW14L01ha2VmaWxlIGIvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlIGluZGV4DQo+IDkyOGY4
NzQuLjFhZjhjZmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9NYWtlZmlsZQ0KPiAr
KysgYi9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUNCj4gQEAgLTIxLDkgKzIxLDggQEAgb2JqLSQo
Q09ORklHX01YQ19DTEspICs9IFwNCj4gIAljbGstc3NjZy1wbGwubyBcDQo+ICAJY2xrLXBsbDE0
eHgubw0KPiANCj4gLW9iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0gXA0KPiAtCWNsay1zY3Uu
byBcDQo+IC0JY2xrLWxwY2ctc2N1Lm8NCj4gK214Yy1jbGstc2N1LW9ianMgKz0gY2xrLXNjdS5v
IGNsay1scGNnLXNjdS5vDQo+ICtvYmotJChDT05GSUdfTVhDX0NMS19TQ1UpICs9IG14Yy1jbGst
c2N1Lm8NCg0KTGlrZSBpLk1YIHBpbmN0cmwsIEknbSBub3Qgc3VyZSBpZiBpdCdzIHJlYWxseSBu
ZWNlc3NhcnkgdG8gYnVpbGQgY29yZSBsaWJyYXJpZXMNCmFzIG1vZHVsZXMuIFByb2JhYmx5IHRo
ZSBzaW1wbGVzdCB3YXkgaXMgb25seSBidWlsZGluZyBwbGF0Zm9ybSBkcml2ZXJzIHBhcnQNCmFz
IG1vZHVsZS4gQW5kIGxlYXZlIHRob3NlIGNvcmUgbGlicmFyaWVzIGJ1aWx0IGluIGtlcm5lbC4N
ClRoaXMgbWF5IG1ha2UgdGhlIGNvZGUgYSBiaXQgY2xlYW5lci4NCg0KUmVnYXJkcw0KQWlzaGVu
Zw0KDQo+IA0KPiAgb2JqLSQoQ09ORklHX0NMS19JTVg4TU0pICs9IGNsay1pbXg4bW0ubw0KPiAg
b2JqLSQoQ09ORklHX0NMS19JTVg4TU4pICs9IGNsay1pbXg4bW4ubyBkaWZmIC0tZ2l0DQo+IGEv
ZHJpdmVycy9jbGsvaW14L2Nsay1scGNnLXNjdS5jIGIvZHJpdmVycy9jbGsvaW14L2Nsay1scGNn
LXNjdS5jIGluZGV4DQo+IGE3M2E3OTkuLjgxNzdmMGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Y2xrL2lteC9jbGstbHBjZy1zY3UuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWxwY2ct
c2N1LmMNCj4gQEAgLTExNCwzICsxMTQsNCBAQCBzdHJ1Y3QgY2xrX2h3ICppbXhfY2xrX2xwY2df
c2N1KGNvbnN0IGNoYXIgKm5hbWUsDQo+IGNvbnN0IGNoYXIgKnBhcmVudF9uYW1lLA0KPiANCj4g
IAlyZXR1cm4gaHc7DQo+ICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChpbXhfY2xrX2xwY2dfc2N1
KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstc2N1LmMgYi9kcml2ZXJzL2Ns
ay9pbXgvY2xrLXNjdS5jIGluZGV4DQo+IGI4YjIwNzIuLjk2ODg5ODEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvY2xrL2lteC9jbGstc2N1LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1z
Y3UuYw0KPiBAQCAtOCw2ICs4LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9hcm0tc21jY2MuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9l
cnIuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9z
bGFiLmg+DQo+IA0KPiAgI2luY2x1ZGUgImNsay1zY3UuaCINCj4gQEAgLTEzMiw2ICsxMzMsNyBA
QCBpbnQgaW14X2Nsa19zY3VfaW5pdCh2b2lkKSAgew0KPiAgCXJldHVybiBpbXhfc2N1X2dldF9o
YW5kbGUoJmNjbV9pcGNfaGFuZGxlKTsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKGlteF9j
bGtfc2N1X2luaXQpOw0KPiANCj4gIC8qDQo+ICAgKiBjbGtfc2N1X3JlY2FsY19yYXRlIC0gR2V0
IGNsb2NrIHJhdGUgZm9yIGEgU0NVIGNsb2NrIEBAIC0zODcsMyArMzg5LDYgQEANCj4gc3RydWN0
IGNsa19odyAqX19pbXhfY2xrX3NjdShjb25zdCBjaGFyICpuYW1lLCBjb25zdCBjaGFyICogY29u
c3QgKnBhcmVudHMsDQo+IA0KPiAgCXJldHVybiBodzsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0xf
R1BMKF9faW14X2Nsa19zY3UpOw0KPiArDQo+ICtNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+
IC0tDQo+IDIuNy40DQoNCg==

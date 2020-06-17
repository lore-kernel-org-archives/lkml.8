Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D090C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4CE20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bebVAoV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:26:48 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:44101
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgFQM0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcia4LLVO9LaUhRJI+oE5+vNel2vjem50H/UQNQwnCO1cK8FN2AlfeiPm8Xazt6YBMIVH2PX0ua6L6KsWRQ68Zsm9nUTUEzr5tlRUGIi6yZFAE01nEQFfYo02BiR/oiRp00BR73hAW2VlYdMC6R4jJyQukjEfIHKpnnTzYlBHJj3TSIylD/DHmRj1AndG3uIrcNRkABmJjl8Bc1VeNhF91t9gQAhy/kAphVmIKy5JkwHYx3YNcFRj5f1zUeK74G5bi6coAN+niUZueYVc05Xz/R8sV/8NZGNYI82/MnLzXSHo8Fh015favM/PhqDTFOkkUt0VlLZuNzdOtOHgwr6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OUq3R75rdKSSnxys/SVFm1fcgb15bPx2uFsnmGFzHk=;
 b=CgBf2QQnoz3sYXzHPllFtZNDIvf2QxEfhmUX3BB8jzW4rPein6m/i/szAQoiS7+KCyEXLYuD2fcNFLU9qyFeG0tTp3rPfGsodeTKPplS3SUB4P8pZWv7mtu0nfwAhrtU60roAM3uWOX/H/308ryjr1WmBKaCa/q2Gnga3RCUoHzoNO3qnFiBjTTbmkoV38XO7O3wV6lDvPXA61FomDR9zXml20AflpEL44q5sLHCEGu2HkJnrznX2bl+4VHuNl4X96LnJOsLpv50YqG5NGhrKn/hLiNwjqllHI58YFgGlMSRyMwCpbq4qtxnZg3z+m93MlUisrKDAIbYJ+hOf87GhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OUq3R75rdKSSnxys/SVFm1fcgb15bPx2uFsnmGFzHk=;
 b=bebVAoV7VUoyRuMzPKTYAeZAh/U5hvmRIQ8oKnjLFB0TQrjxzQZf/rwQ/GDP95TIW+sz3eVRDPfLJWIVnEduKOowfuzLC6UY8zbJqMWssha6k1haCYxFoAUGLrNptRJtj2Kduz36iAphUo4Tfm63v0stsnz52SKqGrZCxpg4Pkg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3881.eurprd04.prod.outlook.com (2603:10a6:8:12::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 12:26:43 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 12:26:43 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHWPjGlTieDV0WYc0SOGNv5XMQ0F6jcrBWAgAAcNCA=
Date:   Wed, 17 Jun 2020 12:26:43 +0000
Message-ID: <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01fb318e-09c7-4065-a04d-08d812b9b1e9
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3881D5D0335E3B99567381C3F59A0@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22b1HaOIS2icXu9OLJJPDbGq0TwJimaRLtlfLRCRKYW2CubDF+oDWEAFkY61uyGdnoOsRt0JiBjC+wX4ZHqx/1GqxAFB1LM9kPpG7UGOhZ3ctWq5pvVdF9jp20BI7ZpPad3vkPSw2xD9ZXwfmDYWXfx0MV/NyoXs/8R59TNa/QTagx2TF9yr7c73iZsdCIlNqgEBoXVlT6hAabehww8SyJ5Q/tvNklX2UQ0JZ7V5Y3HRS5Zxbk75JlQFp8twW1FeXa8PI/OM7aXnvoNi4JtyQfjcYmwEoCGAFCOVBMW5a9tLouolqNqWC7at56gy3PLI+GOJ1mDY1pW+e76hC+BzhsVa/fXAQ09SVomxn/S9dRLtota6i+9xzSrKNFR9+wt2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(8676002)(33656002)(4326008)(71200400001)(2906002)(55016002)(186003)(26005)(44832011)(8936002)(5660300002)(110136005)(478600001)(9686003)(83380400001)(76116006)(7696005)(52536014)(66446008)(86362001)(316002)(64756008)(66476007)(6506007)(66556008)(7416002)(66946007)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1ocY81cP+XOnCmjIAj6Aj5oxyPPhSuvxPDC8B9+HTGk3R9BgGln60DdVZrQr9tna54bFf7cFhQy/Xs0NFYOF8L3WeWXn5oHy1nG4b1LQaaI0kguxP4r4B0XBnqFvFoQFKt+dNxJlduxBWGTapx06wNgyIiaFE4HGJnS2dmd9S0u56uPOmN3acDZhjKfM0FlPPU/D78AJ6qOC7riC0G9j656qrieeu4n0sawy3mWKNrc8+GILRi2YwgqiTfZqjF8TwaZM1hzoqbd/bLaPdaz2vC5gB51I4eZyt5fmbypNYMeM5iqxglO2xZICViKIY9ya6u+SMFhJjfPuivYn8yY6azkotkUrs2HH5CTkhClEx0XI0r325A2XXqXnAe6/8rmA5nIHPAShVLKPxavqet2IYghERO/nVj6aVosa6rQZNiMedcgu6XK/O43ZSLjiM7LbRUoG4M7aCXtsNUMLgSNYaMQmoCIpI8BcdDr9E1uJNLFS/1YROOAU3o8o+tpYERwZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fb318e-09c7-4065-a04d-08d812b9b1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 12:26:43.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAyzG1FAKzgN9l8prxplXvKAxKDnnMYkWHKmnIt1hwKXhOlH5cW6ifB3eXxwDEB/SN2WJG9gvBLD0atG9EU8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85XSBjbGs6IGlteDogU3VwcG9ydCBidWlsZGlu
ZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBKdW5lIDksIDIwMjAg
MzozMiBQTQ0KPiA+DQo+ID4gVGhlcmUgYXJlIG1vcmUgYW5kIG1vcmUgcmVxdWlyZW1lbnRzIG9m
IGJ1aWxkaW5nIFNvQyBzcGVjaWZpYyBkcml2ZXJzDQo+ID4gYXMgbW9kdWxlcywgYWRkIHN1cHBv
cnQgZm9yIGJ1aWxkaW5nIFNDVSBjbG9jayBkcml2ZXIgYXMgbW9kdWxlIHRvDQo+ID4gbWVldCB0
aGUgcmVxdWlyZW1lbnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiA+IAkt
IGFkZCBBUkNIX01YQyB0byBidWlsZCBkZXBlbmRlbmN5IHRvIGF2b2lkIGJ1aWxkIGZhaWwgb24g
eDg2IGFyY2g7DQo+ID4gCS0gbW92ZSBjbGstbHBjZy1zY3UuYyBjaGFuZ2UgaW4gdG8gdGhpcyBw
YXRjaC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsvaW14L0tjb25maWcgICAgICAgIHwgNCAr
Ky0tDQo+ID4gIGRyaXZlcnMvY2xrL2lteC9NYWtlZmlsZSAgICAgICB8IDUgKystLS0NCj4gPiAg
ZHJpdmVycy9jbGsvaW14L2Nsay1scGNnLXNjdS5jIHwgMSArDQo+ID4gIGRyaXZlcnMvY2xrL2lt
eC9jbGstc2N1LmMgICAgICB8IDUgKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL2lteC9LY29uZmlnIGIvZHJpdmVycy9jbGsvaW14L0tjb25maWcgaW5kZXgNCj4gPiBkYjAy
NTNmLi5kZWQwNjQzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9LY29uZmlnDQo+
ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L0tjb25maWcNCj4gPiBAQCAtNSw4ICs1LDggQEAgY29u
ZmlnIE1YQ19DTEsNCj4gPiAgCWRlZl9ib29sIEFSQ0hfTVhDDQo+ID4NCj4gPiAgY29uZmlnIE1Y
Q19DTEtfU0NVDQo+ID4gLQlib29sDQo+ID4gLQlkZXBlbmRzIG9uIElNWF9TQ1UNCj4gDQo+IEtl
ZXAgdGhpcyBsaW5lIGFzIGl0IGlzDQo+IA0KPiA+ICsJdHJpc3RhdGUgIklNWCBTQ1UgY2xvY2si
DQo+IA0KPiBpLk1YIFNDVSBDbG9jayBjb3JlIGRyaXZlcg0KPiANCj4gPiArCWRlcGVuZHMgb24g
QVJDSF9NWEMgJiYgSU1YX1NDVQ0KPiA+DQo+ID4gIGNvbmZpZyBDTEtfSU1YOE1NDQo+ID4gIAli
b29sICJJTVg4TU0gQ0NNIENsb2NrIERyaXZlciINCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvaW14L01ha2VmaWxlIGIvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlIGluZGV4DQo+ID4gOTI4
Zjg3NC4uMWFmOGNmZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUN
Cj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUNCj4gPiBAQCAtMjEsOSArMjEsOCBA
QCBvYmotJChDT05GSUdfTVhDX0NMSykgKz0gXA0KPiA+ICAJY2xrLXNzY2ctcGxsLm8gXA0KPiA+
ICAJY2xrLXBsbDE0eHgubw0KPiA+DQo+ID4gLW9iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0g
XA0KPiA+IC0JY2xrLXNjdS5vIFwNCj4gPiAtCWNsay1scGNnLXNjdS5vDQo+ID4gK214Yy1jbGst
c2N1LW9ianMgKz0gY2xrLXNjdS5vIGNsay1scGNnLXNjdS5vDQo+ID4gK29iai0kKENPTkZJR19N
WENfQ0xLX1NDVSkgKz0gbXhjLWNsay1zY3Uubw0KPiANCj4gTGlrZSBpLk1YIHBpbmN0cmwsIEkn
bSBub3Qgc3VyZSBpZiBpdCdzIHJlYWxseSBuZWNlc3NhcnkgdG8gYnVpbGQgY29yZSBsaWJyYXJp
ZXMgYXMNCj4gbW9kdWxlcy4gUHJvYmFibHkgdGhlIHNpbXBsZXN0IHdheSBpcyBvbmx5IGJ1aWxk
aW5nIHBsYXRmb3JtIGRyaXZlcnMgcGFydCBhcw0KPiBtb2R1bGUuIEFuZCBsZWF2ZSB0aG9zZSBj
b3JlIGxpYnJhcmllcyBidWlsdCBpbiBrZXJuZWwuDQo+IFRoaXMgbWF5IG1ha2UgdGhlIGNvZGUg
YSBiaXQgY2xlYW5lci4NCj4gDQoNCldpbGwgZGlzY3VzcyB0aGlzIHdpdGggTGluYXJvIGd1eXMg
YWJvdXQgaXQsIHByZXZpb3VzIHJlcXVpcmVtZW50IEkgcmVjZWl2ZWQgaXMNCmFsbCBTb0Mgc3Bl
Y2lmaWMgbW9kdWxlcyBuZWVkIHRvIGJlIGJ1aWx0IGFzIG1vZHVsZS4NCg0KQW5zb24NCg==

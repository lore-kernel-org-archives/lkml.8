Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9759C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC7A2224A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ixrfz6bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgFRB7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:59:05 -0400
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:6179
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732657AbgFRB66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:58:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gni7DTaK0MbK3vmal4kYqmcaHXL4uD8O4359nl3+BNxK61FZRGI8SiQENEjS6a0g7+/WvRXOV8oQvBV0q6YtEwllF1G6cJ/gAlw2gSQhV44QYhSs1OoR5GsZae6mvnN9ydR19tc5b2D2rAa4gfr+zWb9YoRr+DT2UYZvcUtRkVCN5EUVvx/WF1nFuV3JaPHE+e6TUDW0K55c/J3TirZCsb3IDfUQpu3FsczYnn1MgwieZ9W/kaOlzvPtB01K3Ux1FwubyIQi1nDZcAMSyg2ee69N6AG5I7yralFoCORtQPNGvIGq09garGm73PQy4wyQT1O9qzg4ftuKTWE+mJvMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnppIL3oCXx8Ftrawzm3nzRK8t976Xzu+IVXltWxhF4=;
 b=lq90lYCiWER07HZcgzmRR5iUzTGIEkJnjB5hq3iTisyG9hluIq8dQFLu0SJBpZz+C+hRR0FhGrzHiS7DewEKlv0dsZ82D7/i4I3bvZ26Fypmx4qUHVsHarfQ0YMuUncX6MRgAZx/i5SxA8rMyRuA8gMOgkXluKhiJFfSi/D0wcDBlRMHiPiJ7j86fVyEhmL0NHaY3LwFc21TKtBMvdZI+t4q/s480+XNEuGplXlg042aFFx2MKBYiF0Tj33Dga7L+FvdlRdLMFTb6VXnhYygZ+XQY3Q0l4vINpegbMpx+v0W9zqa2XQcDFYo7/0brRg6lTOSgKgU7r7wp0mQVtpKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnppIL3oCXx8Ftrawzm3nzRK8t976Xzu+IVXltWxhF4=;
 b=Ixrfz6bslIJAQLR54dv7iTouFDALE7MiGxI3DNBdXvXl40i92RJd9Bx9fPXAEvfsNmjJzF19MOUfcmyJHipPbQ51qXJ9vnc43fDIaMk869dmFvmZrvE6tXNozopTzc9C9nKSIH6mjMXqABqmnV05jFnEglU5+TfODXztU04JkBI=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5895.eurprd04.prod.outlook.com (2603:10a6:20b:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 18 Jun
 2020 01:58:51 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 01:58:51 +0000
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
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAA==
Date:   Thu, 18 Jun 2020 01:58:51 +0000
Message-ID: <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f9438cf-5c70-4df8-8c51-08d8132b25f9
x-ms-traffictypediagnostic: AM6PR04MB5895:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5895157FE6F25CC473DEF15C809B0@AM6PR04MB5895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wc+QUbu3NrTxY8s/F3DLhDN/YulAtJwcGY6kwPkqbq/Su0xTuz+KbGDvXx9ev7Ubw+KjWjB7UB1wu4up1YnN9MIaEoP1NYxYbN9oHKHV7EK+IhzQryPfD5DYgDFZoV24/fE2TopTxuk7RP+d9BZ3+ouRyHn+GArblX5+7vn8wXmthdZLcHjFXgOCLunjzsjXffF84KF25OCuDkT4M/watyBIy47vLIKLp7IcSvGKaIQ6g2HAtu6bXGyVUq9G86jkbpAJAiTU2qhYHLOj9/xYj72wrVocsPS1dBe9l0bWgrZ0HqoogwWthR0tvdHCTUdwNjw1gLtUX1YSkgHQXxBaBlIip6bO+HoGiNMbEvfyYbXXP2g80qHVcpJGtPF0s/E3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(44832011)(66476007)(66946007)(66446008)(64756008)(66556008)(8936002)(186003)(2906002)(7416002)(76116006)(316002)(53546011)(55016002)(6506007)(7696005)(9686003)(478600001)(86362001)(33656002)(26005)(8676002)(71200400001)(4326008)(52536014)(5660300002)(110136005)(83380400001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D4M2qAbuHMVItlIQjH9X+mLDkFq8xcsow0ITU6x/zgT66mQMOFXvOZXraokbhs5dfipCql6BT5c5MiKhhlKHmhO0vk3bNBZiuJ/uzdUj6wqtx/BHVeBHl6ZYfjdBQDWd35rjGKb1A/PoEMQ47MPmSuQkfcW1u35iWjgCpWunZwubWgqtwz8ZqNRQLKNRWqB592f2ofo3ZNyC5uLRha7NHlW6Ax3646ES5athVzIJfUCIw2/ac0zbroW2agq27RDScTLqUTdtO3cQWApltg/xJjpIHr+L+r2ZKgm4CRcNNN3WHQKvG2a7q2WlYUX6PR1tqIw1lPW1hMQXVHDm3M/fdNx0rb8gwLNG2OKu6wV0fUTRSbSqgU/CCU95r5t0uus5VOG8cF9tsR8jWR9+RA74Cjk8lvtlCVXgAARxUmIXWgM5ncH0DXxjpS3in4TGK42asV+NRkFNa3npTJ3GHm7Nu2gKQORKS08bwQxfPhYYJiITXH/h775alL6U79mmCf9j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9438cf-5c70-4df8-8c51-08d8132b25f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 01:58:51.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KB1v+NghntJ6N+YB6dWI50KDQ/akWmP+2fqhrQEqpGh9esE/dUPrNekz/mvj9WHcROs/6ppgzS8TFFEWXeVgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDE3LCAyMDIwIDg6MjcgUE0NCj4gDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggVjIgMy85XSBjbGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiBkcml2
ZXIgYXMgbW9kdWxlDQo+ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0Bu
eHAuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgSnVuZSA5LCAyMDIwIDM6MzIgUE0NCj4gPiA+
DQo+ID4gPiBUaGVyZSBhcmUgbW9yZSBhbmQgbW9yZSByZXF1aXJlbWVudHMgb2YgYnVpbGRpbmcg
U29DIHNwZWNpZmljDQo+ID4gPiBkcml2ZXJzIGFzIG1vZHVsZXMsIGFkZCBzdXBwb3J0IGZvciBi
dWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+ID4gPiBtb2R1bGUgdG8gbWVldCB0aGUgcmVx
dWlyZW1lbnQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgc2luY2UgVjE6DQo+ID4g
PiAJLSBhZGQgQVJDSF9NWEMgdG8gYnVpbGQgZGVwZW5kZW5jeSB0byBhdm9pZCBidWlsZCBmYWls
IG9uIHg4NiBhcmNoOw0KPiA+ID4gCS0gbW92ZSBjbGstbHBjZy1zY3UuYyBjaGFuZ2UgaW4gdG8g
dGhpcyBwYXRjaC4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvY2xrL2lteC9LY29uZmlnICAg
ICAgICB8IDQgKystLQ0KPiA+ID4gIGRyaXZlcnMvY2xrL2lteC9NYWtlZmlsZSAgICAgICB8IDUg
KystLS0NCj4gPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWxwY2ctc2N1LmMgfCAxICsNCj4gPiA+
ICBkcml2ZXJzL2Nsay9pbXgvY2xrLXNjdS5jICAgICAgfCA1ICsrKysrDQo+ID4gPiAgNCBmaWxl
cyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL2lteC9L
Y29uZmlnIGluZGV4DQo+ID4gPiBkYjAyNTNmLi5kZWQwNjQzIDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9jbGsvaW14L0tjb25maWcNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9LY29u
ZmlnDQo+ID4gPiBAQCAtNSw4ICs1LDggQEAgY29uZmlnIE1YQ19DTEsNCj4gPiA+ICAJZGVmX2Jv
b2wgQVJDSF9NWEMNCj4gPiA+DQo+ID4gPiAgY29uZmlnIE1YQ19DTEtfU0NVDQo+ID4gPiAtCWJv
b2wNCj4gPiA+IC0JZGVwZW5kcyBvbiBJTVhfU0NVDQo+ID4NCj4gPiBLZWVwIHRoaXMgbGluZSBh
cyBpdCBpcw0KPiA+DQo+ID4gPiArCXRyaXN0YXRlICJJTVggU0NVIGNsb2NrIg0KPiA+DQo+ID4g
aS5NWCBTQ1UgQ2xvY2sgY29yZSBkcml2ZXINCj4gPg0KPiA+ID4gKwlkZXBlbmRzIG9uIEFSQ0hf
TVhDICYmIElNWF9TQ1UNCj4gPiA+DQo+ID4gPiAgY29uZmlnIENMS19JTVg4TU0NCj4gPiA+ICAJ
Ym9vbCAiSU1YOE1NIENDTSBDbG9jayBEcml2ZXIiDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbGsvaW14L01ha2VmaWxlIGIvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlDQo+ID4gPiBpbmRl
eCA5MjhmODc0Li4xYWY4Y2ZmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L01h
a2VmaWxlDQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUNCj4gPiA+IEBAIC0y
MSw5ICsyMSw4IEBAIG9iai0kKENPTkZJR19NWENfQ0xLKSArPSBcDQo+ID4gPiAgCWNsay1zc2Nn
LXBsbC5vIFwNCj4gPiA+ICAJY2xrLXBsbDE0eHgubw0KPiA+ID4NCj4gPiA+IC1vYmotJChDT05G
SUdfTVhDX0NMS19TQ1UpICs9IFwNCj4gPiA+IC0JY2xrLXNjdS5vIFwNCj4gPiA+IC0JY2xrLWxw
Y2ctc2N1Lm8NCj4gPiA+ICtteGMtY2xrLXNjdS1vYmpzICs9IGNsay1zY3UubyBjbGstbHBjZy1z
Y3Uubw0KPiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xLX1NDVSkgKz0gbXhjLWNsay1zY3Uubw0K
PiA+DQo+ID4gTGlrZSBpLk1YIHBpbmN0cmwsIEknbSBub3Qgc3VyZSBpZiBpdCdzIHJlYWxseSBu
ZWNlc3NhcnkgdG8gYnVpbGQgY29yZQ0KPiA+IGxpYnJhcmllcyBhcyBtb2R1bGVzLiBQcm9iYWJs
eSB0aGUgc2ltcGxlc3Qgd2F5IGlzIG9ubHkgYnVpbGRpbmcNCj4gPiBwbGF0Zm9ybSBkcml2ZXJz
IHBhcnQgYXMgbW9kdWxlLiBBbmQgbGVhdmUgdGhvc2UgY29yZSBsaWJyYXJpZXMgYnVpbHQgaW4g
a2VybmVsLg0KPiA+IFRoaXMgbWF5IG1ha2UgdGhlIGNvZGUgYSBiaXQgY2xlYW5lci4NCj4gPg0K
PiANCj4gV2lsbCBkaXNjdXNzIHRoaXMgd2l0aCBMaW5hcm8gZ3V5cyBhYm91dCBpdCwgcHJldmlv
dXMgcmVxdWlyZW1lbnQgSSByZWNlaXZlZCBpcyBhbGwNCj4gU29DIHNwZWNpZmljIG1vZHVsZXMg
bmVlZCB0byBiZSBidWlsdCBhcyBtb2R1bGUuDQo+IA0KDQpPa2F5LiBBRkFJSyBpdCdzIG5vdCBj
b25mbGljdC4NCllvdSBzdGlsbCBtYWtlIGRyaXZlcnMgaW50byBtb2R1bGVzLg0KT25seSBkaWZm
ZXJlbmNlIGlzIGZvciB0aG9zZSBjb21tb24gbGlicmFyaWVzIHBhcnQsIHdlIGRvbid0IGNvbnZl
cnQgdGhlbSBpbnRvIG1vZHVsZQ0KV2hpY2ggaXMgbGVzcyBtZWFuaW5nbGVzcy4NCiANClJlZ2Fy
ZHMNCkFpc2hlbmcNCg0KPiBBbnNvbg0K

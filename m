Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FBEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503B6206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MAi4JunA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgFWDm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:42:26 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:9881
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728526AbgFWDmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:42:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhz9iJ0xS15bybhkoROtJ33soIqo54m5a9ay5pKjhaI5+iLPh2K4yLEXhCHVr9CUTKRsNxxuFRJWfgUvHM8T5BLACwA1zqXedS5t25kktD8WujYiPCct2G0tK+bYsdVSOTDEHA2fSd2snXVHLB0Qj9988TRiW8acxwHVlbjocAYs8UQQzWCkRbTMusEc7a+Gzu/nZmEV20Y7AOKMF10zj4HLfhhA2rAI3tAY85IZuY3VIdknceIvJnc7cTEa93uWwdTkfGAsWNsIuE9XV6nrqqJE9oDb1Me5H0D6svNW1jmlOOd0Op13SYmxNoAOOrrL7JORPJ9k6X4ucca4cPzGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r/iFQSszR5fqUSx/kNmXLCmJpQD7FO4H8wKvct06mw=;
 b=M4tJNvsSMGreJ3/3MhQf439Q1eBDWmcjOkJI9C8LhcPJHsGJHHQMcFRc7pX6+lUUD2Rkjn3EKnP8/pfPbqUdwnwk+yuW8mTWsqsX0Tw+dH5zfzQJXJcL55XyA1+OsjTRV/DcmsuqvO96FQyLDEWRkrxyMHwat3HeiG9qg+ElA8O0nOfhPByosh4CcH/uQG8+zfYby+4+E48fn2sh9ewHaxVAJ2q27m+B+wsZHcrJ4jTHD+qIgR4AT2PaNi0Q3E0utwoLUsUz9p2IqJiM/QqCqzURYAUMG3H+j1uFIc8GEqqBL2/jHTZjy/a45fEin1TXVIZzCHLKbKkNayBIsWSuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r/iFQSszR5fqUSx/kNmXLCmJpQD7FO4H8wKvct06mw=;
 b=MAi4JunAhhrC80XFkQGMrkVpNuf0lAgJuPolX5Q8Lnf9n475JKyAPqBTlRizn/Wt+DSwUCLQuzC0XfL2UjwFrhuVFlGIhFSZ3NwU3xqpnxsXtBXPAcJ6lGSu3C8OWn0vt9Maviw8pFoEaMWeIWkoFfenfcaHTwLKIJHS7uyPKzg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5831.eurprd04.prod.outlook.com (2603:10a6:20b:a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 03:42:19 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 03:42:19 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAIADPk4AgASxvPA=
Date:   Tue, 23 Jun 2020 03:42:19 +0000
Message-ID: <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
In-Reply-To: <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 31300c8c-0e83-418e-143d-08d817276e4c
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5831EC6081F6C820F96BB20F80940@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+XIPgBXtzVB9SG73ZTobx0AksXn+edD3P8tcJcyW2d16YXI4IJIaVjchlpTWmAOxmQh9Im+rgvOZuX3jw1tUrh3YbkAanSjMsP9QSzfAn+aAO+bMu4qj3I66yRCSQBY+4eckc6rOcmm4PFED+nO0u4MN6txIM4df3HzFIAakj7mzOaK+0qsFyoxuci6PWY2QgDrRPk3uIRVRXApkn23XPWL26BtRr1Rz4e5B0zX7YClqAKLj1KNuCTTBUlyVu/BIzi3E0wOMiU75F5XzF4ZSGq6IOZRYPIm1WxmCunNdJ5UxrCMXdNsz7V0fCQqcELYzoXpU73e3dGeqKscYx0yHX7Au6kWtMJ/60sEvB6eri65GUroQgfMXsbusNe8Nw2uyRZoGem0JLbSKOE71qsc1Czqany0OrM+E8pJdx57CAf1rJWjLpl+y8Yj4e8O87Qi83zU3bJSbAdwBey4SEFMMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(44832011)(76116006)(26005)(7416002)(478600001)(52536014)(2906002)(5660300002)(186003)(316002)(110136005)(33656002)(8936002)(6506007)(64756008)(66446008)(66476007)(66556008)(8676002)(66946007)(4326008)(7696005)(83380400001)(86362001)(71200400001)(55016002)(9686003)(966005)(53546011)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BMMIMAgEExXvzDxPOHq/teeOfnKb094KQ0VeGutZJhjB03ehAlnl7300OLcwv+NNN4dTsRob4CtWmH6PBrTeQ0NHSyu3Ni5U782yD+aOIT+8tWhkmyjXnz9EbCSQz6gJPqXbh4lOgulQhammCBsqzAF701u3j5Rbr03izI0lND1K7Zc6v4DNg3LAUwqYH3vcVS1wv+BpvXkshvplzj1kweQx29jBZ9CiSIsUBw3rw9XLae+Z35moiA1chjG5xw1tAiDU8rAKlIhF82OsqkOTKil7p5Eh4XuEevolUj0/Qw0fc7MB/zsYoBJE76QVGsCXq8+gpgDHH7JfPWt2Qoi4u6xtsbz4ZynbiDTBQSFpkhNnFHE5WJiziHc7CGrAJy+A3XyFbYzEMrvAvVHPt0T+ucusaSERr6S4VgqpXfcTQWF6w68mdTDno53abBV2dKxb+DEqScEQ1fg/Naj0nyJH180Wrr/cBUqizd+qKlKYa14=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31300c8c-0e83-418e-143d-08d817276e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 03:42:19.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irajU0LNn3gN/Z2RTy9wg4Fu5FeBGkfOxhSA101XYnmbdoIhsNmcBXCLLr8UtrAc3a6HsEb3DYnkfmIeKOPa7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5
LCBKdW5lIDIwLCAyMDIwIDExOjI4IEFNDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85XSBj
bGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0K
PiANCj4gUXVvdGluZyBBaXNoZW5nIERvbmcgKDIwMjAtMDYtMTcgMTg6NTg6NTEpDQo+ID4gPiBG
cm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiArb2JqLSQo
Q09ORklHX01YQ19DTEtfU0NVKSArPSBteGMtY2xrLXNjdS5vDQo+ID4gPiA+DQo+ID4gPiA+IExp
a2UgaS5NWCBwaW5jdHJsLCBJJ20gbm90IHN1cmUgaWYgaXQncyByZWFsbHkgbmVjZXNzYXJ5IHRv
IGJ1aWxkDQo+ID4gPiA+IGNvcmUgbGlicmFyaWVzIGFzIG1vZHVsZXMuIFByb2JhYmx5IHRoZSBz
aW1wbGVzdCB3YXkgaXMgb25seQ0KPiA+ID4gPiBidWlsZGluZyBwbGF0Zm9ybSBkcml2ZXJzIHBh
cnQgYXMgbW9kdWxlLiBBbmQgbGVhdmUgdGhvc2UgY29yZSBsaWJyYXJpZXMNCj4gYnVpbHQgaW4g
a2VybmVsLg0KPiA+ID4gPiBUaGlzIG1heSBtYWtlIHRoZSBjb2RlIGEgYml0IGNsZWFuZXIuDQo+
ID4gPiA+DQo+ID4gPg0KPiA+ID4gV2lsbCBkaXNjdXNzIHRoaXMgd2l0aCBMaW5hcm8gZ3V5cyBh
Ym91dCBpdCwgcHJldmlvdXMgcmVxdWlyZW1lbnQgSQ0KPiA+ID4gcmVjZWl2ZWQgaXMgYWxsIFNv
QyBzcGVjaWZpYyBtb2R1bGVzIG5lZWQgdG8gYmUgYnVpbHQgYXMgbW9kdWxlLg0KPiA+ID4NCj4g
Pg0KPiA+IE9rYXkuIEFGQUlLIGl0J3Mgbm90IGNvbmZsaWN0Lg0KPiA+IFlvdSBzdGlsbCBtYWtl
IGRyaXZlcnMgaW50byBtb2R1bGVzLg0KPiA+IE9ubHkgZGlmZmVyZW5jZSBpcyBmb3IgdGhvc2Ug
Y29tbW9uIGxpYnJhcmllcyBwYXJ0LCB3ZSBkb24ndCBjb252ZXJ0DQo+ID4gdGhlbSBpbnRvIG1v
ZHVsZSBXaGljaCBpcyBsZXNzIG1lYW5pbmdsZXNzLg0KPiA+DQo+IA0KPiBXaGF0IGlzIHRoZSBi
ZW5lZml0IG9mIG1ha2luZyB0aGUgY29yZSBwYXJ0IG9mIHRoZSBTb0MgZHJpdmVyIG5vdCBhIG1v
ZHVsZT8NCg0KVXN1YWxseSB3ZSBjb3VsZCB0cnkgdG8gYnVpbGQgaXQgYXMgbW9kdWxlIGlmIGl0
J3Mgbm90IGhhcmQuDQoNCk9uZSBxdWVzdGlvbiBpcyBzb21ldGltZXMgdGhvc2UgY29yZSBwYXJ0
IGFyZSBzaGFyZWQgd2l0aCBzb21lIHBsYXRmb3JtcyB3aGljaCBjYW4ndCBidWlsdCBhcyBtb2R1
bGUuDQpGb3IgaS5NWCBjYXNlLCBpdCdzIG1haW5seSBwYXRjaCA0Og0KW1YyLDQvOV0gY2xrOiBp
bXg6IFN1cHBvcnQgYnVpbGRpbmcgaS5NWCBjb21tb24gY2xvY2sgZHJpdmVyIGFzIG1vZHVsZQ0K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTU5NDgwMS8NCg0KVGhvc2UgbGli
cmFyaWVzIGFyZSBhbHNvIHVzZWQgYnkgaS5NWDYmNyB3aGljaCBjYW4ndCBidWlsZCBhcyBtb2R1
bGUuDQpTbyB3ZSBuZWVkIGFuIGV4dHJhIHdvcmthcm91bmQgcGF0Y2ggdG8gZm9yY2VseSAnc2Vs
ZWN0JyBpdCB1bmRlciBhcmNoL2FybS9tYWNoLWlteC9LY29uZmlnDQpbVjIsMi85XSBBUk06IGlt
eDogU2VsZWN0IE1YQ19DTEsgZm9yIEFSQ0hfTVhDDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3BhdGNoLzExNTk0NzkzLw0KVGhlbiB0aGUgdXNlcnMgY2FuJ3QgY29uZmlndXJlIGl0IGFz
IG1vZHVsZSBpbiBvcmRlciB0byBub3QgYnJlYWsgYnVpbGQuDQoNCklmIGJ1aWxkLWluIHRob3Nl
IGNvbW1vbiBsaWJyYXJpZXMsIHRoZSBpbXBsZW1lbnRhdGlvbiBjb3VsZCBiZSBhIGJpdCBlYXNp
ZXIgYW5kIGNsZWFuZXIuDQpTbyBJJ20gbm90IHN1cmUgaWYgd2Ugc3RpbGwgaGF2ZSB0byBidWls
ZCB0aGVtIGFzIG1vZHVsZS4NCkhvdyB3b3VsZCB5b3Ugc3VnZ2VzdCBmb3Igc3VjaCBjYXNlPw0K
DQo+IEZyb20gdGhlIG1vZHVsZSBwZXJzcGVjdGl2ZSBpdCBzaG91bGQgYmUgcGVyZmVjdGx5IGZp
bmUgdG8gbWFrZSBpdCBhIG1vZHVsZSBhcw0KPiB3ZWxsLCBhbmQgdGhlbiBkZXBtb2Qgd2lsbCBz
b3J0IG91dCBsb2FkaW5nIG1vZHVsZXMgaW4gdGhlIHJpZ2h0IG9yZGVyLg0KPiANCj4gVGhpcyBp
cyBmb3IgYW5kcm9pZCByaWdodD8NCg0KWWVzLCBmb3IgQW5kcm9pZCBHS0kgc3VwcG9ydC4NCg0K
UmVnYXJkcw0KQWlzaGVuZw0K

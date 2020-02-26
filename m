Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA486C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FDC21744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UoP/xWxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgBZC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:56:48 -0500
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:15331
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728989AbgBZC4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:56:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT65n8YQfvtIUgrF567cYkMbFY0u6xuDzxpaA4d5OCOh/QprK2RMAI9ik49952dcRlIlYUK9e11QKP75H4fp8Nu0cLFSNG+8nsqiAk8UfMno82YslyQ0/OoXF0rYjS6PzEbSOaXy8AgYanmRm3kMCGUrweL13UAK+Ub147jkCkqhMA+D4yXiTYJn5zg7QIqdA1b1XbBo18egYK2vdqz4UD9C6JRpJlISaWV+fOX2pRGnG0Bim7ia4dbru1yX2GgiQidOkSYUr2W5ZJe0/mqLNdFIHAymaXpRHdntIybAMQm+ETVU6cF4MhvZqfUZXvPECXljJcDlqEPBC9hpYpE34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkC16IAxrfYoBhPcBghxfMT+/kQNhYDyPxaoUDSSJG0=;
 b=Sz8pUVvsMiXT2hU8cvXVsHSKwaRTT9j40scgE8EBH7zibm/tykurFVpYePj3r9v6np2fVff16ftdTFo2AL/3lppM8vHyZUkddyUzxq4XMMH+UOk3CbmVXv1XDL/nUWmA3UE/NPEt5YXn6PYdB7hOzf6OJ7VccnrpgmH2LjRGtB1o6Z6ydFC0iM3+TdwLsHGfQdmUp8kynrzNKxeJqTmcX/3V+1SlZ7y5fKm3p0A54s097G2SXuGz0GE5pL2YuBu2dHfNQZKHrCmBhteqYS60dkIyFPy9KmAdXpOhAoZ4ai94ChvYiCg+PKDrNDRO3KODWgkLybohnU2k77+Yqb+3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkC16IAxrfYoBhPcBghxfMT+/kQNhYDyPxaoUDSSJG0=;
 b=UoP/xWxbdXursMpPKhjb8o8NK68Rzj9XwBC8x+pE4QWg2/0hh/OBVbPnVDowpBKfWy04P9cXFa+N1RyPJXjXVapdZWKCqsli9v9QzJ1eCKjJAcorMLmYK7vyzrIBARphSd0N2PTJ4a4GcV2cARf3iWKDbXt7YoxNWgZxJID4dLg=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5995.eurprd04.prod.outlook.com (20.178.107.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 02:56:44 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 02:56:44 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] clk: imx8: Add SCU and LPCG clocks for I2C in CM40 SS
Thread-Topic: [PATCH 2/7] clk: imx8: Add SCU and LPCG clocks for I2C in CM40
 SS
Thread-Index: AQHV5UIQzDG739vOdEefzni3O2DFrqgsP5qAgACTgBA=
Date:   Wed, 26 Feb 2020 02:56:44 +0000
Message-ID: <DB7PR04MB46183E18F10C5B1B1F214DCCE6EA0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-3-git-send-email-qiangqing.zhang@nxp.com>
 <20200225175735.GA5232@bogus>
In-Reply-To: <20200225175735.GA5232@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [222.93.202.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29ee1899-5184-4fb4-6e3b-08d7ba67839d
x-ms-traffictypediagnostic: DB7PR04MB5995:|DB7PR04MB5995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5995F5BAAB4A56B9EE6AF54EE6EA0@DB7PR04MB5995.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(26005)(66476007)(33656002)(52536014)(76116006)(86362001)(7416002)(6916009)(53546011)(478600001)(71200400001)(66946007)(5660300002)(81156014)(9686003)(7696005)(55016002)(64756008)(316002)(6506007)(54906003)(66556008)(8936002)(81166006)(186003)(2906002)(8676002)(4326008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5995;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0J7xK+g6GWIShZuHWPF52IL3qtYEFoU/BdxV6cx1i4626H8mlwmuQAkIRjXlpCZa5ZOxfENoc7MkbZOaxH9OqD7Jiy/9lLEzzB9FegIxo+p0pZ5Nyclu18OxFhlQ1gvkyfK1RxgWM23hDnbjNPFWwHwVYhfbW7VCRelj9Jmh0ipBDIEO6o/hPNCskacQObU6mkbFa/enJtOC7QBRchffZ9JoXHAlMWbTUvZHjXt2947qmb6QXyoZB4xGpe9cAiK+ORDaDdSu+IessaNt91GjL5R+M5SO1s9pk2dIFCv5jGaHgiQiOBldQZhUU5R3WXwbUDl3aBvig8WFH9g4U5lxJb9josHSHGlxAKYrM4L9gJ6yCWJm7nUobXawYXqZaIT5YvmZtYbTVrw+Z8TVvHif9nC88QV5ygR3CWFDOgEw14Jmnw6yi+OxyaZjL86vCDN
x-ms-exchange-antispam-messagedata: TWVekSp/tsck1/e9nqhFANsilv6vDDN1eLI24uyqfeN7YWC6mKTfH2YG3vmjBQxCdW9FK2WO1myNwjJfrEf9KFUtlZBY8zzbYBIFKlFgHQ+nvvWi6BlPJFNH1NU1S5wb48lXs/02U3+5kIMNNHRUOQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee1899-5184-4fb4-6e3b-08d7ba67839d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 02:56:44.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8dJzI3HCGx1KxL9aUhXPKRgVbXeBZetIWOsjTwjt8WmS5fLLabk0wB/zTDQPfcJ31GAvI3Jl8PWGePStpoukQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5995
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jLUwjI2yNUgMTo1OA0KPiBUbzogSm9ha2ltIFpo
YW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IG10dXJxdWV0dGVAYmF5bGlicmUu
Y29tOyBzYm95ZEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRl
Ow0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+
OyBBbnNvbiBIdWFuZw0KPiA8YW5zb24uaHVhbmdAbnhwLmNvbT47IExlb25hcmQgQ3Jlc3RleiA8
bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+Ow0KPiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRh
QG54cC5jb20+OyBBaXNoZW5nIERvbmcNCj4gPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+OyBBbmR5IER1YW4NCj4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+
OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi83XSBjbGs6IGlteDg6IEFk
ZCBTQ1UgYW5kIExQQ0cgY2xvY2tzIGZvciBJMkMgaW4gQ000MCBTUw0KPiANCj4gT24gTW9uLCBG
ZWIgMTcsIDIwMjAgYXQgMTE6MTk6MTZBTSArMDgwMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+
IEFkZCBTQ1UgYW5kIExQQ0cgY2xvY2tzIGZvciBJMkMgaW4gQ000MCBTUy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OC1jbG9jay5oIHwgMTMgKysr
KysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sv
aW14OC1jbG9jay5oDQo+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4LWNsb2NrLmgN
Cj4gPiBpbmRleCA2NzNhOGM2NjIzNDAuLjg0YTQ0MmJlNzAwZiAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDgtY2xvY2suaA0KPiA+ICsrKyBiL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svaW14OC1jbG9jay5oDQo+ID4gQEAgLTEzMSw3ICsxMzEsMTIgQEAN
Cj4gPiAgI2RlZmluZSBJTVhfQURNQV9QV01fQ0xLCQkJCTE4OA0KPiA+ICAjZGVmaW5lIElNWF9B
RE1BX0xDRF9DTEsJCQkJMTg5DQo+ID4NCj4gPiAtI2RlZmluZSBJTVhfU0NVX0NMS19FTkQJCQkJ
CTE5MA0KPiA+ICsvKiBDTTQwIFNTICovDQo+ID4gKyNkZWZpbmUgSU1YX0NNNDBfSVBHX0NMSwkJ
CQkyMDANCj4gPiArI2RlZmluZSBJTVhfQ000MF9JMkNfQ0xLCQkJCTIwNQ0KPiA+ICsNCj4gPiAr
I2RlZmluZSBJTVhfU0NVX0NMS19FTkQJCQkJCTIyMA0KPiANCj4gV2h5IGFyZSB5b3Ugc2tpcHBp
bmcgbnVtYmVycz8NCkhpIFJvYiwNCg0KSSBmb3VuZCB0aGF0IHRoZXJlIGlzIGEgZ2FwIGluIFND
VSBjbG9jayBiZXR3ZWVuIHN1YnN5c3RlbSwgc29tZSBudW1iZXJzIGNvdWxkIGJlIHJlc2VydmVk
IGZvciBkZXZpY2VzIHdoaWNoIG1heSBiZSBhZGRlZCBpbnRvIHRoaXMgc3Vic3lzdGVtIGluIHRo
ZSBmdXR1cmUuIA0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gPiArDQo+ID4NCj4g
PiAgLyogTFBDRyBjbG9ja3MgKi8NCj4gPg0KPiA+IEBAIC0yOTAsNCArMjk1LDEwIEBADQo+ID4N
Cj4gPiAgI2RlZmluZSBJTVhfQURNQV9MUENHX0NMS19FTkQJCQkJNDUNCj4gPg0KPiA+ICsvKiBD
TTQwIFNTIExQQ0cgKi8NCj4gPiArI2RlZmluZSBJTVhfQ000MF9MUENHX0kyQ19JUEdfQ0xLCQkJ
MA0KPiA+ICsjZGVmaW5lIElNWF9DTTQwX0xQQ0dfSTJDX0NMSwkJCQkxDQo+ID4gKw0KPiA+ICsj
ZGVmaW5lIElNWF9DTTQwX0xQQ0dfQ0xLX0VORAkJCQkyDQo+ID4gKw0KPiA+ICAjZW5kaWYgLyog
X19EVF9CSU5ESU5HU19DTE9DS19JTVhfSCAqLw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==

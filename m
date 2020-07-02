Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A107AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751AC2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JhVrJPfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgGBGPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:15:11 -0400
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:19331
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbgGBGPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi/YgY8lwfPK41E6wJr+CjC5Wy5XxXqqd4Aa74r6vfhrzBO2nB0ubHqLFptbKDdfG7tHnbg8NlbJ8UqzrRaqSkDzPH4mrRKwPp6KI6eUD0qSFCxGOxB7p8QbRf2zgt5SRJzVvTDopiha3tmICA9Z0fE4po34B0i6+n5HAuUHVDdUvFt39vkbOOhueD1hcjH8uRJWyZCvJpUZqSu4DgcYxiORQnmlNGprkgp/KkrgPkIxHZ8qM0HoOSNux++vBBG/EdskebaHBTwM5GSjE99o58UBzszsqQfHMFx12nSYCY9q8qNDvBsgtg+zR+kHvnEzesQTgeLJTRlxn31X2h0jAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn3bi1LLuPgJzIHElEa5S2jvTP8xh4wCwP0j0+nSPHg=;
 b=RpQJLy98cXekEdT0aaTpwOSAcbCdEcq2QtrhjZRFtO8/BTArZqIVqwUy6hml8g6Oq830WMrxuIJ/n+pRylZn1IwsBsGJm/3tZcIIhY1ZGAnWGUttZF5XvnjhlVVJssrynORUlDyLX6TR+e+HYK79Gho7s0HAjXm+M2BKliS+ljJadD7heXOu6juNFDyGPS2DMY8UvlFdykwaaUwYfio+g737xWCRCVkw7eFgdPGFCVs0VaFfojA8WC5EmEA4X6vz75iQ7YUwGf0mq1ZPHBvMsJ9WFs8HzQ5ZcnxCd62T2y0A1HOzkvo70qGBLx5k2PSXkZitefukrKfZ8k15DNbfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn3bi1LLuPgJzIHElEa5S2jvTP8xh4wCwP0j0+nSPHg=;
 b=JhVrJPfo8BkwZS1ddTeVZv5A4DqxkoOStezVxAiFqxvQ69oiHxANdouvfS2EbOhqvGJRcCV4R62jL36qL4mhpGYjGil0/AoltvtAVLSZofyTuxwWYJkdfSoUKTangk+bR8SLuwfMdIlI0GuBj70IbqZm+Sqd4k3klwOuTAUBnww=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10) by AM5PR04MB2946.eurprd04.prod.outlook.com
 (2603:10a6:206:b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 06:15:06 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::8df1:e619:369e:404f%4]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 06:15:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <dongas86@gmail.com>
CC:     Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Abel Vesa <abel.vesa@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Allison Randal <allison@lohutok.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ARM/FREESCALE IMX / MXC ARM ARCHITECTURE 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        gregkh <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Enrico Weigelt <info@metux.net>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGlTieDV0WYc0SOGNv5XMQ0F6jcrBWAgAAcNCCAAONagIADPYYAgAS7CoCAAFGNAIAAB26AgAELZ4CAABbpgIAAA6hggAAHU4CAAUrDAIAG1X0AgAAU+gCAANX3gIADu/vQ
Date:   Thu, 2 Jul 2020 06:15:05 +0000
Message-ID: <AM6PR0402MB391135EDF34C7207AC37D42DF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com>
 <CAA+hA=RB3H_EqCMpCuide7WDqddaZu5=LmihU1pZaCPM8b8zng@mail.gmail.com>
 <CAK8P3a2-1nFvw2rR1wws04fCmj6AyvcJ4RFwcJQ+xRPwDjUCaA@mail.gmail.com>
 <159346473301.62212.686512161256425690@swboyd.mtv.corp.google.com>
In-Reply-To: <159346473301.62212.686512161256425690@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61c7d1d2-81c4-4fc4-8dbd-08d81e4f43ef
x-ms-traffictypediagnostic: AM5PR04MB2946:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB294648CE941695DD8ACF7C65F56D0@AM5PR04MB2946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VbipZ0Ph6BrvSKRpMBeorDt9kqwuTDx7rC8sFG+h6y/l5Haf1hXV02R3eM8GMBNhQh2g47HGpG/3Rf+x5waD1cmS7yBKyiCjh2gdI7N4vm9R0UFHT22EKua+iEaXQpd6Sga00LBtS98sWuH4OY151WeDpcuNgx6N3OOqs6r96c6OIZNR8mTIgueljCyrAHv0ZlTt8MCE6Q8T3MQF2syVSrdkG3vdrvjDKiScjehx3wLU9bRyQucZBYENFhExcgHAzShbM9VQgURYSRMlpwjnuhm0Mos51HghAcbgAt2TejBbvG+CSK3UdE1Tj2ouQLc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(186003)(26005)(83380400001)(53546011)(6506007)(7696005)(55016002)(8936002)(71200400001)(8676002)(9686003)(7416002)(2906002)(110136005)(54906003)(33656002)(4326008)(316002)(86362001)(478600001)(66946007)(66476007)(76116006)(44832011)(52536014)(64756008)(66446008)(5660300002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: oNaytqgsiyqD3bEALnd/glRcRXmHAG7GxrIguXdaiPlNuaVryT3TyPo2LkfAW+LQeZWX60Ew4Y5cDUnRFCDCZtVgksN5ECh1Vh5u70CyfXUwDRAPIl5RSgySrlZDcAJZzRDYbyqeTOFxhOoTtUpxl7HrzYVY7R0IkPosTEjfH4FcYrvN6sCpz+ONzEqHMSulbnmilxtAua7vG5Yk4iyJgbx681QqnQCdXqmyLHmLiQyzFfLUVZJwngKdXxxBtogbJuXdIpZyXAlu0tDisQ7TJUILkmT8+WVZLIPohWN/QJF8dBl9E4YjSCEUrLp8G7iK176gAGg80vshoPs4GcCTsEtIQD87yFIWflVLI+x7Xo10odMueHUXQ6qL9BVAcugFZiu/EbtEDULybt8gtmkjaoDMJQ1/egEykSVCtUfMa4UROMOu3qSXRMM+IwcKt26O1a6sV1LQIpQvPCkYjf6vMF8o7jqpt8wZBmKfox3z+dKCya+Dc9DGVxo93+UB4qKj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3911.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c7d1d2-81c4-4fc4-8dbd-08d81e4f43ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 06:15:06.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IN2+W/0QmTxTaivjmUg+bYqiBq1Z4/7zpcU8WWHJQlyIAaxvRrG7DpsbXpFTgOZHDUneAVNJVjXxahzqh0++Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQvU3RlcGhlbg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMy85XSBjbGs6IGlt
eDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0KPiANCj4g
UXVvdGluZyBBcm5kIEJlcmdtYW5uICgyMDIwLTA2LTI5IDAxOjE5OjQ0KQ0KPiA+IE9uIE1vbiwg
SnVuIDI5LCAyMDIwIGF0IDk6MTggQU0gRG9uZyBBaXNoZW5nIDxkb25nYXM4NkBnbWFpbC5jb20+
DQo+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdW4gMjUsIDIwMjAgYXQgNjo0MyBBTSBTdGVwaGVu
IEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+ID4gPiBRdW90aW5nIEFpc2hl
bmcgRG9uZyAoMjAyMC0wNi0yMyAxOTo1OTowOSkgV2h5IGFyZW4ndCB0aGVyZQ0KPiA+ID4gPiBv
cHRpb25zIHRvIGVuYWJsZSBjbGstaW14NnEgYW5kIGNsay1pbXg2c2wgaW4gdGhlIGNsay9pbXgv
S2NvbmZpZw0KPiA+ID4gPiBmaWxlPyBUaG9zZSBjYW4gYmUgYm9vbCBvciB0cmlzdGF0ZSBkZXBl
bmRpbmcgb24gaWYgdGhlIFNvQw0KPiA+ID4gPiBkcml2ZXJzIHVzZSBDTEtfT0ZfREVDTEFSRSBv
ciBub3QgYW5kIGRlcGVuZCBvbiB0aGUgbXhjLWNsaw0KPiA+ID4gPiBsaWJyYXJ5IGFuZCBTb0Mg
Y29uZmlnIHdlIGhhdmUgaW4gdGhlIG1ha2VmaWxlIHRvZGF5Lg0KPiA+ID4NCj4gPiA+IFllcywg
d2UgY2FuIGRvIHRoYXQgaW4gY2xrL2lteC9LY29uZmlnIGFzIGZvbGxvd3MgdGhlb3JldGljYWxs
eS4NCj4gPiA+IGNvbmZpZyBDTEtfSU1YNlENCj4gPiA+ICAgICAgICAgYm9vbA0KPiA+ID4gICAg
ICAgICBkZWZfYm9vbCBBUkNIX01YQyAmJiBBUk0NCj4gPiA+ICAgICAgICAgc2VsZWN0IE1YQ19D
TEsNCj4gPiA+DQo+ID4gPiBCdXQgd2UgaGF2ZSB0b3RhbGx5IDE1IHBsYXRmb3JtcyB0aGF0IG5l
ZWQgdG8gY2hhbmdlLg0KPiA+DQo+ID4gSSB3b3VsZCBtYWtlIHRoYXQNCj4gPg0KPiA+IGNvbmZp
ZyBDTEtfSU1YNlENCj4gPiAgICAgICAgICBib29sICJDbG9jayBkcml2ZXIgZm9yIE5YUCBpLk1Y
NlEiDQo+ID4gICAgICAgICAgZGVwZW5kcyBvbiBTT0NfSU1YNlEgfHwgQ09NUElMRV9URVNUDQo+
ID4gICAgICAgICAgZGVmYXVsdCBTT0NfSU1YNlENCj4gPiAgICAgICAgICBzZWxlY3QgTVhDX0NM
Sw0KPiANCj4gWWVzLCBkbyB0aGlzLg0KDQpUaGUgQ09NUElMRV9URVNUIGV4aXN0aW5nIG9uIHRo
ZSBjb25maWcgd2lsbCBpbnRyb2R1Y2Ugc29tZSBidWlsZCBlcnJvcg0Kb24gb3RoZXIgQVJDSCdz
IGFsbHllc2NvbmZpZyBidWlsZCBvbiBpLk1YMi8zIHBsYXRmb3JtcywgSSByZWNlaXZlZCBzb21l
IGJ1aWxkIGVycm9yIHJlcG9ydC4NClNvIGluIG5leHQgcGF0Y2ggc2VyaWVzLCBJIHdpbGwgZHJv
cCB0aGUgQ09NUElMRV9URVNUIGZvciB0aGVzZSBuZXcgYWRkZWQgY2xvY2sgY29uZmlndXJhdGlv
bnMsDQphcyBJIHRoaW5rIGl0IGlzIE5PVCB3b3J0aCB0byBzdXBwb3J0IHRoZSBDT01QSUxFX1RF
U1QgZm9yIHRoZXNlIG9sZCBsZWdhY3kgcGxhdGZvcm1zIHdoaWNoIGFyZQ0KTk9UIHN1cHBvcnRl
ZCBiZWZvcmUuDQoNClRoYW5rcywNCkFuc29uDQoNCg0K

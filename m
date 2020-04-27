Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3AC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75252206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ThZEAUXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD0I6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:58:55 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:6159
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgD0I6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9f/fq3blev9rbCEpL2w1bNP3PjbUFV0NeHkTHd2YGB9CDQ2rLuqjhFpcT1nkRnol8dV3HqLpGPLKVAK1X3dOqo1BwyzBAVf34SqXI8O0zP8bYM+jpcaIIe6H5NlJFqNiAVGLtKddcQDFypFQTmg8aqbdSjj8wLLtBLKCwLZvBYxpx3ma3Bx631QgH/gJgBuba5ObG42Y8rHIdswfg1dLthU6SqakhzuzCQhO58zqrgvDNgvPwUNoEit9WUr5BkrnTlQp6pbSQ3oGJF9P5BWaLJWTG2P0PzD4Ox2wTkB6IrR23aPqBcql+RhtRJzHpwyq87CvFeMRFyS4SQuSNxj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+t0uo8/Q6dvV762NrAvxk+bHM+qr1Hptvt6C8Sglw=;
 b=kULDH4e7q2196XegGoo8p4WAW1rQCXzg4YxqmdtaHQrdn/H+Chitp1CZ7/9usCIusJ1qHjDLgmwd/iGAjnCHp4erLDcj975NguzrYtFj+q5g7curf4bhTY3mRNKetlCS2/aW7edMAaQbyC51tB/j2CGIrmf2gChEfCxKB0bLZKTyk2hhPA6Os1C+rQTx0Ofima3+zpTTkGjKWNddCCrpCqUPSe4sw9jAuY0ToBJ2XtjUMcz5thleftCwPNObR75uxGSkPG/KWGW1PxnyET9xEGX0RkcN2Tm7xhYTjeAbZW0qWDDc7i7hm9nmFBq/63y/MrQeZEnih2LrLEGmckoWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+t0uo8/Q6dvV762NrAvxk+bHM+qr1Hptvt6C8Sglw=;
 b=ThZEAUXk/VqPDZ7A2SqqjvGzmcnSwTKQaC5I3SUVOaQBm2BpDnYzIOL21Xy5sn+jlZBAIiSTG/ihCKZGtuFO3Lz7XxpXKPrSBhksPN8vjCKFtpWWwK6r5nKszFn9DjOXGpEXRzNnl04laI4YURHI1ycsbynvbo0aRK8Pr1zM5os=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:58:50 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:58:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: RE: [PATCH V2 06/10] clk: imx8m: migrate A53 clk root to use
 composite core
Thread-Topic: [PATCH V2 06/10] clk: imx8m: migrate A53 clk root to use
 composite core
Thread-Index: AQHV+FjKzuc7KbaUCkiuyqa70SF6FKiLGbaAgAHZnPA=
Date:   Mon, 27 Apr 2020 08:58:49 +0000
Message-ID: <DB6PR0402MB276031ADC7FB0209973655F588AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-7-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB49664159E56A48EC6C4CBCC880AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB49664159E56A48EC6C4CBCC880AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f433613-9d8d-4aed-15e9-08d7ea8933f4
x-ms-traffictypediagnostic: DB6PR0402MB2711:|DB6PR0402MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2711842FC7F027349FDC5DB588AF0@DB6PR0402MB2711.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(81156014)(8676002)(44832011)(33656002)(186003)(52536014)(110136005)(9686003)(7416002)(316002)(478600001)(54906003)(5660300002)(2906002)(8936002)(4326008)(55016002)(7696005)(6506007)(86362001)(26005)(6636002)(66556008)(64756008)(66446008)(76116006)(71200400001)(66476007)(66946007)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeyeVhKxajZgndDBHCjV/ZPYebI3+pfEMB3t0ic6LzdgyBMSCmtt9DDpidA4IZXvvo2kilD6hUJ5CUcozPA2dc9ohVwXArJxQ5R97mZG0jcM4beLenObCvEWXeZRLDwR7JUwm2d3s+FDxIovJR9KLrreiQi324nW5m2eknBzdudO1b1HmzGRxKuKfjrJj6A+Kfme2sa+h/5+pzxHGBQeVWPsYMAbifXAgdSCXGoLyWAHwyxcZPV2kAXVBOiooEZUj1HFXZA0POE4Sm0F7YpYUW4F7iztxUi+39nwlYQAy8W7RdqpS8AMw2sNrC2Sv9zKQBUzUZhydObCScVBdEjk3E7nQpelijtFhxm3wyp2Aba0cr+xok7DnfLuM8s79Fy9OGQ++c63oYgfTeNlbIzs6AIAGfpQ9SqbNWB1QVRHAEPTUnyjXEpgM0eieCM0vgRbhk4B3lNlqhvt7WIYUh4uxeek0MuXYFw7V84Yo5pEkYMzsYqNixv+un2Vvi6A76xy
x-ms-exchange-antispam-messagedata: AxW7748LINQh++khNOZLxSMZP01/fZ2qCKNVZ9lsLcWmuC5srU6U8yuKZAfXA4k/AuTjcsXQktl+AKAKFEUyqyftHddSID2aJ20KWBjAi7CnpHB/by22ahleWB/5jhOw2ygp1+crLeQpereKh+EfYUKFGmt0nWpYgeYBWZCEQF1baS8LjnAkRENOguxlhXZSkQBo/ZE8MNRon2n0MmHT6j4ZAOk/SVgbazYZqpij3gXjpp21dP8j6N+d29c/NSocONp5tauusNw11iwuSUbWv0kHcBvK0Nc1oRkSv5fWJ2B5s8Qxq+BVFB8T1MV2dFJODKcmMJTelRsTM3snwcuYSXqs2iMoehGCRLbFwNbHkqxSTiz6ah5haQmIGG3hmgvtiAtg1aRG7929aOBieB9YF8PiI4hqTa04bdBYlY8/ffMdov3nkkxMC6v3/nCdPIJcOGOm7AvFVglWk6eqynPK1fLFxXNkhuIp0HSNlK4B1iQAIe5kzYDukB10prGFaEmNRUOqMJQ64Pc3kHVtrRki6ecPhmLK93PwApoPZIFJqHmwVkKaxL65wb11t0NGxpRZUkYvGEFgIbmqyHbddNzxU1bfFRf8zb38/CZn7uNiEx8NnytQ9qncmAbSNlTfYH+jkK4qXZLZX8VEYofbIkdgZ3tsRZFKlIbgkonJZQadpPS4hXOfBTiHeiea/P66ydUwpXoq3P8VHwEfeQ5CV4YNkxHAknmpM0O0H+r56sAxqhN61/HVk31TKUZDmHeyv/OF9tKVAfE14csZV4N31/Q1w9jbZrlitCCWUdOgMlPvNeY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f433613-9d8d-4aed-15e9-08d7ea8933f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 08:58:49.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6U+NEGZGfR09G6NWal/2gnXHB+siy1yonW9MgNb7ssRhda/heJiryjo300LYNVZUDv531ownRFY7cj79LjzH3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDA2LzEwXSBjbGs6IGlteDhtOiBtaWdyYXRlIEE1MyBj
bGsgcm9vdCB0byB1c2UNCj4gY29tcG9zaXRlIGNvcmUNCj4gDQo+ID4gRnJvbTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIE1hcmNoIDEyLCAyMDIwIDY6
MjAgUE0NCj4gPg0KPiA+IE1pZ3JhdGUgQTUzIGNsayByb290IHRvIHVzZSBjb21wb3NpdGUgY29y
ZSBjbGsgdHlwZS4gSXQgd2lsbCBzaW1wbGlmeQ0KPiA+IGNvZGUgYW5kIG1ha2UgaXQgZWFzeSB0
byB1c2UgY29tcG9zaXRlIHNwZWNpZmljIG11eCBvcGVyYXRpb24uDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9jbGsvaW14L2Nsay1pbXg4bW0uYyB8IDYgKysrLS0tICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlt
eDhtbi5jDQo+ID4gfCA2DQo+ID4gKysrLS0tICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5j
IHwgNiArKystLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4
bW0uYw0KPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYyBpbmRleA0KPiA+IDU0MzUw
NDJhMDZlMy4uMTI0NDNlMDZmMzI5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1tLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jDQo+ID4g
QEAgLTQxNiw5ICs0MTYsOSBAQCBzdGF0aWMgaW50IGlteDhtbV9jbG9ja3NfcHJvYmUoc3RydWN0
DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJldHVybiBQVFJfRVJSKGJhc2Up
Ow0KPiA+DQo+ID4gIAkvKiBDb3JlIFNsaWNlICovDQo+ID4gLQlod3NbSU1YOE1NX0NMS19BNTNf
U1JDXSA9IGlteF9jbGtfaHdfbXV4MigiYXJtX2E1M19zcmMiLA0KPiBiYXNlICsNCj4gPiAweDgw
MDAsIDI0LCAzLCBpbXg4bW1fYTUzX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1tX2E1M19zZWxzKSk7
DQo+ID4gLQlod3NbSU1YOE1NX0NMS19BNTNfQ0ddID0gaW14X2Nsa19od19nYXRlMygiYXJtX2E1
M19jZyIsDQo+ID4gImFybV9hNTNfc3JjIiwgYmFzZSArIDB4ODAwMCwgMjgpOw0KPiA+IC0JaHdz
W0lNWDhNTV9DTEtfQTUzX0RJVl0gPSBpbXhfY2xrX2h3X2RpdmlkZXIyKCJhcm1fYTUzX2RpdiIs
DQo+ID4gImFybV9hNTNfY2ciLCBiYXNlICsgMHg4MDAwLCAwLCAzKTsNCj4gPiArCWh3c1tJTVg4
TU1fQ0xLX0E1M19ESVZdID0NCj4gPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2NvcmUoImFybV9h
NTNfZGl2IiwgaW14OG1tX2E1M19zZWxzLCBiYXNlICsNCj4gPiAweDgwMDApOw0KPiA+ICsJaHdz
W0lNWDhNTV9DTEtfQTUzX0NHXSA9IGh3c1tJTVg4TU1fQ0xLX0E1M19ESVZdOw0KPiA+ICsJaHdz
W0lNWDhNTV9DTEtfQTUzX1NSQ10gPSBod3NbSU1YOE1NX0NMS19BNTNfRElWXTsNCj4gDQo+IFRo
ZSBmb3JtZXIgcGF0Y2ggYWxyZWFkeSBicmVha3MgdGhlIGNvbXBhdGliaWxpdHkuDQo+IE5vdCBz
dXJlIGlmIHdlIHJlYWxseSBuZWVkIGtlZXAgaXQgZm9yIG9ubHkgQTUzIGNsb2NrIGhlcmUgYXMg
d2UgYXJlIHN0aWxsIGF0DQo+IHZlcnkgZWFybHkgZW5hYmxlbWVudCBQaGFzZSBmb3IgTVg4TVAu
ICBTbyB3ZSBtYXkganVzdCByZW1vdmUgdGhlbQ0KPiBJTUhPLg0KDQppLk1YOE1NLCBub3QgaS5N
WDhNUC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiBTaGF3biwgd2hhdCdzIHlvdXIgc3VnZ2VzdGlv
bj8NCj4gDQo+IFJlZ2FyZHMNCj4gQWlzaGVuZw0KPiANCj4gPg0KPiA+ICAJaHdzW0lNWDhNTV9D
TEtfTTRfQ09SRV0gPQ0KPiA+IGlteDhtX2Nsa19od19jb21wb3NpdGVfY29yZSgiYXJtX200X2Nv
cmUiLCBpbXg4bW1fbTRfc2VscywgYmFzZSArDQo+ID4gMHg4MDgwKTsNCj4gPiAgCWh3c1tJTVg4
TU1fQ0xLX1ZQVV9DT1JFXSA9DQo+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9jb3JlKCJ2cHVf
Y29yZSIsIGlteDhtbV92cHVfc2VscywgYmFzZSArDQo+ID4gMHg4MTAwKTsgZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1uLmMNCj4gPiBiL2RyaXZlcnMvY2xrL2lteC9jbGst
aW14OG1uLmMgaW5kZXggNmNhYzZjYTAzZTEyLi5iZDM3NTliNGFmZDANCj4gMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14OG1uLmMNCj4gPiBAQCAtNDEzLDkgKzQxMyw5IEBAIHN0YXRpYyBpbnQgaW14
OG1uX2Nsb2Nrc19wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikN
Cj4gPiAgCX0NCj4gPg0KPiA+ICAJLyogQ09SRSAqLw0KPiA+IC0JaHdzW0lNWDhNTl9DTEtfQTUz
X1NSQ10gPSBpbXhfY2xrX2h3X211eDIoImFybV9hNTNfc3JjIiwgYmFzZQ0KPiArDQo+ID4gMHg4
MDAwLCAyNCwgMywgaW14OG1uX2E1M19zZWxzLCBBUlJBWV9TSVpFKGlteDhtbl9hNTNfc2Vscykp
Ow0KPiA+IC0JaHdzW0lNWDhNTl9DTEtfQTUzX0NHXSA9IGlteF9jbGtfaHdfZ2F0ZTMoImFybV9h
NTNfY2ciLA0KPiA+ICJhcm1fYTUzX3NyYyIsIGJhc2UgKyAweDgwMDAsIDI4KTsNCj4gPiAtCWh3
c1tJTVg4TU5fQ0xLX0E1M19ESVZdID0gaW14X2Nsa19od19kaXZpZGVyMigiYXJtX2E1M19kaXYi
LA0KPiA+ICJhcm1fYTUzX2NnIiwgYmFzZSArIDB4ODAwMCwgMCwgMyk7DQo+ID4gKwlod3NbSU1Y
OE1OX0NMS19BNTNfRElWXSA9DQo+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9jb3JlKCJhcm1f
YTUzX2RpdiIsIGlteDhtbl9hNTNfc2VscywgYmFzZSArDQo+ID4gMHg4MDAwKTsNCj4gPiArCWh3
c1tJTVg4TU5fQ0xLX0E1M19TUkNdID0gaHdzW0lNWDhNTl9DTEtfQTUzX0RJVl07DQo+ID4gKwlo
d3NbSU1YOE1OX0NMS19BNTNfQ0ddID0gaHdzW0lNWDhNTl9DTEtfQTUzX0RJVl07DQo+ID4NCj4g
PiAgCWh3c1tJTVg4TU5fQ0xLX0dQVV9DT1JFXSA9DQo+ID4gaW14OG1fY2xrX2h3X2NvbXBvc2l0
ZV9jb3JlKCJncHVfY29yZSIsIGlteDhtbl9ncHVfY29yZV9zZWxzLCBiYXNlDQo+ICsNCj4gPiAw
eDgxODApOw0KPiA+ICAJaHdzW0lNWDhNTl9DTEtfR1BVX1NIQURFUl0gPQ0KPiA+IGlteDhtX2Ns
a19od19jb21wb3NpdGVfY29yZSgiZ3B1X3NoYWRlciIsIGlteDhtbl9ncHVfc2hhZGVyX3NlbHMs
DQo+IGJhc2UNCj4gPiArIDB4ODIwMCk7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhtcS5jDQo+ID4gYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jIGluZGV4IDIwMWM3
YmJiMjAxZi4uOTEzMDlmZjY1NDQxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OG1xLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jDQo+ID4g
QEAgLTQwNSw5ICs0MDUsOSBAQCBzdGF0aWMgaW50IGlteDhtcV9jbG9ja3NfcHJvYmUoc3RydWN0
DQo+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gIAkJcmV0dXJuIFBUUl9FUlIo
YmFzZSk7DQo+ID4NCj4gPiAgCS8qIENPUkUgKi8NCj4gPiAtCWh3c1tJTVg4TVFfQ0xLX0E1M19T
UkNdID0gaW14X2Nsa19od19tdXgyKCJhcm1fYTUzX3NyYyIsIGJhc2UNCj4gKw0KPiA+IDB4ODAw
MCwgMjQsIDMsIGlteDhtcV9hNTNfc2VscywgQVJSQVlfU0laRShpbXg4bXFfYTUzX3NlbHMpKTsN
Cj4gPiAtCWh3c1tJTVg4TVFfQ0xLX0E1M19DR10gPSBpbXhfY2xrX2h3X2dhdGUzX2ZsYWdzKCJh
cm1fYTUzX2NnIiwNCj4gPiAiYXJtX2E1M19zcmMiLCBiYXNlICsgMHg4MDAwLCAyOCwgQ0xLX0lT
X0NSSVRJQ0FMKTsNCj4gPiAtCWh3c1tJTVg4TVFfQ0xLX0E1M19ESVZdID0gaW14X2Nsa19od19k
aXZpZGVyMigiYXJtX2E1M19kaXYiLA0KPiA+ICJhcm1fYTUzX2NnIiwgYmFzZSArIDB4ODAwMCwg
MCwgMyk7DQo+ID4gKwlod3NbSU1YOE1RX0NMS19BNTNfRElWXSA9DQo+ID4gaW14OG1fY2xrX2h3
X2NvbXBvc2l0ZV9jb3JlKCJhcm1fYTUzX2RpdiIsIGlteDhtcV9hNTNfc2VscywgYmFzZSArDQo+
ID4gMHg4MDAwKTsNCj4gPiArCWh3c1tJTVg4TVFfQ0xLX0E1M19DR10gPSBod3NbSU1YOE1RX0NM
S19BNTNfRElWXTsNCj4gPiArCWh3c1tJTVg4TVFfQ0xLX0E1M19TUkNdID0gaHdzW0lNWDhNUV9D
TEtfQTUzX0RJVl07DQo+ID4NCj4gPiAgCWh3c1tJTVg4TVFfQ0xLX000X0NPUkVdID0NCj4gPiBp
bXg4bV9jbGtfaHdfY29tcG9zaXRlX2NvcmUoImFybV9tNF9jb3JlIiwgaW14OG1xX2FybV9tNF9z
ZWxzLA0KPiBiYXNlDQo+ID4gKyAweDgwODApOw0KPiA+ICAJaHdzW0lNWDhNUV9DTEtfVlBVX0NP
UkVdID0NCj4gPiBpbXg4bV9jbGtfaHdfY29tcG9zaXRlX2NvcmUoInZwdV9jb3JlIiwgaW14OG1x
X3ZwdV9zZWxzLCBiYXNlICsNCj4gPiAweDgxMDApOw0KPiA+IC0tDQo+ID4gMi4xNi40DQoNCg==

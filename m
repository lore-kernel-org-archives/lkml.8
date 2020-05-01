Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F53C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB93820708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9kriS3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgEAMgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:36:55 -0400
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:35968
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728639AbgEAMgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcAj1lURYVN53UTVOTcAwkucNrxGr7w3Q69AZRiKUbzXN7Ql7CP6rTffPLQ2QgzuJ3bsGBd30W+lWMoAIPjwXHNgz3qKGrN5GYnuOLAP2avr6xRLTwKv9yvU+kUyCzb/nf1oQ6oZazXUWWdG+6FXzyiVsJUndsh+wM/Mlyvsq1H29eAWUXVcZZ7ifPb5KBUTTjjHgrzBbpQF9S73SliXyPEQIlfWdfoVDoGN42OLEKqDhBX9YllqSKwelioakyrmYNbdsuOsWZPReWmHdPZgzdXEZ/Fw+E/XnHY/5h7yhzMp08UCHcuU0MTrR7KfDfsQ4y1ojNbHUvq/ynEEOhQ1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtXGdz1Qd1ZPEX3P0mHUeuOUjRtckIEAVXzk5jJ6To=;
 b=f2ZWeDmYSrWd6xFcnj8fIdWxeYKe2PF13wxo2HTuc1a5owthDzv6OF0L+5R5hjaA6CNhTtfGFcI/acbp/IGZ5YG2KgaSIvxUrO0LHMvXDmZ+cpVZe307goWz3qp7ufbMZHIqOngFHKFFuK6u06zeHYwoPO159pDhrTG84EZsoB8AimrdnURPwjU+ntHxsNylkM3mXiADjLdbBnq8pnlgZ9my5uXK5KxelE0ZTRIHWpTbQzgJCTHj62dt/ryPEX56lyjrxumpf91TOLRPcB7zZoZ6cnfGOemsEQzkWFGzARyDIB/EaiOBDOnRCzLlUULoOwk3KzS6jtG30v3sjb2hlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNtXGdz1Qd1ZPEX3P0mHUeuOUjRtckIEAVXzk5jJ6To=;
 b=j9kriS3wKS2oF3VUtlYkA9X7/o5EjdXVSmZBb4BdZfdeEbfyTmBTvpgBjGOJ64OGCYpgDUhtozC3NG+AWRWwDSexzQkyyO819Zme191LqNiK3EKkUx83DqAMmLmjqOKbPpgFnsad7k2P2FfeEIzVm12rlxo8CLWWX2stGW9Pa1A=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2693.eurprd04.prod.outlook.com (2603:10a6:4:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Fri, 1 May
 2020 12:36:43 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.028; Fri, 1 May 2020
 12:36:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jun Li <jun.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
Thread-Topic: [RFC PATCH 3/4] drm/etnaviv: Change order of enabling clocks to
 fix boot on i.MX8MM
Thread-Index: AQHWHu1XXaOrH0g5LUa6iTgqgfKJiaiRuzoAgAAQ8wCAAWANAA==
Date:   Fri, 1 May 2020 12:36:43 +0000
Message-ID: <DB6PR0402MB276059A8D612ECBA8812379988AB0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
 <20200430124602.14463-4-frieder.schrempf@kontron.de>
 <3895f202cf5919e41a56878a62f6d5259dea12d3.camel@pengutronix.de>
 <72e8618b-856e-de42-9282-958cd03b239f@kontron.de>
In-Reply-To: <72e8618b-856e-de42-9282-958cd03b239f@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kontron.de; dkim=none (message not signed)
 header.d=none;kontron.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [117.80.211.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd022fd0-19ef-4527-b0c5-08d7edcc4e2a
x-ms-traffictypediagnostic: DB6PR0402MB2693:|DB6PR0402MB2693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB26933799CE920046023BB5BE88AB0@DB6PR0402MB2693.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bTqiyBAY++NeG4ZDnd/YIrMCzypL2vWIRKVuetw89LQHOe3nlg3edVVAij2kAJQkS66lg0MrG22rFYX6YqHvAkPSsyAFz989QWErfmMAs40tAQ7PQNYZnsRzAli+68OWNdnZjnIfE7eW3+8h8/19cHpR6OrNjfRe+wB3OrD6NPdrj7HxPPMCY5I0Qm2fjAq5grCfRcJ0xV2MxEAMbc7Z6paJVLz1rnv9Qaw52Rvy5A0mb9kXHCyp9DCZzPnaYDxqehJyp/T708m59jIThATdHCQzF0rn8NN0lCQn8jKi5VD+FmpYhm+qWDT3131MabqY5rIno/Izy5ThdiiCi1dwb3Yy4Uie/6oQckJKBexL78Xg+HCMVtXg58O4sB0HzxE5d/N+vlKiHf3IKfdDIK9b0+7HgQg8M1suBqT153CEdJ4DgIyWzIjaL1nFAAiZUa5Vqfc6bcDEQfqdKMMM7h76+GN4+tZ5CDWR5cutzOQWSSJTfBcJnmRcitkEuUY19Rut2pGkLDz4bNMkV4WTuapdJZp71urnmVc6RhV3nFClW9Y5v9Hf3AE1ktAstbS+IC0X52W9sRhv/GjOsNKzBorKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(8676002)(5660300002)(44832011)(54906003)(8936002)(26005)(7696005)(186003)(86362001)(33656002)(966005)(9686003)(316002)(6506007)(53546011)(7416002)(4326008)(45080400002)(110136005)(52536014)(6636002)(71200400001)(55016002)(76116006)(66556008)(66476007)(83080400001)(66946007)(66446008)(64756008)(478600001)(2906002)(154233001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tSx1ffESOpM+8v4nMGrR5uUZ4Bc/vH0VQA30JHgvS0/TEo95o1lv804bcQo2PwoVnT91AFWhcDbAJ9c5cFdJFs2An7ZpDsEuw3URVL7039kDrSK0S3LMnzUO6kjZkVfRegM5LVVZo9rggDnvQo3X5+dpnJ3R5NbYPIEfts/CYErzkD32Ir6B8KovLHkUWomvMo/RgDff/Z2vKxkYNTaybW8tpVkJYarF1oL+XPjdo0P95Geo6ulU3+zgDCE8DIgTaQe/wXKToGL42Jjp/QC5PeD438IjIo82OcJyFc+Wx+i5xAoJswt0F0p6H73KaqGH+xNuE1XbJWzLRocudrDoygLYGMhSjLPOgWZICA4doSvxibg4PHVJsQVnEO8hMEfBycIC2+7OsJo4JeE0QSsNaEOOdzvPUePWff1YUTTuZOiPnHCE2f4qIRm7e4xmDJRzFUH+xi644EUC8cqsS2i3us9xjXdGSSpo20lhmLqUKzfBEvVb6dkV2MSVC9P817L7EV4belXmGod5+FpddOTPqomrgdga2XnYeHmtePq7Yx0XaaIj7SJGu+9ztN+7ksuMvz6YRB2nVkp3hQqJKeaAfSZXlj/WqTWbwGrGCdbXpseW7O8P6nu12nezm3aQc+t0RTZV9OHued6f/ylB2htIxtK+ErtWil68InJsnIytTau8tru2MEndO0GVqAdH/B3UICXYsVv7MSfmQjBvpXV3Lw1HUm7gz7GVZBo3TRJV7QT7Pttj/vcwKiiUmh5v2VqoC3J0rehPwYEcQEOiuqypvN6GNGTaWcv4ATTs3oMkhJI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd022fd0-19ef-4527-b0c5-08d7edcc4e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 12:36:43.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V66WV62PPen+FylOLq1CNkM4+tZdOb029lAvStzDa7wmKQo37B1HCXlKjYGTpp4hngxw+Zxa+oHRMPfSYQsN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAzLzRdIGRybS9ldG5hdml2OiBDaGFuZ2Ugb3JkZXIg
b2YgZW5hYmxpbmcgY2xvY2tzIHRvDQo+IGZpeCBib290IG9uIGkuTVg4TU0NCj4gDQo+IE9uIDMw
LjA0LjIwIDE2OjM1LCBMdWNhcyBTdGFjaCB3cm90ZToNCj4gPiBBbSBEb25uZXJzdGFnLCBkZW4g
MzAuMDQuMjAyMCwgMTI6NDYgKzAwMDAgc2NocmllYiBTY2hyZW1wZiBGcmllZGVyOg0KPiA+PiBG
cm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+ID4+
DQo+ID4+IE9uIHNvbWUgaS5NWDhNTSBkZXZpY2VzIHRoZSBib290IGhhbmdzIHdoZW4gZW5hYmxp
bmcgdGhlIEdQVSBjbG9ja3MuDQo+ID4+IENoYW5naW5nIHRoZSBvcmRlciBvZiBjbG9jayBpbml0
YWxpemF0aW9uIHRvDQo+ID4+DQo+ID4+IGNvcmUgLT4gc2hhZGVyIC0+IGJ1cyAtPiByZWcNCj4g
Pj4NCj4gPj4gZml4ZXMgdGhlIGlzc3VlLiBUaGlzIGlzIHRoZSBzYW1lIG9yZGVyIHVzZWQgaW4g
dGhlIGlteCBwbGF0Zm9ybSBjb2RlDQo+ID4+IG9mIHRoZSBkb3duc3RyZWFtIEdQVSBkcml2ZXIg
aW4gdGhlIE5YUCBrZXJuZWwgWzFdLiBGb3IgdGhlIHNha2Ugb2YNCj4gPj4gY29uc2lzdGVuY3kg
d2UgYWxzbyBhZGp1c3QgdGhlIG9yZGVyIG9mIGRpc2FibGluZyB0aGUgY2xvY2tzIHRvIHRoZQ0K
PiA+PiByZXZlcnNlLg0KPiA+Pg0KPiA+PiBbMV0NCj4gPj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGc291DQo+ID4+DQo+
IHJjZS5jb2RlYXVyb3JhLm9yZyUyRmV4dGVybmFsJTJGaW14JTJGbGludXgtaW14JTJGdHJlZSUy
RmRyaXZlcnMlMkYNCj4gbXgNCj4gPj4NCj4gYyUyRmdwdS12aXYlMkZoYWwlMkZvcyUyRmxpbnV4
JTJGa2VybmVsJTJGcGxhdGZvcm0lMkZmcmVlc2NhbGUlMkZnYw0KPiBfaA0KPiA+Pg0KPiBhbF9r
ZXJuZWxfcGxhdGZvcm1faW14LmMlM0ZoJTNEaW14XzUuNC4zXzIuMC4wJTIzbjE1MzgmYW1wO2Rh
dGE9MDINCj4gJTdDDQo+ID4+DQo+IDAxJTdDcGVuZy5mYW4lNDBueHAuY29tJTdDZGM3ZGE1M2Y2
NjVlNGY1NjdlMzAwOGQ3ZWQxYzI3ZTAlN0M2DQo+IDg2ZWExZDMNCj4gPj4NCj4gYmMyYjRjNmZh
OTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzcyMzg1Nzc0OTc5Njk3ODcmYW1wO3NkYQ0KPiB0
YT1RUkh6dQ0KPiA+PiBDNmdTS3klMkY2eTJGVFJ2bE5GNXQ3RG1KSXZUZ0JFU1lLY2hJJTJGRHcl
M0QmYW1wO3Jlc2VydmVkPTANCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIHdoeSB0aGUgb3JkZXIgb2Yg
dGhlIGNsb2NrcyBpcyBpbXBvcnRhbnQuIElzIHRoaXMgcmVhbGx5IGENCj4gPiBHUFUgaXNzdWU/
IEFzIGluOiBkb2VzIGEgR1BVIGFjY2VzcyBoYW5nIHdoZW4gZW5hYmxpbmcgdGhlIGNsb2NrcyBp
bg0KPiA+IHRoZSB3cm9uZyBvcmRlcj8gT3IgaXMgdGhpcyBhIGNsb2NrIGRyaXZlciBpc3N1ZSB3
aXRoIGEgY2xvY2sgYWNjZXNzDQo+ID4gaGFuZ2luZyBkdWUgdG8gYW4gdXBzdHJlYW0gY2xvY2sg
c3RpbGwgYmVpbmcgZGlzYWJsZWQ/DQo+IA0KPiBBY3R1YWxseSB5b3UgbWlnaHQgYmUgcmlnaHQg
d2l0aCB0aGlzIGJlaW5nIGEgY2xvY2sgZHJpdmVyIGlzc3VlLiBUaGUgaGFuZ2luZw0KPiBoYXBw
ZW5zIHdoaWxlIGVuYWJsaW5nIHRoZSBjbG9ja3MgKHVucmVsYXRlZCB0byBhbnkgR1BVIHJlZ2lz
dGVyIGFjY2VzcykuIFRoZQ0KPiBzdHJhbmdlIHRoaW5nIGlzIHRoYXQgbW9zdCBvZiB0aGUgZGV2
aWNlcyB3ZSBoYXZlIGRvbid0IGNhcmUgYW5kIHdvcmsgYXMgaXMNCj4gYW5kIHNvbWUgZGV2aWNl
cyByZWxpYWJseSBmYWlsIGVhY2ggdGltZSB3aGVuIGVuYWJsaW5nIHRoZSBjbG9ja3MgaW4gdGhl
DQo+ICJ3cm9uZyIgb3JkZXIuDQo+IA0KPiBTbyBJIGd1ZXNzIHRoaXMgY291bGQgaW5kZWVkIGJl
IHNvbWUgY2xvY2sgYmVpbmcgZW5hYmxlZCB3aXRoIGFuIHVwc3RyZWFtDQo+IFBMTCBub3QgaGF2
aW5nIGxvY2tlZCB5ZXQgb3Igc29tZXRoaW5nLg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL2NvdmVyLzExNDMzNzc1Lw0KDQpXaWxsIHRoaXMgcGFjaHNldCBoZWxwPw0KDQpUaGUgaS5N
WDhNIENDTSByb290IG11eCBjb2RlIGluIExpbnV4IG5lZWRzIGEgZml4Lg0KDQpSZWdhcmRzLA0K
UGVuZy4NCg0KPiANCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gTHVjYXMNCj4gPg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+
DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ3B1LmMg
fCA0Mg0KPiArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dwdS5jDQo+ID4+IGIvZHJpdmVy
cy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUuYw0KPiA+PiBpbmRleCA3YjEzOGQ0ZGQwNjgu
LjQyNGIyZTU5NTFmMCAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYv
ZXRuYXZpdl9ncHUuYw0KPiA+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2
X2dwdS5jDQo+ID4+IEBAIC0xNDg3LDU1ICsxNDg3LDU1IEBAIHN0YXRpYyBpbnQgZXRuYXZpdl9n
cHVfY2xrX2VuYWJsZShzdHJ1Y3QNCj4gZXRuYXZpdl9ncHUgKmdwdSkNCj4gPj4gICB7DQo+ID4+
ICAgCWludCByZXQ7DQo+ID4+DQo+ID4+IC0JaWYgKGdwdS0+Y2xrX3JlZykgew0KPiA+PiAtCQly
ZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5jbGtfcmVnKTsNCj4gPj4gKwlpZiAoZ3B1LT5j
bGtfY29yZSkgew0KPiA+PiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5jbGtfY29y
ZSk7DQo+ID4+ICAgCQlpZiAocmV0KQ0KPiA+PiAgIAkJCXJldHVybiByZXQ7DQo+ID4+ICAgCX0N
Cj4gPj4NCj4gPj4gLQlpZiAoZ3B1LT5jbGtfYnVzKSB7DQo+ID4+IC0JCXJldCA9IGNsa19wcmVw
YXJlX2VuYWJsZShncHUtPmNsa19idXMpOw0KPiA+PiArCWlmIChncHUtPmNsa19zaGFkZXIpIHsN
Cj4gPj4gKwkJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGdwdS0+Y2xrX3NoYWRlcik7DQo+ID4+
ICAgCQlpZiAocmV0KQ0KPiA+PiAtCQkJZ290byBkaXNhYmxlX2Nsa19yZWc7DQo+ID4+ICsJCQln
b3RvIGRpc2FibGVfY2xrX2NvcmU7DQo+ID4+ICAgCX0NCj4gPj4NCj4gPj4gLQlpZiAoZ3B1LT5j
bGtfY29yZSkgew0KPiA+PiAtCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5jbGtfY29y
ZSk7DQo+ID4+ICsJaWYgKGdwdS0+Y2xrX2J1cykgew0KPiA+PiArCQlyZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoZ3B1LT5jbGtfYnVzKTsNCj4gPj4gICAJCWlmIChyZXQpDQo+ID4+IC0JCQlnb3Rv
IGRpc2FibGVfY2xrX2J1czsNCj4gPj4gKwkJCWdvdG8gZGlzYWJsZV9jbGtfc2hhZGVyOw0KPiA+
PiAgIAl9DQo+ID4+DQo+ID4+IC0JaWYgKGdwdS0+Y2xrX3NoYWRlcikgew0KPiA+PiAtCQlyZXQg
PSBjbGtfcHJlcGFyZV9lbmFibGUoZ3B1LT5jbGtfc2hhZGVyKTsNCj4gPj4gKwlpZiAoZ3B1LT5j
bGtfcmVnKSB7DQo+ID4+ICsJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShncHUtPmNsa19yZWcp
Ow0KPiA+PiAgIAkJaWYgKHJldCkNCj4gPj4gLQkJCWdvdG8gZGlzYWJsZV9jbGtfY29yZTsNCj4g
Pj4gKwkJCWdvdG8gZGlzYWJsZV9jbGtfYnVzOw0KPiA+PiAgIAl9DQo+ID4+DQo+ID4+ICAgCXJl
dHVybiAwOw0KPiA+Pg0KPiA+PiAtZGlzYWJsZV9jbGtfY29yZToNCj4gPj4gLQlpZiAoZ3B1LT5j
bGtfY29yZSkNCj4gPj4gLQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGdwdS0+Y2xrX2NvcmUpOw0K
PiA+PiAgIGRpc2FibGVfY2xrX2J1czoNCj4gPj4gICAJaWYgKGdwdS0+Y2xrX2J1cykNCj4gPj4g
ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19idXMpOw0KPiA+PiAtZGlzYWJsZV9j
bGtfcmVnOg0KPiA+PiAtCWlmIChncHUtPmNsa19yZWcpDQo+ID4+IC0JCWNsa19kaXNhYmxlX3Vu
cHJlcGFyZShncHUtPmNsa19yZWcpOw0KPiA+PiArZGlzYWJsZV9jbGtfc2hhZGVyOg0KPiA+PiAr
CWlmIChncHUtPmNsa19zaGFkZXIpDQo+ID4+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUt
PmNsa19zaGFkZXIpOw0KPiA+PiArZGlzYWJsZV9jbGtfY29yZToNCj4gPj4gKwlpZiAoZ3B1LT5j
bGtfY29yZSkNCj4gPj4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGdwdS0+Y2xrX2NvcmUpOw0K
PiA+Pg0KPiA+PiAgIAlyZXR1cm4gcmV0Ow0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICBzdGF0aWMg
aW50IGV0bmF2aXZfZ3B1X2Nsa19kaXNhYmxlKHN0cnVjdCBldG5hdml2X2dwdSAqZ3B1KQ0KPiA+
PiAgIHsNCj4gPj4gKwlpZiAoZ3B1LT5jbGtfcmVnKQ0KPiA+PiArCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZ3B1LT5jbGtfcmVnKTsNCj4gPj4gKwlpZiAoZ3B1LT5jbGtfYnVzKQ0KPiA+PiArCQlj
bGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfYnVzKTsNCj4gPj4gICAJaWYgKGdwdS0+Y2xr
X3NoYWRlcikNCj4gPj4gICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShncHUtPmNsa19zaGFkZXIp
Ow0KPiA+PiAgIAlpZiAoZ3B1LT5jbGtfY29yZSkNCj4gPj4gICAJCWNsa19kaXNhYmxlX3VucHJl
cGFyZShncHUtPmNsa19jb3JlKTsNCj4gPj4gLQlpZiAoZ3B1LT5jbGtfYnVzKQ0KPiA+PiAtCQlj
bGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfYnVzKTsNCj4gPj4gLQlpZiAoZ3B1LT5jbGtf
cmVnKQ0KPiA+PiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZ3B1LT5jbGtfcmVnKTsNCj4gPj4N
Cj4gPj4gICAJcmV0dXJuIDA7DQo+ID4+ICAgfQ0KPiA+DQo=

Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A281204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="og9w9LM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404835AbgFYMyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:54:44 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:9773
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404825AbgFYMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWWEHMLOrAWrzbnqxQ+M6yLfZEO8KeMePgt0K1bMJ2jfWPqhnmN8rwsy3qwA0J+aFTsn8szOYGSnYmNjcbUdr6IvmKVjOeSbHr7K/Vs7uCVAUIlOgOKYVyYsmoDG0sk+dJXlnZxUiGDX+kOqUIQkEfuxnCJr3MShs91i/KZTH7dUs8dN0POmtVQLT77WqV8RQwJeHHloaM4gD88yARSt0gDIrzCFlMH/REz0apdlrWsUqVKjYjpWuGXZwU7PpIx3bhT6NfnbBcH8HMgM8KeuiiwQCUi/I9NHwCmXEkOC2A0lAokVZ7g+8ZSQ4mOvGWavrw0WxU9Og+lTdVmOIvc8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v++lMVtdM+8qMcxGwADnZD1+/0CKDy6ceQ91G67mI2I=;
 b=jxQNGTe+JVObA574zgiaL8slf/mxNqYfQJdN98ZVxpYQa0z9I2e6exhKbs9JnKDGS2xl9YcJv6F0HTQOr1zi/3S69skSuYSvShqA7wZkY7YLUT9l+08N+68g19YTxEYZc3KfXJB+QFGcVVpJ8oRGvM2YkDMUtVVsseLYYSS+jnISsYYX5ogb+rlCVWWnoeqVJb8u0QG6+dNNgn9Q9q0wQ0PxluthbYcW8F2zLT7OiJpLzaRhA/EoggFPQg/k7C+eXhXQYCIco0ctuHaVORWUDBve2HHZu05ctf2xHNt+S8EoNan3MnRRO6c2RSfYLvHyPmUdjTSjG7k5RrmMTxjDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v++lMVtdM+8qMcxGwADnZD1+/0CKDy6ceQ91G67mI2I=;
 b=og9w9LM2+fLW4fqo9IvVQFZK/CsVJ/d2+fMnNcuISOPyhMYWxF86m/pBXE4tXb2Kefo4uwFpycvYdHu9bNtthQum5NM1PDLOmBAXlOm1MfmcNfBlu9lg4gG6ahkpaJkVyxz4UbWjSpxwoZkufjocUwps3art9yoz9mu878dmbg8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4937.eurprd04.prod.outlook.com (2603:10a6:10:18::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Thu, 25 Jun
 2020 12:54:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 12:54:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
Thread-Topic: [PATCH V2] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
Thread-Index: AQHWSodyLml7JnYRykSNdTCtFwV+t6jo+8+AgABOFHA=
Date:   Thu, 25 Jun 2020 12:54:38 +0000
Message-ID: <DB3PR0402MB39165C1192139A67B5252941F5920@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593044164-32362-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2uh2eBHE+XPt1gUDEj0vnXwES-GmL=rsBRDHpK5HXc0A@mail.gmail.com>
In-Reply-To: <CAK8P3a2uh2eBHE+XPt1gUDEj0vnXwES-GmL=rsBRDHpK5HXc0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e179720a-aed9-4f76-a50c-08d81906ebf2
x-ms-traffictypediagnostic: DB7PR04MB4937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB49376D9A8F15385B719EE4E4F5920@DB7PR04MB4937.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZmPaL9QOpKa2c8LYHwdhsh6zcMPMZBvilyyR4EzrBjbI+AtTWJWqLP6o0X5aK2dqESSGrwDfs/2j9to4y2josGidj8oUYstJyRJfZslOxv/OfrXd3U00DuUIpm7XcE9lIx+DwaDiZpCV+zc1lw4Std3MGna1HD/TYQF0i+8uxQmm/i8w11Ew1vlFHhodl6L5ffaGAO/Gc4J5IwUge4oxfbM0CQV/WIK2sqetF6SujTP5w1DFqAniZBySol0+I14a4tEdaOvi78ibHPZfzh6SJYCgwKFNqYlQ0dw1MZrp8bbaEgDk+hGYmtIMrwlIsKdbpM9iIheZQZ22jiTEfdFOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(6506007)(52536014)(5660300002)(76116006)(33656002)(44832011)(2906002)(64756008)(66476007)(66556008)(66446008)(478600001)(66946007)(86362001)(7416002)(71200400001)(186003)(316002)(6916009)(53546011)(26005)(9686003)(8936002)(54906003)(8676002)(7696005)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SzuLLoN4SzhXnVkUGo5EwViZJihTU5FEu2fEkH+rUn0mY1jYebsduuixElyY8j/n5NB/THs9ULIn7KT+FCMDwBu7OvaPPZks+WH7bxFaXqw8d3xdHoVb3pyXeFzipMxgHw0tYXArT5ZrDkpFe0INqEC3jYU65Uu8PMzix71cC45Ks9WvVB6X5ibIbslCcjPscalMqubTYiEXmpkd/hfKlnjhG8EJo+YMaXP7rETkdRdP4emmz+HcjvKMBpzOdyAK4XqiA6M5ETUvXF/U+jM/zsolSZQG9K/HdR2OcErxAL9RK1H5tf/QNMT3eCfh5Q1dhxRBqM3EtPZphBOW5ijeUwFJvBOmN5yNu2HEwzkAwF+n9A3SuMgRmj1Hc2DehpX6fuomqhqcmyIWN4HuScdXIrYzhsS6Nr1w00rZ7pQ6VHzCNmbjGi9sWHqnemrVXYCpbY4dYdwM+uguCPk0PDybmlOXKhBjjFSEQ1/ZqpUoBK6Ywr2ch7orz4c+4JnLXpaw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e179720a-aed9-4f76-a50c-08d81906ebf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 12:54:39.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kdaucaEH/T1aKdErzrDdDbV2OdX+yazV/PprtRZuwA9afNdpxGZmlgmrz6vyPRdOw2p5YVExDFufObcn7N3Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIGZpcm13YXJlOiBpbXg6IE1v
dmUgaS5NWCBTQ1Ugc29jIGRyaXZlciBpbnRvIGlteA0KPiBmaXJtd2FyZSBmb2xkZXINCj4gDQo+
IE9uIFRodSwgSnVuIDI1LCAyMDIwIGF0IDI6MjcgQU0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIGkuTVggU0NVIHNvYyBkcml2ZXIgZGVw
ZW5kcyBvbiBTQ1UgZmlybXdhcmUgZHJpdmVyLCBzbyBpdCBoYXMgdG8NCj4gPiB1c2UgcGxhdGZv
cm0gZHJpdmVyIG1vZGVsIGZvciBwcm9wZXIgZGVmZXIgcHJvYmUgb3BlcmF0aW9uLCBzaW5jZSBp
dA0KPiA+IGhhcyBubyBkZXZpY2UgYmluZGluZyBpbiBEVCBmaWxlLCBhIHNpbXBsZSBwbGF0Zm9y
bSBkZXZpY2UgaXMgY3JlYXRlZA0KPiA+IHRvZ2V0aGVyIGluc2lkZSB0aGUgcGxhdGZvcm0gZHJp
dmVyLiBUbyBtYWtlIGl0IG1vcmUgY2xlYW4sIHdlIGNhbg0KPiA+IGp1c3QgbW92ZSB0aGUgZW50
aXJlIFNDVSBzb2MgZHJpdmVyIGludG8gaW14IGZpcm13YXJlIGZvbGRlciBhbmQNCj4gPiBpbml0
aWFsaXplZCBieSBpLk1YIFNDVSBmaXJtd2FyZSBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IExvb2tzIGdvb2Qg
ZXhjZXB0IGZvciBvbmUgaXJyaXRhdGluZyBpc3N1ZToNCj4gDQo+ID4gaW5kZXggMTdlYTM2MS4u
Yjc2YWNiYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9NYWtlZmlsZQ0K
PiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlDQo+ID4gQEAgLTEsNCArMSw0
IEBADQo+ID4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiAgb2JqLSQo
Q09ORklHX0lNWF9EU1ApICAgICAgICAgICs9IGlteC1kc3Aubw0KPiA+IC1vYmotJChDT05GSUdf
SU1YX1NDVSkgICAgICAgICAgKz0gaW14LXNjdS5vIG1pc2MubyBpbXgtc2N1LWlycS5vIHJtLm8N
Cj4gPiArb2JqLSQoQ09ORklHX0lNWF9TQ1UpICAgICAgICAgICs9IGlteC1zY3UubyBtaXNjLm8g
aW14LXNjdS1pcnEubyBybS5vDQo+IGlteC1zY3Utc29jLm8NCj4gPiAgb2JqLSQoQ09ORklHX0lN
WF9TQ1VfUEQpICAgICAgICs9IHNjdS1wZC5vDQo+IA0KPiBUaGlzIG1ha2VzIHNlcGFyYXRlIGxv
YWRhYmxlIG1vZHVsZXMgb3V0IG9mIHRoZSBkcml2ZXIgd2hlbg0KPiBDT05GSUdfSU1YX1NDVT1t
LCBpbmNsdWRpbmcgdGhlIGJhZGx5IG5hbWVkIG1pc2Mua28gYW5kIHJtLmtvIG1vZHVsZXMNCj4g
dGhhdCBtaWdodCBjb25mbGljdCB3aXRoIG90aGVyIG1vZHVsZXMgb2YgdGhlIHNhbWUgbmFtZSAo
bW9kdWxlIG5hbWVzIGFyZSBhDQo+IGdsb2JhbCBuYW1lc3BhY2UgZm9yIG1vZHByb2JlKS4NCj4g
DQo+IFRoZSB3YXkgdG8gbWFrZSB0aGlzIGEgc2luZ2xlIG1vZHVsZSBmcm9tIGZvdXIgZmlsZXMg
aXMNCj4gDQo+IG9iai0kKENPTkZJR19JTVhfU0NVKSAgICAgICAgICArPSBpbXgtc2N1LW1vZC5v
DQo+IGlteC1zY3UtbW9kLXkgOj0gaW14LXNjdS5vIG1pc2MubyBpbXgtc2N1LWlycS5vIHJtLm8g
aW14LXNjdS1zb2Mubw0KDQpJIGhhdmVuJ3QgY29uc2lkZXJlZCB0aGUgc3VwcG9ydCBmb3IgbG9h
ZGFibGUgbW9kdWxlIG9mIGkuTVggU0NVIGZpcm13YXJlIHlldCwNCnBsYW4gdG8gaGF2ZSBhbm90
aGVyIHBhdGNoIHRvIGRvIGl0LCBzbyBkbyB5b3UgdGhpbmsgaXQgaXMgZ29vZCB0byBhZGQgdGhl
IGxvYWRhYmxlDQptb2R1bGUgc3VwcG9ydCB0b2dldGhlciBpbiB0aGlzIHBhdGNoPw0KDQo+IA0K
PiA+ICtFWFBPUlRfU1lNQk9MKGlteF9zY3Vfc29jX2luaXQpOw0KPiANCj4gQ29uc2VxdWVudGx5
LCB0aGVyZSBzaG91bGQgbm90IGJlIGFuIEVYUE9SVF9TWU1CT0wgaGVyZS4NCg0KV2lsbCByZW1v
dmUgaXQuDQoNClRoYW5rcywNCkFuc29uDQo=

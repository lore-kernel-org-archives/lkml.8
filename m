Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910BF206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZEqN6cvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFSGUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:20:45 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:52958
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFSGUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbQbBisL9CxAGxMb73JXC8UJaOe/pSsVP1f7R1LD4zPHNMVgqiJBNGnEaWN0glp92dEm36ZDV9ZZs4wPtxalAgDBO09Z/AJLMbxp5ld6KjMUJuJj+4MG5RfDwcUn3oeb+v4KjDJ79Av0I/JkCjQGWY3KljzCFbVU7SG/iPq9evnXp4c3EJOykkRUu0KJKT6F6SvsdjGorTiUiB6hUUuZaHEzMvRooz6sFYCmB4LpYKPTZzBW0XOOO6MTdr4fbRMfSEUeRd6dg4R1zARoc7Q4eq5nJSZj3LKIS9BN3VtomUBI9v5u1cMQtEg5N4ZZ6RpaHnM7m8mLLIhSNNx4/kw1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0zNMfSmGrTwHaOMwUXWOGvzk5fJCcUBU4/AzdLNa/o=;
 b=RqjLP0DUyJ9KwqxnXRclyeQV/OFBTHJCFmEKdGc9hUZwGdxatJG2vg8U9A+KS+9dR5PhH4OsWUlhzB9Wm0i2x8pIUdpDUT1mxz+rJ5HOL/ntj3Oa+IdbLPwnkEGCtZM10cf9OxEBluARTB4m2XGYXS3AOjpqL4vTAyD295nudmaBlELisMxS+J7ZX2/XiqAzyKyS+J3LllESIgNHXSGoOsrOghGCtwlCwJ5WKDuTRv/epWSSo4dk7WlfWEValZD0j4V0jow6b71q2XWfhksY7B/B+paMVK+aEfCBEP3I2p1HaTyoYsEKk5hcpMa//fEuChNvWp75tn0kFweyBGDXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0zNMfSmGrTwHaOMwUXWOGvzk5fJCcUBU4/AzdLNa/o=;
 b=ZEqN6cvq4V0qCwSWNouKcBcjRJRYSg0NCy2oybEywrW6eJZnbtPSAdLSzdIhHaNAYgixNRQwk5bh5V+bd4Roiii6LKOtpPsyvuitlUFmGso7Ambh0WnowUGHfK6tY9Yb3jYM+XwI5M04/JTRkQ3XCIVAQqj9CuVRDYc7VtwX3wY=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5640.eurprd04.prod.outlook.com (2603:10a6:20b:a3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 06:20:41 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Fri, 19 Jun 2020
 06:20:41 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>, Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Support module build
Thread-Topic: [PATCH] soc: imx-scu: Support module build
Thread-Index: AQHWRGTWXA/Y7jtl6U620nWhqctCc6jccHNQgAABg4CAABwbAIABayQAgAGBIrA=
Date:   Fri, 19 Jun 2020 06:20:40 +0000
Message-ID: <AM6PR04MB496696A8695FA85D1EEE276B80980@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <AM6PR0402MB3911B852B49E194E5FE84505F59A0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167727A8B7CEDAC531D94EF59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3zHBRqSg1VeuKcmyQquE7n5wrEViw5KFbDGJNaMjtZRw@mail.gmail.com>
In-Reply-To: <CAK8P3a3zHBRqSg1VeuKcmyQquE7n5wrEViw5KFbDGJNaMjtZRw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c8f3446-93f4-4daf-aece-08d81418e469
x-ms-traffictypediagnostic: AM6PR04MB5640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5640239C080EEB8189CC11E780980@AM6PR04MB5640.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJIfXdMcdy8GAY9VBz9RJhfpQmz0byu5l+GG9QHtEJuJsrW+cNjiMxPx5Cs2bR+KbFwAQQ4lcQZPgjUH2p1x/nAiZTKf1zlLbrgR1IoNoaenl4wLoKrH4i/dmZn8jsrLgjJ6d9r03l4CV7pZXsusC/6zCB30SrRqFeE5/n6MgP027pdyjiUCKx1Pw6jzMR0Y4jV3w4iVaMym8OhxJjhgcg23kFv0VtIamhKKugtlFtrxDCwsJwgTxnhvbojg4sl1X6LO2on3o6N8zIW/Ox0UXbkk/mpxgc4KahzP+AiPZl2algeYAFH9JrDIa4l/iPHi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(83380400001)(186003)(86362001)(26005)(8936002)(8676002)(66476007)(478600001)(66446008)(66556008)(64756008)(66946007)(2906002)(5660300002)(6636002)(33656002)(52536014)(7696005)(71200400001)(9686003)(316002)(54906003)(110136005)(4326008)(55016002)(6506007)(76116006)(44832011)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NnNTpgEwOAaaP+vvHPsgCZrK83xmB21sR79cCW4N8EXhtuJ474hQyDUis3poMgN8wifWu9Rug3y2S9uZ6d8nDiio5wEjhOvKVwwN6/p0uDHaqGQeOAjNiAebevCjmIhOzBDpo8zOMwpsCBxbxZ+YM7NgvF11uRfPQF3EumexZQp7Vqrff8vUhGy/qyErccyUy84OWpGsJr2U/Cokr0fIPYxTlH52MLHpe1pdkytvFsUIzr1VRoYj+6gVPseWSfU7r4ig4u7hdyWInZ3xJjUg1pAj92SYOJCIvgXPctYpWkVUiScRhKN/AP0SNc/LEdx9Gen6g7roILgkg3Pp1UXOOHXFHayZS4YD5dYSGDQxN/GpyuUiSdk7d+XxIX2WoEIQ9faW69UHnpHSc00mewbWEfmxexJM/IvVpHMhQ0zhv0vyLdqpdKYn5T2UJE3pkXnmsr4hx0xwYVGxg7FCPIWKKnc4OVuCB8dpacux/0Yz2hk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8f3446-93f4-4daf-aece-08d81418e469
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 06:20:41.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3IB1EDqY1K5GhgThSqhLIsGU+5wvu3hzEhhs5EBFirTS5F1WBLwVIxapVL/rdgC3ESK9MOynikiKcGpnmSauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVuZSAxOCwgMjAyMCAzOjIxIFBNDQo+IA0KPiBPbiBXZWQsIEp1biAxNywgMjAyMCBhdCAxMTo0
MSBBTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+
ID4gPg0KPiA+ID4gPiBJJ20gb2sgd2l0aCB0aGUgY2hhbmdlLiBCdXQgSSdtIGN1cmlvdXMgaG93
IGNhbiB0aGlzIG1vZHVsZSBiZQ0KPiA+ID4gPiBhdXRvbG9hZGVkIHdpdGhvdXQgTU9EVUxFX0RF
VklDRV9UQUJMRS4NCj4gPiA+ID4gSGF2ZSB5b3UgdGVzdGVkIGlmIGl0IGNhbiB3b3JrPw0KPiA+
ID4gPg0KPiA+ID4NCj4gPiA+IEkgT05MWSB0ZXN0ZWQgdGhlIG1hbnVhbCBpbnNtb2QsIGlmIHdh
bnQgdG8gc3VwcG9ydCBhdXRvIGxvYWQsIG1heQ0KPiA+ID4gbmVlZCBzb21lIG1vcmUgY2hhbmdl
LCB3aWxsIHRyeSBpdCBsYXRlciBhbmQgc2VuZCBvdXQgYSBWMiBpZiBuZWVkZWQuDQo+ID4NCj4g
PiBUaGUgZnVydGhlciBjaGVjayBzaG93cyB0aGF0LCBpZiB3YW50IHRvIHN1cHBvcnQgYXV0byBs
b2FkLCB0aGUNCj4gPiBwbGF0Zm9ybSBkZXZpY2UgcmVnaXN0ZXIgbmVlZHMgdG8gYmUgZG9uZSBp
biBzb21ld2hlcmUgZWxzZSB3aGljaCBpcw0KPiA+IGJ1aWx0LWluIChpbiBteSB0ZXN0LCBJIG1v
dmUgaXQgdG8gY2xrLWlteDhxeHAuYydzIHByb2JlKSwgYW5kIGFsc28NCj4gPiBuZWVkIHRvIGFk
ZCBiZWxvdyBtb2R1bGUgYWxpYXMgaW4gdGhpcyBkcml2ZXIsIGJlY2F1c2UgaXQgaGFzIG5vIGRl
dmljZSBub2RlIGluDQo+IERUIGFuZCBubyBkZXZpY2UgdGFibGUgaW4gZHJpdmVyLg0KPiA+DQo+
ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06aW14LXNjdS1zb2MiKTsNCj4gPg0KPiA+IFNpbmNl
IHRoaXMgZHJpdmVyIGhhcyBubyBkZXZpY2Ugbm9kZSBpbiBEVCwgYW5kIHRoZSB0YXJnZXQgaXMg
dG8gYnVpbGQNCj4gPiBhbGwgU29DIHNwZWNpZmljIGRyaXZlcnMgYXMgbW9kdWxlLCBzbyB0aGUg
YmVzdCB3YXkgaXMgdG8gYWRkIGENCj4gPiB2aXJ0dWFsIGRldmljZSBub2RlIGluIERUIGluIG9y
ZGVyIHRvIHN1cHBvcnQgYXV0byBsb2FkPw0KPiANCj4gSSBzZWUgdGhhdCB0aGVyZSBpcyBpbmRl
ZWQgYSBkcml2ZXIgZm9yIHRoZSBkZXZpY2Ugbm9kZSBpbg0KPiBkcml2ZXJzL2Zpcm13YXJlL2lt
eC9pbXgtc2N1LmMsIHRoZSBvbmx5IHJlYXNvbiBmb3IgdGhpcyBtb2R1bGUgdXNpbmcNCj4gZGV2
aWNlX2luaXRjYWxsKCkgd2l0aCBhIG1hbnVhbA0KPiBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJf
c2ltcGxlKCkgc2VlbXMgdG8gYmUgdGhhdCB3ZSBjYW5ub3QgaGF2ZSB0d28NCj4gcGxhdGZvcm0g
ZHJpdmVycyBiaW5kIHRvIHRoZSBzYW1lIGRldmljZSBub2RlLg0KPiANCj4gSSB0aGluayBhIGNs
ZWFuZXIgd2F5IHRvIGhhbmRsZSB0aGlzIHdvdWxkIGJlIHRvIGp1c3QgbW92ZSB0aGUgZW50aXJl
IHNvYyBkcml2ZXINCj4gaW50byB0aGUgZmlybXdhcmUgZHJpdmVyIGFuZCB0aGVuIHJlbW92ZSB0
aGUgZHVwbGljYXRpb24uDQo+IA0KDQpZZXMsIHNvdW5kcyBsaWtlIGEgZ29vZCBpZGVhIHRvIG1l
Lg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gICAgICAgIEFybmQNCg==

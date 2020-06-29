Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E7C206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rV9faRfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbgF2U6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbgF2TNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0605.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4CC0068F8;
        Mon, 29 Jun 2020 04:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuOXzDdn5ofkp+emIv9mQCL040pAkrHADA+mtboYXx6ty0ntNlsSn1qqL/CDvgFOc8vCF0HW7nCVE48lhLBBqbNyqAsSGWBjsLTtc+55kqSKyw3N85JYvyCNW1+2048wAGTs5xyeFzzL9s3fI1urleZuPqYQlxBHvr+Iuj37tgj6tHS2ntcSC/X076tNgZlRoJDuau3nbZ8iRQvhMHUFzxkCIMSeRo93qN2c3IDmvDAT7mntvgK+nTp303SODkjdlINWjgpPg5okiVSm+37hUYUMI9/anI70SiVQEZ80YEN+aWyDl/JPGURvow9+mqHBAuCSRY/hHeTKuJ9V51YHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9VJ7773uWe3X9v7POf1jrJm6noNEStB8eJLtbZyfF8=;
 b=Zn/Ax3HhGDplZyTIQPGET1USpnZQEbj25H8O7cW1ACiNjyq56ZbsqzS0ox02RXqP7I3eE+8BieFoPoGZxfmiJyOVXjjta+PqiVdaNs12+A1I/NXUpHVIi09OHAIJsHbQ2hS99/FzOQ94ezpIc/UEoM6u15Iv47iSwFQC5Q3yJr5RiDF6EY0eTNXnpNCQHkNBlarUFCril681yLKkhUVVJkkDqSdc+xKAqqTofMri3iukPOA9K/jO8KQIjQgWRIrJPuVF9GCXjF3CwabgdV2i6JGUCdOzdeNEQ0VKDqas7vDTXFxu7qgEKP5RhuPvevsO21RdafpxABWv7PWcPhfxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9VJ7773uWe3X9v7POf1jrJm6noNEStB8eJLtbZyfF8=;
 b=rV9faRfdmNZYEsXAoonZHOb5NxPqXy85SZFsZ0NB6B5YOQQ3AA/C5wvF+aTCPeHSigkNtPPQMaLKLms2l+4HdZOCWUtcrg8ra+BkFSAaaMHOk4Fmkonz3MrkXnZD+1B25fiZwICesKhU1SY2YdesMSuZ2Qs93uDlOGJc6/C3/8Y=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB5803.eurprd04.prod.outlook.com (2603:10a6:10:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 11:43:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:43:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 10/10] clk: imx8qxp: Support module build
Thread-Topic: [PATCH V3 10/10] clk: imx8qxp: Support module build
Thread-Index: AQHWTdtpxysJAMB9PU24IC+6g53x0qjveHSAgAAAPqA=
Date:   Mon, 29 Jun 2020 11:43:28 +0000
Message-ID: <DB3PR0402MB3916911E2321760C65AB3293F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-11-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a1W4Wxj0o3dtcjGq0L5VQqsH0=ntego=jmH2Von97+H-w@mail.gmail.com>
In-Reply-To: <CAK8P3a1W4Wxj0o3dtcjGq0L5VQqsH0=ntego=jmH2Von97+H-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bcc12cf-ced1-4ed1-cfa1-08d81c21a423
x-ms-traffictypediagnostic: DB8PR04MB5803:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB580336C45074FF880B504E87F56E0@DB8PR04MB5803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yivByYm8hHLNRPS5cNoKYDH/fd8gHBi8YgrkB/kaGPy+KgE9AkTblfi2WqmRoVSLPjHuoMJnVG1tub5SZc0SJyynCNXQCpVA85V6EOL1rVQEvF9AAVb4qpY7rvicYxCD7lJ6SPVNNzJUkTv05qdRy+pN2lnF1btTwmkvKuOatX5XlL6jUPCqmoGrVIeb9/x8Ifv0D/EfxuS0extqy2NaGfvVOgP0wF5mg0RegCFOELS+DFpf/yxy4YqVTF3MlMi9h3z1AxGhDfpqwCD/BQYIueedoezirf1SRvSJeAAOzV6WndK9Dao1z5fUURsmd9yWgoLeXxMO80MCZf3NVYxPwABDFQuz/jjnTgXYzuz35MXUl37fA2pB+nOPgSIGENai
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(5660300002)(33656002)(71200400001)(478600001)(76116006)(64756008)(66446008)(66946007)(7696005)(66476007)(66556008)(4326008)(26005)(2906002)(9686003)(52536014)(55016002)(8676002)(86362001)(8936002)(186003)(6916009)(54906003)(53546011)(44832011)(6506007)(83380400001)(316002)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jdUTKSUAR31B9gw4zPtexxcvVUYQxUe+PYlH7kE9YWOHI++2P+diEs8Y+sUipPeOT6FCvRNqF7SSKFVhR6jHHTOD007chNvSpDXbJ8Kmb1ZhkZIjHxeZwNprnQN1UbLgfriUSvgBVUqNdLrWFtUlrquDWmvLYq36NDwcPi3u/HosHb2wnn+8nTwjAuWXkZ/MaqdzgLOxS1gPrXKMjlP+79JBklKb2Wfag1j6ju03R6je9ahkoNQjNfwmIZy9yRUf6Nnve2qXDV3qwXG3vnL7wntDiTt0a1LtVO1UkLoZGU5rg+D5AjtUgsKl+4QqcUqSxx4WodqDJcWxmtlQDVua0KzvGcNdvEz6z7Nz5xoabpIdxS569nPYe2O4+CvtVhMtchzRKByVuok/9EqnKcpWhrNWMyGMOPDhf2QNgWdJtT3IUSvmbGe9zD/ZFHJgYscDreVN6OiriWaj+dn2Tt+XOG5hcyRLEsy9nmG4h6VU96p1zt3CefNnw+cHaiRD/N6J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcc12cf-ced1-4ed1-cfa1-08d81c21a423
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:43:28.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: keeJnTkSx/9yOfYchrjcA5sVfybvhQ1ZeVGZk2yurFAOfI4MZmhCQDptaoBRoLqMq1bYmOWVptinzt5gtvPtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMTAvMTBdIGNsazogaW14OHF4
cDogU3VwcG9ydCBtb2R1bGUgYnVpbGQNCj4gDQo+IE9uIE1vbiwgSnVuIDI5LCAyMDIwIGF0IDg6
MDYgQU0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+
ID4gU3VwcG9ydCBidWlsZGluZyBpLk1YOFFYUCBjbG9jayBkcml2ZXIgYXMgbW9kdWxlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
IA0KPiBJIHdvdWxkIGp1c3QgY29tYmluZSB0aGUgcGVyLXNvYyBwYXRjaGVzIGludG8gb25lLCBh
cyB0aGV5IGFsbCBoYXZlIHRoZSBzYW1lDQo+IGNoYW5nZWxvZyB0ZXh0Lg0KDQpPSywgSSB3aWxs
IG1lcmdlIHRob3NlIHBhdGNoZXMgd2l0aCBzYW1lIGNoYW5nZWxvZyB0ZXh0IGludG8gb25lIHBh
dGNoLg0KQnV0IGZvciBpLk1YOFFYUCBjbG9jayBkcml2ZXIsIGFzIEkgbmVlZCB0byBhZGQgbW9y
ZSBjaGFuZ2VzIGFib3V0IG1vZHVsZSBhdXRob3INCmV0Yy4sIEkgd2lsbCBrZWVwIGl0IGFzIGEg
c2VwYXJhdGUgcGF0Y2guDQoNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OHF4cC1scGNnLmMNCj4gPiBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OHF4cC1scGNn
LmMNCj4gPiBpbmRleCAwNGM4ZWUzLi44YWZhZWZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Y2xrL2lteC9jbGstaW14OHF4cC1scGNnLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xr
LWlteDhxeHAtbHBjZy5jDQo+ID4gQEAgLTIzMiwzICsyMzIsNCBAQCBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlcg0KPiA+IGlteDhxeHBfbHBjZ19jbGtfZHJpdmVyID0geyAgfTsNCj4gPg0K
PiA+ICBidWlsdGluX3BsYXRmb3JtX2RyaXZlcihpbXg4cXhwX2xwY2dfY2xrX2RyaXZlcik7DQo+
ID4gK01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gDQo+IFNhbWUgdGhpbmcgaGVyZTogcGxl
YXNlIHRyeSB0byBtYWtlIGl0IHBvc3NpYmxlIHRvIHVubG9hZCB0aGVzZSBkcml2ZXJzLCBhbmQN
Cj4gYWRkIE1PRFVMRV9BVVRIT1IvTU9EVUxFX0RFU0NSSVBUSU9OIHRhZ3MgaW4gYWRkaXRpb24g
dG8NCj4gTU9EVUxFX0xJQ0VOU0UuDQo+IA0KDQpPSywgd2lsbCBpbXByb3ZlIGl0IGluIG5leHQg
cGF0Y2ggc2VyaWVzLg0KDQpUaGFua3MsDQpBbnNvbg0K

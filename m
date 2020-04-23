Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0661AC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA4D20724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WhvjtDBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDWKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:06:58 -0400
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:5831
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLeslSegu44/YblVoKZtzw5ZGbQxvGGHe2pbOJNk9ld2CDgNc0oBCXU0lCPgwSkEzf74ck0xJcOTbDZC15i+G6+2dk0Nl7e5hlhBAOu6gDrcaooLmTcWXrHWf2xpWvEFuKKcs6N9I8YNAJ4oXtMvJR5bQz2B9KdFFdIU27WRrG8EIG6qfm6NFoOyikgYWCpLOKvBuFLkrPiQ5Ms1/Zz4cW0NEYmzUcMgeZyJny95ziLWjQtSAPCMnFlVRSo57xZYDnbz0qCHR822ATTRJ9trh0LAynfosltGOZkBecpgqafZb8Gfw62ST31Kg11VAUYCK4dbqg40S5efQ+uC3AG1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV91eEIUv3IMIWIWPv/favlOjnV7HE+UGLknJ1C/vN0=;
 b=DumyeNSqAKDUINuKA1oGZudDW5BLHHxj86tPziNu2faZkwEz6cuzUneJBEzUIwbHEme19YKVOcWzXHcASGrxVo0s3irD9G+osQpX/JHAZuYBKB+w2JU4OvK9eKGONie7wJcskK200fo33ZnpDgv5iLjqpwyHnFEKjd9sA2fn3noRHVGf3hXJxRyzP5O2iIpvc1JwquDoepMYOp4KyNakwd8eUy97oVpARPaAPvhhmdJd9nRgF17xD78z1srDCIdd++J2O5CYBhhMCH6p2PJ3VGTilJWrJTZS8DHr17uDerGLSHNGd4C1cz6F2HAtrkmC8rniZenMqGmvvnTaGr24ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV91eEIUv3IMIWIWPv/favlOjnV7HE+UGLknJ1C/vN0=;
 b=WhvjtDBzxm9ST/cDxg7BaVYiLT2ZYFJIjOmXJohDu0pT8izU57MNL/0kXkiVH4gZScRcVXe1NLsLLPTGwl8Hvp3d0zTd0+ZYaNmoCNVSDUtLIyT/WyISgEOtcBoQXR6cb1q6Rb3wKgUJVvMnC4DSg1Dw6T/y3WhFVePjQHuCzqg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4536.eurprd04.prod.outlook.com (2603:10a6:20b:16::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 10:06:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 10:06:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/4] firmware: imx: scu-pd: ignore power domain not owned
Thread-Topic: [PATCH 3/4] firmware: imx: scu-pd: ignore power domain not owned
Thread-Index: AQHWGT3/0FZZcpj/kkCj4hqyUbpRo6iGercQ
Date:   Thu, 23 Apr 2020 10:06:54 +0000
Message-ID: <AM6PR04MB4966F8E07B105EDCAF3CB40680D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-4-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587625174-32668-4-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e67d406-6f7b-40a0-7bd0-08d7e76e0cbb
x-ms-traffictypediagnostic: AM6PR04MB4536:|AM6PR04MB4536:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB45360DD11E0317426603B41E80D30@AM6PR04MB4536.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(55016002)(5660300002)(316002)(66476007)(9686003)(54906003)(8676002)(6506007)(2906002)(81156014)(7696005)(110136005)(4744005)(66556008)(86362001)(66946007)(26005)(64756008)(478600001)(52536014)(66446008)(33656002)(44832011)(71200400001)(76116006)(186003)(4326008)(8936002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4pHusYxNS1p5lOestia9VHhROuvekSpj86ebaCqStlJwNZSACoFMEvG52/cb5qeP/DPOam7Sx00pjUbCXvwj0mf+EFdGRjXn4nVLVxhm0LYYFL/R32OK1Rv5t+uodYbK2yfgqgpNDZcojeXITvWGthpFq/qkqI5tarTyh6H2Yzl92dkBPBcNeUTGVTacTSw+fHcDW9IFxxx6rsWT5SkOunrJk1jvLSLHKlYTtER1RHbuVwAv+QCW9ZsbB9xVHCxs7DaxVldbrr7zohRBRpUZZH/T/X7424k7WsC61ebr4PnY273d3zktyHWa8CWpDY2pN3XaqamIVK6pVTIFaUapn6eLRm0YgF5sek8oi6i6cAgGcpHMmeZUxNCl+//7xKL5u/IOnZkJXHaOo/xqMoQDG6Hl9jMdjNYvPPyx8o1CkG9rD47nzfTssT1A+bCfTBY
x-ms-exchange-antispam-messagedata: XdeOp7IJSHXxDMVf/PVG0yW4dvSTJ6HPn3JvlOavueY5JlA0V0QNaeJBAOgurC/beYo2TR9q/x1VRKgLEjs8VSHKMhtA5o20Hh3S+YlRgfR1wgMm/FUfj+ESOrc0c9U/oSCzA/s6tSZ/ruE9xJB3OQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e67d406-6f7b-40a0-7bd0-08d7e76e0cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:06:54.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TniJ5M7PjxUPA6TX+us8we4RiZjLu6WPQum/SbKnVsHLwS1M2iR7+8Ag8gG90tTSuHl++KbLX+dGCbBnysnITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4536
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDM6MDAgUE0NCj4gDQo+IFNob3VsZCBub3QgcmVnaXN0ZXIgcG93ZXIgZG9t
YWluIHRoYXQgbm90IG93bmVkIGJ5IGN1cnJlbnQgcGFydGl0aW9uLg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZmly
bXdhcmUvaW14L3NjdS1wZC5jIHwgNCArKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMg
Yi9kcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYw0KPiBpbmRleCBkMWIzMTNmYTdiOTYuLjdi
NDNiZDYzY2MxZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMN
Cj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gQEAgLTQ2LDYgKzQ2LDcg
QEANCj4gDQo+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaD4gICNp
bmNsdWRlDQo+IDxsaW51eC9maXJtd2FyZS9pbXgvc2NpLmg+DQo+ICsjaW5jbHVkZSA8bGludXgv
ZmlybXdhcmUvaW14L3N2Yy9ybS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gQEAgLTI0
Niw2ICsyNDcsOSBAQCBpbXhfc2N1X2FkZF9wbV9kb21haW4oc3RydWN0IGRldmljZSAqZGV2LCBp
bnQgaWR4LA0KPiAgCXN0cnVjdCBpbXhfc2NfcG1fZG9tYWluICpzY19wZDsNCj4gIAlpbnQgcmV0
Ow0KPiANCj4gKwlpZiAoIWlteF9zY19ybV9pc19yZXNvdXJjZV9vd25lZChwbV9pcGNfaGFuZGxl
LCBwZF9yYW5nZXMtPnJzcmMgKyBpZHgpKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0KDQpTYW1l
IHF1ZXN0aW9uLg0KU2VlIG15IGNvbW1lbnQgb24gcGF0Y2ggMi80Lg0KDQpSZWdhcmRzDQpBaXNo
ZW5nDQoNCj4gIAlzY19wZCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqc2NfcGQpLCBHRlBf
S0VSTkVMKTsNCj4gIAlpZiAoIXNjX3BkKQ0KPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsN
Cj4gLS0NCj4gMi4xNi40DQoNCg==

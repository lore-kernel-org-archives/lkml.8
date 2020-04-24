Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E469C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2FD2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N8ZCMRVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDXCiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:38:09 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:59969
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbgDXCiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0PkR4ardmJOHJpvbj6UkRulayP5Lbb0oDQo61C/wzjYFnPyIOj+masSUzRmq696wOFC8yL5X7CnbRIRGUUQUKccsXs05U9GtkkySYqgnfPbZjDG8PlUGZ56SuXntkwENhN4SkeO58i8z1HOkqeucHi7WryuptrGnGgZQ3M5fHPVaNnAHeSFzS8fdFM2tvUzdUNzPlbQa5WshxSYAsPpXn3vVmekcaTzB5w0kzRL2DtLSIublU0GwNhLHkGKpf1Z8bTjsWhn2eWoz4ETIO56AnurS8/FA9iXIgKuCSK52fp//P3NmblsgpdoS31GNewY1uhIRP7wC4E/U3SHvqlbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzOAP0XP95f0wqp9u+GeMLzgkZnISNpLIYzB7c6vCeQ=;
 b=i73oOmwvNPtz1vTXpfeIhaj1CwR4dijRqUSA7F3xRDdzwB2Wkzi+ENMpFYh1IGi0jGyH3q7neQMJu4kyF2BsqPw0GxPeFEw4UlQZzGAZu3m3WytvM8LgUGkSPxTCJBtHTd4j/5n0KG/0MaWn/qqezCFT8cu5MmpTzfCDU8izP+jktkZqp8ZQe1oaZq2TRiuLXZyJ9f/6c2c5OcXu/jBv10RAFEE2wS1u6zoLIyBT3iz6JfgOGcjQGx/7GQUEqKvZUmu76v5ILvmDSIdJkkvhzKngePocxRRrKbPzYA1qZ5pnFVi/DnpM4z0E8MH4PtxMkf0hl1nuojeSsc5GJ/d3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzOAP0XP95f0wqp9u+GeMLzgkZnISNpLIYzB7c6vCeQ=;
 b=N8ZCMRVZteWFd60gz3slKyr8J/731xnEmCE9xFzWyNJMkTY4d5ZjNdc5dT/OLkIbjpeEwGQDqhtzKyu+HUBYJwkAmaNceOivGzKLgAtIo37pLaq9D3HP262jufKRIJWL9yayFJc1SNkDAHkk/B7aQytM/UI2rospejEIBXkNtX0=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4598.eurprd04.prod.outlook.com (2603:10a6:20b:26::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 02:38:04 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 02:38:04 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] firmware: imx: make sure MU irq can wake up system
 from suspend mode
Thread-Topic: [PATCH 1/2] firmware: imx: make sure MU irq can wake up system
 from suspend mode
Thread-Index: AQHWGcUyYFyr/9xk10y5Z68uwTj2MKiHjxag
Date:   Fri, 24 Apr 2020 02:38:04 +0000
Message-ID: <AM6PR04MB4966BF03338718776465D90680D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71efb847-17b9-4bb1-8960-08d7e7f88391
x-ms-traffictypediagnostic: AM6PR04MB4598:|AM6PR04MB4598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB459827FED219C61F8442310280D00@AM6PR04MB4598.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(2906002)(71200400001)(4326008)(478600001)(7696005)(5660300002)(6506007)(66446008)(76116006)(66476007)(66556008)(66946007)(64756008)(8676002)(52536014)(110136005)(33656002)(44832011)(55016002)(86362001)(26005)(81156014)(9686003)(316002)(186003)(15650500001)(8936002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lei3ZMarTjftkYb4988a4oDD/qZ6UHl21RgiBQNDt1l+66LQMpG2Yb82ldHoJsTTRV26EEJspn153esXOEDcPPEDhppDs2gklJjugoad4YIPnm1Ef8v4idjDPoWg0Hda6lmLwDJl3MAH2s4ApA7WOyxXoARDUrWIQTjbDGUhlZMR/i4s+EgxinDwY60zqNb6L+AANA2UH2dM5hlk1ro10bdYr6kmSFXgiVcNxYerg0+GCFinQot7sL+OBrRePsMdhQ53k6d3UjDCWXfpbTLhpgK/9eQhRR8k9QiTd6tJYl7KPPziNllqHlkMIgZ+dp9UrosA7a9poXVd17WBC615i4rVOr2UKT6PsFCOu2zpSsg/IBZPPU2cjMQYpag3l+t0isvoJP5D56ati9u+LXKLFQB2oqjZ34ZwjzP7TDqsPwiGhsL9a5TVC2j6Zn9JP6ms
x-ms-exchange-antispam-messagedata: Uv0oFtWCCF0OE2bF4ro93wbUksMb5SyKICkI2uq4tVidigO6cQjIky7ZnOK+/uUkwIDh33am9TSNzRDCmu0LtqVOJfY2ZTVV1MbU7OCf8rpCYfIs8ZRqKCJ7O6l3PwiMLehz/muAsu7b76caXNDw2A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71efb847-17b9-4bb1-8960-08d7e7f88391
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:38:04.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIH1mk2EzFnT3X9IS9eufknyBRUotACs8CvOCNuzj8ambCKLxGK2avUNxHIG9XvUy5mYqkoaLqSC0kA9KwlVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAyNCwgMjAyMCA3OjA3IEFNDQo+IA0KPiBJUlFGX05PX1NVU1BFTkQgZmxhZyBpcyBz
ZXQgZm9yIE1VIElSUSBvZiBJUEMgd29yaywgYnV0IHdpdGggdGhpcyBmbGFnIHNldCwNCj4gSVJR
RF9XQUtFVVBfQVJNRUQgZmxhZyB3aWxsIE5PVCBiZSBzZXQgZHVyaW5nDQo+IHN1c3BlbmRfZGV2
aWNlX2lycSgpIHBoYXNlLCB0aGVuIHdoZW4gTVUgSVJRIGFycml2ZXMsIGl0IHdpbGwgTk9UIHdh
a2UgdXANCj4gc3lzdGVtIGZyb20gc3VzcGVuZC4NCj4gDQo+IFRvIGZpeCB0aGlzIGlzc3VlLCBw
bV9zeXN0ZW1fd2FrZXVwKCkgaXMgY2FsbGVkIGluIGdlbmVyYWwgTVUgSVJRIGhhbmRsZXIgdG8N
Cj4gbWFrZSBzdXJlIHN5c3RlbSBjYW4gYmUgd2FrZWQgdXAgd2hlbiBNVSBJUlEgYXJyaXZlcy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVn
YXJkcw0KQWlzaGVuZw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1p
cnEuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQo+IGIvZHJpdmVy
cy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEuYw0KPiBpbmRleCBkYjY1NWU4Li5kOWRjYzIwIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQo+ICsrKyBi
L2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gQEAgLTEwLDYgKzEwLDcgQEAN
Cj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvaXBjLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvZmlybXdhcmUvaW14L3NjaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY2xpZW50
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc3VzcGVuZC5oPg0KPiANCj4gICNkZWZpbmUgSU1YX1ND
X0lSUV9GVU5DX0VOQUJMRQkxDQo+ICAjZGVmaW5lIElNWF9TQ19JUlFfRlVOQ19TVEFUVVMJMg0K
PiBAQCAtOTEsNiArOTIsNyBAQCBzdGF0aWMgdm9pZCBpbXhfc2N1X2lycV93b3JrX2hhbmRsZXIo
c3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiAgCQlpZiAoIWlycV9zdGF0dXMpDQo+ICAJ
CQljb250aW51ZTsNCj4gDQo+ICsJCXBtX3N5c3RlbV93YWtldXAoKTsNCj4gIAkJaW14X3NjdV9p
cnFfbm90aWZpZXJfY2FsbF9jaGFpbihpcnFfc3RhdHVzLCAmaSk7DQo+ICAJfQ0KPiAgfQ0KPiAt
LQ0KPiAyLjcuNA0KDQo=

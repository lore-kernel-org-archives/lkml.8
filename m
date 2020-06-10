Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A52C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FA0206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LIE0fqu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgFJHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:53:58 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2733
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbgFJHx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLv++6zjzmbn03ZWocqkuwS0ky1TNDodM3aCWqjFYJjNvmLYeLnqEtJWeujJmGy6mONQMeI2cKhptdsO4DDtaThYYePcUgHbvugwMrrzpiuZXVneQjzf+QT+Vei46yaBOxlp8kbk5G09HoSr6S2dXQ+CYI/AYysvNTKdnRxBrwvLgBbZ0cW4TzLxEYQ9EUqEhPlTKE0GJrDvfokQL4vepOOe8+NHTb9k4IxMM97Oq6BwjQpoyT8p/Gfcc3ZVPsJ/F2cQg/DyQDUtzZ+XPbLrZFAtFXK7GaQnG4hqeFaIcHt0tAlnZmzc1egB8EJGaMHqLWfiE3MMOqEPj6MSU3ijwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me7v+XnVdq6PelxdwT5RZp0/waIVJd5CaUZV0eJvZe4=;
 b=DFOWvBeYgz+j40ksIXJoXMFMl9Il2BhnJtUVuuEWZEBhH3a5KaCSgAW9+lZvpwlJGmPuMwr909WfAqiz/biJG7phfgBgSaVM1EMo0JcSq450XVWkrIomANFNBxMIUiVc/yBrx7VN5DmKe3ubgRiBRtJG1s5SLW4IqLlZIhYRUdiS9/h2UjnAUDYU/i4UfPg4S/c+wySUCU7rWah9+gv1TWdvwsY6I+S8RE9fFyimtTjfqKEl8BHsXqur36sqFRkRK0Fk/bs2qA1EV4gYaz6BfOsLjUmIdWWcjaQd6ouRVwkq4amdxmNgTWnI5jQ8qdLgB+aJ9IfEySY6/KgNQJ4R3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me7v+XnVdq6PelxdwT5RZp0/waIVJd5CaUZV0eJvZe4=;
 b=LIE0fqu6lBvtriOPPr6GnLZN6vwS9E6duBLIEafRrDD50wSXzuPWqxrozRVgTTb6lKMTaqit6TsInV+zKtLV1QSBVnmZjhHF2F3GWPZEnrbUA4FYMJlDf4Y9ybBxLJ0zRRmMoTSAMwrGJIirqCKvQBhWcThInTzs/+CsJRCEiAY=
Received: from DB7PR04MB4972.eurprd04.prod.outlook.com (2603:10a6:10:1c::11)
 by DB7PR04MB5337.eurprd04.prod.outlook.com (2603:10a6:5:1b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Wed, 10 Jun
 2020 07:53:54 +0000
Received: from DB7PR04MB4972.eurprd04.prod.outlook.com
 ([fe80::8cb5:8821:ad1a:7f6e]) by DB7PR04MB4972.eurprd04.prod.outlook.com
 ([fe80::8cb5:8821:ad1a:7f6e%4]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 07:53:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Topic: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Index: AQHWPrCwHFST6JvKdUylgCfenms2aajReZOQ
Date:   Wed, 10 Jun 2020 07:53:53 +0000
Message-ID: <DB7PR04MB4972E7B649B935B1EFE6469880830@DB7PR04MB4972.eurprd04.prod.outlook.com>
References: <1591742515-7108-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1591742515-7108-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a06a5efc-9625-4008-0ab6-08d80d136c37
x-ms-traffictypediagnostic: DB7PR04MB5337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5337DA164B7EE4E7A8158FDA80830@DB7PR04MB5337.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNCNk5rOn+iR1cmYtt3lvvKFQ5xNmLBs7SGeCxFaEHw/Qwt597tgeAhR9czjqxlxukNY6m4jsKbI2TB1lmd6h/q4/mJl2Jdwkqm2CRmBadHWqNcA6w9brDQkdPzAumiE7qqERrhTxYpdgck8fUZ4MOiHrBAxwk9qg9iVlv7nEoNJ7f575KP1pVtpj+ylLg9THqBTp1WmDPmJcQHrixhpxXt1E4SKGjbA4253MKuax4A6obxFsfRq6Khcdv/GDY/C4cs3eQWnaBKrQc1L/Y+sKz1oc/1ZKVSEuRFy+mxWdObycauJ8ESLGyeY1L8wU4iuJWiRYThGdW5/MiOWhd3El2BPp9F0IY0PQo6mT+w2gV8M1N0t+jMmqjBvYG4ELuDO55sh7Bpr29Pgr2XxDrgetg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4972.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(7696005)(2906002)(316002)(8676002)(110136005)(83380400001)(5660300002)(86362001)(33656002)(52536014)(8936002)(4326008)(186003)(66476007)(9686003)(6506007)(66946007)(66446008)(66556008)(55016002)(478600001)(44832011)(71200400001)(76116006)(26005)(64756008)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0yX1x3eyls5y/0pOjkxkLT8p3qt8XvW33IY9v//EWwzWkpUv+WeX56rPR2Lp6cfaShPO6D0q8IFr0VSJiEPIIi+gVWe/02p/14BE4S4LKGdQxFewEB16RYdH2ZIHgD+goUDgAhjqZH2dI9jVO6I43QV6YFKksUzxj1t/2keUiXHUQu8sRBf/6rEDEp74V359IGjrjgT8NEZOVTSeuc4ojJ6BtikjUsJ8zidkNz9kXYhDZOxz7a2XHq4uYmRJ7fLNN1CS8oE0kn8c2KYSPdsiR1JLY7zs1eioPbAWiXaQEjyhKxWfvchiRUA1+YHalZV72FHuV8yMrY+lDO7IDsoFJHUruzmI9Q1RihZj4RJ5wxrqx/24PZIFk9z6U6N0zaF+ko7+RtovGkEO7pBbxV3Jk/Xj640lnHbCivfTzhYOGd0JesOq6rK2J3mZiNT9fuPCFAQ/8hoGOLsE96h3iW3U1nJT7TS55j7EUFoxFgpdkgc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06a5efc-9625-4008-0ab6-08d80d136c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 07:53:54.2115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShOwIcVSeIU0t7YRVscT2pNvoKkvwKCVx7ZFLUEFq1tU9uT1xXAyfElI4NfQQyJmBO2Zf718JEGL08nzNcgjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDEwLCAyMDIwIDY6NDIgQU0NCj4gDQo+IENvcnJlY3QgaS5NWDhNUCBVSUQgZnVz
ZSBvZmZzZXQgYWNjb3JkaW5nIHRvIGZ1c2UgbWFwOg0KPiANCj4gVUlEX0xPVzogMHg0MjANCj4g
VUlEX0hJR0g6IDB4NDMwDQo+IA0KPiBGaXhlczogZmM0MDIwMGViZjgyICgic29jOiBpbXg6IGlu
Y3JlYXNlIGJ1aWxkIGNvdmVyYWdlIGZvciBpbXg4bSBzb2MgZHJpdmVyIikNCg0KQUZBSUsgIkZp
eGVzOiIgc2hvdWxkIHBvaW50IHRvIHRoZSBvcmlnaW5hbCBwYXRjaCB3aGljaCBpbnRyb2R1Y2Vk
IHRoZSBpc3N1ZS4NCk5vdCB0aGUgb25lIGNoYW5naW5nIGZpbGUgbmFtZS4NCg0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5n
ZXMgc2luY2UgVjE6DQo+IAktIGFkZCBmaXggdGFnLg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL2lt
eC9zb2MtaW14OG0uYyB8IDggKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14
L3NvYy1pbXg4bS5jIGIvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4bS5jIGluZGV4DQo+IDdiMDc1
OWEuLjBiYzgzMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OG0uYw0K
PiArKysgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDhtLmMNCj4gQEAgLTIyLDYgKzIyLDggQEAN
Cj4gICNkZWZpbmUgT0NPVFBfVUlEX0xPVwkJCTB4NDEwDQo+ICAjZGVmaW5lIE9DT1RQX1VJRF9I
SUdICQkJMHg0MjANCj4gDQo+ICsjZGVmaW5lIElNWDhNUF9PQ09UUF9VSURfT0ZGU0VUCQkweDEw
DQo+ICsNCj4gIC8qIFNhbWUgYXMgQU5BRElHX0RJR1BST0dfSU1YN0QgKi8NCj4gICNkZWZpbmUg
QU5BRElHX0RJR1BST0dfSU1YOE1NCTB4ODAwDQo+IA0KPiBAQCAtODcsNiArODksOCBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgaW14OG1tX3NvY191aWQodm9pZCkgIHsNCj4gIAl2b2lkIF9faW9tZW0g
Km9jb3RwX2Jhc2U7DQo+ICAJc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4gKwl1MzIgb2Zmc2V0
ID0gb2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14OG1wIikgPw0KPiArCQkgICAgIElN
WDhNUF9PQ09UUF9VSURfT0ZGU0VUIDogMDsNCj4gDQoNCglJZiAob2ZfbWFjaGluZV9pc19jb21w
YXRpYmxlKCJmc2wsaW14OG1wIikpDQoJCU9jdG9wX2Jhc2UgKz0gSU1YOE1QX09DT1RQX1VJRF9P
RkZTRVQ7DQpUaGVuIHlvdSBtYXkgbm90IG5lZWQgdGhlIGV4dHJhIGNoYW5nZXMuDQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg0KPiAgCW5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVM
TCwgImZzbCxpbXg4bW0tb2NvdHAiKTsNCj4gIAlpZiAoIW5wKQ0KPiBAQCAtOTUsOSArOTksOSBA
QCBzdGF0aWMgdm9pZCBfX2luaXQgaW14OG1tX3NvY191aWQodm9pZCkNCj4gIAlvY290cF9iYXNl
ID0gb2ZfaW9tYXAobnAsIDApOw0KPiAgCVdBUk5fT04oIW9jb3RwX2Jhc2UpOw0KPiANCj4gLQlz
b2NfdWlkID0gcmVhZGxfcmVsYXhlZChvY290cF9iYXNlICsgT0NPVFBfVUlEX0hJR0gpOw0KPiAr
CXNvY191aWQgPSByZWFkbF9yZWxheGVkKG9jb3RwX2Jhc2UgKyBPQ09UUF9VSURfSElHSCArIG9m
ZnNldCk7DQo+ICAJc29jX3VpZCA8PD0gMzI7DQo+IC0Jc29jX3VpZCB8PSByZWFkbF9yZWxheGVk
KG9jb3RwX2Jhc2UgKyBPQ09UUF9VSURfTE9XKTsNCj4gKwlzb2NfdWlkIHw9IHJlYWRsX3JlbGF4
ZWQob2NvdHBfYmFzZSArIE9DT1RQX1VJRF9MT1cgKyBvZmZzZXQpOw0KPiANCj4gIAlpb3VubWFw
KG9jb3RwX2Jhc2UpOw0KPiAgCW9mX25vZGVfcHV0KG5wKTsNCj4gLS0NCj4gMi43LjQNCg0K

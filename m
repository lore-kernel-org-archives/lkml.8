Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D7DC35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19EF24653
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUHD3zWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgBYEPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:15:13 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:6235
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbgBYEPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:15:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab07hwmsjZrCmVZzJ3SUy7RNOcwqYS5Ow33mO9BFkn2j/rZ52q/SeM/geK6IEPffVhJkt4kAfn5ULT52WIhHoX23bkxpaZzXZ5782G94pZ9iwCAkdSX8qpl86yyrukPBEgOuaHMcvcjCeBaTkAOaMM9qpGSvIxmmd4h2zpmhlB/4JIt/e6cpjAIQu1lRZ0ob3rA2yxmqH5JINe44qBzp6P06IcmNuAeXF3hgNOUaCmrkeW/yRQAHK6fnyCwlND1MqicfBqHRk5EuR7F7faUMsqA5109sozA/O2oa4rgNNhwi1S6aUb6uJlsSyGzRuab5GaqQ/kvGbKOJI7Wfuqe0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v427+uFanGN41OZvgX8pMhkN8P9/c/6Q85gWGEGtXdc=;
 b=InAJcdAxjJYTBvt9Ufva/b3W4BeSCLlzc+GxTPpvs5OsMV43t5UNvM7KPWSh+tr+sPdBerz0yV4g3XuKXl6FS1vTsNF7xeKL8AI7mFp2A9k47k+CvoU4xwmKgpB8YZchIc7gzgu8c6ny623Y3b4Fr8JFgkktzMYV2T9vGHwKvwJPD9ZUDCMHzEMk0yQqMJQeqSXiRR+h8GeFFg9dQc2c3WCWEESYUrqrHXeEeGQ+0yn5ozG01Ku66I9y2e4bLZfEz1yGdxUv5I4PiE+aWEtvr3qpzf/q1Ow2T9/d07kVFZ+ktln6yjti+Jzn4m6tvIpN2OPdBkaAh2pfxatjQU2LdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v427+uFanGN41OZvgX8pMhkN8P9/c/6Q85gWGEGtXdc=;
 b=nUHD3zWol2EnqEmNvMCJnRBbSOW0o9sI7LhJHGrJ805tG00N5MYnFc5VDSJymO5yYvlh503xSRGvKmU786tBhiNPZ8au+oNffRgARqH0bNlSFwin2P0CZwhdItLxaATqrYVdO9n90fbUIqvunI/p2TdjOOgrdrlpS6uW/V2qSII=
Received: from VI1PR04MB6992.eurprd04.prod.outlook.com (52.133.247.22) by
 VI1PR04MB6126.eurprd04.prod.outlook.com (20.179.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 04:15:08 +0000
Received: from VI1PR04MB6992.eurprd04.prod.outlook.com
 ([fe80::9879:13e1:8f56:cb3b]) by VI1PR04MB6992.eurprd04.prod.outlook.com
 ([fe80::9879:13e1:8f56:cb3b%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 04:15:07 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [PATCH] ARM64: dts: imx8m: fix aips dts node
Thread-Topic: [PATCH] ARM64: dts: imx8m: fix aips dts node
Thread-Index: AQHV646vWLiVkiqi30itYtGPLIEo/6grSRNg
Date:   Tue, 25 Feb 2020 04:15:07 +0000
Message-ID: <VI1PR04MB69920BD928735E22A8B9928987ED0@VI1PR04MB6992.eurprd04.prod.outlook.com>
References: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1582602242-28577-1-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4aab26a5-191e-4994-34d2-08d7b9a94c5b
x-ms-traffictypediagnostic: VI1PR04MB6126:|VI1PR04MB6126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6126DFEA18D5CBE0AD54210487ED0@VI1PR04MB6126.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(86362001)(478600001)(33656002)(4326008)(2906002)(316002)(5660300002)(53546011)(66556008)(54906003)(8676002)(8936002)(64756008)(26005)(66946007)(7696005)(110136005)(66476007)(66446008)(76116006)(186003)(81156014)(81166006)(71200400001)(55016002)(9686003)(52536014)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6126;H:VI1PR04MB6992.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBa7htMJxqVYU72Yqv43rV1DyW4OG3OFYpbu5prySTHOLVMS3Fw8Gfb0UBMNNZ3oREHyjzCzslBK2R4ph3C1pTkgJKd02Ix/Q8mWqKpRVi+YeO6NqeagOhf7DpqhdtYQuEjILwi322fk1STdO4jGvQa/Hm8PMXSS/yC+jHtg4URKyAltL8Mg65CIB6VwOIA5XsGv/blS7WM8f5AzogYObn7Swj2MjgiSSCu7FCzavpPqgIUgDfpnRz8CGcxU/4eGytZDgOejpbBiRl95u6RnZ0K3DoO/YWFy3XeJuBf01HQ5RL7saEe7sI6m5Foq7+ca4okRsXoHv/tFKo8XCG0vu9HhZtE0k+mHdnrAx2JWas/yWBMx4yFLGrcTXQH1Lev65PSA9uZAUTMyNr4bZRvyNpgoXVuBKz9J5mcYGvPL2xk5DxqxPD0ipSBPuAQ7A5wW3Ent9QuxmO4pAm994XGlcq+dwjUZmyFARwt84uiNt6YH19MRDSeqHHH5ZMNjf80X
x-ms-exchange-antispam-messagedata: wSXC33zOQKeAnpmQMK/nUv//tr8M93QL6/RzUoBYGHDbAExlZ8wNwKMnpyne051f7MZa7RL7FXrrYLVuvIjM+c2LTx3GlvljUZm+D9XBWoLpyzw/j5U0g5njEmBGV1262l9YviT5xkvug+PwkpICDA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aab26a5-191e-4994-34d2-08d7b9a94c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 04:15:07.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wI810oDkP9XnxquaH0m3bSRuuzpohVvMlWn4tuZHCw6s5aJtucxK+tYtAlbh1EbQfXfA/JS0RXCxonmR/MzwMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjUsIDIwMjAgMTE6NDQgQU0NCj4g
VG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtl
cm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBu
eHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5zb24N
Cj4gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBMZW9uYXJkIENyZXN0ZXoNCj4gPGxlb25h
cmQuY3Jlc3RlekBueHAuY29tPjsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29t
PjsgUGVuZw0KPiBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gQVJN
NjQ6IGR0czogaW14OG06IGZpeCBhaXBzIGR0cyBub2RlDQo+IA0KPiBGcm9tOiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IFBlciBiaW5kaW5nIGRvYyBmc2wsYWlwcy1idXMueWFt
bCwgY29tcGF0aWJsZSBhbmQgcmVnIGlzIHJlcXVpcmVkLiBBbmQgZm9yIHJlZywNCj4gdGhlIEFJ
UFMgY29uZmlndXJhdGlvbiBzcGFjZSBzaG91bGQgYmUgdXNlZCwgbm90IGFsbCB0aGUgQUlQUyBi
dXMgc3BhY2UuDQo+IA0KDQpBbnkgcmVhc29uIHRoYXQgd2UgbmVlZCB0byBhZGQgdGhlIGFpcHMg
YnVzIGNvbXBhdGlibGUgJiByZWcgYmFjaz8gVGhlIGFpcHMgY29uZmlnIHNwYWNlDQpjYW4gb25s
eSBiZSB3cml0ZSBieSBzZWN1cmUgd29ybGQsIGxpbnV4IGhhcyBubyBwZXJtaXNzaW9uIHRvIGNv
bmZpZyB0aGUgYWlwcyBwb3J0LiBBbmQgaXQgc2VlbXMNCm5vIGRyaXZlciB1c2UgImZzbCxhaXBz
IiBhbnltb3JlLg0KDQpCUg0KSmFja3kgQmFpDQoNCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLmR0c2kgfCAxMiArKysrKysrKy0tLS0NCj4gYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1uLmR0c2kgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+IGFyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgMTIgKysrKysrLS0tLS0tDQo+IGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpIHwgMTIgKysrKysrKystLS0tDQo+
ICA0IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNp
DQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gaW5kZXgg
YjNkMGIyOWQ3MDA3Li5hNDM1NmQyMDQ3Y2QgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+IEBAIC0yMjcsNyArMjI3LDggQEANCj4gIAkJcmFuZ2Vz
ID0gPDB4MCAweDAgMHgwIDB4M2UwMDAwMDA+Ow0KPiANCj4gIAkJYWlwczE6IGJ1c0AzMDAwMDAw
MCB7DQo+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiArCQkJY29tcGF0aWJsZSA9
ICJmc2wsYWlwcyIsICJzaW1wbGUtYnVzIjsNCj4gKwkJCXJlZyA9IDwweDMwMWYwMDAwIDB4MTAw
MDA+Ow0KPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCQkjc2l6ZS1jZWxscyA9IDwx
PjsNCj4gIAkJCXJhbmdlcyA9IDwweDMwMDAwMDAwIDB4MzAwMDAwMDAgMHg0MDAwMDA+OyBAQCAt
NDk2LDcNCj4gKzQ5Nyw4IEBADQo+ICAJCX07DQo+IA0KPiAgCQlhaXBzMjogYnVzQDMwNDAwMDAw
IHsNCj4gLQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ICsJCQljb21wYXRpYmxlID0g
ImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiArCQkJcmVnID0gPDB4MzA1ZjAwMDAgMHgxMDAw
MD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+
Ow0KPiAgCQkJcmFuZ2VzID0gPDB4MzA0MDAwMDAgMHgzMDQwMDAwMCAweDQwMDAwMD47IEBAIC01
NTUsNw0KPiArNTU3LDggQEANCj4gIAkJfTsNCj4gDQo+ICAJCWFpcHMzOiBidXNAMzA4MDAwMDAg
ew0KPiAtCQkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gKwkJCWNvbXBhdGlibGUgPSAi
ZnNsLGFpcHMiLCAic2ltcGxlLWJ1cyI7DQo+ICsJCQlyZWcgPSA8MHgzMDlmMDAwMCAweDEwMDAw
PjsNCj4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkJI3NpemUtY2VsbHMgPSA8MT47
DQo+ICAJCQlyYW5nZXMgPSA8MHgzMDgwMDAwMCAweDMwODAwMDAwIDB4NDAwMDAwPjsgQEAgLTgw
MCw3DQo+ICs4MDMsOCBAQA0KPiAgCQl9Ow0KPiANCj4gIAkJYWlwczQ6IGJ1c0AzMmMwMDAwMCB7
DQo+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiArCQkJY29tcGF0aWJsZSA9ICJm
c2wsYWlwcyIsICJzaW1wbGUtYnVzIjsNCj4gKwkJCXJlZyA9IDwweDMyZGYwMDAwIDB4MTAwMDA+
Ow0KPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsN
Cj4gIAkJCXJhbmdlcyA9IDwweDMyYzAwMDAwIDB4MzJjMDAwMDAgMHg0MDAwMDA+OyBkaWZmIC0t
Z2l0DQo+IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiBpbmRleCBmMjc3NTcy
NDM3N2YuLjQ4NDhjZTgyZjA4MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1uLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1uLmR0c2kNCj4gQEAgLTIwMyw4ICsyMDMsOCBAQA0KPiAgCQlyYW5nZXMgPSA8MHgw
IDB4MCAweDAgMHgzZTAwMDAwMD47DQo+IA0KPiAgCQlhaXBzMTogYnVzQDMwMDAwMDAwIHsNCj4g
LQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IC0JCQlyZWcgPSA8MHgzMDAwMDAwMCAw
eDQwMDAwMD47DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0K
PiArCQkJcmVnID0gPDB4MzAxZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzOw0KPiBAQCAtNDAx
LDggKzQwMSw4IEBADQo+ICAJCX07DQo+IA0KPiAgCQlhaXBzMjogYnVzQDMwNDAwMDAwIHsNCj4g
LQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IC0JCQlyZWcgPSA8MHgzMDQwMDAwMCAw
eDQwMDAwMD47DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0K
PiArCQkJcmVnID0gPDB4MzA1ZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzOw0KPiBAQCAtNDYx
LDggKzQ2MSw4IEBADQo+ICAJCX07DQo+IA0KPiAgCQlhaXBzMzogYnVzQDMwODAwMDAwIHsNCj4g
LQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IC0JCQlyZWcgPSA8MHgzMDgwMDAwMCAw
eDQwMDAwMD47DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0K
PiArCQkJcmVnID0gPDB4MzA5ZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzOw0KPiBAQCAtNzA3
LDggKzcwNyw4IEBADQo+ICAJCX07DQo+IA0KPiAgCQlhaXBzNDogYnVzQDMyYzAwMDAwIHsNCj4g
LQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IC0JCQlyZWcgPSA8MHgzMmMwMDAwMCAw
eDQwMDAwMD47DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0K
PiArCQkJcmVnID0gPDB4MzJkZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzOw0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiBpbmRleCA3MWIwYzhmMjM2
OTMuLmViNjdmNTZjZGZlMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLmR0c2kNCj4gQEAgLTE0NCw4ICsxNDQsOCBAQA0KPiAgCQlyYW5nZXMgPSA8MHgwIDB4
MCAweDAgMHgzZTAwMDAwMD47DQo+IA0KPiAgCQlhaXBzMTogYnVzQDMwMDAwMDAwIHsNCj4gLQkJ
CWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IC0JCQlyZWcgPSA8MHgzMDAwMDAwMCAweDQw
MDAwMD47DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiAr
CQkJcmVnID0gPDB4MzAxZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzOw0KPiBAQCAtMzA5LDgg
KzMwOSw4IEBADQo+ICAJCX07DQo+IA0KPiAgCQlhaXBzMjogYnVzQDMwNDAwMDAwIHsNCj4gLQkJ
CWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+IC0JCQlyZWcgPSA8MHgzMDQwMDAwMCAweDQw
MDAwMD47DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiAr
CQkJcmVnID0gPDB4MzA1ZjAwMDAgMHg0MDAwMDA+Ow0KPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQo+ICAJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCXJhbmdlczsNCj4gQEAgLTM2OSw4
ICszNjksOCBAQA0KPiAgCQl9Ow0KPiANCj4gIAkJYWlwczM6IGJ1c0AzMDgwMDAwMCB7DQo+IC0J
CQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiAtCQkJcmVnID0gPDB4MzA4MDAwMDAgMHg0
MDAwMDA+Ow0KPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsYWlwcyIsICJzaW1wbGUtYnVzIjsNCj4g
KwkJCXJlZyA9IDwweDMwOWYwMDAwIDB4NDAwMDAwPjsNCj4gIAkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiAgCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICAJCQlyYW5nZXM7DQo+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQ0KPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpDQo+IGluZGV4IDZhMWU4MzkyMmM3
MS4uMDcwNzA0NjQwNjNkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXEuZHRzaQ0KPiBAQCAtMjkwLDcgKzI5MCw4IEBADQo+ICAJCWRtYS1yYW5nZXMgPSA8MHg0
MDAwMDAwMCAweDAgMHg0MDAwMDAwMCAweGMwMDAwMDAwPjsNCj4gDQo+ICAJCWJ1c0AzMDAwMDAw
MCB7IC8qIEFJUFMxICovDQo+IC0JCQljb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KPiArCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsYWlwcyIsICJzaW1wbGUtYnVzIjsNCj4gKwkJCXJlZyA9IDwweDMw
MWYwMDAwIDB4MTAwMDA+Ow0KPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICAJCQkjc2l6
ZS1jZWxscyA9IDwxPjsNCj4gIAkJCXJhbmdlcyA9IDwweDMwMDAwMDAwIDB4MzAwMDAwMDAgMHg0
MDAwMDA+OyBAQCAtNjkyLDcNCj4gKzY5Myw4IEBADQo+ICAJCX07DQo+IA0KPiAgCQlidXNAMzA0
MDAwMDAgeyAvKiBBSVBTMiAqLw0KPiAtCQkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4g
KwkJCWNvbXBhdGlibGUgPSAiZnNsLGFpcHMiLCAic2ltcGxlLWJ1cyI7DQo+ICsJCQlyZWcgPSA8
MHgzMDVmMDAwMCAweDEwMDAwPjsNCj4gIAkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ICAJCQlyYW5nZXMgPSA8MHgzMDQwMDAwMCAweDMwNDAwMDAw
IDB4NDAwMDAwPjsgQEAgLTc1MSw3DQo+ICs3NTMsOCBAQA0KPiAgCQl9Ow0KPiANCj4gIAkJYnVz
QDMwODAwMDAwIHsgLyogQUlQUzMgKi8NCj4gLQkJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7
DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiArCQkJcmVn
ID0gPDB4MzA5ZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
IAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzID0gPDB4MzA4MDAwMDAgMHgzMDgw
MDAwMCAweDQwMDAwMD4sIEBAIC0xMDIzLDcNCj4gKzEwMjYsOCBAQA0KPiAgCQl9Ow0KPiANCj4g
IAkJYnVzQDMyYzAwMDAwIHsgLyogQUlQUzQgKi8NCj4gLQkJCWNvbXBhdGlibGUgPSAic2ltcGxl
LWJ1cyI7DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxhaXBzIiwgInNpbXBsZS1idXMiOw0KPiAr
CQkJcmVnID0gPDB4MzJkZjAwMDAgMHgxMDAwMD47DQo+ICAJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCj4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJcmFuZ2VzID0gPDB4MzJjMDAwMDAg
MHgzMmMwMDAwMCAweDQwMDAwMD47DQo+IC0tDQo+IDIuMTYuNA0KDQo=

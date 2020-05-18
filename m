Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C58C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F5F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oE8L5bRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgERJJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:09:45 -0400
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:17633
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlYEloSHZP8h9no9Pat/qVbOzCFaVxc71zZtLwOWgQ9LLdQQss6NgIeN1OoDo98KoouNRNOrj9Lq9CoVVHIEQ9rbxpI6f32rjamnOeLjsxVVvZHmUgpz1TMURbHsbKOULvSwuPJTtxDso4QBwcT0gMcVoMt54kk5dsmjA/Um7OV64L34BvN8AKKVYklyYZV+gsiVj/EYYXNe7cOGFb0Uha77PRPfv5Im8GtO/ris8N4yy3W2jDJ4i7cL0I8C6KyjpCOFl2Hn2D9qMMn8AoG9DvUWj41JcfmeWLiMRm+WSoRLR1Nywrk9IzBr/rOpXT5LAHxCSxSp3ck8Y1iNIjrhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbhOV8NPs1hJXzCgoEoOnmTsLnn4fXCc2oE1WQZtExI=;
 b=HtL/CtlVg/Cck6sijmXsLxlYdPLADH+Mr2Rr0q0kZoPvHXiip6zVHJF9EyM0S17VrnZjIeQ2yDe5IBj2svouxC9yDX20JWoNiP8+ZoemHZ5of3LMPQ/3pdxrU9WM3ClNM1tx9sw3LjnAsQ/DGO2hZi7wa4+MxWpyIqKUo1adjcLRj0xhTwxik/9Wj4BOw5fSS+heXnBBzSRCXI32C2/sEDdQZiuOwEvAUUS45TZwX4ceNKOiDdRxV6d2m8dExDt/jGNBjZoXJlS1uRe8VYMbam9A+IT56n14Rz88m10PfhShGM7FUQyzXS6ncsy9JrD26jxDpgai1+X82D7dYzImCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbhOV8NPs1hJXzCgoEoOnmTsLnn4fXCc2oE1WQZtExI=;
 b=oE8L5bRDzjWpYAFETq7da6oPKwgLmnVhb6rccNJszXqsB7zVOEJPYGkJOAmUiusewl9HqpIwFCJTUjQstO2rTvp0qI+plYigbEQi2zOYybWF131pw5fr2bB66oKspMeBU3XD0hl4PoNWiojuP3CxbsHCKQe2ikWKFLvfXiOrVxc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5509.eurprd04.prod.outlook.com (2603:10a6:20b:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 09:09:41 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 09:09:41 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] ARM: dts: imx51: Add src node interrupt
Thread-Topic: [PATCH 1/2] ARM: dts: imx51: Add src node interrupt
Thread-Index: AQHWKAXeNUM3Dc7i3kKbaOY3gSyNJKitl5sQ
Date:   Mon, 18 May 2020 09:09:41 +0000
Message-ID: <AM6PR04MB4966830C391C7E69E6CE203080B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589250307-29662-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ceb642d6-bb43-42ac-caae-08d7fb0b32d9
x-ms-traffictypediagnostic: AM6PR04MB5509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB55091587714BD92790ADC13980B80@AM6PR04MB5509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dD6Evep7HJP2bsmY5t8XJQxEUJ+SkLfhGk0WmjeK3K9vqXxyhXmoK697AEeUeJHoufmyvI+2EOW3tYF1iZ6P1vcJOPXDHAv4HtKcwCQrUembUlCYkJ4qd5i5619cmVVZwsbf3q7CqHlQzQcYEF7mpTSynwFbZe3d0j0DWbdc3i+LN4vO0OGbjPZlWob9DZd6W2+InCAsOw0OpJS5hBgGn4zeIVtZNxyDzOB9SrXCytlwGcPId7nkamrvPbkD43EthEZS/zL1BvkWK2qFMRtRA87lLP3h/s32nuWr+CIkFNgUWmGEbjX31mZMUcdKcNuxVnUqBXkC96XOG0SStIsFmuRjAIBG+GFiAi7gjzogqksjYsmcApZbpo2ReSgGXR6d6gjenlN1JTpNU1gS6Dbklln8jPt+DKj0h6gCpiypUEHH969DovDiqMTx8KYSO3tr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(5660300002)(55016002)(8936002)(8676002)(26005)(186003)(71200400001)(6506007)(9686003)(4326008)(478600001)(7696005)(316002)(110136005)(86362001)(4744005)(44832011)(66476007)(33656002)(64756008)(2906002)(76116006)(66446008)(52536014)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QCpH/DrL0c8LBa5n2rdUWsPlQq4K0LVqaXH8AsNkdkZUEHfkgdoNIf/hScHTvTzmSwUvi7/RV664JPx4TSsc1cG1YNNES/N0WixPw8uk/ZZ76qSoVYbnDhjfI6B86pIdf2BYz+ZGG6k5iIeqYbwfzUJWEsJ4vukVkFmnN3i+MV2Ipv+RPuxMHixPIHvx2faMcgNBdcWB0fPIiuIYaj2Z3KgaO1iZ9rO0NZTkWPdHL3i8Wiq3c4FRh6WBRl0LGrLU2i9/fCnTD/ZOmuGFDm3eFhD6CyQBZNLi4jvEdR2iExL8ROHxaK7eDj5EXt4AUCgbWLETQVRHd1VCrdvgAS0+SyYrVYkn+mfADcHxBMUJl03lxYCf+vGNqhO8Uh16AoHiyc6bNo0vTL4HAl6ex7TOENYdw6hyoIfHHN8LiqA9QmcFJ9OZa62t7/ogLTj5/TtGKImSIhxJxfmpIJSadbl5Tu8945PiOxpZ0GrG1zlXQd2r/N1MHaeDZewpMq4LpGaM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb642d6-bb43-42ac-caae-08d7fb0b32d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 09:09:41.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLr7XIHQhEiOxjuH/VXyWFTD4zM8dQTtWuamH0aPwJ0L80iekzH1Qhow4Z9vXNZ0+mx2FjFlcM3BbPyBbxZxMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTWF5IDEyLCAyMDIwIDEwOjI1IEFNDQo+IA0KPiBJbnRlcnJ1cHQgaXMgYSByZXF1aXJlZCBw
cm9wZXJ0eSBhY2NvcmRpbmcgdG8gU1JDIGJpbmRpbmcsIGFkZCBpdCBmb3IgU1JDIG5vZGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDUxLmR0c2kgfCAx
ICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDUxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg1MS5k
dHNpIGluZGV4DQo+IDkyZmJiOTAuLjNmMWU5MTMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDUxLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NTEuZHRzaQ0K
PiBAQCAtNDQyLDYgKzQ0Miw3IEBADQo+ICAJCQlzcmM6IHNyY0A3M2ZkMDAwMCB7DQo+ICAJCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsaW14NTEtc3JjIjsNCj4gIAkJCQlyZWcgPSA8MHg3M2ZkMDAwMCAw
eDQwMDA+Ow0KPiArCQkJCWludGVycnVwdHMgPSA8NzU+Ow0KPiAgCQkJCSNyZXNldC1jZWxscyA9
IDwxPjsNCj4gIAkJCX07DQo+IA0KPiAtLQ0KPiAyLjcuNA0KDQo=

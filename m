Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F635C38A30
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF40420776
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z1Rfa9vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDRM2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:28:39 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:6127
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgDRM2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AirvPf7CnHz0VZUetLDv9SYK1Y6MqW+yOukN52gNM8QjRhtr/GNP8wgwsu21cevgfrDf64lwTEbgPXddGESKvpEk2T0kQTu0K+RnI76w84tKJJIo5fGEHyX/G2IDswfiGKBxSwzfT1zmFKuvfAUjUg8zGNBv3vWEylKJTuO/0bB6J789AAYNXwMJB98C3BneeScCYLnoBrg39s7u1hVXl1CA2WHVr4MxNCCd+pxl5XB6n9ZdVlVo8YkU5wvr+M9QnmhL0XQOQoxevL/U6yfS2LcpxVtgMOs33XK6eRljwcjJq8l6nfjbCiuKVttUqzszCf4q9BgQrBC3HwSXWFFBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR0jMAhfFbDk4gNaCRhrWzPf7oInTvy0WtusPX7ruCw=;
 b=XEboyJ0ujcLLDHR1QmS5OiokuR1dZ7IH6xrC3lSxSqgifrjg3Ult3aav2/kFvRp1obwHHbaESXduVQu9C3aOCv664E4IPyTgybOe4gjE2Krkj7B/ODVkrVP9pD4R5pmGQMxcesYjYbMZTJHw0n3AYeKxydXfVW6D/NZ/+pt4sq7t4mfR7pwurcNk0LNP/JRjmFKSuco6nG8pI+Jx1HquqNjUTkYQh91mNEXYSi5nTBKUR6OjtN3KPHL946dHzCoch7xWjysvXakDR3v1f8iiiVJdB5cuEYkTVLvDImf8DpEKrIHsoLwug1jHzHWyjhG0QrIeKHq/5ggwAjLNIsbhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR0jMAhfFbDk4gNaCRhrWzPf7oInTvy0WtusPX7ruCw=;
 b=Z1Rfa9vqaOHRGGP+ueL0ZEq142+3NK3qY/0CW5AHnXOtXDRxYuSL7JofoYn3bCkmpK7xWKdkOuxp8JjAdn2s004+3D6LYfbPxQ1tuudUTfZgwrnpxyjdMgOQdb/p8yTUHQuFZRTO+cPUftQprCvsYdj3DHC52xS2KZuDzG5mISg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Sat, 18 Apr
 2020 12:28:31 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 12:28:31 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Thread-Topic: [PATCH 1/2] arm64: dts: imx8qxp-mek: Sort labels alphabetically
Thread-Index: AQHWFHuqWzzklb0b6kSSZSO2avVUNKh+z3KA
Date:   Sat, 18 Apr 2020 12:28:31 +0000
Message-ID: <AM6PR04MB496663AED27DFD38E648169C80D60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587101946-19495-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587101946-19495-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8d16b8c-aa68-4890-9021-08d7e3940193
x-ms-traffictypediagnostic: AM6PR04MB5752:|AM6PR04MB5752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB575227403CE6E87F42D1633C80D60@AM6PR04MB5752.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(8676002)(2906002)(478600001)(966005)(186003)(6506007)(110136005)(44832011)(8936002)(316002)(71200400001)(26005)(76116006)(81156014)(66476007)(66556008)(64756008)(66446008)(66946007)(55016002)(33656002)(9686003)(4326008)(86362001)(52536014)(5660300002)(7696005)(21314003)(921003)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: viExhar4rnDXOi2p8oPacKygjWaNHiUBpS+Pdp0ULpNjBmiGViV9NY5NF3qT4Jg4rNTFESW35TyM07Tceeo8kuh6WpKd+tcyzk+dxlgQGFrWuaTvQPRG0vCvTDPl7jQr2/+CNVQP0HHzF7AEXyBsYV7xQexWWldj6j7K4Y6Qq7ZqJX46r+nTrFznU5csdJjJEE3Q8JSnTjJ0DnUQqtr1S7tOPSbsB5ouet20XFhktNxbSSmFjPWFV62GG7cTq1JJUxUtbqyLo18OkPSBgXCpy/1bXEMUQdICR6LrOF1YTO/2SnxL4L2XFYWr7Es0dODKiOFuTbQdo8+OX60FxYMtO7nJmCFAAuz50sk5v7tc21ODaiKL6NRPGl5UyVUoyvcJH6KGQ5WwkIOHHEo3HJ6DcZXm2/lWQ3cfxHzjXz/mWoWwJOeJnlvtdQSBgmmXnqBsZY9z6LL5e/Miu94U/sX7YpSVOnq+cxmgbWG3eUQcZAKaPI9GdLVNs1mZjUGd4lafHNKI/lp57yHkzoVdRfQedvlOr6PpET0Py+uIwkgZWuGJu2Jg6cUJkWo4M6fZ4buvr1m0u1/n7TsBgXkg8p6BhowvtXoeXT9ZZq8TGeiu5n8=
x-ms-exchange-antispam-messagedata: GxhMbrb//DfGgH/iuAsWrozjULbQ0Hv9x9Rx5TVLVsXMhxm7pMAzxqPisypZacdlrZrSNryQlXLai8L80HZ55vudOZo2MTUM4y43GwUa8Bmv+o0i541iYlkEISXMyvEQAQlGsg1AorHEDY7lJrhyYQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d16b8c-aa68-4890-9021-08d7e3940193
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 12:28:31.5760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgT9q7N0HqPBqeHwuiU0J/IrE7rWtXQhfvmMrSKiSfE5LuUmUc24fJW3f5w/VrBn6i5s5LZ2g1Ewq+LfqeWjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAxNywgMjAyMCAxOjM5IFBNDQo+IA0KPiBTb3J0IHRoZSBsYWJlbHMgYWxwaGFiZXRp
Y2FsbHkgZm9yIGNvbnNpc3RlbmN5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQoNClRoaXMgcGF0Y2ggaXMgbWVhbmluZ2xlc3MgYXMgc3Vi
c3lzIHByZWZpeCAoZS5nLiBhZG1hX3h4eCkgd2lsbCBiZSByZW1vdmVkIGxhdGVyDQphbmQgZGV2
aWNlcyBub2RlcyBhbGwgbW92ZWQgaW50byBzdWJzeXMgZHRzaS4NCkkndmUgcmVwbGllZCB0aGlz
IGJlZm9yZToNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzMvMTYvMjQ0DQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhx
eHAtbWVrLmR0cyB8IDYwDQo+ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAtbWVrLmR0cw0KPiBpbmRleCAx
MzQ2MGEzLi4yZWQ3YWJhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4cXhwLW1lay5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHF4cC1tZWsuZHRzDQo+IEBAIC0zMCwyOSArMzAsOCBAQA0KPiAgCX07DQo+ICB9Ow0K
PiANCj4gLSZhZG1hX2xwdWFydDAgew0KPiAtCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+
IC0JcGluY3RybC0wID0gPCZwaW5jdHJsX2xwdWFydDA+Ow0KPiAtCXN0YXR1cyA9ICJva2F5IjsN
Cj4gLX07DQo+IC0NCj4gLSZmZWMxIHsNCj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
PiAtCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mZWMxPjsNCj4gLQlwaHktbW9kZSA9ICJyZ21paS1p
ZCI7DQo+IC0JcGh5LWhhbmRsZSA9IDwmZXRocGh5MD47DQo+IC0JZnNsLG1hZ2ljLXBhY2tldDsN
Cj4gKyZhZG1hX2RzcCB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAtDQo+IC0JbWRpbyB7DQo+
IC0JCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gLQ0K
PiAtCQlldGhwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+IC0JCQljb21wYXRpYmxlID0gImV0aGVy
bmV0LXBoeS1pZWVlODAyLjMtYzIyIjsNCj4gLQkJCXJlZyA9IDwwPjsNCj4gLQkJfTsNCj4gLQl9
Ow0KPiAgfTsNCj4gDQo+ICAmYWRtYV9pMmMxIHsNCj4gQEAgLTEzMSw2ICsxMTAsMzUgQEANCj4g
IAl9Ow0KPiAgfTsNCj4gDQo+ICsmYWRtYV9scHVhcnQwIHsNCj4gKwlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9scHVhcnQwPjsNCj4gKwlzdGF0
dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICsmZmVjMSB7DQo+ICsJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmVjMT47DQo+ICsJcGh5LW1v
ZGUgPSAicmdtaWktaWQiOw0KPiArCXBoeS1oYW5kbGUgPSA8JmV0aHBoeTA+Ow0KPiArCWZzbCxt
YWdpYy1wYWNrZXQ7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArDQo+ICsJbWRpbyB7DQo+ICsJ
CSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0KPiAr
CQlldGhwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+ICsJCQljb21wYXRpYmxlID0gImV0aGVybmV0
LXBoeS1pZWVlODAyLjMtYzIyIjsNCj4gKwkJCXJlZyA9IDwwPjsNCj4gKwkJfTsNCj4gKwl9Ow0K
PiArfTsNCj4gKw0KPiArJnNjdV9rZXkgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307DQo+
ICsNCj4gICZ1c2RoYzEgew0KPiAgCWFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWF9DT05OX1NE
SEMwX0NMSz47DQo+ICAJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MjAwMDAwMDAwPjsNCj4gQEAg
LTIyOSwxMSArMjM3LDMgQEANCj4gIAkJPjsNCj4gIAl9Ow0KPiAgfTsNCj4gLQ0KPiAtJmFkbWFf
ZHNwIHsNCj4gLQlzdGF0dXMgPSAib2theSI7DQo+IC19Ow0KPiAtDQo+IC0mc2N1X2tleSB7DQo+
IC0Jc3RhdHVzID0gIm9rYXkiOw0KPiAtfTsNCj4gLS0NCj4gMi43LjQNCg0K

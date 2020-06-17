Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9657EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF1F21475
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z/y+L4gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFQH5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:57:52 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:60608
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgFQH5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9d8mvTPorDFRlhF6Yla5YgZMQxYOSWEIYINLr0MzwlMM9TObpeSQ8SoRz/qlvKTr32J+TVr6v/ZE3EdY78qmug31dUcAlC33wLrqwORm6XQpzoprv4NjnEFHjSrfp4Co9mmbF/ubEYooc0tSLCmzRY714CQLDTWPt498NLPgAjhcXxbsrYkDRn88WLqw+5MjQhKhzypjFx7X2lxrqqNdTali4Vrgqf3XCUVulR+E+aKIZw+JF1HeasWQf1a179cGA0kOsSDspiqaiceu0siTnH7Vtc4Zen4NWeadtzp4AfnNB5PapgKSwLeFajz0hRlhHpfsjbmcImv7BsngAnnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j1aV5XZIsetXMs+sMI7LV3EIQnLaqm8ztF8l48uRrU=;
 b=hJKsEteITnq5RzutdDaXtpZ0LsUiDktvksTGNVD7CnBH/cC3Eem2RxtE8HsKkinwYVELXnYkt8A5T19o+egamdmsmnZ4arwYcuAQ+m6Z1dOvP5R9Faw2jyZwhwVwuizLx5oEQC6VpIoU0jzY2i/AydDjOWEK8iwoRM3+rMyK16R3OQOfpz8EHdiuMAtouxzfm/X2r4CP76gsnjrRWX4Obi7fmvCgs3ePe1+50QPAH09chMQO8SE6RyxRLc42Bj8DktpgGXN6VDRjIXfqjLiH/pEd3P/ICERkaJYVTWFlCwyfYG3o9E5Iq9D9LFVwBbpVrmrOa5tDJf1LaWa/9xUlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j1aV5XZIsetXMs+sMI7LV3EIQnLaqm8ztF8l48uRrU=;
 b=Z/y+L4gmzRZC9RVpboSBq86ldhhN+n5JcBcaGfHgCEZQxTrsg9UyIKNimUK0L/16J4PSOg19Dp5nO6ZSA6vxPxAJDiDZJvHUGXY3KozxqZ9pflb+0IQcjD/PhqEbFHfYs3rgmNiXcriYVJ97RNytnrDROqRAtnL+BqmppRAuOP4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 17 Jun
 2020 07:57:46 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 07:57:46 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, "arnd@arndb.de" <arnd@arndb.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx-scu: Support module build
Thread-Topic: [PATCH] soc: imx-scu: Support module build
Thread-Index: AQHWRGTWXA/Y7jtl6U620nWhqctCc6jccHNQ
Date:   Wed, 17 Jun 2020 07:57:46 +0000
Message-ID: <AM6PR04MB49667E1B41DC2A77B3E2FEBF809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1592369623-10723-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a02c2915-f4cf-448c-6945-08d812941f78
x-ms-traffictypediagnostic: AM6PR04MB6503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6503DF3E0328A731F60E02B2809A0@AM6PR04MB6503.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4PBnVuIUPtORZ2VWaSGNyrb3yswDFN5MhjveLccw0tbO+wGt1U1J4VLNgmTCbZDhTMgtR/u9hGk7sLMvQ1OnQs7+PIqDdZu82TDLxudWxav0LLMJsZE61GLT09QOx4z9+ZNYFQ6RJjFeRXRu3uCuQLuMU5zElKj0wrtMEZ43igJjXWntMAfwCVaRmvcE73vJQABtaUu4545b6Su9xkMSiFFrvqEXQbzUBtgpjfyfW9tjs4nqIfQZJUSXjo9waEnz6efNeCJvMw0tg0+rcs58A+PpQ97ZWAHVC8OafqpVc4jwDHS6n645vMNqVLOVKu7Q7vAoXqsut5+Qo414TC7Saj8UQfdMXx7sXeOu5iC6Fp/2WOAWpkJnikLMuLRO4fL4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(8676002)(83380400001)(5660300002)(478600001)(110136005)(52536014)(8936002)(71200400001)(4326008)(66556008)(6506007)(2906002)(316002)(66446008)(64756008)(76116006)(26005)(66946007)(66476007)(186003)(33656002)(86362001)(44832011)(55016002)(7696005)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: r9/S/GsmY/Tf8HR0F7lObIiWm5Q7wAKuttKfgeF2h1J/hNXkUVRS5AA9ad1+NZ79F8FfyxJhQmDEP6j6E5CzXd49QulMTLSvNG3g7daq+aSN/Z8TC0deJj4Qz5McL/tuV7L0Re/m9zEgo1lSSTGKU1Yfcx/Hy3ammo4kBvdPxCYcGCn+sfQ9XSCu7Pxn9T9Z3oXYptKWEpz1kDxlsc0sYC1F3n74FmkxVvFs1LZ5QMIeK2V9y2ILyC7s28xiXCL/oJQAFmQxk75taJKv82XoXszt5kUgClVqz5XFrJr0SdNqd4pMUT15zKbQ9eO9esoI/QZNqJ3mxbaa9cg83AiChGwQ0zFEWSPkcX6PAkHPQw3wW5OKzQf01xpF9//OFbOioazA/QpFFqRYl/RAT2YIKKKiko09rK9BcXLB+nZ7wB4R/meUkwbhWy3fFCLeTDsKrGUWeqRVrlBc6fP8GNSWklw2zR6OC23YODqWo5AWiT3t23+QHF+tUVh8fn9RT5Xe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02c2915-f4cf-448c-6945-08d812941f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 07:57:46.4370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4yCcoBEVR4OqUHMzYlCuyXw0klz8XaJdVeTeXVqHOZu5+s9LpzLHnP0n9x5rf2boB/9pog6cpSB5ULHGYbgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDE3LCAyMDIwIDEyOjU0IFBNDQo+IA0KPiBDaGFuZ2UgdGhlIGNvbmZpZ3VyYXRp
b24gdHlwZSB0byB0cmlzdGF0ZSwgYWRkIG1vZHVsZSBkZXNjcmlwdGlvbiwgYXV0aG9yIGFuZA0K
PiBsaWNlbnNlIHRvIHN1cHBvcnQgbW9kdWxlIGJ1aWxkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2Mv
aW14L0tjb25maWcgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3Uu
YyB8IDUgKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L0tjb25maWcgYi9kcml2
ZXJzL3NvYy9pbXgvS2NvbmZpZyBpbmRleA0KPiBkNTE1ZDJjLi5jMjU1YWNiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvS2Nv
bmZpZw0KPiBAQCAtOSw3ICs5LDcgQEAgY29uZmlnIElNWF9HUENWMl9QTV9ET01BSU5TDQo+ICAJ
ZGVmYXVsdCB5IGlmIFNPQ19JTVg3RA0KPiANCj4gIGNvbmZpZyBJTVhfU0NVX1NPQw0KPiAtCWJv
b2wgImkuTVggU3lzdGVtIENvbnRyb2xsZXIgVW5pdCBTb0MgaW5mbyBzdXBwb3J0Ig0KPiArCXRy
aXN0YXRlICJpLk1YIFN5c3RlbSBDb250cm9sbGVyIFVuaXQgU29DIGluZm8gc3VwcG9ydCINCj4g
IAlkZXBlbmRzIG9uIElNWF9TQ1UNCj4gIAlzZWxlY3QgU09DX0JVUw0KPiAgCWhlbHANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jIGIvZHJpdmVycy9zb2MvaW14
L3NvYy1pbXgtc2N1LmMgaW5kZXgNCj4gMjBkMzdlYS4uYmRkNDNlZCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gKysrIGIvZHJpdmVycy9zb2MvaW14L3Nv
Yy1pbXgtc2N1LmMNCj4gQEAgLTUsNiArNSw3IEBADQo+IA0KPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2Zpcm13YXJlL2lteC9yc3JjLmg+ICAjaW5jbHVkZQ0KPiA8bGludXgvZmlybXdhcmUvaW14
L3NjaS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zeXNfc29jLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+IEBAIC0xODUsMyArMTg2LDcgQEAgc3RhdGljIGludCBf
X2luaXQgaW14X3NjdV9zb2NfaW5pdCh2b2lkKQ0KPiAgCXJldHVybiBQVFJfRVJSX09SX1pFUk8o
cGRldik7DQo+ICB9DQo+ICBkZXZpY2VfaW5pdGNhbGwoaW14X3NjdV9zb2NfaW5pdCk7DQo+ICsN
Cj4gK01PRFVMRV9BVVRIT1IoIkFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPiIpOw0K
PiArTU9EVUxFX0RFU0NSSVBUSU9OKCJOWFAgaS5NWCBTQ1UgU29DIGRyaXZlciIpOyBNT0RVTEVf
TElDRU5TRSgiR1BMDQo+ICt2MiIpOw0KDQpJJ20gb2sgd2l0aCB0aGUgY2hhbmdlLiBCdXQgSSdt
IGN1cmlvdXMgaG93IGNhbiB0aGlzIG1vZHVsZSBiZSBhdXRvbG9hZGVkDQp3aXRob3V0IE1PRFVM
RV9ERVZJQ0VfVEFCTEUuDQpIYXZlIHlvdSB0ZXN0ZWQgaWYgaXQgY2FuIHdvcms/DQoNClJlZ2Fy
ZHMNCkFpc2hlbmcNCg0KPiAtLQ0KPiAyLjcuNA0KDQo=

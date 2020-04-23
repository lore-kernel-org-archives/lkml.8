Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A4C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2432076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITMDRs6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgDWKdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:33:17 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:3350
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbgDWKdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:33:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWsOpDYUuSQ0T/nTaIbj16F+qPdYPv2xwTwsy4UrXC3rClxUaghv8ROqD1TXT0YlhWtV+fCBhlvBUW+YZ9Ez5n+jOayEALRgjTKQIQU1yD90HEXcEbJkofUBwuQK+FXRc/QsivqjLOwIUKigJjGkvlddsiKfU6FeHqwHjjI1h06fPMPZltANK4xPig4frDri5El8bDyQ2dDwGNjDfM+ptrTvlx6YhZXtZVJMdHMc2QtaZG9BPIDSLF9Ouf0TgCeZzBVl0V0H0oJ1mUwzgFPg0GOOcVyQNHsQ4wDz/nHG6ocN2ddp2jsSsmyG7qG5lJud85uwjTc3ZEXDadQC9d8E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GH7jddGNw8L76ZIqCAgKhlt5Iin9pNRtgPLrCuVM44=;
 b=XDARzUEdoLaawxyeeUt5SwlCrU7mfrxlFo7HWX+cNvdxNC4HnP2ygaCJB1gUc4LI7NR0a5Jw0rnjSitB6c76NYA07Q0F3WZqR2rZhB8as9u8AUeiB+9/rUdGyZLl/t7x0Qpwrdct/fUSos1RyMLNiiqS0/Jluo9a176Vvh68pNbcl4mCThFIwSXxf9Rx+ldVJGOqbDv+5ZONV4KYWMnjO0DiIqwNz0rEyQupFiluWLqsCe1DO27HNYnGaG8sF7B1gwFT9v7NH5nziuGF+oar+wuKK42XfbVjPAbk+HX90CLUlZF7C87jvQEIHSqiqrZhY0sjhjgEcrYvTnAX6pOfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GH7jddGNw8L76ZIqCAgKhlt5Iin9pNRtgPLrCuVM44=;
 b=ITMDRs6SJGW6QWSOJbPiZNfHzGzotHw5P4BbmJBWoHRGuJfkbvR7YIaLRebBift6fTYlRNaY9Gi4x7sOwR6D9h1V37X3dEdXWW95nFUWPI1eiCm7ZOZvSi+bZZ5FUNndXBvcEle7BLLf7ZkCY3WE385fMXmesG7KJWqrIzblDr0=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4886.eurprd04.prod.outlook.com (2603:10a6:20b:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 10:33:10 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 10:33:10 +0000
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
Subject: RE: [PATCH 4/4] firmware: imx: scu-pd: add more cm4 resources
Thread-Topic: [PATCH 4/4] firmware: imx: scu-pd: add more cm4 resources
Thread-Index: AQHWGT4B5RWzQBophkGzJ+N5J4+FiqiGgKjA
Date:   Thu, 23 Apr 2020 10:33:10 +0000
Message-ID: <AM6PR04MB4966A8D160E0F1970A24E9F280D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587625174-32668-1-git-send-email-peng.fan@nxp.com>
 <1587625174-32668-5-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1587625174-32668-5-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcf53d01-6b2f-4011-01b9-08d7e771b83c
x-ms-traffictypediagnostic: AM6PR04MB4886:|AM6PR04MB4886:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4886DFE9B26A9A97350E903E80D30@AM6PR04MB4886.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:262;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(52536014)(110136005)(2906002)(54906003)(6506007)(4326008)(186003)(316002)(55016002)(7696005)(26005)(33656002)(5660300002)(9686003)(86362001)(478600001)(71200400001)(66446008)(81156014)(66946007)(66476007)(64756008)(76116006)(44832011)(8936002)(8676002)(66556008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kh17lqJJTlJSvx7Y0+BOcHVGTteBdSm+EzXXz7woNm09+fvkIBeLbrszuPatNKtXG/GCdteSSF3t0fS+vZNtYtvXag+BF0fp/4bpNdzJKiBmNqW/OUQNiAGJVJ5oDqijoBwIPto7EaH6oj12PMAH9O4M584X6O+x4WtWgJRZISakixxQDX6tZ2hfpPZ4mN5L53rW4Wj0ijC/qeZRUhxOgYhJW6dKEiFRJ+nqAh1S30wo2ukRsUvnr3oxxe6tL5fPe0/OrDddCxWlDVLA4O65/4yl+OkTD51BF2T3sMT2yVFDfhwvftEai8PYuU14cJ7k2xj/bgq6n3xYHucoZd6tUcSIJ1x2vBCo1Q+7RaBzvmS9X7zfhpO54OQVPGq7IsXE3G2CcT9FYJmRCTjllIVzvC6Da0JsXzmXHvZAdMJjfsL4WxcKdDM16jvSx9UcyQD
x-ms-exchange-antispam-messagedata: 71oE0Fs5WckwVfNMLzOltOp/8GNu+CNq3T1+z/kXHS/czMifKXca/YJe2O5rtuMLY/XhvVvUhdHWrNDBKZ8v2AsEuNaNjE5NFwTt1yvxrP1gout/OaN1wPHnxugokplb8Ex/560UyZSFftOmu927yA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf53d01-6b2f-4011-01b9-08d7e771b83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 10:33:10.3592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /j/61+4RgBfPMu6gvfA8PYuc/pwZUmOEYXCai9puwj830LGhVVsgrk/X5Rni2LaCr+XF1MigflYTQYhIe8hjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFw
cmlsIDIzLCAyMDIwIDM6MDAgUE0NCj4gDQo+IEFkZCBtb3JlIGNtNCByZXNvdXJjZXMsIHRoZW4g
bGludXggY291bGQgdXNlIGNtNCdzIGkyYy9scHVhcnQgYW5kIGNvdWxkIGtpY2sNCj4gY200IGNv
cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQuYyB8IDEwICsrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9zY3UtcGQu
Yw0KPiBpbmRleCA3YjQzYmQ2M2NjMWUuLjJmYTg2YmUyMDI3YSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9maXJtd2FyZS9pbXgvc2N1LXBkLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgv
c2N1LXBkLmMNCj4gQEAgLTE3MCw2ICsxNzAsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhf
c2NfcGRfcmFuZ2UNCj4gaW14OHF4cF9zY3VfcGRfcmFuZ2VzW10gPSB7DQo+ICAJLyogQ000MCBT
UyAqLw0KPiAgCXsgImNtNDBfaTJjIiwgSU1YX1NDX1JfTTRfMF9JMkMsIDEsIGZhbHNlLCAwIH0s
DQo+ICAJeyAiY200MF9pbnRtdXgiLCBJTVhfU0NfUl9NNF8wX0lOVE1VWCwgMSwgZmFsc2UsIDAg
fSwNCj4gKwl7ICJjbTQwX3BpZCIsIElNWF9TQ19SX000XzBfUElEMCwgNSwgdHJ1ZSwgMH0sDQo+
ICsJeyAiY200MF9tdTFhIiwgSU1YX1NDX1JfTTRfMF9NVV8xQSwgMSwgZmFsc2UsIDB9LA0KPiAr
CXsgImNtNDBfbHB1YXJ0IiwgSU1YX1NDX1JfTTRfMF9VQVJULCAxLCBmYWxzZSwgMH0sDQoNCkZv
ciBjb25zaXN0ZW5jeSwNCnMvY200MF9waWQvY200MC1waWQNCnMvY200MF9tdTFhL2NtNDAtbXUt
YTENCnMvY200MF9scHVhcnQvY200MC1scHVhcnQNCg0KVGhpcyBhbHNvIGFwcGxpZXMgZm9yIHRo
ZSBmb2xsb3dpbmcgcGFydC4NCg0KYmVzaWRlcyB0aGF0LCB5b3UgY2FuIGFkZCBteSB0YWc6DQpS
ZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJk
cw0KQWlzaGVuZw0KCUENCj4gKw0KPiArCS8qIENNNDEgU1MgKi8NCj4gKwl7ICJjbTQxX2kyYyIs
IElNWF9TQ19SX000XzFfSTJDLCAxLCBmYWxzZSwgMCB9LA0KPiArCXsgImNtNDFfaW50bXV4Iiwg
SU1YX1NDX1JfTTRfMV9JTlRNVVgsIDEsIGZhbHNlLCAwIH0sDQo+ICsJeyAiY200MV9waWQiLCBJ
TVhfU0NfUl9NNF8xX1BJRDAsIDUsIHRydWUsIDB9LA0KPiArCXsgImNtNDFfbXUxYSIsIElNWF9T
Q19SX000XzFfTVVfMUEsIDEsIGZhbHNlLCAwfSwNCj4gKwl7ICJjbTQxX2xwdWFydCIsIElNWF9T
Q19SX000XzFfVUFSVCwgMSwgZmFsc2UsIDB9LA0KPiAgfTsNCg0KDQo+IA0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpbXhfc2NfcGRfc29jIGlteDhxeHBfc2N1X3BkID0gew0KPiAtLQ0KPiAyLjE2
LjQNCg0K

Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDABC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E82B2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QvF2URTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDXCcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:32:36 -0400
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:52235
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDXCcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/cuqrpTBxz6VafFJ/7ZV1f9OQyZx2KAeicuVxMNRK56pl+V1ZpBDfrDriqGiACjmNaawJbJOYd9n39dRJzquRe3bcs4h4EXQMbhXDEyCeYccR4rdwRzo72VoaVbyU5ET+HwNLpoSLBQdV/qHp3eYER2Q95Vnhl5lNHo92hnHNEKm97MHN933fkJWN5VCYiddBA7qQZEeXp1HTAgvzzqx9cZigH3m77i1LGgDpdtLMwRpiNtyV/49MDtD2Z+VlqMOv5sbAR6NBLoX7QGSLLg01H1fldrhJhE7LDYi8YT7A262y3O41xvljClt3yW8ulCT1quMDTDeiU1YbfCxrRnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvNJZRn3xpk+by/M0EwVen0PJlDAdCr91TR+NRnf+HI=;
 b=Q78aLblmgeZMEDwNUwKum43tG9OCyskpA4u+PcHQRx7n3P2R26nTIYoYLzKcHiDX6EScPojQU8BEQR2rDJmq7KzH1CFVEG9ZKocTWB55HzdDf2lB5rXkEq8IACrKme/AOysTe5zvSYTHmRk7AECYwiKOFEvEaE5TOCENY7l4gvYanFKYqI6472+COPQDbnFJXFSw6lFOPsM5SIseTLt2XheC7ZWlAr2LlWBVJk4ksv4Tae8GnLC1K2dujX2VEhTtTUS1kzLX6Qd/kOl3w9ZeJofTKm1OORigfUnXNXZXNbUAnZf5AvAQw2oBugdFMrSf0F4mvx2NkhJg2ldRbcn8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvNJZRn3xpk+by/M0EwVen0PJlDAdCr91TR+NRnf+HI=;
 b=QvF2URTbZnEvLuOc5kYCsj1tsnfpq1wgxzAd1SPZxui5jktFoPOVChG7Pcc4R6ixJ6imeDHvqo4C0JeXTuC5DMwRyXxyGOAAZ5TcT56wFIv/mvove9k2l/d9wur9ALO+CmIHeJklhLKKgTYhtOvw9mt/Cj+8/pb42MBfuDDZLJc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4598.eurprd04.prod.outlook.com (2603:10a6:20b:26::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 02:32:32 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Fri, 24 Apr 2020
 02:32:32 +0000
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
Subject: RE: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Thread-Topic: [PATCH 2/2] firmware: imx: MU IRQ group number should be 7
Thread-Index: AQHWGcUy/MHx513YSkqpWUZybaROrqiHjXLg
Date:   Fri, 24 Apr 2020 02:32:32 +0000
Message-ID: <AM6PR04MB496669637FE86E928B9E0EBE80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587683231-18468-1-git-send-email-Anson.Huang@nxp.com>
 <1587683231-18468-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587683231-18468-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf7000ef-c6a6-4a57-02e7-08d7e7f7be1b
x-ms-traffictypediagnostic: AM6PR04MB4598:|AM6PR04MB4598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB45985F253267DB91F644516480D00@AM6PR04MB4598.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:421;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(2906002)(71200400001)(4326008)(478600001)(7696005)(5660300002)(6506007)(66446008)(76116006)(66476007)(66556008)(66946007)(4744005)(64756008)(8676002)(52536014)(110136005)(33656002)(44832011)(55016002)(86362001)(26005)(81156014)(9686003)(316002)(186003)(8936002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGGB6dQi5nPTsuV5gSYbm1N/vnixrdRxpCVeM2qJU8jw7v/JITnFV5IvePoU2Nk1Z0eGAQpzUOo7xOzpPww5q2m4wFc9RKUkf0DuEVanHd/+rlFGzRMxoirDRCumo9vwNme5ayfb/hyQQ053QYDCekkdxbaTUHLSxcCA04djsiLuZX/gjY2HHZVpwOR7/LoR/B2VYO067vKUUMWbesIw7CurMTDUooXowq6kK8dGl5AHv+PppAEzhDS73sVcKJEVwLAG4QLR6fNEneLvATgarcqyxUZXO/icclgjR1uqXvaZYvSuu5+9Jn74+7PrLCa6xkzqpS0rxKgrT8sisLPKmAEjaCtSKqieoH0fxHpw+7KoNrgLLZWTYnLv4HqoWD3koD9oS9u64vXZxaTMr5CnGqA/7db5RazTKC1t1sjCNKQEaz7iih/AVbfJG/pmTz0h
x-ms-exchange-antispam-messagedata: lDB6FBqD2p0cJo4dMhVve0rAnBzgWLGAlYEBc8N7SC4gi6KgCO6hTy12HTBaMOUmo0rNO08LxXKvrxFiqzC2SQqn+iRHpMS++XKK5uAU6EwFVLtMftry0A6TWIVaDmrh6hRoekyrxPNKykpF4Ab8Qg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7000ef-c6a6-4a57-02e7-08d7e7f7be1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:32:32.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWHw1UhPmlM05UVc2PYqx8YGuFO4ihfLSgt2wnjtIzYD4OIZm7APXSS7XUQ7K9yKzJsO66B/xi4qSRnkYnW72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAyNCwgMjAyMCA3OjA3IEFNDQo+IA0KPiBUaGUgTVUgSVJRIGdyb3VwIG51bWJlciBz
aG91bGQgYmUgNyBpbnN0ZWFkIG9mIDQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KQXJlIHdlIHVzaW5nIG90aGVycyBJUlEgZ3JvdXA/
DQpJZiBub3QsIHRoaXMgY2hhbmdlIG1heSBzbG93IGRvd24gdGhlIGlycSBoYW5kbGluZyBzcGVl
ZC4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9maXJtd2FyZS9pbXgv
aW14LXNjdS1pcnEuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lt
eC1zY3UtaXJxLmMNCj4gYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQo+IGlu
ZGV4IGQ5ZGNjMjAuLjY2ZmVmODggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14
L2lteC1zY3UtaXJxLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEu
Yw0KPiBAQCAtMTQsNyArMTQsNyBAQA0KPiANCj4gICNkZWZpbmUgSU1YX1NDX0lSUV9GVU5DX0VO
QUJMRQkxDQo+ICAjZGVmaW5lIElNWF9TQ19JUlFfRlVOQ19TVEFUVVMJMg0KPiAtI2RlZmluZSBJ
TVhfU0NfSVJRX05VTV9HUk9VUAk0DQo+ICsjZGVmaW5lIElNWF9TQ19JUlFfTlVNX0dST1VQCTcN
Cj4gDQo+ICBzdGF0aWMgdTMyIG11X3Jlc291cmNlX2lkOw0KPiANCj4gLS0NCj4gMi43LjQNCg0K

Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9002076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mKShn9JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgFIWtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:49:08 -0400
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:53163
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbgFIWtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOWMrd8Z2S/9k7NncZUh3LjgvhnfJUHRLzpRyOsakMaTouzudBuZ+ZDrcrEYaHCHXRCEyA/vHMYRRp5PBBZbEE/2ZZ5Xp2vSehRNBz2tyUIAaQwXbp/lpdgukgrZ4+HxOXCEMYv8KIgrtzd2WCMyBihMp6o0Lj0Iyg+L2lnQ/rJqvkb8oIq34g0ET6CWye1niaAxyIhhTStGSsOBZCF7whQIxz3SEItmhsP6/yUsW9uOj0G7vOShOk2wDnj2w7h+TipACPvJ4tH+wZYJjuN8kkBgnLlxUyFjEWKyzkF3xqGq5iVL3el0VDNY6whMvE1tikV0BOgjpDv1X4zqzv5U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgZM0LGLKYuobA3Xixb2KGGVCp/2govML2blk93+E18=;
 b=DXB66+y4oUjxjAJm2b+A8rv7qO8UgxaM335oP0CqVUyu0aSpYCYhja2vSurkwRfc8u57t1B1R5M9dRFKkuUbpMVwv/UrXuoGty/H7ibC6TgsOOGK/phMz7y/gx5CBj2P8oo7NGqUNwwwKxctDVXfMBzmLN3SQyHDr0cy9ngvIfcamt7+4xYEOl/IqIkqviqmS3tBrMThby91mT5n3LeYCXN/9yS3LJ7io2kpijAaSktQK6LfFD34JeUuqp18o13rLWuzXvYSspRt4OVk6vGJwTmN5iSGsnO8k1qRBdxK73ZVLrae0AMiYl6VOSQHCw7hwpn5UnT8qPphdWAh6TfKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgZM0LGLKYuobA3Xixb2KGGVCp/2govML2blk93+E18=;
 b=mKShn9JQN7HrS+M/PVpvw6iTVlDjVTU6kDKmPhkbBGfGc+E9j5i1+GbfCGok16Qog/YWaYT+hCbbt3bk6xVgiM7VaXR3G/T2zR9lwdsJuIePo4iau0xij03Hov+ZeY4N0u2vZnLHkWBcpFACDd9I9WC+vBk3wj9nDcPu3YOJIVw=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by AM0PR0402MB3393.eurprd04.prod.outlook.com (2603:10a6:208:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 22:49:01 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::bde6:6e57:8c23:79ae]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::bde6:6e57:8c23:79ae%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 22:49:01 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
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
Subject: RE: [PATCH] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Topic: [PATCH] soc: imx8m: Correct i.MX8MP UID fuse offset
Thread-Index: AQHWPmGaLCVYIW/uG0iQCSK/g/UPiajQZy+AgAB5hxCAAAKcIA==
Date:   Tue, 9 Jun 2020 22:49:01 +0000
Message-ID: <AM0PR0402MB3905BE3E0047941D5880ABA6F5820@AM0PR0402MB3905.eurprd04.prod.outlook.com>
References: <1591708550-14058-1-git-send-email-Anson.Huang@nxp.com>
 <7a4091c5-dc57-31c3-3445-c6b16a565928@nxp.com>
 <AM0PR0402MB3905F42A025BF12B1D6B26A0F5820@AM0PR0402MB3905.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3905F42A025BF12B1D6B26A0F5820@AM0PR0402MB3905.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f9c01b5-7d70-4c71-8850-08d80cc74ddc
x-ms-traffictypediagnostic: AM0PR0402MB3393:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB3393D2C82068A78B012A08EFF5820@AM0PR0402MB3393.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3NvqPZmj7KOQOYM7DRzT+mAdbjKx2zfjJ8vkisqqlTp01cdqAk5hnFZoBpFamOHfznIYsVorKHVoRMlsGwCoeLF3i4e9Ol7PG7oU0saPolZy3Ed2hJIXdkjHAQ1b1SBjsnn8vvJDWCVkk7PDozUeECOAcj5vd1X9pTs+qO9MdXmxQ2Z0tmFYiY/IcxwFfiwUKPEydYGa015DGwfYZvJ9kIuWRPePUhQJOXy/6Q7QflHnrVPoUynoXtBiStNTbgXQHSn4xGXtlt7RuO5fEofdxP50GeakaE5i38WvADpRyLTIpLGQjJZm2sAyah8Sn99fab8KJIxNi7x5bA6wCRNBBIY4hyPbjoAJv9UHxqtuL1n/ybqYkq/po3P6csZ9e5I2Vl5s7hXenh75K35QQILnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(2940100002)(26005)(44832011)(71200400001)(8936002)(7696005)(4326008)(53546011)(8676002)(2906002)(6506007)(86362001)(4744005)(316002)(66946007)(66476007)(66556008)(110136005)(5660300002)(76116006)(478600001)(52536014)(55016002)(186003)(64756008)(66446008)(33656002)(9686003)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IgqWo23sJo9evQfb+vttTE8Va3TpdkfYuqo3Fs5tEGvw50NX1DWzkDwbd/eFBk1M3kMmARw2MOnP5CiJXf6NtnySS7Dg/FDnlio6i2arbCd86H14ZxNSD+ejJw1aJSKMRJAhQQHr0CchJsrNJLd2UE3epkzyzIDIOT4CFHmj3rZGqUdDm1F1wO+33/smcWVB0i7nf4KxCDoLh6K/19ovEZkNx8DUUAO2RjLvEyZS/NzC36IBVtU4CvFYjTnLlftxnMgVbREDnlYq51TyrlWvzaRkJvE2A801YOUgJWNEdVbYJw6IoPU154vTeS8YrAQtCaJJwG3WQ3usRc85w1JlyBlD+Yg82d+VGKg7DVBjHR/0AaizxCTcntdUfP7j8ceQJhaGXDXXoi4/rkORQgsVl4FN/1nvvZY1kkx1/MZDSXrKU46p1q+3Nq/L2VZi5fBfBQEGZif9HA1xHZcaJTXxfnrwH8O2UNajmY4iqaMdDIokrZ6hFbwe1aszWABulXyJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9c01b5-7d70-4c71-8850-08d80cc74ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 22:49:01.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+p0pO7QbI8n6TxI0CIww33IInWeOS9DRlMICPW+nw8FCEXZw6JEhl++Tv31isZRlr6jY4M/aH8SObajYDtzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3393
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1bGlhbmENCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBzb2M6IGlteDhtOiBDb3JyZWN0
IGkuTVg4TVAgVUlEIGZ1c2Ugb2Zmc2V0DQo+IA0KPiBIaSwgTHVsaWFuYQ0KPiANCj4gDQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSF0gc29jOiBpbXg4bTogQ29ycmVjdCBpLk1YOE1QIFVJRCBmdXNl
IG9mZnNldA0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDYvOS8yMDIwIDQ6MTUgUE0sIEFuc29uIEh1
YW5nIHdyb3RlOg0KPiA+ID4gQ29ycmVjdCBpLk1YOE1QIFVJRCBmdXNlIG9mZnNldCBhY2NvcmRp
bmcgdG8gZnVzZSBtYXA6DQo+ID4gPg0KPiA+ID4gVUlEX0xPVzogMHg0MjANCj4gPiA+IFVJRF9I
SUdIOiAweDQzMA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiA+DQo+ID4gSWYgdGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgaW14
OG1wIFVJRCBzaG91bGRuJ3QgaGF2ZSBhIEZpeGVzIHRhZz8NCj4gDQo+IEkgdGhvdWdodCBhYm91
dCB0aGlzLCBidXQgSSB3YXMgY29uZnVzZWQgdGhhdCB0aGlzIGZpbGUgbmFtZSBpcyBjaGFuZ2Vk
IGJ5DQo+IGNvbW1pdCBmYzQwMjAwZWJmODIgKCJzb2M6IGlteDogaW5jcmVhc2UgYnVpbGQgY292
ZXJhZ2UgZm9yIGlteDhtIHNvYw0KPiBkcml2ZXIiKSwgc28gaWYgdG8gYWRkIGZpeCB0YWcsIHNo
b3VsZCBJIGFkZCB0aGUgdGFnIHRvIHBvaW50IHRvIGZpcnN0IHBhdGNoIG9mDQo+IGRyaXZlcnMv
c29jL2lteC9zb2MtaW14OG0uYywgb3IgdGhlIG9yaWdpbmFsIGNvbW1pdCBvZiBzdXBwb3J0aW5n
IDhNUCBVSUQgaW4NCj4gZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4LmMgd2hpY2ggaXMgbm8gbG9u
ZyB0aGVyZS4NCg0KSSB0aGluayBpdCBzaG91bGQgYmUgY29tbWl0IGZjNDAyMDBlYmY4MiAoInNv
YzogaW14OiBpbmNyZWFzZSBidWlsZCBjb3ZlcmFnZSBmb3IgaW14OG0gc29jDQpkcml2ZXIiKSwg
d2lsbCBzZW5kIGEgVjIgcGF0Y2guDQoNClRoYW5rcywNCkFuc29uDQo=

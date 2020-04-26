Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2543EC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 04:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062B62071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 04:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I3StkV4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZEXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 00:23:18 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:5856
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgDZEXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 00:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6TVJ9nRteGO/ELx9a9Fr2KlMsmiUltun/I1h6v+kCiskCzDjY2vzCAJ9DjyJSXipQE2Xl5QUkGWEFqscW625vrp2CIG20oI5rFSav7E+2LGV2CFvlUEP/ytiPQVx+Q436XN53nG4dnC4LqflauNUAFOOZneO8WdOPaHOe4HKxAAWtSsEcJA95Gt2eqtl76/gCGy9PDlDXH7xa7WT0KRBnFVReJ4YeJo9qinaTfS5TkfJsuJkvGP3W2Qv7raox6BxFDD/cRitKER1fE6eR9kh1e6pr4wMFDDsdD8PhZ73hxq8GglPPi3pvhvdZfQpJRrv8iIVlQSXkNSSZ3JI4RnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF9FH9cI7MO9qemuql9OyFGpA9dZ7tWo1gU+2pSFFN0=;
 b=IwfJ3GY3A0/0OGNxhU02aLEpoBvHoXjd4zR7e3THype5RiptLMIxwXFT3B+C8wVV0MRpqy6mi+D2mnxlAJJyBAVxicw1ftKAXf2xrK5EvSqZmj5g3gst35UwEcCz1JbNdFepNhbmOmqALI8cF5kjJbW79Os7Js6cpNq1HfjFB2e97baBSw5u2g1KL8SDYLPB+VCPpnpaPs9Rrb2NvRxx7iWnZhzHYgJNYTD64RAcIwUac+JflTSDJd1CPeejfldA4BJIgrVEH3ZVd3S21cLnuk7A3XAyuG8ZaoTXgoJ/6Bis+uYEAt7W8CmBmm61AgFw5TRt9fIYR2Uh+G7DVIcL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF9FH9cI7MO9qemuql9OyFGpA9dZ7tWo1gU+2pSFFN0=;
 b=I3StkV4HhXwLP++UNISPDkmGFzlVHoeWYziZA8vjlMw4OUffG6n5Zhhm2gYyaDn7I688s4tYcGpHfY4sW7s2nhUEUGWx1YWUKFtrMvGCly5E/dwFJm6BSUVk1gCzLOOWbj4kipF6N947rs/Md/THT27HMILiCZi9HnLzr4+j74M=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4072.eurprd04.prod.outlook.com (2603:10a6:209:4d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 04:23:13 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 04:23:13 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 03/10] clk: imx: imx8mp: fix pll mux bit
Thread-Topic: [PATCH V2 03/10] clk: imx: imx8mp: fix pll mux bit
Thread-Index: AQHV+FjAxHm8d1Y7QkOteofuF3bevqiLE+iw
Date:   Sun, 26 Apr 2020 04:23:13 +0000
Message-ID: <AM6PR04MB496606675B8D3D5C8CE8995780AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-4-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1584008384-11578-4-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [218.82.155.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 751d76cd-3a03-488b-7a35-08d7e999893d
x-ms-traffictypediagnostic: AM6PR04MB4072:|AM6PR04MB4072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB407252DC132917C507A23EA580AE0@AM6PR04MB4072.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(64756008)(8676002)(8936002)(44832011)(86362001)(81156014)(66476007)(54906003)(52536014)(66446008)(66556008)(2906002)(71200400001)(76116006)(66946007)(4744005)(6506007)(55016002)(6636002)(110136005)(186003)(478600001)(7416002)(9686003)(33656002)(5660300002)(316002)(4326008)(7696005)(26005)(32563001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFkIq7mxxPPDBR6skSL0LPfAGztJ4y7bp6lAaSAaOqOD/BaCiKfGEqINX/H2KduuK5SARGH3y4oR6pp/bJPTCCxYywurW3mqZY+0fO/3S6B9cQBPR0JTdbYDzkEF4RZWSB7vZaZEZFvc+qjftiDi5ZGUDzRwHejXtE3oktmBZTO+TkTVyLD448VhvF/xr97kSZV73TIz/vZNQboaSIDehyUIlLbNuZ/76k3uNBrYOlbKFmOcgMUFIenMuQacSGhoB/g+9irbIOwcjkC/bPVfIVN+iiOD3Y94qMK4dYjFWm4tSJEokPIOLgpnEOABjfL3HUleEOvJQWXnOiw9dpdqAcQ23BMudo0jp56r9le+s0dS+Ni6on3iq9lVYf/mhVKzG9qIlG6FWt755h8pzfZCs4eZSg28IBgj+agb8mPx0T0VsEn5ZDUBobvx0NPNvVL960M0Lp9IHFSk0LWyA8GB5HXGuzqjvRmlN2tyOv7c5t4LdAOI6jZtlcC9CK2ApTxo
x-ms-exchange-antispam-messagedata: k9SWIWReqDqtLV5fCJidc23mQzL73BSGR3WqWqohRFoshZQe8vTVM0yQk7i0SNE2Un9Ca9pB5Qx+4UjJMzqiAcRWkto9X3int8JhI7aZxsQZ3eiHZXHToxk4YkaWFPJiONG0uU2alCJdLM4VkF6quBoWzqijSiwZxXktpxHHB9MZY87nr7zTifUYzOhxBykjWe8rbavXydzPZGMESCBnXb2ygrWEm8IsjfqKeO45GHZeBbBj3+zXg7ELLh9hi9mcJMizAdQY8uro4kT6CfUJR8AHZYXB9zPtujrI6vHzt6+2ta8FNzK4ZScs4bcopgN1Fgjada25rxFiJn7X/TBvM1DPTOxsHW6VkBu9KX6Wt+jRCUYknPkHNpteuKW0s3uDJAfoMPMlNWqqhmiT07GIf3ex5CQGdl+p7vok6Rk7mIWjWklluvW5tc9qGEv6tUpfkd4toyZ806qMoCCsqS2XS5sluFRN6do2NQ4IDikFkuuW1yK+xbKrXfb+87894JAVTP9Wr71niImBn7mnb76vi/19s8/o5KbfcTjZVz/hn3N8nlhq79HmU8EEv8TJBnYQ/yEw5k5xUVGn4fWf5tpJbJoHO9gaRQPYEO4TL85eunOYBfnVTv3ml5n5+51J9tKZAvFOKTu/LFlyEZb9/3NUUzCpA5cnEZ8sggeI+xUMg/aXFVxTybooUJU4UHUmeTHFrwqFMo0/iY6OeqNogfIlStHScXe9PHYMTwN0vELlz2c4Ny04NQaX+656geNdvDX+NRJSHPKhv8njdppGOz5IB+5ZIOdnXFqX7lHM5Io8HDI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751d76cd-3a03-488b-7a35-08d7e999893d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 04:23:13.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TrqpF6H6H7uXfpLrETyLRgiHYMIfmHgePZ3V1X5plbEmvCRJwfBGA3tNEF8qhTJWSGjKrca4RaiAkGyNuBPCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1h
cmNoIDEyLCAyMDIwIDY6MjAgUE0NCj4gDQo+IFNhbWUgdG8gaS5NWDhNTi9pLk1YOE1NLCBwbGwg
QllQQVNTIGJpdCBzaG91bGQgYmUga2VwdCBpbnNpZGUgcGxsIGRyaXZlciBmb3INCj4gZ2xpdGNo
bGVzcyBmcmVxIHNldHRpbmcgZm9sbG93aW5nIHNwZWMuIElmIGV4cG9zaW5nIHRoZSBiaXQsIHRo
YXQgbWVhbnMgcGxsIGRyaXZlcg0KPiBhbmQgY2xrIGRyaXZlciBoYXMgdHdvIHBhdGhzIHRvIHRv
dWNoIHRoaXMgYml0LCB3aGljaCBpcyB3cm9uZy4NCj4gDQo+IFNvIHVzZSBFWFRfQllQQVNTIGJp
dCBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpS
ZWdhcmRzDQpBaXNoZW5nDQo=

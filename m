Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E62C33CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEA72187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q5UBVus+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgANH1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:27:16 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:36462
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbgANH1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:27:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmDzc7m7+BZBAB5bPXo7Xx12rBryiD2KcJEDSh+DJG/PDr++CPz4njcWw7nV9NsMnPbRVjwwJosXYJKWqJMVAuPkOp5CmdpgYq6ydXpEBdyMOVi8fMWusWwtwgrfkEJmZFLzqlC98GGzdvqaJupnrk3sfEhXy59VSfnS8WWIQZixkqCtEzsIxDW1cdHBcwekPv202AafWpPD3Fd1cnr1Z0EMV9aXu/jRweLUmBSpnYQ6QmGUL4AIBhWkpn8/CaKHVVj/w4p3Zv80PlBk1r8TwQMJeuJF5B2PxGVIxQ+UaXdnFCg48hYIDePYbkuWfOCJF4MhFWNS7eYdvnN6wrNgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTfFJDq15ddji1P+Ws6ZW93IiCXDYAJ9Pv/q7a7AeGw=;
 b=Am25Rit9az5cNGO3C2DyF7x1Pwjcm5bVGPXHj8MJzZOzyT+6hmSEtID2EMPfOOOdQKjgEbKFBS+/XDCeF7YvJzV2viSEZcXg++BbDr9ve+M+TM56+FL1taeu4V6V8ZHzxD1SGSgunzRA+0JcsHqwZX5QXqWF69EFS0ZxYr+IyCKtaBy5EOTtCsNM05Moc/HBjny+Ru+Qp7MHO4vBWlUjt62eSqV2WEAP9YK5t4w+Mr8y9GZxzMKUBX1RQxCx/v9jQG2IDdZVp+b6obeLjzdIKg33okXw5fJQVpff8Nn7987bTEfY0Y9J6KYvd5Vgm1YE+aDsd711rb+Zn76dDcYx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTfFJDq15ddji1P+Ws6ZW93IiCXDYAJ9Pv/q7a7AeGw=;
 b=Q5UBVus+eHAyRpiOrFtt/xoEj55XFNcI+UfOFKy81+iN4HtQQDOKoc6rYQX0KECqaRw1jeeDRxDgO42epErnrcV+NT2yYg2i9QMytFkEMDG23q09VloJZIHZ8PjzRPgmByeBt2Ds1huZ8j6yXBJR0Y2nU8wgjPzDCzni3AvqEeU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5490.eurprd04.prod.outlook.com (20.178.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 07:27:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 07:27:10 +0000
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 07:27:05 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] clk: imx: imx8m: fix a53 cpu clock
Thread-Topic: [PATCH V2 0/4] clk: imx: imx8m: fix a53 cpu clock
Thread-Index: AQHVyqwI/Q11JwojXU6mQ7Vn6Yy0zw==
Date:   Tue, 14 Jan 2020 07:27:10 +0000
Message-ID: <1578986576-6168-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99af563f-b85e-47ec-e132-08d798c32b09
x-ms-traffictypediagnostic: AM0PR04MB5490:|AM0PR04MB5490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5490D5B0CAFD83F1ADEF3D8588340@AM0PR04MB5490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(66476007)(478600001)(66946007)(2906002)(66446008)(66556008)(6506007)(64756008)(52116002)(186003)(2616005)(26005)(44832011)(16526019)(8936002)(71200400001)(69590400006)(956004)(81166006)(8676002)(36756003)(81156014)(86362001)(6666004)(5660300002)(4326008)(6486002)(6636002)(110136005)(6512007)(316002)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5490;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzsB0fofNzIXkl338jyPAL+NEGYAkwy6Xc39YGC/s2FGFXi7GywZPINCT63byqbuXj+fr7aAOLyOLpBT+6GRA5NqkyJMOJPTwYVshrlVK474SFr9kA7a79eR4hmqBpo8rAECDArZu/dssiL4d5yeJcMomrz+Ao2aldg0H8lMnC56phm/FdLnkIfpDM1abnQ/Plg6tMMsDoFTo2TXT9HjH/0dJZbFcBTsA+HITOWlH6RTlC+BxS7f++/A7LyzFqyt5SCFS09JkxFRBJC9Kr6+HwXxQ76qm3hz5vehVyZicpFBz9kA0iJXFdoxlv+2lJiPjzFri/i3fY4hsFOPAq51PSFHCOSAoGMW0HQNpGssXh6GB11IiqaClT39oGgpAmqksTrCuzDFy93LqgjjqvPnCwkeGjaqzxe2V36nOEo1RsWly0P1TkF2+kxUstEX12rB8qB0zqypreTOxtdY0mQVAG6HNK+juHtAvO6TFO5b118dofmUpn2k2MPugm1lixbbUARHAqyjQpKRzzBodVLmNg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af563f-b85e-47ec-e132-08d798c32b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 07:27:10.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TY2mpqbr15y832BgDyIsJh7Ut+aUHcb+ujIxAZ9hKzWGXWRaAUYJK1SpceQeo5Ng37PZ/TSBHXDeug0nPJ5NmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Fix i.MX8MP build
 Update cover letter, i.MX7D not have this issue=20

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which voilates the CCM.

There is a CORE_SEL slice before A53 core, we need configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

Peng Fan (4):
  clk: imx: imx8mq: fix a53 cpu clock
  clk: imx: imx8mm: fix a53 cpu clock
  clk: imx: imx8mn: fix a53 cpu clock
  clk: imx: imx8mp: fix a53 cpu clock

 drivers/clk/imx/clk-imx8mm.c             | 16 ++++++++++++----
 drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++++++----
 drivers/clk/imx/clk-imx8mp.c             | 16 ++++++++++++----
 drivers/clk/imx/clk-imx8mq.c             | 16 ++++++++++++----
 include/dt-bindings/clock/imx8mm-clock.h |  4 +++-
 include/dt-bindings/clock/imx8mn-clock.h |  4 +++-
 include/dt-bindings/clock/imx8mp-clock.h |  3 ++-
 include/dt-bindings/clock/imx8mq-clock.h |  4 +++-
 8 files changed, 59 insertions(+), 20 deletions(-)

--=20
2.16.4


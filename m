Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6139C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938982077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+GjfT8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgAJHRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:17:51 -0500
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:37825
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgAJHRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:17:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adOs9R40v/0L6TE33S+NAfOTf9cBy1k3OhrLaDFMGou7SstOOLVxv76Gt4NHOPfqpce4KWUvtpBX0S0L2Agi6V4wCMOH4d1VfSVx6swUCBpGivYWh4j1OFPdOkpF0VNJmK3+Yjq05taGBSHPxgY1Xj+fDxr4kD7Kau5IK7RW/Pa6SLhBLl1Oaay26wTZ6TK8ZF8ZhbJI0Cm+9V1px8M3OzHB/bDOmazNMEFojLo6tzuitzeRbfgahsr96KEsWQIqAyAYMXWXXK7d7mv84nEXw9XDO08oFIz9xWae9azrA3phdS4uhH7LzLmelPiRon6Fqr90vUB+6bqi7pQo1GYWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAgdBfY8LMh9QMyH9YtGYQpD/f6m1bntQHj+NaoZ5S4=;
 b=nxgvVWI00OvdrJJ5FRpHu44+16IGW22cWKHnanIiBLQzF/x1Nr9Hoj8KrLhny+YTj1IwNk6prLwYoptQ4c0CsbPTExInXpVmMNrzisugXIkXlWS1wPoBZ55oKq0usMdVtHH8N5lGaq8scVA/LzaNUa2GLMijqwsxgSfknyG3br2w6SNPfH2ajSF6C5YlgYb4W6Ugl0a9Sxd91wXf4jO+XnI0ri++LP2fwXTECjI4q2BGWOZJr1JtxwwW3yGSLWCTBtJgB/bL0TWxq3Iwb7vQW4xgrCW+xlG6TOz0mep0dm7g26wwcy7zr9d1sqP0XqyICtcAp1WeYHlgDyZQfaclEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAgdBfY8LMh9QMyH9YtGYQpD/f6m1bntQHj+NaoZ5S4=;
 b=V+GjfT8IXJ509vAQBVia6yOGZzCPvc8vo650LjV2ECDJipRnjmEEXVbfqhN5bqBjuzVvZs7YqwX9/DVLX4y0yA/ZZq/T9lPliLEuUR8adm/mCElKXNQdpscJ3zScUHaKEfHsNanyDe90GoSvJcnWLVcHYHTzpyQWsSlGbs60Nt8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6866.eurprd04.prod.outlook.com (52.132.213.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 07:17:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 07:17:46 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend Transport; Fri, 10 Jan 2020 07:17:41 +0000
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
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] clk: imx: imx8m: introduce imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V2 0/4] clk: imx: imx8m: introduce
 imx8m_clk_hw_composite_core
Thread-Index: AQHVx4YOBUx4I9OVL0O8T7W08mrNMQ==
Date:   Fri, 10 Jan 2020 07:17:46 +0000
Message-ID: <1578640411-16991-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3c47479-92bd-404e-b4c2-08d7959d3104
x-ms-traffictypediagnostic: AM0PR04MB6866:|AM0PR04MB6866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6866E017322B43BD30E78D5688380@AM0PR04MB6866.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(478600001)(6486002)(8936002)(81156014)(4326008)(36756003)(86362001)(316002)(54906003)(110136005)(81166006)(8676002)(2906002)(69590400006)(64756008)(186003)(52116002)(16526019)(6636002)(6506007)(66556008)(66476007)(66446008)(66946007)(44832011)(5660300002)(2616005)(26005)(6512007)(71200400001)(956004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6866;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ClMxlS7EM/lBXF5CqHIRIcFNAjBik4r3dGyUJYzfnqyx5nouJd2NZKg8kKwnEO1o0JGhWpx47LeqjkykXnUNpYgnieRsp8bgcnkPxnsPxYSx5NqIsZFdmLbIdFfPQ8H3iFXJK019uNnFKRsvGvg5w/deIeaGhdQDXmRFbHvumuNnW8LeSXd17QNDSFIkP8E9LiXZQrcYUoqDb5SScqze+BD6TWsnCAm47oB9f+1LCg4kE3a4b4/3H7pVqsy4+lqcb5bKR+dIPXiCanBuHw8J1zOG9dd4deOxpw8/KeMkDJFpZ7+s7VMTuBuA+xZ7oRLJ8srWC/iBduD09FEfSWIWzCjjj+leXsx7X0WcDm8yVSYz68M/aej0k6TEeOnaAYKGx+o4ENIYQCFVdLLnlSxXxKk+i3qG190z3hA7afE4gyu/e3Z0NNIgF11AJjYR807LoK4Oa5uHCx04JK5Z3LWbHR56jllan41AW8wduYd97dsmoeJU2J638kt2XW8fTqN9lCMN8Z+Izla4NS4Iu508rg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c47479-92bd-404e-b4c2-08d7959d3104
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 07:17:46.6057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yATO8ZpMpO6fmN/lJBkwZQ1HE7hY168GVAZUf44lSz8j+xBW1Da4wg0NOkFNhsC5NZ990AmWvIaX2TeHKwbfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Rename imx8m_clk_hw_core_composite to imx8m_clk_hw_composite_core
 Add Abel's tag

To i.MX8M family, there are different types of clock slices,
bus/core/ip and etc. Currently, the imx8m_clk_hw_composite
api could only handle bus and ip clock slice, it could
not handle core slice. The difference is core slice not have
pre divider and the width of post divider is 3 bits.

To simplify code and reuse imx8m_clk_hw_composite, introduce a
flag IMX_COMPOSITE_CORE to differentiate the slices.

With this new helper, we could simplify i.MX8M SoC clk drivers.

Peng Fan (4):
  clk: imx: composite-8m: add imx8m_clk_hw_composite_core
  clk: imx: imx8mq: use imx8m_clk_hw_composite_core
  clk: imx: imx8mm: use imx8m_clk_hw_composite_core
  clk: imx: imx8mn: use imx8m_clk_hw_composite_core

 drivers/clk/imx/clk-composite-8m.c | 18 ++++++++++++++----
 drivers/clk/imx/clk-imx8mm.c       | 17 +++++------------
 drivers/clk/imx/clk-imx8mn.c       | 10 +++-------
 drivers/clk/imx/clk-imx8mq.c       | 19 +++++--------------
 drivers/clk/imx/clk.h              | 12 ++++++++++--
 5 files changed, 37 insertions(+), 39 deletions(-)

--=20
2.16.4


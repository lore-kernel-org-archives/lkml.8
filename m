Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B28C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F4E2467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 05:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PhrHH5ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgA1F2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 00:28:37 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:41686
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgA1F2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 00:28:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLabxd0eY8eGzBkkyB209gXtF5zfc7BYrLjJWFZu2kPxvw0TwQD3gdayChdX55XKvPYyBkFhImBuzPp2nDnJhEn0NQqSE5JSPJMbbXINT8VB/0cQOpMSkX3J69FiESByzpCT0STq/x+CSkviNr1IPKyGtGV77wkR0e2lPIuhTgnGVGyNR6egSrFCrhMca8y8nk+N00rAeSu3pMFMWqaOY7IK2qd1jfnBM23daj+5yox+CMrw9pVP60+PmfayHgP5zLT5UfacmHbpqegFvVty6cnF7EH+ITpxlws3wKxz6jLqfe4iqenGltUF/4KctnxdAPiI4qrBvr5NJtTRcEHF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLKmliOlzZaavwQHUbPFwVDfiYQ9Ih/Z7+05z5lMGJw=;
 b=SI+ttF1fgJXkZBQRaomHBXUFtHmfcWywHNIQ/D5bvmbrQStMC/Gy1wPheHeYeP6fDjTnzE85+v/4N2k2wygoNSoEWN8G1k7P4wg3jDkUmZ3tRcn+62COrPm6nvKXeaZL8cjgpbouc/uv9/sbNip22mWyA6u+qy9YvI+CNL9rQMlZbDhHr8fFN14Yw4crXbNJ7yIrCYd3Woefz+mfmfJk+NS3SpU6iMIdCrAHTjeJz1ldW6yWmBaPgZFQYnZFnV7mFoi2JYTnPCV1DJuZw3liWZKbhW60nFbJo0YW6FSw2ukERXbA76qNYZSwRMuGJMjEOSaug+0v1ymD7UYMNUVZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLKmliOlzZaavwQHUbPFwVDfiYQ9Ih/Z7+05z5lMGJw=;
 b=PhrHH5ubcDe/xs3vEkktITysvBaI4u4vh/5DirVCIfUBiE66y7TWb2UFvMcc33dwdylQNHYH2164RYJVcJVYI/es2399GCVhc+2c30DHJtCc5YyuIDDql+k+u6F5uG0vJ2s/FlorN4Ver3pMEzA9p63wVY9e6/I5wjng4/TUEEo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5890.eurprd04.prod.outlook.com (20.178.202.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 05:28:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 05:28:32 +0000
Received: from localhost.localdomain (119.31.174.66) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2665.22 via Frontend Transport; Tue, 28 Jan 2020 05:28:27 +0000
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
Subject: [PATCH V4 0/4] clk: imx: imx8m: introduce imx8m_clk_hw_composite_core
Thread-Topic: [PATCH V4 0/4] clk: imx: imx8m: introduce
 imx8m_clk_hw_composite_core
Thread-Index: AQHV1ZvHklheOLKStkK+igJOK/WgpA==
Date:   Tue, 28 Jan 2020 05:28:32 +0000
Message-ID: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef93258e-6597-4dd2-9447-08d7a3b2e9de
x-ms-traffictypediagnostic: AM0PR04MB5890:|AM0PR04MB5890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB58906D1C36F0791A657DF9E3880A0@AM0PR04MB5890.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(36756003)(69590400006)(110136005)(54906003)(4326008)(71200400001)(52116002)(44832011)(66556008)(64756008)(478600001)(66476007)(66946007)(66446008)(2616005)(5660300002)(956004)(316002)(86362001)(6486002)(186003)(8676002)(16526019)(6512007)(81156014)(81166006)(6506007)(6636002)(2906002)(26005)(8936002)(6666004)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5890;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBBT+slQFh1KsCBQMeiSA4aDKdyhtrqKNDi4e+HiDOzAqN7XHxUvhDIRcxGoRP58SJONcm6rVI8iERz4NBVWmNxGJ6G159WHn087avNlCD/oNTYNcDaXU3ZASxpRWtH2hpBSi1oYHnusP+jYqUMsD3TxKsuKDeitlIEFjiypqXc9dvrqtDyTOik8OZvOhyZwN+P+/Q8DolCBkVAO7wk6kj4vvU6kT3S+rXBrvH3RXwkrtLn3hsNoKVJNW9koAJemuAZuZJvCeywhnLVvMce+i/H9iJX+i0ir7Ob6NgSj/DiqidEeYaUQKsqnEjUE0M30KJIxiUyN1pRqn3Fmw70ee23MeNTt2uGwgxUY6j2K6RTK7lm+LAWHmHcNBurzZEYJuKTr59f9yba9yQOhxm3cPba3tokCx9EE8omoERRrxwmYBohuj+R42bEQfQ7fcnKJAipXk7rQ7Rd3WBjTBuN2JX303KrsCTsn7PoAJ0K35id8WxNVmKMVAqC+wqrYAVl2G0Zbl6ncIGhzF8gl/OZX+h+2Tzh9g8W5bgCQHGLxrGkkRBw2SSDOfqktBzndIQHBAp/2pAS8gPHDaVPtgLDONplb2w01BzzIuUr02unYerg=
x-ms-exchange-antispam-messagedata: dJnn8X5u4NpwgdOdAqVBeNlQW0DOCuhC/nQ1Xh8dev1go4QHKMqEIYvx83Oq/KPxQmVFfUiR3AOdVkEnfRNtG7s7Go+1s+xy2D5pHdfon/oRZtlQxwtGvzsJxJgUz8jP/r3UnnUqad5ymRD+Ig1QVQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef93258e-6597-4dd2-9447-08d7a3b2e9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 05:28:32.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOdegzN5iMLMS7l8KD7FJi8oChX+jk+DQg9HrpQqX1D/iPhDSOPIvk2QK28Cm8ETgEZMGaZ/RG9Fx6VDxOa12A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5890
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Per Leonard's comments, added new definitions and  _SRC/CG/DIV are
 alias to the new definition.
 Did boot test on i.MX8MQ/M/N-EVK

V3:
 Add CLK_SET_RATE_NO_REPARENT and CLK_OPS_PARENT_ENABLE for core
 Avoid break DT for i.MX8MQ

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

 drivers/clk/imx/clk-composite-8m.c       | 18 ++++++++++++----
 drivers/clk/imx/clk-imx8mm.c             | 35 +++++++++++++++++++---------=
----
 drivers/clk/imx/clk-imx8mn.c             | 19 +++++++++--------
 drivers/clk/imx/clk-imx8mq.c             | 34 +++++++++++++++++-----------=
---
 drivers/clk/imx/clk.h                    | 13 ++++++++++--
 include/dt-bindings/clock/imx8mm-clock.h |  7 ++++++-
 include/dt-bindings/clock/imx8mn-clock.h |  5 ++++-
 include/dt-bindings/clock/imx8mq-clock.h |  7 ++++++-
 8 files changed, 92 insertions(+), 46 deletions(-)

--=20
2.16.4


Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D09C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0377B20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 09:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WxsMaUPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgAPJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:36:47 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:36800
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgAPJgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:36:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDt7Ephiy8QOYZtDn/jWFzOoE+yYjzcEm6mLmsJbAKpTq709JADVPbYEIdR62s8Xlpu8AJvFlM5vwPXvsepXtzAxTSm/vAMfpdcgzNc+/gbR6JpneMLa+cflg57HPhPbmTVrK2jKQdvWBhYN3nKPmla4Apc7kwzEzXHESeUM5puI/85Did1n7FfY0RsZKgY64Su9I5EwhN38cgh0odPlVvELzoU0ilDkYoKaIwWpM9cuuwSM20Ka/stfSJMP2Q7FLU2Agu/YlQEFSp5QdF5GT9VAYLvTH5QpmGBdbaRmLIw5fxMWXy0nIXUXtvC3eCboyDBs4bnoqp26yjY1gR55Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT4MDkCzU4NJ0bMXmF2fkl1mvzTyRAOOHOii8lGrM3g=;
 b=UMrk0ok2xitc3tUoZzr46VO0PAbSrqHHJZiO/EiuFXV/VsgsQRDotFNkuj7wTR6YrKv5ypd4yRnRceYcknDQqdxwXFtWymSe2Rk41iDvq+4DDQJHTE2PWVcVRKaPeJibaw3zJDFpWyU4GogxA2+IM7O8ZdS1eXqjnTdFxarWmRfGVrzTDCeRSVRK/7RJAAJvfkVqSj1CoimwDvv/TyuORDE+QlIQ8diQ9ngRhc43q1uKs9TrcxWAhnfFTKZGS8YS6EkiGnXRZslMYoj1snXIoSumX7efX3rsV826il0Sl/iTHrW4l3gMmffhCtGLgM2fvB9obwkDYOY+eF+wemtgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT4MDkCzU4NJ0bMXmF2fkl1mvzTyRAOOHOii8lGrM3g=;
 b=WxsMaUPQ6LH3VBILqphN2/lp8PIVHUXe69AGNTlF9lBfOb/CRJXnSSbbXq/FPrI2yMlUwSsz04GsZR/E0r0RDbRYXtxRtmYZn6nP+Wr/54NAhwX+jgungB00IC5wZ0NprjsBEhkfqp2ynxYv0dU+oVGesLc3bLycdlRy21Bn4dg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.124.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 16 Jan 2020 09:36:43 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 09:36:43 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:202::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Thu, 16 Jan 2020 09:36:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC 0/4] ARM: imx: move cpu code to drivers/soc/imx
Thread-Topic: [RFC 0/4] ARM: imx: move cpu code to drivers/soc/imx
Thread-Index: AQHVzFB28inl/b14XEmQISgKukQ5pA==
Date:   Thu, 16 Jan 2020 09:36:43 +0000
Message-ID: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20ca5246-c663-4e5c-3495-08d79a6798ce
x-ms-traffictypediagnostic: AM0PR04MB4337:|AM0PR04MB4337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4337EAEE51E1D018258EB00C88360@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(8936002)(86362001)(69590400006)(71200400001)(6512007)(186003)(16526019)(52116002)(956004)(44832011)(2616005)(6486002)(26005)(6506007)(478600001)(6666004)(4326008)(7416002)(2906002)(81166006)(66556008)(81156014)(66476007)(66446008)(8676002)(110136005)(316002)(54906003)(5660300002)(36756003)(66946007)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: roH6XQYLimWGYZocYjrvI3qpNsbNXURSl45uGbzp/IWanr5s0FwlvYfIwvA4YNjfNIpo8Wao6AQk0rAmTTD6HNKyfVVYosOH4S6VWNOUPC50Okqnn1jboLMMbhCf0kYM7j1R/fzo+bMPRUEJ/J5JT4DXydPjEIRtCT4f4uoaFbcXuGtUNQSh5T4vfwOFP+Ot/P0W/V0fcgaoBXt6Bvl3U8bsOKfCl3PIwWkz+K742tlwbMKaB92LQmKxAMtCDPTRPUgI9z5x7Kq64SLy6zfrSCxJNIxkBZMUQn2Zf/Fuveywu40Ve5p86EVW0MbXeBPfg8lzXvFmkrmhr5xSTi41Et8mVKyLojsDH9kdjYMGRTY23NTbiWZHoEwJAuj/J7RhY/WyWWbdjrlnN3ccjz04xPMrppRPof4gJ2BQjFwqRBeS+OAQ6KmNF3jS3L3ByJNCQb0LDzJ2z56KyXI2qMFLOQ9yIa+CnLXdZXOFO+/xFOK5vKY8WO6rFcsmM9Jl0ecb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ca5246-c663-4e5c-3495-08d79a6798ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 09:36:43.3773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oI0ELJgBIvEitywbhU953rauL8lzqXtnzPacdYWE7SJqSfazBjGKSnZ5pnzH0+59JFUOU+xxzT2bXS3w4+sOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Follow i.MX8, move the soc device register code to drivers/soc/imx
to simplify arch/arm/mach-imx/cpu.c

I planned to use similar logic as soc-imx8.c to restructure soc-imx.c
and merged the two files into one. But not sure, so still keep
the logic in cpu.c.

There is one change is the platform devices are not under
/sys/devices/soc0 after patch 1/4. Actually ARM64 platform
devices are not under /sys/devices/soc0, such as i.MX8/8M.
So it should not hurt to let the platform devices under platform dir.

Peng Fan (4):
  ARM: imx: use device_initcall for imx_soc_device_init
  ARM: imx: cpu: drop dead code
  ARM: imx: move cpu definitions into a header
  soc: imx: move cpu code to drivers/soc/imx

 arch/arm/mach-imx/common.h       |   1 -
 arch/arm/mach-imx/cpu.c          | 159 -----------------------------------=
----
 arch/arm/mach-imx/mach-imx6q.c   |   8 +-
 arch/arm/mach-imx/mach-imx6sl.c  |   8 +-
 arch/arm/mach-imx/mach-imx6sx.c  |   8 +-
 arch/arm/mach-imx/mach-imx6ul.c  |   8 +-
 arch/arm/mach-imx/mach-imx7d.c   |   6 --
 arch/arm/mach-imx/mach-imx7ulp.c |   2 +-
 arch/arm/mach-imx/mxc.h          |  22 +-----
 drivers/soc/imx/Makefile         |   3 +
 drivers/soc/imx/soc-imx.c        | 146 +++++++++++++++++++++++++++++++++++
 include/soc/imx/cpu.h            |  30 ++++++++
 12 files changed, 185 insertions(+), 216 deletions(-)
 create mode 100644 drivers/soc/imx/soc-imx.c
 create mode 100644 include/soc/imx/cpu.h

--=20
2.16.4


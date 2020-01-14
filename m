Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC2FC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59757214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxSU3FK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgANDRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:17:50 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:27011
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729072AbgANDRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:17:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ0Kf3U85qyH9Z+ARUlUB9/c0/Fpnjg9KR8tVlqvBm1N1LBIc9J5LD4fefnedQLJP0TJ8GhzquOgOgCT05BHghDKvy7m4vgqz7r+XwmuyukWgKSCpeDE56dhcnWK/SsDz2WUZbBAgCC8JFZdf3+1M5LLDVoz4Fu0QZTBakbFvq/KQXrNOxAqTiqdFNpYuBWAw8Qsu5WyIqCC4FnHEC5CZPC/hmmp86J2i+LAc3wuYeiy6FSDPLIF6dViZJjOW6jF175mJVHl8w7Pdw0oLkmCDYKwn2JY8Hi3Erop2XIod6hd0HAREpWsBWLcxOw3IzufTdrJmDVqeow97GvlLv9/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1OuPjjSFmgg/gVpt0lcP9WEYEwfByMtLtjuWnyzMnc=;
 b=X5OdZf2AokXowKxtRPigO+Se5/kRg7X5sLM6Yl2yBhGJT2N3JuwDpVplN011mweJyY8B1wlNpnE+Z6spIcqxEV/uuMt+d/VSdz3AAMXmUEFlKRnkuY0AqzAEKKFT9JEkibSsbpvSx8jB/+Nn/xngtBEbFK+gfoyIB3+vU3tIejLdMlmk6jc6QlN2fZQ+PkKgIaLCHyl1hrlgSCPpUl8x1qDrl8k1mzrM1w0pduc4xx+jvk5GV+7gp4apuXVUsGkJoKCbuflFaveQAnowO008JBZW4xFu900M+pFhk/obyMvBTfA5dHrJye7cNUf+ZwW/norVRYnjnEAZQJxL4VDelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1OuPjjSFmgg/gVpt0lcP9WEYEwfByMtLtjuWnyzMnc=;
 b=TxSU3FK3odq8mOGMXHR2+qPezhnt8iucK6cxmqLHovyGwRoSOUndMt261uGhV8uXTjd2EgXhuA5nib2F+roOxZ1q8MJp/icTJ+hbCuzUJMuoaRedOvPFWbS0kF/7ctmKiyC60M3ty72cL22dweQWgysTUzFEO/xdJ/GIAPl7YWU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6755.eurprd04.prod.outlook.com (20.179.252.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Tue, 14 Jan 2020 03:17:44 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 03:17:44 +0000
Received: from localhost.localdomain (119.31.174.66) by HK2PR0302CA0002.apcprd03.prod.outlook.com (2603:1096:202::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Tue, 14 Jan 2020 03:17:39 +0000
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
Subject: [PATCH 0/4] clk: imx: imx8m: fix a53 cpu clock
Thread-Topic: [PATCH 0/4] clk: imx: imx8m: fix a53 cpu clock
Thread-Index: AQHVyokvjgMYqA4lbUarp6lsou3EEg==
Date:   Tue, 14 Jan 2020 03:17:44 +0000
Message-ID: <1578971599-4277-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:202::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4121cec-bb92-4832-68ac-08d798a05224
x-ms-traffictypediagnostic: AM0PR04MB6755:|AM0PR04MB6755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB67555DCDFF36A1FD44578B9C88340@AM0PR04MB6755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(6506007)(478600001)(4326008)(2906002)(66556008)(66476007)(16526019)(64756008)(66446008)(186003)(66946007)(81156014)(81166006)(6512007)(26005)(6666004)(5660300002)(52116002)(8676002)(6486002)(71200400001)(2616005)(956004)(8936002)(86362001)(36756003)(69590400006)(316002)(110136005)(54906003)(44832011)(6636002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6755;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKx3f/q2RuUcVNITfP+wZBLk5Onbu3QuTuuB7YKqzOZv0kMLmHL/ajKLtFfCDDzmufxm2W4uGyBo5hqyduuTSXe1z0WXMf5HI8I3tNRNzb3D0zfyYGS6w3j7n05J3qPpVfSMV06MyHMnDTsJsIWDEPTKlHyZtDNJyLitA/GnRrC+ou5ctjiMSsXFbnmnSeZQaAoj7FoLgKOw12dp7FZZWBxGCG3FzAzqDJpOsiWZhBn0RxBlxO328bLrAVAcsqsNjW3/tkVh5emXBvxZ/jOSNp8QNaz5jnhUTMA37AY4KLqqZmpu/S6S+rth3VNC+lcUMmlCusryglPNdllnUAugTTCuinbkpWgQts/PvrL5yYjSUYADbiALMz5rWaapOZVPcfKA646W+CT9SKRAvz7mbJFikWTgLs8dk8+p4wKaXDeVMWHV4eojKa7UaDD7zL+YN6GvPeuTXZAC5XK62A5HikokKPZ27Cn95wM4kM8DQOI+l2ZsY2ikIoGom69HLY4If/5+kdR88fnThJgsk9zXzQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4121cec-bb92-4832-68ac-08d798a05224
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 03:17:44.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CawHqrjfsfRc0EyUsDureTsoPhGLjukTu44NV8IgqcFzZ8lgRd8gZNRTQWRb9hbbBIuVYqK+niuZzrkFGe6Huw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The A53 CCM clk root only accepts input up to 1GHz, CCM A53 root
signoff timing is 1Ghz, however the A53 core which sources from CCM
root could run above 1GHz which voilates the CCM.

There is a CORE_SEL slice before A53 core, we need configure the
CORE_SEL slice source from ARM PLL, not A53 CCM clk root.

The A53 CCM clk root should only be used when need to change ARM PLL
frequency.

The i.MX7D A7 CCM should also be fixed, I'll write a patch later.

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


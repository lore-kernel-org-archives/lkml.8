Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D034C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0101B205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgD3MqI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:46:08 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:35962 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgD3MqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:46:07 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        by skedge04.snt-world.com (Postfix) with ESMTP id 7A03567A7D8;
        Thu, 30 Apr 2020 14:46:04 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 14:46:03 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 14:46:03 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Adam Ford <aford173@gmail.com>, Anson Huang <Anson.Huang@nxp.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Li Jun" <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/4] Add support for i.MX8MM GPUs through Etnaviv
Thread-Topic: [RFC PATCH 0/4] Add support for i.MX8MM GPUs through Etnaviv
Thread-Index: AQHWHu1P24EsvLcp2k6XxTQQ1PmCiA==
Date:   Thu, 30 Apr 2020 12:46:03 +0000
Message-ID: <20200430124602.14463-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7A03567A7D8.AE648
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: aford173@gmail.com, anson.huang@nxp.com,
        christian.gmeiner@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org, festevam@gmail.com, jun.li@nxp.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux+etnaviv@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This series contains patches to enable GPU support for the i.MX8MM.
There is currently no upstream support for the display subsystem of
the i.MX8MM, but I have a 5.4-based tree with some ported drivers for
LCDIF, DSIM bridge, etc. (see [1]) which I used to test the GPU with
glmark2.

I'm posting this as an RFC for now, as I'm not feeling confident of
all of the changes. Especially patch 1 seems a bit like a hack. Maybe
someone can help me understand the underlying problem and/or come up
with a better fix.

[1] https://git.kontron-electronics.de/linux/linux/-/commits/v5.4-ktn

Frieder Schrempf (4):
  drm/etnaviv: Prevent IRQ triggering at probe time on i.MX8MM
  drm/etnaviv: Fix error path in etnaviv_gpu_clk_enable()
  drm/etnaviv: Change order of enabling clocks to fix boot on i.MX8MM
  arm64: dts: imx8mm: Add GPU nodes for 2D and 3D core using Etnaviv

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 36 ++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c     | 68 ++++++++++++++---------
 2 files changed, 79 insertions(+), 25 deletions(-)

-- 
2.17.1

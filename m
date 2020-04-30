Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC8C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E69205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgD3MqR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:46:17 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:54820 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgD3MqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:46:14 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        by skedge03.snt-world.com (Postfix) with ESMTP id 59DFA67A902;
        Thu, 30 Apr 2020 14:46:11 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 14:46:10 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1913.007; Thu, 30 Apr 2020 14:46:10 +0200
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
Subject: [RFC PATCH 2/4] drm/etnaviv: Fix error path in
 etnaviv_gpu_clk_enable()
Thread-Topic: [RFC PATCH 2/4] drm/etnaviv: Fix error path in
 etnaviv_gpu_clk_enable()
Thread-Index: AQHWHu1TJbmsdbRrokKu6860tWMz5w==
Date:   Thu, 30 Apr 2020 12:46:10 +0000
Message-ID: <20200430124602.14463-3-frieder.schrempf@kontron.de>
References: <20200430124602.14463-1-frieder.schrempf@kontron.de>
In-Reply-To: <20200430124602.14463-1-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: 59DFA67A902.A03A6
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

In case enabling of the bus clock fails etnaviv_gpu_clk_enable()
returns without disabling the already enabled reg clock. Fix this.

Fixes: 65f037e8e908 ("drm/etnaviv: add support for slave interface clock")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 23877c1f150a..7b138d4dd068 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1496,7 +1496,7 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 	if (gpu->clk_bus) {
 		ret = clk_prepare_enable(gpu->clk_bus);
 		if (ret)
-			return ret;
+			goto disable_clk_reg;
 	}
 
 	if (gpu->clk_core) {
@@ -1519,6 +1519,9 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 disable_clk_bus:
 	if (gpu->clk_bus)
 		clk_disable_unprepare(gpu->clk_bus);
+disable_clk_reg:
+	if (gpu->clk_reg)
+		clk_disable_unprepare(gpu->clk_reg);
 
 	return ret;
 }
-- 
2.17.1

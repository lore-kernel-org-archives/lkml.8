Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A4DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6D820754
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCMVNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:13:00 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:35305 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726681AbgCMVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:58 -0400
X-IronPort-AV: E=Sophos;i="5.70,550,1574089200"; 
   d="scan'208";a="41620062"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Mar 2020 06:12:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A780D40E09DA;
        Sat, 14 Mar 2020 06:12:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] media: i2c: ov5645: Set maximum leverage of external clock frequency to 24480000
Date:   Fri, 13 Mar 2020 21:12:33 +0000
Message-Id: <1584133954-6953-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584133954-6953-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1584133954-6953-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing on Renesas RZ/G2E platform, noticed the clock frequency to
be 24242424 as a result the probe failed. However increasing the maximum
leverage of external clock frequency to 24480000 fixes this issue. Since
this difference is small enough and is insignificant set the same in the
driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 4fbabf3..b49359b 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1107,8 +1107,10 @@ static int ov5645_probe(struct i2c_client *client)
 	}
 
 	xclk_freq = clk_get_rate(ov5645->xclk);
-	/* external clock must be 24MHz, allow 1% tolerance */
-	if (xclk_freq < 23760000 || xclk_freq > 24240000) {
+	/* external clock must be 24MHz, allow a minimum 1% and a maximum of 2%
+	 * tolerance
+	 */
+	if (xclk_freq < 23760000 || xclk_freq > 24480000) {
 		dev_err(dev, "external clock frequency %u is not supported\n",
 			xclk_freq);
 		return -EINVAL;
-- 
2.7.4


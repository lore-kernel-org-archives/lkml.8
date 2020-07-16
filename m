Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580CCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4024020760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGPKqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:46:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:23800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPKqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:46:17 -0400
IronPort-SDR: Xs+zIJg3znxE2F/0nIqfvAzWTKwI9S87+4SM01gdofrDi4ZC3ocZ1OFsO4EaeqOogee4KlLUvY
 Yadr70Ex2tFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="128923005"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="128923005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 03:46:16 -0700
IronPort-SDR: L8VK+aZ2Vf4Femkn8SU1E3eRNCT4jfzkerLAZP0H2JXZhyC6PtQnNGLHaPkx6yhfE3TySaQX2s
 91xgA6p+p2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="300207172"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 16 Jul 2020 03:46:15 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v2 2/3] regmap: spi-avmm: start with the last SOP on phy rx buffer parsing
Date:   Thu, 16 Jul 2020 18:42:53 +0800
Message-Id: <1594896174-18826-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch works around a bug in the SPI Slave to Avalon Master bridge.
The SPI slave will send an unexpected extra SOP in the following case.

One in approximately one million read requests results in an apparant
stall on the avalon bus where the SPI slave inserts IDLE characters. When
the stall is over, the slave sends an extra SOP character instead of the
0x7c indicating channel. The other characters are correct.

To eliminate the impact of the bug, this patch changes to look for the
last SOP as the start point of the valid phy rx data.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: no change.
---
 drivers/base/regmap/regmap-spi-avmm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index ab329d2..632e018 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -433,14 +433,14 @@ static int pkt_phy_rx_parse(struct device *dev,
 {
 	char *b, *p;
 
-	b = phy_buf;
 	p = trans_buf;
 
-	/* Find the SOP */
-	while (b < phy_buf + phy_len && *b != PKT_SOP)
-		b++;
+	/* Find the last SOP */
+	b = (phy_buf + phy_len) - 1;
+	while (b >= phy_buf && *b != PKT_SOP)
+		b--;
 
-	if (b >= phy_buf + phy_len) {
+	if (b < phy_buf) {
 		dev_err(dev, "%s no SOP\n", __func__);
 		return -EINVAL;
 	}
-- 
2.7.4


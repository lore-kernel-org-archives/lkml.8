Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1350204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGMEkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:40:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:36861 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgGMEkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:40:16 -0400
IronPort-SDR: S0e2sT23Rj1+Q0DL4eooaRR5j9kKrr42iQ70mQ9NQB4MdY2VnXP1CvxCWY9CfDB7a3J7KsrZZ6
 PVuHRTPER6Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146592082"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="146592082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 21:40:15 -0700
IronPort-SDR: /AmOPvFlXWwlyd3ZPDGWEcpnq6vW15HHommG94y+yTYTP65tvOuTRUxXI4p5MMC3TAFKYIRFRU
 X81itYYi40zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="324130547"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2020 21:40:12 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com
Subject: [PATCH 2/2] mfd: intel-m10-bmc: start with the last SOP on phy rx buffer parsing
Date:   Mon, 13 Jul 2020 12:34:56 +0800
Message-Id: <1594614896-16606-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
References: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
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
 drivers/mfd/intel-spi-avmm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel-spi-avmm.c b/drivers/mfd/intel-spi-avmm.c
index 2604657..e4443b7 100644
--- a/drivers/mfd/intel-spi-avmm.c
+++ b/drivers/mfd/intel-spi-avmm.c
@@ -431,14 +431,14 @@ static int pkt_phy_rx_parse(struct device *dev,
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


Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97468C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F4520706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHYRS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:18:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:23068 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgHYRRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:17:21 -0400
IronPort-SDR: jQeRja6yCj+MnlmJoAS1GRQFOuzGViKDfGDXkviMmurUIHrPl/oHP8tzDb6h38zdJxa3AkVszI
 kMtTfrnx5Ouw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136221315"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136221315"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:13 -0700
IronPort-SDR: d3NZa9SV0Erea1YTulYBLN0sGbqCPfb1OHXJZ1polaNzEvInVIOYHnBaL3ccwUU0BvnRDoH1cA
 zd5liRfe9T7A==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="331478421"
Received: from bgarring-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.4.243])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:12 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Date:   Tue, 25 Aug 2020 12:16:53 -0500
Message-Id: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-ENOTSUPP is not a valid error code, use recommended value instead.

Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 50a66382d87d..89d3856f5890 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -40,14 +40,14 @@ static int regmap_sdw_config_check(const struct regmap_config *config)
 {
 	/* All register are 8-bits wide as per MIPI Soundwire 1.0 Spec */
 	if (config->val_bits != 8)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Registers are 32 bits wide */
 	if (config->reg_bits != 32)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (config->pad_bits != 0)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	return 0;
 }
-- 
2.25.1


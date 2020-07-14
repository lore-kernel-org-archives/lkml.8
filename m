Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1838C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B99C206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgGOJcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:1641 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgGOJcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:09 -0400
IronPort-SDR: XMz8KE0gUkaoZHq6yTYZ5YiKSEHbM2I/+lIkXA9hbU+uPEn4dcGdcNLBBEa5kxGOl8YrKkGE6n
 i/gE1WaIzGqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147119296"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="147119296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:32:08 -0700
IronPort-SDR: EtDtJlDPlYRIvJKIg68eUFrdOu7QMbSIatFBXmGn53ww/n7xu+OopTBBKPtm7jdA3AcPlsuqEC
 9qRoD13YJ1tA==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="460006248"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:32:04 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: sdw.h: fix indentation
Date:   Wed, 15 Jul 2020 05:37:44 +0800
Message-Id: <20200714213744.24674-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
References: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Not sure how this went undetected for years.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 6452bac957b3..76052f12c9f7 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -88,10 +88,10 @@ enum sdw_slave_status {
  * @SDW_CLK_POST_DEPREPARE: post clock stop de-prepare
  */
 enum sdw_clk_stop_type {
-	       SDW_CLK_PRE_PREPARE = 0,
-	       SDW_CLK_POST_PREPARE,
-	       SDW_CLK_PRE_DEPREPARE,
-	       SDW_CLK_POST_DEPREPARE,
+	SDW_CLK_PRE_PREPARE = 0,
+	SDW_CLK_POST_PREPARE,
+	SDW_CLK_PRE_DEPREPARE,
+	SDW_CLK_POST_DEPREPARE,
 };
 
 /**
-- 
2.17.1


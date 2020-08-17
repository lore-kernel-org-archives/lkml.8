Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76790C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2F82063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHRFl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:41:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:36469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHRFlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:41:25 -0400
IronPort-SDR: ygMYQgUH4/b2xRsnP5nsGFx5COmglrI/1iKwuItVWXKHGAkWZMMsMqPjo9MzwNSJWqq+BB+m5p
 8ehHEBeaRN9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152477971"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="152477971"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:41:24 -0700
IronPort-SDR: q6vq7fQJDA/syxlOKE9XCNTj6MPmYV6xF0yedEVuplfQTxSfka3FiYfSsCdSxK9+sNOG8ma5cz
 mIl6K1+bwiUA==
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="471678380"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:41:20 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: add definition for maximum number of ports
Date:   Tue, 18 Aug 2020 01:47:26 +0800
Message-Id: <20200817174727.15139-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

A Device may have at most 15 physical ports (DP0, DP1..DP14).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..0aa4c6af7554 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -38,7 +38,8 @@ struct sdw_slave;
 #define SDW_FRAME_CTRL_BITS		48
 #define SDW_MAX_DEVICES			11
 
-#define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
+#define SDW_MAX_PORTS			15
+#define SDW_VALID_PORT_RANGE(n)		((n) < SDW_MAX_PORTS && (n) >= 1)
 
 enum {
 	SDW_PORT_DIRN_SINK = 0,
-- 
2.17.1


Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943FB2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHaBVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:21:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:18361 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHaBVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:21:30 -0400
IronPort-SDR: WXrtpckWiZqOZTIMXaV3zm+gZql2Dc2TtlrkqZN4smPqwg94Q9R694o+LFOlejFCuNUMzfF9Mu
 2I/ZOlGxqygw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144639109"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="144639109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 18:21:30 -0700
IronPort-SDR: wGI05vG5C9lDG/mW2tvGgOT2yS8ZReo29QIXeGO/HF3Nvns9luXLfHZ1PpHdhP1BF5hEaJuwEa
 EXrg/DGzoXRw==
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="476529203"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 18:21:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v3 1/3] soundwire: add definition for maximum number of ports
Date:   Sun, 30 Aug 2020 21:27:40 +0800
Message-Id: <20200830132742.20404-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
References: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
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


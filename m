Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B053C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30934207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgFOOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:14:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:34462 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730188AbgFOOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:14:08 -0400
IronPort-SDR: wJxOVjZsTrHC0HBGL3w40OpYSufr4wYXnmDs+CgOCpVWnWiSZTKuX7lBVr2e++4/5xptmENDJz
 BhHSIoLQGOgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:14:07 -0700
IronPort-SDR: VMFAbqlG3HsC0h9Lxy5iKDnfcb9snWiqle4sfQgTgfndouU3IFxKi6Q5HaslbBTXiFcR46i4QS
 D6iYULVNE5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476029197"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 07:14:07 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 1/4] firmware: stratix10-svc: correct reconfig flag and timeout values
Date:   Mon, 15 Jun 2020 09:29:05 -0500
Message-Id: <1592231348-31334-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
References: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Correct the incorrect flag value for COMMAND_RECONFIG_FLAG_PARTIAL and
increase FPGA reconfig timeout values so that Intel service layer and
FPGA manager drivers can work with all versions of firmware.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 include/linux/firmware/intel/stratix10-svc-client.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 64213c3..040bc3f 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -54,18 +54,17 @@
  * Flag bit for COMMAND_RECONFIG
  *
  * COMMAND_RECONFIG_FLAG_PARTIAL:
- * Set to FPGA configuration type (full or partial), the default
- * is full reconfig.
+ * Set to FPGA configuration type (full or partial).
  */
-#define COMMAND_RECONFIG_FLAG_PARTIAL	0
+#define COMMAND_RECONFIG_FLAG_PARTIAL	1
 
 /**
  * Timeout settings for service clients:
  * timeout value used in Stratix10 FPGA manager driver.
  * timeout value used in RSU driver
  */
-#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         100
-#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          240
+#define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
+#define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 
 struct stratix10_svc_chan;
-- 
2.7.4


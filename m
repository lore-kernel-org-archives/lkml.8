Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5152065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgEMWYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:24:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:51461 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgEMWYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:24:38 -0400
IronPort-SDR: QeGy5Lp/ZJ5PG78ROAq2YNUUdH6ueLL5QhEz+VgGCGofbfhxwu7FEhmR7OI2nrAlR/QoeVAIr8
 GpGn/oVS6CdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 15:24:37 -0700
IronPort-SDR: 4fgwQjlIysqXsGZVGJhVkOmI/ugp2yka52jMNzt2Opm/53NlrjVdA+bUIyxVfyaSBx/arjQyck
 lbtjIVtuanfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="306912805"
Received: from spandruv-mobl.amr.corp.intel.com ([10.209.1.86])
  by FMSMGA003.fm.intel.com with ESMTP; 13 May 2020 15:24:37 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy@infradead.org, dvhart@infradead.org, prarit@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Increase timeout
Date:   Wed, 13 May 2020 15:24:34 -0700
Message-Id: <20200513222434.152088-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix timeout issue on some Ice Lake servers, where mail box command is
timing out before the response,

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel_speed_select_if/isst_if_mbox_pci.c      | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
index de4169d0796b..d84e2174cbde 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
@@ -21,13 +21,12 @@
 #define PUNIT_MAILBOX_BUSY_BIT		31
 
 /*
- * Commands has variable amount of processing time. Most of the commands will
- * be done in 0-3 tries, but some takes up to 50.
- * The real processing time was observed as 25us for the most of the commands
- * at 2GHz. It is possible to optimize this count taking samples on customer
- * systems.
+ * The average time to complete some commands is about 40us. The current
+ * count is enough to satisfy 40us. But when the firmware is very busy, this
+ * causes timeout occasionally.  So increase to deal with some worst case
+ * scenarios. Most of the command still complete in few us.
  */
-#define OS_MAILBOX_RETRY_COUNT		50
+#define OS_MAILBOX_RETRY_COUNT		100
 
 struct isst_if_device {
 	struct mutex mutex;
-- 
2.25.4


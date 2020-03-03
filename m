Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6A21741
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgCCWuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:50:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:13236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgCCWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:50:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 14:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="319622087"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.184.249])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2020 14:50:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] tools/power/x86/intel-speed-select: Fix mailbox usage for CLOS_PM_QOS_CONFIG
Date:   Tue,  3 Mar 2020 14:50:43 -0800
Message-Id: <20200303225044.362525-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303225044.362525-1-srinivas.pandruvada@linux.intel.com>
References: <20200303225044.362525-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even for the products using MMIO, this message needs to be sent via
mail box. The previous fix done for this didn't properly address this.
That fix simply removed sending command via MMIO, but still didn't
trigger sending via mailbox.

Add additional condition to check for CLOS_PM_QOS_CONFIG, when MMIO
is supported on a platform.

Fixes: cd0e63706549 (tools/power/x86/intel-speed-select: Use mailbox for CLOS_PM_QOS_CONFIG)
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 0cf3548681f8..50db0cd23d8c 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -572,7 +572,8 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 		"mbox_send: cpu:%d command:%x sub_command:%x parameter:%x req_data:%x\n",
 		cpu, command, sub_command, parameter, req_data);
 
-	if (isst_platform_info.mmio_supported && command == CONFIG_CLOS) {
+	if (isst_platform_info.mmio_supported && command == CONFIG_CLOS &&
+	    sub_command != CLOS_PM_QOS_CONFIG) {
 		unsigned int value;
 		int write = 0;
 		int clos_id, core_id, ret = 0;
-- 
2.24.1


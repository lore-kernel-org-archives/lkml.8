Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B9C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544532082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgAMD7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:59:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:7682 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387417AbgAMD7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:59:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 19:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,427,1571727600"; 
   d="scan'208";a="224829130"
Received: from spandruv-mobl3.jf.intel.com ([10.251.135.218])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2020 19:59:32 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andy@infradead.org, dvhart@infradead.org, lenb@kernel.org,
        andy@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Update for the intel uncore frequency control
Date:   Sun, 12 Jan 2020 19:59:17 -0800
Message-Id: <20200113035917.1419452-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113035917.1419452-1-srinivas.pandruvada@linux.intel.com>
References: <20200113035917.1419452-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for drivers/platform/x86/intel-uncore-frequency.c.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4017e6b760be..dbdadb369082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8562,6 +8562,12 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
 F:	drivers/platform/x86/intel_telemetry*
 
+INTEL UNCORE FREQUENCY CONTROL
+M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel-uncore-frequency.c
+
 INTEL VIRTUAL BUTTON DRIVER
 M:	AceLan Kao <acelan.kao@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.24.1


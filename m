Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABD2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2063420870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:55:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:17958 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgCEQzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:55:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 08:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="229756751"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga007.jf.intel.com with ESMTP; 05 Mar 2020 08:55:49 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 2/2] firmware: intel_stratix10_service: add depend on agilex
Date:   Thu,  5 Mar 2020 11:12:26 -0600
Message-Id: <1583428346-13307-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
References: <1583428346-13307-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add depend on Agilex for Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index ea869ad..8007d4a 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -206,7 +206,7 @@ config FW_CFG_SYSFS_CMDLINE
 
 config INTEL_STRATIX10_SERVICE
 	tristate "Intel Stratix10 Service Layer"
-	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
+	depends on (ARCH_STRATIX10 || ARCH_AGILEX) && HAVE_ARM_SMCCC
 	default n
 	help
 	  Intel Stratix10 service layer runs at privileged exception level,
-- 
2.7.4


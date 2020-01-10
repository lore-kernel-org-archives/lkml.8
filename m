Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E207DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3F520678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgAJV4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:56:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:5242 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgAJV4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:56:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="238900624"
Received: from jderrick-mobl.amr.corp.intel.com ([10.255.4.181])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2020 13:56:47 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Jens Axboe <axboe@fb.com>, <linux-kernel@vger.kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH] MAINTAINERS: Add Revanth Rajashekar as a SED-Opal maintainer
Date:   Fri, 10 Jan 2020 14:56:46 -0700
Message-Id: <20200110215646.15930-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott hasn't worked for Intel for some time and has already given us his
blessing.

CC: Scott Bauer <sbauer@plzdonthack.me>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..e1312439f027 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14785,8 +14785,8 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-omap.c
 
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
-M:	Scott Bauer <scott.bauer@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
+M:	Revanth Rajashekar <revanth.rajashekar@intel.com>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	block/sed*
-- 
2.20.1


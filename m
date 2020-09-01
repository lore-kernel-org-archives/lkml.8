Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BDBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB672065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbgIAQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:22:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:8412 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgIAQWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:22:46 -0400
IronPort-SDR: cvtamdoHYUuq4QXoPnebGNvc/mppgg/2S9xJjaNxfHJu0xHPjwSemuvqVhCdR49Bm7pnaz4Toe
 E3q2Fwt3BN5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144939931"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="144939931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 09:22:44 -0700
IronPort-SDR: 5hhM7C4HH2LqVhXMHA0UmLVWRA4p+L554xhv4DOf/55fw0C39nnROp6eoShIuzd8yGU+6Ng4CR
 Smj2pKXQBl/Q==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="477261186"
Received: from tracimsx-mobl5.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.140.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 09:22:43 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org (open list:REGISTER MAP ABSTRACTION)
Subject: [PATCH v2 1/3] regmap: sdw: add required header files
Date:   Tue,  1 Sep 2020 11:22:23 -0500
Message-Id: <20200901162225.33343-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly add header files used by regmap SoundWire support.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index c92d614b4943..c83be26434e7 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -2,7 +2,9 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
 #include "internal.h"
 
-- 
2.25.1


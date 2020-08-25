Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC4FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86D520706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHYRSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:18:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:23070 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgHYRRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:17:21 -0400
IronPort-SDR: aYkaR6G/lgfW3OwDb7sTnBUi0fBwPy69H5Ff5RObUy/VjuKy+F0t5RPJyjXHfYmBvsVhiZIKO6
 avG26Y7gRSwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136221327"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="136221327"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:15 -0700
IronPort-SDR: +p7QzQSPau+jUe91o0Ol3KCjxRpoabbyf+Tp8Zh2nlhiJT03kk/g9uIUINRok0LEu1s0rGKgTi
 Bc79uxsgUwlg==
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="331478437"
Received: from bgarring-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.4.243])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 10:17:14 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/4] regmap: sdw: add required header files
Date:   Tue, 25 Aug 2020 12:16:54 -0500
Message-Id: <20200825171656.75836-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
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
index 89d3856f5890..29edbb6da48f 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -2,8 +2,10 @@
 // Copyright(c) 2015-17 Intel Corporation.
 
 #include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
 #include "internal.h"
 
-- 
2.25.1


Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B23DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75859206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHDJPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:15:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:26085 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgHDJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:15:16 -0400
IronPort-SDR: etIyCEtHzeIxmC6DOJyM876zRR8mbmnhoVYoz/eUitHAbZtQ2yoS/d+YgeVDEoEwi2/by75XLN
 d8xPGFoN8JSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="131846744"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="131846744"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 02:15:16 -0700
IronPort-SDR: uOX8vFjOZCA1KulpAbQNwzaINFIwCQ+himuKYXfYAYTJUZraK3mJnel0teLCwuD0AK3Kqquc4E
 c7bG0JaWRNIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="466989286"
Received: from ipu5-build.bj.intel.com ([10.238.232.196])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2020 02:15:14 -0700
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        bingbu.cao@linux.intel.com
Subject: [PATCH] nvmem: core: add sanity check in nvmem_device_read()
Date:   Tue,  4 Aug 2020 17:13:56 +0800
Message-Id: <1596532436-19073-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem_device_read() could be called directly once nvmem device
registered, the sanity check should be done before call
nvmem_reg_read() as cell and sysfs read did now.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/nvmem/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 927eb5f6003f..c9a77993f008 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1491,6 +1491,13 @@ int nvmem_device_read(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
+	if (offset >= nvmem->size || bytes < nvmem->word_size)
+		return 0;
+
+	if (bytes + offset > nvmem->size)
+		bytes = nvmem->size - offset;
+
+	bytes = round_down(bytes, nvmem->word_size);
 	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
 
 	if (rc)
-- 
2.7.4


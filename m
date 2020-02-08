Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C1C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D1C20733
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBHSo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:44:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:57472 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgBHSoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:44:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 10:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="405181250"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2020 10:44:22 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/2] platform: constify properties in platform_device
Date:   Sat,  8 Feb 2020 20:44:07 +0200
Message-Id: <20200208184407.1294-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208184407.1294-1-tomas.winkler@intel.com>
References: <20200208184407.1294-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify 'struct property_entry *properties' in
platform_device. It is always passed around as a pointer const struct.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 include/linux/platform_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 276a03c24691..8e83c6ff140d 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -89,7 +89,7 @@ struct platform_device_info {
 		size_t size_data;
 		u64 dma_mask;
 
-		struct property_entry *properties;
+		const struct property_entry *properties;
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
-- 
2.21.1


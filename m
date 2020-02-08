Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC63C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DD620661
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBHSoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:44:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:57472 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgBHSoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:44:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2020 10:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,418,1574150400"; 
   d="scan'208";a="405181243"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2020 10:44:20 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/2 V2] mfd: constify properties in mfd_cell
Date:   Sat,  8 Feb 2020 20:44:06 +0200
Message-Id: <20200208184407.1294-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify 'struct property_entry *properties' in
mfd_cell It is always passed
around as a pointer const struct.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---

V2: drop platform_device part

 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49d..7e5ac3c00891 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -70,7 +70,7 @@ struct mfd_cell {
 	size_t			pdata_size;
 
 	/* device properties passed to the sub devices drivers */
-	struct property_entry *properties;
+	const struct property_entry *properties;
 
 	/*
 	 * Device Tree compatible string
-- 
2.21.1


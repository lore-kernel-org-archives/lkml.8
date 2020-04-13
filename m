Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA846C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDCD2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgDMQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:08:14 -0400
Received: from vkten.in ([104.244.73.96]:57596 "EHLO vkten.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbgDMQIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:08:12 -0400
Received: (qmail 15265 invoked from network); 13 Apr 2020 16:08:07 -0000
Received: from unknown (HELO localhost) (vkor@vkten.in@117.209.137.67)
  de/crypted with TLSv1.3: TLS_AES_256_GCM_SHA384 [256/256] DN=none
  by vkten with ESMTPSA; 13 Apr 2020 16:08:07 -0000
From:   R Veera Kumar <vkor@vkten.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     R Veera Kumar <vkor@vkten.in>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Make function arguments alignment match open parenthesis
Date:   Mon, 13 Apr 2020 21:37:53 +0530
Message-Id: <20200413160753.3787-1-vkor@vkten.in>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function arguments alignment match open parenthesis.
Found using checkpatch.pl.

Signed-off-by: R Veera Kumar <vkor@vkten.in>
---
 drivers/staging/sm750fb/sm750.h    | 23 +++++++++++++----------
 drivers/staging/sm750fb/sm750_hw.c |  2 +-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index ce90adcb449d..55fe5a28a174 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -59,16 +59,19 @@ struct lynx_accel {
 
 	int (*de_wait)(void);/* see if hardware ready to work */
 
-	int (*de_fillrect)(struct lynx_accel *, u32, u32, u32, u32,
-						u32, u32, u32, u32, u32);
-
-	int (*de_copyarea)(struct lynx_accel *, u32, u32, u32, u32,
-						u32, u32, u32, u32,
-						u32, u32, u32, u32);
-
-	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
-							       u32, u32, u32, u32,
-							       u32, u32, u32, u32);
+	int (*de_fillrect)(struct lynx_accel *,
+			   u32, u32, u32, u32,
+			   u32, u32, u32, u32, u32);
+
+	int (*de_copyarea)(struct lynx_accel *,
+			   u32, u32, u32, u32,
+			   u32, u32, u32, u32,
+			   u32, u32, u32, u32);
+
+	int (*de_imageblit)(struct lynx_accel *, const char *,
+			    u32, u32, u32, u32,
+			    u32, u32, u32, u32,
+			    u32, u32, u32, u32);
 
 };
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index b8d60701f898..7136d751cff5 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -51,7 +51,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	/* now map mmio and vidmem */
 	sm750_dev->pvReg = ioremap(sm750_dev->vidreg_start,
-					   sm750_dev->vidreg_size);
+				   sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
-- 
2.20.1


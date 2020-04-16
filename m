Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583C6C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357B9206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046531;
	bh=zIMMVk7TAcD0zD+FRPSfWoTEuxM27h+7dOkzAQzeEjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RYuaowrZIyg1pu2dJOCMZ26w3sX7d9Qs9vcOahCDsVd9lZQIWzQYTe63TYXsKLOkp
	 0+HeCkpUqQ16ZYcPad0Q74VGEftmWRqeCZtStx00J9xdh88opn4sNn+k+KEYKUBz4b
	 SSGW6yDuUWcWaItI4pUHHta9dUI6aDBfQKZTisf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgDPOPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392370AbgDPNv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:51:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87C82063A;
        Thu, 16 Apr 2020 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045087;
        bh=zIMMVk7TAcD0zD+FRPSfWoTEuxM27h+7dOkzAQzeEjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELXX9UwFYWneD6GYp4VXL0FGF7HHODu5VK8IP5Pcz5o5y+sSPZrFR3WgGvhjIu+Yb
         bmR6rFhKoB3r134lUnaTOMltUgkwinYtqUsN/8sVNGOz0qcbPU7CmRaogSUozX6Jn0
         XRMi4vG5oI+PQCS2L58jPO4Kc2jX2STeqf4cjgms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 174/232] scsi: ufs: fix Auto-Hibern8 error detection
Date:   Thu, 16 Apr 2020 15:24:28 +0200
Message-Id: <20200416131336.817023449@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

commit 5a244e0ea67b293abb1d26c825db2ddde5f2862f upstream.

Auto-Hibern8 may be disabled by some vendors or sysfs in runtime even if
Auto-Hibern8 capability is supported by host. If Auto-Hibern8 capability is
supported by host but not actually enabled, Auto-Hibern8 error shall not
happen.

To fix this, provide a way to detect if Auto-Hibern8 is actually enabled
first, and bypass Auto-Hibern8 disabling case in
ufshcd_is_auto_hibern8_error().

Fixes: 821744403913 ("scsi: ufs: Add error-handling of Auto-Hibernate")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200129105251.12466-4-stanley.chu@mediatek.com
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
Reviewed-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |    3 ++-
 drivers/scsi/ufs/ufshcd.h |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5467,7 +5467,8 @@ static void ufshcd_update_uic_error(stru
 static bool ufshcd_is_auto_hibern8_error(struct ufs_hba *hba,
 					 u32 intr_mask)
 {
-	if (!ufshcd_is_auto_hibern8_supported(hba))
+	if (!ufshcd_is_auto_hibern8_supported(hba) ||
+	    !ufshcd_is_auto_hibern8_enabled(hba))
 		return false;
 
 	if (!(intr_mask & UFSHCD_UIC_HIBERN8_MASK))
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -55,6 +55,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bitfield.h>
 #include "unipro.h"
 
 #include <asm/irq.h>
@@ -771,6 +772,11 @@ static inline bool ufshcd_is_auto_hibern
 	return (hba->capabilities & MASK_AUTO_HIBERN8_SUPPORT);
 }
 
+static inline bool ufshcd_is_auto_hibern8_enabled(struct ufs_hba *hba)
+{
+	return FIELD_GET(UFSHCI_AHIBERN8_TIMER_MASK, hba->ahit) ? true : false;
+}
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\



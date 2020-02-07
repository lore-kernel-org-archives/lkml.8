Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0D4C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B194C21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYOBuAYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgBGIQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:16:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39928 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:16:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so1541968wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahavwFCNEsNrYJ/5CRKAeLeUfqVud8xuIXpp11HDQww=;
        b=sYOBuAYR4wRxJqwAyTfY+Gg7/QeNS/pGOChhb7xzYST262KcNSJLvroFtHKJD5ONsX
         BnTygE3GrRkEQBaomuDYRtXkuZ0Yw8huUcF/2CaE6AH79JsuP2Gk5kmZCDfQKHNvOCVS
         P2qEw4oH782ZIVtTzqLmwuDC6a6+eMTvltXJadp8RvggVP1wbRIkX2KwkLnhlXdJrk4g
         L2yO8yUwr+zbSjRCyqJE6aLEcQEqv4Tud1+9yxb44S+GkYE02PX8ycMEKv53Pzq3NcIk
         SHJpPNIpYSnYK8r5BkM590RM2UwX6n+uSdJTqqL6tjii0Rq0TeAJLqI/qVcekEj+MRge
         puIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahavwFCNEsNrYJ/5CRKAeLeUfqVud8xuIXpp11HDQww=;
        b=ktUhj0SRubnGHkIvPoTtIgcoxfQ39Sm3BzBySvei8JgU/bo2o54ACs9kfoajseG7sj
         NaiGbdKySClq47Ntrn/oYuNOPboCoTfBnxgi4xL45sYClUEAseYWzIVAcZ3bFkojdFFE
         wQIJEcJihOAzoAjyC2U4YLrPXQaCYow4F2aNDXur12ghftYRiFFV77GeL52xyJoBzAzQ
         NLVPZ79lwOfOXjP4yUT9YelC4/DZbpYVmDPchum56zdMzUFgNAl8fY7/yFvKvek2S6LO
         DRWSEkV9WnUJeg8qZH4kXBHZe4NPYYE/fCXmfheUburrai4LcO+XZDNfvjPvn/ab2P+T
         4V6g==
X-Gm-Message-State: APjAAAVrNziJAeZFhOTcXYnt60O96JKsHzy0ZlROpxa1MFv/Z/SR6tXP
        Zt0bxTcWNKL+fKfcVNG/pzFQj46OCOo=
X-Google-Smtp-Source: APXvYqwkFE3wkP8wr4XQ/E8XbU8WTntpfGdxxQ5sxkPrc8Ueq8Ojq0zL29RBEa6VUS3mvdI9FmC7hw==
X-Received: by 2002:adf:c145:: with SMTP id w5mr3335995wre.205.1581063368912;
        Fri, 07 Feb 2020 00:16:08 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm2466182wrx.25.2020.02.07.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 00:16:07 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/5] habanalabs: ratelimit error prints of IRQs
Date:   Fri,  7 Feb 2020 10:15:17 +0200
Message-Id: <20200207081520.5368-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207081520.5368-1-oded.gabbay@gmail.com>
References: <20200207081520.5368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compute engines can perform millions of transactions per second. If
there is a bug in the S/W stack, we could get a lot of interrupts and spam
the kernel log. Therefore, ratelimit these prints

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0b6567b48622..19bce06e5fc0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4480,22 +4480,22 @@ static void goya_get_event_desc(u16 event_type, char *desc, size_t size)
 static void goya_print_razwi_info(struct hl_device *hdev)
 {
 	if (RREG32(mmDMA_MACRO_RAZWI_LBW_WT_VLD)) {
-		dev_err(hdev->dev, "Illegal write to LBW\n");
+		dev_err_ratelimited(hdev->dev, "Illegal write to LBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_LBW_WT_VLD, 0);
 	}
 
 	if (RREG32(mmDMA_MACRO_RAZWI_LBW_RD_VLD)) {
-		dev_err(hdev->dev, "Illegal read from LBW\n");
+		dev_err_ratelimited(hdev->dev, "Illegal read from LBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_LBW_RD_VLD, 0);
 	}
 
 	if (RREG32(mmDMA_MACRO_RAZWI_HBW_WT_VLD)) {
-		dev_err(hdev->dev, "Illegal write to HBW\n");
+		dev_err_ratelimited(hdev->dev, "Illegal write to HBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_HBW_WT_VLD, 0);
 	}
 
 	if (RREG32(mmDMA_MACRO_RAZWI_HBW_RD_VLD)) {
-		dev_err(hdev->dev, "Illegal read from HBW\n");
+		dev_err_ratelimited(hdev->dev, "Illegal read from HBW\n");
 		WREG32(mmDMA_MACRO_RAZWI_HBW_RD_VLD, 0);
 	}
 }
@@ -4515,7 +4515,8 @@ static void goya_print_mmu_error_info(struct hl_device *hdev)
 		addr <<= 32;
 		addr |= RREG32(mmMMU_PAGE_ERROR_CAPTURE_VA);
 
-		dev_err(hdev->dev, "MMU page fault on va 0x%llx\n", addr);
+		dev_err_ratelimited(hdev->dev, "MMU page fault on va 0x%llx\n",
+					addr);
 
 		WREG32(mmMMU_PAGE_ERROR_CAPTURE, 0);
 	}
@@ -4527,7 +4528,7 @@ static void goya_print_irq_info(struct hl_device *hdev, u16 event_type,
 	char desc[20] = "";
 
 	goya_get_event_desc(event_type, desc, sizeof(desc));
-	dev_err(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
+	dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
 		event_type, desc);
 
 	if (razwi) {
-- 
2.17.1


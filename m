Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954FC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF3206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqtRAXEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1Iwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:52:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgC1Iwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:52:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id h15so14528784wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3AEQAcypEG7YogV8HmIRZ50gECqZh9q92MAZBge2+YU=;
        b=ZqtRAXEcQ7PFW8yW8RYy9xR2yQrRRu+GitcHg92Wc0vQcd8CQSPhIwL6RtFg1OJNUo
         FE5nowMs45s8+uFFvO/uy92hKaEDTm1XyN4WNGoNVsvSj1FI0uK1hD3WdeS1NbJT7znE
         EQtGk4jWn+K3x7L9WkCse46QKVzrYeJAqC+5OYLgKXGqluFp9gVWuWFCUJ8gi7Gr/Gx1
         C4VUyYfYi9vuAku+tFTWy+OuxpSKSQiu4XZICe8B1KOK0Bfd5K9tmiJvBiewL3opm8M2
         1P6sT//zEB+X4oTiR+hnmeVAa3ljYfWDswcFR7YNLH0t8wEzYWJns2u53UtwPfaLpON8
         UBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3AEQAcypEG7YogV8HmIRZ50gECqZh9q92MAZBge2+YU=;
        b=furYHctHhDKwveNB2ccSZ2dYx3Sh7alZsSoKPGDPROfKClpugDapuC5r+HLl2WKiTR
         ITp7B6Mcg5X64a+xYqYx4zmoJpuGfSbFhoYUk+RnMxqU3iINxTSN8C3vE2uoY9aIbUmf
         mwYpQBM5DwOcpVg5rHnjVc1uxqJaQIGFdUlwSkauwsduxk0HMGF8uSwar9vuf5ZIZ0vJ
         8J4M8z0YtSYwtGUg2f33iO3Q2PXGMLlNKRo1iCjWyrLQG/DWd3F7PKdmtTQGj6161nIf
         AJt05LEoGhpUIfEwKQfH5YBzJV5v1UHf9g4rXxPFEww5I/XKqxCKJ0SYJLgDN9tDdXQt
         Wh/w==
X-Gm-Message-State: ANhLgQ21Y6bhOiyCvZ3toglBEEpryYmg3rnD2vPeQgCADoPPP/m9JEQf
        hSV15lanlJhNp7HSSWRaqghybUFW
X-Google-Smtp-Source: ADFU+vsB9xDO9cnmZ4F16dn1N7fnG9PegS4u1mn7UcXHit1GMb6Gy9S/Oykb5EKCmHtjsQvYh4M41Q==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr3871892wrs.202.1585385560083;
        Sat, 28 Mar 2020 01:52:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k15sm11908683wrm.55.2020.03.28.01.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:52:38 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/6] habanalabs: don't wait for ASIC CPU after reset
Date:   Sat, 28 Mar 2020 11:52:33 +0300
Message-Id: <20200328085238.3428-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon reset of the ASIC, the driver would have waited for the CPU to come
out of reset before finishing the reset process. This was done for the
purpose of making the CPU available to answer FLR requests. However, when a
VM shuts down, the driver isn't removed so a reset never happens.
Therefore, remove this waiting period as we don't need it.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c  | 24 ------------------------
 drivers/misc/habanalabs/goya/goyaP.h |  2 +-
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 68f065607544..db125cf80850 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2684,30 +2684,6 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 					HW_CAP_MMU | HW_CAP_TPC_MBIST |
 					HW_CAP_GOLDEN | HW_CAP_TPC);
 	memset(goya->events_stat, 0, sizeof(goya->events_stat));
-
-	if (!hdev->pldm) {
-		int rc;
-		/* In case we are running inside VM and the VM is
-		 * shutting down, we need to make sure CPU boot-loader
-		 * is running before we can continue the VM shutdown.
-		 * That is because the VM will send an FLR signal that
-		 * we must answer
-		 */
-		dev_info(hdev->dev,
-			"Going to wait up to %ds for CPU boot loader\n",
-			GOYA_CPU_TIMEOUT_USEC / 1000 / 1000);
-
-		rc = hl_poll_timeout(
-			hdev,
-			mmPSOC_GLOBAL_CONF_WARM_REBOOT,
-			status,
-			(status == CPU_BOOT_STATUS_DRAM_RDY),
-			10000,
-			GOYA_CPU_TIMEOUT_USEC);
-		if (rc)
-			dev_err(hdev->dev,
-				"failed to wait for CPU boot loader\n");
-	}
 }
 
 int goya_suspend(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index c3230cb6e25c..1555d03e3cb2 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -45,7 +45,7 @@
 
 #define CORESIGHT_TIMEOUT_USEC		100000		/* 100 ms */
 
-#define GOYA_CPU_TIMEOUT_USEC		10000000	/* 10s */
+#define GOYA_CPU_TIMEOUT_USEC		15000000	/* 15s */
 
 #define TPC_ENABLED_MASK		0xFF
 
-- 
2.17.1


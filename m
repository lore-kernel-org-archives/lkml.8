Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D953C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D147A2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWVW9SWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgESP1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgESP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:27:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F9C08C5C0;
        Tue, 19 May 2020 08:27:47 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o24so86749oic.0;
        Tue, 19 May 2020 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RYbtw7YF74B1TP3f62w+MMm9AmH3T7TyQIzVADm4joc=;
        b=rWVW9SWwfu2ivOfML4vV88PpbtolLbU1Bt6z/GmKJYKvEr/IJAxC6A+Jan25TLv+67
         f6IE5DHTZLO9gGFEuM+g3oHnVyHSJ/1mLnjUrYYjZXAPz9BWUue+vLouwKC8JwFv8lE+
         xL0/DA4BFZAhctA7RjlV5tZSuNUaLhrxtuRqhK1yUPOYp6ErfW5gQDsQhUO0CmAWPi2Z
         lRHLTdU/LN8H/XKQdofqT8kMbuaGuRe9RWzMqzwGXf8vsOpikWH1l25S/9gJ0m6Du4nz
         fhUu0iIpQbgyQDF1hVuLP7njtWygXPhhp3G0cbKdGYkrIyXJBvOft96+Te4iOvLsZYuX
         hYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RYbtw7YF74B1TP3f62w+MMm9AmH3T7TyQIzVADm4joc=;
        b=sXL0PrAJxCM7+BbxgNi4MefqlLC08qc+twxmLDIf0B661TywSYp4L+7XrBhh6QMgkg
         LQkR+lI1PrtOGt2Fty0O+n2aeOt4UZlUWWj5InimJdbBEeD2qumJ3I3eVqme4IOSdBFa
         an4yDKu5a13Tu1+3+DfUZr0UwSnKeVclHWh1imgSQaBMv3VBWkZVbh8a8HFA18Mvt27s
         EPX9gQ1lVndue+LHdaSzs9GKga+EDy67AeiDPq6PF/SUHUPB51vka9rJ1ExkedLmtPfI
         CS7RM2cgQviWLfnB5xDrKFWOpu0iLxaXt0mTCCZNNAeWneDyYeNg3W5EYItJh0ex+5LH
         MC3w==
X-Gm-Message-State: AOAM532EvI7uyqtq8aNo4gZl2fR8LQB1WU/iLw4mE1BV/WvvShvUhXvl
        zX0fHUKQiIY8f8w9SKEdY2Y=
X-Google-Smtp-Source: ABdhPJztuxWSwe1B/C48Pk77y+JPvKe2hhPzs11LdWiec1uOOAS4b8PdoDnud6zWas21oN/OFnRQeg==
X-Received: by 2002:aca:fc0c:: with SMTP id a12mr3784oii.50.1589902066973;
        Tue, 19 May 2020 08:27:46 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id m63sm3858556otm.21.2020.05.19.08.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:27:46 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] dcdbas: Check SMBIOS for protected buffer address
Date:   Tue, 19 May 2020 11:27:33 -0400
Message-Id: <20200519152733.48689-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a new method for BIOS to provide the address and length
of the protected SMI communication buffer, via SMBIOS OEM strings.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/platform/x86/dcdbas.c | 43 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/dcdbas.c b/drivers/platform/x86/dcdbas.c
index 84f4cc839cc3..d513a59a5d47 100644
--- a/drivers/platform/x86/dcdbas.c
+++ b/drivers/platform/x86/dcdbas.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
@@ -34,7 +35,7 @@
 #include "dcdbas.h"
 
 #define DRIVER_NAME		"dcdbas"
-#define DRIVER_VERSION		"5.6.0-3.3"
+#define DRIVER_VERSION		"5.6.0-3.4"
 #define DRIVER_DESCRIPTION	"Dell Systems Management Base Driver"
 
 static struct platform_device *dcdbas_pdev;
@@ -45,7 +46,7 @@ static unsigned long smi_data_buf_size;
 static unsigned long max_smi_data_buf_size = MAX_SMI_DATA_BUF_SIZE;
 static u32 smi_data_buf_phys_addr;
 static DEFINE_MUTEX(smi_data_lock);
-static u8 *eps_buffer;
+static u8 *bios_buffer;
 
 static unsigned int host_control_action;
 static unsigned int host_control_smi_type;
@@ -518,8 +519,10 @@ static inline struct smm_eps_table *check_eps_table(u8 *addr)
 
 static int dcdbas_check_wsmt(void)
 {
+	const struct dmi_device *dev = NULL;
 	struct acpi_table_wsmt *wsmt = NULL;
 	struct smm_eps_table *eps = NULL;
+	u64 bios_buf_paddr;
 	u64 remap_size;
 	u8 *addr;
 
@@ -532,6 +535,17 @@ static int dcdbas_check_wsmt(void)
 	    !(wsmt->protection_flags & ACPI_WSMT_COMM_BUFFER_NESTED_PTR_PROTECTION))
 		return 0;
 
+	/*
+	 * BIOS could provide the address/size of the protected buffer
+	 * in an SMBIOS string or in an EPS structure in 0xFxxxx.
+	 */
+
+	/* Check SMBIOS for buffer address */
+	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev)))
+		if (sscanf(dev->name, "30[%16llx;%8llx]", &bios_buf_paddr,
+		    &remap_size) == 2)
+			goto remap;
+
 	/* Scan for EPS (entry point structure) */
 	for (addr = (u8 *)__va(0xf0000);
 	     addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
@@ -542,34 +556,37 @@ static int dcdbas_check_wsmt(void)
 	}
 
 	if (!eps) {
-		dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no EPS found\n");
+		dev_dbg(&dcdbas_pdev->dev, "found WSMT, but no firmware buffer found\n");
 		return -ENODEV;
 	}
+	bios_buf_paddr = eps->smm_comm_buff_addr;
+	remap_size = eps->num_of_4k_pages * PAGE_SIZE;
 
+remap:
 	/*
 	 * Get physical address of buffer and map to virtual address.
 	 * Table gives size in 4K pages, regardless of actual system page size.
 	 */
-	if (upper_32_bits(eps->smm_comm_buff_addr + 8)) {
-		dev_warn(&dcdbas_pdev->dev, "found WSMT, but EPS buffer address is above 4GB\n");
+	if (upper_32_bits(bios_buf_paddr + 8)) {
+		dev_warn(&dcdbas_pdev->dev, "found WSMT, but buffer address is above 4GB\n");
 		return -EINVAL;
 	}
 	/*
 	 * Limit remap size to MAX_SMI_DATA_BUF_SIZE + 8 (since the first 8
 	 * bytes are used for a semaphore, not the data buffer itself).
 	 */
-	remap_size = eps->num_of_4k_pages * PAGE_SIZE;
 	if (remap_size > MAX_SMI_DATA_BUF_SIZE + 8)
 		remap_size = MAX_SMI_DATA_BUF_SIZE + 8;
-	eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
-	if (!eps_buffer) {
-		dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map EPS buffer\n");
+
+	bios_buffer = memremap(bios_buf_paddr, remap_size, MEMREMAP_WB);
+	if (!bios_buffer) {
+		dev_warn(&dcdbas_pdev->dev, "found WSMT, but failed to map buffer\n");
 		return -ENOMEM;
 	}
 
 	/* First 8 bytes is for a semaphore, not part of the smi_data_buf */
-	smi_data_buf_phys_addr = eps->smm_comm_buff_addr + 8;
-	smi_data_buf = eps_buffer + 8;
+	smi_data_buf_phys_addr = bios_buf_paddr + 8;
+	smi_data_buf = bios_buffer + 8;
 	smi_data_buf_size = remap_size - 8;
 	max_smi_data_buf_size = smi_data_buf_size;
 	wsmt_enabled = true;
@@ -736,8 +753,8 @@ static void __exit dcdbas_exit(void)
 	 */
 	if (dcdbas_pdev)
 		smi_data_buf_free();
-	if (eps_buffer)
-		memunmap(eps_buffer);
+	if (bios_buffer)
+		memunmap(bios_buffer);
 	platform_device_unregister(dcdbas_pdev_reg);
 	platform_driver_unregister(&dcdbas_driver);
 }
-- 
2.18.1


Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943EEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F33C20665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4GHU2XO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIDSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:46:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7083C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:46:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so7831717wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SWh7AAYefil89ZJ7bkafwpIit9xPtQzztCSEaWWinXk=;
        b=R4GHU2XO233WvWj123EFcOxQbagWcj5fcJ5ynv8BKVTdOELTVscLlKocoLv/ogr1FT
         rmVZ96YiOVDqSund3PkLcbiQy5vWNQb/wMA3cgg13FmR5LSZ9dZOdNwEunLCYxZgW53n
         aPN3ldPm3TsgK4BcpBe4TOrulWW8FFVSFBNkTvszR4H06ikeqdJRc1QXE1piUtNn0ci4
         T1mtFbKh+YfMOHO0bUzY5oPL0irbCjqrwXByvJHNuLY8bqZaMLNf8N5mUnNW4gzFJV9j
         DP0KfwfLlp1qA1MR7kjoI8GPmDIZmPVwxs9YhBvhXspQWVm1CULgyHw8fnNd2PftAjcG
         sYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=SWh7AAYefil89ZJ7bkafwpIit9xPtQzztCSEaWWinXk=;
        b=E1vnZAcFuFVQU4Nep12oijanU9Piu5a8Q0dUxRvZTzGQlEdNuZXrfNi2kjSi38kAyr
         sQNsDJjtpY4nIC13c03LeopAB4WFlYmheBuAIvwYCxEBIa8fUucVYzRlxH26DLuWIm/q
         NHeKYR9mU6f5YeFxFyZLqo7g+Pre94AwZ2p3+l2ynjrjIIVs14Nf0q+iqJQ19XOx4cps
         6uaLNgr3QpobSCBNnHo90p84V1japm5R7310qT2jgzJPkZnHEVK1RyrDLdQ3O9Vr4lxS
         YpsVUHvJQJe/HwGBAIPfJLQ5+RlMtBUfrc2MJ+dfnLXMO1O7WWlLQh8Mva5gjYCdBKhS
         dEkA==
X-Gm-Message-State: AOAM533AkjEYRFXnhe70g78J2CjrQVIqGsqrwffFhZC068zPYAYayUUX
        CHq3eN7xby6punPQrsqrcV4kDEBJPjo=
X-Google-Smtp-Source: ABdhPJx+FqAzB9vCmbkTyGSaG/s9/q4WIfEBguHLwHX+U2HHUknQzZeNz5skzlqFVRR6rCtIkkpaoQ==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr9677452wrr.390.1599245188767;
        Fri, 04 Sep 2020 11:46:28 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q186sm14111670wma.45.2020.09.04.11.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:46:27 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/6] habanalabs: remove unused ASIC function pointer
Date:   Fri,  4 Sep 2020 21:46:19 +0300
Message-Id: <20200904184623.13478-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904184623.13478-1-oded.gabbay@gmail.com>
References: <20200904184623.13478-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old function pointer that was left when the call to this function pointer
was removed.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/habanalabs.h | 5 -----
 drivers/misc/habanalabs/gaudi/gaudi.c       | 1 -
 drivers/misc/habanalabs/goya/goya.c         | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b56410d75065..ec765320159a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -675,8 +675,6 @@ enum div_select_defs {
  *                    ASIC
  * @get_hw_state: retrieve the H/W state
  * @pci_bars_map: Map PCI BARs.
- * @set_dram_bar_base: Set DRAM BAR to map specific device address. Returns
- *                     old address the bar pointed to or U64_MAX for failure
  * @init_iatu: Initialize the iATU unit inside the PCI controller.
  * @rreg: Read a register. Needed for simulator support.
  * @wreg: Write a register. Needed for simulator support.
@@ -779,7 +777,6 @@ struct hl_asic_funcs {
 				u16 len, u32 timeout, long *result);
 	enum hl_device_hw_state (*get_hw_state)(struct hl_device *hdev);
 	int (*pci_bars_map)(struct hl_device *hdev);
-	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 	int (*init_iatu)(struct hl_device *hdev);
 	u32 (*rreg)(struct hl_device *hdev, u32 reg);
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
@@ -1874,8 +1871,6 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
 int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data);
-int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
-				u64 addr);
 int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 		struct hl_inbound_pci_region *pci_region);
 int hl_pci_set_outbound_region(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7946179632fb..483989500863 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6642,7 +6642,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.send_cpu_message = gaudi_send_cpu_message,
 	.get_hw_state = gaudi_get_hw_state,
 	.pci_bars_map = gaudi_pci_bars_map,
-	.set_dram_bar_base = gaudi_set_hbm_bar_base,
 	.init_iatu = gaudi_init_iatu,
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index fb7e4f50c198..804c83eb12b7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5377,7 +5377,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.send_cpu_message = goya_send_cpu_message,
 	.get_hw_state = goya_get_hw_state,
 	.pci_bars_map = goya_pci_bars_map,
-	.set_dram_bar_base = goya_set_ddr_bar_base,
 	.init_iatu = goya_init_iatu,
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
-- 
2.17.1


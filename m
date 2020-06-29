Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3F0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3555F2158C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mExcRW14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgF2VWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgF2Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7940C02E2CE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so8626116wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCTcGJHtSmaPBnZUOms/69xtZG01NEK1s+KL4aDek/0=;
        b=mExcRW14yTqdrE+npdERL83UBRuofRErdA5/zgO3vl9BxrfDKDkoQbWF20CyrH2IUS
         8UGyTrSsNjnnKbfg/JmvpnQmPPE+9II9m4mQ1g3abKPLo/CHKonJEB9B2KyTk40TL7zZ
         wJelDv5eKmyMI8SV1t20g5eXswq7iBjDP7X11tsetirsv9dUe16SDowmC7QpfiHTMG+x
         XvDbt0wa3fLD8MJ8wtrAGo1AQyLuSl7AIsI5m7XxErYSsKc6UKyp0O771NkG9DgFhEm6
         NN/AlfVVuxiSc3efXqK8IquWgOi6l6dGg0dGxvvifTk7+/navEyuFGkz6eRr2WYZVKZy
         IMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCTcGJHtSmaPBnZUOms/69xtZG01NEK1s+KL4aDek/0=;
        b=IWBdMMwAN+gjSGQrrv+xZmZfCFW2KDImMpRZ1EA8zvgVUlBvIm8oQXDcTH6kDLk8WH
         D+0PHXmjWEBI4q45Z2VAxYD8An+HnnHw4R/kxknyeGh9lEtLMjdqg/3yg1pqWiyEfHbg
         zWivR/vEGpzmoK5zx+ZR2AQfhosR32bvhZUpcUiEdisnlegG3I8zxBEuFvyByapm2l7E
         jvEyvuW8hQm8E44DuOyHHzqPGGvPVNCUCQOeAPwJ+LOYjwqTfhA6o426EU+bjMaH6JSr
         kNQRwxp6GeYcThpEgA60n1chrQ6jWhZT2/r1N6J4dqEzLpcz5IWQcFFetLAmELhWhHQ1
         qgrQ==
X-Gm-Message-State: AOAM531OhwK+SClB/+COtbTJHh1w/3v1CRVT5MkbCFqjlTlI2KzuQtpp
        qBGBXlm/5XmvqeboJRg8XT9f7Q==
X-Google-Smtp-Source: ABdhPJygUbnUrJAbW4jXvLREPQuFQ/kwh1F2Ffox4kxTw9ORCJFsMC95XOvyQ46XY78Axn7iLPLN1w==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr17264874wrw.370.1593439493674;
        Mon, 29 Jun 2020 07:04:53 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 06/20] misc: habanalabs: goya: Omit pointless check ensuring addr is >=0
Date:   Mon, 29 Jun 2020 15:04:28 +0100
Message-Id: <20200629140442.1043957-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing as 'addr' is unsigned, it would be impossible for the assigned
value to be anything other than zero or positive.

Squashes the following W=1 warnings:

 drivers/misc/habanalabs/goya/goya.c: In function ‘goya_debugfs_read32’:
 drivers/misc/habanalabs/goya/goya.c:3945:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
 3945 | } else if ((addr >= DRAM_PHYS_BASE) &&
 | ^~
 drivers/misc/habanalabs/goya/goya.c: In function ‘goya_debugfs_write32’:
 drivers/misc/habanalabs/goya/goya.c:4002:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
 4002 | } else if ((addr >= DRAM_PHYS_BASE) &&
 | ^~
 drivers/misc/habanalabs/goya/goya.c: In function ‘goya_debugfs_read64’:
 drivers/misc/habanalabs/goya/goya.c:4047:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
 4047 | } else if ((addr >= DRAM_PHYS_BASE) &&
 | ^~
 drivers/misc/habanalabs/goya/goya.c: In function ‘goya_debugfs_write64’:
 drivers/misc/habanalabs/goya/goya.c:4091:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
 4091 | } else if ((addr >= DRAM_PHYS_BASE) &&
 | ^~
 drivers/misc/habanalabs/pci.c:328: warning: Excess function parameter 'dma_mask' description in 'hl_pci_set_dma_mask'
 drivers/misc/habanalabs/goya/goya_coresight.c: In function ‘goya_debug_coresight’:
 drivers/misc/habanalabs/goya/goya_coresight.c:643:6: warning: variable ‘val’ set but not used [-Wunused-but-set-variable]
 643 | u32 val;
 | ^~~

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/goya/goya.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0d2952bb58dfb..a4a20e27ed3b4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3942,8 +3942,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 		*val = readl(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
 				(addr - SRAM_BASE_ADDR));
 
-	} else if ((addr >= DRAM_PHYS_BASE) &&
-			(addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size)) {
+	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
 
 		u64 bar_base_addr = DRAM_PHYS_BASE +
 				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
@@ -3999,8 +3998,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 		writel(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
 					(addr - SRAM_BASE_ADDR));
 
-	} else if ((addr >= DRAM_PHYS_BASE) &&
-			(addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size)) {
+	} else if (addr < DRAM_PHYS_BASE + hdev->asic_prop.dram_size) {
 
 		u64 bar_base_addr = DRAM_PHYS_BASE +
 				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
@@ -4044,9 +4042,8 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 		*val = readq(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
 				(addr - SRAM_BASE_ADDR));
 
-	} else if ((addr >= DRAM_PHYS_BASE) &&
-		   (addr <=
-		    DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64))) {
+	} else if (addr <=
+		   DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
 
 		u64 bar_base_addr = DRAM_PHYS_BASE +
 				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
@@ -4088,9 +4085,8 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 		writeq(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
 					(addr - SRAM_BASE_ADDR));
 
-	} else if ((addr >= DRAM_PHYS_BASE) &&
-		   (addr <=
-		    DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64))) {
+	} else if (addr <=
+		   DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64)) {
 
 		u64 bar_base_addr = DRAM_PHYS_BASE +
 				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
-- 
2.25.1


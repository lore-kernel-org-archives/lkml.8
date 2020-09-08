Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89883C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584AA207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wDOiidQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgIHUEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9AC09B04F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:19:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so19500067wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3z8ewx/ZRDSN9alYRV1GNbpM8nlpU8ozO9MS5G5Yh6E=;
        b=wDOiidQ2OMXWHXErJkSC//k9rNMkPjKCsh0kCoDcDQ7I4wBdVBmw/53WjBfmc0S/zF
         z4+bOBwfdB8CG/d120sIqdXklHCLwSYlSIsddndpa6bQPyUsudOnAWIy7HJ3r5dQJqUr
         sfCrz+fpUMMCk6ymbFmsi65sR17m7gOVYc6J7EIfwrROdKShHKqA7kPwc6qfFCoIKQcm
         zbhPZJjteaQq6e7RKBO1qIBR4l/Ff78YdM9SDoXiRPNCsBwiPgv+2i/YhAq2NBbSoTzy
         b8v3s9TzVTGmhE6Tp1CEtFAu4+Znw3cdD45XPKL/uP80PpXi+CI7AJIL1C4MNSs9Crik
         p2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3z8ewx/ZRDSN9alYRV1GNbpM8nlpU8ozO9MS5G5Yh6E=;
        b=NWCToSKyp+Pk55o8zThRJX/oxlTb7KkWyg7gKk8qOs74yqWJ8d3k55n1HoWoUT2X8X
         qrdj7XnKc6+r1P1tCsUAyCjvcdC4UNw2l/MEaudj96zQLbc8PAY2xAJTsR1LaaQA4BzO
         Rv4ntTgd4HwctYtxBPxnTAa/l/P/rtNq7sJ5j0CWcS7Cl/aLG7POwWiLQvfTbQY5oFUM
         ld/mKUaPOw1kfC+KBBFuH7I0pQMaYWUnX8VT+6CcZL94K7vYjfslArEk+xfUrFx5OwTx
         7c0kHnkyE/+xFOdgAOPLFKkPq+e7igKfE9CwxTTRlNYHSoF/wMGzwchsad/JSKrDKLxF
         fGIw==
X-Gm-Message-State: AOAM533s0nGI7G3Agf1HmrqlZlwuHlwknTGi5sqVnR/NOGsOrXSqxnXZ
        1/N48+Bpn7R++gRiv70M4aU3Pw==
X-Google-Smtp-Source: ABdhPJw9PhMfql/HCXy219kI4xjVlQ2JDvbSsD9uFg37fWGjczy3ofVC8EMawYpaXn0CvZsQro+EIQ==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr128489wrn.47.1599578339377;
        Tue, 08 Sep 2020 08:18:59 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id d25sm10004886wra.25.2020.09.08.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:18:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/5] iommu/io-pgtable-arm: Add BROKEN_NS quirk to disable shareability on ARM LPAE
Date:   Tue,  8 Sep 2020 17:18:49 +0200
Message-Id: <20200908151853.4837-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908151853.4837-1-narmstrong@baylibre.com>
References: <20200908151853.4837-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coherency integration of the IOMMU in the Mali-G52 found in the Amlogic G12B SoCs
is broken and leads to constant and random faults from the IOMMU.

Disabling shareability completely fixes the issue.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 ++++---
 include/linux/io-pgtable.h     | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dc7bcf858b6d..d2d48dc86556 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -440,7 +440,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
 
-	if (prot & IOMMU_CACHE)
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_BROKEN_SH)
+		pte |= ARM_LPAE_PTE_SH_NS;
+	else if (prot & IOMMU_CACHE)
 		pte |= ARM_LPAE_PTE_SH_IS;
 	else
 		pte |= ARM_LPAE_PTE_SH_OS;
@@ -1005,8 +1007,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	struct arm_lpae_io_pgtable *data;
 
-	/* No quirks for Mali (hopefully) */
-	if (cfg->quirks)
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_BROKEN_SH))
 		return NULL;
 
 	if (cfg->ias > 48 || cfg->oas > 40)
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 23285ba645db..efb9c8f20909 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -86,6 +86,9 @@ struct io_pgtable_cfg {
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
 	 *	for use in the upper half of a split address space.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_BROKEN_SH: (ARM LPAE format) Disables shareability
+	 *	when coherency integration is broken.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -93,6 +96,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
+	#define IO_PGTABLE_QUIRK_ARM_BROKEN_SH	BIT(6)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.22.0


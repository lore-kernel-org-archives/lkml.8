Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62164C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345E820838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="eINJVtQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgBCQSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:18:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35401 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgBCQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:18:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so14784500qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ptdL8j4y4Nu0slWC9GMlqw2vupDc3jE8cCzq/d6QOxo=;
        b=eINJVtQOFasRcQUUhrRypp1cvIgGSB2uv66wDqp4LEqIw+IxE8nZFh8zR1m5xpcBNs
         asYRxtDshmiHoSfr1mRX75C2UKBJu2rdW11q9+Bv/5yr2fbQHpAax5CNnqgsso8HZU0v
         UyOp9uDe8Q5dKeQmicM7GjESp/71ZeaA3EeFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ptdL8j4y4Nu0slWC9GMlqw2vupDc3jE8cCzq/d6QOxo=;
        b=JWuuhIeFbl8KqjMlC9dafQksESLK8McmOp6F7OJu+rbHr3Rp7kQHFmfwznMcvxpgMZ
         ggojT271HOdxL0tsR9bYXrY7q68v8keDkRy16+prw9saCzuWyBdM9fqq6DVtsQj6N2ku
         NDtKNesw0DFjnUqMf2tHXKuFJnsKhmrTZg7zH4tuwTzLl1X9CuOVE2qDY+zLaAs7i+AD
         hkHo6lHZn5t6NQLQvKY4NmqEaPx3+fTmIbnisacYDqqb7J66dAz/Nizz8blcp8u5iOdH
         QhcdmBkyVn0IPLrmtoD9bnYonH68H8kENjJOtchsc6YPfY6rYs23CjrCF1Ty/yi8OiQN
         Ol+A==
X-Gm-Message-State: APjAAAVsTB88Y2BJqOwPZKejra0l5SrmrIB3hwKfJzIlVCRAG2qFGGN1
        3pcV+Rqm4AwdicxEBgMHo7gb
X-Google-Smtp-Source: APXvYqxDPyKmX7Xb7xJg3h+x7fg95e7oQwGe6vGn9t+4Xg/mY5Q8WpzfOarZKicAK8elQfsAEGxyDw==
X-Received: by 2002:a05:620a:306:: with SMTP id s6mr22664268qkm.469.1580746719156;
        Mon, 03 Feb 2020 08:18:39 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
        by smtp.gmail.com with ESMTPSA id 8sm9530476qkm.92.2020.02.03.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:18:38 -0800 (PST)
From:   Tianlin Li <tli@digitalocean.com>
To:     kernel-hardening@lists.openwall.com
Cc:     keescook@chromium.org, Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tianlin Li <tli@digitalocean.com>
Subject: [PATCH v2] drm/radeon: have the callers of set_memory_*() check the return value
Date:   Mon,  3 Feb 2020 10:18:27 -0600
Message-Id: <20200203161827.768-1-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now several architectures allow their set_memory_*() family of  
functions to fail, but callers may not be checking the return values.
If set_memory_*() returns with an error, call-site assumptions may be
infact wrong to assume that it would either succeed or not succeed at  
all. Ideally, the failure of set_memory_*() should be passed up the 
call stack, and callers should examine the failure and deal with it. 

Need to fix the callers and add the __must_check attribute. They also 
may not provide any level of atomicity, in the sense that the memory 
protections may be left incomplete on failure. This issue likely has a 
few steps on effects architectures:
1)Have all callers of set_memory_*() helpers check the return value.
2)Add __must_check to all set_memory_*() helpers so that new uses do  
not ignore the return value.
3)Add atomicity to the calls so that the memory protections aren't left 
in a partial state.

This series is part of step 1. Make drm/radeon check the return value of  
set_memory_*().

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
v2:
The hardware is too old to be tested on and the code cannot be simply
removed from the kernel, so this is the solution for the short term. 
- Just print an error when something goes wrong
- Remove patch 2.  
v1:
https://lore.kernel.org/lkml/20200107192555.20606-1-tli@digitalocean.com/
---
 drivers/gpu/drm/radeon/radeon_gart.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index f178ba321715..a2cc864aa08d 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -80,8 +80,9 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_uc((unsigned long)ptr,
-			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (set_memory_uc((unsigned long)ptr,
+			      rdev->gart.table_size >> PAGE_SHIFT))
+			DRM_ERROR("set_memory_uc failed.\n");
 	}
 #endif
 	rdev->gart.ptr = ptr;
@@ -106,8 +107,9 @@ void radeon_gart_table_ram_free(struct radeon_device *rdev)
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_wb((unsigned long)rdev->gart.ptr,
-			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (set_memory_wb((unsigned long)rdev->gart.ptr,
+			      rdev->gart.table_size >> PAGE_SHIFT))
+			DRM_ERROR("set_memory_wb failed.\n");
 	}
 #endif
 	pci_free_consistent(rdev->pdev, rdev->gart.table_size,
-- 
2.17.1


Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8549D20792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG0VvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:51:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34105 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgG0Vu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id x69so16842699qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xf8u112G9B6jocNxpIpSZ5Ma8y1M/w5PTt/UgbiI4/s=;
        b=ZMsuDCfx/ThSZIAky4LIzEagGIbw1+E/u0IhdmOr/fR3FNrCqxQmVtUgRlhfYmAEdj
         QmjukLET29BMQ5E4vNm0TzGWDXlvux4qrKPZO+WwlbLNry0u4e2WLn8XH/GcEZ3hiKZB
         vNKSHQ8Hw9YutZwytIUNAlU/k946KxdUmVEXJ+c9uyWury7d3QlyGOqLXU6AfQBrjMWe
         zQ5VSkNio0uHwbcOkIrDzZ8l8vpzrejluxEUVJTcUm67PzQ7RCTZx7PwkOW7t41sJ65H
         O7DoNwf3ttoAnItL96ISt4Omu4+XlHGIGrQV+Yi1vfBTQ89lNZyOPMhALR89qGOQr1cD
         dayA==
X-Gm-Message-State: AOAM532/a4WFPbPKtd1GvwsE82i/5P/QN0p1CBtyk6gF2fXBjSvID5vD
        hpAAwPsnFyBHrRjEFB62fsYIl5R9
X-Google-Smtp-Source: ABdhPJwvTNjzxaJ0CBPfM3l41ojSWKcAqqK56y4tzPDyZNZNMTf7NEpoWfiFkmQt/TeswMFwR10T5w==
X-Received: by 2002:a37:6482:: with SMTP id y124mr25625811qkb.470.1595886655245;
        Mon, 27 Jul 2020 14:50:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] x86/kaslr: Clean up slot handling
Date:   Mon, 27 Jul 2020 17:50:46 -0400
Message-Id: <20200727215047.3341098-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of slots and slot areas can be unsigned int, since on 64-bit,
the maximum amount of memory is 2^52, the minimum alignment is 2^21, so
the slot number cannot be greater than 2^31. The slot areas are limited
by MAX_SLOT_AREA, currently 100. Replace the type used for slot number,
which is currently a mix of int and unsigned long, with unsigned int
consistently.

Drop unnecessary check that number of slots is not zero in
store_slot_info, it's guaranteed to be at least 1 by the calculation.

Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
find_random_virt_addr, it cannot change the result: the largest valid
slot is the largest n that satisfies

  minimum + n * CONFIG_PHYSICAL_ALIGN + image_size <= KERNEL_IMAGE_SIZE

(since minimum is already aligned) and so n is equal to

  (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN

even if image_size is not aligned to CONFIG_PHYSICAL_ALIGN.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 36 ++++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 29ec964b1330..ffbcc0444f70 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -511,16 +511,14 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 
 struct slot_area {
 	unsigned long addr;
-	int num;
+	unsigned int num;
 };
 
 #define MAX_SLOT_AREA 100
 
 static struct slot_area slot_areas[MAX_SLOT_AREA];
-
-static unsigned long slot_max;
-
-static unsigned long slot_area_index;
+static unsigned int slot_area_index;
+static unsigned int slot_max;
 
 static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 {
@@ -530,13 +528,10 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 		return;
 
 	slot_area.addr = region->start;
-	slot_area.num = (region->size - image_size) /
-			CONFIG_PHYSICAL_ALIGN + 1;
+	slot_area.num = 1 + (region->size - image_size) / CONFIG_PHYSICAL_ALIGN;
 
-	if (slot_area.num > 0) {
-		slot_areas[slot_area_index++] = slot_area;
-		slot_max += slot_area.num;
-	}
+	slot_areas[slot_area_index++] = slot_area;
+	slot_max += slot_area.num;
 }
 
 /*
@@ -589,8 +584,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 
 static unsigned long slots_fetch_random(void)
 {
-	unsigned long slot;
-	int i;
+	unsigned int slot, i;
 
 	/* Handle case of no slots stored. */
 	if (slot_max == 0)
@@ -603,7 +597,7 @@ static unsigned long slots_fetch_random(void)
 			slot -= slot_areas[i].num;
 			continue;
 		}
-		return slot_areas[i].addr + slot * CONFIG_PHYSICAL_ALIGN;
+		return slot_areas[i].addr + (unsigned long)slot * CONFIG_PHYSICAL_ALIGN;
 	}
 
 	if (i == slot_area_index)
@@ -819,28 +813,24 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	if (process_efi_entries(minimum, image_size))
-		return slots_fetch_random();
+	if (!process_efi_entries(minimum, image_size))
+		process_e820_entries(minimum, image_size);
 
-	process_e820_entries(minimum, image_size);
 	return slots_fetch_random();
 }
 
 static unsigned long find_random_virt_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
-	unsigned long slots, random_addr;
-
-	/* Align image_size for easy slot calculations. */
-	image_size = ALIGN(image_size, CONFIG_PHYSICAL_ALIGN);
+	unsigned int slots;
+	unsigned long random_addr;
 
 	/*
 	 * There are how many CONFIG_PHYSICAL_ALIGN-sized slots
 	 * that can hold image_size within the range of minimum to
 	 * KERNEL_IMAGE_SIZE?
 	 */
-	slots = (KERNEL_IMAGE_SIZE - minimum - image_size) /
-		 CONFIG_PHYSICAL_ALIGN + 1;
+	slots = 1 + (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN;
 
 	random_addr = kaslr_get_random_long("Virtual") % slots;
 
-- 
2.26.2


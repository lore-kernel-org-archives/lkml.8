Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBEDC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545CE206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kjBiP+F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBMRgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:36:43 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43291 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgBMRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:36:43 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so2976870qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O0HHfKHIMlC0RjUcckPaUV2bXRGbWu90N+8L8NiO3VY=;
        b=kjBiP+F3hV0eEn1QW0XYHbEKbm/EmTOaUFbFEJ7s0yyrhmHX4masMc+lyAJrxjljV1
         14mpFaF5/lOF/RDUrA4bn85pFWB9fL1AmduugFYFoe7xQJcFXOXvq32/Oe+y+7x0b+72
         S4bNcG1TuHk/Sxn+dmQlTQnjqznoue8EKQXHDELcC3iTKccMEakh5DI9yMXf6e3D/BY/
         ky5GksqbaNYXuBvWpIOw8qVoAkA0RlBG6a8661TmgaZqkS5dArhkK7nhUfM8vv/TSNSr
         a6ic5JeiGOdSJtYgvJBEMsqZpCgv0NsdorcWTQy/DPau/v8LY0evhhLYEUZObkD3Up1t
         5ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O0HHfKHIMlC0RjUcckPaUV2bXRGbWu90N+8L8NiO3VY=;
        b=Mi2ReyZqT/JQBP8n4oC15xPm/c93fA8BWq4cqMCnJuYd3C8byAJsw4WB1Cu3I9cSR/
         XLZPCkNhjBEylXj6zsBf8FfwAXMG7cu8veD8bivBe1wBnS3pbgHY3XO2gPyjBa29jr7T
         yldZtfA6M1c/XmWhr/jpkgbyBYCEBjFo87e5jSHP9hnswEeGWZBb82/x8Y04TA1pXLtn
         eCI8SYFd8vafW/qgnbix1sI4glSguRybmHqjZT34uOz/kUXBCi9Btflq+cnUDrZv0fbz
         Mr9pcDIw0H3DSH3iOVNtkbuvKpmX8+pEiTggfeNUu1XAau5j1x6RM+GvzGhd4R7r4irY
         SVVw==
X-Gm-Message-State: APjAAAVbY6vK0DOIvRLFx/rBoA7Bkr1Eox30HPEQcL/puioS8CBmIz7L
        jfF1WeOgFX0abMC42mnmP1nZKQ==
X-Google-Smtp-Source: APXvYqzjjdyf+MJULWzPS8PZx6PvEQ2smSMkicTbCD90d06Eu4erfG/EMBgRqee484nSEbCgR/viSA==
X-Received: by 2002:ad4:5888:: with SMTP id dz8mr12736260qvb.204.1581615400917;
        Thu, 13 Feb 2020 09:36:40 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 65sm1795043qtc.4.2020.02.13.09.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 09:36:40 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/kmemleak: annotate various data races obj->ptr
Date:   Thu, 13 Feb 2020 12:36:30 -0500
Message-Id: <1581615390-9720-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of object->pointer could be accessed concurrently as noticed
by KCSAN,

 write to 0xffffb0ea683a7d50 of 4 bytes by task 23575 on cpu 12:
  do_raw_spin_lock+0x114/0x200
  debug_spin_lock_after at kernel/locking/spinlock_debug.c:91
  (inlined by) do_raw_spin_lock at kernel/locking/spinlock_debug.c:115
  _raw_spin_lock+0x40/0x50
  __handle_mm_fault+0xa9e/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffffb0ea683a7d50 of 4 bytes by task 839 on cpu 60:
  crc32_le_base+0x67/0x350
  crc32_le_base+0x67/0x350:
  crc32_body at lib/crc32.c:106
  (inlined by) crc32_le_generic at lib/crc32.c:179
  (inlined by) crc32_le at lib/crc32.c:197
  kmemleak_scan+0x528/0xd90
  update_checksum at mm/kmemleak.c:1172
  (inlined by) kmemleak_scan at mm/kmemleak.c:1497
  kmemleak_scan_thread+0xcc/0xfa
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 write to 0xffff939bf07b95b8 of 4 bytes by interrupt on cpu 119:
  __free_object+0x884/0xcb0
  __free_object at lib/debugobjects.c:359
  __debug_check_no_obj_freed+0x19d/0x370
  debug_check_no_obj_freed+0x41/0x4b
  slab_free_freelist_hook+0xfb/0x1c0
  kmem_cache_free+0x10c/0x3a0
  free_object_rcu+0x1ca/0x260
  rcu_core+0x677/0xcc0
  rcu_core_si+0x17/0x20
  __do_softirq+0xd9/0x57c
  run_ksoftirqd+0x29/0x50
  smpboot_thread_fn+0x222/0x3f0
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 read to 0xffff939bf07b95b8 of 8 bytes by task 838 on cpu 109:
  scan_block+0x69/0x190
  scan_block at mm/kmemleak.c:1250
  kmemleak_scan+0x249/0xd90
  scan_large_block at mm/kmemleak.c:1309
  (inlined by) kmemleak_scan at mm/kmemleak.c:1434
  kmemleak_scan_thread+0xcc/0xfa
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

crc32() will dereference object->pointer. If a shattered value was
returned due to a data race, it will be corrected in the next scan.
scan_block() will dereference a range of addresses (e.g., percpu
sections) to search for valid pointers. Even if a data race heppens, it
will cause no issue because the code here does not care about the exact
value of a non-pointer. Thus, mark them as intentional data races using
the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: add a missing annotation.

 mm/kmemleak.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 3a4259eeb5a0..aa6832432d6a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1169,7 +1169,12 @@ static bool update_checksum(struct kmemleak_object *object)
 	u32 old_csum = object->checksum;
 
 	kasan_disable_current();
-	object->checksum = crc32(0, (void *)object->pointer, object->size);
+	/*
+	 * crc32() will dereference object->pointer. If an unstable value was
+	 * returned due to a data race, it will be corrected in the next scan.
+	 */
+	object->checksum = data_race(crc32(0, (void *)object->pointer,
+					   object->size));
 	kasan_enable_current();
 
 	return object->checksum != old_csum;
@@ -1243,7 +1248,7 @@ static void scan_block(void *_start, void *_end,
 			break;
 
 		kasan_disable_current();
-		pointer = *ptr;
+		pointer = data_race(*ptr);
 		kasan_enable_current();
 
 		untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
-- 
1.8.3.1


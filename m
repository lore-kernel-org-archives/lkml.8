Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5EE20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YXpNNOp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgBKQYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:24:18 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42256 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbgBKQYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:24:18 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so5234285qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 08:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wLPl/cstzWTeMlUQRCBJAM9GpFQjWbFFR3GkPG8wzQ4=;
        b=YXpNNOp7JzrPirfuXj4Fw25ulXJOqSKTXSPMTVYD9fnCBtHtOGvBwQrHPCC3N8K77O
         B1nOurTpEqdnUGs/JUG4AS3TKNe1cQjqkHH8YZxwy6BYHb5vIKSqnOnKvYwn5FLAt9uY
         u5pdbKDdsbXdPFPBu6Rleu1Np1Nepu3O3Hfn+v3pRY3uv/K4nd5mWQ8pIS/5Sc257iLm
         9q9ak1rO4E8PK0mfS8gyzF2o55Mv11UBU7bdPD4TLLSj1mIm/Eru1KA3tTovFGVOAc1m
         5EDP2K3WtRMkMKhq4Te52he7Zms7OHmkZxoTfz5ltoRnv2TdY65neO41fWQ1ngljxVN6
         ZyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wLPl/cstzWTeMlUQRCBJAM9GpFQjWbFFR3GkPG8wzQ4=;
        b=blcd1moFH1hsUkrbY8xnUl3uRkMGW5LNRSBitwpNBVk1OYXu46+bsVeVu51DDQMEne
         a3nW4OiKSeN1/ywYZkSDJBrAZoH97y3hRDoNxsxkyHoO3H8zhST41pN+e+NNVR4q64sG
         2i+2SLI7jYr+deZIqXv4G52aPzjv0CYbaecstNqlyT9QQA0fq4l/B6KBylB1Tk3Z8r0A
         SByopz4TvExIS4n8LfOZKvWQOqA0gvVPhliNI86R6tX4ysnm+BVnpcOMMoT/mOTNwBTb
         Jubcx+yI9gbPoN0dB4QpQSVU1/P12YVs7Nn129VtUaKGosRUcx6oIkIg1g20oIGeaKtY
         V9+w==
X-Gm-Message-State: APjAAAW/0j8nPWn3tFI9H183hukg8eXPawVkJisfs0Nl6G3jMnpRGRLr
        EJhkflKzIhScGx9xwu5PVHO9tw==
X-Google-Smtp-Source: APXvYqzs+bk5h6W/Qj9KvzQVLRqIJFLobB26Q9E2sfed40GYLzcTZmIP0wnbXsGmesBTAwmcsiz69g==
X-Received: by 2002:a0c:eac7:: with SMTP id y7mr3695907qvp.86.1581438257600;
        Tue, 11 Feb 2020 08:24:17 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k4sm2315242qtj.74.2020.02.11.08.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2020 08:24:17 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/kmemleak: annotate a data race in checksum
Date:   Tue, 11 Feb 2020 11:24:05 -0500
Message-Id: <1581438245-24391-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of object->pointer could be accessed concurrently as noticed
by KCSAN,

 BUG: KCSAN: data-race in crc32_le_base / do_raw_spin_lock

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

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 60 PID: 839 Comm: kmemleak Tainted: G        W    L 5.5.0-next-20200210+ #3
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

crc32() will dereference object->pointer. If a shattered value was
returned due to a data race, it will be corrected in the next scan.
Thus, annotate it as an intentional data race using the data_race()
macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kmemleak.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 3a4259eeb5a0..25b4bcc32b5f 100644
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
-- 
1.8.3.1


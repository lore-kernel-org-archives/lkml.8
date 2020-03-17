Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29126C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022AB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="X7ZelAWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgCQNWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:22:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35789 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgCQNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:22:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id d8so32331244qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BooTS55gW36ai8J66FC6mGTgbiGzFCkI2TXTYLHqnGc=;
        b=X7ZelAWQ7nwxsy3GpfF6lmDBp6gFzEiRnpdbJeR5mX4XlZoTsXc6NA+BAlwT+LQbHS
         v18rFiFdYOYZArh7/h+1Ep/e9Uiw/i+uJbx7cQiv5K/+Li7B2vXeJ8qO0bP+N/AisdJ4
         6Rzzq3kigFAVb4f6HrCuoEo4o7bCcJn4cl2Fy9h9ie58oR29vnGLqwHeaXrm0mZumdq9
         ZWFTgEB2UOopuQRtzfywlfwXrsRTiur8omjm8TkteWXFSr2czztQ0kDyBZdXQdZ7IdHz
         NlvkTGz8ObmjeUdBT5RscuificYkpq4keZx5YLC1xFfrdX0W8ZDqNFeqOftZjIX6GcJJ
         kUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BooTS55gW36ai8J66FC6mGTgbiGzFCkI2TXTYLHqnGc=;
        b=ZHGuQjUJvNy+fvlgT7ve1iN9EFsXWDTTlre/WF3hRKf+qmaicPwmGfSHY2vz6Wpp6Z
         smdHd+k48rgARwQu/nr+/X2/fdJmYlpbSfM0SQGs2nx8CBLkOuibqK8gQxn0JO8h1TK4
         hfsD4pNKAlqxUOEwZmn5ayNbuGZGUL+7cv9aP6vthVS7LXTUN0CttK+CK/N9x54KrKX3
         jmgbPioWGk+DCjaY+BUAG7WQ2KArFI3UiejgekjZZ0iiXmI4N7vbI//0zPHccjGcQ2g7
         Dko5PxEFmM/Wd+eNM1uHvwkSmVWC7ZKL1LwHfrkX9tqC8dGhYTKh7xrcX0rQrrUuEknU
         i/mA==
X-Gm-Message-State: ANhLgQ1cfEdXbmrv1a80swcHe8ntplHkf46YIH3gaiixWjBhTPEIgWtl
        aQ9KEd+XB6nuwEI//HXb04dkOA==
X-Google-Smtp-Source: ADFU+vuoeqGw++ekYdgJ3cqO5Fw6bRoSYhCb6wK/ilXVoC2TYGulSobvHJm1dWdUV+euKh4JCX8JPg==
X-Received: by 2002:a05:620a:21ce:: with SMTP id h14mr4469320qka.363.1584451324432;
        Tue, 17 Mar 2020 06:22:04 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d13sm2093752qto.33.2020.03.17.06.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 06:22:03 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/kmemleak: annotate a data race in checksum
Date:   Tue, 17 Mar 2020 09:21:57 -0400
Message-Id: <20200317132157.1272-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if KCSAN is disabled for kmemleak, update_checksum() could still
call crc32() (which is outside of kmemleak.c) to dereference
object->pointer. Thus, the value of object->pointer could be accessed
concurrently as noticed by KCSAN,

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

If a shattered value was returned due to a data race, it will be
corrected in the next scan. Thus, annotate it as an intentional data
race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kmemleak.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e362dc3d2028..d3327756c3a4 100644
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
2.21.0 (Apple Git-122.2)


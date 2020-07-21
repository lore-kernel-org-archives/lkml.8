Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B62620714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ll1B1CDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgGUKbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgGUKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:30:48 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCAC0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:48 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id v4so5808414wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ikYXLHhML1V0ebfQAy4A07GGk0dvPdarKLZgU/LHY8=;
        b=Ll1B1CDJ7KhvtRWHa99+JHlf54xff9v1gzaVfJnVQ6BvfNllw/H4GTkWGKnG/V0iA7
         X4KB+Y+XgMZjZ79KBaIPQlNJ6v3mkrXIKghZ89OSIEJtdWHjMXjW5E6+npezzxHqPdR8
         6ac4mUL+KbcjKvsg/EHSn0BoSgz4dZ/JfnGxU6nifSB77LgrCFngtRsBhR9Ehu9WaVBE
         LLtgGeO4Znx4q1Xawr65MyTx9Hv4FClfqSXl+hfPAIIs3ykmODLk8+j1qKWGCp0MBljZ
         OoYR75bTlm3WU9kjA+aU8pMpR7nt6aRUlkeXEfWq7mq+EjrxyJayil/a2pOx8/Sal5cV
         dlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ikYXLHhML1V0ebfQAy4A07GGk0dvPdarKLZgU/LHY8=;
        b=HRgye4SbP0G+/QgejWXVP/6WniSbHFrqTRI/qbmKY3RLOgyt3GuUXoRPvDgHl7aT4I
         PvZKWVnTr7M1CkyfWWHfA3dwExnUsHbZqlzB+lQsT/gmNn1DhkrV2C75hUCT5VTRuhPv
         JX8N21SALICN4XZeGdAKyj9QDCNmH3Y3VXsZTLY2V/U7WLfP0VOh5N1dMRtRWuQ1PsE5
         q4sJWP4cbt/1h/iZKuprpkeyAsNoYrmN4pnZj63V5gu8csqtYzOq6gKUpQR/pqeOfo+H
         LMRGVDeWqwXFVpsYyjHNsYjBv4wXGS+rrh2Rmssmi63hdAWNwe3STJ26oTsVEfxci7ht
         5IMQ==
X-Gm-Message-State: AOAM531fO0CtMzPRfGjjLnJhqedxa9h/CE4Vse7cwOfMCMeGj0AyMCr4
        pgVkDw+fP+wM9nXegyoIpI5GMpuiTw==
X-Google-Smtp-Source: ABdhPJy+pMLYd9uyp3mCBJY0DYGtdOmtX8zBL4UIkfuGg+OekMUs5/AqzmECnb0r/wVB6t89Rl6g9YCfOw==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr3762023wmg.68.1595327447092;
 Tue, 21 Jul 2020 03:30:47 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:15 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-8-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 7/8] asm-generic/bitops: Use instrument_read_write() where appropriate
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new instrument_read_write() where appropriate.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/bitops/instrumented-atomic.h     | 6 +++---
 include/asm-generic/bitops/instrumented-lock.h       | 2 +-
 include/asm-generic/bitops/instrumented-non-atomic.h | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index fb2cb33a4013..81915dcd4b4e 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -67,7 +67,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -80,7 +80,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -93,7 +93,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index b9bec468ae03..75ef606f7145 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -52,7 +52,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
-	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 20f788a25ef9..f86234c7c10c 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -68,7 +68,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +82,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +96,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog


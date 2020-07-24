Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45425C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B6520714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URAz3B9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgGXHAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgGXHAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:00:38 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB57C0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:00:38 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id y204so3620151wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nzPB/8gD7tiXvmPnGkXWvRfHEEqZYmZWnzjoz4lCFa4=;
        b=URAz3B9pmI3bMj/6AQUMnQQhW0rplCGsl7EloPnKMvSTNGhtNnCDfpGQ/8+TWhN/lS
         eu93QjVcDkQhVrqUknfjSvB0XOajZEZToOyVflz40sULKVkXx6GdG2Jl9RetHholLscb
         PoV5V60V4M9lw/Srge2zKAj1zk8uQFxfbooBj805sbbIK/sv+2won75T8Ek6ZGQN9uEK
         4+p+bDebrCVEHu50+mjp7zz0MS0fpWFGfLHruk2rEJmQEiqiXAcTlPldK0MredKRg7Tu
         hIeWfrLaMilSJpOi81uGZWmzYRa14TOKhpPwhFvIXdYF90TU+Nm8AI28zeAGN4zl+ncI
         mmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nzPB/8gD7tiXvmPnGkXWvRfHEEqZYmZWnzjoz4lCFa4=;
        b=DPdnI6hfocQ613QiKJWG1iGnz8pDvvgiqsYSybAIEcmYsvgHjuKFiYA4Ph5qKdbKCg
         4tpf/1F0GV3HP+83Ez0oDxfV22jRops1ggKKfvrosf51umCyRMxWcPdJ0ZXVIsvOIcFi
         WWynvVaG01brC7W9gLNzu8hC3f8a9pPYIRtTzChCqKHOleLd2evDBij7orwXVt3aQJS/
         VTIJVMnwhoZ+4U9Ha8ZTnNZghO9tBV8EnpM/7RiqF0+53Dh1eI/ZdPntIIRM8z0Q8NLq
         U5GbKURa3+TAPN7nNWR4KhdhilgUzElB5hjQeQKxT4Ug21yxxRj4zGekLGw4ArqVIjVP
         OOFw==
X-Gm-Message-State: AOAM530MblObt+YXH6rqVytauFIvIFPhwygAxFP9JqD6cwFYgKBR7cFm
        KAKjUUyYGbTqBGTAhqCyP/XqU8bchQ==
X-Google-Smtp-Source: ABdhPJx2JoNHbcPJzjn4ZQvYwamZ3dXW5+J9rF1Ytf7+0vXB5i7gS14K5hdGsJuzH9+fJNjTZ5Y2F4/QdQ==
X-Received: by 2002:adf:e805:: with SMTP id o5mr7608214wrm.419.1595574036687;
 Fri, 24 Jul 2020 00:00:36 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:00:06 +0200
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Message-Id: <20200724070008.1389205-7-elver@google.com>
Mime-Version: 1.0
References: <20200724070008.1389205-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 6/8] instrumented.h: Introduce read-write instrumentation hooks
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

Introduce read-write instrumentation hooks, to more precisely denote an
operation's behaviour.

KCSAN is able to distinguish compound instrumentation, and with the new
instrumentation we then benefit from improved reporting. More
importantly, read-write compound operations should not implicitly be
treated as atomic, if they aren't actually atomic.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/instrumented.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 43e6ea591975..42faebbaa202 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -42,6 +42,21 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 	kcsan_check_write(v, size);
 }
 
+/**
+ * instrument_read_write - instrument regular read-write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_read_write(v, size);
+}
+
 /**
  * instrument_atomic_read - instrument atomic read access
  *
@@ -72,6 +87,21 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 	kcsan_check_atomic_write(v, size);
 }
 
+/**
+ * instrument_atomic_read_write - instrument atomic read-write access
+ *
+ * Instrument an atomic read-write access. The instrumentation should be
+ * inserted before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_read_write(v, size);
+}
+
 /**
  * instrument_copy_to_user - instrument reads of copy_to_user
  *
-- 
2.28.0.rc0.142.g3c755180ce-goog


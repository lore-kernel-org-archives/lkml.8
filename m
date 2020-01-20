Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C096C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C002A20678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhbxWX6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgATOTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:19:44 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:36646 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:19:43 -0500
Received: by mail-wm1-f74.google.com with SMTP id f25so3754407wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Nfa3SPvPtmfv9OXDVBjRxJwd9iLaWZX/BpfniwtezQo=;
        b=UhbxWX6ASocBqYOmExgZzHhGzoGU/XgRLrivmvNu5RQg6NKZq6hO7pdIzkpWFJULHM
         atx/Qq2QEwL/yg/3qSS8SdwGO+jGGjp6w9Nl2ioB1mmyE00P7+fySO9bQICvMzQNmbHo
         bpDwCLx4VyPkgdqvfYQXDk3UKXXTFa7uGl77QnFdrl3ZLGHfKaq5u/nwlZ86la4up6y7
         Xv8aDxNsRXVJFiQFWxXVDd6XSJ5XNpBik2BdIhdGQoUW1A3dAohysmdYUMsMwNCXG2VC
         r7EEcIVSqnpXmXHGucnsjd/QiIp5W0m9qRgBtoFDX+WZJ0yTeIhWDxtuYWhmQhaqWGIl
         S+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Nfa3SPvPtmfv9OXDVBjRxJwd9iLaWZX/BpfniwtezQo=;
        b=UyE5pJgE4YeWhfinaXR4YkVhU2rrDhumNstd7ou48Tn32BLG0fm2gHbdRxbV5y5AmN
         ZUhR2GM6WW2cyQ37+Nm5lDA11GHscXrRyYokhmjMXz+6TlBJKPkOMit4YDITjDQZTSTx
         a9kzU2ZbbWK5lslxJMWpg4LRGneIAEr2vBxDhsK8i4tMHmGQ7/HFL+swtqVpdOqSP5V2
         YBWEdZIkmfMdGVPsNiB0AQgUu8Y71cIrE57EpsYuF+5vPsQYrN4jiYG/TTBG+VZ4Uu6n
         71Ip+lQrcXuEvi49/+I8C9oCUTS6pIxvG65zdtLQwqg2af+ltVEtiRzsz6sngfWe4X5x
         zrLA==
X-Gm-Message-State: APjAAAXp0yRTBF00alKarxVLW20qBmWd7V6HxNUJtuTBowu6ZooJdT2Z
        h/2pD9ALrZgKFYe0WlPNmLaR71Ab0w==
X-Google-Smtp-Source: APXvYqx4qC4nxJBlx0ET7P5Aq/iTgxx89uovXuTSxsSVUW7EBw+E/3iA8A0MlYCrgRwHYCEa9EvzdlcpYw==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr18022313wrs.303.1579529980939;
 Mon, 20 Jan 2020 06:19:40 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:19:23 +0100
Message-Id: <20200120141927.114373-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        arnd@arndb.de, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr,
        dja@axtens.net, mpe@ellerman.id.au, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@kernel.org,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        cyphar@cyphar.com, keescook@chromium.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds instrumented.h, which provides generic wrappers for memory
access instrumentation that the compiler cannot emit for various
sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
future this will also include KMSAN instrumentation.

Note that, copy_{to,from}_user require special instrumentation,
providing hooks before and after the access, since we may need to know
the actual bytes accessed (currently this is relevant for KCSAN, and is
also relevant in future for KMSAN).

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 include/linux/instrumented.h

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
new file mode 100644
index 000000000000..9f83c8520223
--- /dev/null
+++ b/include/linux/instrumented.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This header provides generic wrappers for memory access instrumentation that
+ * the compiler cannot emit for: KASAN, KCSAN.
+ */
+#ifndef _LINUX_INSTRUMENTED_H
+#define _LINUX_INSTRUMENTED_H
+
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+#include <linux/types.h>
+
+/**
+ * instrument_read - instrument regular read access
+ *
+ * Instrument a regular read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_read(v, size);
+}
+
+/**
+ * instrument_write - instrument regular write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_write(v, size);
+}
+
+/**
+ * instrument_atomic_read - instrument atomic read access
+ *
+ * Instrument an atomic read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_atomic_read(v, size);
+}
+
+/**
+ * instrument_atomic_write - instrument atomic write access
+ *
+ * Instrument an atomic write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_write(v, size);
+}
+
+/**
+ * instrument_copy_to_user_pre - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted before the accesses. At this point the
+ * actual number of bytes accessed is not yet known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ */
+static __always_inline void
+instrument_copy_to_user_pre(const volatile void *src, size_t size)
+{
+	/* Check before, to warn before potential memory corruption. */
+	kasan_check_read(src, size);
+}
+
+/**
+ * instrument_copy_to_user_post - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted after the accesses. At this point the
+ * actual number of bytes accessed should be known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ * @left number of bytes left that were not copied
+ */
+static __always_inline void
+instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
+{
+	/* Check after, to avoid false positive if memory was not accessed. */
+	kcsan_check_read(src, size - left);
+}
+
+/**
+ * instrument_copy_from_user_pre - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted before the accesses. At this point the
+ * actual number of bytes accessed is not yet known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ */
+static __always_inline void
+instrument_copy_from_user_pre(const volatile void *dst, size_t size)
+{
+	/* Check before, to warn before potential memory corruption. */
+	kasan_check_write(dst, size);
+}
+
+/**
+ * instrument_copy_from_user_post - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants).
+ *
+ * The instrumentation must be inserted after the accesses. At this point the
+ * actual number of bytes accessed should be known.
+ *
+ * @dst destination address
+ * @size maximum access size
+ * @left number of bytes left that were not copied
+ */
+static __always_inline void
+instrument_copy_from_user_post(const volatile void *dst, size_t size, size_t left)
+{
+	/* Check after, to avoid false positive if memory was not accessed. */
+	kcsan_check_write(dst, size - left);
+}
+
+#endif /* _LINUX_INSTRUMENTED_H */
-- 
2.25.0.341.g760bfbb309-goog


Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767EAC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A5020838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNc7TEIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBFPvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:51:53 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:56227 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBFPvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:51:53 -0500
Received: by mail-wr1-f73.google.com with SMTP id m15so3584271wrs.22
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9ivMm6BzzOGZymLSvHhw6OFUtFZ37ARIsWSjvoe/3Wc=;
        b=KNc7TEIw3xiZevfE1+iy3grNxT5hmqDXPT6BQN/a4NTgu/Lc1hvfVygu44jAxKR73F
         XW5oQ3UXxyyhgqmKt3NRpYCy1mMwxEVRU5zDvrWHuhCU3OWyeJgv2b8+zc1oXtfM5Nd7
         5Mvc5p6vl+5L/6A8wSTrp9vGQn0ggn2VMjOjgdJsb53Ts3uMEkRbzOFcXtovHvGOZXM/
         udV+++FUdci8d537TiQUlCkm6IPXj7z2y+BaPZS7GXsGSHO9/MdAtHU8KspNm/HcCQ54
         +/hRQ7gcRWiysT8F5Gz/vDm8gYI0MultZnwhIJZ9D31HbQVOSHIuQGr3WINGtT4CCYL/
         JD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9ivMm6BzzOGZymLSvHhw6OFUtFZ37ARIsWSjvoe/3Wc=;
        b=NBy3FK9GISwtKcMqlpGGHE12pIjI1dXzxxJErFuDKRo7n6aZ3XR+wQS32V85Yde2Cw
         GBeIGZuMFS6foAS7O796EgpsCgvfqq6g/MHmk2JwKhmdI+eiekhhW2m9U68yr+lhN2Cg
         uppuPTJjWDXnHWB6DQ1/VOK38u+vHiLGXmnqArqMAU6n3qXkFCZC5EIReYOXzVJQZwWH
         r5qEIgsqPKvhgi3VIu3d5xgT7G2vCf+BXTbmQp2hW74QVWhFMGC6D/ALy5NQO2Z56KIb
         wD0R0Zs0GChhD045Ei01Z3WF45MbIE/JMkLzPc+f9O1NzVyDczfEIk/+qhUkozTYqboa
         3rWw==
X-Gm-Message-State: APjAAAWaiHi46SKGy7qncMu/J4pOcpLn/A+hCYupOWN0eFQHv39/FGR4
        9ztB0zHLb10TGKlRPk3WuKSUgXdzaA==
X-Google-Smtp-Source: APXvYqzOr4yffDvvoJeFwb2l5i1e3i+Yl4mOXJxxXgOvXOuqaHSbeF11g0Oj4X6r1nPt+TBkAQviNfwQtA==
X-Received: by 2002:adf:f302:: with SMTP id i2mr4427613wro.21.1581004310493;
 Thu, 06 Feb 2020 07:51:50 -0800 (PST)
Date:   Thu,  6 Feb 2020 16:46:25 +0100
In-Reply-To: <20200206154626.243230-1-elver@google.com>
Message-Id: <20200206154626.243230-2-elver@google.com>
Mime-Version: 1.0
References: <20200206154626.243230-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 2/3] kcsan: Introduce ASSERT_EXCLUSIVE_* macros
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces ASSERT_EXCLUSIVE_WRITER and ASSERT_EXCLUSIVE_ACCESS, which
may be used to assert properties of synchronization logic, where
violation cannot be detected as a normal data race.

Examples of the reports that may be generated:

    ==================================================================
    BUG: KCSAN: assert: race in test_thread / test_thread

    write to 0xffffffffab3d1540 of 8 bytes by task 466 on cpu 2:
     test_thread+0x8d/0x111
     debugfs_write.cold+0x32/0x44
     ...

    assert no writes to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
     test_thread+0xa3/0x111
     debugfs_write.cold+0x32/0x44
     ...
    ==================================================================

    ==================================================================
    BUG: KCSAN: assert: race in test_thread / test_thread

    assert no accesses to 0xffffffffab3d1540 of 8 bytes by task 465 on cpu 1:
     test_thread+0xb9/0x111
     debugfs_write.cold+0x32/0x44
     ...

    read to 0xffffffffab3d1540 of 8 bytes by task 464 on cpu 0:
     test_thread+0x77/0x111
     debugfs_write.cold+0x32/0x44
     ...
    ==================================================================

Signed-off-by: Marco Elver <elver@google.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
---
v2:
* Update ASSERT_EXCLUSIVE_ACCESS() example.
---
 include/linux/kcsan-checks.h | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 5dcadc221026e..cf6961794e9a1 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -96,4 +96,44 @@ static inline void kcsan_check_access(const volatile void *ptr, size_t size,
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
 #endif
 
+/**
+ * ASSERT_EXCLUSIVE_WRITER - assert no other threads are writing @var
+ *
+ * Assert that there are no other threads writing @var; other readers are
+ * allowed. This assertion can be used to specify properties of concurrent code,
+ * where violation cannot be detected as a normal data race.
+ *
+ * For example, if a per-CPU variable is only meant to be written by a single
+ * CPU, but may be read from other CPUs; in this case, reads and writes must be
+ * marked properly, however, if an off-CPU WRITE_ONCE() races with the owning
+ * CPU's WRITE_ONCE(), would not constitute a data race but could be a harmful
+ * race condition. Using this macro allows specifying this property in the code
+ * and catch such bugs.
+ *
+ * @var variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_WRITER(var)                                           \
+	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
+
+/**
+ * ASSERT_EXCLUSIVE_ACCESS - assert no other threads are accessing @var
+ *
+ * Assert that no other thread is accessing @var (no readers nor writers). This
+ * assertion can be used to specify properties of concurrent code, where
+ * violation cannot be detected as a normal data race.
+ *
+ * For example, in a reference-counting algorithm where exclusive access is
+ * expected after the refcount reaches 0. We can check that this property
+ * actually holds as follows:
+ *
+ *	if (refcount_dec_and_test(&obj->refcnt)) {
+ *		ASSERT_EXCLUSIVE_ACCESS(*obj);
+ *		safely_dispose_of(obj);
+ *	}
+ *
+ * @var variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
+	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
+
 #endif /* _LINUX_KCSAN_CHECKS_H */
-- 
2.25.0.341.g760bfbb309-goog


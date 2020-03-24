Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357AAC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169422070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCXJMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:12:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgCXJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaM-0007VV-R5; Tue, 24 Mar 2020 10:10:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E0B0E1C0481;
        Tue, 24 Mar 2020 10:10:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:56 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Introduce ASSERT_EXCLUSIVE_*() macros
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105659.28353.5875053583912976459.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     f97f713dc25714ac13f3b5abdeffce2da3f6fe70
Gitweb:        https://git.kernel.org/tip/f97f713dc25714ac13f3b5abdeffce2da3f6fe70
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 06 Feb 2020 16:46:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:42:59 +01:00

kcsan: Introduce ASSERT_EXCLUSIVE_*() macros

Introduces ASSERT_EXCLUSIVE_WRITER() and ASSERT_EXCLUSIVE_ACCESS(), which
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

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kcsan-checks.h | 40 +++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 5dcadc2..cf69617 100644
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

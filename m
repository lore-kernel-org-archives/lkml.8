Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAF4C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA1321556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgAMTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:11:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgAMTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55p-00013T-DT; Mon, 13 Jan 2020 20:09:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 63A641C18E7;
        Mon, 13 Jan 2020 20:09:29 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:29 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Add do_timens_ktime_to_host() helper
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-13-dima@arista.com>
References: <20191112012724.250792-13-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256926.19145.902754876248951106.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     6c9c1492c9fd0732dfa85c9cb55f71f2571c3825
Gitweb:        https://git.kernel.org/tip/6c9c1492c9fd0732dfa85c9cb55f71f2571c3825
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:01 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:51 +01:00

time: Add do_timens_ktime_to_host() helper

The helper subtracts namespace's clock offset from the given time
and ensures that the result is within [0, KTIME_MAX].

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-13-dima@arista.com

---
 include/linux/time_namespace.h | 17 ++++++++++++++++-
 kernel/time/namespace.c        | 36 +++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index d7e3b49..34ee110 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -59,6 +59,19 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 	*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct time_namespace *ns = current->nsproxy->time_ns;
+
+	if (likely(ns == &init_time_ns))
+		return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, &ns->offsets);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -88,6 +101,10 @@ static inline int timens_on_fork(struct nsproxy *nsproxy,
 
 static inline void timens_add_monotonic(struct timespec64 *ts) { }
 static inline void timens_add_boottime(struct timespec64 *ts) { }
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index c2a58e4..1a0fbaa 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -16,6 +16,42 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *ns_offsets)
+{
+	ktime_t offset;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offset = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		offset = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/*
+	 * Check that @tim value is in [offset, KTIME_MAX + offset]
+	 * and subtract offset.
+	 */
+	if (tim < offset) {
+		/*
+		 * User can specify @tim *absolute* value - if it's lesser than
+		 * the time namespace's offset - it's already expired.
+		 */
+		tim = 0;
+	} else {
+		tim = ktime_sub(tim, offset);
+		if (unlikely(tim > KTIME_MAX))
+			tim = KTIME_MAX;
+	}
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);

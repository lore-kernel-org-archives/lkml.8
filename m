Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E822C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14820714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgBJNA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:29 -0500
Received: from foss.arm.com ([217.140.110.172]:60742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgBJNAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:00:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 769061FB;
        Mon, 10 Feb 2020 05:00:24 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AD2F3F68E;
        Mon, 10 Feb 2020 05:00:22 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        richard.henderson@linaro.org, tytso@mit.edu, will@kernel.org
Subject: [PATCH 2/4] random: add arch_get_random_*long_early()
Date:   Mon, 10 Feb 2020 13:00:13 +0000
Message-Id: <20200210130015.17664-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200210130015.17664-1-mark.rutland@arm.com>
References: <20200210130015.17664-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures (e.g. arm64) can have heterogeneous CPUs, and the
boot CPU may be able to provide entropy while secondary CPUs cannot. On
such systems, arch_get_random_long() and arch_get_random_seed_long()
will fail unless support for RNG instructions has been detected on all
CPUs. This prevents the boot CPU from being able to provide
(potentially) trusted entropy when seeding the primary CRNG.

To make it possible to seed the primary CRNG from the boot CPU without
adversely affecting the runtime versions of arch_get_random_long() and
arch_get_random_seed_long(), this patch adds new early versions of the
functions used when initializing the primary CRNG.

Default implementations are provided atop of the existing
arch_get_random_long() and arch_get_random_seed_long() so that only
architectures with such constraints need to provide the new helpers.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c  | 20 +++++++++++++++++++-
 include/linux/random.h | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 62d32e62f2da..02a85b87b993 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -799,6 +799,24 @@ static bool crng_init_try_arch(struct crng_state *crng)
 	return arch_init;
 }
 
+static bool __init crng_init_try_arch_early(struct crng_state *crng)
+{
+	int		i;
+	bool		arch_init = true;
+	unsigned long	rv;
+
+	for (i = 4; i < 16; i++) {
+		if (!arch_get_random_seed_long_early(&rv) &&
+		    !arch_get_random_long_early(&rv)) {
+			rv = random_get_entropy();
+			arch_init = false;
+		}
+		crng->state[i] ^= rv;
+	}
+
+	return arch_init;
+}
+
 static void crng_initialize_secondary(struct crng_state *crng)
 {
 	memcpy(&crng->state[0], "expand 32-byte k", 16);
@@ -811,7 +829,7 @@ static void __init crng_initialize_primary(struct crng_state *crng)
 {
 	memcpy(&crng->state[0], "expand 32-byte k", 16);
 	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
-	if (crng_init_try_arch(crng) && trust_cpu) {
+	if (crng_init_try_arch_early(crng) && trust_cpu) {
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
diff --git a/include/linux/random.h b/include/linux/random.h
index d319f9a1e429..45e1f8fa742b 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_RANDOM_H
 #define _LINUX_RANDOM_H
 
+#include <linux/bug.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/once.h>
 
@@ -185,6 +187,26 @@ static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 }
 #endif
 
+/*
+ * Called from the boot CPU during startup; not valid to call once
+ * secondary CPUs are up and preemption is possible.
+ */
+#ifndef arch_get_random_seed_long_early
+static inline bool __init arch_get_random_seed_long_early(unsigned long *v)
+{
+	WARN_ON(system_state != SYSTEM_BOOTING);
+	return arch_get_random_seed_long(v);
+}
+#endif
+
+#ifndef arch_get_random_long_early
+static inline bool __init arch_get_random_long_early(unsigned long *v)
+{
+	WARN_ON(system_state != SYSTEM_BOOTING);
+	return arch_get_random_long(v);
+}
+#endif
+
 /* Pseudo random number generator from numerical recipes. */
 static inline u32 next_pseudo_random32(u32 seed)
 {
-- 
2.11.0


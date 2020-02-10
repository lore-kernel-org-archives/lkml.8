Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905EAC3B187
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AD620733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgBJNA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:00:26 -0500
Received: from foss.arm.com ([217.140.110.172]:60726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbgBJNAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:00:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B14E31B;
        Mon, 10 Feb 2020 05:00:22 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E3853F68E;
        Mon, 10 Feb 2020 05:00:21 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        richard.henderson@linaro.org, tytso@mit.edu, will@kernel.org
Subject: [PATCH 1/4] random: split primary/secondary crng init paths
Date:   Mon, 10 Feb 2020 13:00:12 +0000
Message-Id: <20200210130015.17664-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200210130015.17664-1-mark.rutland@arm.com>
References: <20200210130015.17664-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently crng_initialize() is used for both the primary CRNG and
secondary CRNGs. While we wish to share common logic, we need to do a
number of additional things for the primary CRNG, and this would be
easier to deal with were these handled in separate functions.

This patch splits crng_initialize() into crng_initialize_primary() and
crng_initialize_secondary(), with common logic factored out into a
crng_init_try_arch() helper.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
---
 drivers/char/random.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..62d32e62f2da 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -781,27 +781,37 @@ static int __init parse_trust_cpu(char *arg)
 }
 early_param("random.trust_cpu", parse_trust_cpu);
 
-static void crng_initialize(struct crng_state *crng)
+static bool crng_init_try_arch(struct crng_state *crng)
 {
 	int		i;
-	int		arch_init = 1;
+	bool		arch_init = true;
 	unsigned long	rv;
 
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
-	if (crng == &primary_crng)
-		_extract_entropy(&input_pool, &crng->state[4],
-				 sizeof(__u32) * 12, 0);
-	else
-		_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
 	for (i = 4; i < 16; i++) {
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv)) {
 			rv = random_get_entropy();
-			arch_init = 0;
+			arch_init = false;
 		}
 		crng->state[i] ^= rv;
 	}
-	if (trust_cpu && arch_init && crng == &primary_crng) {
+
+	return arch_init;
+}
+
+static void crng_initialize_secondary(struct crng_state *crng)
+{
+	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
+	crng_init_try_arch(crng);
+	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
+}
+
+static void __init crng_initialize_primary(struct crng_state *crng)
+{
+	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	_extract_entropy(&input_pool, &crng->state[4], sizeof(__u32) * 12, 0);
+	if (crng_init_try_arch(crng) && trust_cpu) {
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
@@ -822,7 +832,7 @@ static void do_numa_crng_init(struct work_struct *work)
 		crng = kmalloc_node(sizeof(struct crng_state),
 				    GFP_KERNEL | __GFP_NOFAIL, i);
 		spin_lock_init(&crng->lock);
-		crng_initialize(crng);
+		crng_initialize_secondary(crng);
 		pool[i] = crng;
 	}
 	mb();
@@ -1771,7 +1781,7 @@ static void __init init_std_data(struct entropy_store *r)
 int __init rand_initialize(void)
 {
 	init_std_data(&input_pool);
-	crng_initialize(&primary_crng);
+	crng_initialize_primary(&primary_crng);
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
-- 
2.11.0


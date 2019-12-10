Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB4DC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC718206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgC1QpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:45:20 -0400
Received: from mx.sdf.org ([205.166.94.20]:49956 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgC1Qnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:42 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhObs019651
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:24 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhOi3016886;
        Sat, 28 Mar 2020 16:43:24 GMT
Message-Id: <202003281643.02SGhOi3016886@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Tue, 10 Dec 2019 07:15:55 -0500
Subject: [RFC PATCH v1 44/50] arm64: ptr auth: Use get_random_u64 instead of
 _bytes
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since these are authentication keys, stored in the kernel as long
as they're important, get_random_u64 is fine.  In particular,
get_random_bytes has significant per-call overhead, so five
separate calls is painful.

This ended up being a more extensive change, since the previous
code was unrolled and 10 calls to get_random_u64() seems excessive.
So the code was rearranged to have smaller object size.

Currently fields[i] = { 1 << i, 16 * i } for all i could be computed
rather than looked up, but the table seemed more future-proof.

For ptrauth_keys_switch(), the MSR instructions must be unrolled and
are much faster than get_random, so although a similar flags-based
interface is possible, it's probably not worth it.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pointer_auth.h | 20 +++++----
 arch/arm64/kernel/pointer_auth.c      | 62 +++++++++++++++------------
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 7a24bad1a58b8..b7ef71362a3ae 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -30,17 +30,19 @@ struct ptrauth_keys {
 	struct ptrauth_key apga;
 };
 
+static inline unsigned long ptrauth_keys_supported(void)
+{
+	return (system_supports_address_auth() ?
+			PR_PAC_APIAKEY | PR_PAC_APIBKEY |
+			PR_PAC_APDAKEY | PR_PAC_APDBKEY : 0) |
+	       (system_supports_generic_auth() ? PR_PAC_APGAKEY : 0);
+}
+
+void ptrauth_keys_generate(struct ptrauth_keys *keys, unsigned long flags);
+
 static inline void ptrauth_keys_init(struct ptrauth_keys *keys)
 {
-	if (system_supports_address_auth()) {
-		get_random_bytes(&keys->apia, sizeof(keys->apia));
-		get_random_bytes(&keys->apib, sizeof(keys->apib));
-		get_random_bytes(&keys->apda, sizeof(keys->apda));
-		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
-	}
-
-	if (system_supports_generic_auth())
-		get_random_bytes(&keys->apga, sizeof(keys->apga));
+	ptrauth_keys_generate(keys, ptrauth_keys_supported());
 }
 
 #define __ptrauth_key_install(k, v)				\
diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
index c507b584259d0..1604ed246128c 100644
--- a/arch/arm64/kernel/pointer_auth.c
+++ b/arch/arm64/kernel/pointer_auth.c
@@ -7,40 +7,48 @@
 #include <asm/cpufeature.h>
 #include <asm/pointer_auth.h>
 
+/*
+ * Generating crypto-quality random numbers is expensive enough that
+ * there's no point unrolling this.
+ */
+void ptrauth_keys_generate(struct ptrauth_keys *keys, unsigned long flags)
+{
+	size_t i;
+	static const struct {
+		/*
+		 * 8 bits is enough for now.  Compiler will complain
+		 * if/when we need more.
+		 */
+		unsigned char flag, offset;
+	} fields[] = {
+		{ PR_PAC_APIAKEY, offsetof(struct ptrauth_keys, apia) },
+		{ PR_PAC_APIBKEY, offsetof(struct ptrauth_keys, apib) },
+		{ PR_PAC_APDAKEY, offsetof(struct ptrauth_keys, apda) },
+		{ PR_PAC_APDBKEY, offsetof(struct ptrauth_keys, apdb) },
+		{ PR_PAC_APGAKEY, offsetof(struct ptrauth_keys, apga) }
+	};
+
+	for (i = 0; i < ARRAY_SIZE(fields); i++) {
+		if (flags & fields[i].flag) {
+			struct ptrauth_key *k = (void *)keys + fields[i].offset;
+			k->lo = get_random_u64();
+			k->hi = get_random_u64();
+		}
+	}
+}
+
 int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
 {
+	unsigned long supported = ptrauth_keys_supported();
 	struct ptrauth_keys *keys = &tsk->thread.keys_user;
-	unsigned long addr_key_mask = PR_PAC_APIAKEY | PR_PAC_APIBKEY |
-				      PR_PAC_APDAKEY | PR_PAC_APDBKEY;
-	unsigned long key_mask = addr_key_mask | PR_PAC_APGAKEY;
 
-	if (!system_supports_address_auth() && !system_supports_generic_auth())
+	if (!supported || arg & ~supported)
 		return -EINVAL;
 
-	if (!arg) {
-		ptrauth_keys_init(keys);
-		ptrauth_keys_switch(keys);
-		return 0;
-	}
-
-	if (arg & ~key_mask)
-		return -EINVAL;
-
-	if (((arg & addr_key_mask) && !system_supports_address_auth()) ||
-	    ((arg & PR_PAC_APGAKEY) && !system_supports_generic_auth()))
-		return -EINVAL;
-
-	if (arg & PR_PAC_APIAKEY)
-		get_random_bytes(&keys->apia, sizeof(keys->apia));
-	if (arg & PR_PAC_APIBKEY)
-		get_random_bytes(&keys->apib, sizeof(keys->apib));
-	if (arg & PR_PAC_APDAKEY)
-		get_random_bytes(&keys->apda, sizeof(keys->apda));
-	if (arg & PR_PAC_APDBKEY)
-		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
-	if (arg & PR_PAC_APGAKEY)
-		get_random_bytes(&keys->apga, sizeof(keys->apga));
+	if (!arg)
+		arg = supported;
 
+	ptrauth_keys_generate(keys, arg);
 	ptrauth_keys_switch(keys);
 
 	return 0;
-- 
2.26.0


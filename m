Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A3CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36BC20748
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgDFVAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:00:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFVAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:00:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08B77AA55;
        Mon,  6 Apr 2020 21:00:37 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpcs: perf: consolidate perf_callchain_user_64 and perf_callchain_user_32
Date:   Mon,  6 Apr 2020 23:00:22 +0200
Message-Id: <20200406210022.32265-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <1585896170.ohti800w9v.astroid@bobo.none>
References: <1585896170.ohti800w9v.astroid@bobo.none>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_callchain_user_64 and perf_callchain_user_32 are nearly identical.
Consolidate into one function with thin wrappers.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/perf/callchain.h    | 24 +++++++++++++++++++++++-
 arch/powerpc/perf/callchain_32.c | 21 ++-------------------
 arch/powerpc/perf/callchain_64.c | 14 ++++----------
 3 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/perf/callchain.h b/arch/powerpc/perf/callchain.h
index 7a2cb9e1181a..7540bb71cb60 100644
--- a/arch/powerpc/perf/callchain.h
+++ b/arch/powerpc/perf/callchain.h
@@ -2,7 +2,7 @@
 #ifndef _POWERPC_PERF_CALLCHAIN_H
 #define _POWERPC_PERF_CALLCHAIN_H
 
-int read_user_stack_slow(void __user *ptr, void *buf, int nb);
+int read_user_stack_slow(const void __user *ptr, void *buf, int nb);
 void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 			    struct pt_regs *regs);
 void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
@@ -16,4 +16,26 @@ static inline bool invalid_user_sp(unsigned long sp)
 	return (!sp || (sp & mask) || (sp > top));
 }
 
+/*
+ * On 32-bit we just access the address and let hash_page create a
+ * HPTE if necessary, so there is no need to fall back to reading
+ * the page tables.  Since this is called at interrupt level,
+ * do_page_fault() won't treat a DSI as a page fault.
+ */
+static inline int __read_user_stack(const void __user *ptr, void *ret,
+				    size_t size)
+{
+	int rc;
+
+	if ((unsigned long)ptr > TASK_SIZE - size ||
+			((unsigned long)ptr & (size - 1)))
+		return -EFAULT;
+	rc = probe_user_read(ret, ptr, size);
+
+	if (rc && IS_ENABLED(CONFIG_PPC64))
+		return read_user_stack_slow(ptr, ret, size);
+
+	return rc;
+}
+
 #endif /* _POWERPC_PERF_CALLCHAIN_H */
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index 8aa951003141..1b4621f177e8 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -31,26 +31,9 @@
 
 #endif /* CONFIG_PPC64 */
 
-/*
- * On 32-bit we just access the address and let hash_page create a
- * HPTE if necessary, so there is no need to fall back to reading
- * the page tables.  Since this is called at interrupt level,
- * do_page_fault() won't treat a DSI as a page fault.
- */
-static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
+static int read_user_stack_32(const unsigned int __user *ptr, unsigned int *ret)
 {
-	int rc;
-
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
-	    ((unsigned long)ptr & 3))
-		return -EFAULT;
-
-	rc = probe_user_read(ret, ptr, sizeof(*ret));
-
-	if (IS_ENABLED(CONFIG_PPC64) && rc)
-		return read_user_stack_slow(ptr, ret, 4);
-
-	return rc;
+	return __read_user_stack(ptr, ret, sizeof(*ret);
 }
 
 /*
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index df1ffd8b20f2..55bbc25a54ed 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -24,7 +24,7 @@
  * interrupt context, so if the access faults, we read the page tables
  * to find which page (if any) is mapped and access it directly.
  */
-int read_user_stack_slow(void __user *ptr, void *buf, int nb)
+int read_user_stack_slow(const void __user *ptr, void *buf, int nb)
 {
 	int ret = -EFAULT;
 	pgd_t *pgdir;
@@ -65,16 +65,10 @@ int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	return ret;
 }
 
-static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
+static int read_user_stack_64(const unsigned long __user *ptr,
+			      unsigned long *ret)
 {
-	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
-	    ((unsigned long)ptr & 7))
-		return -EFAULT;
-
-	if (!probe_user_read(ret, ptr, sizeof(*ret)))
-		return 0;
-
-	return read_user_stack_slow(ptr, ret, 8);
+	return __read_user_stack(ptr, ret, sizeof(*ret));
 }
 
 /*
-- 
2.23.0


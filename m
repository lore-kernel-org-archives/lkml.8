Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3190C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9F520727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563694;
	bh=kv5mnSWLjr5fBV4nQ8+dYNhj0aVw4GQo+4yHT59GbLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q96vUXugfDw8yRYTjMWh9X/GDaKHzqNUcSsivUXjp0/763AER7wBkDQVSbb6PcBng
	 pTiOaxwfGLXs/sc+/S1jVXkwY8STjkLvW+qrKMbIkU4C/TiiZAZYaWMqFPFbwyej/C
	 CNkozG/RmOWPsIClnp3r8m1GPUQEeQM7A2E5LwSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgEOR2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgEOR2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:11 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299A7207D5;
        Fri, 15 May 2020 17:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563691;
        bh=kv5mnSWLjr5fBV4nQ8+dYNhj0aVw4GQo+4yHT59GbLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GUhQpkPHCiFNiBceCCvlyDAK8CSvD8Ee+z6+TNY03ORfuvnrDGahbWBzDJLE3SJI
         ElQ3TdQYN1ZeTFygNbIjUgfTcHBTFWqs9GgNc3Xi1IjtfF9UcOsf1SScwVaQb6xTNM
         F2nfBQBOOuvL2DpUBLY371Ls/BS28+5ZPiat51oU=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: [PATCH 2/6] scs: Move accounting into alloc/free functions
Date:   Fri, 15 May 2020 18:27:52 +0100
Message-Id: <20200515172756.27185-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
References: <20200515172756.27185-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to perform the shadow stack page accounting independently
of the lifetime of the underlying allocation, so call the accounting code
from the {alloc,free}() functions and simplify the code in the process.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/scs.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/scs.c b/kernel/scs.c
index 5ff8663e4a67..aea841cd7586 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -14,25 +14,35 @@
 
 static struct kmem_cache *scs_cache;
 
+static void __scs_account(void *s, int account)
+{
+	struct page *scs_page = virt_to_page(s);
+
+	mod_zone_page_state(page_zone(scs_page), NR_KERNEL_SCS_KB,
+			    account * (SCS_SIZE / SZ_1K));
+}
+
 static void *scs_alloc(int node)
 {
-	void *s;
-
-	s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
-	if (s) {
-		*__scs_magic(s) = SCS_END_MAGIC;
-		/*
-		 * Poison the allocation to catch unintentional accesses to
-		 * the shadow stack when KASAN is enabled.
-		 */
-		kasan_poison_object_data(scs_cache, s);
-	}
+	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
+
+	if (!s)
+		return NULL;
 
+	*__scs_magic(s) = SCS_END_MAGIC;
+
+	/*
+	 * Poison the allocation to catch unintentional accesses to
+	 * the shadow stack when KASAN is enabled.
+	 */
+	kasan_poison_object_data(scs_cache, s);
+	__scs_account(s, 1);
 	return s;
 }
 
 static void scs_free(void *s)
 {
+	__scs_account(s, -1);
 	kasan_unpoison_object_data(scs_cache, s);
 	kmem_cache_free(scs_cache, s);
 }
@@ -42,17 +52,6 @@ void __init scs_init(void)
 	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, 0, 0, NULL);
 }
 
-static struct page *__scs_page(struct task_struct *tsk)
-{
-	return virt_to_page(task_scs(tsk));
-}
-
-static void scs_account(struct task_struct *tsk, int account)
-{
-	mod_zone_page_state(page_zone(__scs_page(tsk)), NR_KERNEL_SCS_KB,
-		account * (SCS_SIZE / 1024));
-}
-
 int scs_prepare(struct task_struct *tsk, int node)
 {
 	void *s = scs_alloc(node);
@@ -61,7 +60,6 @@ int scs_prepare(struct task_struct *tsk, int node)
 		return -ENOMEM;
 
 	task_scs(tsk) = task_scs_sp(tsk) = s;
-	scs_account(tsk, 1);
 	return 0;
 }
 
@@ -102,6 +100,5 @@ void scs_release(struct task_struct *tsk)
 
 	WARN(scs_corrupted(tsk), "corrupted shadow stack detected when freeing task\n");
 	scs_check_usage(tsk);
-	scs_account(tsk, -1);
 	scs_free(s);
 }
-- 
2.26.2.761.g0e0b3e54be-goog


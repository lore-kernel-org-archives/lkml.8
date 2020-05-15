Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645AEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0AD20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563706;
	bh=JS2Jcbe+j41/8PgSBe5ih0CI/gZxqJJ8SvDSb97vzwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=awaZ7b9VEvBzj8zegRcisL4dR5+u4FY7YUTDheUy0kxEZYRa8w/slUSd/7y/RM1uG
	 o3n2w57TOk9tOkSD/eLgTCa7/whSYKY5fbB6opR/JwkpFREDc9rV4g2Vs3BQAPJR3F
	 FmJNgQzZ6aOmwqI9DQv/XmzyVN32v/xviMWD4RfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgEOR2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgEOR2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:20 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226DA20758;
        Fri, 15 May 2020 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563699;
        bh=JS2Jcbe+j41/8PgSBe5ih0CI/gZxqJJ8SvDSb97vzwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhbWjB9Y7n2sMM0P5UzxQKHLsz8tKpwzCNGStKJaSVGYMfbcKjAvx90oglmyJbBI4
         A4n2ySKaJBRmk8qXEId9xSsNu+yiLfWMP1PnoB1eNPC5WH5E1dwfYuMFp1C7R+Xjtz
         xB4ZBLlaXVLMzIx2O1CtaijJWKVy9G+GskKy6s0o=
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
Subject: [PATCH 6/6] scs: Move DEFINE_SCS macro into core code
Date:   Fri, 15 May 2020 18:27:56 +0100
Message-Id: <20200515172756.27185-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
References: <20200515172756.27185-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining static shadow call stacks is not architecture-specific, so move
the DEFINE_SCS() macro into the core header file.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/scs.c | 4 ----
 include/linux/scs.h     | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
index 955875dff9e1..e8f7ff45dd8f 100644
--- a/arch/arm64/kernel/scs.c
+++ b/arch/arm64/kernel/scs.c
@@ -8,10 +8,6 @@
 #include <linux/percpu.h>
 #include <linux/scs.h>
 
-/* Allocate a static per-CPU shadow stack */
-#define DEFINE_SCS(name)						\
-	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
-
 DEFINE_SCS(irq_shadow_call_stack);
 
 #ifdef CONFIG_ARM_SDE_INTERFACE
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 2fd3df50e93e..6dec390cf154 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -26,6 +26,10 @@
 /* An illegal pointer value to mark the end of the shadow stack. */
 #define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
 
+/* Allocate a static per-CPU shadow stack */
+#define DEFINE_SCS(name)						\
+	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
+
 #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
 #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
 
-- 
2.26.2.761.g0e0b3e54be-goog


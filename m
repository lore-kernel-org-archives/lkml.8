Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7A820842
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538744;
	bh=2Mxxi9P5lRW+5g3NQeU4qRWtaohhR1GFugsFg71PpZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/9JLnTgzk6nMe30zYuNhUsLka8FvXAaUbix0qs/BvNaPqi8Vb3rIwRJsq3qxPzGg
	 2aE3HUFBoPv+kJK/fQkiks88Gp9En1df91Mq7HbeSdqb6pS9yPTaodZVm0qttG5O8r
	 lrUI8/CghHJBqIJW36gye/uayaDB6ltBHEfhnjKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbgF3RjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733290AbgF3Riv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2513E208C7;
        Tue, 30 Jun 2020 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538730;
        bh=2Mxxi9P5lRW+5g3NQeU4qRWtaohhR1GFugsFg71PpZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHmhulfd7SvL45c44fC0qSgxIdAPN86DyrwnKNzGUg2Pq5OjOijA/yWJyAtsmEUma
         rPR64cLaZaBkm37b+Sa2giePD+devRt9g6SbU0ATC0mG6V+RLRb6k8iDZGKf1D8o3z
         k9YXXvWinl98EEh7HO58U2tPFIT6KD8BNSIG73q4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH 16/18] arm64: cpufeatures: Add capability for LDAPR instruction
Date:   Tue, 30 Jun 2020 18:37:32 +0100
Message-Id: <20200630173734.14057-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armv8.3 introduced the LDAPR instruction, which provides weaker memory
ordering semantics than LDARi (RCpc vs RCsc). Generally, we provide an
RCsc implementation when implementing the Linux memory model, but LDAPR
can be used as a useful alternative to dependency ordering, particularly
when the compiler is capable of breaking the dependencies.

Since LDAPR is not available on all CPUs, add a cpufeature to detect it at
runtime and allow the instruction to be used with alternative code
patching.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..e1073210e70b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1409,6 +1409,9 @@ config ARM64_PAN
 	 The feature is detected at runtime, and will remain as a 'nop'
 	 instruction if the cpu does not implement the feature.
 
+config AS_HAS_LDAPR
+	def_bool $(as-instr,.arch_extension rcpc)
+
 config ARM64_LSE_ATOMICS
 	bool
 	default ARM64_USE_LSE_ATOMICS
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index d7b3bb0cb180..3ff0103d4dfd 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -62,7 +62,8 @@
 #define ARM64_HAS_GENERIC_AUTH			52
 #define ARM64_HAS_32BIT_EL1			53
 #define ARM64_BTI				54
+#define ARM64_HAS_LDAPR				55
 
-#define ARM64_NCAPS				55
+#define ARM64_NCAPS				56
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9f63053a63a9..a29256a782e9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2056,6 +2056,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sign = FTR_UNSIGNED,
 	},
 #endif
+	{
+		.desc = "RCpc load-acquire (LDAPR)",
+		.capability = ARM64_HAS_LDAPR,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_LRCPC_SHIFT,
+		.matches = has_cpuid_feature,
+		.min_field_value = 1,
+	},
 	{},
 };
 
-- 
2.27.0.212.ge8ba1cc988-goog


Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61720C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287E1207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egwaEsnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgETLNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:13:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B593C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:13:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so1198007plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yX6L8WE/2wulIJ9zzHwHac/OpN/D9QY9ojqo7Mh/3mw=;
        b=egwaEsnbY6AeyS96dO0hGfkxr/9sazC/TRAuJtiKxLcMasIkKn3431qFi4aKu8PyZy
         zA+K2sbl6vAxNVwL9+KW7XZ6wDYR0TzfCEIX9eF4LrQXw6fMVz9bXjVDFxUoh1Awjccn
         ikb16VFGIwZvdaIOWKt4pgIEZT6ajVQzfP7WI2ZTnNIVJZCp5DG8DKNGNTvC4VTRynVq
         5oD1hCIlADqJ8xlYek0oUenVOv++9LauUwQ9ImiMD6NjhqZAfkNSzAItZBGBgnIpAekq
         GXtOXwG57Y9VE31yfVzj2gBoGkiuh6+l8qxBEZcJ3Ymt5wWomn20SbsZKRngQKiep0rj
         icKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yX6L8WE/2wulIJ9zzHwHac/OpN/D9QY9ojqo7Mh/3mw=;
        b=jnZD0RS+b0+DCso0UDwUEW4j0A7GE+0SR8DAWRt5O4cMYJg7+0BgP+wMTE3f4XZpJx
         LoM+L9OwTv5f/QwsfceUJRdimBXMk1pkau582zPGDDJipkTpF5BNhQ8o27JX5M+8eeeW
         4ucoYey6EGdVwIQb8TA2AXlDoTT3RtBfJRpiLCUVB5iBfa3SsgF3lU1FUeCl9XOmUe9a
         y/tagCV66skTPcQHzt3vTEJkR0TJc3Wp/vvBgsPAWEkWmYD2N7UxLFdaEpJQpelB2c+y
         MZ495ol9rFQRd4vxufNpTtjqXlrDuTrT9A0FoO8cjuZZfe2XWlo0MA/wKOIfPsviV1ed
         eY8w==
X-Gm-Message-State: AOAM53038zHbxuSPtuCE+wK/3CEVSx+EmBg6MUQMnL3isP9+IZ/ZWG8e
        w3E+5rMOGL37t0BbKI6aO3Vc3Q==
X-Google-Smtp-Source: ABdhPJzUpGV1y7deDtZi57sfC8WyhNh7TcidlxseCMF5t7wpivc/pdczLuxnyS0XLzXoczy4erEZ3Q==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr4537270pjb.131.1589973202196;
        Wed, 20 May 2020 04:13:22 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id q134sm2044974pfc.143.2020.05.20.04.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 04:13:21 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 4/4] arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
Date:   Wed, 20 May 2020 16:41:55 +0530
Message-Id: <1589973115-14757-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
References: <1589973115-14757-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to round up CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to round up CPUs using IPI_CALL_NMI_FUNC. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
IPI_CALL_NMI_FUNC will act as a normal IPI which maintains existing
kgdb functionality.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/kgdb.h |  8 ++++++++
 arch/arm64/kernel/kgdb.c      | 21 +++++++++++++++++++++
 arch/arm64/kernel/smp.c       |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kgdb.h b/arch/arm64/include/asm/kgdb.h
index 21fc85e..6f3d3af 100644
--- a/arch/arm64/include/asm/kgdb.h
+++ b/arch/arm64/include/asm/kgdb.h
@@ -24,6 +24,14 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
+#ifdef CONFIG_KGDB
+extern void ipi_kgdb_nmicallback(int cpu, void *regs);
+#else
+static inline void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 4311992..ee932ba 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -14,6 +14,7 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smp.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -353,3 +354,23 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void ipi_kgdb_nmicallback(int cpu, void *regs)
+{
+	if (atomic_read(&kgdb_active) != -1)
+		kgdb_nmicallback(cpu, regs);
+}
+
+#ifdef CONFIG_SMP
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arch_send_call_nmi_func_ipi_mask(&mask);
+}
+#endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c5e42a1..3baace7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/irq_work.h>
 #include <linux/kexec.h>
+#include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 
 #include <asm/alternative.h>
@@ -958,7 +959,7 @@ static void do_handle_IPI(int ipinr)
 #endif
 
 	case IPI_CALL_NMI_FUNC:
-		/* nop, IPI handlers for special features can be added here. */
+		ipi_kgdb_nmicallback(cpu, get_irq_regs());
 		break;
 
 	default:
-- 
2.7.4


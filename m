Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890FCC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633FA20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RhV+Dgur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgDXLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:11:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04082C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a31so1895908pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGgPpUWWcJSKxFWk1j0ZpUZcDZ7qWSk+2Ep1V3opjsY=;
        b=RhV+Dgur2THbXVsj1cTu37mw8UPw80MKORypqDq7r/YfZFzDSHI0k79rvvs3kRsL+N
         5X10akzNH/fucZMO2P+Hqo+FCdis++edlXsKCaoPKGeOFZHpR8rNipVNdkPBE7nc1FtL
         JAnQMkVN/9e0A5DGLVeib1jx8kE46Ta4BFi4iS2XnJgWwfNMkyjGivbJIDXz4IO5uVih
         iP/Ss+WpI9mJhxFgwThDtMgqbXhV0bZwV4YtOYbHxLvaiwTwi0YHM57IX3IXb2K6ZmMa
         ZnfIe/U12bZDfeCOntbNTqUd4qRY76VDrfjXvdCam3jgPIhzv9/AA8CqliMBJ94JV9O2
         R7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGgPpUWWcJSKxFWk1j0ZpUZcDZ7qWSk+2Ep1V3opjsY=;
        b=lNlRsvR5zeXw2tklJrWyh3ZZG80IsGEeGCuTVvYkpk57H7Y5X2h7vveBl8A5CNk1kd
         Hiu68cU/NGx5Y0VDwd1D+bNXJq/UxurPH0Q6yC+/QCWH2CizKwPn7IYPYWaQZ0JGFPMu
         GYllcHI00R7LQ/KYMAtynlJRzi2FoffRZMu22njkAqbcozoosVgcHkkkkrYe6DcQfsiT
         ipPhE1UPiOJH38yO8utnlWKylmfk0/lUlJliUv+YgNN4PB6GsD6bm1eqbatA4O9EBzDD
         tBAhQe4gUUra0Kg6u2tqA+J58xJ2++BMcl8Xq+XlnipoZkHCd46f1PNh5PxUKbhmCJqa
         I/Iw==
X-Gm-Message-State: AGi0PuaJj2RZcrN3mgToP8Y7+0DzfFjzf45hqfyz/KehSz9GiGXsdnmx
        cu3CmjoWWEPdT7uXXNQ52m2J/Q==
X-Google-Smtp-Source: APiQypL+FHEDBtk6zd1EZND+1rWOLvFjGjy05fIVV+X1HKwQAax28zUwpf9w2/xAFM9nylW0/w1XRg==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr8684677plt.87.1587726714544;
        Fri, 24 Apr 2020 04:11:54 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.186])
        by smtp.gmail.com with ESMTPSA id o11sm4637628pgd.58.2020.04.24.04.11.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:11:53 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC Patch v1 4/4] arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
Date:   Fri, 24 Apr 2020 16:39:14 +0530
Message-Id: <1587726554-32018-5-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
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

Also, one thing to note here is that with CPUs running in NMI context,
kernel has special handling for printk() which involves CPU specific
buffers and defering printk() until exit from NMI context. But with kgdb
we don't want to defer printk() especially backtrace on corresponding
CPUs. So switch to normal printk() context instead prior to entering
kgdb context.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/kgdb.c | 15 +++++++++++++++
 arch/arm64/kernel/smp.c  | 17 ++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 4311992..0851ead 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -14,6 +14,7 @@
 #include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smp.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
@@ -353,3 +354,17 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
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
index 27c8ee1..c7158f6e8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/irq_work.h>
 #include <linux/kexec.h>
+#include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 
 #include <asm/alternative.h>
@@ -976,9 +977,19 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		/* Handle it as a normal interrupt if not in NMI context */
 		if (!in_nmi())
 			irq_enter();
-
-		/* nop, IPI handlers for special features can be added here. */
-
+#ifdef CONFIG_KGDB
+		if (atomic_read(&kgdb_active) != -1) {
+			/*
+			 * For kgdb to work properly, we need printk to operate
+			 * in normal context.
+			 */
+			if (in_nmi())
+				printk_nmi_exit();
+			kgdb_nmicallback(raw_smp_processor_id(), regs);
+			if (in_nmi())
+				printk_nmi_enter();
+		}
+#endif
 		if (!in_nmi())
 			irq_exit();
 		break;
-- 
2.7.4


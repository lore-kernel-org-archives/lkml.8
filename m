Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E604C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D1620776
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="M48Rb4hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgFWN3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbgFWN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:29:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83000C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:29:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so9892283pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=irmIqYd5MZLaWssj9MvOx+JHzybak5z12LXnlT9AlWo=;
        b=M48Rb4hrziEI7WgqkUsqc6SKOyd1Ob5LSCZAoIKnm77J/IHpx4qkkdsHeiO2zNAa5W
         1oQrsTz8m2DjAppo5SeqEPzW5XTZnQ3HR4HAvMGH4u5j1jiMhaoesljf1Ecr25kW6Jkt
         OzwCPlADfseQ7oLTkYl9S6d/yv/iBamrG9EdzQwLGE0exbMyo+Ljq/Ml09NEuMB7VOPN
         sirRdxy1tpCQlpbbXgTTUuG6LfQuy5SM0sq1CrZKZW1ciVODFyK1pyugfrV5/z0to+MR
         V5jk/bG7clj7VL+pnBJ8KItoGc5whl4gCBMPVs9ivu9st5/ZbIuZ0cvCQT4UZFeqzD5a
         83Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irmIqYd5MZLaWssj9MvOx+JHzybak5z12LXnlT9AlWo=;
        b=c/7Ik+v1G3HF/+lhVIxDweE0YeLh4Ewl9OwJqLvBuhsud5qAFZZJpjJVOpCG79iCcV
         mYBsjOm6Mqj2SAFPs24Xc2zivqkYY07EwvyMuwKBgPzUfwkKXXlK2mAsfA/61PMBDaE1
         2uUs+0P8mxOa3Xal1AmT0gO/k6lM17RWXuE1yGDhyEzFF4HYRJkjLAge7SVGhPIg0l4B
         06nw+6JzvIs+mX7ul8G664Os4iIxqHLI25N2yg5kI+RJKTQtOqaKydGVsnRwtdWR9Bq7
         +yAjqyh9a+r2k9Nrz+hyI5WRsnDt6vj1YQas+TzSvQVrEoNOTLY4vIF+YG+ztf1RPEr5
         SIlw==
X-Gm-Message-State: AOAM532Bt2XKcOQG12DIdNH+8HYUD+MszbG3Y5BNTBx+FkNwGALF4cPK
        fFqfwjMyN9SphxU9a1XlP6qRig==
X-Google-Smtp-Source: ABdhPJxiIkX+1xeumMyIlkiRdFjn2jJbSHGwdeEuM9eZBEuaJcrvqk13mprVIVBatct1dcHpq20eZA==
X-Received: by 2002:a63:924c:: with SMTP id s12mr17479462pgn.431.1592918940069;
        Tue, 23 Jun 2020 06:29:00 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id z19sm1670602pjn.55.2020.06.23.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:28:59 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        guoren@linux.alibaba.com
Subject: [PATCH 1/2] riscv: Support irq_work via self IPIs
Date:   Tue, 23 Jun 2020 21:28:51 +0800
Message-Id: <3c4a03ac99118bc6648d06f62c2f46b877bc8c72.1592918110.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592918110.git.greentime.hu@sifive.com>
References: <cover.1592918110.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for arch_irq_work_raise() and arch_irq_work_has_interrupt() was
missing from riscv (a prerequisite for FULL_NOHZ).

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/irq_work.h | 10 ++++++++++
 arch/riscv/kernel/smp.c           | 15 +++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 arch/riscv/include/asm/irq_work.h

diff --git a/arch/riscv/include/asm/irq_work.h b/arch/riscv/include/asm/irq_work.h
new file mode 100644
index 000000000000..eb9f3d9b15ed
--- /dev/null
+++ b/arch/riscv/include/asm/irq_work.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_IRQ_WORK_H
+#define _ASM_RISCV_IRQ_WORK_H
+
+static inline bool arch_irq_work_has_interrupt(void)
+{
+	return true;
+}
+
+#endif /* _ASM_RISCV_IRQ_WORK_H */
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b1d4f452f843..554b0fb47060 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq_work.h>
 
 #include <asm/clint.h>
 #include <asm/sbi.h>
@@ -26,6 +27,7 @@ enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_IRQ_WORK,
 	IPI_MAX
 };
 
@@ -123,6 +125,13 @@ static inline void clear_ipi(void)
 		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_single(smp_processor_id(), IPI_IRQ_WORK);
+}
+#endif
+
 void handle_IPI(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
@@ -158,6 +167,11 @@ void handle_IPI(struct pt_regs *regs)
 			ipi_stop();
 		}
 
+		if (ops & (1 << IPI_IRQ_WORK)) {
+			stats[IPI_IRQ_WORK]++;
+			irq_work_run();
+		}
+
 		BUG_ON((ops >> IPI_MAX) != 0);
 
 		/* Order data access and bit testing. */
@@ -173,6 +187,7 @@ static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
-- 
2.27.0


Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14198C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8752065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0RdbT8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgGPPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgGPPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:20:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34EFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so10653659wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ay69b5loZmqipTP77uDUcCD3CMZjdEh7hP0bruwli1k=;
        b=d0RdbT8MqbY1ZnJgHeIEd2m0zeXY1i+Lj+PmqGKQmqaLAJiZKpFm3oxosLkai3MZ0S
         9GSppOaArDiTYBQvupivke+FSk3+Cg0P1TwPggyBEFA8P2wxtI30qV6Y7JyAOlakSWrI
         7XT1YjyZjvfmUCiUFYRAy0BjbJXCYgz1uFTdgl7DUv/IAVH7i1uRm+edatyqJ7NVoblc
         JvKimwXgxv4KzksqAgPh/JXDw+DSf64M4xeWMlQ9bYXHSivCfwoxQFDZJLmqnaay/7Vk
         4zxaoCVUrydKo2k8oILHDbWI30tA8KvW6RT2eovrOz6JbQEb01y+dmuMDVMqA/Je4xhZ
         aoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ay69b5loZmqipTP77uDUcCD3CMZjdEh7hP0bruwli1k=;
        b=sBlhYrsjWo5gqrRA1GaHou0WjSzeLLEdVveLMBi4oMjCN1TQQELqrjkEFMkALAH66w
         uLwVjGljsHVG6opn/3Nhl59JrGSNNW+xMV0EgJUF+FI59bHcV+fDP42iryKWCQFDwDFk
         0TTIjuqjUKdVJkJ+DVMv0ritp7rQZS9iWdhocR7cXP7ydInEkXGustY6/haIo1c01Ron
         W+AIvX7xSyt7gPbLQX4e1UKmvBLLAAM5v67OslpjPoTBr4DxVUMPXtVzyr6Skef/I6/E
         wi5/vNe+fojItAD0krKg5LKByTlemUXDA0d93Fmbp3WK7ze6148XcVhvt+yJ2yMpcYHy
         2FeQ==
X-Gm-Message-State: AOAM5300vYDpNvGGT0W6tHgsFV/zGDQJj4dENg2D45BEUgpq4EczyUbb
        ARRhUfUnOKEh0fZhbqrljKatGA==
X-Google-Smtp-Source: ABdhPJytl8835REhXfZSH+IBujrm7NkmVewsF6kxmqbPplKu/iOWB6yHc9BFpHQOHY51qHxdg66EWQ==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr4851699wmi.49.1594912808280;
        Thu, 16 Jul 2020 08:20:08 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u17sm9877687wrp.70.2020.07.16.08.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:20:07 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 3/3] kgdb: Add NOKPROBE labels on the trap handler functions
Date:   Thu, 16 Jul 2020 16:19:43 +0100
Message-Id: <20200716151943.2167652-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716151943.2167652-1-daniel.thompson@linaro.org>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb honours the kprobe blocklist but doesn't place its own
trap handling code on the list. Add labels to discourage attempting to
use kgdb to debug itself.

These changes do not make it impossible to provoke recursive trapping
since they do not cover all the calls that can be made on kgdb's entry
logic. However going much further whilst we are sharing the kprobe
blocklist risks reducing the capabilities of kprobe and this would be a
bad trade off (especially so given kgdb's users are currently conditioned
to avoid recursive traps).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4b59bcc90c5d..b056afb1beec 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -183,6 +183,7 @@ int __weak kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return copy_to_kernel_nofault((char *)bpt->bpt_addr,
 				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_arch_remove_breakpoint);
 
 int __weak kgdb_validate_break_address(unsigned long addr)
 {
@@ -315,6 +316,7 @@ static void kgdb_flush_swbreak_addr(unsigned long addr)
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_flush_swbreak_addr);
 
 /*
  * SW breakpoint management:
@@ -405,6 +407,7 @@ int dbg_deactivate_sw_breakpoints(void)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(dbg_deactivate_sw_breakpoints);
 
 int dbg_remove_sw_break(unsigned long addr)
 {
@@ -573,6 +576,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_reenter_check);
 
 static void dbg_touch_watchdogs(void)
 {
@@ -811,6 +815,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 
 	return kgdb_info[cpu].ret_state;
 }
+NOKPROBE_SYMBOL(kgdb_cpu_enter);
 
 /*
  * kgdb_handle_exception() - main entry point from a kernel exception
@@ -855,6 +860,7 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 		arch_kgdb_ops.enable_nmi(1);
 	return ret;
 }
+NOKPROBE_SYMBOL(kgdb_handle_exception);
 
 /*
  * GDB places a breakpoint at this function to know dynamically loaded objects.
@@ -889,6 +895,7 @@ int kgdb_nmicallback(int cpu, void *regs)
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallback);
 
 int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 							atomic_t *send_ready)
@@ -914,6 +921,7 @@ int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallin);
 
 static void kgdb_console_write(struct console *co, const char *s,
    unsigned count)
-- 
2.25.4


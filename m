Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFB2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DD02065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTkZfuza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgFENWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgFENW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:22:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D9C08C5C4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:22:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so9120357wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B90P5vlRjcmc/HwmlTNh5ez1pbs9ga7qbMLqz94WeAc=;
        b=YTkZfuzam21k+uBt0acIuHPSgWol4t9gl77sHHb0fCSWzBFXoGCJliwFNTqsttd+AF
         qtG/4YyJse4VKAOpBl7G1blPNzVVKsKoDWzWj4UXjvgAdw8JX29fx0ejWQy08+oKs5Dv
         WprF3Nft8aVQ16a1n1ccsooduEpWognLe1f1P8GiXz3fGs+n1sDxlY2j7pTVqemseUk0
         kG/3KCz5+UlMh7EARDuudE7NV3tPDG1JBMqeRXYWUEOL5BhuPEHCfG3rWnS6tzJHeorJ
         7I8gAiNYwQcv0fx+jJ28f7Z/rJlJDa7HfKq4aPIFZYnKik7nbdG4smPYqqGN7o3UF27Q
         jS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B90P5vlRjcmc/HwmlTNh5ez1pbs9ga7qbMLqz94WeAc=;
        b=S/oB3MXVXa0Nxep9r8rRMoUsNrsMI4FFJm4Lbmsc6ceBLWqDMp/hvsNjxlJGOTarrP
         ftIEVcnb3oCGSlBHYoyeAudd2H2+corPbRWT5vr7M36KGJ1zR/aY8iENoddfikFRMn96
         fGLyahC+zffGgkfhRA+bI3AalO2SY12eS+knhvNt8y2ckq42ftbjhK8npO0+cRj3oKpc
         d532M8Gc7pvz5R+3aRX7PpW8xAPjHfrRyAdswFG2fUz3fEBaaTfUDZgQ0Dijm0jgcvkK
         XhQL7nYDh+G7SaKyy17npJt2VcpWnPPNOwb40vaEAthwwOFNxEid90SU+zonUPOBxGgi
         2iQw==
X-Gm-Message-State: AOAM530jngErDIsFy+oqjhx4/GjSDJit8b7+1l38e9Fid2+7y9En3CL8
        nGvqHO+PDEwMfqjCEK1dQWEY6A==
X-Google-Smtp-Source: ABdhPJyIAgP4Nu6MeJ5AZk9gWIJ9ycHXjBABtQl48AzXyVO5HV3VWQMGZqu06mldUl+jLuwYIcLGMg==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr2853782wmr.49.1591363345886;
        Fri, 05 Jun 2020 06:22:25 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 1sm11419211wmz.13.2020.06.05.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:22:25 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [RFC PATCH 3/4] kgdb: Add NOKPROBE labels on the trap handler functions
Date:   Fri,  5 Jun 2020 14:21:29 +0100
Message-Id: <20200605132130.1411255-4-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200605132130.1411255-1-daniel.thompson@linaro.org>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb honours the kprobe blacklist but doesn't place its own
trap handling code on the list. Add macros to discourage attempting to
use kgdb to debug itself.

These changes do not make it impossible to provoke recursive trapping
since they do not cover all the calls that can be made on kgdb's entry
logic. However going much further whilst we are sharing the kprobe
blacklist risks reducing the capabilities of kprobe and this is a bad
trade off (especially so given kgdb's users are currently conditioned to
avoid recursive traps).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4a2df4509fe1..21d1d91da4bb 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -184,6 +184,7 @@ int __weak kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return probe_kernel_write((char *)bpt->bpt_addr,
 				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_arch_remove_breakpoint);
 
 int __weak kgdb_validate_break_address(unsigned long addr)
 {
@@ -321,6 +322,7 @@ static void kgdb_flush_swbreak_addr(unsigned long addr)
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_flush_swbreak_addr);
 
 /*
  * SW breakpoint management:
@@ -411,6 +413,7 @@ int dbg_deactivate_sw_breakpoints(void)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(dbg_deactivate_sw_breakpoints);
 
 int dbg_remove_sw_break(unsigned long addr)
 {
@@ -567,6 +570,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_reenter_check);
 
 static void dbg_touch_watchdogs(void)
 {
@@ -801,6 +805,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 
 	return kgdb_info[cpu].ret_state;
 }
+NOKPROBE_SYMBOL(kgdb_cpu_enter);
 
 /*
  * kgdb_handle_exception() - main entry point from a kernel exception
@@ -845,6 +850,7 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 		arch_kgdb_ops.enable_nmi(1);
 	return ret;
 }
+NOKPROBE_SYMBOL(kgdb_handle_exception);
 
 /*
  * GDB places a breakpoint at this function to know dynamically loaded objects.
@@ -879,6 +885,7 @@ int kgdb_nmicallback(int cpu, void *regs)
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallback);
 
 int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 							atomic_t *send_ready)
@@ -904,6 +911,7 @@ int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallin);
 
 static void kgdb_console_write(struct console *co, const char *s,
    unsigned count)
@@ -1204,7 +1212,6 @@ noinline void kgdb_breakpoint(void)
 	atomic_dec(&kgdb_setting_breakpoint);
 }
 EXPORT_SYMBOL_GPL(kgdb_breakpoint);
-NOKPROBE_SYMBOL(kgdb_breakpoint);
 
 static int __init opt_kgdb_wait(char *str)
 {
-- 
2.25.4


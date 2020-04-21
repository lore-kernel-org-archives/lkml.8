Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9941C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946102073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VSh9fIaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDUHaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUHaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:30:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26150C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b8so6228922pfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqdk4PAIqG8nuCO40pczcx65QEF5mBrlQS3vzbn1WpQ=;
        b=VSh9fIaBN7oj6/8mumUuw27O4lo2HM/p1xnMxKeVTUJRCRPKX9hmBeg7FHypkhD8Ky
         ztyl7JHxbH+YNrWyTR5d2CeDf9sn9cy5PW1TDJ1NQqc6R5QGspGYw+5H9egt1u9/hvi6
         PWq8HFs1fccwJDfupHdUAU4lyxrweuGSWBYPYydmRckCUhqCJIp91adXeAcVVmpVlz0W
         qj3F8jypnJBnEbTRJmqzYW7CaK7WAUcFLuchpbjeYz0bBadHfSPJ8oqm6WXLy7SOmIve
         SYAuchx4PSrvwrpc9qQz9QEU0i4cvJ3+YobJsu2QlhCAWkS2Cf/CwRXilEvVtO8XULkz
         Loaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqdk4PAIqG8nuCO40pczcx65QEF5mBrlQS3vzbn1WpQ=;
        b=VYu/j+Q0qV+ci51tJOjQfmTl4oiFDqcQ5cyPE0mfqgzCUHhdBMov2/bRqHhmkyu1UW
         VWwsY3PFZm8fUo/hxx8i4kDRGwxOTOr+rJQ1I3WaYBOtxPNzzzWlo7Y2LrY+eAoNdYLe
         yvuF51noFoYeY8H885x5eg89rTJF2dh8FeojUH5Mm2rOYtdbfhC37jZNXjqeP2O5XPez
         jAR7dmlTk9Tgy2m1OPIji6bFzx2/CBNPTRiUIdJonwja5K1gYlIhaGHgctJT4YdIK4VY
         eJKj96JE938XKUsKl1Z6EZd20dXOL5ItuRWP5lhDd3g4YE5CRVp1yta/fj3YD35/Hv2f
         +x0Q==
X-Gm-Message-State: AGi0PuaS7Ck7TAHbUTxcq89Z29JP47tvAAOoh6Q2htQ1Nc4MHnN/8zfR
        sHjQt7aqLWW6M6XiiyAdfEqq9g==
X-Google-Smtp-Source: APiQypKQkEl7lxNFrJuCVmA5Wbfxd8Nd2XGxeohqm1S94pGJ8zgqHooREJT3fOB7mSU0szcSySZ8hw==
X-Received: by 2002:a63:79c9:: with SMTP id u192mr19776129pgc.7.1587454209688;
        Tue, 21 Apr 2020 00:30:09 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t7sm1535200pfh.143.2020.04.21.00.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:30:08 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 1/3] riscv: Remove the 'riscv_' prefix of function name
Date:   Tue, 21 Apr 2020 15:29:59 +0800
Message-Id: <2a1a03d7f9895dd92490b89c926fc7975015e449.1587453338.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587453338.git.zong.li@sifive.com>
References: <cover.1587453338.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the function name by removing the 'riscv_' prefix, it would be
better unless it could mix up with arch-independent functions.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/patch.h |  4 ++--
 arch/riscv/kernel/ftrace.c     |  2 +-
 arch/riscv/kernel/patch.c      | 22 +++++++++++-----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index b5918a6e0615..9a7d7346001e 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_RISCV_PATCH_H
 #define _ASM_RISCV_PATCH_H
 
-int riscv_patch_text_nosync(void *addr, const void *insns, size_t len);
-int riscv_patch_text(void *addr, u32 insn);
+int patch_text_nosync(void *addr, const void *insns, size_t len);
+int patch_text(void *addr, u32 insn);
 
 #endif /* _ASM_RISCV_PATCH_H */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index ce69b34ff55d..fb1e2b8fe254 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -51,7 +51,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 	make_call(hook_pos, target, call);
 
 	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
-	if (riscv_patch_text_nosync
+	if (patch_text_nosync
 	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 8a4fc65ee022..de28f23f65cb 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -11,7 +11,7 @@
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 
-struct riscv_insn_patch {
+struct patch_insn {
 	void *addr;
 	u32 insn;
 	atomic_t cpu_count;
@@ -43,7 +43,7 @@ static void __kprobes patch_unmap(int fixmap)
 	clear_fixmap(fixmap);
 }
 
-static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
+static int __kprobes patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
@@ -69,18 +69,18 @@ static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
 	return ret;
 }
 #else
-static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
+static int __kprobes patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	return probe_kernel_write(addr, insn, len);
 }
 #endif /* CONFIG_MMU */
 
-int __kprobes riscv_patch_text_nosync(void *addr, const void *insns, size_t len)
+int __kprobes patch_text_nosync(void *addr, const void *insns, size_t len)
 {
 	u32 *tp = addr;
 	int ret;
 
-	ret = riscv_insn_write(tp, insns, len);
+	ret = patch_insn_write(tp, insns, len);
 
 	if (!ret)
 		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
@@ -88,14 +88,14 @@ int __kprobes riscv_patch_text_nosync(void *addr, const void *insns, size_t len)
 	return ret;
 }
 
-static int __kprobes riscv_patch_text_cb(void *data)
+static int __kprobes patch_text_cb(void *data)
 {
-	struct riscv_insn_patch *patch = data;
+	struct patch_insn *patch = data;
 	int ret = 0;
 
 	if (atomic_inc_return(&patch->cpu_count) == 1) {
 		ret =
-		    riscv_patch_text_nosync(patch->addr, &patch->insn,
+		    patch_text_nosync(patch->addr, &patch->insn,
 					    GET_INSN_LENGTH(patch->insn));
 		atomic_inc(&patch->cpu_count);
 	} else {
@@ -107,14 +107,14 @@ static int __kprobes riscv_patch_text_cb(void *data)
 	return ret;
 }
 
-int __kprobes riscv_patch_text(void *addr, u32 insn)
+int __kprobes patch_text(void *addr, u32 insn)
 {
-	struct riscv_insn_patch patch = {
+	struct patch_insn patch = {
 		.addr = addr,
 		.insn = insn,
 		.cpu_count = ATOMIC_INIT(0),
 	};
 
-	return stop_machine_cpuslocked(riscv_patch_text_cb,
+	return stop_machine_cpuslocked(patch_text_cb,
 				       &patch, cpu_online_mask);
 }
-- 
2.26.1


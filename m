Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810262073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JYud2tk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgDUHaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgDUHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:30:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y25so6236475pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcpN/XiWAS11rrSyAPDkJjBumx0MxRm5WZVge7KIbAo=;
        b=JYud2tk/6N1f/uA3Roin6jRKpujCUbSPMrF6i9FoQB5BBtRZdMWS2QDvmbGoiKXuHQ
         TDJj/ngfSraP8Mgl2WbSqs24kJu21un2zHnQLwfvaMGYfPtOqrMKCa2QduYauvYJbz3h
         w0PahAK5WeZx4jNZPQla+DMTr3GaHJl5cUk/lxLT+tWlXON9MwDRw6ECsx77m6IrTsqB
         OtwIkUQ21sYyZFNNbMMJJkZZZaJbuHpbMVIROyl64ij3wzDGXwh317pbsSbtRiNHkxYX
         2MJYC8inZ2bawqZRbmJOyQduZ2SLoosXOpfV1h5k5eFX0TzlRK2hakQaLJS5eoo+1jgf
         lm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcpN/XiWAS11rrSyAPDkJjBumx0MxRm5WZVge7KIbAo=;
        b=BICpB95c8z4tPIiI8gUE2aFfdgyrgeDbSJv6/J/0kYlHF0chc593BrGeyr/ZXLzQYd
         1UuXPBw4D3yD2C9lW8FkiyDjWbDEKgsXI0uJWeJLskqCOIVXS3HqqpfcB5b2zA+iFp6C
         HpcB4fi9xmuZmSiqQmroaTRB1VD4OAXHEiuaOiirZVyLEzkqlRIS4YXHfDSojYZB25DF
         hcb70dOOFDFAM9Gq4jy0RlqZFBEqsqvoKDhqrJp7sWlJtN0KUAI4n9+CMeOBiMMy/NS1
         zxUif2rCUh+3rtWdXq/DzcxeJKFHLupfKZtbPjxTYPQO5w8XbWnJu1upgy7IaiXs6vzi
         7bXg==
X-Gm-Message-State: AGi0PuaMmZ7hmhIR3+KJnS89rQFNIlQVKXGbIOeUcRDD7Ijpn6Zw1Rg5
        hsfI7knZJ3SeXh3vBKGY+BjvAg==
X-Google-Smtp-Source: APiQypJAkMhSjNf221KM9EVsZIhg2TPkidVKczHxUwbnnXw5dVzEe4kTer4jWi34bhipomvboJ76vg==
X-Received: by 2002:a63:a519:: with SMTP id n25mr19759868pgf.256.1587454213662;
        Tue, 21 Apr 2020 00:30:13 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id t7sm1535200pfh.143.2020.04.21.00.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 00:30:13 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 3/3] riscv: Use text_mutex instead of patch_lock
Date:   Tue, 21 Apr 2020 15:30:01 +0800
Message-Id: <4d5bf5e362523d48a89891942eb986d98b0584e1.1587453338.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587453338.git.zong.li@sifive.com>
References: <cover.1587453338.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need the additional lock protection when patching the text.

There are two patching interfaces here:
 - patch_text: patch code and always synchronize with stop_machine()
 - patch_text_nosync: patch code without synchronization, it's caller's
                      responsibility to synchronize all CPUs if needed.

For the first one, stop_machine() is protected by its own mutex, and
also the irq is already disabled here.

For the second one, in risc-v real case now, it would be used to ftrace
patching the mcount function, since it already running under
kstop_machine(), no other thread will run, so we could use text_mutex
on ftrace side.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/ftrace.c | 13 +++++++++++++
 arch/riscv/kernel/patch.c  | 13 +++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index fb1e2b8fe254..08396614d6f4 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -7,10 +7,23 @@
 
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
+{
+	mutex_lock(&text_mutex);
+	return 0;
+}
+
+int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
+{
+	mutex_unlock(&text_mutex);
+	return 0;
+}
+
 static int ftrace_check_current_call(unsigned long hook_pos,
 				     unsigned int *expected)
 {
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 8acb9ae2da08..5805791cd5b5 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -5,6 +5,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/stop_machine.h>
 #include <asm/kprobes.h>
@@ -18,8 +19,6 @@ struct patch_insn {
 };
 
 #ifdef CONFIG_MMU
-static DEFINE_RAW_SPINLOCK(patch_lock);
-
 static void *patch_map(void *addr, int fixmap)
 {
 	uintptr_t uintaddr = (uintptr_t) addr;
@@ -49,10 +48,14 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
-	unsigned long flags = 0;
 	int ret;
 
-	raw_spin_lock_irqsave(&patch_lock, flags);
+	/*
+	 * Before reaching here, it was expected to lock the text_mutex
+	 * already, so we don't need to give another lock here and could
+	 * ensure that it was safe between each cores.
+	 */
+	lockdep_assert_held(&text_mutex);
 
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
@@ -66,8 +69,6 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 	if (across_pages)
 		patch_unmap(FIX_TEXT_POKE1);
 
-	raw_spin_unlock_irqrestore(&patch_lock, flags);
-
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_insn_write);
-- 
2.26.1


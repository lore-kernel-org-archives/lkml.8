Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59866C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE42208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Dp2cyuiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgDGOrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42902 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgDGOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id e1so1321329plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYuVFCggRo9I8GvVGPv9n9TMuc3y+S8enCWZ0r9b2Rg=;
        b=Dp2cyuiV3Zq2urQAMh7yiuZ3tl4kdNTj0CnDofGx5CYcevhuKy6HPSG4E7W9b0Q7Y0
         2uRjZtKohnI7E8ZgkiEw8px7x+qMhXPYizZnM37q5PEOBdTSXVfkFm1rceB9zklVQOkX
         1LPAhRh1htLQX11lcxKXodjYAR/tQZSpZ31ln21dus97h07gwSbhgcUgQebQncnDJVxG
         FTmWLZgq3KfB2/OjR+yXpBM8YXWRHKJp+WLQ2haAVfKXzKbFkVmcTQIrch4ZHhaQgeM+
         pnouesMXOGAoFz4QI/DgUrFHdTMGktQ4jJzfrqzYGwFkYxCBwnkXraurAUu5y22zedFW
         bdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYuVFCggRo9I8GvVGPv9n9TMuc3y+S8enCWZ0r9b2Rg=;
        b=jig31crtYLQl3RvA3ZMaxaTlZ2VbTSwgPaT0qjtkZ8py3ZoJ+S/ACRn8ij0/pN0ibP
         1xt/2Gz5FTYs+ew8vu899oKFJRqbow+L/WiRGFMP7XGgiGZVVpnuCP2CzAlFN5galCzJ
         CTag9FETt/0kJhzrzOcF+ovo7DJ+Ztrm3O1pwtZl7DbYiCqvcuBpRZ6yya1gMOLRV3gk
         znvkuen4Pi8cpDJo1Ka2MEsJUJvVFEpQtgHik3pIuuXHScM/YDj1NSImzWuaxmVJ+pEF
         5Hz04oZF96oihe+CMSObujCMlbTejUzKZQ1kWInyB/RybHt3p+dQGROJZdLeYo5q7cTm
         w2Cw==
X-Gm-Message-State: AGi0PuYkTzAerevF4xrFRDziVbJlMIOuXJIlJOGLEIUtKxatfD1SJTXw
        5Fg/+Z+T0+ea4eAItR8YTHE9YBtAtdo=
X-Google-Smtp-Source: APiQypJeg8iV+Is/jjghotuLsws3LW3MbtvTfDLRSrO+mQADIEt6UxaVlUqnEGdv59l9qdnUHdBNhw==
X-Received: by 2002:a17:90b:4c84:: with SMTP id my4mr3182095pjb.3.1586270824425;
        Tue, 07 Apr 2020 07:47:04 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:04 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 3/9] riscv: patch code by fixmap mapping
Date:   Tue,  7 Apr 2020 22:46:48 +0800
Message-Id: <0b6ad2759b47731a83008b46dbbed7c92e68cae2.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On strict kernel memory permission, the ftrace have to change the
permission of text for dynamic patching the intructions. Use
riscv_patch_text_nosync() to patch code instead of probe_kernel_write.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/riscv/kernel/ftrace.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index c40fdcdeb950..08396614d6f4 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -7,9 +7,23 @@
 
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <linux/memory.h>
 #include <asm/cacheflush.h>
+#include <asm/patch.h>
 
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
@@ -46,20 +60,14 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 {
 	unsigned int call[2];
 	unsigned int nops[2] = {NOP4, NOP4};
-	int ret = 0;
 
 	make_call(hook_pos, target, call);
 
-	/* replace the auipc-jalr pair at once */
-	ret = probe_kernel_write((void *)hook_pos, enable ? call : nops,
-				 MCOUNT_INSN_SIZE);
-	/* return must be -EPERM on write error */
-	if (ret)
+	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
+	if (patch_text_nosync
+	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
-	smp_mb();
-	flush_icache_range((void *)hook_pos, (void *)hook_pos + MCOUNT_INSN_SIZE);
-
 	return 0;
 }
 
-- 
2.26.0


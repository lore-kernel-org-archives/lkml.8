Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B01C2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664C320747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GoQ2lksF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgDHH5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46941 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgDHH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so2038162pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XkJsQ5wK/x/TlqEbA+mDNHgNHjaEj7vOian5h3Az/dI=;
        b=GoQ2lksF14YYCaOtMuoKYM7vT3Yx9eYSzDJeBCT1onK+swzFQVmrxQNz8A0Tx1UV7w
         N4ukqiuGUz7US9jG6G1pNTsCLz0BIPllR5BjjArtNUhj2U6cj8SyMJrr0nyeieYkUBWS
         lRuu0Ksmv3TE6giCaCh0dC879/19i4O751Yez/1Q6bLNmfw/Avdp1LOLgu3G/M+9XGP2
         OD2j9gih+Y+EHJJMt6O6mMQ8IEtjo/iu/nAwwpROg7jmT5q2oS8i+Fyi2h759BYMgIic
         FXmTCxNbmRzSoqCsLEcV0QdM/JF3rA1UzVR/48veI1V1jXkwkN5Aj5Sh4zsr73xcomL4
         u3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XkJsQ5wK/x/TlqEbA+mDNHgNHjaEj7vOian5h3Az/dI=;
        b=gVfXTGlSc/OZ+TsYaZOTovB/9OGGKF836bZrkN7pIV3FCSgWcyqmYWVkBNCyja34AR
         COwllzU6EUxLhoH6YOmi2JxfsGUekkvM8g0H/E+fwpyCc5oP83r+xOoKmyrbR4V+fK40
         FTP3AET6kuamTl+zEolyKuX2iD+2HQSQByb4ayJJalMS7aG7xgEf/33cwPCkdXITFU7p
         kw54Zzwbw+wcj3oweUtP3iO9Qlt/oXXXVHk4fXMSOyBdZMBz11JypDGXH/DO6Gq5VxWp
         mNBciGTaY0iRfuqczXxHASqVPgQCpe73OArutB1TVziS0B1ibuz4QOlxMvqJ4zysoCrR
         aZlQ==
X-Gm-Message-State: AGi0Pub8qklx6lABobF7yD6A8BbCW4U56J9g+1JfFVT+QkaBEovgHmto
        jPLfBYilH2VEpm4E9HxqxGes4Q==
X-Google-Smtp-Source: APiQypJAFMM/eXRWkh6FXOGZKFYt6ev58qcGDr+z+KrnA0/S0UYY70C6txy6deaM8WjT5DJ2UcB/OQ==
X-Received: by 2002:a62:1e84:: with SMTP id e126mr6071812pfe.315.1586332634924;
        Wed, 08 Apr 2020 00:57:14 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:14 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 3/9] riscv: patch code by fixmap mapping
Date:   Wed,  8 Apr 2020 15:56:58 +0800
Message-Id: <27f31750f58cd0ad2805579b16b001aa88103688.1586332296.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
References: <cover.1586332296.git.zong.li@sifive.com>
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
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
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


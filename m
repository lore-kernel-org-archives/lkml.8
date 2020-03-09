Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C92C2BB8A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E9120828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZYOiXfiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCIQ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:56:13 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39577 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCIQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:56:09 -0400
Received: by mail-pj1-f66.google.com with SMTP id d8so108633pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=seWJfto8ScXH/WTie1kGmp0AZpPcjTPuoxrfVsKEou8=;
        b=ZYOiXfiY0tuckfLvllImLc1PbkvyeyMedOVlEVYN8R2vuqmWY3Pk58X31O6HtH1cMQ
         F4wo1cSGiZlx5pD2FM2mTALZXAGQH8b7G9UU8YcW1TVdW8l9z+94mEs2fqOCJ8XnGhxX
         oGfN+MV06tnAAhEY1DcVv6yHEnbmLysfoigH9gIClmGeVe7y4ctJGqO4ScJCk8JPIEP3
         3y92APRfOMk/ipYJEKKDf6HnMqwP1duhPyvlvgAYg2cl4CwZ0yLqOMoYxRm7EI33JsG/
         Wq4+HmnQATpQgd0JT1TJVWY1eznEda9oruz+3TYhG8zlO01YOkECSxW8VWmkyPYZDujq
         evlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=seWJfto8ScXH/WTie1kGmp0AZpPcjTPuoxrfVsKEou8=;
        b=TtfE0KbpCpiLZo18Xo9noSLD+iTeu7VZZsWd/e6whw/NEZICZDYoyHwtlXHtOluBxR
         zibGs9f2TuBio8KniS0ld9TbpUlDBAsBW1pidzQzOKsL830/eGBifPvTDUs9i9sCTRTL
         z774AoD+ZGBcINFTRVtTVDAHscJR5JvXLWftEU5f9Wxo+k2UXMr9OiHsETjQgENtpGTm
         lNtOj35tGuJoJAGB+HTDhIry5OEYeFdPc1vlCspaVnVAf2FUR8FyLYiFdyD0TGaAS9jf
         l5apWTISCbdE6LaollvqDotRCmvT7qF6WkXzOev5Yvc6HyoDUmCshpA3GmRtYBb7I4xK
         IDhQ==
X-Gm-Message-State: ANhLgQ1mm/OSz40u8ooY1XRPWoQjzQJZMjNPtHO1HLQg6GDZyfCCRBuJ
        Pkd1Wifjlh/HenGtoc9qpyu3Ag==
X-Google-Smtp-Source: ADFU+vsyfd5fnD7Id1YJ9cBBLv47NvOkkKzY+u5QBKpwxGSA2UnrFBvvrspWMG1D+5N/ft+289Ji3g==
X-Received: by 2002:a17:90a:202f:: with SMTP id n44mr255862pjc.150.1583772967759;
        Mon, 09 Mar 2020 09:56:07 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:56:07 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 9/9] riscv: patch code by fixmap mapping
Date:   Tue, 10 Mar 2020 00:55:44 +0800
Message-Id: <b414b96a2d9b2d2837550306a4c71b8b0f2e6c7e.1583772574.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
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
---
 arch/riscv/kernel/ftrace.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index c40fdcdeb950..ce69b34ff55d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int ftrace_check_current_call(unsigned long hook_pos,
@@ -46,20 +47,14 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
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
+	if (riscv_patch_text_nosync
+	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
-	smp_mb();
-	flush_icache_range((void *)hook_pos, (void *)hook_pos + MCOUNT_INSN_SIZE);
-
 	return 0;
 }
 
-- 
2.25.1


Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14ECC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A35E24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5n4a+qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBSAIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:08:51 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35201 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSAIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:08:49 -0500
Received: by mail-pl1-f202.google.com with SMTP id v24so11066410plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tR8HWR8eyR6LK2Q8Pau54PB7Q0F7v08515rGGzIGLyo=;
        b=b5n4a+qzRVoc9p1sMaGcT/avtJg0p34XcrSWSeo6yE4SNClAhGvDWJAoBExyHPO3/M
         PugrHM1VkHW3JMcUgboaltvnYlevaK0mhr2LWRqBIjWKqlzzLgwrVNQ3WddvYgyZ590f
         EhOJfkNAkqMLFx8slzXRty6uvqQquUIPBM/qiVSwThzajXQpK2du4fa3QUrFH6uSuwiw
         w0rKl/E1ibiFUvV8qBI2200bkOB5w3Pa6/gAJnn7yIMSbqnGEL5kL5QKEghpUKm+Uin5
         /fxQ/rvydrg0/k7tj3penT6Yk7Wsvz1o47oE7V6wluUfG2Bz66AXSiCps8hDwWSTAkqK
         OklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tR8HWR8eyR6LK2Q8Pau54PB7Q0F7v08515rGGzIGLyo=;
        b=G5cH0mYC54WNWXyBXMoVHz7iS8GV+kM/8PnTTJFiOkgtGTpAFQN+sL5TfyZ//bWZF7
         rxVUt79ivE6XDe+M/RvwM6ah+wkF8lSRfSsHxSyZnC38hCUQKPaaId6KaLNYTBSSkdnD
         mOnrIhnVejLKWI87NJ+IOrg1wWg7NCnkYz+JqPUvCfGe2BIlmvI2Vk2OUhdzs6uA8s1o
         hA6ERHnK8xQACBtCUhKLVdo6/woYgmBQl34zvLxc/LNHdbIV9rgQhgz3Bsf+76IXx4fs
         pPAzosxMo5yAZiilcHCrj2UBzHy75ErZ4MEczVYc7qEc+wRZdkBgcpHH5wr9zgmEwcHw
         mnIQ==
X-Gm-Message-State: APjAAAUC5DonpIIkSvnY2Dik90E0I3RNq9Xcfyi44oejC52UCG8rFs1t
        hssBnoFhXpbHGVJDbFGiYV5EXB+0gpJ6wI9B1A4=
X-Google-Smtp-Source: APXvYqxOXrqP7Hvugsa8IU49Lr4UDLSOLYebYtchIFGNM9hOXl0Twc3BrDAcc+jG4ELWfvylhcvwGTzbahuYoyApHyM=
X-Received: by 2002:a63:3d44:: with SMTP id k65mr4554387pga.349.1582070928011;
 Tue, 18 Feb 2020 16:08:48 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:11 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 06/12] arm64: preserve x18 when CPU is suspended
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't lose the current task's shadow stack when the CPU is suspended.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 8939c87c4dce..0cde2f473971 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 12
+#define NR_CTX_REGS 13
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index aafed6902411..7d37e3c70ff5 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -56,6 +56,8 @@
  * cpu_do_suspend - save CPU registers context
  *
  * x0: virtual address of context pointer
+ *
+ * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
  */
 SYM_FUNC_START(cpu_do_suspend)
 	mrs	x2, tpidr_el0
@@ -80,6 +82,11 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+	/*
+	 * Save x18 as it may be used as a platform register, e.g. by shadow
+	 * call stack.
+	 */
+	str	x18, [x0, #96]
 	ret
 SYM_FUNC_END(cpu_do_suspend)
 
@@ -96,6 +103,13 @@ SYM_FUNC_START(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+	/*
+	 * Restore x18, as it may be used as a platform register, and clear
+	 * the buffer to minimize the risk of exposure when used for shadow
+	 * call stack.
+	 */
+	ldr	x18, [x0, #96]
+	str	xzr, [x0, #96]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.25.0.265.gbab2e86ba0-goog


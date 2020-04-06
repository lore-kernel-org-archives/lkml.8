Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ABEC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7ABD24971
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZgUXhLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgDFQlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:41:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:54096 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbgDFQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id c33so13486889pgl.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FvIJZaGomfz5bQTqJN2U0Xo4/dMI8mtkhTC7egpm8RA=;
        b=sZgUXhLMxuUZHoqYFcqJQyMtRrVeB4vbIJgZfI8vPE3ap9A/9BT16xYBgEZfJZwzHb
         p/Xb5EGHwP5/CHALYTdDgmSLbcPrGZxAna83nSg6gIywsrUh7VegvbRlWKSidmTZaduL
         JkIi3FLIB3RLFCMs8/R2AIvOjODoY4FM+pu6UiLLtsoUZ4FIpMSRZZd/sl1DrxuOHLRs
         qsTLwGT7TZOTmsB4zwdErv1k7eKdBWOhQ0UgfSaLWeBzdHI/14RLXcoxTbmTmzGS4PJz
         S1BSe2jfOXJpexnv2HjTJdH928LuWNUeCfCevn3GUQ3kWhph4qWJWBu706wq7G4VUNsy
         Vq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FvIJZaGomfz5bQTqJN2U0Xo4/dMI8mtkhTC7egpm8RA=;
        b=cN5tWGVY8kOFKYR8tlnmW54ey4apofauGwxs/7St61HK+m8J/0I5JLUHKzRyVYQ22s
         dCOMoBroUst+iNldv8MunZlC2al8zVN4wG/doFyxzAlg/1D7Gp1rarpScvaBSYXtW1mj
         tA86x1fCiemfxf9sNYAdIJFPOhOGZp7dxfX7PUHqvtVvfmWJvj2yYUpgBLCE1GxFrW52
         /BwncSRmlB0lr/vcpR5k4lTeELKytxH54XC8frrZEV46qtkdzFKmPSdfe+qZb77C9FZN
         LV7Ofk+wqVF47RNKXB6qPbqSgBL6EgLRneHz6RDlks9JF9vV3laaK0q2H6XOd4KzN1D0
         fYCQ==
X-Gm-Message-State: AGi0PualSK482Cjr9pxzeZt5S9rvtFl7Vrwfh2bnGuFaTTYLf9yKKFpm
        W2PmVx76j1nm3YlTvIPtKoBDNRYdcvciIgG2+ZY=
X-Google-Smtp-Source: APiQypIFwmNrjKh1lQZCso9eQPW5DK0TW2vYCZpfEPndLBGmeeUElj0RyNkfI+/Jw0+mhfmcbtmfQfN+X3LYM4MOsRg=
X-Received: by 2002:a63:9550:: with SMTP id t16mr19437932pgn.300.1586191308872;
 Mon, 06 Apr 2020 09:41:48 -0700 (PDT)
Date:   Mon,  6 Apr 2020 09:41:15 -0700
In-Reply-To: <20200406164121.154322-1-samitolvanen@google.com>
Message-Id: <20200406164121.154322-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200406164121.154322-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v10 06/12] arm64: preserve x18 when CPU is suspended
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
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
index 197a9ba2d5ea..ed15be0f8103 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -58,6 +58,8 @@
  * cpu_do_suspend - save CPU registers context
  *
  * x0: virtual address of context pointer
+ *
+ * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
  */
 SYM_FUNC_START(cpu_do_suspend)
 	mrs	x2, tpidr_el0
@@ -82,6 +84,11 @@ alternative_endif
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
 
@@ -98,6 +105,13 @@ SYM_FUNC_START(cpu_do_resume)
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
2.26.0.292.g33ef6b2f38-goog


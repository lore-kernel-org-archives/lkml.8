Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B06BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A3D22262
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5q7QBjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506888AbgDPQNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506864AbgDPQNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:13:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5DC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 62so3575801pgh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Kugk+73vmOylC3TFtzHwjlOoaJ/Fe5NzWOKKOj4AXU4=;
        b=W5q7QBjkw4JghTfPUShlkXNs2sDNOGOuiYOGElC1wAONEdOLPNJ/uNyxDMDXjlRLf4
         Pa2+Zrq7EyaDCJp1Sp3AVQn9w8BtLyDEdMdL2575OXgi5fxdIK+8sv379QKTbap2WvC+
         NiN0Q+AVLm5GD6wuH4dSCDO0b66W2nLZ0Xzrofc/J1m+UZX9J2yLmiCSxELYozVXH1uQ
         vVBs/CwtxyA+WTpTHf3NFy3LgZlj4g/kbXfkm3SRVstHLiNAqtUgbanoiYUosQNk9PUW
         zvsM3kOiPbsMtH3WUpHwLBRuJopu9sSmI6vIv47ooOAFB9l9KFuPLGhVXV6robI3fW4H
         ch8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Kugk+73vmOylC3TFtzHwjlOoaJ/Fe5NzWOKKOj4AXU4=;
        b=shQXNUHX+2ymsrLZ+qbvgLSEQ+n1Eoj+jeFw0lzQS9eG/MuFv9KFkLybEQZqhbOoBj
         4nyOZ30fVI3TaJg0TH6KXnhkQFJ6bZugSt7ekEp8X05MklbnjUskXkKbsnlwEyUehKLB
         IqpcqfP4OWfVbqP50J9M5LHopWo26zFDERJ7D+JAEaoXpLMBv8nGdhNv1gV9UNFmfMQJ
         aRmFxUp1APThzUayDpV22/mw89Ur2wG1LdJ2WHvg6jmClHgCzm0Zh3WhMSFy7RqQN5dO
         S642L3gCwgJ4Rx6DUusHXB5Krt+444yIHk2AmVXVfnW56xD+ExOIQJHR3/XVdRZNrNlv
         VTgQ==
X-Gm-Message-State: AGi0PuY32S+U5avAsqQJFlQGYP91/PP22O6HPmPe1lIPiwpTKCo2/9/3
        gPUq9JqTeBUFn+ncU2tOGJ/q/SsnAcertyqtAgs=
X-Google-Smtp-Source: APiQypItSg+rLQgEmLkTBr9HxWTvnV3rSuRsTSpO5mKzGKaJOiL7a4R9QX9rkJEWAZiMSzM5JWs5mbOwhT82CTPYKHg=
X-Received: by 2002:a63:9e54:: with SMTP id r20mr8539917pgo.301.1587053584336;
 Thu, 16 Apr 2020 09:13:04 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:12:39 -0700
In-Reply-To: <20200416161245.148813-1-samitolvanen@google.com>
Message-Id: <20200416161245.148813-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200416161245.148813-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v11 06/12] arm64: preserve x18 when CPU is suspended
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
2.26.1.301.g55bc3eb7cb9-goog


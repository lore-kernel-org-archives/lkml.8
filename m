Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B274BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25B22054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TVjmeJRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbgEMXG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731815AbgEMXG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:06:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8BDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:06:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so416587pfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMogoehN6gd8yEcUzfto82bogvcHTiAGCMH4pO/0ves=;
        b=TVjmeJRT30wG3o5oee/nQvtjayTS9UEmO1IKTN3/YROyngl0ARUX+gqTeIneHeojqM
         gYBxNYwyp5blo8Rorot/HCMhVM8Rsy7slg+/x8RdQoCiT11cFofCu+3DTSKptK731mBX
         yq4/rABaceMa8DkAadYUlzIg9W0ocTQiCTsT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yMogoehN6gd8yEcUzfto82bogvcHTiAGCMH4pO/0ves=;
        b=ZDQOY4HJ5dgIvy27ZjoaRIBfkk3J/nPUCDJPZRBdgMXk6B0mj5Xu99qXVDoz3vmiE3
         utzSES1oqOe/awybzN1zjh+0IQ+uPcshcwqulNzkIBzS2ZGaVBA3EKgpn7IvAHHk4SZz
         vgm4jV94EHvd9SQNCLGXVtNxK3hCis7NbJ8+mg6gunudHsvKd5vFzE/fGZmdY2eJwAFy
         XHey4CvQy3qALiWxHRe0JM7pzAaa/S1xTdAidBXI0TOgMwyYOOzJeZpt3sPpmi6w6usU
         ipDAm9jK5t2lv8+6v+f86Ougk/C5zJDTp1acyZFYz1sFl9k3X5HnfNJ9/CT4yanxiQ9g
         IOnw==
X-Gm-Message-State: AOAM532QJdkNJitzgUPEJ8HSmkLAjclDMex6vfKvODZcBZbDCILQ5AC2
        4yMlw6KRr84LRE0/1Zd4Pbmcww==
X-Google-Smtp-Source: ABdhPJzzVabiFt1inZIi4trNKtrwiawtGgHCOPmCLYH5yl1Fukr15nZDmHm+dhqQ3Y059dh1zVOT2w==
X-Received: by 2002:a63:3545:: with SMTP id c66mr1444745pga.82.1589411216357;
        Wed, 13 May 2020 16:06:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d184sm513936pfc.130.2020.05.13.16.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:06:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, liwei391@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, sumit.garg@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Call debug_traps_init() from trap_init() to help early kgdb
Date:   Wed, 13 May 2020 16:06:37 -0700
Message-Id: <20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new kgdb feature will soon land (kgdb_earlycon) that lets us run
kgdb much earlier.  In order for everything to work properly it's
important that the break hook is setup by the time we process
"kgdbwait".

Right now the break hook is setup in debug_traps_init() and that's
called from arch_initcall().  That's a bit too late since
kgdb_earlycon really needs things to be setup by the time the system
calls dbg_late_init().

We could fix this by adding call_break_hook() into early_brk64() and
that works fine.  However, it's a little ugly.  Instead, let's just
add a call to debug_traps_init() straight from trap_init().  There's
already a documented dependency between trap_init() and
debug_traps_init() and this makes the dependency more obvious rather
than just relying on a comment.

NOTE: this solution isn't early enough to let us select the
"ARCH_HAS_EARLY_DEBUG" KConfig option that is introduced by the
kgdb_earlycon patch series.  That would only be set if we could do
breakpoints when early params are parsed.  This patch only enables
"late early" breakpoints, AKA breakpoints when dbg_late_init() is
called.  It's expected that this should be fine for most people.

It should also be noted that if you crash you can still end up in kgdb
earlier than debug_traps_init().  Since you don't need breakpoints to
debug a crash that's fine.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
This replaces the patch ("arm64: Add call_break_hook() to
early_brk64() for early kgdb") in my recent kgdb series [1].  If I end
up re-posting that series again I'll include this patch as a
replacement, but I'm sending it separately to avoid spamming a pile of
people another time with a 12-patch series.

Note that, because it doesn't select the "ARCH_HAS_EARLY_DEBUG"
KConfig option it could be landed standalone.  However, it's still
probably better to land together with that patch series.

If the kgdb_earlycon patch series lands without this patch then
kgdbwait + kgdb_earlycon won't work well on arm64, but there would be
no other bad side effects.

If this patch lands without the kgdb_earlycon patch series then there
will be no known problems.

[1] https://lore.kernel.org/r/20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid

 arch/arm64/include/asm/debug-monitors.h | 2 ++
 arch/arm64/kernel/debug-monitors.c      | 4 +---
 arch/arm64/kernel/traps.c               | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..e5ceea213e39 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -125,5 +125,7 @@ static inline int reinstall_suspended_bps(struct pt_regs *regs)
 
 int aarch32_break_handler(struct pt_regs *regs);
 
+void debug_traps_init(void);
+
 #endif	/* __ASSEMBLY */
 #endif	/* __ASM_DEBUG_MONITORS_H */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2..15e80c876d46 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -376,15 +376,13 @@ int aarch32_break_handler(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(aarch32_break_handler);
 
-static int __init debug_traps_init(void)
+void __init debug_traps_init(void)
 {
 	hook_debug_fault_code(DBG_ESR_EVT_HWSS, single_step_handler, SIGTRAP,
 			      TRAP_TRACE, "single-step handler");
 	hook_debug_fault_code(DBG_ESR_EVT_BRK, brk_handler, SIGTRAP,
 			      TRAP_BRKPT, "ptrace BRK handler");
-	return 0;
 }
-arch_initcall(debug_traps_init);
 
 /* Re-enable single step for syscall restarting. */
 void user_rewind_single_step(struct task_struct *task)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..8408e8670f2e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1047,11 +1047,11 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
 
-/* This registration must happen early, before debug_traps_init(). */
 void __init trap_init(void)
 {
 	register_kernel_break_hook(&bug_break_hook);
 #ifdef CONFIG_KASAN_SW_TAGS
 	register_kernel_break_hook(&kasan_break_hook);
 #endif
+	debug_traps_init();
 }
-- 
2.26.2.645.ge9eca65c58-goog


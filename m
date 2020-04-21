Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9AC55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5170720724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jCiq2fay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDUVP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726362AbgDUVPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A4CC061BD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:15:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x15so2927695pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04XZYo5fXA8jjjQEMhm6NIaDkuVBkhqneNWDzQVam7g=;
        b=jCiq2faydL3OiQdwG7cFDruVuRAgHnscmd8JDvfJ5iyBf/cSxretgz78r9MZid2wQs
         pHJQK1BpUlFelzuAEcGpKwyg6UjVOQYEIr4jz1kSFuGgbKFAQErtbb7pXwX5etMp0BBm
         kJHMsRmyCSl2NnT1g3J8PRJwfFJCUJQNithtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04XZYo5fXA8jjjQEMhm6NIaDkuVBkhqneNWDzQVam7g=;
        b=JxozHp1fih8AGBdCSJlfvLz0/tzmNIgEeEr/2IydfAdKGwWEbSZbkmbKPE/6SgqFlk
         U8dCImclxco/OxnJbfnCj2h2CfRru/sPZdiSadQi6GR4y6Iy8K/KYzC3qEIh9VsbKRET
         DY7tU3CIU0tt5tRlrph7afeLMyAnw07A5SzSpcy8+I6Zjl/5LZ9QoOm1BdA5bbK6JJ/M
         knfiG4MIVArB00HkhW3Nzvf7GPRalIEJEVciuK1A7bIcsFgzS/Cc+kaSMYelQ2b7uA9h
         ZaRECVelfX3hHfWft4hZaQdD8TQc1KNDzpCt/wHF1mNlhMb7YFQqtfRAWqsw0+tLLwJQ
         uQGA==
X-Gm-Message-State: AGi0PuZ3CdO+svF/YVRlOd6vuah6Gs8x6pyFYOLrBYzAD7YgzBoMYyU+
        UBm7wVehfBSjwQ1OPdd9nN9Uuw==
X-Google-Smtp-Source: APiQypKuBADi/9vxdm+kBSaWN7ML+MvxdmBicivB0CG8boqZPIB1lUO05+yH8k3NEjmmzMx6G4rXkw==
X-Received: by 2002:a63:4d5e:: with SMTP id n30mr23391637pgl.154.1587503724930;
        Tue, 21 Apr 2020 14:15:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] arm64: Add call_break_hook() to early_brk64() for early kgdb
Date:   Tue, 21 Apr 2020 14:14:43 -0700
Message-Id: <20200421141234.v2.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make early kgdb work properly we need early_brk64() to be
able to call into it.  This is as easy as adding a call into
call_break_hook() just like we do later in the normal brk_handler().

Once we do this we can let kgdb know that it can break into the
debugger a little earlier (specifically when parsing early_param's).

NOTE: without this patch it turns out that arm64 can't do breakpoints
even at dbg_late_init(), so if we decide something about this patch is
wrong we might need to move dbg_late_init() a little later.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Changes in v2: None

 arch/arm64/include/asm/debug-monitors.h | 2 ++
 arch/arm64/kernel/debug-monitors.c      | 2 +-
 arch/arm64/kernel/kgdb.c                | 5 +++++
 arch/arm64/kernel/traps.c               | 3 +++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7619f473155f..2d82a0314d29 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -97,6 +97,8 @@ void unregister_user_break_hook(struct break_hook *hook);
 void register_kernel_break_hook(struct break_hook *hook);
 void unregister_kernel_break_hook(struct break_hook *hook);
 
+int call_break_hook(struct pt_regs *regs, unsigned int esr);
+
 u8 debug_monitors_arch(void);
 
 enum dbg_active_el {
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2..59c353dfc8e9 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -297,7 +297,7 @@ void unregister_kernel_break_hook(struct break_hook *hook)
 	unregister_debug_hook(&hook->node);
 }
 
-static int call_break_hook(struct pt_regs *regs, unsigned int esr)
+int call_break_hook(struct pt_regs *regs, unsigned int esr)
 {
 	struct break_hook *hook;
 	struct list_head *list;
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 43119922341f..96a47af870bc 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -301,6 +301,11 @@ static struct notifier_block kgdb_notifier = {
 	.priority	= -INT_MAX,
 };
 
+extern bool kgdb_arch_can_debug_early(void)
+{
+	return true;
+}
+
 /*
  * kgdb_arch_init - Perform any architecture specific initialization.
  * This function will handle the initialization of any architecture
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be5c573..a8173f0c1774 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -1044,6 +1044,9 @@ int __init early_brk64(unsigned long addr, unsigned int esr,
 	if ((comment & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
 		return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
 #endif
+	if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
+		return 0;
+
 	return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
 }
 
-- 
2.26.1.301.g55bc3eb7cb9-goog


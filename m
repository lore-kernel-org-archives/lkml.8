Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3404C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD547246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197014;
	bh=A1N8eTJy0wfQbLoi57GZ4ERDw7BhnmsCr0Z6pNY66RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WkZIpLfgQjohwuCtxvXVZMxZCB9I9RzT2J3XD5TBMxm/MYoP8htgw6EMvuUYrs6Nr
	 OXO4V31rXuhrEpenkG2ggiVgse1TbVwgMV+As2mPXuBb4Fz1byquOxj7oKgJzWPiRw
	 Ymxm7EqwxaFBD4ky9kTurk0m0jsXGvNUoiS8xWV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394351AbgAPRuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406190AbgAPRpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E35246C4;
        Thu, 16 Jan 2020 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196755;
        bh=A1N8eTJy0wfQbLoi57GZ4ERDw7BhnmsCr0Z6pNY66RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjMLgBrJ98s24A0Z3F9KxM5gGbQXkZe/5gz6fsOl1ofXkwMnh1ARLly4KX6gOG6ef
         XdS6gz4sPLVPf3kvp6Wk1nJ2NcREC0hi342tTBL3FE+ZNmnhOWbK+PXRh5jfqNCyuA
         eLOG2v2rLQqrLuHW9XwI1uj+i/oS89drXNxwDE7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 130/174] x86, perf: Fix the dependency of the x86 insn decoder selftest
Date:   Thu, 16 Jan 2020 12:42:07 -0500
Message-Id: <20200116174251.24326-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 7720804a2ae46c90265a32c81c45fb6f8d2f4e8b ]

Since x86 instruction decoder is not only for kprobes,
it should be tested when the insn.c is compiled.
(e.g. perf is enabled but kprobes is disabled)

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: cbe5c34c8c1f ("x86: Compile insn.c and inat.c only for KPROBES")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 2aa212fb0faf..31c191a08bb1 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -221,7 +221,7 @@ config HAVE_MMIOTRACE_SUPPORT
 
 config X86_DECODER_SELFTEST
 	bool "x86 instruction decoder selftest"
-	depends on DEBUG_KERNEL && KPROBES
+	depends on DEBUG_KERNEL && INSTRUCTION_DECODER
 	depends on !COMPILE_TEST
 	---help---
 	 Perform x86 instruction decoder selftests at build time.
-- 
2.20.1


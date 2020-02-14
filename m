Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DEDC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B16724727
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697234;
	bh=MER3F+zK08+jgmeAuCAce7UgS5Ekz7pQQqRlzv2/Bb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rAiunDbWNPEVKRG9XCG7h+MfxWWTlu/ZuriremYB69pxZm9/Mj3466shJh9zq+PsG
	 0YlMZzGquptvTYWHR9KxNwZoLu4OYVxAuDkBO9Tn7e0AXKC2pE/tF6D+a4LsmdPZxd
	 BnWkrGxZRxHUE44rJRyPzLlR0JRnemOJaXw5dTD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbgBNQUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392798AbgBNQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:19:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E1224718;
        Fri, 14 Feb 2020 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697166;
        bh=MER3F+zK08+jgmeAuCAce7UgS5Ekz7pQQqRlzv2/Bb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wl1QegLbgbHPTK4UeYP1Ln+kWl3aFK1FyW9H4cYHtLagv5ORNCkHR0+h27utsz92g
         WrmCxHxTajBwZL8DjOL7FG727lh7B9UJc9WMeWrZg5poLOcUSjSzcokmO90qSLfRSN
         +q17JG/r1P+Suq8aBmRPAm9mxUnK3DVvFMOFMdoM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 101/186] x86/unwind/orc: Fix !CONFIG_MODULES build warning
Date:   Fri, 14 Feb 2020 11:15:50 -0500
Message-Id: <20200214161715.18113-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

[ Upstream commit 22a7fa8848c5e881d87ef2f7f3c2ea77b286e6f9 ]

To fix follwowing warning due to ORC sort moved to build time:

  arch/x86/kernel/unwind_orc.c:210:12: warning: ‘orc_sort_cmp’ defined but not used [-Wunused-function]
  arch/x86/kernel/unwind_orc.c:190:13: warning: ‘orc_sort_swap’ defined but not used [-Wunused-function]

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/c9c81536-2afc-c8aa-c5f8-c7618ecd4f54@linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/unwind_orc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 3bbb399f7ead3..5ac0e0359b668 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -131,6 +131,8 @@ static struct orc_entry *orc_find(unsigned long ip)
 	return orc_module_find(ip);
 }
 
+#ifdef CONFIG_MODULES
+
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
@@ -173,7 +175,6 @@ static int orc_sort_cmp(const void *_a, const void *_b)
 	return orc_a->sp_reg == ORC_REG_UNDEFINED ? -1 : 1;
 }
 
-#ifdef CONFIG_MODULES
 void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
 			void *_orc, size_t orc_size)
 {
-- 
2.20.1


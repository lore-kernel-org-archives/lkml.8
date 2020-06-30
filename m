Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA7920774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgF3JjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:39:20 -0400
Received: from 107-174-27-60-host.colocrossing.com ([107.174.27.60]:47736 "EHLO
        ozlabs.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgF3JjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:19 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 7F809AE80019;
        Tue, 30 Jun 2020 05:36:21 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH kernel] panic: Dump registers on panic_on_warn
Date:   Tue, 30 Jun 2020 19:38:46 +1000
Message-Id: <20200630093846.100531-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we print stack and registers for ordinary warnings but
we do not for panic_on_warn which looks as oversight - panic()
will reboot the machine but won't print registers.

This moves printing of registers and modules earlier.

This does not move the stack dumping as panic() dumps it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/panic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index e2157ca387c8..798eff8156f3 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -589,6 +589,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	if (args)
 		vprintk(args->fmt, args->args);
 
+	print_modules();
+
+	if (regs)
+		show_regs(regs);
+
 	if (panic_on_warn) {
 		/*
 		 * This thread may hit another WARN() in the panic path.
@@ -600,12 +605,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 		panic("panic_on_warn set ...\n");
 	}
 
-	print_modules();
-
-	if (regs)
-		show_regs(regs);
-	else
-		dump_stack();
+	dump_stack();
 
 	print_irqtrace_events(current);
 
-- 
2.17.1


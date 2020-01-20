Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F84EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCF5217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgATPkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:40:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgATPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:40:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 40E91B376;
        Mon, 20 Jan 2020 15:40:44 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     akpm@linux-foundation.org, jpoimboe@redhat.com, trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] arch/Kconfig: Update HAVE_RELIABLE_STACKTRACE description
Date:   Mon, 20 Jan 2020 16:40:42 +0100
Message-Id: <20200120154042.9934-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_stack_trace_tsk_reliable() is not the only function providing the
reliable stack traces anymore. Architecture might define ARCH_STACKWALK
which provides a newer stack walking interface and has
arch_stack_walk_reliable() function. Update the description accordingly.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 48b5e103bdb0..f73dbbcc86fe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -733,8 +733,9 @@ config HAVE_STACK_VALIDATION
 config HAVE_RELIABLE_STACKTRACE
 	bool
 	help
-	  Architecture has a save_stack_trace_tsk_reliable() function which
-	  only returns a stack trace if it can guarantee the trace is reliable.
+	  Architecture has either save_stack_trace_tsk_reliable() or
+	  arch_stack_walk_reliable() function which only returns a stack trace
+	  if it can guarantee the trace is reliable.
 
 config HAVE_ARCH_HASH
 	bool
-- 
2.24.1


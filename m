Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A0C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA7024676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582201139;
	bh=rSOLOShieIA2TZ4lAc93LuLE6YPRZUTgla+6noim+Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AFuxHVQ0l52R+YwuKUwmvxql71ZGHZqFWLtqmKE+oBu1hSpAhmBTwikeDG3zgce8t
	 RUMFj3oGrjUPIWkRHrh1q5nCDqBrJX9b3u6T8K+mknBsDa//oa1Q8ECmE0OdUI/40M
	 Gupi1iuxYDGDzoKQXyCSFLvoqHc1HGXhtXDl6IUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBTMS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBTMS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:18:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E6C207FD;
        Thu, 20 Feb 2020 12:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201137;
        bh=rSOLOShieIA2TZ4lAc93LuLE6YPRZUTgla+6noim+Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwOqohQPYH0CGLxOunrixXHpd6FsQsr/M1VUSLlEoTo0Vt+YgG2LtwvIs0af9yuoI
         h3vDT3l58fK03uXXhfARFBtgLmoK0dAb9p61+gb3k0D2rnrq0l4d5nWFjVN66MGvA6
         q+r46iSEbP5YnHEwdxfWQFyYrRZyctuPy63slA+Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 3/8] tools/bootconfig: Remove unneeded error message silencer
Date:   Thu, 20 Feb 2020 21:18:52 +0900
Message-Id: <158220113256.26565.14264598654427773104.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158220110257.26565.4812934676257459744.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove error message silent knob, we don't need it anymore
because we can check if there is a bootconfig by checking
the magic word.
If there is a magic word, but failed to load a bootconfig
from initrd, there is a real problem.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/include/linux/printk.h |    5 +----
 tools/bootconfig/main.c                 |    8 --------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
index e978a63d3222..036e667596eb 100644
--- a/tools/bootconfig/include/linux/printk.h
+++ b/tools/bootconfig/include/linux/printk.h
@@ -4,10 +4,7 @@
 
 #include <stdio.h>
 
-/* controllable printf */
-extern int pr_output;
-#define printk(fmt, ...)	\
-	(pr_output ? printf(fmt, ##__VA_ARGS__) : 0)
+#define printk(fmt, ...) printf(fmt, ##__VA_ARGS__)
 
 #define pr_err printk
 #define pr_warn	printk
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 742271f019a9..a9b97814d1a9 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -14,8 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
-int pr_output = 1;
-
 static int xbc_show_array(struct xbc_node *node)
 {
 	const char *val;
@@ -227,13 +225,7 @@ int delete_xbc(const char *path)
 		return -errno;
 	}
 
-	/*
-	 * Suppress error messages in xbc_init() because it can be just a
-	 * data which concidentally matches the size and checksum footer.
-	 */
-	pr_output = 0;
 	size = load_xbc_from_initrd(fd, &buf);
-	pr_output = 1;
 	if (size < 0) {
 		ret = size;
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);


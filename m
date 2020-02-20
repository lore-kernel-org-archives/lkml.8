Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D684C11D80
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4724676
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582183631;
	bh=rSOLOShieIA2TZ4lAc93LuLE6YPRZUTgla+6noim+Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L8iGB4EM670v7EqK7X31ckZnnlSX5PaEuwn2RaW8EQBCFmtCZgSRgEsYinCVGL7xl
	 32n8pIWi/gDGxkAn1QB6JLcDrirTYyydcGQML45DAguagq9CpNMzxjaoMtp3o4HyHm
	 rYWSOAYoR84FDUkEoEbDoybcjgK8CrE3yJRgidMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBTH06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgBTH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:26:58 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B378E24654;
        Thu, 20 Feb 2020 07:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582183618;
        bh=rSOLOShieIA2TZ4lAc93LuLE6YPRZUTgla+6noim+Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3nwSvpUaK44PXNsWWP0waStLmJToDWY+he5VECJ0moeOsabMmAA6TdPettxg/ezf
         uWAyvtHADdclRa9u0I8HilD9Gyc1hRqJ1TZVCggxL2/lMdRDGYUKC80+T4LGgyeSII
         X25j+1a5o4r/8FzBnmKOZlpTjPsBaJZAVqMia3nI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/8] tools/bootconfig: Remove unneeded error message silencer
Date:   Thu, 20 Feb 2020 16:26:53 +0900
Message-Id: <158218361325.6940.15869822744969552773.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158218358363.6940.18380270211351882136.stgit@devnote2>
References: <158218358363.6940.18380270211351882136.stgit@devnote2>
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


Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7751EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8968206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735259;
	bh=i5ANlpqR018YR0d6q0AnTMbQwaCSVTrwSPCu4a3h7lc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TqV04gNT21wxv9mexPv0YypxoSSZcg6QqqbzFOblzEXHe8LZvVfGB6x0wN6i4ppEg
	 Kol7GcfgWWStAiFxsmoO3vhRqjjHtUFZfebH3tJl37goySqY2Dq+NowaFLCAieuVVW
	 E+zDXlubiAA3ySJ8RyNwwy27t6VOxbcBHzP5hZdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHFReQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D5523123;
        Thu,  6 Aug 2020 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596725526;
        bh=i5ANlpqR018YR0d6q0AnTMbQwaCSVTrwSPCu4a3h7lc=;
        h=From:To:Cc:Subject:Date:From;
        b=NWfRvtbaky3m3FtA0y3zzCKqvokh4wOi44r6qO8lyx6VnY3sSO1XUFafedRF6Eh8Y
         up9hJkXBv3MqNDx1IBqInmV8ifJpbXr7ybPfA/nitNWGSwgx/f8Clc9hmt/420yBDE
         Pyg1GFqDe84WMyVVFL2oHiVYusgeLw25WfXIHINE=
From:   guoren@kernel.org
To:     guoren@kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
Date:   Thu,  6 Aug 2020 14:50:54 +0000
Message-Id: <1596725454-16245-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The function ftrace_process_locs() will modify text code, so we
should give a text_mutex lock. Because some arch's patch code
will assert held of text_mutex even during start_kernel->
ftrace_init().

backtrace log:
   assert by lockdep_assert_held(&text_mutex)
0  patch_insn_write (addr=0xffffffe0000010fc <set_reset_devices+10>, insn=0xffffffe001203eb8, len=8) at arch/riscv/kernel/patch.c:63
1  0xffffffe0002042ec in patch_text_nosync (addr=<optimized out>, insns=<optimized out>, len=<optimized out>) at arch/riscv/kernel/patch.c:93
2  0xffffffe00020628e in __ftrace_modify_call (hook_pos=<optimized out>, target=<optimized out>, enable=<optimized out>) at arch/riscv/kernel/ftrace.c:68
3  0xffffffe0002063c0 in ftrace_make_nop (mod=<optimized out>, rec=0xffffffe001221c70 <text_mutex+96>, addr=18446743936272720288) at arch/riscv/kernel/ftrace.c:97
4  0xffffffe0002b13f0 in ftrace_init_nop (rec=<optimized out>, mod=<optimized out>) at ./include/linux/ftrace.h:647
5  ftrace_nop_initialize (rec=<optimized out>, mod=<optimized out>) at kernel/trace/ftrace.c:2619
6  ftrace_update_code (new_pgs=<optimized out>, mod=<optimized out>) at kernel/trace/ftrace.c:3063
7  ftrace_process_locs (mod=<optimized out>, start=<optimized out>, end=<optimized out>) at kernel/trace/ftrace.c:6154
8  0xffffffe00000b6e6 in ftrace_init () at kernel/trace/ftrace.c:6715
9  0xffffffe000001b48 in start_kernel () at init/main.c:888
10 0xffffffe0000010a8 in _start_kernel () at arch/riscv/kernel/head.S:247

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80..4b48b88 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -26,6 +26,7 @@
 #include <linux/uaccess.h>
 #include <linux/bsearch.h>
 #include <linux/module.h>
+#include <linux/memory.h>
 #include <linux/ftrace.h>
 #include <linux/sysctl.h>
 #include <linux/slab.h>
@@ -6712,9 +6713,11 @@ void __init ftrace_init(void)
 
 	last_ftrace_enabled = ftrace_enabled = 1;
 
+	mutex_lock(&text_mutex);
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
+	mutex_unlock(&text_mutex);
 
 	pr_info("ftrace: allocated %ld pages with %ld groups\n",
 		ftrace_number_of_pages, ftrace_number_of_groups);
-- 
2.7.4


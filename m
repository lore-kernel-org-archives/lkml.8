Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E1C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:36:21 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D8206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6D8206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgDMGgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgDMGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:36:19 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F07C008673
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:36:18 -0700 (PDT)
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03D6XShj060956;
        Mon, 13 Apr 2020 15:33:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Mon, 13 Apr 2020 15:33:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from ccsecurity.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03D6XOwp060692
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Apr 2020 15:33:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v3] Add kernel config option for tweaking kernel behavior.
Date:   Mon, 13 Apr 2020 15:33:17 +0900
Message-Id: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing kernel config options are defined based on "whether you want to
enable this module/feature or not". And such granularity is sometimes
too rough-grained for fuzzing tools which try to find bugs inside each
module/feature.

While syzkaller (one of fuzzing tools) is finding many bugs, sometimes
syzkaller examines stupid operations. Some examples of such operations
are: changing console loglevel which in turn makes it impossible to get
kernel messages when a crash happens, freezing filesystems which in turn
causes khungtaskd to needlessly complain, programmatically sending
Ctrl-Alt-Del which in turn causes the system to needlessly reboot.
Currently we prevent syzkaller from examining stupid operations by
blacklisting syscall arguments and/or disabling whole functionality
using existing kernel config options. But such approach is difficult to
maintain and needlessly prevents fuzzers from testing kernel code. [1]

We want fuzzers to test as much coverage as possible while we want
fuzzers not to try stupid operations. To achieve this goal, we want
cooperation from kernel side, and build-time branching (i.e. kernel
config options) will be the simplest and the most reliable.

Therefore, this patch introduces a kernel config option which allows
selecting fine-grained kernel config options for tweaking kernel's
behavior. Each fine-grained kernel config option will be added by future
patches. For ease of management, grouping kernel config options for
allowing e.g. syzkaller to select all fine-grained kernel config options
which e.g. syzkaller wants would be added by future patches.

[1] https://lkml.kernel.org/r/CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.debug | 11 +++++++++++
 1 file changed, 11 insertions(+)

Changes since v2 ( https://lkml.kernel.org/r/20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp ):
  Reduce the role of this kernel config option from "enable everything
  which would be useful for fuzz testing" to "simply serve as a gate for
  hiding individual kernel config option", for we should use individual
  kernel config option for tweaking individual kernel behavior.

Changes since v1 ( https://lkml.kernel.org/r/20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp ):
  Drop users of this kernel config option.
  Update patch description.

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 50c1f5f08e6f..a7c3ebc21428 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2223,4 +2223,15 @@ config HYPERV_TESTING
 
 endmenu # "Kernel Testing and Coverage"
 
+menuconfig TWEAK_KERNEL_BEHAVIOR
+	bool "Tweak kernel behavior"
+	help
+	  Saying Y here allows modifying kernel behavior via kernel
+	  config options which will become visible by selecting this
+	  config option.
+
+if TWEAK_KERNEL_BEHAVIOR
+
+endif # TWEAK_KERNEL_BEHAVIOR
+
 endmenu # Kernel hacking
-- 
2.18.2


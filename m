Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E5BC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA9620753
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgDUNW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:22:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57903 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgDUNWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:22:50 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03LDLBNY043494;
        Tue, 21 Apr 2020 22:21:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 21 Apr 2020 22:21:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from ccsecurity.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03LDL6O7043463
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Apr 2020 22:21:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller@googlegroups.com,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v4 1/3] Add kernel config option for twisting kernel behavior.
Date:   Tue, 21 Apr 2020 22:19:49 +0900
Message-Id: <20200421131951.4948-1-penguin-kernel@I-love.SAKURA.ne.jp>
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
selecting fine-grained kernel config options for twisting kernel's
behavior. Each fine-grained kernel config option will be added by future
patches. For ease of management, grouping kernel config options for
allowing e.g. syzkaller to select all fine-grained kernel config options
which e.g. syzkaller wants would be added by future patches.

[1] https://lkml.kernel.org/r/CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 lib/Kconfig.debug |  2 ++
 lib/Kconfig.twist | 13 +++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 lib/Kconfig.twist

Changes since v3 ( https://lkml.kernel.org/r/20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp ):
  Use "twist" instead of "tweak".
  Add an instance of fine-grained kernel config option as patch 2 of 3.
  Add a grouping kernel config option for syzkaller as patch 3 of 3.

Changes since v2 ( https://lkml.kernel.org/r/20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp ):
  Reduce the role of this kernel config option from "enable everything
  which would be useful for fuzz testing" to "simply serve as a gate for
  hiding individual kernel config option", for we should use individual
  kernel config option for tweaking individual kernel behavior.

Changes since v1 ( https://lkml.kernel.org/r/20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp ):
  Drop users of this kernel config option.
  Update patch description.

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..e6162595ef9d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2225,4 +2225,6 @@ config HYPERV_TESTING
 
 endmenu # "Kernel Testing and Coverage"
 
+source "lib/Kconfig.twist"
+
 endmenu # Kernel hacking
diff --git a/lib/Kconfig.twist b/lib/Kconfig.twist
new file mode 100644
index 000000000000..a5ce0db67f28
--- /dev/null
+++ b/lib/Kconfig.twist
@@ -0,0 +1,13 @@
+menuconfig TWIST_KERNEL_BEHAVIOR
+	bool "Twist kernel behavior"
+	help
+	  Saying Y here allows modifying kernel behavior via kernel
+	  config options which will become visible by selecting this
+	  config option. Since these kernel config options are intended
+	  for helping e.g. fuzz testing, behavior twisted by this kernel
+	  option might be unstable. Userspace applications should not
+	  count on this option being selected.
+
+if TWIST_KERNEL_BEHAVIOR
+
+endif # TWIST_KERNEL_BEHAVIOR
-- 
2.18.2


Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E315C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D6220753
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgDUNWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:22:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57898 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgDUNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:22:49 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03LDLCsZ043506;
        Tue, 21 Apr 2020 22:21:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Tue, 21 Apr 2020 22:21:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from ccsecurity.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03LDL6O9043463
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
Subject: [PATCH v4 3/3] twist: Add option for selecting twist options for syzkaller's testing
Date:   Tue, 21 Apr 2020 22:19:51 +0900
Message-Id: <20200421131951.4948-3-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200421131951.4948-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200421131951.4948-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kernel developer adds a kernel config option, they will not go
and update configs on all external testing systems. This problem is also
common for "enable all boot tests that can run on this kernel", or
"configure a 'standard' debug build". Currently doing these things
require all of expertise, sacred knowledge, checking all configs
one-by-one as well as checking every new kernel patch and that needs to
be done by everybody doing any kernel testing.

In order to reduce the burden of maintaining kernel config options, this
patch introduces a kernel config option which will select twist options
when building kernels for syzkaller's testing.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.twist | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/Kconfig.twist b/lib/Kconfig.twist
index a1d038bcc2a5..95020a56bbfc 100644
--- a/lib/Kconfig.twist
+++ b/lib/Kconfig.twist
@@ -10,6 +10,12 @@ menuconfig TWIST_KERNEL_BEHAVIOR
 
 if TWIST_KERNEL_BEHAVIOR
 
+config TWIST_FOR_SYZKALLER_TESTING
+       bool "Select all twist options suitable for syzkaller testing"
+       select TWIST_DISABLE_KBD_K_SPEC_HANDLER
+       help
+	 Say N unless you are building kernels for syzkaller's testing.
+
 config TWIST_DISABLE_KBD_K_SPEC_HANDLER
        bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
        help
-- 
2.18.2


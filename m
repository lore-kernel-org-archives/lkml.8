Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C147C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C21F20675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCGOAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 09:00:24 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56006 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCGOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 09:00:23 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 027DwcKw034153;
        Sat, 7 Mar 2020 22:58:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sat, 07 Mar 2020 22:58:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from ccsecurity.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 027DwVo3033899
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 7 Mar 2020 22:58:38 +0900 (JST)
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
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2] Add kernel config option for fuzz testing.
Date:   Sat,  7 Mar 2020 22:58:22 +0900
Message-Id: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While syzkaller is finding many bugs, sometimes syzkaller examines
stupid operations. Currently we prevent syzkaller from examining
stupid operations by blacklisting syscall arguments and/or disabling
whole functionality using existing kernel config options, but it is
a whack-a-mole approach. We need cooperation from kernel side [1].

This patch introduces a kernel config option which allows disabling
only specific operations. This kernel config option should be enabled
only when building kernels for fuzz testing.

We discussed possibility of disabling specific operations at run-time
using some lockdown mechanism [2], but conclusion seems that build-time
control (i.e. kernel config option) fits better for this purpose.
Since patches for users of this kernel config option will want a lot of
explanation [3], this patch provides only kernel config option for them.

[1] https://github.com/google/syzkaller/issues/1622
[2] https://lkml.kernel.org/r/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com
[3] https://lkml.kernel.org/r/20191216163155.GB2258618@kroah.com

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

Changes since v1:
  Drop users of this kernel config option.
  Update patch description.

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 53e786e0a604..e360090e24c5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2208,4 +2208,14 @@ config HYPERV_TESTING
 
 endmenu # "Kernel Testing and Coverage"
 
+config KERNEL_BUILT_FOR_FUZZ_TESTING
+       bool "Build kernel for fuzz testing"
+       default n
+       help
+	 Say N unless you are building kernels for fuzz testing.
+	 Saying Y here disables several things that legitimately cause
+	 damage under a fuzzer workload (e.g. copying to arbitrary
+	 user-specified kernel address, changing console loglevel,
+	 freezing filesystems).
+
 endmenu # Kernel hacking
-- 
2.18.2


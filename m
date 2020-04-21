Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B12BC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E23A20775
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgDUNWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:22:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57891 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgDUNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:22:49 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03LDLBYp043501;
        Tue, 21 Apr 2020 22:21:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 21 Apr 2020 22:21:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from ccsecurity.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03LDL6O8043463
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
Subject: [PATCH v4 2/3] twist: Allow disabling k_spec() function in drivers/tty/vt/keyboard.c
Date:   Tue, 21 Apr 2020 22:19:50 +0900
Message-Id: <20200421131951.4948-2-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200421131951.4948-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200421131951.4948-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting unexpected kernel reboots [1]. This seems to be
caused by triggering Ctrl-Alt-Del event via k_spec() function in
drivers/tty/vt/keyboard.c file, for the console output includes normal
restart sequence.

  [   97.727327][    T1] systemd-shutdown[1]: Unmounting file systems.
  [   97.734278][    T1] systemd-shutdown[1]: Remounting '/' read-only with options ''.
  [   97.747758][   T21] usb 2-1: device descriptor read/8, error -71
  [   97.747850][ T3116] usb 1-1: device descriptor read/8, error -71
  [   97.764818][    T1] EXT4-fs (sda1): re-mounted. Opts: 
  [   97.777551][    T1] systemd-shutdown[1]: Remounting '/' read-only with options ''.
  [   97.785448][    T1] EXT4-fs (sda1): re-mounted. Opts: 
  [   97.790920][    T1] systemd-shutdown[1]: All filesystems unmounted.
  [   97.797352][    T1] systemd-shutdown[1]: Deactivating swaps.
  [   97.803451][    T1] systemd-shutdown[1]: All swaps deactivated.
  [   97.809626][    T1] systemd-shutdown[1]: Detaching loop devices.
  [   97.890294][    T1] systemd-shutdown[1]: All loop devices detached.
  [   98.967832][ T3116] usb 1-1: device descriptor read/8, error -71
  [  100.108406][    T1] sd 0:0:1:0: [sda] Synchronizing SCSI cache
  [  100.116036][    T1] reboot: Restarting system
  [  100.120636][    T1] reboot: machine restart
  SeaBIOS (version 1.8.2-20200402_173431-google)
  Total RAM Size = 0x00000001e0000000 = 7680 MiB
  CPUs found: 2     Max CPUs supported: 2
  Comparing RSDP and RSDP

Therefore, allow disabling only k_spec() function in order to allow
fuzzers to examine the remaining part in that file.

[1] https://syzkaller.appspot.com/bug?id=321861b1588b44d064b779b92293c5d55cfe8430

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/keyboard.c | 2 ++
 lib/Kconfig.twist         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 15d33fa0c925..f08855c4c5ba 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -633,6 +633,8 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
 	     kbd->kbdmode == VC_OFF) &&
 	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
+	if (IS_ENABLED(CONFIG_TWIST_DISABLE_KBD_K_SPEC_HANDLER))
+		return;
 	fn_handler[value](vc);
 }
 
diff --git a/lib/Kconfig.twist b/lib/Kconfig.twist
index a5ce0db67f28..a1d038bcc2a5 100644
--- a/lib/Kconfig.twist
+++ b/lib/Kconfig.twist
@@ -10,4 +10,11 @@ menuconfig TWIST_KERNEL_BEHAVIOR
 
 if TWIST_KERNEL_BEHAVIOR
 
+config TWIST_DISABLE_KBD_K_SPEC_HANDLER
+       bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
+       help
+	 k_spec() function allows triggering e.g. Ctrl-Alt-Del event.
+	 Such event is annoying for fuzz testing which wants to test
+	 kernel code without rebooting the system.
+
 endif # TWIST_KERNEL_BEHAVIOR
-- 
2.18.2


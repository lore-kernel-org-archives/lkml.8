Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DBDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EC220772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgFCLDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:03:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58264 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCLDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:03:34 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 053B3UOI030441;
        Wed, 3 Jun 2020 20:03:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Wed, 03 Jun 2020 20:03:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 053B3UFW030438
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 3 Jun 2020 20:03:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: twist: allow disabling reboot request
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei>
 <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
 <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
Message-ID: <51eaa6cd-33ce-f9d8-942c-c797c0ec6733@i-love.sakura.ne.jp>
Date:   Wed, 3 Jun 2020 20:03:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/29 22:26, Tetsuo Handa wrote:
>     By the way, I do worry that people forget to perform these steps when they do
>     their tests without asking syzbot...

Here is a draft of boot-time switching. Since kconfig can handle string variable up to
2048 characters, we could hold the content of the "your-config" file inside .config file
in order to avoid relying on external file in "syzkaller tree". But since only one kconfig
option is used, basically the way to temporarily include/exclude specific options (under
automated testing by syzbot) seems to remain directly patching apply_twist_flags(), for
https://github.com/google/syzkaller/blob/master/dashboard/config/util.sh will automatically
overwrite CONFIG_DEFAULT_TWIST_FLAGS settings. If each twist flag were using independent
kconfig option, the way to temporarily include/exclude specific options will become directly
patching Kconfig file.

 drivers/tty/vt/keyboard.c |    2 ++
 include/linux/kernel.h    |    8 ++++++++
 init/main.c               |   30 ++++++++++++++++++++++++++++++
 kernel/reboot.c           |   36 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug         |    5 +++++
 5 files changed, 81 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 568b2171f335..ae0b7cd69249 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -637,6 +637,8 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
 	     kbd->kbdmode == VC_OFF) &&
 	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
+	if (twist_flags.disable_kbd_k_spec_handler)
+		return;
 	fn_handler[value](vc);
 }
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 82d91547d122..78fdbb4f17b1 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -1038,4 +1038,12 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
 	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
 	 (perms))
+
+/* Flags for twisting kernel behavior. */
+struct twist_flags {
+	bool disable_kbd_k_spec_handler;
+	bool disable_reboot_request;
+};
+extern struct twist_flags twist_flags;
+
 #endif
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5a..15eecd253b61 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1531,3 +1531,33 @@ static noinline void __init kernel_init_freeable(void)
 
 	integrity_load_keys();
 }
+
+/* Flags for twisting kernel behavior. */
+struct twist_flags twist_flags __ro_after_init;
+EXPORT_SYMBOL(twist_flags);
+static __initdata char default_twist_flags[] __initdata = CONFIG_DEFAULT_TWIST_FLAGS;
+static __initdata char *chosen_twist_flags = default_twist_flags;
+
+static int __init overwrite_twist_flags(char *str)
+{
+	chosen_twist_flags = str;
+	return 1;
+}
+__setup("twist_flags=", overwrite_twist_flags);
+
+static int __init apply_twist_flags(void)
+{
+	char *flags = chosen_twist_flags;
+	char *name;
+
+	while ((name = strsep(&flags, ",")) != NULL) {
+		if (!strcmp(name, "kbd-disable-hotkeys"))
+			twist_flags.disable_kbd_k_spec_handler = true;
+		else if (!strcmp(name, "disable-reboot-request"))
+			twist_flags.disable_reboot_request = true;
+		else
+			printk(KERN_INFO "Ignoring unknown twist option '%s'.\n", name);
+	}
+	return 0;
+}
+late_initcall(apply_twist_flags);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 491f1347bf43..63cec97a9e59 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -63,6 +63,8 @@ EXPORT_SYMBOL_GPL(pm_power_off_prepare);
  */
 void emergency_restart(void)
 {
+	if (twist_flags.disable_reboot_request)
+		panic("reboot request is disabled");
 	kmsg_dump(KMSG_DUMP_EMERG);
 	machine_emergency_restart();
 }
@@ -243,6 +245,8 @@ void migrate_to_reboot_cpu(void)
  */
 void kernel_restart(char *cmd)
 {
+	if (twist_flags.disable_reboot_request)
+		panic("reboot request is disabled");
 	kernel_restart_prepare(cmd);
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
@@ -270,6 +274,8 @@ static void kernel_shutdown_prepare(enum system_states state)
  */
 void kernel_halt(void)
 {
+	if (twist_flags.disable_reboot_request)
+		panic("reboot request is disabled");
 	kernel_shutdown_prepare(SYSTEM_HALT);
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
@@ -286,6 +292,8 @@ EXPORT_SYMBOL_GPL(kernel_halt);
  */
 void kernel_power_off(void)
 {
+	if (twist_flags.disable_reboot_request)
+		panic("reboot request is disabled");
 	kernel_shutdown_prepare(SYSTEM_POWER_OFF);
 	if (pm_power_off_prepare)
 		pm_power_off_prepare();
@@ -344,6 +352,10 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	mutex_lock(&system_transition_mutex);
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
+		if (twist_flags.disable_reboot_request) {
+			ret = -EPERM;
+			break;
+		}
 		kernel_restart(NULL);
 		break;
 
@@ -356,11 +368,19 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		break;
 
 	case LINUX_REBOOT_CMD_HALT:
+		if (twist_flags.disable_reboot_request) {
+			ret = -EPERM;
+			break;
+		}
 		kernel_halt();
 		do_exit(0);
 		panic("cannot halt");
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
+		if (twist_flags.disable_reboot_request) {
+			ret = -EPERM;
+			break;
+		}
 		kernel_power_off();
 		do_exit(0);
 		break;
@@ -373,17 +393,29 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 		}
 		buffer[sizeof(buffer) - 1] = '\0';
 
+		if (twist_flags.disable_reboot_request) {
+			ret = -EPERM;
+			break;
+		}
 		kernel_restart(buffer);
 		break;
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		if (twist_flags.disable_reboot_request) {
+			ret = -EPERM;
+			break;
+		}
 		ret = kernel_kexec();
 		break;
 #endif
 
 #ifdef CONFIG_HIBERNATION
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
+		if (twist_flags.disable_reboot_request) {
+			ret = -EPERM;
+			break;
+		}
 		ret = hibernate();
 		break;
 #endif
@@ -493,6 +525,8 @@ static DECLARE_WORK(poweroff_work, poweroff_work_func);
  */
 void orderly_poweroff(bool force)
 {
+	if (twist_flags.disable_reboot_request)
+		panic("reboot request is disabled");
 	if (force) /* do not override the pending "true" */
 		poweroff_force = true;
 	schedule_work(&poweroff_work);
@@ -514,6 +548,8 @@ static DECLARE_WORK(reboot_work, reboot_work_func);
  */
 void orderly_reboot(void)
 {
+	if (twist_flags.disable_reboot_request)
+		panic("reboot request is disabled");
 	schedule_work(&reboot_work);
 }
 EXPORT_SYMBOL_GPL(orderly_reboot);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 498d344ea53a..41cfabc74ad7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2338,4 +2338,9 @@ config HYPERV_TESTING
 
 endmenu # "Kernel Testing and Coverage"
 
+menuconfig DEFAULT_TWIST_FLAGS
+	string "Default twist options (DANGEROUS)"
+	help
+	  Don't specify anything unless you know what you are doing.
+
 endmenu # Kernel hacking


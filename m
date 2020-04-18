Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D30C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625AA21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgDROaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:30:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54334 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDROaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:30:04 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03IESTW1035131;
        Sat, 18 Apr 2020 23:28:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sat, 18 Apr 2020 23:28:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03IESN5r035088
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 18 Apr 2020 23:28:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200413081426.GA2791586@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <85d9c411-f205-56bf-df6b-6d4fa39a134b@i-love.sakura.ne.jp>
Date:   Sat, 18 Apr 2020 23:28:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413081426.GA2791586@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/13 17:14, Greg Kroah-Hartman wrote:
>> @@ -2223,4 +2223,15 @@ config HYPERV_TESTING
>>  
>>  endmenu # "Kernel Testing and Coverage"
>>  
>> +menuconfig TWEAK_KERNEL_BEHAVIOR
>> +	bool "Tweak kernel behavior"
>> +	help
>> +	  Saying Y here allows modifying kernel behavior via kernel
>> +	  config options which will become visible by selecting this
>> +	  config option.
> 
> This "help" text really only says "say Y here to allow for some config
> options".  It doesn't explain what these are for, or why anyone would
> select them, or what type of options are here at all.
> 
> I don't see how this option, by just looking at it, relates to your goal
> of doing things to make fuzzers' lives easier.

Well, we could add some more text (like shown below), but this option itself
is neutral. This option is not limiting the target to fuzzers.
Below 3 patches are an example of "a set of fine-grained configs" with
"some umbrella uber-config" approach. Linus, are you OK with this approach?



From 23b585fdd0ed55710285a6d67faffe63cebc098f Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 18 Apr 2020 22:03:04 +0900
Subject: [PATCH 1/3] Add kernel config option for tweaking kernel behavior.

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
---
 lib/Kconfig.debug |  2 ++
 lib/Kconfig.tewak | 13 +++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 lib/Kconfig.tewak

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..e6162595ef9d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2225,4 +2225,6 @@ config HYPERV_TESTING
 
 endmenu # "Kernel Testing and Coverage"
 
+source "lib/Kconfig.tewak"
+
 endmenu # Kernel hacking
diff --git a/lib/Kconfig.tewak b/lib/Kconfig.tewak
new file mode 100644
index 000000000000..a5ce0db67f28
--- /dev/null
+++ b/lib/Kconfig.tewak
@@ -0,0 +1,13 @@
+menuconfig TWEAK_KERNEL_BEHAVIOR
+	bool "Tweak kernel behavior"
+	help
+	  Saying Y here allows modifying kernel behavior via kernel
+	  config options which will become visible by selecting this
+	  config option. Since these kernel config options are intended
+	  for helping e.g. fuzz testing, behavior tweaked by this kernel
+	  option might be unstable. Userspace applications should not
+	  count on this option being selected.
+
+if TWEAK_KERNEL_BEHAVIOR
+
+endif # TWEAK_KERNEL_BEHAVIOR
-- 
2.18.2

From f7f668896e188217b50c50a31c4ad1acb7556b36 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 18 Apr 2020 22:39:38 +0900
Subject: [PATCH 2/3] tweak: Allow disabling k_spec() function in drivers/tty/vt/keyboard.c

syzbot is reporting unexpected kernel reboots [1]. This seems to be
caused by triggering Ctrl-Alt-Del event via k_spec() function in
drivers/tty/vt/keyboard.c file, for the console output includes normal
restart sequence. Therefore, allow disabling only k_spec() function
in order to allow fuzzers to examine the remaining part in that file.

[1] https://syzkaller.appspot.com/bug?id=321861b1588b44d064b779b92293c5d55cfe8430

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/keyboard.c | 2 ++
 lib/Kconfig.tewak         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 15d33fa0c925..f08855c4c5ba 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -633,6 +633,8 @@ static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
 	     kbd->kbdmode == VC_OFF) &&
 	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
+	if (IS_ENABLED(CONFIG_TWEAK_DISABLE_KBD_K_SPEC_HANDLER))
+		return;
 	fn_handler[value](vc);
 }
 
diff --git a/lib/Kconfig.tewak b/lib/Kconfig.tewak
index a5ce0db67f28..a1d038bcc2a5 100644
--- a/lib/Kconfig.tewak
+++ b/lib/Kconfig.tewak
@@ -10,4 +10,11 @@ menuconfig TWEAK_KERNEL_BEHAVIOR
 
 if TWEAK_KERNEL_BEHAVIOR
 
+config TWEAK_DISABLE_KBD_K_SPEC_HANDLER
+       bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
+       help
+	 k_spec() function allows triggering e.g. Ctrl-Alt-Del event.
+	 Such event is annoying for fuzz testing which wants to test
+	 kernel code without rebooting the system.
+
 endif # TWEAK_KERNEL_BEHAVIOR
-- 
2.18.2

From 5cf7f2ef1d470ea980c6b9a21437d37279d13d12 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 18 Apr 2020 23:12:16 +0900
Subject: [PATCH 3/3] tweak: Add option for selecting tweak options for syzkaller's testing

When a kernel developer adds a kernel config option, they will not go
and update configs on all external testing systems. This problem is also
common for "enable all boot tests that can run on this kernel", or
"configure a 'standard' debug build". Currently doing these things
require all of expertise, sacred knowledge, checking all configs
one-by-one as well as checking every new kernel patch and that needs to
be done by everybody doing any kernel testing.

In order to reduce the burden of maintaining kernel config options, this
patch introduces a kernel config option which will select tweak options
when building kernels for syzkaller's testing.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 lib/Kconfig.tewak | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/Kconfig.tewak b/lib/Kconfig.tewak
index a1d038bcc2a5..95020a56bbfc 100644
--- a/lib/Kconfig.tewak
+++ b/lib/Kconfig.tewak
@@ -10,6 +10,12 @@ menuconfig TWEAK_KERNEL_BEHAVIOR
 
 if TWEAK_KERNEL_BEHAVIOR
 
+config TWEAK_FOR_SYZKALLER_TESTING
+       bool "Select all tewak options suitable for syzkaller testing"
+       select TWEAK_DISABLE_KBD_K_SPEC_HANDLER
+       help
+	 Say N unless you are building kernels for syzkaller's testing.
+
 config TWEAK_DISABLE_KBD_K_SPEC_HANDLER
        bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
        help
-- 
2.18.2

Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81813C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E97B206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCLWAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:00:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53069 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:00:30 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02CLxOr0088649;
        Fri, 13 Mar 2020 06:59:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 13 Mar 2020 06:59:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02CLxOUL088644
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 13 Mar 2020 06:59:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
 <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
 <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
 <20200311101115.53139149@gandalf.local.home>
 <CACT4Y+Z5co4HyQBj6-uUdqT2Vk=6jgT-aQXuPtjx3qV4C_pZ7g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7e0d2bbf-71c2-395c-9a42-d3d6d3ee4fa4@i-love.sakura.ne.jp>
Date:   Fri, 13 Mar 2020 06:59:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z5co4HyQBj6-uUdqT2Vk=6jgT-aQXuPtjx3qV4C_pZ7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/13 4:23, Dmitry Vyukov wrote:
>> Or teach the fuzz tool not to do specific bad things.
> 
> We do some of this.
> But generally it's impossible for anything that involves memory
> indirections, or depends on the exact type of fd (e.g. all ioctl's),
> etc. Boils down to halting problem and ability to predict exact
> behavior of arbitrary programs.

I would like to enable changes like below only if CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y .

Since TASK_RUNNING threads are not always running on CPUs (in syzbot, the kernel is
tested on a VM with only 2 CPUs, which means that many threads are simply waiting for
CPU time to be assigned), dumping locks held by all threads gives us more clue when
e.g. khungtask fired. But since lockdep_print_held_locks() is racy, I assume that
this change won't be accepted unless CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y .

Also, for another example, limit number of memory pages /dev/ion driver can consume only if
CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y ( https://github.com/google/syzkaller/issues/1267 ),
for limiting number of memory pages is a user-visible change while we need to avoid false
alarms caused by consuming all memory pages.

In other words, while majority of things CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING=y would
do "disable this", there would be a few "enable this" and "change this".

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32406ef0d6a2..1bc7878768fc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -695,6 +695,7 @@ static void print_lock(struct held_lock *hlock)
 static void lockdep_print_held_locks(struct task_struct *p)
 {
 	int i, depth = READ_ONCE(p->lockdep_depth);
+	bool unreliable;
 
 	if (!depth)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
@@ -705,10 +706,12 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
 	 */
-	if (p->state == TASK_RUNNING && p != current)
-		return;
+	unreliable = p->state == TASK_RUNNING && p != current;
 	for (i = 0; i < depth; i++) {
-		printk(" #%d: ", i);
+		if (unreliable)
+			printk(" #%d?: ", i);
+		else
+			printk(" #%d: ", i);
 		print_lock(p->held_locks + i);
 	}
 }


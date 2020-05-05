Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FFC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED01A206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgEERpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:45:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbgEERpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:45:15 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jW1cz-00020g-G1; Tue, 05 May 2020 17:45:12 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christian Kellner <christian@kellner.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Stancek <jstancek@redhat.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Florian Weimer <fw@deneb.enyo.de>, libc-alpha@sourceware.org
Subject: [PATCH] clone: only use lower 32 flag bits
Date:   Tue,  5 May 2020 19:44:46 +0200
Message-Id: <20200505174446.204918-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan reported an issue where an interaction between sign-extending clone's
flag argument on ppc64le and the new CLONE_INTO_CGROUP feature causes
clone() to consistently fail with EBADF.

The whole story is a little longer. The legacy clone() syscall is odd in a
bunch of ways and here two things interact. First, legacy clone's flag
argument is word-size dependent, i.e. it's an unsigned long whereas most
system calls with flag arguments use int or unsigned int. Second, legacy
clone() ignores unknown and deprecated flags. The two of them taken
together means that users on 64bit systems can pass garbage for the upper
32bit of the clone() syscall since forever and things would just work fine.
Just try this on a 64bit kernel prior to v5.7-rc1.

int main(void)
{
        pid_t pid;

        /* Note that legacy clone() has different argument ordering on
         * different architectures so this won't work everywhere.
         *
         * Only set the upper 32 bits.
         */
        pid = syscall(__NR_clone, 0xffffffff00000000 | SIGCHLD,
                      NULL, NULL, NULL, NULL);
        if (pid < 0)
                exit(EXIT_FAILURE);
        if (pid == 0)
                exit(EXIT_SUCCESS);
        if (wait(NULL) != pid)
                exit(EXIT_FAILURE);

        exit(EXIT_SUCCESS);
}

Since legacy clone() couldn't be extended this was not a problem so far and
nobody really noticed or cared since nothing in the kernel ever bothered to
look at the upper 32 bits.

But once we introduced clone3() and expanded the flag argument in struct
clone_args to 64 bit we opened this can of worms. With the first flag-based
extension to clone3() making use of the upper 32 bits of the flag argument
we've effectively made it possible for the legacy clone() syscall to reach
clone3() only flags. The sign extension scenario is just the odd
corner-case that we needed to figure this out.

The reason we just realized this now and not already when we introduced
CLONE_CLEAR_SIGHAND was that CLONE_INTO_CGROUP assumes that a valid cgroup
file descriptor has been given. So the sign extension (or the user
accidently passing garbage for the upper 32 bits) caused the
CLONE_INTO_CGROUP bit to be raised and the kernel to error out when it
didn't find a valid cgroup file descriptor.

Let's fix this by always capping the upper 32 bits for the legacy clone()
syscall. This ensures that we can't reach clone3() only features by
accident via legacy clone as with the sign extension case and also that
legacy clone() works exactly like before, i.e. ignoring any unknown flags.
This solution risks no regressions and is also pretty clean.

I've chosen u32 and not unsigned int to visually indicate that we're
capping this to 32 bits.

Reported-by: Jan Stancek <jstancek@redhat.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: libc-alpha@sourceware.org
Link: https://sourceware.org/pipermail/libc-alpha/2020-May/113596.html
Fixes: 7f192e3cd316 ("fork: add clone3")
Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/fork.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8c700f881d92..1a712e7bf274 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2569,12 +2569,21 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		 unsigned long, tls)
 #endif
 {
+	/*
+	 * On 64 bit unsigned long can be used by userspace to
+	 * pass flag values only useable with clone3(). So cap
+	 * the flag argument to the lower 32 bits. This is fine,
+	 * since legacy clone() has traditionally ignored unknown
+	 * flag values. So don't break userspace workloads that
+	 * (on accident or on purpose) rely on this.
+	 */
+	u32 flags = (u32)clone_flags;
 	struct kernel_clone_args args = {
-		.flags		= (clone_flags & ~CSIGNAL),
+		.flags		= (flags & ~CSIGNAL),
 		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
-		.exit_signal	= (clone_flags & CSIGNAL),
+		.exit_signal	= (flags & CSIGNAL),
 		.stack		= newsp,
 		.tls		= tls,
 	};

base-commit: 0e698dfa282211e414076f9dc7e83c1c288314fd
-- 
2.26.2


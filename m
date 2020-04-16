Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D1C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8C020771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503588AbgDPJMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502313AbgDPIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E253C02C444;
        Thu, 16 Apr 2020 01:31:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOzvo-0000pe-ER; Thu, 16 Apr 2020 10:31:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E94BA1C001F;
        Thu, 16 Apr 2020 10:31:28 +0200 (CEST)
Date:   Thu, 16 Apr 2020 08:31:28 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers UAPI: Sync sched.h with the kernel
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158702588853.28353.13491043117520136406.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     027fa8fb63635fb984a86ec3106bc8417e074019
Gitweb:        https://git.kernel.org/tip/027fa8fb63635fb984a86ec3106bc8417e074019
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 14 Apr 2020 09:01:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Apr 2020 09:01:08 -03:00

tools headers UAPI: Sync sched.h with the kernel

To get the changes in:

  ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")

Add that to 'perf trace's clone 'flags' decoder.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 5 +++++
 tools/perf/trace/beauty/clone.c  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 2e3bc22..3bac0a8 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -35,6 +35,7 @@
 
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
@@ -81,6 +82,8 @@
  * @set_tid_size: This defines the size of the array referenced
  *                in @set_tid. This cannot be larger than the
  *                kernel's limit of nested PID namespaces.
+ * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
+ *                a file descriptor for the cgroup.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -97,11 +100,13 @@ struct clone_args {
 	__aligned_u64 tls;
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
 
 /*
  * Scheduling policies
diff --git a/tools/perf/trace/beauty/clone.c b/tools/perf/trace/beauty/clone.c
index 062ca84..f4db894 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -46,6 +46,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(NEWNET);
 	P_FLAG(IO);
 	P_FLAG(CLEAR_SIGHAND);
+	P_FLAG(INTO_CGROUP);
 #undef P_FLAG
 
 	if (flags)

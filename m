Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893EC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4050D206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883086;
	bh=/mHARHeWczRi1L5tDKAwMG7VRaHqjAqAAZDBdAFAoJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJap5O7K5m2JkcBIub/3XGIESJZlzcgtu+39pSYXGd0OZtgRFq3p3sdQarPb5azFu
	 vw+eEsA4cWaWSaJWuLOhJGBo5mxm90zmZBsf1ZQNQQJlaszOZjebMuXm7xN4YgVkOQ
	 zRwkWDdcQK8VbsvlUCICihB4miQSeRUp2isSZUgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440411AbgDNQvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440406AbgDNQtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC8420656;
        Tue, 14 Apr 2020 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882956;
        bh=/mHARHeWczRi1L5tDKAwMG7VRaHqjAqAAZDBdAFAoJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hDy+lq50lzxBnb1keJMR5ZhFNyRO3L5S+NZ2mJbZ9CvgWUzIy8B54nSUvEB+alk0
         Re541EWfc0j6Tb16rBoCNcTAebnm8RfcqirAPj0KXXFfTjMp18BAokdGxigUE8Fe0P
         laYaWpwb1nCHHo8BEQoRQoRLm76mv1dm0gLvdB8k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/15] tools headers UAPI: Sync sched.h with the kernel
Date:   Tue, 14 Apr 2020 13:48:44 -0300
Message-Id: <20200414164854.26026-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 2e3bc22c6f20..3bac0a8ceab2 100644
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
index 062ca849c8fd..f4db894e0af6 100644
--- a/tools/perf/trace/beauty/clone.c
+++ b/tools/perf/trace/beauty/clone.c
@@ -46,6 +46,7 @@ static size_t clone__scnprintf_flags(unsigned long flags, char *bf, size_t size,
 	P_FLAG(NEWNET);
 	P_FLAG(IO);
 	P_FLAG(CLEAR_SIGHAND);
+	P_FLAG(INTO_CGROUP);
 #undef P_FLAG
 
 	if (flags)
-- 
2.21.1


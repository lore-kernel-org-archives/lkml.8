Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE076C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CA22073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V8UDDlMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgE0Bv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:51:58 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44048 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgE0Bv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:51:57 -0400
Received: by linux.microsoft.com (Postfix, from userid 1040)
        id 7D19520B717B; Tue, 26 May 2020 18:51:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D19520B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1590544315;
        bh=C9ajJeJOQyL3l974xDokVYQ2Tn8ZMUfjZ4zwNe9QJkM=;
        h=From:To:Cc:Subject:Date:From;
        b=V8UDDlMwDyd+30hefwbAUrqx1yhHsCfUBoj/MlbWwlNyAocgxHRZnN9L6/P4Rrvxk
         IehBXj73lBaX+XReNqzNRM753cTPopdFOz2ibJP89WWvgAx0aNO+JtVzPa7sig0kdz
         67VCtK8D7dgybLPA95IgHgONHTW/ZXVu99sAC3YQ=
From:   Steve MacLean <steve.maclean@linux.microsoft.com>
Cc:     Steve MacLean <Steve.MacLean@Microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf inject --jit: Remove //anon mmap events
Date:   Tue, 26 May 2020 18:51:11 -0700
Message-Id: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve MacLean <Steve.MacLean@Microsoft.com>

**perf-<pid>.map and jit-<pid>.dump designs:

When a JIT generates code to be executed, it must allocate memory and
mark it executable using an mmap call.

*** perf-<pid>.map design

The perf-<pid>.map assumes that any sample recorded in an anonymous
memory page is JIT code. It then tries to resolve the symbol name by
looking at the process' perf-<pid>.map.

*** jit-<pid>.dump design

The jit-<pid>.dump mechanism takes a different approach. It requires a JIT
to write a `<path>/jit-<pid>.dump` file. This file must also be mmapped
so that perf inject -jit can find the file. The JIT must also add
JIT_CODE_LOAD records for any functions it generates. The records are
timestamped using a clock which can be correlated to the perf record
clock.

After perf record,  the `perf inject -jit` pass parses the recording
looking for a `<path>/jit-<pid>.dump` file. When it finds the file, it
parses it and for each JIT_CODE_LOAD record:
* creates an elf file `<path>/jitted-<pid>-<code_index>.so
* injects a new mmap record mapping the new elf file into the process.

*** Coexistence design

The kernel and perf support both of these mechanisms. We need to make
sure perf works on an app supporting either or both of these mechanisms.
Both designs rely on mmap records to determine how to resolve an ip
address.

The mmap records of both techniques by definition overlap. When the JIT
compiles a method, it must:
* allocate memory (mmap)
* add execution privilege (mprotect or mmap. either will
generate an mmap event form the kernel to perf)
* compile code into memory
* add a function record to perf-<pid>.map and/or jit-<pid>.dump

Because the jit-<pid>.dump mechanism supports greater capabilities, perf
prefers the symbols from jit-<pid>.dump. It implements this based on
timestamp ordering of events. There is an implicit ASSUMPTION that the
JIT_CODE_LOAD record timestamp will be after the // anon mmap event that
was generated during memory allocation or adding the execution privilege setting.

*** Problems with the ASSUMPTION

The ASSUMPTION made in the Coexistence design section above is violated
in the following scenario.

*** Scenario

While a JIT is jitting code it will eventually need to commit more
pages and change these pages to executable permissions. Typically the
JIT will want these collocated to minimize branch displacements.

The kernel will coalesce these anonymous mapping with identical
permissions before sending an MMAP event for the new pages. The address
range of the new mmap will not be just the most recently mmap pages.
It will include the entire coalesced mmap region.

See mm/mmap.c

unsigned long mmap_region(struct file *file, unsigned long addr,
                unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
                struct list_head *uf)
{
...
        /*
         * Can we just expand an old mapping?
         */
...
        perf_event_mmap(vma);
...
}

*** Symptoms

The coalesced // anon mmap event will be timestamped after the
JIT_CODE_LOAD records. This means it will be used as the most recent
mapping for that entire address range. For remaining events it will look at the
inferior perf-<pid>.map for symbols.

If both mechanisms are supported, the symbol will appear twice with
different module names. This causes weird behavior in reporting.

If only jit-<pid>.dump is supported, the symbol will no longer be resolved.

** Implemented solution

This patch solves the issue by removing // anon mmap events for any
process which has a valid jit-<pid>.dump file.

It tracks on a per process basis to handle the case where some running
apps support jit-<pid>.dump, but some only support perf-<pid>.map.

It adds new assumptions:
* // anon mmap events are only required for perf-<pid>.map support.
* An app that uses jit-<pid>.dump, no longer needs
perf-<pid>.map support. It assumes that any perf-<pid>.map info is
inferior.

*** Details

Use thread->priv to store whether a jitdump file has been processed

During "perf inject --jit", discard "//anon*" mmap events for any pid which
has sucessfully processed a jitdump file.

** Committer testing:

// jitdump case
perf record <app with jitdump>
perf inject --jit --input perf.data --output perfjit.data
// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'
// no jitdump case
perf record <app without jitdump>
perf inject --jit --input perf.data --output perfjit.data
// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events not removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

** Repro:

This issue was discovered while testing the initial CoreCLR jitdump
implementation. https://github.com/dotnet/coreclr/pull/26897.

** Alternate solutions considered

These were also briefly considered
* Change kernel to not coalesce mmap regions.
* Change kernel reporting of coalesced mmap regions to perf. Only
include newly mapped memory.
* Only strip parts of // anon mmap events overlapping existing
jitted-<pid>-<code_index>.so mmap events.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
---
 tools/perf/builtin-inject.c |  4 ++--
 tools/perf/util/jitdump.c   | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3..0f38862 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -263,7 +263,7 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
 	 * if jit marker, then inject jit mmaps and generate ELF images
 	 */
 	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap.filename, sample->pid, &n);
+			  event->mmap.filename, event->mmap.pid, &n);
 	if (ret < 0)
 		return ret;
 	if (ret) {
@@ -301,7 +301,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
 	 * if jit marker, then inject jit mmaps and generate ELF images
 	 */
 	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap2.filename, sample->pid, &n);
+			  event->mmap2.filename, event->mmap2.pid, &n);
 	if (ret < 0)
 		return ret;
 	if (ret) {
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e3ccb0c..d18596e 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -26,6 +26,7 @@
 #include "jit.h"
 #include "jitdump.h"
 #include "genelf.h"
+#include "thread.h"
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
@@ -749,6 +750,28 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	return 0;
 }
 
+static void jit_add_pid(struct machine *machine, pid_t pid)
+{
+	struct thread *thread = machine__findnew_thread(machine, pid, pid);
+
+	if (!thread) {
+		pr_err("%s: thread %d not found or created\n", __func__, pid);
+		return;
+	}
+
+	thread->priv = (void *)1;
+}
+
+static bool jit_has_pid(struct machine *machine, pid_t pid)
+{
+	struct thread *thread = machine__find_thread(machine, pid, pid);
+
+	if (!thread)
+		return 0;
+
+	return (bool)thread->priv;
+}
+
 int
 jit_process(struct perf_session *session,
 	    struct perf_data *output,
@@ -764,8 +787,13 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	/*
 	 * first, detect marker mmap (i.e., the jitdump mmap)
 	 */
-	if (jit_detect(filename, pid))
+	if (jit_detect(filename, pid)) {
+		// Strip //anon* mmaps if we processed a jitdump for this pid
+		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
+			return 1;
+
 		return 0;
+	}
 
 	memset(&jd, 0, sizeof(jd));
 
@@ -784,6 +812,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = jit_inject(&jd, filename);
 	if (!ret) {
+		jit_add_pid(machine, pid);
 		*nbytes = jd.bytes_written;
 		ret = 1;
 	}
-- 
1.8.3.1


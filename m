Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C74C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FCE21582
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgDVMTa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728897AbgDVMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74496C03C1AE;
        Wed, 22 Apr 2020 05:17:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREK4-0008D1-3F; Wed, 22 Apr 2020 14:17:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9AC801C081A;
        Wed, 22 Apr 2020 14:17:39 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Synthesize bpf_trampoline/dispatcher
 ksymbol event
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, bjorn.topel@intel.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158755785918.28353.10912233734711838427.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     943930e4729a64c11142a0370415663b39189996
Gitweb:        https://git.kernel.org/tip/943930e4729a64c11142a0370415663b39189996
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 12 Mar 2020 20:56:08 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:06 -03:00

perf tools: Synthesize bpf_trampoline/dispatcher ksymbol event

Synthesize bpf images (trampolines/dispatchers) on start, as ksymbol
events from /proc/kallsyms. Having this perf can recognize samples from
those images and perf report and top shows them correctly.

The rest of the ksymbol handling is already in place from for the bpf
programs monitoring, so only the initial state was needed.

perf report output:

  # Overhead  Command     Shared Object                  Symbol

    12.37%  test_progs  [kernel.vmlinux]                 [k] entry_SYSCALL_64
    11.80%  test_progs  [kernel.vmlinux]                 [k] syscall_return_via_sysret
     9.63%  test_progs  bpf_prog_bcf7977d3b93787c_prog2  [k] bpf_prog_bcf7977d3b93787c_prog2
     6.90%  test_progs  bpf_trampoline_24456             [k] bpf_trampoline_24456
     6.36%  test_progs  [kernel.vmlinux]                 [k] memcpy_erms

Committer notes:

Use scnprintf() instead of strncpy() to overcome this on fedora:32,
rawhide and OpenMandriva Cooker:

    CC       /tmp/build/perf/util/bpf-event.o
  In file included from /usr/include/string.h:495,
                   from /git/linux/tools/lib/bpf/libbpf_common.h:12,
                   from /git/linux/tools/lib/bpf/bpf.h:31,
                   from util/bpf-event.c:4:
  In function 'strncpy',
      inlined from 'process_bpf_image' at util/bpf-event.c:323:2,
      inlined from 'kallsyms_process_symbol' at util/bpf-event.c:358:9:
  /usr/include/bits/string_fortified.h:106:10: error: '__builtin_strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
    106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Björn Töpel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200312195610.346362-14-jolsa@kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 93 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index a3207d9..0cd41a8 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -6,6 +6,9 @@
 #include <bpf/libbpf.h>
 #include <linux/btf.h>
 #include <linux/err.h>
+#include <linux/string.h>
+#include <internal/lib.h>
+#include <symbol/kallsyms.h>
 #include "bpf-event.h"
 #include "debug.h"
 #include "dso.h"
@@ -290,11 +293,82 @@ out:
 	return err ? -1 : 0;
 }
 
+struct kallsyms_parse {
+	union perf_event	*event;
+	perf_event__handler_t	 process;
+	struct machine		*machine;
+	struct perf_tool	*tool;
+};
+
+static int
+process_bpf_image(char *name, u64 addr, struct kallsyms_parse *data)
+{
+	struct machine *machine = data->machine;
+	union perf_event *event = data->event;
+	struct perf_record_ksymbol *ksymbol;
+	int len;
+
+	ksymbol = &event->ksymbol;
+
+	*ksymbol = (struct perf_record_ksymbol) {
+		.header = {
+			.type = PERF_RECORD_KSYMBOL,
+			.size = offsetof(struct perf_record_ksymbol, name),
+		},
+		.addr      = addr,
+		.len       = page_size,
+		.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
+		.flags     = 0,
+	};
+
+	len = scnprintf(ksymbol->name, KSYM_NAME_LEN, "%s", name);
+	ksymbol->header.size += PERF_ALIGN(len + 1, sizeof(u64));
+	memset((void *) event + event->header.size, 0, machine->id_hdr_size);
+	event->header.size += machine->id_hdr_size;
+
+	return perf_tool__process_synth_event(data->tool, event, machine,
+					      data->process);
+}
+
+static int
+kallsyms_process_symbol(void *data, const char *_name,
+			char type __maybe_unused, u64 start)
+{
+	char disp[KSYM_NAME_LEN];
+	char *module, *name;
+	unsigned long id;
+	int err = 0;
+
+	module = strchr(_name, '\t');
+	if (!module)
+		return 0;
+
+	/* We are going after [bpf] module ... */
+	if (strcmp(module + 1, "[bpf]"))
+		return 0;
+
+	name = memdup(_name, (module - _name) + 1);
+	if (!name)
+		return -ENOMEM;
+
+	name[module - _name] = 0;
+
+	/* .. and only for trampolines and dispatchers */
+	if ((sscanf(name, "bpf_trampoline_%lu", &id) == 1) ||
+	    (sscanf(name, "bpf_dispatcher_%s", disp) == 1))
+		err = process_bpf_image(name, start, data);
+
+	free(name);
+	return err;
+}
+
 int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts)
 {
+	const char *kallsyms_filename = "/proc/kallsyms";
+	struct kallsyms_parse arg;
 	union perf_event *event;
 	__u32 id = 0;
 	int err;
@@ -303,6 +377,8 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	event = malloc(sizeof(event->bpf) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
+
+	/* Synthesize all the bpf programs in system. */
 	while (true) {
 		err = bpf_prog_get_next_id(id, &id);
 		if (err) {
@@ -335,6 +411,23 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 			break;
 		}
 	}
+
+	/* Synthesize all the bpf images - trampolines/dispatchers. */
+	if (symbol_conf.kallsyms_name != NULL)
+		kallsyms_filename = symbol_conf.kallsyms_name;
+
+	arg = (struct kallsyms_parse) {
+		.event   = event,
+		.process = process,
+		.machine = machine,
+		.tool    = session->tool,
+	};
+
+	if (kallsyms__parse(kallsyms_filename, &arg, kallsyms_process_symbol)) {
+		pr_err("%s: failed to synthesize bpf images: %s\n",
+		       __func__, strerror(errno));
+	}
+
 	free(event);
 	return err;
 }

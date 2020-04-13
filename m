Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37DBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FA42076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796749;
	bh=BeMfiKoM1HPrk5N7B8y8DbFVG2B/mSoTaSD4GFKpvrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wBp9LltOeywggcjFOwGvEVdcceSkJRUGBd1TjukL6eiRVVQuYqxRx8AGDdAR/EGaR
	 mR/PV71S/SLb8rAjviXzGJzoizg+bcaYZmustYRHaW0RRZBEB56t7zStZn9WdPbPjI
	 k+xBv41LQUGR8Iae/kZGseMXWqOZFXL9XdRIFK1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgDMQw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731841AbgDMQwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:52:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6053F20857;
        Mon, 13 Apr 2020 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796737;
        bh=BeMfiKoM1HPrk5N7B8y8DbFVG2B/mSoTaSD4GFKpvrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vi/57LaIktpx/gQm/uAHCS5vcvbTuDtY+Y/bTAy7INWqGoBM7EMBt7bMd0L0940zy
         gyLUrt9LbNQxkL9WrADK5gtdIDp4f2fHBUxdU9K11PtxUjDpF8KeytrDpZMmc9RIiR
         ipQLuUz64lB6egLl2ax8EM6D2Ak7kaVpRF2xvNQE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/26] perf tools: Synthesize bpf_trampoline/dispatcher ksymbol event
Date:   Mon, 13 Apr 2020 13:51:38 -0300
Message-Id: <20200413165203.1816-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 tools/perf/util/bpf-event.c | 93 +++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index a3207d900339..0cd41a862952 100644
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
@@ -290,11 +293,82 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
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
-- 
2.21.1


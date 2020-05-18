Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4160C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1D620758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589811039;
	bh=qofNNklcalMpuGWBoUKJJY7FgfoOjbmW6q0duAvIXcU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=j6ZhXSFhcyAs6NTIM5iUCVtO+dlQUDdIoAlEQAmJeZAxBuO7XOp/4YD+zb1Vy6ivA
	 dg50QPi32rzBNmOP+IX9Bun7MNuE0sLf2ZSf2rpxatG2gmWKil2YXyJtBfsw4WNYlc
	 ZTtJ8Y60+kFZtvIDAqRiPdeZGWnExcpE9OVx9MfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgEROKi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:10:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54984 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726945AbgEROKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:10:38 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Rc9al0JYPzyOmqTSwBUjXQ-1; Mon, 18 May 2020 10:10:32 -0400
X-MC-Unique: Rc9al0JYPzyOmqTSwBUjXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D090D835B8B;
        Mon, 18 May 2020 14:10:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.196.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C71332CD69;
        Mon, 18 May 2020 14:10:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [RFC] perf trace: Fix compilation error for make NO_LIBBPF=1 DEBUG=1
Date:   Mon, 18 May 2020 16:10:27 +0200
Message-Id: <20200518141027.3765877-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tested if this breaks some perf trace functionality,
hence RFC ;-)

The perf compilation fails for NO_LIBBPF=1 DEBUG=1 with:

  $ make NO_LIBBPF=1 DEBUG=1
    BUILD:   Doing 'make -j8' parallel build
    CC       builtin-trace.o
    LD       perf-in.o
    LINK     perf
  /usr/bin/ld: perf-in.o: in function `trace__find_bpf_map_by_name':
  /home/jolsa/kernel/linux-perf/tools/perf/builtin-trace.c:4608: undefined reference to `bpf_object__find_map_by_name'
  collect2: error: ld returned 1 exit status
  make[2]: *** [Makefile.perf:631: perf] Error 1
  make[1]: *** [Makefile.perf:225: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2

Moving trace__find_bpf_map_by_name calls under HAVE_LIBBPF_SUPPORT
ifdef and add make test for this.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c | 54 ++++++++++++++++++++++++--------------
 tools/perf/tests/make      |  1 +
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 56bcf1ab19f8..61bafca1018a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3174,6 +3174,26 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 }
 
 #ifdef HAVE_LIBBPF_SUPPORT
+static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
+{
+	if (trace->bpf_obj == NULL)
+		return NULL;
+
+	return bpf_object__find_map_by_name(trace->bpf_obj, name);
+}
+
+static void trace__set_bpf_map_filtered_pids(struct trace *trace)
+{
+	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
+}
+
+static void trace__set_bpf_map_syscalls(struct trace *trace)
+{
+	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
+	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
+	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
+}
+
 static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
 {
 	if (trace->bpf_obj == NULL)
@@ -3512,6 +3532,20 @@ static void trace__delete_augmented_syscalls(struct trace *trace)
 	trace->bpf_obj = NULL;
 }
 #else // HAVE_LIBBPF_SUPPORT
+static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace __maybe_unused,
+						   const char *name __maybe_unused)
+{
+	return NULL;
+}
+
+static void trace__set_bpf_map_filtered_pids(struct trace *trace __maybe_unused)
+{
+}
+
+static void trace__set_bpf_map_syscalls(struct trace *trace __maybe_unused)
+{
+}
+
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
 {
 	return 0;
@@ -4600,26 +4634,6 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 	return 0;
 }
 
-static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
-{
-	if (trace->bpf_obj == NULL)
-		return NULL;
-
-	return bpf_object__find_map_by_name(trace->bpf_obj, name);
-}
-
-static void trace__set_bpf_map_filtered_pids(struct trace *trace)
-{
-	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
-}
-
-static void trace__set_bpf_map_syscalls(struct trace *trace)
-{
-	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
-	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
-	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
-}
-
 static int trace__config(const char *var, const char *value, void *arg)
 {
 	struct trace *trace = arg;
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 5d0c3a9c47a1..c3c59def9f87 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -84,6 +84,7 @@ make_no_libaudit    := NO_LIBAUDIT=1
 make_no_libbionic   := NO_LIBBIONIC=1
 make_no_auxtrace    := NO_AUXTRACE=1
 make_no_libbpf	    := NO_LIBBPF=1
+make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
 make_no_libcrypto   := NO_LIBCRYPTO=1
 make_with_babeltrace:= LIBBABELTRACE=1
 make_no_sdt	    := NO_SDT=1
-- 
2.25.4


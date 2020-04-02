Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B18C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7B3206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585792390;
	bh=H6aHCcDMj6hcwI0cywXgcJlAiZwTaspnebpzMLfe2Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WCmuEiB9im+f8HNc+ELw7/g+/3VmXZMBhQWPou0Q8hOeGR4M93xIEqZY/8mFw7RLK
	 ZWkuG25JTmkkRvSqSO2kppr88EoIgqftnav7t9O6/Sa7CihlAk11eBYHCMAbGxPSwE
	 P7MaALwySnnW5Rubt782+wavNHOhOOH273h/0t8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgDBBxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:53:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39846 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgDBBxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:53:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id k18so740332pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQEI873PF2LrUSqZm3036pkATOUPJKvAFL2pT5so68E=;
        b=gxPgWVpnWU/fcUfkImFnkxuUoa9yoL0i10I/EsLVqHzlnRHZoJbj2bfkK2MjsXocQM
         qVlIv2WnRITELACweOOgOS7yeDc6qembSKAIOuSdus0nTI3Pc6GdR4TNFeHJrUFwYWHB
         fAzi5Mstn/hgfT7noAHcdd2/FT9trwF1TkBmxTOneeApdFWVRCT13XYqMLGbpdFMXVoF
         Mp5WTqehqnRPEmv4I1RN3bJHdthT0WRykoNcO27DFU/MfP9zqbVVzkI/9zmkOEk/hJTu
         fHdsdKSyRR62bos3yb9ZgkranEic8VXvRhP6E9Z3M+XAAlFmLeYgOmqo4+J0ucutAqRr
         CjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vQEI873PF2LrUSqZm3036pkATOUPJKvAFL2pT5so68E=;
        b=dYJGqErX3Mf3ufpvvBDRZ+S4tHYJDsE/SzixHqoPWPZb8N88J5cfnIWATjz2HAqRyx
         C3LYFi+XmnEOOXWz5qN3+m2NM6zCuUrAUhoVYjAFIHs1AbMQXNWFNFa8QWW6hsTz/toe
         hfnFxtYOmRGVsE3Q7kUTz/je94UmnTW1vnzhd4Uk4OtStuBYAtEwzZGAwSNMzU33AaLn
         ZKYlpyz1lhu0cdQWTQqQstM/ggXMy6VxS0qd4jgFiIIXywKlAOOvxa7vmOR0GHCpFUTT
         5GufyzwHYQotUG7cXc1Kwy8tPibYishz4FG/HOwhXRZw7G3lre/XzLKd5IudZ3a+TUf5
         Pk1w==
X-Gm-Message-State: AGi0PuZPBlM1gvi+7/veLQb3HAh9tAyVAG6yBgk3HyjzhWeqx6AmnRrS
        vafi/5Y0c9BqibALjw3d9wE=
X-Google-Smtp-Source: APiQypKhk7dAqOgtbiRF7u52WOhvNj+VEfkmWgncyhWRHSxda+01OtPzFpHwS6e5KxPPomOxmGpMpQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr1068156pjg.35.1585792386379;
        Wed, 01 Apr 2020 18:53:06 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h71sm2287533pge.32.2020.04.01.18.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 18:53:05 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf tools: Add file-handle feature test
Date:   Thu,  2 Apr 2020 10:52:49 +0900
Message-Id: <20200402015249.3800462-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <CAM9d7cgtEXGZL+GZeLy1RmoU=jB4BfLApbsV9F=iDx6cqMh_5A@mail.gmail.com>
References: <CAM9d7cgtEXGZL+GZeLy1RmoU=jB4BfLApbsV9F=iDx6cqMh_5A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file handle (FHANDLE) support is configurable so some systems might
not have it.  So add a config feature item to check it on build time
and reject cgroup tracking based on that.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/build/Makefile.feature           |  3 ++-
 tools/build/feature/Makefile           |  6 +++++-
 tools/build/feature/test-file-handle.c | 14 ++++++++++++++
 tools/perf/Makefile.config             |  4 ++++
 tools/perf/builtin-record.c            |  8 +++++++-
 tools/perf/builtin-top.c               |  8 +++++++-
 tools/perf/util/synthetic-events.c     |  9 +++++++++
 7 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 tools/build/feature/test-file-handle.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 574c2e0b9d20..3e0c019ef297 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -72,7 +72,8 @@ FEATURE_TESTS_BASIC :=                  \
         setns				\
         libaio				\
         libzstd				\
-        disassembler-four-args
+        disassembler-four-args		\
+        file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ac0d8088565..621f528f7822 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -67,7 +67,8 @@ FILES=                                          \
          test-llvm.bin				\
          test-llvm-version.bin			\
          test-libaio.bin			\
-         test-libzstd.bin
+         test-libzstd.bin			\
+         test-file-handle.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -321,6 +322,9 @@ FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
+$(OUTPUT)test-file-handle.bin:
+	$(BUILD)
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-file-handle.c b/tools/build/feature/test-file-handle.c
new file mode 100644
index 000000000000..5f8c16f8784f
--- /dev/null
+++ b/tools/build/feature/test-file-handle.c
@@ -0,0 +1,14 @@
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+int main(void)
+{
+	struct file_handle fh;
+	int mount_id;
+
+	name_to_handle_at(AT_FDCWD, "/", &fh, &mount_id, 0);
+	return 0;
+}
+
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 80e55e796be9..eb95c0c0a169 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -348,6 +348,10 @@ ifeq ($(feature-gettid), 1)
   CFLAGS += -DHAVE_GETTID
 endif
 
+ifeq ($(feature-file-handle), 1)
+  CFLAGS += -DHAVE_FILE_HANDLE
+endif
+
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7d7912e121d6..1ab349abe904 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1433,8 +1433,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->opts.record_namespaces)
 		tool->namespace_events = true;
 
-	if (rec->opts.record_cgroup)
+	if (rec->opts.record_cgroup) {
+#ifdef HAVE_FILE_HANDLE
 		tool->cgroup_events = true;
+#else
+		pr_err("cgroup tracking is not supported\n");
+		return -1;
+#endif
+	}
 
 	if (rec->opts.auxtrace_snapshot_mode || rec->switch_output.enabled) {
 		signal(SIGUSR2, snapshot_sig_handler);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 56b2dd0db88e..02ea2cf2a3d9 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1246,8 +1246,14 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
-	if (opts->record_cgroup)
+	if (opts->record_cgroup) {
+#ifdef HAVE_FILE_HANDLE
 		top->tool.cgroup_events = true;
+#else
+		pr_err("cgroup tracking is not supported.\n");
+		return -1;
+#endif
+	}
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 24975470ed5c..f96e84956d84 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -415,6 +415,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	return rc;
 }
 
+#ifdef HAVE_FILE_HANDLE
 static int perf_event__synthesize_cgroup(struct perf_tool *tool,
 					 union perf_event *event,
 					 char *path, size_t mount_len,
@@ -526,6 +527,14 @@ int perf_event__synthesize_cgroups(struct perf_tool *tool,
 
 	return 0;
 }
+#else
+int perf_event__synthesize_cgroups(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine)
+{
+	return -1;
+}
+#endif
 
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
-- 
2.26.0.rc2.310.g2932bb562d-goog


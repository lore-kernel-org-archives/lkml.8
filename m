Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D63C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658D62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un4WQVe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgD2XO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgD2XOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:14:52 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D94C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:14:52 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d15so4458609qkl.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eiWqfc49ogrYbZ/4/xuGkLOd4BeleFiuwlczI7sArlo=;
        b=Un4WQVe5D1bdYyPUVc6UQDO3j0T9MYR3rGyZ2ceOJtfX6QNrYpRMgVjMcxYeEps1k6
         ZMWjpH0eDukhgY7ojYA6f3eFq0CHjY/IOyeDzaHrv4Y/2YLXEoxQ/KPcJsmECkud8/+P
         sl/yU64IiBRk1Bit02eWZd5mGAH+MEiCK7tWX1R7HsMsPRDFljOz2Ux3BjDce695yBMJ
         69WpStLxpilYpM4uLeKxhJtqUzMymXy4kH77soTQRCaKfLFbhrNBqPZhhhydncySyGAp
         CpkuWlKPgRwgj5H0TesyuQwJ10CCQeidlGmYMcetG0KWehLkbleIzKKzxac82MvYBRlq
         2ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eiWqfc49ogrYbZ/4/xuGkLOd4BeleFiuwlczI7sArlo=;
        b=QPsrwARQUNAOmiXyR5Ih28TdsttdCLDc98TMBxAmyt3F1f7FPZDXzLxL9RDcuVrRE4
         5Xdd8Q/n/PkUgbPDnuvEPqhli1UpPFC9cmOWlffE4tzlP8OE0REPyFbDZY6JZONPTdDK
         fs05naMUmM4HEhmYy2BfCNCrEjuMLd2fFsJYkExegFpAw/QpRTKakeIxQy3f6NVIdYFZ
         0ubGEVzFs89nmnDmf2US7w6Kf9aYdorEX4DC/TXMJuMHOtzGwE6MrH/C+6kyg7LPRMPc
         lBtW0IJVXmNzjjsGbX9lhnBpkR7/BH1bfHUqxvXTQLRZJLhVhBWVsF6TDkyaA55iaMDn
         FmSQ==
X-Gm-Message-State: AGi0Pua8tpzREMMjwBwOgoxxhekQXFHgKzPQ5u7FGqp2wAdI0GPwu1b7
        wF9aaF13ECBMqxd7d1K8og2NP8VWmBE5
X-Google-Smtp-Source: APiQypJF+pNX0f25uRs8CxEj2RzxyRoLpHIC31I9C2TGE4E2d47A5QkzmO9GJcdYTfo+svN1asUse81hbhTv
X-Received: by 2002:a0c:d652:: with SMTP id e18mr292809qvj.58.1588202091087;
 Wed, 29 Apr 2020 16:14:51 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:14:41 -0700
In-Reply-To: <20200429231443.207201-1-irogers@google.com>
Message-Id: <20200429231443.207201-3-irogers@google.com>
Mime-Version: 1.0
References: <20200429231443.207201-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v12 2/4] tools feature: add support for detecting libpfm4
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

libpfm4 provides an alternate command line encoding of perf events.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature       | 3 ++-
 tools/build/feature/Makefile       | 6 +++++-
 tools/build/feature/test-libpfm4.c | 9 +++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libpfm4.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3e0c019ef297..3abd4316cd4f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -98,7 +98,8 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          llvm-version                   \
          clang                          \
-         libbpf
+         libbpf                         \
+         libpfm4
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 92012381393a..84f845b9627d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -69,7 +69,8 @@ FILES=                                          \
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-global-var.bin		\
-         test-file-handle.bin
+         test-file-handle.bin			\
+         test-libpfm4.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -331,6 +332,9 @@ $(OUTPUT)test-clang-bpf-global-var.bin:
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libpfm4.bin:
+	$(BUILD) -lpfm
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-libpfm4.c b/tools/build/feature/test-libpfm4.c
new file mode 100644
index 000000000000..af49b259459e
--- /dev/null
+++ b/tools/build/feature/test-libpfm4.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/types.h>
+#include <perfmon/pfmlib.h>
+
+int main(void)
+{
+	pfm_initialize();
+	return 0;
+}
-- 
2.26.2.303.gf8c07b1a785-goog


Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FBC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94FB920767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soPE3YbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503505AbgDNSLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503478AbgDNSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:11:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69582C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:11:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v71so13682929pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=soPE3YbSyYsetKYuTK1j8cBgfL1ufL/chbR0V1Nlr/KGFsEhqXTx37PrP+FQqZ0VYS
         NctD2fvmwY0Mz0T3Tcm3+G7nBpf9rZrXjJUeST7ysZvyAr/mrERTRZWTCT2/0UIRi5/Z
         q3KMJmhn4tEpliFy/lSZC8i7J7aWbJfQN21+4ZFDhmKviV5dV+ltPNrogtJFbmI87/hL
         dh42b3mlezccKwMiD+jM5ivV64HZ+tLkq/7I3cFlXr6jqHlMyidiBdgzeBrS9/3wb9yA
         VoQgrEmq7kcUFtWJiiCr5r+X2ChTmphrOZS/2BOjmBmPijYVLcQ4/ngHh9BbhtWWjdSe
         cODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=d9kp8cQQDOFv5UeAmslEVmtfwPMnhfs0mVim33grqch2O1ZFLhM5OwZ1TsEidkjQvx
         B4PQ35CJaGkzio/TCWc/LvOmRyJ0CMISN4WY1JjMsJ8znr9nYsDJbdIXINFDZxFVRAIs
         H11nf/zVwTSCWct09VF/6YLtzIK1Yo8hLmSqTlknN1TsiIYNcqEpiq4wKf81ATZoBQqb
         xytUWm1taaJbKF6qGZ24Lpf0pC4RW5/kHnLo8Ci+r5UUSC9WwBNC3hJs4yo12ptvtkiU
         HTCDZB44RvY3v+K/MvUvq1AASW9QF2/QppGCqzdImh3rV+k0Zgpz5CUezB6gwZXmnvwP
         xm+w==
X-Gm-Message-State: AGi0PuZOda25vFkynMeL2I1Sd/0jUXRq9ZuhMWUnEhuljxvUtDgM1+BV
        EF1srt2DMoUCGC4HTxjgoBQ04OqNd4mF
X-Google-Smtp-Source: APiQypKS42oeOJ/EEIPZ1vIkACtXeNF9CLv/+ToiDrm8HpPrn9vyCpP3q9r8jnr+W/V+4FlFShEz/09JUiYJ
X-Received: by 2002:a17:90a:14c6:: with SMTP id k64mr1503515pja.39.1586887863831;
 Tue, 14 Apr 2020 11:11:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:10:52 -0700
In-Reply-To: <20200414181054.22435-1-irogers@google.com>
Message-Id: <20200414181054.22435-3-irogers@google.com>
Mime-Version: 1.0
References: <20200414181054.22435-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 2/4] tools feature: add support for detecting libpfm4
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
index 621f528f7822..a6eded94a36b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -68,7 +68,8 @@ FILES=                                          \
          test-llvm-version.bin			\
          test-libaio.bin			\
          test-libzstd.bin			\
-         test-file-handle.bin
+         test-file-handle.bin			\
+         test-libpfm4.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -325,6 +326,9 @@ $(OUTPUT)test-libzstd.bin:
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
2.26.0.110.g2183baf09c-goog


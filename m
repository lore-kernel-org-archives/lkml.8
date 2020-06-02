Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5C92072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFBEPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:15:20 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59922 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgFBEPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:15:20 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx399J0tVe14A8AA--.2282S3;
        Tue, 02 Jun 2020 12:15:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/2] perf tools: Remove some duplicated includes
Date:   Tue,  2 Jun 2020 12:15:04 +0800
Message-Id: <1591071304-19338-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
References: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dx399J0tVe14A8AA--.2282S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw48Cw45WFy7GrW8tr13urg_yoW8tw17pF
        4DCrW7J343XF15KwnxAF4SgFW7Wws3uFyrG34Igr4kZr1Iyrn7JrZ7tF15tF4UX3yDtw1Y
        9ryDGrs8Jr4rZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj-eOJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exists some duplicated includes in tools/perf, remove them.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/builtin-report.c | 1 -
 tools/perf/util/annotate.c  | 1 -
 tools/perf/util/auxtrace.c  | 1 -
 tools/perf/util/config.c    | 1 -
 tools/perf/util/session.c   | 1 -
 5 files changed, 5 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ba63390..5425a2c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -47,7 +47,6 @@
 #include "util/time-utils.h"
 #include "util/auxtrace.h"
 #include "util/units.h"
-#include "util/branch.h"
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d828c2d..76bfb4a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -41,7 +41,6 @@
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <bpf/libbpf.h>
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 749487a..94a8f4f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -55,7 +55,6 @@
 #include "util/mmap.h"
 
 #include <linux/ctype.h>
-#include <linux/kernel.h>
 #include "symbol/kallsyms.h"
 #include <internal/lib.h>
 
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index ef38eba..64f14a5 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -20,7 +20,6 @@
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
-#include "debug.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c11d89e..5550e26e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -33,7 +33,6 @@
 #include "../perf.h"
 #include "arch/common.h"
 #include <internal/lib.h>
-#include <linux/err.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
 static int perf_session__process_compressed_event(struct perf_session *session,
-- 
2.1.0


Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA212C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780D1206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyDpG3qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCMA4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:56:08 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55923 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMA4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:56:07 -0400
Received: by mail-pg1-f201.google.com with SMTP id r10so4717082pgu.22
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8Seoij4ALETWEJFvgHk8UkPpVlPLf3FDOygziQYap+c=;
        b=QyDpG3qkwbUhxqn8yjbAlijmB/mOmxa7YwBJMTKrPzLOCr9mvxkCuOY3fH9RZdtigw
         2xMxma3PsOXuHqLOYKdyWkREE97D/rgnxB+Mt92TR6yXVdyZaxNTM2/rJqS5/P2KLAeE
         G3SXdEssDwkwNV9GAdg6CcCNHMG57OdQS5BGMd68f3I4rcQbH1Fv/0EFm0c1abZcyl90
         YJLWfdskYOLoAzgHoZK8ctmN0LAZnKiOZZFT3UmSjQRsxW0alfrVbHlLFvVQ1c490Abk
         l+16bCw4SMAb+D4B/fFmIEUtbX6ECnqEEUWyc6MyCI0QURAjEJEKOkVFM6jwjtLXYAoP
         bXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8Seoij4ALETWEJFvgHk8UkPpVlPLf3FDOygziQYap+c=;
        b=U8Zc04z1Jmr5JvFKDEYL4znKjo2DITgn6bEQTysrkt24QoMovBoO70Ut2c+fvIHZm1
         X9bVYxLClfrM6YYPSizcjZrt6nrG/PUrtE81CVgeGiUUODdfjWlkpF4IFT+TZdLkUq7n
         VMPqO/SnhfpT+POgOI0VjXvsYA0KxViHHblxQwmpRBbusRuTQi4wzFmIHWxYWW8B1j5v
         ZTLoMfmw9gj+4cLpcYcw55ItSC06pF52uHGikMWGgImHWQZMdgVE9q/eXqQGNP8JMa/M
         BhHppa4u1yDkoeQy3h+8QlXOOIwxofHmHCCfrEZFSI7P4zXSCnk30zym5IBhriCiWk6e
         XpSQ==
X-Gm-Message-State: ANhLgQ39kg6nE7DaThF4Yzx7dhr3RQDftuxA0WgP+9EFcI2WRzQzokTl
        +/szX25nIh6ZsqIcqOKf4rsCEQIF9M/i
X-Google-Smtp-Source: ADFU+vvsI/W7/KuUwFW4MKOMv7dmgXEzDt3sx/y/sLU4mefzKExncgN6q6hMONuEHkWfj+cv/hkA+eYdzdNU
X-Received: by 2002:a63:6944:: with SMTP id e65mr11029646pgc.406.1584060966519;
 Thu, 12 Mar 2020 17:56:06 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:56:02 -0700
Message-Id: <20200313005602.45236-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] perf test: print if shell directory isn't present
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the shell test directory isn't present the exit code will be 255 but
with no error messages printed. Add an error message.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5f05db75cdd8..54d9516c9839 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -543,8 +543,11 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 		return -1;
 
 	dir = opendir(st.dir);
-	if (!dir)
+	if (!dir) {
+		pr_err("failed to open shell test directory: %s\n",
+			st.dir);
 		return -1;
+	}
 
 	for_each_shell_test(dir, st.dir, ent) {
 		int curr = i++;
-- 
2.25.1.481.gfbce0eb801-goog


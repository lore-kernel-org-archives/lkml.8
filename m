Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3CBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035C521582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEIM/oIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgF0NiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgF0NiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC977C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so6265085pgk.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUiaFhQXBjd6L5mR7qyeq05qsRXEHFURN+UUcSPjTlA=;
        b=rEIM/oIhGTKoU9GPe+1qJuUyaooU6oP1+eyqT97WVOZsetFapHxfpi7lJwr8XO0biE
         cvwRmk+G/HOGD/35TTKK0CrPh6MCNKVMaObFXC8YbVFrVJPuLBewCeP6Tqu7zyCF5KkL
         a1lkCXJgnrIlhvVPqPBttgyiWTfeylhCZi07Jz7xIilhQvk2cX5BBU46negFRvV6mAS2
         LN0OS0CKwg6Q9G0lojbD9UY4d/UHiDnttiOvpbu3ebJSUUrUdoWZN9+HP6kF0yV4x3P9
         gXj5D7JwMZ56v3slmPhPS0MkN4FnwxmYl91TO8k8Hcc+TBOKh2F8EQjnPiOo2GqVYecL
         nbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUiaFhQXBjd6L5mR7qyeq05qsRXEHFURN+UUcSPjTlA=;
        b=NjhLddT0GWG5w5cromQMha0rljR0xMkomoOkTM9VCfqZmVp3T1+Kq/C9k2l9BJyyTU
         re12ajlmyR81Uu7rhFbpaEAR7Z8FiceQZgEgTQyULUAQ+GE3wnAS+Jr4ZQF3oh3EigWx
         ONy9/ExmEcIoUYNnFGw1dsRR2aFPY5dXTJQbcwXsxuel3G+wYRmbD7CiGK12mXGU1jmn
         T5KIDPz7pC9880SZ1J4otb6NqRFJXOyzL11WFRu85njQqG3kkltk2J6WMb+F8/FwH3AT
         RLACS3RMDIJannhGbgzQjSS+KIfN4Z6BdaO4ApndU3QTNXdua8UeeDBV2DkQ/dDrORS4
         dszA==
X-Gm-Message-State: AOAM5324GtIvf/mTnKEHSmF3fh3RX43AfNIHVdMk56ztFCQcP2q7IIIT
        BbPAKMgUb4YPwB2Wubp3enw=
X-Google-Smtp-Source: ABdhPJy1l7OwEih4MzdDlKdYAdS1Lqe98Qt84aur+v7S/XwrCnuJvL34dYvhZ3WAIHA7GB4qmQkS6A==
X-Received: by 2002:a63:564e:: with SMTP id g14mr3299143pgm.326.1593265092500;
        Sat, 27 Jun 2020 06:38:12 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 07/15] perf ftrace: show trace column header
Date:   Sat, 27 Jun 2020 21:36:46 +0800
Message-Id: <20200627133654.64863-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes perf-ftrace display column header before printing trace.

$ sudo perf ftrace
\# tracer: function
\#
\# entries-in-buffer/entries-written: 0/0   #P:8
\#
\#           TASK-PID     CPU#   TIMESTAMP  FUNCTION
\#              | |         |       |         |
           <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
           <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
           <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
           <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
           <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e45496012611..686d744d5025 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -430,6 +430,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
+	/* display column headers */
+	read_tracing_file_to_stdout("trace");
+
 	if (!ftrace->initial_delay) {
 		if (write_tracing_file("tracing_on", "1") < 0) {
 			pr_err("can't enable tracing\n");
-- 
2.25.1


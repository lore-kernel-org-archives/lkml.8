Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79776C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD0220734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+2k0tfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgGQOhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgGQOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:37:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BB2C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so6446316pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eijOJmGeXbqqTxPaJjxhGuk/GGaaVtUD+GTIed+9zZI=;
        b=s+2k0tfhKAXCopLGDpLYqC4CCk+0cP8QE/91LAc3DeEXA74Z3w0lz9kLLeQpxJoqjI
         Qko/8Jx0hPuE/hUsjgR6oinLRh5ZOcxCyo6D5kHHAx1bwKEFbjptOi1efqZK5jp0fGx6
         0cq2FQxqDRiCh4KA6IPC7w6ESLCHvZuwRYRuQDQxWtDdqZ6GQFVZpXKP7CpoXPRS+0ZC
         PdXRmda+sFPz7M5VX27hkH7vnyNLtZpi2f3gB+TwKU5d9Tr6li9illazYg80MCe6wdi2
         aK7QUO4qx/2e3qHioCWschTfcbQauDzOgqoF3HdZoBELFM1kAdGQse1g0JOu0wcdsZSu
         EqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eijOJmGeXbqqTxPaJjxhGuk/GGaaVtUD+GTIed+9zZI=;
        b=c38cKXVQq1vT/tgiNfkIlt0SjFGzM9T80wLrnH5Djrl7E021Uh1NwpW6WozJ2nvFJG
         Vbdpf/gEFEbAdIGoFg9rKodrFkKWKfyJ+8t2kb7N0BxCjHrZOaQFGqnoO8Hc5IhsH6gq
         mIeGk30QBu2GztTOFE5HQOdCFTDcp0epLzIoRONfyKWu60Y2eTQpkTA/fX4Z8nP/5fi6
         YjhlYHqzyQlP1JT0m5Sfs84NE3fbJTpscwInnFh9UQM3yR3yToPDW9jnyJ5tW1RqYecl
         MR7LFW6FVMTVxs5yfyu5pKmN+G03+0GkbEiKu1ET4fNWRljtpekCsNhd80i/u6jEWy/w
         orsg==
X-Gm-Message-State: AOAM530LpuurLlKFonj58s8Ksy3i1moWJq9+tHut667Kw9Ez5oUBTr5z
        DHjp6ofurCbk6SWCXh+5Iho=
X-Google-Smtp-Source: ABdhPJzLrMOY0HcknnLywTpgp4AKsJSOghmq5pxphVLE4ADsCL1oPRT74P0ScGBw/tzV6GvPcJa4Bw==
X-Received: by 2002:a17:90a:c915:: with SMTP id v21mr10337113pjt.48.1594996649761;
        Fri, 17 Jul 2020 07:37:29 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:37:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 05/17] perf ftrace: show trace column header
Date:   Fri, 17 Jul 2020 22:36:16 +0800
Message-Id: <20200717143628.47721-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes perf-ftrace display column header before printing trace.

  $ sudo perf ftrace
  # tracer: function
  #
  # entries-in-buffer/entries-written: 0/0   #P:8
  #
  #            TASK-PID     CPU#   TIMESTAMP  FUNCTION
  #              | |         |       |         |
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
index 3ea3aaa4650b..6ce626a2d0d1 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -433,6 +433,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
+	/* display column headers */
+	read_tracing_file_to_stdout("trace");
+
 	if (write_tracing_file("tracing_on", "1") < 0) {
 		pr_err("can't enable tracing\n");
 		goto out_close_fd;
-- 
2.25.1


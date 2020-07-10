Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72463C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC21207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JikiFCyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgGJNo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgGJNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55974C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so1070604pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTGTULWmfso35E7FYKTL1i0ulA/qmTVO7U/T6LRAxiQ=;
        b=JikiFCyJ4hGHBnvEheOKj9yRxNXyEf6KAG1N7ewyPo6nKWDxVwUkKisqavF6xayu0w
         4BOJPVh++hATAczbVhn7FdxrOILymOUAmFvkQtr4a4SBb11y/qDu3FI+1QcZdj9Yug9O
         Pn4X9Dkkh53ON1BCPpvpZkWiphrOM6UZFN1x4TzZ5w/iIZ6rPhrhJS1VDo4IesHayBWj
         x+SKOUdCZwDXWg0v8CU+A3oRjUO3bwCO3jHgZMQRu2a5y8G5pMAQyAh/loLmrxH7orSE
         cgOGpy2kABTc3LM+HuMGhE0nBCg+Z0zuA9Jq31ghyon9XP/PBye782iNqCWE8iolD0Bb
         6D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTGTULWmfso35E7FYKTL1i0ulA/qmTVO7U/T6LRAxiQ=;
        b=jMotseZqb8HCRypXxe40xSsisciYU4fdL3rrWPkLGHZLPEMfN0EY0R4zhkazbmz+s4
         OKEo57sf6frzoYLQ7BiYcWJsnA7gco4rtl6GwkRVUQfhbbH6SUgJTPxOnjuch9FkRBV6
         xD7oEG7xqV5K3CKB8e2wlMOelmVX+7WSSlp2cEvL/6rAX+5hkI4bupxPOIo2wtnZizVx
         Xkat0ARA1pezUX0pVJlDiCUU/y+P8wQTI+Q6fbeAEg3C9xrW67nxLPuSomS0pNy/tQ52
         8RUwj0gLfJ/q/FEZWaeyhIj2XL/OfI1Nrsizpcq0tzWLMlukq5wGsFWH3XOjcPnZFJpK
         UxSg==
X-Gm-Message-State: AOAM532+0x9SQ6You0B5OHagplcQGR6HM0ka2IpybdmisYyeKcpwOrLA
        7Nva5X61vWiSbCANBLMWH0A=
X-Google-Smtp-Source: ABdhPJyQAhT8dPQBBhmngRbuKrTNC1nuHjTawVWUe6KwzXtJ0pD3kFNdjHx+s6ufolBqmIKp3yCGUw==
X-Received: by 2002:a17:90a:db8a:: with SMTP id h10mr5932910pjv.197.1594388664979;
        Fri, 10 Jul 2020 06:44:24 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 06/17] perf ftrace: show trace column header
Date:   Fri, 10 Jul 2020 21:43:11 +0800
Message-Id: <20200710134322.15400-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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
index 348e2d960987..887e78b23a82 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -430,6 +430,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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


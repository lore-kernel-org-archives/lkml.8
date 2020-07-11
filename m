Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81D8C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A017D207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J56macQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGKMmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:49 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC341C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so3762145pgk.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTGTULWmfso35E7FYKTL1i0ulA/qmTVO7U/T6LRAxiQ=;
        b=J56macQfDm0v2yMuHIcIujfOQyyCoJwhrYBEsN7noz6bDyKXGvRkrAX/1dmiUmhoSA
         +rhIZLlQ8q9wytY3SDPMOQfFTZEA5WGYCDH0I1CaEmBhJDWmeSyQdFz9s4fx3NQVFESn
         U+quR95eunMUVvpqU0JS/HUnBAxOJKPfLbecI8SvfcWdzrf6Vs6+sX+txvA1ZqL6cgOQ
         3NLmF/U3qSzkPsFVqxiS6oQMu2dQnm2ksql1dpyS9FalzMbhPvx4Vd6QsqNoolxR2xww
         0XCWzB6bo0lBNWchi4wvZVV5gKffT1Giw+SIdtLa/zFghgQoTS7MN1eoQ/DMiWzwQfKO
         opTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTGTULWmfso35E7FYKTL1i0ulA/qmTVO7U/T6LRAxiQ=;
        b=iPjWdjj9uZVR+e2PS6Ofz5sjj1cYfdEWcSwDST28U63Ygai0BYoBKhOAfJG18ACZId
         s6XCW6PiBBsP1kZ6/vc43noOK7wxRaWcbHxYgkVjOvGjoNA9tkRLvo4W+cwF3Q0hFujR
         +7vM7UGpXvrN+Q/ec6IxUO43ZDxJIbuGs9v0zDUoFTp/BmHR7UH3oqNa4AXrehJ1WSyN
         g4yiF5gIQqBlzuqOeV3EobxhUb0eYJtWlwGTrEV7JEi/qmW4auodMlVRFv3BO8FLgk6h
         2a0fT/kM6mE5LAUqfDMjRMXWbgep/IH6nWGxacAIoQ0q4Kdn5t8D4eta2KvPgqNbgzhS
         J1PQ==
X-Gm-Message-State: AOAM532Oq8Pb/7sISsIIUD2fnChulVAh4DoURT2MmAG8s7uRpGg/8wTe
        jvOH60N8q1Br84rBwAyaFUc=
X-Google-Smtp-Source: ABdhPJywJiJLxPgEfy+1yRwM62qXk507IrwBVJEVw29J1OZfufNOu1sCZxEmWcM63xkg35KjFX4uZA==
X-Received: by 2002:a63:a119:: with SMTP id b25mr60804244pgf.10.1594471369284;
        Sat, 11 Jul 2020 05:42:49 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 06/17] perf ftrace: show trace column header
Date:   Sat, 11 Jul 2020 20:40:24 +0800
Message-Id: <20200711124035.6513-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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


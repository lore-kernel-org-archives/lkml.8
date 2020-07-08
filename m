Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F084C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56582206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9adpdB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgGHQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgGHQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D81C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so1465246pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s45sz+Z8KdGsC2ioG3kBV+tM8Qtg7G2jwvxo8x0+od0=;
        b=g9adpdB2KUE0/2J/XBeus8WExt+IJ3lERYY9+yyJm7DSo5z0n6sj/hSJRQRC2oE4DT
         YfjeUeUmmycRmXbM/SXsMJ++n7eEV3vrxds3rChIVw3Xb50vINZWwI6SzrHLG/Mw9J+M
         FNhVRTKEN8UWuSExoM7HDqDxwCLiIYR6HHcCekKamvpOGcHWpy5YKvMzDIdguH6koD2X
         fR0KXLOOrJ/+E02GKoA2FjV28OZpbDLDEmJvT49/OSFHtQm3hlISqZgYw1J0AQ3oZ7Qu
         2O3PZajRDR2kHhjT2hMtLlVSdjXSBmK6/9UhyxW85XFaqTn/vazbhbRaJrJDx6K71pCt
         IaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s45sz+Z8KdGsC2ioG3kBV+tM8Qtg7G2jwvxo8x0+od0=;
        b=dpMuFrk0bUTzNPwsvezJhq4NUl7fDlVHE+7ZuQnp+uGpZrQPBZrmxEaGa/bBbx3sLO
         +6VrnRp04ANxf19/InHMizWQG23kdHh287rQdAOcvI6PvHaiwq6WRoBcxzl3XOd4Kjvw
         48nrkbwQTthN+YjmuLbAVulIKGG3XtZD6/8DP1ujGgnRPkkRR5kLrbNRnhMMXYzaeJY+
         QHnsUqUo4z/Wifpbgco2D8rfDxK6Dj+PV6mF1d08GkZe5469NJzVcVVzwTGTJi7X1t0b
         3qiAivQ70RtsCA/u5A0IoGAfBoQqUA/hXwu57hkEYXBPZx5L68Zg4y8O21ZHYsk6CaH9
         jR9A==
X-Gm-Message-State: AOAM530n02R/7noA5ej6ZRQtz4sIQWLdI1LxwUKIoDdmD4yNDBqRTjUQ
        kHOg9JTuTxVe+MFjaQevRIM=
X-Google-Smtp-Source: ABdhPJxYTYe9KyFfJwqKVbhCJEHYcUVJlgxXsE33QimYCptIWlOfaoAgjNJT+HL7O3C/zzQCHyQZjA==
X-Received: by 2002:a17:90a:b901:: with SMTP id p1mr9665049pjr.134.1594226856858;
        Wed, 08 Jul 2020 09:47:36 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 07/17] perf ftrace: show trace column header
Date:   Thu,  9 Jul 2020 00:45:55 +0800
Message-Id: <20200708164605.31245-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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
index 66cdfe42b1fe..885d11f369fc 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -431,6 +431,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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


Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A93C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1C12076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkuC3ptE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgGRGtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CE8C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so7728165pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eijOJmGeXbqqTxPaJjxhGuk/GGaaVtUD+GTIed+9zZI=;
        b=EkuC3ptERxKbAd2Rl8ZdjVpiGC4PUS12jAoIEb3Snnz1kHWlFhjHdd39wl3UrlH6GT
         uyId52LCas/2k/rZnC4cms+X2H3YAiXXPfVV7ssruQubxFOiAxF59srSsDzUhCWM3yIP
         oF3UKBDKb7bKWJyidPgKY6c8Ju8PSp0vYmYDlUD0LCLbSZytmZvWBUGn8DPtv7b0/VVf
         Ix3YTsVC+zr+xcy4aD4AsIIkg/hCb05q9VxXVCc13agl+ZQlC6WGK26eorcB0WPkk2Ex
         orjHy+AjRVvrsidqqklU/CIgyXgzeArDfvJhfw9hs6KuOvHxo16gRC9hldI5ugN93yVA
         s6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eijOJmGeXbqqTxPaJjxhGuk/GGaaVtUD+GTIed+9zZI=;
        b=P/XtP87YQSkJULEuo3V+y8ys3mIubu2Gg2B1eZYEDJJmeYC4hlqqx187tUZCfiYeh7
         xRrfjEGJHfSUFO0TL7v/n88vabChW9nXb3vWjSmy2TOnerZgZvx8nqWcDQg8tX/sN/4V
         MbQt+3m2KMiN2MHAwd/E86TnjFsCVoJUP1fBECSx3wV0jvpZNwsFbt4kdhJ1JPoYnfC0
         ZadMDMqPZKR4x5L1Qh578NDTQhU+YRRD7ete/qpiY2WkQhc0LSw4l4vOEKIqjbxAEjK/
         fQ1KDb15fceLwqC++JrosqCa5GtBkBxjAgKsJ6lwklwKyZpVPCnlsPtt1GgcozypFKB7
         9VIQ==
X-Gm-Message-State: AOAM5337ZakrcFmoGYqqEtMw2cw4sQz8jEbSrfAdrT71d5XeEZbyKDND
        yOt3kDoiLRgUCCdjAg/XLcc=
X-Google-Smtp-Source: ABdhPJzLpZRTHTWBu/+X4mlqVnNZ4Ubh1oYFmBxxM7piBKgSdansWzmEKs951c/FtDQQt0H+GOHCTw==
X-Received: by 2002:a63:5220:: with SMTP id g32mr11180373pgb.78.1595054955776;
        Fri, 17 Jul 2020 23:49:15 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 05/18] perf ftrace: show trace column header
Date:   Sat, 18 Jul 2020 14:48:13 +0800
Message-Id: <20200718064826.9865-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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


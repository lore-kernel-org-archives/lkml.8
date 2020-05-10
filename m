Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2B2C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A9920735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb8f1kDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgEJPKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:10:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F0FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so3502547pfv.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mz7kzAVMLVz/EHdToDqGn101jLvr6T6IM36BMJ7mrM4=;
        b=Zb8f1kDKF7bcBAUYAk+PVAKw97EUwmqnLbmZdNFAWKjkugw/IA8u7A9E8IVBteIuGa
         iplbkUNDyYvQfeMqH1eNrd9cgM7LRw0cZu+PGQRifc2V0bM9kGjH5JQk+hEMNkHqJPIP
         0z0p9JEr9MCE1tSxi7+MFWmQ/4O14uMlr9Bv/iwlnRwkLLEd0YAR1aR2VlZWOlUHfmCB
         V/jXtDUxmC3R9mK/8uZT6nL5jOkMIFqMR2kd8e/p+z1l4BfddNFja/FHdWbKu2IBuwgR
         Jarbdx+2pl2K8K9JJFcf1fKi7/blicFXML06QwgEg7/B6g4+dxZtAkrXtBrTXZnolVNI
         k2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mz7kzAVMLVz/EHdToDqGn101jLvr6T6IM36BMJ7mrM4=;
        b=ZvHoHaT7fHB0rPkRa43uP57ckM0P75P11PCyaD6LzuquF69fsIcbFzmSnPNxl3dxOr
         id37VfkCLOdtmzE3SDNf8XQ16hJ3gidmbQ76SARTNVfqPUbXEZLa8l0wUfr46rvvi5rL
         g4vJzb2GeamjaFYGvQ6qLALgrhQWjWX4VirOs0UiL8het+HhnRxI3c8oFRmC0PIP8yDp
         FgCMaGtgy+c5DomrtuLOoqV6ZhPNdjgaukdDSOnbZ9bunFu5vhBc5fpLWPwpze0rNpCZ
         dEC4HUKK1Vk/Sx2obLjcpRkGscEaQiyfgh3Mzadt6XcVHYe7dYSC5e+wN7nl5FNIoqOP
         u60A==
X-Gm-Message-State: AGi0PuabgLEWFzPDB8XSXT8xYwy8kWjI7KavYghs+McomZDUE3cy1KS5
        D83dYljqgmvGV+pxRl0S008=
X-Google-Smtp-Source: APiQypI58RWUhFP3hzRKBoDysow/d1xpaaHkks8kSRRAdXeDphD9+AqreICyEuef1eI1VOpwe0oRbQ==
X-Received: by 2002:a65:5641:: with SMTP id m1mr10371834pgs.18.1589123403495;
        Sun, 10 May 2020 08:10:03 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:10:02 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 15/19] perf ftrace: show trace column header
Date:   Sun, 10 May 2020 23:06:24 +0800
Message-Id: <20200510150628.16610-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
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
index 64c22f367ba2..0b39b6a88026 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -614,6 +614,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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


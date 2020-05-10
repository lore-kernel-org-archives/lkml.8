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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C93C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8A420820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSpyO5pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgEJPK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgEJPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:10:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E8C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so3488654pfw.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=el9+HL0NG4w6riBCeyPr28XbBHtaw2gamEGL+qRM05k=;
        b=WSpyO5pHDsRNNmX5tzrIydLzDkxvqQX+GB9PKXyL1gQYIFiCedFjSogxont5VmD+HF
         MDjyNMNJ7yDThIGteQMMpNXT0BYeStXp6k3yeHDHUK8VlzvAmOhObqr3+i8vcE2/BjSG
         U+RXqln6wdUM8Y1EJ2QLTjRxVnaLuip0g+mk5MSDA43r/Iw5/IHLiDF4hl0s0tABAV0A
         DeHmjRGqkLNQdvE9nD+5VkLGygzD1KNuCvIZh4NlA4N2WVjwKR7h1oB1DvIl1CfPtzR1
         bzOk+yF8zvv86PpmT9uZV/ZSRDbnsFvd4om/VJYAmJmll637Abzj2qGLUS34qKYvw6d6
         a3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=el9+HL0NG4w6riBCeyPr28XbBHtaw2gamEGL+qRM05k=;
        b=i+T66fUQvk0SWP/Z39qnAXb/706VMvV1VDd94YBRloT0K3+4gjKjrcG5orQz0/oOTG
         lzCRe0sUWK7EGj3NDqRPl3jBvLgzQwSf6ZWq9jSi3eGVDx5qqvwTl+Cq9hHbwjvkAIJL
         cFOnqwB6u2GOZEiecOvaZjnzJM2FPtqjINriDFLX36BzBs6ou8i36y+lkOdXGUy5t7p6
         /fFWLqc7dSHsGrHiP3HfCCJApUutMvkVa+quimf2iy1olNNBtmCIrBKYb/+fyAaIM8ib
         RSutCyGWUGV/+ULqb8Tz9jeiY66CoFyzC/eMhw3V5xMoVOi8E82hutHmKatqZC9RcyEp
         UoIA==
X-Gm-Message-State: AOAM530AKYdckZ6RbVuOGscQA5SLSiZ2TiskEnulg3uGZ4fuqjqK0OTu
        KM8ScaEwp229CkQ2uaxZ/4g=
X-Google-Smtp-Source: ABdhPJy7CJKmjOISia4X3fNPkvnESMEvIHDSc+ppeBRXvJ0IKuBjW5BxNxq/80tzCv6cmoUdKdLjmA==
X-Received: by 2002:a63:712:: with SMTP id 18mr513609pgh.96.1589123426630;
        Sun, 10 May 2020 08:10:26 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:10:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 17/19] perf ftrace: add option -d/--delay to delay tracing
Date:   Sun, 10 May 2020 23:06:26 +0800
Message-Id: <20200510150628.16610-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-d/--delay' to allow us to start tracing some
times later after workload is launched.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8d04e5afe2d3..d376b37c53fc 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -49,6 +49,7 @@ struct perf_ftrace {
 	bool			trace_children;
 	unsigned		buffer_size_kb;
 	bool			no_pager;
+	unsigned		initial_delay;
 };
 
 struct filter_entry {
@@ -617,13 +618,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	/* display column headers */
 	read_tracing_file_to_stdout("trace");
 
-	if (write_tracing_file("tracing_on", "1") < 0) {
-		pr_err("can't enable tracing\n");
-		goto out_close_fd;
+	if (!ftrace->initial_delay) {
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
 	}
 
 	perf_evlist__start_workload(ftrace->evlist);
 
+	if (ftrace->initial_delay) {
+		usleep(ftrace->initial_delay * 1000);
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
+	}
+
 	while (!done) {
 		if (poll(&pollfd, 1, -1) < 0)
 			break;
@@ -747,6 +758,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "size of per cpu buffer in kb"),
 	OPT_BOOLEAN('P', "no-pager", &ftrace.no_pager,
 		    "Do not use pager"),
+	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
+		     "Wait <n> ms before tracing"),
 	OPT_END()
 	};
 
-- 
2.25.1


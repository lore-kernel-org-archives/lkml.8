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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A859CC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831902076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSmi6L4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGKMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0CC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so3351561plm.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ul89J2LxR5qyab2DeLgx+D64gpkzNDa9NrxPE9OXSOk=;
        b=uSmi6L4qVoPIGFZH8aRGSgD4tA04A8+M1duaVeJv+oLwov0Acwt/zG16Ld8laGItrM
         2hZ88ztNQfCQ6qwzqU0T7ZlcLVEa/MqikrgMNkU6zQuSaxVB/WbOkl5D9ElqVwoQUYyk
         rJD8xezZrSJNdZuQ9bKDQg9HQXp7wUZWfnBOTj07/JGCLAH3rJ/81xVlAWjBvPzzxcEB
         J+oPVt4SFVY/zFRj9UqL1U1g/zYYpltM1OLdQFRZ4G990ste4l9ec7M+COIYnx0Rnpbf
         hgMDOrSXgJgMFUwPlRgA4rHoM1Za7e6TCmPCo1c5z/Yu0mgDogNelBomLfN51e4yOxdj
         wcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ul89J2LxR5qyab2DeLgx+D64gpkzNDa9NrxPE9OXSOk=;
        b=YIO840Q0zLWqb4uUrRxXQDuqMvbYJAWzO0X+SzVYju9jHHYmgDCVHs2yWNwyDFz2Mt
         cmQswmQUaJ2olddv2XiQAmEGJ1LPS4L0zXL2SmiJmfcpZw80k2Oz/lRWZhkJEHclYJQi
         GGDE2z5xaT9JnMHN2rPQmjbQfyI4XH/Vcef9sNMhngoMmfUlApJIj+gV00cVynZzEKlm
         PyXywhmrJl5LRDaX0AZnSEuOqqOAU9jskFQDljV3PEOQIvCuRPwQK5lcpUdrVXmPqWrU
         VIq47JSLPZfjqoEI7JOZyzdI4ymlRzZ4lkwuYEKwnX6s1CayQgzjap1ozn3PXvi9CkQ7
         SvQA==
X-Gm-Message-State: AOAM5315/4b2fgnY8DkBBZ3DLIoz3uh+uMvZKMRr1r55+7d7sqd7k6AC
        W60QKxRuL2PZExV+dAzZoxc=
X-Google-Smtp-Source: ABdhPJwkECfOTOpd/MlDBI53ujustNgenaumjn4fojRYSfXXFcZNEsIwHsMY0OQvvNdNhrDcSMe7cA==
X-Received: by 2002:a17:90a:c212:: with SMTP id e18mr10715896pjt.118.1594471357566;
        Sat, 11 Jul 2020 05:42:37 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 04/17] perf ftrace: factor out function write_tracing_file_int()
Date:   Sat, 11 Jul 2020 20:40:22 +0800
Message-Id: <20200711124035.6513-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will reuse this function later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 1188b82c6541..342861a1d152 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -165,6 +165,17 @@ static int read_tracing_file_to_stdout(const char *name)
 	return ret;
 }
 
+static int write_tracing_file_int(const char *name, int value)
+{
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%d", value);
+	if (write_tracing_file(name, buf) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -295,8 +306,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -305,9 +314,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
-
-	if (write_tracing_file("max_graph_depth", buf) < 0)
+	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
 		return -1;
 
 	return 0;
-- 
2.25.1


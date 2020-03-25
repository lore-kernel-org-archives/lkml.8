Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD69C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B3B20775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140374;
	bh=ojEGSTps5DL8p2abqfC0e82TDIokwFBtPVkUb3gFUy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FgTM+8hqSsFMI9tj3okj3BR8Qbv1ZsZaa/IgQJbI00gwNSyaBHhJyNnoMHrMvxRWe
	 bRkAAeyQk0Bc7Yh/B0lR3XmziRU366j2l3mfyLFXnlwYMWuCjElJu8jvzLFWMwSft1
	 QVZev7iRxPu2js83DH1IcjxzXfk7N+gSj0OOsZ3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCYMqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:46:13 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40931 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgCYMqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:46:11 -0400
Received: by mail-pj1-f67.google.com with SMTP id kx8so963395pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5Iu6nJ5CQZKpysji5s+hCMPqmliWrBW+yecX82EVWk=;
        b=CVObSsoLUU7Tt3+5xib/sxOo2uAOGlnZsncDV+/5Z3RNlG4hrDuZzulWMdh8QrWsWu
         3Yzfe8l71e+6EpIMWlGwNsy1jZsWjbJ1fCnjfX7y/avYjLpsOpJldyaPS7Y6PajS0hRa
         Ko40DLJO3Q6R7LwVso3lVkXsiYALQNFuX9R7zt1mlP1XCz90vEAfnRkw5PKje1Czv/bM
         6H2U+//xPR7g9mkGdAOYfGGZ3f1zClt2aH+mHq56JJok3uvCIk/OvJBoChgKW8dsbtz0
         VAGqOc6exTddEYkWuaBj4U9+P/DDXi7T11feFyjvUFOgLpelIJr83LLLZPtWx2jEkiS0
         Zu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=h5Iu6nJ5CQZKpysji5s+hCMPqmliWrBW+yecX82EVWk=;
        b=RV4saeiDPH/OU33siYxPU6EJErHS6OFPJZvNUZnPTl7uPzUtfJX+t49O2Y7w3rPlGJ
         14c113J65rCsW4OMujFrdw427Z10lP0QM5b85T7Cknolwx73lIPL5F5ql912mUJBK1ho
         6CGUeh7a09Xvnt9rpa93QQT0mHXbILk1Ol/c2Wv9H4lIR8mxKndQRV4xMiNsuvuYHLWS
         gUH/j6Pp40o7Q207M83IprM01SPs13wDjtxRluouwugssAT/i3orT1ViApw9Lq+QNUoh
         3phe28aMakr+Oo6zYZzT/KYZVZUjvmwlMpwbzkn58ekLlyvaNwrbtQsHfd+1WElzn0li
         j4bQ==
X-Gm-Message-State: ANhLgQ16BIkJ2En+SPnCdB8Sr92f/SAzQq4CFGPTbm+1BJGn73a1SKe+
        NY+cjOUI+fob9OlAOEb8Bkc=
X-Google-Smtp-Source: ADFU+vtka6ZaUYF/zjZsHDmZWznZMPgHs0SpbUIbLUGMFRkiqDHHXLKa5Po2tbQGwew0hWNA0Q7Otg==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr3502361pjo.170.1585140370437;
        Wed, 25 Mar 2020 05:46:10 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:46:09 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 8/9] perf top: Add --all-cgroups option
Date:   Wed, 25 Mar 2020 21:45:35 +0900
Message-Id: <20200325124536.2800725-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 324b6b53c86b..ddab103af8c7 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -272,6 +272,10 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+--all-cgroups::
+	Record events of type PERF_RECORD_CGROUP and display it with the
+	'cgroup' sort key.
+
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d2539b793f9d..56b2dd0db88e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1246,6 +1246,8 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
+	if (opts->record_cgroup)
+		top->tool.cgroup_events = true;
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
@@ -1253,6 +1255,11 @@ static int __cmd_top(struct perf_top *top)
 	if (ret < 0)
 		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
 
+	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
+					     &top->session->machines.host);
+	if (ret < 0)
+		pr_debug("Couldn't synthesize cgroup events.\n");
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->core.threads, false,
 				    top->nr_threads_synthesize);
@@ -1545,6 +1552,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
+		    "Record cgroup events"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.25.1.696.g5e7596f4ac-goog


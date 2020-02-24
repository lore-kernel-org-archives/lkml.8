Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A099C35641
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1112082E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519114;
	bh=/4hTwOR6PVxRLDcHGtCoGVSHbadMK9CAu0edZbN9Uj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dI9lA+tI3baC4lDTyFuHF9qvR9pnPLoVM5kK03BIGe4/7teCI3RLHoZQ1K8T2Xtk/
	 6pEa/D74ElSiMxFfCKwzm7wRP3bArfowsEfaxzkNI/clFNPPuAljTEMjoyYwzPE3N5
	 G3M/AFuSalhurD/qXr200ltA9ztDuKedqdxT4X/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgBXEid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:33 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39800 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgBXEia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:30 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so3600664pjr.4;
        Sun, 23 Feb 2020 20:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pl+sZ0gTzuvSf4XD6xUQQFoYRLbymOcvbzGkCg0V+PY=;
        b=GBkP5mY1WAFq5/uiwugJnlWG/dNX1Ry3p5j00FYIfNcgDaMDkan7SrZANC46U58bI9
         fxaO+5BkRY9p/ZkmmNpZ+riK1r8t32UPL+bDkBCoxqJxmIX3PSwBivkBFHYtaTW0qHHx
         KtYN3BFKYDr05HuhLVSMbSaHd75nsWDfZCWwV+qoBCXJp9kW69SfgIBOoyZPiSn8KJvj
         bUusic2juZZjN4clC89HHSpE735WF8v5tGwSQQdU5C9l2r44qS5iMD3tIA8IuGODY7Cx
         ZSNIb/zPZDscyL+23wnqTF32tIBRAP2iGTLdNu7l3pUV3R5CgNF4nAWgiyvybF2pAzmJ
         +dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pl+sZ0gTzuvSf4XD6xUQQFoYRLbymOcvbzGkCg0V+PY=;
        b=Lu3P/YE4Tm+u/LRfqzfMJRFHHxTY4fJafRCNyO9Q2td8OF8rg3zN5Mzsr50/sHGd3t
         V2K3lJT/WK33VwIwHZ5cPZfA1C1XjlLpK2uGdSyQj53TvxKeV51R1Zvugupsa46EYUwQ
         Jc6Kn0eAUXFsiWNCuW5RBrBgcPAascOBYi5lvL+x0AUJoyF//2hpLubMTVVk9CeUBbyS
         ETS6lVoiqpRnsX5MXDI3bG4WF6Be3tyxa7SJ6iS39MVPYKefpfuQhK4/xx3DhE+DkcvC
         R54ov2cktu8iFMnJV7CfS5RYJ3h666Bgvgq+wdOok1JFuvmlXiq4X0ZE+Up3yZdB+ElS
         QE3Q==
X-Gm-Message-State: APjAAAWI7Ufote5+twvi0BMomuCfqEAnboJRpFCC8p5ONUOAbxhVAVGi
        6VjIYrpH5eDi8RcSXMeU55GJjyYx
X-Google-Smtp-Source: APXvYqxxRbp0AQYSleKEDxXXxSRZIVT7klrRrn3aWi3tmIP55VDorhr9knl96biHhdxd0Z4Ap4XOfw==
X-Received: by 2002:a17:90a:191:: with SMTP id 17mr18271583pjc.88.1582519109539;
        Sun, 23 Feb 2020 20:38:29 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:29 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 09/10] perf top: Add --all-cgroups option
Date:   Mon, 24 Feb 2020 13:37:48 +0900
Message-Id: <20200224043749.69466-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
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
index 8affcab75604..5666212b2f0c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1244,6 +1244,8 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
+	if (opts->record_cgroup)
+		top->tool.cgroup_events = true;
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
@@ -1251,6 +1253,11 @@ static int __cmd_top(struct perf_top *top)
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
@@ -1543,6 +1550,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
+		    "Record cgroup events"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.25.0.265.gbab2e86ba0-goog


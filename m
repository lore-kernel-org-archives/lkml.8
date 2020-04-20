Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA06C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB052071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383756;
	bh=VZN1h7cjWd3DPg/tcndQSyK/rsbx7rzEzxBfHfiUW/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cAQAJDE+BSvY8GVSUvno5obFsawKNf9v77gLlfIlG7tR9IqYk6w9Rx6yYXcLLu4UV
	 sdGqGsn4W+xmYsXzqLaH7tygrEVV3yOda7/JAKIxQLXal/xVynLcgrPLEiPrHUROdr
	 fqWtsmMOSRym5FS2vZr+Kl01C+cyKq64QCq6lE6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgDTLzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgDTLzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E5E2072B;
        Mon, 20 Apr 2020 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383750;
        bh=VZN1h7cjWd3DPg/tcndQSyK/rsbx7rzEzxBfHfiUW/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2UXOjf6VNONVbXOgVWYYIhkpFxPfN5PiD8QJNS34jo2ix3QQvuGewdtpKNprMtCD
         F7RgLlZUkRivVVGWlsa6idLIQeBlDZMiC2y+QNzXzGXWBcC7//O3HCLOu2u6J3HH3x
         u3pvgLQuzG69I8RojPIMgpZZ3DSX2Eo3L8snKj18=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/60] perf s390-cpumsf: Implement ->evsel_is_auxtrace() callback
Date:   Mon, 20 Apr 2020 08:52:46 -0300
Message-Id: <20200420115316.18781-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/s390-cpumcf-kernel.h | 1 +
 tools/perf/util/s390-cpumsf.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
index d4356030b504..f55ca07f3ca1 100644
--- a/tools/perf/util/s390-cpumcf-kernel.h
+++ b/tools/perf/util/s390-cpumcf-kernel.h
@@ -11,6 +11,7 @@
 
 #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
 #define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
+#define PERF_EVENT_CPUM_SF_DIAG	0xBD000 /* Event: Combined-sampling */
 
 struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
 	unsigned int def:16;	/* 0-15  Data Entry Format */
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6785cd87aa4d..d7779e48652f 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1047,6 +1047,14 @@ static void s390_cpumsf_free(struct perf_session *session)
 	free(sf);
 }
 
+static bool
+s390_cpumsf_evsel_is_auxtrace(struct perf_session *session __maybe_unused,
+			      struct evsel *evsel)
+{
+	return evsel->core.attr.type == PERF_TYPE_RAW &&
+	       evsel->core.attr.config == PERF_EVENT_CPUM_SF_DIAG;
+}
+
 static int s390_cpumsf_get_type(const char *cpuid)
 {
 	int ret, family = 0;
@@ -1142,6 +1150,7 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->auxtrace.flush_events = s390_cpumsf_flush;
 	sf->auxtrace.free_events = s390_cpumsf_free_events;
 	sf->auxtrace.free = s390_cpumsf_free;
+	sf->auxtrace.evsel_is_auxtrace = s390_cpumsf_evsel_is_auxtrace;
 	session->auxtrace = &sf->auxtrace;
 
 	if (dump_trace)
-- 
2.21.1


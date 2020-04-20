Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00847C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A5B206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383766;
	bh=vdvOi+Ce8V9fnCpjaDr9goTOMSib+LLdvRLkg3LvhZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WL4hK/HVxX7zXbH+2jJus1BZB6IF+eM2+o7RRxARAI3hj+a+8oTwghzhRMCK2wMqa
	 tGTTVP7GKy77bUkQmMWaGYNmTM19Y7g8Y0wzbj/F+CCzQ7ox9eEZ+v5ES3YKbWZc0r
	 6RgCCM87D2gDiR2w1ajBKuSUBRWJVvvSB0LB6NBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTL4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgDTL4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A7D22247;
        Mon, 20 Apr 2020 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383763;
        bh=vdvOi+Ce8V9fnCpjaDr9goTOMSib+LLdvRLkg3LvhZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Npmsm1Xj0v3vEIheBAaP3x46M5xLasQ0NDy4t2X7fuhX5nGLzCq8AiEmPaZgnytHF
         mBlUlBU4AOlu1jGWSC6jawhbJahaCld75wLdII0shTUatXZYvqCvhJkDWjGp5OW/aB
         ejWPN5ed56AlyvwRvsaGSNKkeH4ZcwzdsmqNH9eA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/60] perf evsel: Be consistent when looking which evsel PERF_SAMPLE_ bits are set
Date:   Mon, 20 Apr 2020 08:52:50 -0300
Message-Id: <20200420115316.18781-35-acme@kernel.org>
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

Using 'type' variable for checking for callchains is equivalent to using
evsel__has_callchain(evsel) and is how the other PERF_SAMPLE_ bits are checked
in this function, so use it to be consistent.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-11-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d23db6755f51..f320adaf1326 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2136,7 +2136,7 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		}
 	}
 
-	if (evsel__has_callchain(evsel)) {
+	if (type & PERF_SAMPLE_CALLCHAIN) {
 		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
 
 		OVERFLOW_CHECK_u64(array);
-- 
2.21.1


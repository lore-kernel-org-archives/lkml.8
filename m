Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10AFC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F76E2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383784;
	bh=eiAl2pjjoyUtBygw6AuZT0Dgf62I08L7fbKscZa5gbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pzl0uZAwsmb8fu+GAzEMu3W8C2zfghS86ec/LARSE72mlgP1Wv68nwkBhYYZINHee
	 s9bl9bRBoTHY0DWGp3P9bttg2frgHny/I/1zBTnP5zOYmBkCU75VOwgSC0MBlpZ8OX
	 ouOq/qrXqcqYjyXsH56RFO1mdsPflYkg/IVKgqo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgDTL4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgDTL4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC3221744;
        Mon, 20 Apr 2020 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383778;
        bh=eiAl2pjjoyUtBygw6AuZT0Dgf62I08L7fbKscZa5gbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsLXSaXigowmq8O/rcBEyMfmq7TjDRAumppHWnRx+8dgsFzrh8MAB8CNsPQsNmGwL
         zF2O3fzyDRe5zRSuSpHtWO3HpDx5L/pf+GbvUHWZu0AxTCqb0P+JRUdI6qjqsZdMb1
         SfTqlunix9bpmvKTGjxkwiUDHIkqc8NpDbLvTpMs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/60] perf evsel: Rearrange perf_evsel__config_leader_sampling()
Date:   Mon, 20 Apr 2020 08:52:55 -0300
Message-Id: <20200420115316.18781-40-acme@kernel.org>
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

In preparation for adding support for leader sampling with AUX area events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/record.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8870ae451cac..32aeeb8a8d00 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -172,24 +172,24 @@ static void perf_evsel__config_leader_sampling(struct evsel *evsel)
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
 
+	if (leader == evsel || !leader->sample_read)
+		return;
+
 	/*
 	 * Disable sampling for all group members other
 	 * than leader in case leader 'leads' the sampling.
 	 */
-	if (leader != evsel && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
+	attr->freq           = 0;
+	attr->sample_freq    = 0;
+	attr->sample_period  = 0;
+	attr->write_backward = 0;
 
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
+	/*
+	 * We don't get a sample for slave events, we make them when delivering
+	 * the group leader sample. Set the slave event to follow the master
+	 * sample_type to ease up reporting.
+	 */
+	attr->sample_type = leader->core.attr.sample_type;
 }
 
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
-- 
2.21.1


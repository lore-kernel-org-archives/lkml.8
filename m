Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F78C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4212F2145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778688;
	bh=X+JaR+67nC3+mnTx0sfbVQoLMgA+y3FKW53P616HF80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLvsuwrmXHA3YurXlGvPJrOufPpE1ho5e0UinDtuZaS/bYXjBoARLaT/JeNvTHG7s
	 ikCKV+Y9vfMvISO2/i5F+vt3hQ0L81DLg9LvVTbEJk71dfZHV+QsgFn7hUdQI2gr+m
	 3dTwAq1VN0xCGd2f5gtuSEcsL4n2USCCbCr2IRik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgEFPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729904AbgEFPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDE521582;
        Wed,  6 May 2020 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778682;
        bh=X+JaR+67nC3+mnTx0sfbVQoLMgA+y3FKW53P616HF80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLDfyaB5NwPD/34OGltD06sfumQbv7M4a7Z8Rt1oz/1OT91MLvgTkALwEQRG58HPt
         JW2ClT5fxF6lHxV4goPL73WlXBShPrXnJ0yWqOZTCvDbmz8iIqeew6npvtMX+asezs
         C4k4H24DrmYyl3CB1Hrb6NeQaLKHZbLkgCq6ToCA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>, Andi Kleen <ak@linux.intel.com>,
        Kyle Meyer <meyerk@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/91] libperf: Add NULL pointer check for cpu_map iteration and NULL assignment for all_cpus.
Date:   Wed,  6 May 2020 12:21:35 -0300
Message-Id: <20200506152234.21977-33-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

A NULL pointer may be passed to perf_cpu_map__cpu and then cause a
crash, such as the one commit cb71f7d43ece ("libperf: Setup initial
evlist::all_cpus value") fix.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kyle Meyer <meyerk@hpe.com>
Link: http://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c | 2 +-
 tools/lib/perf/evlist.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index f93f4e703e4c..ca0215047c32 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 
 int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
-	if (idx < cpus->nr)
+	if (cpus && idx < cpus->nr)
 		return cpus->map[idx];
 
 	return -1;
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index def55054c55b..c481b62f2ce4 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -125,6 +125,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
 	perf_cpu_map__put(evlist->cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
+	evlist->all_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
-- 
2.21.1


Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2789E207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140143;
	bh=g7eVtEd+KoADbNniw89ix5kVCRUXNvkc4GpkQkSSYSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Gzri5ScIsTfPbGG5qZmibX39cwqOY+Y2PTY0ZSBHXTw8DSjW7W3wIv80NHhsLsR7
	 nX9658fl81HOmJRqRSyO0e3uTDqhxhZApiE9xuqES0NMR6ID1/3SsSaMKjD2k6WdR6
	 zZ/FO6STwdjn2hVe8Ajk6SWySNBjYyrFbYjKIpoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCYMmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F1C2078A;
        Wed, 25 Mar 2020 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140138;
        bh=g7eVtEd+KoADbNniw89ix5kVCRUXNvkc4GpkQkSSYSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNZVjDahu6k6Jlnl2GPiUsq9p082vbz17zlICTrOznJMB0dvEERCgEQamfsv0DH3D
         DNlPYT0tCBe13SRvAmSbGejK6/hexIv+jMSguEmDf6uI58zgZ8bRp0iyuPfu1kHRCQ
         LTQlbkfA4pM1svtR66kAOQaEZyPSKnV7/G3Hx4Yc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Vijay Thakkar <vijaythakkar@me.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Jon Grimm <jon.grimm@amd.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/24] perf vendor events amd: Restrict model detection for zen1 based processors
Date:   Wed, 25 Mar 2020 09:41:11 -0300
Message-Id: <20200325124124.32648-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Thakkar <vijaythakkar@me.com>

This patch changes the previous blanket detection of AMD Family 17h
processors to be more specific to Zen1 core based products only by
replacing model detection regex pattern [[:xdigit:]]+ with
([12][0-9A-F]|[0-9A-F]), restricting to models 0 though 2f only.

This change is required to allow for the addition of separate PMU events
for Zen2 core based models in the following patches as those belong to
family 17h but have different PMCs. Current PMU events directory has
also been renamed to "amdzen1" from "amdfam17h" to reflect this
specificity.

Note that although this change does not break PMU counters for existing
zen1 based systems, it does disable the current set of counters for zen2
based systems. Counters for zen2 have been added in the following
patches in this patchset.

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200318190002.307290-2-vijaythakkar@me.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json  | 0
 tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json | 0
 .../arch/x86/{amdfam17h => amdzen1}/floating-point.json         | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json | 0
 .../perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json  | 0
 tools/perf/pmu-events/arch/x86/mapfile.csv                      | 2 +-
 7 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)

diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/branch.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/cache.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/core.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/core.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/memory.json
diff --git a/tools/perf/pmu-events/arch/x86/amdfam17h/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/x86/amdfam17h/other.json
rename to tools/perf/pmu-events/arch/x86/amdzen1/other.json
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 745ced083844..82a9db00125e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
-- 
2.21.1


Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE1C3B1BE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6DC24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707483;
	bh=YYMpruM1vUxms1ibDJf3sYiMASCEkWetY5/BhRRDAZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JSFEH56hnj771oZYBPx0XrDINpBxwDubjCBxStSk+c544js4MfumfCN0zUMg5diRO
	 DtGYiJqKl6qrl4FLFRb0RRQ4kDyGciOMeS3RrLBD98Sf7PZamF269Cd4493097mhFL
	 1THQnHATQLn56mfVuaFjdVdJcsSur+GLbAhKwnjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbgBNTLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgBNTLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:22 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E01624650;
        Fri, 14 Feb 2020 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707481;
        bh=YYMpruM1vUxms1ibDJf3sYiMASCEkWetY5/BhRRDAZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKPHkxoh8pUt+fwaJl1z1eN5Rw45gSi5dH2nWswBZURR0xzq011m3R1eny2h30tfw
         EXpcSvfAt3zcy/O8S9ifgiAuopQG7bkQeuuQmZ6STSjnVB/RviQqxZvxbBuW8zWG+F
         v8J58s8WQcuc7NCOiblQULLYjpssuFn3G244WoQ0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>, Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/23] perf symbols: Update the list of kernel idle symbols
Date:   Fri, 14 Feb 2020 16:10:36 -0300
Message-Id: <20200214191057.26266-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

The "acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and
"idle_cpu" symbols appear in 'perf top' output, at least on AMD systems.

Add them to perf's idle_symbols list, so they don't dominate 'perf top'
output.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200207230613.26709-2-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..f3120c4f47ad 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -635,9 +635,12 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"acpi_idle_do_entry",
+		"acpi_processor_ffh_cstate_enter",
 		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
+		"idle_cpu",
 		"intel_idle",
 		"default_idle",
 		"native_safe_halt",
-- 
2.21.1


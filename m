Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC8EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3CD22CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596145249;
	bh=7c72ALfH3rZJ5RpShQTcy50xH2hkJI2xSDDhyL2ll6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=15jYAS09QoXibfhoQPV15GdMwR06N02NYl8kQ2zI69FfEbsrpFsN4+oPpey69KP5o
	 xkPQqIbf97HINA4fw1MIqYN8OHrhmxozBFwIpEWVqdYrig8c2oJnYe6TB6W/D+GvEI
	 Sgp1FLMnFhJezF9iA9geyKh/DQBLefuWTgvvxk5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgG3Vks convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:40:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26004 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgG3Vkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:40:46 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-LswUfCBpNOGMXMsVSvRwHA-1; Thu, 30 Jul 2020 17:40:42 -0400
X-MC-Unique: LswUfCBpNOGMXMsVSvRwHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 493B9102CC42;
        Thu, 30 Jul 2020 21:40:39 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 728C26EF80;
        Thu, 30 Jul 2020 21:40:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH 5/6] perf script: Change enum perf_output_field values to be 64 bits
Date:   Thu, 30 Jul 2020 23:39:49 +0200
Message-Id: <20200730213950.1503773-6-jolsa@kernel.org>
In-Reply-To: <20200730213950.1503773-1-jolsa@kernel.org>
References: <20200730213950.1503773-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's possible to add new values. I did not find any place
where the enum values are passed through some number type,
so it's safe to make this change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 64 ++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0dfc38fb6d35..eb45f678dc2f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -82,38 +82,38 @@ static bool			native_arch;
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
 enum perf_output_field {
-	PERF_OUTPUT_COMM            = 1U << 0,
-	PERF_OUTPUT_TID             = 1U << 1,
-	PERF_OUTPUT_PID             = 1U << 2,
-	PERF_OUTPUT_TIME            = 1U << 3,
-	PERF_OUTPUT_CPU             = 1U << 4,
-	PERF_OUTPUT_EVNAME          = 1U << 5,
-	PERF_OUTPUT_TRACE           = 1U << 6,
-	PERF_OUTPUT_IP              = 1U << 7,
-	PERF_OUTPUT_SYM             = 1U << 8,
-	PERF_OUTPUT_DSO             = 1U << 9,
-	PERF_OUTPUT_ADDR            = 1U << 10,
-	PERF_OUTPUT_SYMOFFSET       = 1U << 11,
-	PERF_OUTPUT_SRCLINE         = 1U << 12,
-	PERF_OUTPUT_PERIOD          = 1U << 13,
-	PERF_OUTPUT_IREGS	    = 1U << 14,
-	PERF_OUTPUT_BRSTACK	    = 1U << 15,
-	PERF_OUTPUT_BRSTACKSYM	    = 1U << 16,
-	PERF_OUTPUT_DATA_SRC	    = 1U << 17,
-	PERF_OUTPUT_WEIGHT	    = 1U << 18,
-	PERF_OUTPUT_BPF_OUTPUT	    = 1U << 19,
-	PERF_OUTPUT_CALLINDENT	    = 1U << 20,
-	PERF_OUTPUT_INSN	    = 1U << 21,
-	PERF_OUTPUT_INSNLEN	    = 1U << 22,
-	PERF_OUTPUT_BRSTACKINSN	    = 1U << 23,
-	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
-	PERF_OUTPUT_SYNTH           = 1U << 25,
-	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
-	PERF_OUTPUT_UREGS	    = 1U << 27,
-	PERF_OUTPUT_METRIC	    = 1U << 28,
-	PERF_OUTPUT_MISC            = 1U << 29,
-	PERF_OUTPUT_SRCCODE	    = 1U << 30,
-	PERF_OUTPUT_IPC             = 1U << 31,
+	PERF_OUTPUT_COMM            = 1ULL << 0,
+	PERF_OUTPUT_TID             = 1ULL << 1,
+	PERF_OUTPUT_PID             = 1ULL << 2,
+	PERF_OUTPUT_TIME            = 1ULL << 3,
+	PERF_OUTPUT_CPU             = 1ULL << 4,
+	PERF_OUTPUT_EVNAME          = 1ULL << 5,
+	PERF_OUTPUT_TRACE           = 1ULL << 6,
+	PERF_OUTPUT_IP              = 1ULL << 7,
+	PERF_OUTPUT_SYM             = 1ULL << 8,
+	PERF_OUTPUT_DSO             = 1ULL << 9,
+	PERF_OUTPUT_ADDR            = 1ULL << 10,
+	PERF_OUTPUT_SYMOFFSET       = 1ULL << 11,
+	PERF_OUTPUT_SRCLINE         = 1ULL << 12,
+	PERF_OUTPUT_PERIOD          = 1ULL << 13,
+	PERF_OUTPUT_IREGS	    = 1ULL << 14,
+	PERF_OUTPUT_BRSTACK	    = 1ULL << 15,
+	PERF_OUTPUT_BRSTACKSYM	    = 1ULL << 16,
+	PERF_OUTPUT_DATA_SRC	    = 1ULL << 17,
+	PERF_OUTPUT_WEIGHT	    = 1ULL << 18,
+	PERF_OUTPUT_BPF_OUTPUT	    = 1ULL << 19,
+	PERF_OUTPUT_CALLINDENT	    = 1ULL << 20,
+	PERF_OUTPUT_INSN	    = 1ULL << 21,
+	PERF_OUTPUT_INSNLEN	    = 1ULL << 22,
+	PERF_OUTPUT_BRSTACKINSN	    = 1ULL << 23,
+	PERF_OUTPUT_BRSTACKOFF	    = 1ULL << 24,
+	PERF_OUTPUT_SYNTH           = 1ULL << 25,
+	PERF_OUTPUT_PHYS_ADDR       = 1ULL << 26,
+	PERF_OUTPUT_UREGS	    = 1ULL << 27,
+	PERF_OUTPUT_METRIC	    = 1ULL << 28,
+	PERF_OUTPUT_MISC            = 1ULL << 29,
+	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
+	PERF_OUTPUT_IPC             = 1ULL << 31,
 };
 
 struct output_option {
-- 
2.25.4


Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0614C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB502067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596620325;
	bh=7c72ALfH3rZJ5RpShQTcy50xH2hkJI2xSDDhyL2ll6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Newlrzxh56gCktgDOZb6ZROScIKbwSLvCv4EfMv9FnVU8n5kRxwX2fnO+cjFZjROh
	 iMDMuDKFQQd5d/VSkcpA1FYTiN6908XWqyueAgCaCU9vbII25Fc9J+YvnWKbMjaAKs
	 tPx0D9scu4Sb6OwRTU2QgBIMjaBSXhlczcT/8iHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgHEJin convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:38:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37824 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728421AbgHEJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:35:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-j0G7u1y6P2OFppVwq_IFWg-1; Wed, 05 Aug 2020 05:35:19 -0400
X-MC-Unique: j0G7u1y6P2OFppVwq_IFWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAAB38015F3;
        Wed,  5 Aug 2020 09:35:17 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF5B37193A;
        Wed,  5 Aug 2020 09:35:10 +0000 (UTC)
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
Subject: [PATCH v2 6/7] perf script: Change enum perf_output_field values to be 64 bits
Date:   Wed,  5 Aug 2020 11:34:43 +0200
Message-Id: <20200805093444.314999-7-jolsa@kernel.org>
In-Reply-To: <20200805093444.314999-1-jolsa@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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


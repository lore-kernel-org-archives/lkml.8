Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB397C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C300624692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839024;
	bh=a+MJwKbeEW1/mWfc2kj2GaYVcvMfbKDFFFii9iqUW8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u03P0wsyUGMGdPDJQZK2ybOgrZVk/6GyACmwUbvBY914BYibABXh8Wkz2mKm296jC
	 XDPDyL9J6sIM0JzeeshD/rIH2ujcVXdfU80sHgUuqIj0m1DEx2xcZ3+KHMkCpLyrIX
	 noMN88khiLD9smShbc/KsVer7aJCNurq3k7mpTU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCJLRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgCJLRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:17:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A18D2469E;
        Tue, 10 Mar 2020 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839019;
        bh=a+MJwKbeEW1/mWfc2kj2GaYVcvMfbKDFFFii9iqUW8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xK8SfHnYv9qCB8xkfTM4IZb2iNBl8ZrYUGFKHzsCWPsTM4RhlOuxY32Oiw5yFMsfY
         zCIpqSrqLpIfHVnUMt/Ytwuf/gjDulYOYD/udrpd2goNsQNTjQoHTahsx7Lz1bmuDc
         Qy/Q/VfM3hoQ7F2YvpzFn8x1fMlAVRQHOpeLnzP8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/19] perf expr: Make expr__parse() return -1 on error
Date:   Tue, 10 Mar 2020 08:15:47 -0300
Message-Id: <20200310111551.25160-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To match the error value of the expr__find_other function, so all
exported expr functions return the same values:
0 on success, -1 on error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 4 ++--
 tools/perf/util/expr.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 755d73c86c68..28313e59d6f6 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -45,11 +45,11 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 
 	p = "FOO/0";
 	ret = expr__parse(&val, &ctx, p);
-	TEST_ASSERT_VAL("division by zero", ret == 1);
+	TEST_ASSERT_VAL("division by zero", ret == -1);
 
 	p = "BAR/";
 	ret = expr__parse(&val, &ctx, p);
-	TEST_ASSERT_VAL("missing operand", ret == 1);
+	TEST_ASSERT_VAL("missing operand", ret == -1);
 
 	TEST_ASSERT_VAL("find other",
 			expr__find_other("FOO + BAR + BAZ + BOZO", "FOO", &other, &num_other) == 0);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 45b25530db5b..fd192ddf93c1 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -54,7 +54,7 @@ __expr__parse(double *val, struct parse_ctx *ctx, const char *expr,
 
 int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr)
 {
-	return __expr__parse(final_val, ctx, expr, EXPR_PARSE);
+	return __expr__parse(final_val, ctx, expr, EXPR_PARSE) ? -1 : 0;
 }
 
 static bool
-- 
2.21.1


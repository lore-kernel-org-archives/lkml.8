Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48931C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6E02086A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582532988;
	bh=duIA/AazfLpdPhxKWFOpTmyq67PMMsILPnyxwsxGvLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yXcAkVqeFqflyJb2NG4xUDOzC4LPq3CnamgqoLFaJcDYa2jKqz2zxSv1Jr6sWVNJc
	 l3aOwCGrcfhynkeJqoUu4DqPli72gzisQz8+2jvizEGAmMnxeSWvDZe7GUm/Y68pbB
	 dLqyoy6q2vn2B9D6+iB4+HU1Z9FtP9UI7dned9g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXI3q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:29:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22015 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727197AbgBXI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:29:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-uh8hD3SlPJqix-NZqT98nA-1; Mon, 24 Feb 2020 03:29:43 -0500
X-MC-Unique: uh8hD3SlPJqix-NZqT98nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7ED801E5C;
        Mon, 24 Feb 2020 08:29:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-205-68.brq.redhat.com [10.40.205.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D657E85781;
        Mon, 24 Feb 2020 08:29:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] perf expr: Make expr__parse return -1 on error
Date:   Mon, 24 Feb 2020 09:29:18 +0100
Message-Id: <20200224082918.58489-6-jolsa@kernel.org>
In-Reply-To: <20200224082918.58489-1-jolsa@kernel.org>
References: <20200224082918.58489-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To match the error value of the expr__find_other function,
so all exported expr functions return the same values:
0 on success, -1 on error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.24.1


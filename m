Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FFDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FE420823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590360165;
	bh=q2JGWyaAldnk927k20GrrRnWk7xvFNqWcp2skn7i6EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cOdGjjlkG9WM2dB7X0Ml3CP8IQ44eEURSTA5MytkkBsT9rmpN13pKhyYjeWqEg8ca
	 03xVAeRAhmInVlom5TZgQN+WdBGl9wqbzm9Hb1kzbJBNngCnFuSERM93AxUYZ89rMS
	 DkIE0r3HvRbCQCfPbZ/CNv6Wj5EPoqJqYekLBAUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbgEXWmi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:42:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38402 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387850AbgEXWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Wm1SiBvxNDG89WH77f9hlQ-1; Sun, 24 May 2020 18:42:28 -0400
X-MC-Unique: Wm1SiBvxNDG89WH77f9hlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18AF460;
        Sun, 24 May 2020 22:42:26 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 852E95D788;
        Sun, 24 May 2020 22:42:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 01/14] perf tests: Check on subtest for user specified test
Date:   Mon, 25 May 2020 00:42:06 +0200
Message-Id: <20200524224219.234847-2-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
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

It's now possible to put subtest name as a test filter:

  $ perf test 'PMU event table sanity'
  10: PMU events                                            :
  10.1: PMU event table sanity                              : Ok

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/builtin-test.c | 34 +++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 9553f8061772..a9daaeb9fd27 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -334,7 +334,7 @@ static struct test *tests[] = {
 	arch_tests,
 };
 
-static bool perf_test__matches(struct test *test, int curr, int argc, const char *argv[])
+static bool perf_test__matches(const char *desc, int curr, int argc, const char *argv[])
 {
 	int i;
 
@@ -351,7 +351,7 @@ static bool perf_test__matches(struct test *test, int curr, int argc, const char
 			continue;
 		}
 
-		if (strcasestr(test->desc, argv[i]))
+		if (strcasestr(desc, argv[i]))
 			return true;
 	}
 
@@ -580,7 +580,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 			.priv = &st,
 		};
 
-		if (!perf_test__matches(&test, curr, argc, argv))
+		if (!perf_test__matches(test.desc, curr, argc, argv))
 			continue;
 
 		st.file = ent->d_name;
@@ -608,9 +608,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 
 	for_each_test(j, t) {
 		int curr = i++, err;
+		int subi;
 
-		if (!perf_test__matches(t, curr, argc, argv))
-			continue;
+		if (!perf_test__matches(t->desc, curr, argc, argv)) {
+			bool skip = true;
+			int subn;
+
+			if (!t->subtest.get_nr)
+				continue;
+
+			subn = t->subtest.get_nr();
+
+			for (subi = 0; subi < subn; subi++) {
+				if (perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
+					skip = false;
+			}
+
+			if (skip)
+				continue;
+		}
 
 		if (t->is_supported && !t->is_supported()) {
 			pr_debug("%2d: %-*s: Disabled\n", i, width, t->desc);
@@ -638,7 +654,6 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			 */
 			int subw = width > 2 ? width - 2 : width;
 			bool skip = false;
-			int subi;
 
 			if (subn <= 0) {
 				color_fprintf(stderr, PERF_COLOR_YELLOW,
@@ -655,6 +670,9 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			}
 
 			for (subi = 0; subi < subn; subi++) {
+				if (!perf_test__matches(t->subtest.get_desc(subi), curr, argc, argv))
+					continue;
+
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
 				err = test_and_print(t, skip, subi);
@@ -688,7 +706,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 			.desc = shell_test__description(bf, sizeof(bf), path, ent->d_name),
 		};
 
-		if (!perf_test__matches(&t, curr, argc, argv))
+		if (!perf_test__matches(t.desc, curr, argc, argv))
 			continue;
 
 		pr_info("%2d: %s\n", i, t.desc);
@@ -707,7 +725,7 @@ static int perf_test__list(int argc, const char **argv)
 	for_each_test(j, t) {
 		int curr = i++;
 
-		if (!perf_test__matches(t, curr, argc, argv) ||
+		if (!perf_test__matches(t->desc, curr, argc, argv) ||
 		    (t->is_supported && !t->is_supported()))
 			continue;
 
-- 
2.25.4


Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B598C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACA520730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBEPpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:45:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35854 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgBEPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:45:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1izMrS-0004Qk-DZ; Wed, 05 Feb 2020 16:45:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 028691C1EC5;
        Wed,  5 Feb 2020 16:45:06 +0100 (CET)
Date:   Wed, 05 Feb 2020 15:45:05 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf test: Fix test case Merge cpu map
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200120132011.64698-1-tmricht@linux.ibm.com>
References: <20200120132011.64698-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158091750578.411.91326427267812239.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0dd1979f7f9981dcc5c497e68390f208580032ae
Gitweb:        https://git.kernel.org/tip/0dd1979f7f9981dcc5c497e68390f208580032ae
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Mon, 20 Jan 2020 14:20:09 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Jan 2020 11:55:02 +01:00

perf test: Fix test case Merge cpu map

Commit a2408a70368a ("perf evlist: Maintain evlist->all_cpus")
introduces a test case for cpumap merge operation, see functions
perf_cpu_map__merge() and test__cpu_map_merge().

The test case fails on s390 with this error message:

 [root@m35lp76 perf]# ./perf test -Fvvvvv 52
 52: Merge cpu map                                         :
 --- start ---
 cpumask list: 1-2,4-5,7
 perf: /root/linux/tools/include/linux/refcount.h:131:\
          refcount_sub_and_test: Assertion `!(new > val)' failed.
 Aborted (core dumped)
 [root@m35lp76 perf]#

The root cause is in the function test__cpu_map_merge():
It creates two cpu_maps named 'a' and 'b':

  struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
  struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");

and creates a third map named 'c' which is the result of
the merge of maps a and b:

  struct perf_cpu_map *c = perf_cpu_map__merge(a, b);

After some verifaction of the merged cpu_map all three
of them are have their reference count reduced and are
freed:

   perf_cpu_map__put(a); (1)
   perf_cpu_map__put(b);
   perf_cpu_map__put(c);

The release of perf_cpu_map__put(a) is wrong. The map
is already released and free'ed as part of the function

  perf_cpu_map__merge(struct perf_cpu_map *orig,
  |	              struct perf_cpu_map *other)
  +--> perf_cpu_map__put(orig);
       |
       +--> cpu_map__delete(orig)

At the end perf_cpu_map_put() is called for map 'orig'
alias 'a' and since the reference count is 1, the map
is deleted, as can be seen by the following gdb trace:

 (gdb) where
 #0  tcache_put (tc_idx=0, chunk=0x156cc30) at malloc.c:2940
 #1  _int_free (av=0x3fffd49ee80 <main_arena>, p=0x156cc30,
		     have_lock=<optimized out>) at malloc.c:4222
 #2  0x00000000012d5e78 in cpu_map__delete (map=0x156cc40) at cpumap.c:31
 #3  0x00000000012d5f7a in perf_cpu_map__put (map=0x156cc40) at cpumap.c:45
 #4  0x00000000012d723a in perf_cpu_map__merge (orig=0x156cc40,
     other=0x156cc60) at cpumap.c:343
 #5  0x000000000110cdd0 in test__cpu_map_merge (
     test=0x14ea6c8 <generic_tests+2856>, subtest=-1) at tests/cpumap.c:128

Thus the perf_cpu_map__put(a) (see (1) above) frees map 'a'
a second time and causes the failure. Fix this be removing that
function call.

Output after:
  [root@m35lp76 perf]# ./perf test -Fvvvvv 52
  52: Merge cpu map                                         :
  --- start ---
  cpumask list: 1-2,4-5,7
  ---- end ----
  Merge cpu map: Ok
  [root@m35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: sumanthk@linux.ibm.com
Link: http://lore.kernel.org/lkml/20200120132011.64698-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/cpumap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 4ac5674..29c793a 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -131,7 +131,6 @@ int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
-	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
 	return 0;

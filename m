Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58324C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2583D2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580544239;
	bh=HV9bEd5y/kS5QirGTechJ66etJMhVPV4zDZIWJvnB6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bm39zcm6gKW96y6GqymK2VP3UXqdJwKYt++uNo21g1hjD72hps9UaYMZTJRh7iJ5x
	 VZoz9gg0NoNW/ve5J4hmnR1FY+wi2xd9/HeE4vAIiXnySF2cvWxPEk+s+EBes79is4
	 21V7/oEoui8Yh4sRrP5boW+9RsDoGcKY/ZcRuP+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBAIDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBAIDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:03:54 -0500
Received: from quaco.parlament.guest (catv-212-96-54-169.catv.broadband.hu [212.96.54.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F692070C;
        Sat,  1 Feb 2020 08:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580544233;
        bh=HV9bEd5y/kS5QirGTechJ66etJMhVPV4zDZIWJvnB6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+M/j2ih9Fz7Zdwc/EPx9D7E5lYiC2OO1g2D0fTH2a/JA8WrK+VtHqzvWlf6LVOqY
         f01QkQIjH6BHIBJ82VQpD8xq6EusrCrBumHKSA2q3vF31JNLhm6S2imPq3UCq8Ifgo
         04vf2y3gwPt5rJIEG6uMS6+woq5JX7UGoWe1JfoY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/6] perf test: Fix test case Merge cpu map
Date:   Sat,  1 Feb 2020 09:03:27 +0100
Message-Id: <20200201080330.13211-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
References: <20200201080330.13211-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

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
index 4ac56741ac5f..29c793ac7d10 100644
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
-- 
2.21.1


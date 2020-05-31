Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51B920723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590942139;
	bh=mpN/iDKPhhH04HTUDp8uoxeW5Y5nY8iMZ+y7U3eR9kQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=z6A9quoAlorKSvppyHXrTO41AUsZ2oXygpQZLie6yNr8lIxxhBrXs6EKYJ2XcMgWF
	 mv5jGLHV/kmPnxk4zpN5xQA0cd1FHBWE39rc0jULqJGTZPwwf2Y9Y2ZJ2TfJkjsGce
	 qHg4KpZe9Wey4YriAPCZGldKGArZAEuq845D+siQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEaQWT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 12:22:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgEaQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 12:22:18 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-o2qZ29xAMOC3rPJ6htNU7Q-1; Sun, 31 May 2020 12:22:11 -0400
X-MC-Unique: o2qZ29xAMOC3rPJ6htNU7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A94A1800D42;
        Sun, 31 May 2020 16:22:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD54768DE;
        Sun, 31 May 2020 16:22:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf stat: Ensure group is defined on top of the same cpu mask
Date:   Sun, 31 May 2020 18:22:06 +0200
Message-Id: <20200531162206.911168-1-jolsa@kernel.org>
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

Jin Yao reported the issue (and posted first versions of this change)
with groups being defined over events with different cpu mask.

This causes assert aborts in get_group_fd, like:

  # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
  perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
  Aborted

All the events in the group have to be defined over the same
cpus so the group_fd can be found for every leader/member pair.

Adding check to ensure this condition is met and removing the
group (with warning) if we detect mixed cpus, like:

  $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
  WARNING: event cpu maps do not match, disabling group:
    anon group { power/energy-cores/, cycles }
    anon group { instructions, power/energy-cores/ }

Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2b79aa161dd..512a41363d07 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -190,6 +190,55 @@ static struct perf_stat_config stat_config = {
 	.big_num		= true,
 };
 
+static bool cpus_map_matched(struct evsel *a, struct evsel *b)
+{
+	if (!a->core.cpus && !b->core.cpus)
+		return true;
+
+	if (!a->core.cpus || !b->core.cpus)
+		return false;
+
+	if (a->core.cpus->nr != b->core.cpus->nr)
+		return false;
+
+	for (int i = 0; i < a->core.cpus->nr; i++) {
+		if (a->core.cpus->map[i] != b->core.cpus->map[i])
+			return false;
+	}
+
+	return true;
+}
+
+static void evlist__check_cpu_maps(struct evlist *evlist)
+{
+	struct evsel *evsel, *pos, *leader;
+	char buf[1024];
+
+	evlist__for_each_entry(evlist, evsel) {
+		leader = evsel->leader;
+
+		/* Check that leader matches cpus with each member. */
+		if (leader == evsel)
+			continue;
+		if (cpus_map_matched(leader, evsel))
+			continue;
+
+		/*
+		 * If there's mismatch display dismantle the
+		 * group and warn user.
+		 */
+		WARN_ONCE(1, "WARNING: group events cpu maps do not match, disabling group:\n");
+		evsel__group_desc(leader, buf, sizeof(buf));
+		pr_warning("  %s\n", buf);
+
+		for_each_group_evsel(pos, leader) {
+			pos->leader = pos;
+			pos->core.nr_members = 0;
+		}
+		evsel->leader->core.nr_members = 0;
+	}
+}
+
 static inline void diff_timespec(struct timespec *r, struct timespec *a,
 				 struct timespec *b)
 {
@@ -1962,6 +2011,8 @@ int cmd_stat(int argc, const char **argv)
 	} else if (argc && !strncmp(argv[0], "rep", 3))
 		return __cmd_report(argc, argv);
 
+	evlist__check_cpu_maps(evsel_list);
+
 	interval = stat_config.interval;
 	timeout = stat_config.timeout;
 
-- 
2.25.4


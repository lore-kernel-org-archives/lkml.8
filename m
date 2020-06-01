Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03712068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULnVV/OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgFAIUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:20:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726005AbgFAIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590999636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rK/uAal5XUN1e0HkqV2baeLoovsmHTsFDGP7o7CPx54=;
        b=ULnVV/OScHve4by9EEeUhHTc3OEBIlyGrPjGffiH6uXWtBFeUEACqdrTTzM24w7MzARbwz
        rEPCt6QR4EEakUv/nezFSxk+WZOsY1BDzGknRCmlMjbyQi4TgNFE9teX02EAmUcgkorIdk
        N7FIoSp1i+Hgc6kL2Ph82XMrL5DaYn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-gGYMXbP6P1iGOzCblbs9Qg-1; Mon, 01 Jun 2020 04:20:33 -0400
X-MC-Unique: gGYMXbP6P1iGOzCblbs9Qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51A3107ACCD;
        Mon,  1 Jun 2020 08:20:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id E537E5D9CA;
        Mon,  1 Jun 2020 08:20:28 +0000 (UTC)
Date:   Mon, 1 Jun 2020 10:20:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCHv2] perf stat: Ensure group is defined on top of the same cpu
 mask
Message-ID: <20200601082027.GF881900@krava>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ian asked also for cpu maps details, it's displayed in verbose mode:

  $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
  WARNING: group events cpu maps do not match, disabling group:
    anon group { power/energy-cores/, cycles }
       power/energy-cores/: 0
       cycles: 0-7
    anon group { instructions, power/energy-cores/ }
       instructions: 0-7
       power/energy-cores/: 0

Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

v2 changes:
  - display mixed events maps in verbose mode

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2b79aa161dd..dda60b9dbc63 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -190,6 +190,62 @@ static struct perf_stat_config stat_config = {
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
+		if (verbose) {
+			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
+			pr_warning("     %s: %s\n", leader->name, buf);
+			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
+			pr_warning("     %s: %s\n", evsel->name, buf);
+		}
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
@@ -2113,6 +2169,8 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	evlist__check_cpu_maps(evsel_list);
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
-- 
2.25.4


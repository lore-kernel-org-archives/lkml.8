Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0241C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DDC20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383788;
	bh=FNu+j456Xze8WJq0pl3gJLibApoHq/2o4M5SnOQCeQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fzLTA4BnvIKw/ecJMnUEzj4+SOblOSJrVf86xuyn3lBEnyc/Y4bHgiuSsFoLKN13R
	 Kw9JXgpiJgSz6toFNZ1FFATW0h68g8Ljj7JhrdsnICkhd2P/BV9EkD1ksMnFOEl6PP
	 qGAJ1A3W4ZWak46mteKn6iHOcZVtbVgCqZJU4kQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgDTL42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgDTL4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:25 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5914F22240;
        Mon, 20 Apr 2020 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383785;
        bh=FNu+j456Xze8WJq0pl3gJLibApoHq/2o4M5SnOQCeQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrASJaByQcEdxHXnOQraV/okDvvbp2yhENxRwW6kuzjKpFXMBEC9efOcD7QkdT7CE
         EbACTG1AReHEKrhMbO0YSOF3Udcd4AEg7jhkDclEeIJq/YdQ1YqZLFLlTrrqoGnWlK
         RrPSavuLY9OR1EhZ0G/O8yVvkdUioEi9cSMqljU8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/60] perf tools: Add support for leader-sampling with AUX area events
Date:   Mon, 20 Apr 2020 08:52:57 -0300
Message-Id: <20200420115316.18781-42-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When AUX area events are used in sampling mode, they must be the group
leader, but the group leader is also used for leader-sampling. However,
it is not desirable to use an AUX area event as the leader for
leader-sampling, because it doesn't have any samples of its own. To support
leader-sampling with AUX area events, use the 2nd event of the group as the
"leader" for the purposes of leader-sampling.

Example:

 # perf record --kcore --aux-sample -e '{intel_pt//,cycles,instructions}:S' -c 10000 uname
 [ perf record: Woken up 3 times to write data ]
 [ perf record: Captured and wrote 0.786 MB perf.data ]
 # perf report
 Samples: 380  of events 'anon group { cycles, instructions }', Event count (approx.): 3026164
           Children              Self  Command  Shared Object      Symbol
 +   38.76%  42.65%     0.00%   0.00%  uname    [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
 +   35.82%  31.33%     0.00%   0.00%  uname    ld-2.28.so         [.] _dl_start_user
 +   34.29%  29.74%     0.55%   0.47%  uname    ld-2.28.so         [.] _dl_start
 +   33.73%  28.62%     1.60%   0.97%  uname    ld-2.28.so         [.] dl_main
 +   33.19%  29.04%     0.52%   0.32%  uname    ld-2.28.so         [.] _dl_sysdep_start
 +   27.83%  33.74%     0.00%   0.00%  uname    [kernel.kallsyms]  [k] do_syscall_64
 +   26.76%  33.29%     0.00%   0.00%  uname    [kernel.kallsyms]  [k] entry_SYSCALL_64_after_hwframe
 +   23.78%  20.33%     5.97%   5.25%  uname    [kernel.kallsyms]  [k] page_fault
 +   23.18%  24.60%     0.00%   0.00%  uname    libc-2.28.so       [.] __libc_start_main
 +   22.64%  24.37%     0.00%   0.00%  uname    uname              [.] _start
 +   21.04%  23.27%     0.00%   0.00%  uname    uname              [.] main
 +   19.48%  18.08%     3.72%   3.64%  uname    ld-2.28.so         [.] _dl_relocate_object
 +   19.47%  21.81%     0.00%   0.00%  uname    libc-2.28.so       [.] setlocale
 +   19.44%  21.56%     0.52%   0.61%  uname    libc-2.28.so       [.] _nl_find_locale
 +   17.87%  19.66%     0.00%   0.00%  uname    libc-2.28.so       [.] _nl_load_locale_from_archive
 +   15.71%  13.73%     0.53%   0.52%  uname    [kernel.kallsyms]  [k] do_page_fault
 +   15.18%  13.21%     1.03%   0.68%  uname    [kernel.kallsyms]  [k] handle_mm_fault
 +   14.15%  12.53%     1.01%   1.12%  uname    [kernel.kallsyms]  [k] __handle_mm_fault
 +   12.03%   9.67%     0.54%   0.32%  uname    ld-2.28.so         [.] _dl_map_object
 +   10.55%   8.48%     0.00%   0.00%  uname    ld-2.28.so         [.] openaux
 +   10.55%  20.20%     0.52%   0.61%  uname    libc-2.28.so       [.] __run_exit_handlers

Comnmitter notes:

Fixed up this problem:

  util/record.c: In function ‘perf_evlist__config’:
  util/record.c:256:3: error: too few arguments to function ‘perf_evsel__config_leader_sampling’
    256 |   perf_evsel__config_leader_sampling(evsel);
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/record.c:190:13: note: declared here
    190 | static void perf_evsel__config_leader_sampling(struct evsel *evsel,
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  3 ++
 tools/perf/util/record.c               | 45 ++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 6345db33c533..cb23667531ab 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -258,6 +258,9 @@ Normally all events in an event group sample, but with :S only
 the first event (the leader) samples, and it only reads the values of the
 other events in the group.
 
+However, in the case AUX area events (e.g. Intel PT or CoreSight), the AUX
+area event must be the leader, so then the second event samples, not the first.
+
 OPTIONS
 -------
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 32aeeb8a8d00..6d3e3df6e2a1 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -167,17 +167,46 @@ bool perf_can_aux_sample(void)
 	return true;
 }
 
-static void perf_evsel__config_leader_sampling(struct evsel *evsel)
+/*
+ * perf_evsel__config_leader_sampling() uses special rules for leader sampling.
+ * However, if the leader is an AUX area event, then assume the event to sample
+ * is the next event.
+ */
+static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
+					      struct evlist *evlist)
+{
+	struct evsel *leader = evsel->leader;
+
+	if (perf_evsel__is_aux_event(leader)) {
+		evlist__for_each_entry(evlist, evsel) {
+			if (evsel->leader == leader && evsel != evsel->leader)
+				return evsel;
+		}
+	}
+
+	return leader;
+}
+
+static void perf_evsel__config_leader_sampling(struct evsel *evsel,
+					       struct evlist *evlist)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
+	struct evsel *read_sampler;
+
+	if (!leader->sample_read)
+		return;
+
+	read_sampler = perf_evsel__read_sampler(evsel, evlist);
 
-	if (leader == evsel || !leader->sample_read)
+	if (evsel == read_sampler)
 		return;
 
 	/*
-	 * Disable sampling for all group members other
-	 * than leader in case leader 'leads' the sampling.
+	 * Disable sampling for all group members other than the leader in
+	 * case the leader 'leads' the sampling, except when the leader is an
+	 * AUX area event, in which case the 2nd event in the group is the one
+	 * that 'leads' the sampling.
 	 */
 	attr->freq           = 0;
 	attr->sample_freq    = 0;
@@ -188,8 +217,12 @@ static void perf_evsel__config_leader_sampling(struct evsel *evsel)
 	 * We don't get a sample for slave events, we make them when delivering
 	 * the group leader sample. Set the slave event to follow the master
 	 * sample_type to ease up reporting.
+	 * An AUX area event also has sample_type requirements, so also include
+	 * the sample type bits from the leader's sample_type to cover that
+	 * case.
 	 */
-	attr->sample_type = leader->core.attr.sample_type;
+	attr->sample_type = read_sampler->core.attr.sample_type |
+			    leader->core.attr.sample_type;
 }
 
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
@@ -220,7 +253,7 @@ void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 
 	/* Configure leader sampling here now that the sample type is known */
 	evlist__for_each_entry(evlist, evsel)
-		perf_evsel__config_leader_sampling(evsel);
+		perf_evsel__config_leader_sampling(evsel, evlist);
 
 	if (opts->full_auxtrace) {
 		/*
-- 
2.21.1


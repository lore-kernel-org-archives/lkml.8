Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD9C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736FE20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgDVMU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgDVMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E358C03C1AD;
        Wed, 22 Apr 2020 05:17:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJj-0007o0-JP; Wed, 22 Apr 2020 14:17:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 72F171C0451;
        Wed, 22 Apr 2020 14:17:24 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:24 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: For reporting purposes, un-group AUX
 area event
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-8-adrian.hunter@intel.com>
References: <20200401101613.6201-8-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784403.28353.4089105654269177016.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5c7bec0c9c543733fa96fe500e4c245be6f9fd30
Gitweb:        https://git.kernel.org/tip/5c7bec0c9c543733fa96fe500e4c245be6f9fd30
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:04 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:15 -03:00

perf auxtrace: For reporting purposes, un-group AUX area event

An AUX area event must be the group leader when recording traces in
sample mode, but that does not produce the expected results from
'perf report' because it expects the leader to provide samples.

Rather than teach 'perf report' about AUX area sampling, un-group the
AUX area event during processing, making the 2nd event the leader.

Example:

 $ perf record -e '{intel_pt//u,branch-misses:u}' -c 1 uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.080 MB perf.data ]

 Before:

 $ perf report

 Samples: 800  of events 'anon group { intel_pt//u, branch-misses:u }', Event count (approx.): 800
        Children              Self  Command  Shared Object     Symbol
     0.00%  47.50%     0.00%  47.50%  uname    libc-2.28.so      [.] _dl_addr
     0.00%  16.38%     0.00%  16.38%  uname    ld-2.28.so        [.] __GI___tunables_init
     0.00%  54.75%     0.00%   4.75%  uname    ld-2.28.so        [.] dl_main
     0.00%   3.12%     0.00%   3.12%  uname    ld-2.28.so        [.] _dl_map_object_from_fd
     0.00%   2.38%     0.00%   2.38%  uname    ld-2.28.so        [.] strcmp
     0.00%   2.25%     0.00%   2.25%  uname    ld-2.28.so        [.] _dl_check_map_versions
     0.00%   2.00%     0.00%   2.00%  uname    ld-2.28.so        [.] _dl_important_hwcaps
     0.00%   2.00%     0.00%   2.00%  uname    ld-2.28.so        [.] _dl_map_object_deps
     0.00%  51.50%     0.00%   1.50%  uname    ld-2.28.so        [.] _dl_sysdep_start
     0.00%   1.25%     0.00%   1.25%  uname    ld-2.28.so        [.] _dl_load_cache_lookup
     0.00%  51.12%     0.00%   1.12%  uname    ld-2.28.so        [.] _dl_start
     0.00%  50.88%     0.00%   1.12%  uname    ld-2.28.so        [.] do_lookup_x
     0.00%  50.62%     0.00%   1.00%  uname    ld-2.28.so        [.] _dl_lookup_symbol_x
     0.00%   1.00%     0.00%   1.00%  uname    ld-2.28.so        [.] _dl_map_object
     0.00%   1.00%     0.00%   1.00%  uname    ld-2.28.so        [.] _dl_next_ld_env_entry
     0.00%   0.88%     0.00%   0.88%  uname    ld-2.28.so        [.] _dl_cache_libcmp
     0.00%   0.88%     0.00%   0.88%  uname    ld-2.28.so        [.] _dl_new_object
     0.00%  50.88%     0.00%   0.88%  uname    ld-2.28.so        [.] _dl_relocate_object
     0.00%   0.62%     0.00%   0.62%  uname    ld-2.28.so        [.] _dl_init_paths
     0.00%   0.62%     0.00%   0.62%  uname    ld-2.28.so        [.] _dl_name_match_p
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] get_common_indeces.constprop.1
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] memmove
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] memset
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] open_verify.constprop.11
     0.00%   0.38%     0.00%   0.38%  uname    ld-2.28.so        [.] _dl_check_all_versions
     0.00%   0.38%     0.00%   0.38%  uname    ld-2.28.so        [.] _dl_find_dso_for_object
     0.00%   0.38%     0.00%   0.38%  uname    ld-2.28.so        [.] init_tls
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] __tunable_get_val
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] _dl_add_to_namespace_list
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] _dl_determine_tlsoffset
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] _dl_discover_osversion
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] calloc@plt
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] malloc
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] malloc@plt
     0.00%   0.25%     0.00%   0.25%  uname    libc-2.28.so      [.] _nl_load_locale_from_archive
     0.00%   0.25%     0.00%   0.25%  uname    [unknown]         [k] 0xffffffffa3a00010
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] __libc_scratch_buffer_set_array_size
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_allocate_tls_storage
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_catch_exception
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_setup_hash
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_sort_maps
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_sysdep_read_whole_file
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] access
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] calloc
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] mmap64
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] openaux
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] rtld_lock_default_lock_recursive
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] rtld_lock_default_unlock_recursive
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] strchr
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] strlen
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] 0x0000000000001080
     0.00%   0.12%     0.00%   0.12%  uname    libc-2.28.so      [.] __strchrnul_avx2
     0.00%   0.12%     0.00%   0.12%  uname    libc-2.28.so      [.] _nl_normalize_codeset
     0.00%   0.12%     0.00%   0.12%  uname    libc-2.28.so      [.] malloc
     0.00%   0.12%     0.00%   0.12%  uname    [unknown]         [k] 0xffffffffa3a011f0
     0.00%  50.00%     0.00%   0.00%  uname    ld-2.28.so        [.] _dl_start_user
     0.00%  50.00%     0.00%   0.00%  uname    [unknown]         [.] 0000000000000000

 After:

 Samples: 800  of event 'branch-misses:u', Event count (approx.): 800
  Children      Self  Command  Shared Object     Symbol
    54.75%     4.75%  uname    ld-2.28.so        [.] dl_main
    51.50%     1.50%  uname    ld-2.28.so        [.] _dl_sysdep_start
    51.12%     1.12%  uname    ld-2.28.so        [.] _dl_start
    50.88%     0.88%  uname    ld-2.28.so        [.] _dl_relocate_object
    50.88%     1.12%  uname    ld-2.28.so        [.] do_lookup_x
    50.62%     1.00%  uname    ld-2.28.so        [.] _dl_lookup_symbol_x
    50.00%     0.00%  uname    ld-2.28.so        [.] _dl_start_user
    50.00%     0.00%  uname    [unknown]         [.] 0000000000000000
    47.50%    47.50%  uname    libc-2.28.so      [.] _dl_addr
    16.38%    16.38%  uname    ld-2.28.so        [.] __GI___tunables_init
     3.12%     3.12%  uname    ld-2.28.so        [.] _dl_map_object_from_fd
     2.38%     2.38%  uname    ld-2.28.so        [.] strcmp
     2.25%     2.25%  uname    ld-2.28.so        [.] _dl_check_map_versions
     2.00%     2.00%  uname    ld-2.28.so        [.] _dl_important_hwcaps
     2.00%     2.00%  uname    ld-2.28.so        [.] _dl_map_object_deps
     1.25%     1.25%  uname    ld-2.28.so        [.] _dl_load_cache_lookup
     1.00%     1.00%  uname    ld-2.28.so        [.] _dl_map_object
     1.00%     1.00%  uname    ld-2.28.so        [.] _dl_next_ld_env_entry
     0.88%     0.88%  uname    ld-2.28.so        [.] _dl_cache_libcmp
     0.88%     0.88%  uname    ld-2.28.so        [.] _dl_new_object
     0.62%     0.62%  uname    ld-2.28.so        [.] _dl_init_paths
     0.62%     0.62%  uname    ld-2.28.so        [.] _dl_name_match_p
     0.50%     0.50%  uname    ld-2.28.so        [.] get_common_indeces.constprop.1
     0.50%     0.50%  uname    ld-2.28.so        [.] memmove
     0.50%     0.50%  uname    ld-2.28.so        [.] memset
     0.50%     0.50%  uname    ld-2.28.so        [.] open_verify.constprop.11
     0.38%     0.38%  uname    ld-2.28.so        [.] _dl_check_all_versions
     0.38%     0.38%  uname    ld-2.28.so        [.] _dl_find_dso_for_object
     0.38%     0.38%  uname    ld-2.28.so        [.] init_tls
     0.25%     0.25%  uname    ld-2.28.so        [.] __tunable_get_val
     0.25%     0.25%  uname    ld-2.28.so        [.] _dl_add_to_namespace_list
     0.25%     0.25%  uname    ld-2.28.so        [.] _dl_determine_tlsoffset
     0.25%     0.25%  uname    ld-2.28.so        [.] _dl_discover_osversion
     0.25%     0.25%  uname    ld-2.28.so        [.] calloc@plt
     0.25%     0.25%  uname    ld-2.28.so        [.] malloc
     0.25%     0.25%  uname    ld-2.28.so        [.] malloc@plt
     0.25%     0.25%  uname    libc-2.28.so      [.] _nl_load_locale_from_archive
     0.25%     0.25%  uname    [unknown]         [k] 0xffffffffa3a00010
     0.12%     0.12%  uname    ld-2.28.so        [.] __libc_scratch_buffer_set_array_size
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_allocate_tls_storage
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_catch_exception
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_setup_hash
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_sort_maps
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_sysdep_read_whole_file
     0.12%     0.12%  uname    ld-2.28.so        [.] access
     0.12%     0.12%  uname    ld-2.28.so        [.] calloc
     0.12%     0.12%  uname    ld-2.28.so        [.] mmap64
     0.12%     0.12%  uname    ld-2.28.so        [.] openaux
     0.12%     0.12%  uname    ld-2.28.so        [.] rtld_lock_default_lock_recursive
     0.12%     0.12%  uname    ld-2.28.so        [.] rtld_lock_default_unlock_recursive
     0.12%     0.12%  uname    ld-2.28.so        [.] strchr
     0.12%     0.12%  uname    ld-2.28.so        [.] strlen
     0.12%     0.12%  uname    ld-2.28.so        [.] 0x0000000000001080
     0.12%     0.12%  uname    libc-2.28.so      [.] __strchrnul_avx2
     0.12%     0.12%  uname    libc-2.28.so      [.] _nl_normalize_codeset
     0.12%     0.12%  uname    libc-2.28.so      [.] malloc
     0.12%     0.12%  uname    [unknown]         [k] 0xffffffffa3a011f0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 60 +++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2c4ad68..b60bae8 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1234,29 +1234,79 @@ out_free:
 	return err;
 }
 
+static void unleader_evsel(struct evlist *evlist, struct evsel *leader)
+{
+	struct evsel *new_leader = NULL;
+	struct evsel *evsel;
+
+	/* Find new leader for the group */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->leader != leader || evsel == leader)
+			continue;
+		if (!new_leader)
+			new_leader = evsel;
+		evsel->leader = new_leader;
+	}
+
+	/* Update group information */
+	if (new_leader) {
+		zfree(&new_leader->group_name);
+		new_leader->group_name = leader->group_name;
+		leader->group_name = NULL;
+
+		new_leader->core.nr_members = leader->core.nr_members - 1;
+		leader->core.nr_members = 1;
+	}
+}
+
+static void unleader_auxtrace(struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (auxtrace__evsel_is_auxtrace(session, evsel) &&
+		    perf_evsel__is_group_leader(evsel)) {
+			unleader_evsel(session->evlist, evsel);
+		}
+	}
+}
+
 int perf_event__process_auxtrace_info(struct perf_session *session,
 				      union perf_event *event)
 {
 	enum auxtrace_type type = event->auxtrace_info.type;
+	int err;
 
 	if (dump_trace)
 		fprintf(stdout, " type: %u\n", type);
 
 	switch (type) {
 	case PERF_AUXTRACE_INTEL_PT:
-		return intel_pt_process_auxtrace_info(event, session);
+		err = intel_pt_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_INTEL_BTS:
-		return intel_bts_process_auxtrace_info(event, session);
+		err = intel_bts_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_ARM_SPE:
-		return arm_spe_process_auxtrace_info(event, session);
+		err = arm_spe_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_CS_ETM:
-		return cs_etm__process_auxtrace_info(event, session);
+		err = cs_etm__process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_S390_CPUMSF:
-		return s390_cpumsf_process_auxtrace_info(event, session);
+		err = s390_cpumsf_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
 	}
+
+	if (err)
+		return err;
+
+	unleader_auxtrace(session);
+
+	return 0;
 }
 
 s64 perf_event__process_auxtrace(struct perf_session *session,

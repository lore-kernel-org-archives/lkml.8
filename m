Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B3C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D51321473
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgCSONV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:13:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60814 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgCSOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsf-0001zN-5N; Thu, 19 Mar 2020 15:10:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C982F1C22A3;
        Thu, 19 Mar 2020 15:10:40 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:40 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Give synthetic mmap events an inode generation
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313053129.131264-1-irogers@google.com>
References: <20200313053129.131264-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158462704053.28353.11934701390002464663.tip-bot2@tip-bot2>
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

Commit-ID:     3b7a15b0643d42e4dca78c5aed8f1ad209a3d1ab
Gitweb:        https://git.kernel.org/tip/3b7a15b0643d42e4dca78c5aed8f1ad209a3d1ab
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 12 Mar 2020 22:31:29 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 17 Mar 2020 18:01:36 -03:00

perf tools: Give synthetic mmap events an inode generation

When mmap2 events are synthesized the ino_generation field isn't being
set leading to uninitialized memory being compared.

Caught with clang's -fsanitize=memory:

==124733==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x55a96a6a65cc in __dso_id__cmp tools/perf/util/dsos.c:23:6
    #1 0x55a96a6a81d5 in dso_id__cmp tools/perf/util/dsos.c:38:9
    #2 0x55a96a6a717f in __dso__cmp_long_name tools/perf/util/dsos.c:74:15
    #3 0x55a96a6a6c4c in __dsos__findnew_link_by_longname_id tools/perf/util/dsos.c:106:12
    #4 0x55a96a6a851e in __dsos__findnew_by_longname_id tools/perf/util/dsos.c:178:9
    #5 0x55a96a6a7798 in __dsos__find_id tools/perf/util/dsos.c:191:9
    #6 0x55a96a6a7b57 in __dsos__findnew_id tools/perf/util/dsos.c:251:20
    #7 0x55a96a6a7a57 in dsos__findnew_id tools/perf/util/dsos.c:259:17
    #8 0x55a96a7776ae in machine__findnew_dso_id tools/perf/util/machine.c:2709:9
    #9 0x55a96a77dfcf in map__new tools/perf/util/map.c:193:10
    #10 0x55a96a77240a in machine__process_mmap2_event tools/perf/util/machine.c:1670:8
    #11 0x55a96a7741a3 in machine__process_event tools/perf/util/machine.c:1882:9
    #12 0x55a96a6aee39 in perf_event__process tools/perf/util/event.c:454:9
    #13 0x55a96a87d633 in perf_tool__process_synth_event tools/perf/util/synthetic-events.c:63:9
    #14 0x55a96a87f131 in perf_event__synthesize_mmap_events tools/perf/util/synthetic-events.c:403:7
    #15 0x55a96a8815d6 in __event__synthesize_thread tools/perf/util/synthetic-events.c:548:9
    #16 0x55a96a882bff in __perf_event__synthesize_threads tools/perf/util/synthetic-events.c:681:3
    #17 0x55a96a881ec2 in perf_event__synthesize_threads tools/perf/util/synthetic-events.c:750:9
    #18 0x55a96a562b26 in synth_all tools/perf/tests/mmap-thread-lookup.c:136:9
    #19 0x55a96a5623b1 in mmap_events tools/perf/tests/mmap-thread-lookup.c:174:8
    #20 0x55a96a561fa0 in test__mmap_thread_lookup tools/perf/tests/mmap-thread-lookup.c:230:2
    #21 0x55a96a52c182 in run_test tools/perf/tests/builtin-test.c:378:9
    #22 0x55a96a52afc1 in test_and_print tools/perf/tests/builtin-test.c:408:9
    #23 0x55a96a52966e in __cmd_test tools/perf/tests/builtin-test.c:603:4
    #24 0x55a96a52855d in cmd_test tools/perf/tests/builtin-test.c:747:9
    #25 0x55a96a2844d4 in run_builtin tools/perf/perf.c:312:11
    #26 0x55a96a282bd0 in handle_internal_command tools/perf/perf.c:364:8
    #27 0x55a96a284097 in run_argv tools/perf/perf.c:408:2
    #28 0x55a96a282223 in main tools/perf/perf.c:538:3

  Uninitialized value was stored to memory at
    #1 0x55a96a6a18f7 in dso__new_id tools/perf/util/dso.c:1230:14
    #2 0x55a96a6a78ee in __dsos__addnew_id tools/perf/util/dsos.c:233:20
    #3 0x55a96a6a7bcc in __dsos__findnew_id tools/perf/util/dsos.c:252:21
    #4 0x55a96a6a7a57 in dsos__findnew_id tools/perf/util/dsos.c:259:17
    #5 0x55a96a7776ae in machine__findnew_dso_id tools/perf/util/machine.c:2709:9
    #6 0x55a96a77dfcf in map__new tools/perf/util/map.c:193:10
    #7 0x55a96a77240a in machine__process_mmap2_event tools/perf/util/machine.c:1670:8
    #8 0x55a96a7741a3 in machine__process_event tools/perf/util/machine.c:1882:9
    #9 0x55a96a6aee39 in perf_event__process tools/perf/util/event.c:454:9
    #10 0x55a96a87d633 in perf_tool__process_synth_event tools/perf/util/synthetic-events.c:63:9
    #11 0x55a96a87f131 in perf_event__synthesize_mmap_events tools/perf/util/synthetic-events.c:403:7
    #12 0x55a96a8815d6 in __event__synthesize_thread tools/perf/util/synthetic-events.c:548:9
    #13 0x55a96a882bff in __perf_event__synthesize_threads tools/perf/util/synthetic-events.c:681:3
    #14 0x55a96a881ec2 in perf_event__synthesize_threads tools/perf/util/synthetic-events.c:750:9
    #15 0x55a96a562b26 in synth_all tools/perf/tests/mmap-thread-lookup.c:136:9
    #16 0x55a96a5623b1 in mmap_events tools/perf/tests/mmap-thread-lookup.c:174:8
    #17 0x55a96a561fa0 in test__mmap_thread_lookup tools/perf/tests/mmap-thread-lookup.c:230:2
    #18 0x55a96a52c182 in run_test tools/perf/tests/builtin-test.c:378:9
    #19 0x55a96a52afc1 in test_and_print tools/perf/tests/builtin-test.c:408:9

  Uninitialized value was stored to memory at
    #0 0x55a96a7725af in machine__process_mmap2_event tools/perf/util/machine.c:1646:25
    #1 0x55a96a7741a3 in machine__process_event tools/perf/util/machine.c:1882:9
    #2 0x55a96a6aee39 in perf_event__process tools/perf/util/event.c:454:9
    #3 0x55a96a87d633 in perf_tool__process_synth_event tools/perf/util/synthetic-events.c:63:9
    #4 0x55a96a87f131 in perf_event__synthesize_mmap_events tools/perf/util/synthetic-events.c:403:7
    #5 0x55a96a8815d6 in __event__synthesize_thread tools/perf/util/synthetic-events.c:548:9
    #6 0x55a96a882bff in __perf_event__synthesize_threads tools/perf/util/synthetic-events.c:681:3
    #7 0x55a96a881ec2 in perf_event__synthesize_threads tools/perf/util/synthetic-events.c:750:9
    #8 0x55a96a562b26 in synth_all tools/perf/tests/mmap-thread-lookup.c:136:9
    #9 0x55a96a5623b1 in mmap_events tools/perf/tests/mmap-thread-lookup.c:174:8
    #10 0x55a96a561fa0 in test__mmap_thread_lookup tools/perf/tests/mmap-thread-lookup.c:230:2
    #11 0x55a96a52c182 in run_test tools/perf/tests/builtin-test.c:378:9
    #12 0x55a96a52afc1 in test_and_print tools/perf/tests/builtin-test.c:408:9
    #13 0x55a96a52966e in __cmd_test tools/perf/tests/builtin-test.c:603:4
    #14 0x55a96a52855d in cmd_test tools/perf/tests/builtin-test.c:747:9
    #15 0x55a96a2844d4 in run_builtin tools/perf/perf.c:312:11
    #16 0x55a96a282bd0 in handle_internal_command tools/perf/perf.c:364:8
    #17 0x55a96a284097 in run_argv tools/perf/perf.c:408:2
    #18 0x55a96a282223 in main tools/perf/perf.c:538:3

  Uninitialized value was created by a heap allocation
    #0 0x55a96a22f60d in malloc llvm/llvm-project/compiler-rt/lib/msan/msan_interceptors.cpp:925:3
    #1 0x55a96a882948 in __perf_event__synthesize_threads tools/perf/util/synthetic-events.c:655:15
    #2 0x55a96a881ec2 in perf_event__synthesize_threads tools/perf/util/synthetic-events.c:750:9
    #3 0x55a96a562b26 in synth_all tools/perf/tests/mmap-thread-lookup.c:136:9
    #4 0x55a96a5623b1 in mmap_events tools/perf/tests/mmap-thread-lookup.c:174:8
    #5 0x55a96a561fa0 in test__mmap_thread_lookup tools/perf/tests/mmap-thread-lookup.c:230:2
    #6 0x55a96a52c182 in run_test tools/perf/tests/builtin-test.c:378:9
    #7 0x55a96a52afc1 in test_and_print tools/perf/tests/builtin-test.c:408:9
    #8 0x55a96a52966e in __cmd_test tools/perf/tests/builtin-test.c:603:4
    #9 0x55a96a52855d in cmd_test tools/perf/tests/builtin-test.c:747:9
    #10 0x55a96a2844d4 in run_builtin tools/perf/perf.c:312:11
    #11 0x55a96a282bd0 in handle_internal_command tools/perf/perf.c:364:8
    #12 0x55a96a284097 in run_argv tools/perf/perf.c:408:2
    #13 0x55a96a282223 in main tools/perf/perf.c:538:3

SUMMARY: MemorySanitizer: use-of-uninitialized-value tools/perf/util/dsos.c:23:6 in __dso_id__cmp

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200313053129.131264-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/synthetic-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index dd3e6f4..3f28af3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -345,6 +345,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			continue;
 
 		event->mmap2.ino = (u64)ino;
+		event->mmap2.ino_generation = 0;
 
 		/*
 		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c

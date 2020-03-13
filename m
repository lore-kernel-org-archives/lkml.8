Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66205C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2834020746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcXI39oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCMPuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:50:52 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37315 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:50:52 -0400
Received: by mail-pl1-f201.google.com with SMTP id t12so5750213plo.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eVmA9NNLkJ9r6wHykxZnxklaK4+O9W87gli6+oUvaSc=;
        b=IcXI39oT2ZNkUUgz6GoA6/U6ExT4ULIi8KVYTiAqH4VORWfRY28VcMnVklHfN6GOyf
         I/HYqgXVmIn6VUE3+sHvoaVPe2HqKkwEOS/+ZOYnn2uiERmLgQc8Chwi+Uo4gix+qE+Z
         WVr2uNDLpXTgJZb6KrojURlkR7/ebNNbTiVCFKksRVfwGbD/HGblltprQhYh3ZZK2XEE
         liohZOsIS9TdorAK2ocIcCP+y5Uh/gIq0XXVcCx0HlTz/Y2iBsczRSy8DyLn73eEIJOr
         pWwq549tqptYlnD+XzcDEkzsVZjUO+/nQV1o87KhFmKNIh3G+A3vIZsBG2JZZlI9hjTP
         WMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eVmA9NNLkJ9r6wHykxZnxklaK4+O9W87gli6+oUvaSc=;
        b=ABiZh4W0RazVsEnCpoWGbHZ6Fr22cDkTgO5zIHFD8f9hjFb6mITOCLJxUPkT+SpxcH
         nVLOycoiP2kGQTUG7hrvWFN3KO0IC/7QqWYn3JBZDDF0rmURdftf47B/4WW9k37h6XsN
         D/vHwWvveTcW6eovVneBMA+1mL+kCHsY0P8EpZzjpmsyChDliGGZl6HJjxmwLX4lhqtt
         I3GHdLo88XawJEAKtkJKqzMnNtzxYkQo6iLZoIUhcl/ogTGg/FBKyhhZ1Y+5/STjDHE6
         xgrlbV3gTH+V8gi36xZfOxgoTLLydIW2xzCmRvelEBFQ+OesDFQ2GsQ2okJeHBAEohfY
         tPYA==
X-Gm-Message-State: ANhLgQ3O9cxRS2lIgfsKqY1LH2o8+e214v0Uk6JxHgwtQ8UXtCfWL4wk
        trVLPtt6tuQ0As/Kt+KPEwbMJeOY994t
X-Google-Smtp-Source: ADFU+vuHsce+aXNrgiT0n0TIjSDxGmOcV65WFHFx9JOxVyBmdZdjQ3fIhXUlSi5KBZGuC05rzhDkCaOMAzfu
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr10525477pjb.105.1584114651018;
 Fri, 13 Mar 2020 08:50:51 -0700 (PDT)
Date:   Fri, 13 Mar 2020 08:50:47 -0700
Message-Id: <20200313155047.22339-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2] perf tools: give synthetic mmap events an inode generation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, iri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mmap2 events are synthesized the ino_generation isn't being set
leading to uninitialized memory being compared.
Caught with clang's -fsanitize=memory.

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

v2 fixed a white space issue.

Acked-by: iri Olsa <jolsa@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index dd3e6f43fb86..3f28af39f9c6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -345,6 +345,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			continue;
 
 		event->mmap2.ino = (u64)ino;
+		event->mmap2.ino_generation = 0;
 
 		/*
 		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
-- 
2.25.1.481.gfbce0eb801-goog


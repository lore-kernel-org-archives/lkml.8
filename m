Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B034C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B07520661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqL05V7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBCCHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:07:41 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51171 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCCHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:07:41 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so5602183pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V88riAXlZ3Lt6WD4YILY+go/52mtOZTQuqZNCMK0kYU=;
        b=vqL05V7yQvq4qRC5RXkSwh6yPq8Se34I62mBzvrI3p6MhB+pI+e87Vxv3xXDgKxhU3
         RwgLrBs/IyyU+M7QxYJAH7hbnTuH9ubPf91GJzltl+06elPTA15+MvSMbtPaK/raDPxL
         TfE8yfsGnbYnhCvx34N/DOFuwQ+NWr94y9chnaNkoqcuj2QSc2AMAMXUEoZRn2okfim+
         UVCsim0CH7um58iLa719gOzEkue84HIghDJcXWqmSHkd9p5Dl2prj4GhWAtao9rwcK9a
         ip3YQeEPiYIiDiVI/WIR6JBv9TdfIb4Y6r6ARIMVqALtYo5lGbZZtkcIpxM0aIXoHt+c
         mT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V88riAXlZ3Lt6WD4YILY+go/52mtOZTQuqZNCMK0kYU=;
        b=JnvIAvSWl1hoLgy2VyniMDeNsffge09Jx6NlJdRt6eU6iU9fmI71E2uy2AnlMQaNtK
         UKbf1CidMADG7WGu+AaZ/PPI3pudWMSG2LX7u2z2xPMpekkaRJreq06biZ15+NIR585G
         YaZccM5lSa9pjkRuuQo40DYeVJOSdNhr/WAOy6MbDFk+0OPD4YlmiUXxd4H8KOicxmjN
         ZxFnjSMjFS5F3xUUiXWoEt4dLMNTmvjpQWWrD4VfO4Uva+5GHMfz6vtvkOntXaSLfg0l
         U/tjXDnBoWfikrzFV2ukaC49Z4GuIP4qWOeoAYz86R/NdHRvDDgGFDM7pnNCKRbbmii2
         XXTg==
X-Gm-Message-State: APjAAAUJTfnqJKo720NbepUqzlSfKzrNDOQc65VYnUqNbWrMIAEJVbsX
        P9OLuipCVQLDtUqGCRdG9wh0VA==
X-Google-Smtp-Source: APXvYqxKANzDItRx7KBEyi76Jve2TRT9dCT7shgy2FwK9iO9bQSniDxoOgAkNPPHqn+9gEdxDVkihA==
X-Received: by 2002:a17:90a:da04:: with SMTP id e4mr24960801pjv.26.1580695658796;
        Sun, 02 Feb 2020 18:07:38 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id z29sm17521201pgc.21.2020.02.02.18.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 18:07:38 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/5] perf cs-etm: Support thread stack and callchain
Date:   Mon,  3 Feb 2020 10:07:11 +0800
Message-Id: <20200203020716.31832-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for thread stack and callchain; this is a
sequential version from v3 [1] but reorgnized the patches, some changes
have been refactored into the instruction sample fix patch set [2], and
this patch set is only to focus on thread stack and callchain support.

Patch 01 is to refactor the instruction size calculation; this patch is
used by patch 02.

Patch 02 is to add thread stack support, after applying this patch the
option '-F,+callindent' can be used by perf script tool; patch 03 is to
add branch filter thus the Perf tool can display branch samples only
for function calls and returns after enable the call indentation or call
chain related options.

Patch 04 is to synthesize call chain for the instruction samples.

Patch 05 allows the instruction sample can be handled synchronously with
the thread stack, thus it fixes an error for the callchain generation.

This patch set has been tested on Juno-r2 after applied on perf/core
branch with latest commit 85fc95d75970 ("perf maps: Add missing unlock
to maps__insert() error case"), and this patch set is dependent on the
instruction sample fix patch set [2].


Test for option '-F,+callindent':

Before:

  # perf script -F,+callindent
            main   840          1          branches: main                                 ffffa2319d20 __libc_start_main+0xe0 (/usr/lib/aarch64-linux-gnu/libc-2.28.so)
            main   840          1          branches:                                      aaaab94cb7d0 main+0xc (/root/coresight_test/main)
            main   840          1          branches:                                      aaaab94cb808 main+0x44 (/root/coresight_test/main)
            main   840          1          branches: lib_loop_test@plt                    aaaab94cb7dc main+0x18 (/root/coresight_test/main)
            main   840          1          branches: lib_loop_test@plt                    aaaab94cb67c lib_loop_test@plt+0xc (/root/coresight_test/main)
            main   840          1          branches: _init                                aaaab94cb650 _init+0x30 (/root/coresight_test/main)
            main   840          1          branches: _dl_fixup                            ffffa24a5b44 _dl_runtime_resolve+0x40 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches: _dl_lookup_symbol_x                  ffffa24a0070 _dl_fixup+0xb8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  [...]

After:

  # perf script -F,+callindent
            main   840          1          branches:             main                                                     ffffa2319d20 __libc_start_main+0xe0 (/usr/lib/aarch64-linux-gnu/libc-2.28.so)
            main   840          1          branches:                 lib_loop_test@plt                                    aaaab94cb7dc main+0x18 (/root/coresight_test/main)
            main   840          1          branches:                     _dl_fixup                                        ffffa24a5b44 _dl_runtime_resolve+0x40 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                         _dl_lookup_symbol_x                          ffffa24a0070 _dl_fixup+0xb8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                             do_lookup_x                              ffffa249c4a4 _dl_lookup_symbol_x+0x104 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                 check_match                          ffffa249bbf8 do_lookup_x+0x238 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa249b890 check_match+0x70 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                 printf@plt                                           aaaab94cb7f0 main+0x2c (/root/coresight_test/main)
            main   840          1          branches:                     _dl_fixup                                        ffffa24a5b44 _dl_runtime_resolve+0x40 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                         _dl_lookup_symbol_x                          ffffa24a0070 _dl_fixup+0xb8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                             do_lookup_x                              ffffa249c4a4 _dl_lookup_symbol_x+0x104 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                 _dl_name_match_p                     ffffa249baf8 do_lookup_x+0x138 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa24a17e8 _dl_name_match_p+0x18 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa24a180c _dl_name_match_p+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                 _dl_name_match_p                     ffffa249baf8 do_lookup_x+0x138 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa24a17e8 _dl_name_match_p+0x18 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa24a180c _dl_name_match_p+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                 check_match                          ffffa249bbf8 do_lookup_x+0x238 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa249b890 check_match+0x70 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
            main   840          1          branches:                                     strcmp                           ffffa249b968 check_match+0x148 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  [...]


Test for option '--itrace=g':

Before:

  # perf script --itrace=g16l64i100
            main   840        100      instructions:  ffff8000102642c0 event_sched_in.isra.119+0x140 ([kernel.kallsyms])
            main   840        100      instructions:  ffff800010264794 flexible_sched_in+0xe4 ([kernel.kallsyms])
            main   840        100      instructions:  ffff800010263024 perf_pmu_disable+0x4 ([kernel.kallsyms])
            main   840        100      instructions:  ffff80001026b0e0 perf_swevent_add+0xb8 ([kernel.kallsyms])
            main   840        100      instructions:  ffff80001025b504 calc_timer_values+0x34 ([kernel.kallsyms])
            main   840        100      instructions:  ffff80001019bd24 clocks_calc_mult_shift+0x3c ([kernel.kallsyms])
            main   840        100      instructions:  ffff80001026556c perf_event_update_userpage+0xec ([kernel.kallsyms])
            main   840        100      instructions:  ffff80001025c5e4 visit_groups_merge+0x194 ([kernel.kallsyms])

  [...]

After:

  # perf script --itrace=g16l64i100

  main   840        100      instructions: 
  	ffff800010264794 flexible_sched_in+0xe4 ([kernel.kallsyms])
  	ffff80001025c57c visit_groups_merge+0x12c ([kernel.kallsyms])

  main   840        100      instructions: 
  	ffff800010263024 perf_pmu_disable+0x4 ([kernel.kallsyms])
  	ffff8000102641f0 event_sched_in.isra.119+0x70 ([kernel.kallsyms])
  	ffff8000102643d8 group_sched_in+0x60 ([kernel.kallsyms])
  	ffff8000102647b0 flexible_sched_in+0x100 ([kernel.kallsyms])
  	ffff80001025c57c visit_groups_merge+0x12c ([kernel.kallsyms])

  main   840        100      instructions: 
  	ffff80001026b0e0 perf_swevent_add+0xb8 ([kernel.kallsyms])
  	ffff80001026423c event_sched_in.isra.119+0xbc ([kernel.kallsyms])
  	ffff8000102643d8 group_sched_in+0x60 ([kernel.kallsyms])
  	ffff8000102647b0 flexible_sched_in+0x100 ([kernel.kallsyms])
  	ffff80001025c57c visit_groups_merge+0x12c ([kernel.kallsyms])

  [...]


Changes from v3:
* Splitted out separate patch set for instruction samples fixing.
* Rebased on latest perf/core branch.

Changes from v2:
* Added patch 01 to fix the unsigned variable comparison to zero
  (Suzuki).
* Refined commit logs.

Changes from v1:
* Added comments for task thread handling (Mathieu).
* Split patch 02 into two patches, one is for support thread stack and
  another is for callchain support (Mathieu).
* Added a new patch to support branch filter.

[1] https://lkml.org/lkml/2019/10/5/51
[2] https://lkml.org/lkml/2020/2/2/228


Leo Yan (5):
  perf cs-etm: Refactor instruction size handling
  perf cs-etm: Support thread stack
  perf cs-etm: Support branch filter
  perf cs-etm: Support callchain for instruction sample
  perf cs-etm: Synchronize instruction sample with the thread stack

 tools/perf/util/cs-etm.c | 145 ++++++++++++++++++++++++++++++++-------
 1 file changed, 121 insertions(+), 24 deletions(-)

-- 
2.17.1


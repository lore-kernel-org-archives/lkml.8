Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39EEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD08C20737
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599185259;
	bh=HWyCcYNscEhfeAE1qxEeS41pC6Ur4kOb9rfb8AE47fQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SYQOPQPFC4K2bXii5ZW3Mj9T4EXjvt2s2MceuBqPFGvpizn2ecvXRopuu6csbb/8h
	 pr6zOvM0ctWIhULVvphs0RFRNMKPsycGX2Mz4S1kGtw7veAWzxIyqlcP6G6FPcDHQF
	 ep+zhfLYAFfXPm3XSZiyXShE9ODs60y2ahlPFJfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgIDCHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgIDCHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:07:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD412067C;
        Fri,  4 Sep 2020 02:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599185257;
        bh=HWyCcYNscEhfeAE1qxEeS41pC6Ur4kOb9rfb8AE47fQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qIJPA3dkTv8TV5ZtiXn5PDFZvyQ7gHPk9C9xX4JMJd69ASfIYKrj2fdxL+Vq93u8Z
         aJXpksoJpiyu6rEFLSVgHtIx22S6PMB5DGhKQuEeIE4xVDLC9OuuM8LHdF6bOE/V2+
         VPdzuD+68M2KmHuWfxtUaXAyP3/KWdAZHRB83Cng=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.9: 2nd batch
Date:   Thu,  3 Sep 2020 23:07:28 -0300
Message-Id: <20200904020728.3734002-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Comprehensive test results are available in the signed tag.

The following changes since commit e28f0104343d0c132fa37f479870c9e43355fee4:

  Merge tag 'fixes-2020-09-03' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock (2020-09-03 10:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-03

for you to fetch changes up to 830fadfd954c6782b7a8a2461c76a568c7153b9a:

  perf tools: Add bpf image check to __map__is_kmodule (2020-09-03 16:04:46 -0300)

----------------------------------------------------------------
perf tools fixes for v5.9: 2nd batch

- Use uintptr_t when casting numbers to pointers

- Keep output expected by 3rd parties: Turn off summary for interval
  mode by default.

- BPF is in kernel space, make sure do_validate_kcore_modules() knows
  about that.

- Explicitly call out event modifiers in the documentation.

- Fix jevents() allocation of space for regular expressions.

- Address libtraceevent build warnings on 32-bit arches.

- Fix checking of functions returns using ERR_PTR() in 'perf bench'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf parse-events: Use uintptr_t when casting numbers to pointers

Jin Yao (1):
      perf stat: Turn off summary for interval mode by default

Jiri Olsa (1):
      perf tools: Add bpf image check to __map__is_kmodule

Kim Phillips (1):
      perf record/stat: Explicitly call out event modifiers in the documentation

Namhyung Kim (1):
      perf jevents: Fix suspicious code in fixregex()

Tzvetomir Stoyanov (VMware) (1):
      libtraceevent: Fix build warning on 32-bit arches

YueHaibing (1):
      perf bench: The do_run_multi_threaded() function must use IS_ERR(perf_session__new())

 tools/lib/traceevent/event-parse.c       |  2 +-
 tools/perf/Documentation/perf-record.txt |  4 ++++
 tools/perf/Documentation/perf-stat.txt   |  7 +++++++
 tools/perf/bench/synthesize.c            |  4 ++--
 tools/perf/builtin-stat.c                |  8 +++++---
 tools/perf/pmu-events/jevents.c          |  2 +-
 tools/perf/util/machine.c                |  6 ------
 tools/perf/util/map.c                    | 16 ++++++++++++++++
 tools/perf/util/map.h                    |  9 ++++++++-
 tools/perf/util/parse-events.y           |  8 ++++----
 tools/perf/util/stat.h                   |  1 +
 11 files changed, 49 insertions(+), 18 deletions(-)

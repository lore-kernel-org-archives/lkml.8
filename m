Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52775C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC6206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599000128;
	bh=bkqTCuyjMWUzLsM51EdKuZc5BoXY0AQFfsu8gSayk0w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u67r4KQDQoe7VQZhOSox5D+aPiZmsvSredV5NljtQrYn2x3dTIo8DPB0VzORPEmwA
	 FD2mVgnEyW+WLSdEmmgKduLZyHUN+wvOvRvIXYDVU5JGi19LX20OxdarqeaRAkEXhZ
	 bcFmjx/JElN5SoqgrTYbiigQTFWqKOVwmZVmkyQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIAWmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgIAWmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:42:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 681FB206EF;
        Tue,  1 Sep 2020 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599000123;
        bh=bkqTCuyjMWUzLsM51EdKuZc5BoXY0AQFfsu8gSayk0w=;
        h=From:To:Cc:Subject:Date:From;
        b=zA1pC81fboxqgGk5fAc5E877Y0sVcjKXdT4y4X3Jg7/UgTDuT6GvJ+jEZlJy7FDkH
         BOlz3AvHkKSzlLX6VQF9nF+9L7JaNzzwiTXvM070vxKa/clf3Ot+nBN9+EzjzoY5ku
         UF4+bdvOJGBkWlgL3vZgnt9rA5DpihaDw++3eDrA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <al.grant@arm.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Ahern <dsahern@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Like Xu <like.xu@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.9
Date:   Tue,  1 Sep 2020 19:41:54 -0300
Message-Id: <20200901224154.3436175-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit da2968ff879b9e74688cdc658f646971991d2c56:

  Merge tag 'pci-v5.9-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2020-08-20 14:17:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-01

for you to fetch changes up to 977f739b7126bf98b5202e243f60cbc0a1ec2c3b:

  perf report: Disable ordered_events for raw dump (2020-09-01 12:20:25 -0300)

----------------------------------------------------------------
perf tools fixes for v5.9:

- Fix infinite loop in the TUI for grouped events in 'perf top/record', for
  instance when using "perf top -e '{cycles,instructions,cache-misses}'.

- Fix segfault by skipping side-band event setup if HAVE_LIBBPF_SUPPORT is not set.

- Fix synthesized branch stacks generated from CoreSight ETM trace and Intel PT
  hardware traces.

- Fix error when synthesizing events from ARM SPE hardware trace.

- The SNOOPX and REMOTE offsets in the data_src bitmask in perf records were
  were both 37, SNOOPX is 38, fix it.

- Fix use of CPU list with summary option in 'perf sched timehist'.

- Avoid an uninitialized read when using fake PMUs.

- Set perf_event_attr.exclude_guest=1 for user-space counting.

- Don't order events when doing a 'perf report -D' raw dump of perf.data records.

- Set NULL sentinel in pmu_events table in "Parse and process metrics" 'perf test'

- Fix basic bpf filtering 'perf test' on s390x.

- Fix out of bounds array access in the 'perf stat' print_counters() evlist method.

- Add mwait_idle_with_hints.constprop.0 to the list of idle symbols.

- Use %zd for size_t printf formats on 32-bit.

- Correct the help info of "perf record --no-bpf-event" option.

- Add entries for CoreSight and Arm SPE tooling to MAINTAINERS.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Al Grant (3):
  perf cs-etm: Fix corrupt data after perf inject from
  perf intel-pt: Fix corrupt data after perf inject from
  perf tools: Correct SNOOPX field offset

Arnaldo Carvalho de Melo (2):
  perf symbols: Add mwait_idle_with_hints.constprop.0 to the list of idle symbols
  perf top/report: Fix infinite loop in the TUI for grouped events

Chris Wilson (1):
  perf tools: Use %zd for size_t printf formats on 32-bit

David Ahern (1):
  perf sched timehist: Fix use of CPU list with summary option

Ian Rogers (1):
  perf parse-events: Avoid an uninitialized read when using fake PMUs

Jin Yao (1):
  perf parse-events: Set exclude_guest=1 for user-space counting

Jiri Olsa (1):
  perf report: Disable ordered_events for raw dump

Mathieu Poirier (1):
  MAINTAINERS: Add entries for CoreSight and Arm SPE tooling

Sumanth Korikkar (1):
  perf test: Fix basic bpf filtering test

Thomas Richter (2):
  perf test: Set NULL sentinel in pmu_events table in "Parse and process metrics" test
  perf stat: Fix out of bounds array access in the print_counters() evlist method

Tiezhu Yang (1):
  perf top: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set

Wei Li (2):
  perf: arm-spe: Fix check error when synthesizing events
  perf record: Correct the help info of option "--no-bpf-event"

 MAINTAINERS                                   |  8 ++++-
 tools/include/uapi/linux/perf_event.h         |  2 +-
 tools/perf/builtin-record.c                   |  2 +-
 tools/perf/builtin-report.c                   |  3 ++
 tools/perf/builtin-sched.c                    |  6 +++-
 tools/perf/builtin-top.c                      |  2 ++
 tools/perf/tests/bpf.c                        |  2 +-
 tools/perf/tests/parse-events.c               |  4 +--
 tools/perf/tests/parse-metric.c               |  3 ++
 tools/perf/ui/browsers/hists.c                |  3 +-
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  6 ++--
 tools/perf/util/cs-etm.c                      |  9 +++++-
 tools/perf/util/intel-pt.c                    |  9 +++++-
 tools/perf/util/parse-events.c                | 31 ++++++++++++-------
 tools/perf/util/session.c                     |  2 +-
 tools/perf/util/stat-display.c                |  2 +-
 tools/perf/util/symbol.c                      |  1 +
 tools/perf/util/zstd.c                        |  2 +-
 18 files changed, 69 insertions(+), 28 deletions(-)

-- 
2.26.2


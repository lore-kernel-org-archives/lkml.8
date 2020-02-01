Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F57C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D76B20728
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580544238;
	bh=u87zKsENb5rZ7wyQrXknZa5UH6nRaIzYzVG4Jwp3pvQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iUBLIPAFlBInw8n3ls61HoXApEdMPJe0AyHPvbK7WgVEBOLqiz+t8/2GxPHNJ6ZIE
	 YN8eqQvMeZWFxYvEufbvifkiOmabOXejKalO20qRvDyQuyIZLjbur1W6E3qb7A+S1X
	 UMuD+XbHQxaGGEnhMI9c1RsEQnGjAW8ulPZZJD+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgBAIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:03:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBAIDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:03:40 -0500
Received: from quaco.parlament.guest (catv-212-96-54-169.catv.broadband.hu [212.96.54.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85CBF20679;
        Sat,  1 Feb 2020 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580544219;
        bh=u87zKsENb5rZ7wyQrXknZa5UH6nRaIzYzVG4Jwp3pvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QGKPOF/zsw4FMcToEn9PRTNELfFGFk3TmyfcIhYZ0oCosYosogkiBcMEjfV1RJfr3
         QsNxrp3inMoX+P4BB3ImNYTbbbwF082hRG0QVIdCsQmGFbGOr8jz5n1OqwAMQTZU2M
         iAIYTtpUy+kK33pVcZkVJvuDUT2gB3SqubEgqnAM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Cengiz Can <cengiz@kernel.wtf>,
        Changbin Du <changbin.du@gmail.com>,
        Leo Yan <leo.yan@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes from Budapest
Date:   Sat,  1 Feb 2020 09:03:24 +0100
Message-Id: <20200201080330.13211-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 0cc4bd8f70d1ea2940295f1050508c663fe9eff9:

  Merge branch 'core/kprobes' into perf/core, to pick up fixes (2020-01-28 07:59:05 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200201

for you to fetch changes up to 85fc95d75970ee7dd8e01904e7fb1197c275ba6b:

  perf maps: Add missing unlock to maps__insert() error case (2020-01-31 09:40:50 +0100)

----------------------------------------------------------------
perf/core improvements and fixes:

perf maps:

  Cengiz Can:

  - Add missing unlock to maps__insert() error case.

srcline:

  Changbin Du:

  - Make perf able to build with latest libbfd.

perf parse:

  Leo Yan:

  - Keep copy of string in perf_evsel_config_term() to fix sink terms
    processing in ARM CoreSight.

perf test:

  Thomas Richter:

  - Fix test case Merge cpu map, removing extra reference count drop that
    causes a segfault on s/390.

perf probe:

  Thomas Richter:

  - Add ustring support for perf probe command

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Cengiz Can (1):
      perf maps: Add missing unlock to maps__insert() error case

Changbin Du (1):
      perf: Make perf able to build with latest libbfd

Leo Yan (2):
      perf parse: Refactor 'struct perf_evsel_config_term'
      perf parse: Copy string to perf_evsel_config_term

Thomas Richter (2):
      perf test: Fix test case Merge cpu map
      perf probe: Add ustring support for perf probe command

 tools/perf/arch/arm/util/cs-etm.c |  2 +-
 tools/perf/tests/cpumap.c         |  1 -
 tools/perf/util/evsel.c           |  8 +++--
 tools/perf/util/evsel_config.h    |  5 ++-
 tools/perf/util/map.c             |  1 +
 tools/perf/util/parse-events.c    | 67 ++++++++++++++++++++++++++-------------
 tools/perf/util/probe-finder.c    |  3 +-
 tools/perf/util/srcline.c         | 16 +++++++++-
 8 files changed, 71 insertions(+), 32 deletions(-)

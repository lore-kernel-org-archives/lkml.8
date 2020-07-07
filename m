Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B716220738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594153504;
	bh=DDzwBEGWrLW47pq/nQ9txoZmp3Vt4Jz+CIBmNHANzJA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=znmGH/Bc7n0knB01OhvARZZtHCRyHTf8MGQMeQZ0AudAt2PRPmCB5p7LmQiDGyYSA
	 BnlaVGIz2u1iLM0i9vRO6B6Z01MpVqIgo6uhCIikn/nHv71lue9KBYaQHibmC0nt+Y
	 b5U8S1Tk+/PKb6XVbWSqhMAkGFk3UszjqgyOKZCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGGUZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgGGUZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:25:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292B1206BE;
        Tue,  7 Jul 2020 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594153502;
        bh=DDzwBEGWrLW47pq/nQ9txoZmp3Vt4Jz+CIBmNHANzJA=;
        h=From:To:Cc:Subject:Date:From;
        b=dEHexLZdCFHi2/GOnTJWgeSnQejTKdYLUXYfPkj6pFT+0a3C9Fic8pC+w+kLOoElB
         RsVs0W5lv9/jzSqA7S62Lkgah1fDQw//EPk/3aVXt/WET7W+Z2XeU5vSQFALJVScUy
         s/gL8HllLstLqYU+LsMQ2Mem0iu39H6yt1CX4/5s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Wei Li <liwei391@huawei.com>
Subject: [GIT PULL] Second batch of perf tooling fixes for v5.8
Date:   Tue,  7 Jul 2020 17:24:50 -0300
Message-Id: <20200707202450.23345-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.3
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

The following changes since commit cdd3bb54332f82295ed90cd0c09c78cd0c0ee822:

  Merge tag 'm68knommu-for-v5.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu (2020-07-02 22:56:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-07-07

for you to fetch changes up to bee9ca1c8a237ca178f281062bf162637071ab04:

  perf report TUI: Remove needless 'dummy' event from menu (2020-07-06 09:24:02 -0300)

----------------------------------------------------------------
Second batch of perf tooling fixes for v5.8:

- Intel PT fixes for PEBS-via-PT with registers.

- Fixes for Intel PT python based GUI.

- Avoid duplicated sideband events with Intel PT in system wide tracing.

- Remove needless 'dummy' event from TUI menu, used when synthesizing
  meta data events for pre-existing processes.

- Fix corner case segfault when pressing enter in a screen without
  entries in the TUI for report/top.

- Fixes for time stamp handling in libtraceevent.

- Explicitly set utf-8 encoding in perf flamegraph.

- Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy',
  silencing perf build warning.

Adrian Hunter (9):
      perf scripts python: export-to-postgresql.py: Fix struct.pack() int argument
      perf record: Fix duplicated sideband events with Intel PT system wide tracing
      perf scripts python: exported-sql-viewer.py: Fix unexpanded 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call graph 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix zero id in call tree 'Find' result
      perf scripts python: exported-sql-viewer.py: Fix time chart call tree
      perf intel-pt: Fix recording PEBS-via-PT with registers
      perf intel-pt: Fix displaying PEBS-via-PT with registers
      perf intel-pt: Fix PEBS sample for XMM registers

Andreas Gerstmayr (1):
      perf flamegraph: Explicitly set utf-8 encoding

Arnaldo Carvalho de Melo (3):
      Merge remote-tracking branch 'torvalds/master' into perf/urgent
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
      perf report TUI: Remove needless 'dummy' event from menu

Steven Rostedt (Red Hat) (1):
      tools lib traceevent: Add API to read time information from kbuffer

Tom Zanussi (1):
      tools lib traceevent: Add proper KBUFFER_TYPE_TIME_STAMP handling

Wei Li (1):
      perf report TUI: Fix segmentation fault in perf_evsel__hists_browse()

 tools/arch/x86/lib/memcpy_64.S                    |  4 +++
 tools/lib/traceevent/kbuffer-parse.c              | 43 +++++++++++++++++++----
 tools/lib/traceevent/kbuffer.h                    |  2 ++
 tools/perf/arch/x86/util/intel-pt.c               |  1 +
 tools/perf/builtin-record.c                       | 18 +++++-----
 tools/perf/builtin-script.c                       |  2 +-
 tools/perf/scripts/python/export-to-postgresql.py |  2 +-
 tools/perf/scripts/python/exported-sql-viewer.py  | 11 ++++--
 tools/perf/scripts/python/flamegraph.py           |  8 +++--
 tools/perf/ui/browsers/hists.c                    | 36 +++++++++++++++----
 tools/perf/util/evlist.c                          | 12 +++++++
 tools/perf/util/evlist.h                          |  1 +
 tools/perf/util/evsel.c                           | 12 ++-----
 tools/perf/util/evsel.h                           |  6 ++++
 tools/perf/util/intel-pt.c                        |  5 +--
 15 files changed, 123 insertions(+), 40 deletions(-)

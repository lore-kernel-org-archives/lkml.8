Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5817EC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313FF22201
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588165875;
	bh=6IXkE1cnWFyVqOyK/FQYm2XXLLmRWPsdtD52ivzRHvI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ChwPWYAcKmIOKoYYXOnYOm/jxoieVWqY7voNJPPlS2VGxzLw8OP1nXQR9ykF2T4M+
	 /KwxTvHvczWUahr0ijqWi9GI7oYCABLuTPaVIxOsucr6D0AxTkj8KadJKeUhhUxYSR
	 vV8CKbgUrLyknSIf3FVFB8ngLc3gZLZM3K6mKbrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD2NLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgD2NLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:11:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B532121D93;
        Wed, 29 Apr 2020 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588165873;
        bh=6IXkE1cnWFyVqOyK/FQYm2XXLLmRWPsdtD52ivzRHvI=;
        h=From:To:Cc:Subject:Date:From;
        b=U5MNTIS1/5uYGYDP6VdEHaq37mLdGvPGaPFlkMU9zo3JpChB976KM+CS5ncl5ms8F
         gIOVCbZ9L5yEfXhaL6MqfU0LIJb3LKx7KzeekpxakwuICXoK4FmyTzObzkkJK9sre+
         CQBpC4VKqtqwlZ520uLmtzegt66hCLzij/RnnJ7c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [RFC PATCHSET v2] Implement --switch-output-event
Date:   Wed, 29 Apr 2020 10:10:58 -0300
Message-Id: <20200429131106.27974-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	Please consider reviewing, this addresses comments by Jiri in
the V1.

	Again, the example provided is too simple, using 'perf probe' to
put probes in specific places in some workload to then get any other
event close to the time the trigger hits comes to mind as well, using
the signal was just to reuse the pre-existing logic and keep the
patchkit small.

	One other thing that occurred to me while testing is that this
can be combined with 'perf report/perf script' --switch-off option:

  $ perf report -h --switch-off

  Usage: perf report [<options>]

        --switch-off <event>
                          Stop considering events after the ocurrence of this event

  $

	To remove from consideration the events that end up being
recorded in the ring buffer after the --switch-output-event but gets in
the ring buffer because we process the --switch-output-event
asynchronously.

        Its available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/switch-output-event

Best regards,

- Arnaldo


Arnaldo Carvalho de Melo (8):
  perf record: Move sb_evlist to 'struct record'
  perf top: Move sb_evlist to 'struct perf_top'
  perf bpf: Decouple creating the evlist from adding the SB event
  perf parse-events: Add parse_events_option() variant that creates evlist
  perf evlist: Allow reusing the side band thread for more purposes
  libsubcmd: Introduce OPT_CALLBACK_SET()
  perf record: Introduce --switch-output-event
  perf record: Move side band evlist setup to separate routine

 tools/lib/subcmd/parse-options.h         |  2 +
 tools/perf/Documentation/perf-record.txt | 13 ++++
 tools/perf/builtin-record.c              | 75 ++++++++++++++++++++----
 tools/perf/builtin-top.c                 | 20 +++++--
 tools/perf/util/bpf-event.c              |  3 +-
 tools/perf/util/bpf-event.h              |  7 +--
 tools/perf/util/evlist.c                 | 39 +++++++-----
 tools/perf/util/evlist.h                 |  3 +-
 tools/perf/util/parse-events.c           | 23 ++++++++
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/top.h                    |  2 +-
 11 files changed, 151 insertions(+), 37 deletions(-)

-- 
2.21.1


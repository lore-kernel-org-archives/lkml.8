Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBBFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99682075A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596620123;
	bh=MdD6GLM7pG6oDTWaHyVsdLoWqBileE4ms1FSvKZgeWQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FwDA8JyusQidMwHBcs8DLi72EGSiuJI94yxLjJqIhiAONPErJMS37Mwz8/+lZLTSf
	 ElKpKtlyrcKRZSTUwIEOHvk9x4rKQFvXTblhJ7sJU+0Le59/3F/nOxuc2SdwUjijrY
	 geQjRUwzdNDmpFemiNnoomwOsxj2Kk7F1POdZwyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHEJfT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:35:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgHEJe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:34:57 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-A6PLiuaHO56Nis-bj6FLOw-1; Wed, 05 Aug 2020 05:34:52 -0400
X-MC-Unique: A6PLiuaHO56Nis-bj6FLOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C9E418C63C1;
        Wed,  5 Aug 2020 09:34:50 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E70E7193A;
        Wed,  5 Aug 2020 09:34:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH v2 0/7] perf tools: Add wallclock time conversion support
Date:   Wed,  5 Aug 2020 11:34:37 +0200
Message-Id: <20200805093444.314999-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset is based on changes made by David Ahern long time ago.
The perf code moved a lot since then, but the idea is the same.

The patchset is adding the ability to display TOD/wallclock timestamp
in 'perf script' output and in 'perf data convert --to-ctf' subcommand,
so the converted CTF data contain TOD/wallclock timestamps.

It's done by adding new header FEATURE 'CLOCK_DATA' to perf.data, that
stores reference times for both TOD/wallclock time and for the clock that
perf record is configured to use. These reference times are then used to
convert sample's timestamps to TOD/wallclock timestamps.

The feature is available only for recording with clockid specified,
because it's the only case where we can get reference time to TOD/wallclock
time. We can't do that with perf clock yet.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/abs_time

v2 changes:
  - fixed HEADER_CLOCK_DATA doc, typo, print format [Namhyung]
  - moved clockid related code into separate object [Andi]

thanks,
jirka


---
Jiri Olsa (7):
      perf tools: Move parse_clockid into clockid object
      perf tools: Add clockid_name function
      perf tools: Store clock references for -k/--clockid option
      perf tools: Move clockid_res_ns under clock struct
      perf tools: Add support to store time of day in CTF data conversion
      perf script: Change enum perf_output_field values to be 64 bits
      perf script: Add tod field to display time of day

 tools/perf/Documentation/perf-data.txt             |   3 ++
 tools/perf/Documentation/perf.data-file-format.txt |  13 +++++++
 tools/perf/builtin-data.c                          |   1 +
 tools/perf/builtin-record.c                        | 145 +++++++++++++++++++++++---------------------------------------------------
 tools/perf/builtin-script.c                        | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 tools/perf/util/Build                              |   1 +
 tools/perf/util/clockid.c                          | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/clockid.h                          |  11 ++++++
 tools/perf/util/data-convert-bt.c                  |  57 ++++++++++++++++++-----------
 tools/perf/util/data-convert.h                     |   1 +
 tools/perf/util/env.h                              |  14 +++++++-
 tools/perf/util/header.c                           | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/header.h                           |   1 +
 13 files changed, 492 insertions(+), 190 deletions(-)
 create mode 100644 tools/perf/util/clockid.c
 create mode 100644 tools/perf/util/clockid.h


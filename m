Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E341C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D422721582
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599540165;
	bh=vL/EL9ebYCG53fhuBlrAWUrGNhVRl9P0xEjcC9wiB80=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ulV72yuPfvMrXiE0aS+ddo7cZOm8pTJzUi0vp1AX1NuxRWBuw/p2BF27lBNyJuRJ7
	 31Jvbz+EXuKsRfLD8ch+mSAz60roXiNw75VAw8dRavWs8fCDNF7URAvvaoVFG2e79a
	 PeZ9KL6niNdZHJuMsL1JHQVDqXkmEYuBws1hA16w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgIHEmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgIHEmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:42:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF1C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:42:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c142so9909820pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4gdL8pqvo4jo9ucAoXnblDNUDcsJ7ePdXxrWQwtpEBQ=;
        b=VXtCNwLE1D9n/1PFQXm5o/iOEJP2ppecvPHa3nN3hyNiBhh5sHJ49uaeLl9gV3QlXM
         YZmdywOWGITiaXbDSM0jpvOyelGN2GemD6vMrAcCPc5kF7sqXx5b/2d0iTzjKHNk9vpQ
         jbcTLrlLQ+g3pHOaLu0xG2ceXamBz4NqpDBT211ACQBJkNbFxFYD7MoYDrwrdqNq0+St
         DvQ4JdtkKjdYD6VUN2JJHfVfCmy13BxzEczmR/yCTUyp2q0W4cW3Kiaobawhw6cDbJ2V
         QQbLrR3qqIzLpRuUMp+P2JtgOPEJVmPT4HkSf/gz1q40Q2YnRjaw6FIvw+TL0gTAdJGD
         2N+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4gdL8pqvo4jo9ucAoXnblDNUDcsJ7ePdXxrWQwtpEBQ=;
        b=WHZyJZihd4HxBxJo364ZMV+gKvJ4fD0tpk3hsFbz399EvyQ+Iqx/aeHl2gzGS7lD83
         MW/kUnJI8Q2TdcDUlWSD32QWbp5DW6kA5TyxXSu9OQ3/zSM7TD0gCV8+/b+iKWTSnx+W
         eMn9uHl9NB3tWYDr0+7oAEDJ3PAzd7Yi8CRB2SeSV2cotU3w0pcvQ+RfPY2GfV9C1who
         YvTecuHylfM92NSdskyFzZClTcxFsPXTnhcOFhx7FOA5MQ/qCnjm+g+MGooBdTQ7tGKv
         av4mtD0t/n/mgwcCVN3jEg8I11CC+Fc1t/U0tEGMZNZBZZYRVl3U2hXY/zEPK/FLLntb
         eEuw==
X-Gm-Message-State: AOAM532YY9Pvoe8GzskpUlkWnN8+hqVU+eglCX9dJ4T28ryg7utgrxQV
        XE4+L68qaYlPfLOmEp3HCUE=
X-Google-Smtp-Source: ABdhPJy4DKPraj3SlfZ/Uiq7loaccP4UAIZ7D1nRqUIlTUiMHSs8tWFLqgilT6qa1j4sI2sD9FkPew==
X-Received: by 2002:a63:4965:: with SMTP id y37mr19473180pgk.349.1599540154263;
        Mon, 07 Sep 2020 21:42:34 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q5sm16777625pfn.109.2020.09.07.21.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:42:33 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
Date:   Tue,  8 Sep 2020 13:42:24 +0900
Message-Id: <20200908044228.61197-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When we profile cgroup events with perf stat, it's very annoying to
specify events and cgroups on the command line as it requires the
mapping between events and cgroups.  (Note that perf record can use
cgroup sampling but it's not usable for perf stat).

I guess most cases we just want to use a same set of events (N) for
all cgroups (M), but we need to specify NxM events and NxM cgroups.
This is not good especially when profiling large number of cgroups:
say M=200.

So I added --multiply-cgroup option to make it easy for that case.  It
will create NxM events from N events and M cgroups.  One more upside
is that it can handle metrics too.

For example, the following example measures IPC metric for 3 cgroups

  $ cat perf-multi-cgrp.sh
  #!/bin/sh
  
  METRIC=${1:-IPC}
  CGROUP_DIR=/sys/fs/cgroup/perf_event
  
  sudo mkdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C
  
  # add backgroupd workload for each cgroup
  echo $$ | sudo tee $CGROUP_DIR/A/cgroup.procs > /dev/null
  yes > /dev/null &
  echo $$ | sudo tee $CGROUP_DIR/B/cgroup.procs > /dev/null
  yes > /dev/null &
  echo $$ | sudo tee $CGROUP_DIR/C/cgroup.procs > /dev/null
  yes > /dev/null &

  # run 'perf stat' in the root cgroup
  echo $$ | sudo tee $CGROUP_DIR/cgroup.procs > /dev/null
  perf stat -a -M $METRIC --multiply-cgroup -G A,B,C sleep 1
  
  kill %1 %2 %3
  sudo rmdir $CGROUP_DIR/A $CGROUP_DIR/B $CGROUP_DIR/C

  
  $ ./perf-multi-cgrp.sh IPC
  
   Performance counter stats for 'system wide':
  
      11,284,850,010      inst_retired.any          A #     2.71 IPC                    
       4,157,915,982      cpu_clk_unhalted.thread   A                                   
      11,342,188,640      inst_retired.any          B #     2.72 IPC                    
       4,173,014,732      cpu_clk_unhalted.thread   B                                   
      11,135,863,604      inst_retired.any          C #     2.67 IPC                    
       4,171,375,184      cpu_clk_unhalted.thread   C                                   
  
         1.011948803 seconds time elapsed


The code is available at 'perf/cgroup-multiply-v1' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks
Namhyung


Namhyung Kim (4):
  perf evsel: Add evsel__clone() function
  perf stat: Add --multiply-cgroup option
  perf tools: Copy metric events properly when multiply cgroups
  perf test: Add multiply cgroup event test

 tools/perf/builtin-stat.c          |  21 ++-
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   4 +
 tools/perf/tests/multiply-cgroup.c | 203 +++++++++++++++++++++++++++++
 tools/perf/tests/tests.h           |   1 +
 tools/perf/util/cgroup.c           | 106 ++++++++++++++-
 tools/perf/util/cgroup.h           |   4 +
 tools/perf/util/evlist.c           |  11 ++
 tools/perf/util/evlist.h           |   1 +
 tools/perf/util/evsel.c            |  57 ++++++++
 tools/perf/util/evsel.h            |   1 +
 tools/perf/util/metricgroup.c      |  77 +++++++++++
 tools/perf/util/metricgroup.h      |   6 +
 tools/perf/util/stat.h             |   1 +
 14 files changed, 488 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/tests/multiply-cgroup.c

-- 
2.28.0.526.ge36021eeef-goog


Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18547C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF58620DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599450321;
	bh=HU1eJ+AGsC9I9kppvDCtVYnTZacnRIKs3fadw2ZGRPY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DZXIu0f3PNF3qhnJlgk30hTF5J8P7V6CChm770V9ibFKFN7otYURh8NClH0mdQqlE
	 WiskafLBWr2Gzw3OqmXtRWKKQH9A3qzrSCqgsmqbY3MG2K7o2AO/8fnqBFBJCYNR3G
	 wkijfW/x1JPEFbNZa34J0BPKLo8c0fgXrk+UetS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIGDpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGDpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:45:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83955C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 20:45:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so7925871pfg.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMz+YuQ73Vh1ZDuBEz+vPvn5ONCfDFnCqtdgjqi8M0M=;
        b=XYHihCBaGxZAOrBBSWhkpy+4S9vswK/RThG4BeGSyN4UJwWH5MgKTans5GKUw24MpM
         CbNrYDRm35Hjp3JVj56Egtq4NDEYJKambyRoJSNfXy6axh6ymdwvmzaMQ7zAEj1jYHqy
         RQueNkJsvw5jWWjiGrhXki1QYntt6o2h6TxefknP97zD201Xan+p40ap1y3GHXLzzqdk
         Zp9GX6Jk7LV2bwPvvN1XKhi0vd6FIB7qch2lpXlAPtQLR9CqXvZ4ifB0dC2FbKO0ow4u
         qCG0XkoJNw+i5Ubcx5iBvavKdlqrMqyds2+OVFa/vJN9bBJ2DU6r+ofGPK3HETZnFVy1
         AGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aMz+YuQ73Vh1ZDuBEz+vPvn5ONCfDFnCqtdgjqi8M0M=;
        b=U3WPBDEZnziqcKTUBta+mSrJoseIPVxWFoVEOm3mx1K+3uverauXTpKT9y/keTxAyT
         6MOBAOBbReM32qlDuBu9gdeswSYe7LDKg19Pr6hKcInGzjaUQkF/zXqmv1gWgsqB52op
         BOWwneCqeJAOE1oqGn0oM+W/yM6iRmiVKI5/9PoFntiy7nAbaMngqV6FDUFPjIZMs9pA
         f9G3t3arnI03V9TTXqOODsWUZ8MMtnQliISKT5MXDZPJTuNWF8aUafFyJojdMvNdTngg
         0+ZtcgAmH3x7Nf8ueM4s5iaat6xdwXiKV2eVlbfdNjuUhSlvDfHzKT5GAjedHvOAShzp
         vXPg==
X-Gm-Message-State: AOAM530zAkdiQZdpRZsbdY7FtJxlEFzq89ezPOp4JqgXIxw+QQsCr6xj
        v2pkBU+Fxb747HDhOGTr2yM=
X-Google-Smtp-Source: ABdhPJxrQOUJm+E3o1JD4Q0WgUcDvuHvUckrES8rurIKfRkwtoZTj3s67Cs72f2nlUiv2oR2Ih5GGA==
X-Received: by 2002:a62:5b47:: with SMTP id p68mr18988654pfb.255.1599450312667;
        Sun, 06 Sep 2020 20:45:12 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id l123sm11099672pgl.24.2020.09.06.20.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:45:11 -0700 (PDT)
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
Subject: [PATCHSET 0/9] perf tools: Fix various memory leaks
Date:   Mon,  7 Sep 2020 12:44:53 +0900
Message-Id: <20200907034502.753230-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found and fixed a bunch of memory leaks during perf pmu and
metric tests with address sanitizer.  Before this, the tests were
mostly failed due to the leaks since ASAN makes it return non-zero.

Now I'm seeing no error with ASAN like below:

  $ ./perf test pmu metric
   9: Parse perf pmu format                                 : Ok
  10: PMU events                                            :
  10.1: PMU event table sanity                              : Ok
  10.2: PMU event map aliases                               : Ok
  10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
  10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
  67: Parse and process metrics                             : Ok

The failure in 10.3 seems due to parse errors like below:

  Multiple errors dropping message: unknown term 'filter_opc' for pmu 'uncore_cbox_0'
  (valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
                branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
		nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size)


  Parse event failed metric 'DRAM_Parallel_Reads' id 'arb/event=0x80,umask=0x2,thresh=1/'
    expr 'arb@event\=0x80\,umask\=0x2@ / arb@event\=0x80\,umask\=0x2\,thresh\=1@'
  Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help
    'valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
                  branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
		  nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'


The patches are also available at 'perf/metric-fix-v1' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks
Namhyung


Namhyung Kim (9):
  perf evlist: Fix cpu/thread map leak
  perf parse-event: Fix cpu map leaks
  perf parse-event: Fix memory leak in evsel->unit
  perf test: Fix memory leaks in parse-metric test
  perf metric: Release expr_parse_ctx after testing
  perf metric: Free metric when it failed to resolve
  perf metric: Do not free metric when failed to resolve
  perf test: Free aliases for PMU event map aliases test
  perf test: Free formats for perf pmu parse test

 tools/perf/tests/parse-metric.c | 14 +++++++++-----
 tools/perf/tests/pmu-events.c   |  5 +++++
 tools/perf/tests/pmu.c          |  1 +
 tools/perf/util/evlist.c        | 11 ++++++++---
 tools/perf/util/metricgroup.c   | 26 ++++++++++++++++++--------
 tools/perf/util/parse-events.c  |  9 +++++++--
 tools/perf/util/pmu.c           | 13 ++++++++++++-
 tools/perf/util/pmu.h           |  2 ++
 tools/perf/util/stat-shadow.c   |  8 +++++---
 9 files changed, 67 insertions(+), 22 deletions(-)

-- 
2.28.0.526.ge36021eeef-goog


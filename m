Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4295DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D5820814
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kz975543"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFJVvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgFJVvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0318DC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f16so4078020ybp.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rWF/ki1/Yh6gHIVywi4l8h1I3LPzmZjQym2kiDmagOU=;
        b=Kz975543C6Q/egJ+6V6244sjdLgzr8Mo//mkbKXG2BMHVPomlKBPc1o5vkFLbpJ0TQ
         EnCra+KPjGVscR5o4IKn3MqLXKPpDsY871REMqmq9JWPKwT4dLZ0ynPfg1PQkdPb1mi3
         gDvBaX+m+UZGbrkk+Ij5tS7Gj+MKEmJd09mtQj62qkuh21ma9FJSsloiJbO3iGSJGuki
         Wu6/NwpV1kbGU4IT2fZvOEJ1edEyEV/c2+9uuioTvdHznra3TI12fDcluvKu4ahyqXja
         YIZympQAGGI4lYRoaLcW04dv/aAG3O1TjkEk+ia5IDv/3o6F+vuiIoYaNoTOqW0S5HZ6
         yLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rWF/ki1/Yh6gHIVywi4l8h1I3LPzmZjQym2kiDmagOU=;
        b=A4+kFPxXzYVY7OvJqkWaSTL2bPigzHwa3wp+i1+guGagVfrJaHVhicOfn14tBuoARR
         cebp2YNDLI6vKkNKge+GOBYenFqckMarevTSLM4Z/Dr8twvrcgw6qKFmZDjXqJdyMR7h
         XNo9FGQQymiiepp9UEINgu+hUWBquU+CaKAZkbHMmRNh/VPVIlqzq5DRJjeoyG0VBy7e
         EO9iDysW+LTtVGmwabcI3Fe7grFtOozLiLZxo6TLOzSwbkpiGr7KHUTEldgMaB7Atvjr
         PRJgcZDgyjvUugcZ6speUOUg7gzGV8T+hqRX6SO8RvpDaYX8sLqaCfhYN+Cmdff4zqJL
         51pw==
X-Gm-Message-State: AOAM533KwY3M8wJ21e2QDY4P3IRzM9cyhz+s9gnIjcwPHwhgUV90ComA
        liTeJ3RjPQdBHzBn+v7/H90lZxK28Z7c
X-Google-Smtp-Source: ABdhPJx4chO/ehT1h76uyuUdiuC72KQgiCHLrDnmR2Nc+ebOQhx7pV9tjE/kEHxsnSly+aDSnLYEXzaLTJRJ
X-Received: by 2002:a25:2d4c:: with SMTP id s12mr8322618ybe.307.1591825864204;
 Wed, 10 Jun 2020 14:51:04 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:50 -0700
Message-Id: <20200610215100.256599-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 00/10] perf parse-events: enable more flex/bison warnings
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All C compiler warnings are disabled are disabled by -w. This change
removes the -w from flex and bison targets. To avoid implicit
declarations header files are declared as targets and included.

Tested with GCC 9.3.0 and clang 9.0.1.

Previously posted as a single change:
https://lore.kernel.org/lkml/20200609234344.3795-2-irogers@google.com/

Ian Rogers (10):
  perf parse-events: Use automatic variable for flex input
  perf parse-events: Use automatic variable for yacc input
  perf pmu: Add bison debug build flag
  perf pmu: Add flex debug build flag
  perf parse-events: Declare flex header file output
  perf parse-events: Declare bison header file output
  perf parse-events: Disable a subset of flex warnings
  perf expr: Avoid implicit lex function declaration
  perf parse-events: Avoid implicit lex function declaration
  perf parse-events: Disable a subset of bison warnings

 tools/perf/util/Build          | 50 +++++++++++++++++++++-------------
 tools/perf/util/expr.y         |  2 ++
 tools/perf/util/parse-events.y |  1 +
 3 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog


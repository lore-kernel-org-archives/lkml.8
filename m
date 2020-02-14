Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D8FC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DB1222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWy5pftW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgBNHvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:51:43 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33298 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgBNHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:51:43 -0500
Received: by mail-pf1-f202.google.com with SMTP id c72so5552740pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P2ddlz4vcpm8e/XY4uvfV3+XXJSEm7XHa2CWjKYr5uA=;
        b=LWy5pftWbZouqiZvVeFPkzLj8E5uTkNvc2o8pJ+kIgFPe3qV6t/5k8T7UWuJweWafz
         p/N1E/DTcukn54ajYtkJzc/fcI92gU9rDUJlcBAIZ1otBsq/z5pJFn+8TfPv7ZFWtuhX
         7Ufz7X//shoFKAARtKMKyDfyxEJXamB9dDLO6Yu2/+6cgyrUh5TljJFZgFYl/eIndX4w
         jbtFAhe02pUhaD9FHgBfeZ3jJ7MAJ6FmmDl8MSXiqRZJ0+zM64iknkpYwe3iMPjAtvGa
         3dDSK8C3Skw/pLWcZIOcozDxlo2vUpTx7sOLORLLzESa2YRHCHRu+wPLGSIMQ0CbWQ8v
         v3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P2ddlz4vcpm8e/XY4uvfV3+XXJSEm7XHa2CWjKYr5uA=;
        b=RIHsxhPiUKPHr7bp4CNRlvPS9f9e2Z+0dWq0ceCdy9PR6tnThjQM4hG4nj11ze5MP4
         KdiYmxOf1IBWVOp9kbLdl6yYLXXlgpUgUYyMxT4K6mvwlJTgVZuHHl5iHvPW2N99C6U/
         YXuHG446snJc1D8FcoC63IzwvCHNU8quicyHV0BGT0+auuLA1AufwV5ZhHO13RAnZ+OX
         ofDbbrNGaT1PsOAUAb6yeqcVLxHSojwbM/sDRtV/aYOs0Ki4jGsyXqsyDGQOfDH68IhG
         vptXuAyjkUYWRoPC76kiBUdoDOdn7duO644oLoFZSRoXlk8lGj2a+RPn0pzJZqX4ssK8
         UMDg==
X-Gm-Message-State: APjAAAWtV88eEy5PX9kFzzNnRzaysVp/jMfEwad9sJEgbCgmk004Rf0R
        e+Puyz/Ynnb1Co7hozyWfVH8BAhHTf5i
X-Google-Smtp-Source: APXvYqxXZi/i4B5/NMV5/6EoDBbn2j9P1qdXVs14UD0/b3ZgJMvD0sYIewn+xCTfCrKHeK7YA0QCCZi90Q2s
X-Received: by 2002:a63:455c:: with SMTP id u28mr2166242pgk.163.1581666701115;
 Thu, 13 Feb 2020 23:51:41 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:51:27 -0800
In-Reply-To: <20191206231539.227585-1-irogers@google.com>
Message-Id: <20200214075133.181299-1-irogers@google.com>
Mime-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 0/6] Optimize cgroup context switch
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid iterating over all per-CPU events during cgroup changing context
switches by organizing events by cgroup.

To make an efficient set of iterators, introduce a min max heap
utility with test.

The v6 patch reduces the patch set by 4 patches, it updates the cgroup
id and fixes part of the min_heap rename from v5.

The v5 patch set renames min_max_heap to min_heap as suggested by
Peter Zijlstra, it also addresses comments around preferring
__always_inline over inline.

The v4 patch set addresses review comments on the v3 patch set by
Peter Zijlstra.

These patches include a caching algorithm to improve the search for
the first event in a group by Kan Liang <kan.liang@linux.intel.com> as
well as rebasing hit "optimize event_filter_match during sched_in"
from https://lkml.org/lkml/2019/8/7/771.

The v2 patch set was modified by Peter Zijlstra in his perf/cgroup
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git

These patches follow Peter's reorganization and his fixes to the
perf_cpu_context min_heap storage code.

Ian Rogers (5):
  lib: introduce generic min-heap
  perf: Use min_heap in visit_groups_merge
  perf: Add per perf_cpu_context min_heap storage
  perf/cgroup: Grow per perf_cpu_context heap storage
  perf/cgroup: Order events in RB tree by cgroup id

Peter Zijlstra (1):
  perf/cgroup: Reorder perf_cgroup_connect()

 include/linux/min_heap.h   | 135 ++++++++++++++++++++
 include/linux/perf_event.h |   7 ++
 kernel/events/core.c       | 251 +++++++++++++++++++++++++++++++------
 lib/Kconfig.debug          |  10 ++
 lib/Makefile               |   1 +
 lib/test_min_heap.c        | 194 ++++++++++++++++++++++++++++
 6 files changed, 563 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/min_heap.h
 create mode 100644 lib/test_min_heap.c

-- 
2.25.0.265.gbab2e86ba0-goog


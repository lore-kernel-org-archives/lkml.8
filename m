Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7895EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E97C206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3VP8k4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgEEOge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729123AbgEEOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:36:33 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF108C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:36:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p126so2391985qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5trITduqG/di69OK0dgCDcPnGo1iO9CCaWPAdq228EU=;
        b=c3VP8k4/uhRBDhx3iVEfo7rtVKO9GDG6Whny4vpHB6h935C9/hPvNgvHM48R2kXFAy
         28ft+RcgXi+hvOCbKWPJDzoVlW2eoThk4VUxO/uRWAhO4iMuHwnzsmmC7aVmaECIUaqB
         MA7KfZOiXhNCLsP8dApP6Iz38SYTn2SFbvOA0SIO/ppFPeIWLOkH6axELTM8c0sHbBF2
         QWw/V5s44uNkOD7GvpGUXX1zbTEyb9elWYBjXUr6+cWM7xfXSMtr0TTPJzjEcPxLBvIg
         TMuvVqfxE5isu/iY22ZMYWA7+VhQ7K5ytFLrQb7RGNH/BNsjXXz3EQtU6/FBHSgW1BOB
         tFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5trITduqG/di69OK0dgCDcPnGo1iO9CCaWPAdq228EU=;
        b=POCsT4KrTzm8Ir60OkXWDR+04I0bdnJ+kgGAXRLMSQfTb7ZFDSA8epTrGwP/iweSaJ
         u2SuXmRn7j+/ZYmwrs5PsDliht0BH/K5pQ51nOO/W5JGObg3ou8z62svkYvU79LPwO5/
         sFW7Pd+OSSxoFoH1IJQtRgm1WJtTooPyI9yqsH5hWuJ/XLBqRyswEfIkQ6QBstYHqjII
         iDddPkklDALFEbexs872ghg5erDiPyNrMvtQ9zDCdJ/3w8rZRXuNg63GldKik4JnotK6
         8DTCPslLb1XP+TPx/LsQl7u5ZgLpOMaNvmDhR70YUt7pHDlIIQiaUjZR/cYr1wjyGk0r
         Hg2A==
X-Gm-Message-State: AGi0PubgyTdRl23znCXo2GWbbYwi4nvVQrlQtjIFuZqlrTq0TTUdV75p
        gWPisT8mr8qGPcVV0yF+RhMf1MR5hhw+
X-Google-Smtp-Source: APiQypJHn7Wy58w1uH+n3zL+bsl+o+il8hPGJj3MnOWioq0E5jH7SG/Hhkq0YeHpqlmBVMr9O/1X64VtM/q4
X-Received: by 2002:a05:6214:a14:: with SMTP id dw20mr3002885qvb.179.1588689390868;
 Tue, 05 May 2020 07:36:30 -0700 (PDT)
Date:   Tue,  5 May 2020 07:36:22 -0700
Message-Id: <20200505143625.147832-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v3 0/3] Improvements for kallsyms__parse
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms__parse is called 4 times during perf record startup. Add a
benchmark to measure its performance. Transition it to using the api
io.h buffered reading, improving performance by ~8% or saving ~5% from
perf record start up time.

v3. Fixed a link error report in hex2u64 by jolsa@redhat.com.
v2. Fix the err return value for success, error reported by
    jolsa@redhat.com. Add clean-up for hex2u64.

Ian Rogers (3):
  perf bench: add kallsyms parsing
  lib kallsyms: parse using io api
  lib kallsyms: move hex2u64 out of header

 tools/lib/api/io.h                |  3 ++
 tools/lib/symbol/kallsyms.c       | 86 ++++++++++++++-----------------
 tools/lib/symbol/kallsyms.h       |  2 -
 tools/perf/bench/Build            |  1 +
 tools/perf/bench/bench.h          |  1 +
 tools/perf/bench/kallsyms-parse.c | 75 +++++++++++++++++++++++++++
 tools/perf/builtin-bench.c        |  1 +
 tools/perf/util/symbol.c          | 14 +++++
 8 files changed, 133 insertions(+), 50 deletions(-)
 create mode 100644 tools/perf/bench/kallsyms-parse.c

-- 
2.26.2.526.g744177e7f7-goog


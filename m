Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF7C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FD020857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bokqg+Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgEAWNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAWNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:13:24 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49047C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:13:23 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z8so12760568qtu.17
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RIdqLo4hWktII2qSFS69re2nqOxlcy+LfC6phzkurHk=;
        b=bokqg+DsarAeVPBsSKl17lQurhmELauRlNI4mCvsFHssdHcA5IeqmZHW2PwSy9K908
         3cAeNUTy50uwaMgkELxPkc4JIwzGi4yY9s2MhziY70uMjyKJ8Ylj1NvCrSOiFaRKG0xZ
         Vtg3QuXa29jJJ+W7JE1LAdSjtE8H5VvvQmAKQramx/gggdX1xrp89nxKYapu9t6boTcZ
         RJjYFWctuJ2uH7ancq6EfnJO/v6uBTkg89+fBk6PuwImjRDWL86MWQ9bd77/pJzw6Qwg
         cIdtfc3gxYk6pA2aXc/T2Rm7SIJO7F1sjn0+uCbxMGG/Wi+guwZR/wtV3eILSi5xof4o
         G6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RIdqLo4hWktII2qSFS69re2nqOxlcy+LfC6phzkurHk=;
        b=FbWWuOs429QFkbY6GiQd2KaYRsTMRgU4ze86Y4OirhT/SrCpoqAmCWeI5eh68/Gf5m
         Sii/rAzH1XvbEIJwWOmFsICfkbgSccxomMqKUy/Z7l3aK+aQ5svR9FDXfY27+AMvmxRj
         /QFAQ2lNvTzvUGPz+QFyRkyTfJRaE1M6pvvJRlWPdByJYZ7E4kq0L/xVyOK1X65mFdxR
         E/0/doPiLNLA4uR/ScArb1QPNy18nuO3F//fAefZy6l8E/i2lnigqvlD/+ZoPcZDaiJA
         +FOTlOKOnSPsPjq1XHxcDXQQZh5386S473VUmXMAZvpvGEn7TSWQYRcY0fHTjuQJcRAx
         n25Q==
X-Gm-Message-State: AGi0PuYk8gYGvPABXlA8wZpLGSGSK0aBOi3UEIfhkbQj3kkydrGaqGRl
        71wCWCX6O8v/1sv8RSXCcDiE9X5kaFU0
X-Google-Smtp-Source: APiQypJneQQy38v7CDdf0Z5G+T3sLqrun5IvJPxLPJgRv0c988eUeVYa3tmXI7ZI0PohhrpIMuuEbXhigb3J
X-Received: by 2002:a05:6214:414:: with SMTP id z20mr5989856qvx.242.1588371202432;
 Fri, 01 May 2020 15:13:22 -0700 (PDT)
Date:   Fri,  1 May 2020 15:13:12 -0700
Message-Id: <20200501221315.54715-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 0/3] Improvements for kallsyms__parse
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


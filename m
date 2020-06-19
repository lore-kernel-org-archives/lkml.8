Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8ADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C18208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMqhRWjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgFSEeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFSEeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A65C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f16so8832493ybp.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e2t+AoMy42UgEac1mGamDid+gk4pQU3+zHHVv6633Lc=;
        b=mMqhRWjqPFI2wvsFTWF2FBun6wzbMqZxKb8vJkrmTgmKcqdy2irWp7gIb/Fog506l/
         pu9yC6LheRJr+eLBGptwB/KOI2Zo+DnDcqs0/636xvY0Vs/rocQU8i+nIuPBETEBfYuy
         rBl3binV7ALiUJPyJJLM+Ekkj5UHe1Ziam1VY27XOg43qPVOSTorXUYQYbWm+CKp5PsO
         anodD6Q4TtLN3b1pFxbrHpluaMSEglrIBuQRywQtIuWPc3hbS5HZ4YYcA9o34MkLyuhQ
         djdy1MdGyXxQ7yAIfpMW8M7ufuRRGayz61yCH7xwj9LeeZ6ycmn2DCm5idCWBKj6YVVZ
         CtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e2t+AoMy42UgEac1mGamDid+gk4pQU3+zHHVv6633Lc=;
        b=ugEl5ZW+bdXcwbbMKoyCQP4y4Efu3zw2gsjoxts9nysgMi+dwtHxL3nODkccZz5Bsp
         31Cl2pjBO0660APoQ3+Ngip7n+2uv0JiRK4gH9P6x9vmHP6r7P1NYXQjQWQlEpcZiYYw
         jGOgcE+e+Ew2rCcZFxMqAkLwkxtDd7pWBYFHQCjCC1mdAOsnmgEVlJYK5H8h1lycRzBU
         XHKfbbefPMrdwOQrh+TdTwD0qsKLBIbtk4zmXfIOXoCPf2NSZdFqiHKR3603T4sewAcm
         LNL/a0j7C1dYLlpnqDhgA6r9pS7tmRU55+xBeY4Irgzb13LJoGtKpnsWZ1g5AxZM5JeF
         wAbw==
X-Gm-Message-State: AOAM532DVqRPfBpdRkKiOZTi5vqgOrlRfS0vCwU5QDifBWJR5Flee1Zy
        /fBloDAMiWdpCbBJTRQz9YRcuT4lAK9g
X-Google-Smtp-Source: ABdhPJyZfhPdJxelWD1vqK/wZ+Y1PwZazxqMaGG/b7x3U3T6WDL0GDa8khkWXLlwMr499JHgC4evl01xOfbp
X-Received: by 2002:a25:eb05:: with SMTP id d5mr3114666ybs.12.1592541247784;
 Thu, 18 Jun 2020 21:34:07 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:46 -0700
Message-Id: <20200619043356.90024-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 00/10] perf parse-events: enable more flex/bison warnings
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

v2. predicates disabling the warnings on more recent bison and flex
    versions (3.5.3 and 2.6.4 respectively). An alternative would be
    to disabled a large number of warnings to cover the warnings
    generated in older distributions:
  flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function \
    -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter \
    -Wno-missing-prototypes -Wno-misleading-indentation
  bison_flags := -DYYENABLE_NLS=0 -Wno-unused-parameter -Wno-nested-externs \
    -Wno-implicit-function-declaration -Wno-switch-enum

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

 tools/perf/util/Build          | 62 +++++++++++++++++++++++-----------
 tools/perf/util/expr.y         |  2 ++
 tools/perf/util/parse-events.y |  1 +
 3 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.27.0.111.gc72c7da667-goog


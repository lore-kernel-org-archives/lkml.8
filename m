Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EB5C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B2720656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwP+xsYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgD3TgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD3TgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:36:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F0FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:36:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h129so9033252ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Jb1R8N3ENteLMOcD0l0fsxxjCS12Nc1+p9531pxGvvE=;
        b=EwP+xsYRD4KvbCGj3Ucg3cyOUz6mA+R3zW28l/PNeKkHNb6Hj8av1qO1NccLNlw2GF
         ky8rrgiWeEpllChJd59NONJYC2a2Noi0G+tO/TYMU/s262CVj04VjrLtaWi7rZ/giMAi
         +OVbzf3hPlWpEbYrPhqz80g2oOc+dJ+aweAmbwntwLTHPrShTl+Ip/p6OWb09+0ylM4o
         HUkgLLP1jigBuTMxpa3GQxrBonviucvI9ZplrVpmdVjUklyVhZiuH9NqO9P+4Os6Czy5
         UGZIRO1yCNs7LwDtqg9nC7G/7odpm0iWfWq2rMJsuaRuH1H06os5ValYTFKpBqRNtAMR
         eq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Jb1R8N3ENteLMOcD0l0fsxxjCS12Nc1+p9531pxGvvE=;
        b=WRcN1Uoz0hx9zjREhoROrwTjPPii8cD0axxtzizGrGA94nCBBek4m0PPHPRhBsSQ+y
         bM3Op1ZAEJOJ94C4hHIfafjMp7vIiUhcINzAKCvV1pB78e8CuCMK40KesCkYwiouZkZz
         90AOrxBrUWBYKdNd0FnUZNp4nj7X5bN4Qep7XcsmWIjAq7Kv0xF6hfW3g9gq/tTCI8bM
         xMRN9j2tdFGW2/me3I20YQRNrMk+1ukINexgDAc+4Oxc3QRecUAGQVEgTAzFR7MW7t/R
         LMyFtuoeyYaWORuF2Da+sqtMjt/WbWrc9iGrZKbBiB5pkcrFIoxEAZ7BbEkRTx5ssBaP
         0phw==
X-Gm-Message-State: AGi0PuYVsj9nQxG8GMncVNaiOPZLxBBkrYwqQRSFIpZ52USrxVXc1a2w
        tvwvKxTlxW52kNIlFUJDNQVqNZZqOKwv
X-Google-Smtp-Source: APiQypKgfF/HPicUawJAXPaTAu9jit8eqSUQaqBGMNSK10CyF1qeqXkaVUALdbR5iIEqrlG5mtNvGutlpdbx
X-Received: by 2002:a25:20c:: with SMTP id 12mr505271ybc.452.1588275360923;
 Thu, 30 Apr 2020 12:36:00 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:35:55 -0700
Message-Id: <20200430193557.101831-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 0/2] Improvements for kallsyms__parse
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

Ian Rogers (2):
  perf bench: add kallsyms parsing
  lib kallsyms: parse using io api

 tools/lib/api/io.h          |  3 ++
 tools/lib/symbol/kallsyms.c | 81 +++++++++++++++++++------------------
 tools/perf/bench/Build      |  1 +
 tools/perf/bench/bench.h    |  1 +
 tools/perf/builtin-bench.c  |  1 +
 5 files changed, 47 insertions(+), 40 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog


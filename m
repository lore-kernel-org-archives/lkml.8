Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD418C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C70420787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9atdV+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408345AbgDPGiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408149AbgDPGgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:36:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98951C061A41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:36:02 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l40so1971393pjb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=H9atdV+jIHLzhnSRMTGxi6PhgpWAWnmvxLtdgQ7Ze7tsMGx9/Ozfs7Mn/5s7MeGlJK
         cM97cLthvXZj9VfG0UHnIuPZ791ZlqBPcKhl4TKU0gtRxvg27tC9/JA9JN+Z35ZKy5Eb
         FNX25TnWgyh1XsxMgMivQgd44/xASJmd+AL35hxIxietW6xABCdGNpCtY14SNQj1BL3g
         CQncp2pfrj8kIvTXpplmDmWGUgT+AflRLJSPvtWyB3FNcgisU0QaTPa0qwVh8jSRbLS2
         suJMQzyoMqRDHLBu/SlnDfcgOBPVFAGWMQ0qbYprF6Q93xwpM6+wM2DSPrhRpO48dY2x
         Hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BlvWvGdkN2WeiBN4fqdYccjrgT9VbdrAfRUdSyUXBZE=;
        b=Itps9JHwEK8AymYnu9NmdYgmxw7Py3FfjD6+Y8AHDd1Txu/Lf7dSOaNhXdjn5rX/WK
         O308ggVaqjdsZ7bPICnrcY0k2xyT46aVs9DdMq8z12kBQU+f2Z8EZkZZ1+SVVVn9qwER
         xOSsBab7Km3HbCz0atKr5A+q7PAAyc/OSNc4xG9NVrJFtq12JUxYrm65uZU9upzX/YK0
         Soj6o+pZ5QGsWA1VXskk/JyS3cRgMKgmXCqLO4mUbgam7PDTCBXWBeB/S+7OyeB5XcU3
         V8Fzm1BMG76nKttT/rQYBJm3CPaQ/10eabbdgs+f9cYnfIaeL1ukxiIxUlVV3QoJWB3d
         F6aA==
X-Gm-Message-State: AGi0PuZK4aVvpeas0ByRtup6lcZ/1EiGfa1+QnT86JCkvul468B89e6z
        MCHG4Gt6/56P4kqfGxKMv9x8aWBe8+qG
X-Google-Smtp-Source: APiQypIXFlNyU4jPKhKsW7bqQXqygCJOPH3HCUAQSTDfa58kIDTMxNra7PCCqatriqPbIiuDRDfFA+hXIhFk
X-Received: by 2002:a63:31c4:: with SMTP id x187mr29767475pgx.56.1587018961894;
 Wed, 15 Apr 2020 23:36:01 -0700 (PDT)
Date:   Wed, 15 Apr 2020 23:35:48 -0700
In-Reply-To: <20200416063551.47637-1-irogers@google.com>
Message-Id: <20200416063551.47637-2-irogers@google.com>
Mime-Version: 1.0
References: <20200416063551.47637-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 1/4] perf doc: allow ASCIIDOC_EXTRA to be an argument
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow parent makefiles to pass values to asciidoc.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 31824d5269cc..6e54979c2124 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -48,7 +48,7 @@ man5dir=$(mandir)/man5
 man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
-ASCIIDOC_EXTRA = --unsafe -f asciidoc.conf
+ASCIIDOC_EXTRA += --unsafe -f asciidoc.conf
 ASCIIDOC_HTML = xhtml11
 MANPAGE_XSL = manpage-normal.xsl
 XMLTO_EXTRA =
@@ -59,7 +59,7 @@ HTML_REF = origin/html
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
-ASCIIDOC_EXTRA = -a compat-mode
+ASCIIDOC_EXTRA += -a compat-mode
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -a mansource="perf" -a manmanual="perf Manual"
 ASCIIDOC_HTML = xhtml5
-- 
2.26.0.110.g2183baf09c-goog


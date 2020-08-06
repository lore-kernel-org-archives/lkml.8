Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B4CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEA522B40
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVtG4KMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHFCl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHFClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C90C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ha11so5726356pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f4z8ELSFv5RMm4AHUiR4uM0G/VxLU19rLEUo8R7pEyk=;
        b=dVtG4KMgSAFdsCPPK15OWZ2yG1gHEu0HadSg0c+0e+EFVAcpXYdzq43bu7A0w9oi16
         kQcXys1j5RPxPLpowAhmsreKqqDgX/1JBiCr7c6Bmcjoqv2rCRdw+wvnXQF1zuK+VcVy
         JLEQdAo0MXZ4SRFMfVzxx9CV3yh4rpTJNLL9cRZkELzB/hRPY0Zg/pXtAljoHp276poV
         5HUK8qblQpub8v3xzyvRM1CrlRfXj4osqzGVe+/YswgS9OWWFvZtyC5/ixW1UfLsa6z6
         a7N93j9ipkbZZZTcZke3csID+h8CK+kCWKl+vJ58KfQZed4jfb6p8vMejUeu2nm5l2KB
         9GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f4z8ELSFv5RMm4AHUiR4uM0G/VxLU19rLEUo8R7pEyk=;
        b=ePG78E7My8HiCr32tbvxbvqmvG0XNpkcN5Ji33E9oIpmmnqqHC4U/fcPPP4kHwijmx
         6NwyJ8DD0znPoNuKWPUB6RJ1Xlp8cYQnjPX0He7GhKflhvtX3TKgd5ctCacNnNkdgpDK
         x21APEFWa8wqRLz8kyOCWM1ziXL0h49BbX4Rmg+A8PiQfWfDALiWJEAK2fL/iEQTygMH
         edBsvpP6/trAIZ6BjxcGBfpEOcbUQGGb2xyv29xDk+n8nn01Eh7bmFEJ0A22gKbtAziO
         X/G75mD3uPW9jAvwtHF3upLKLYGd2l7cLbI7VhJ1xbIoywnvDTI3QcaUvpbyy5y/lWRl
         ePnw==
X-Gm-Message-State: AOAM531LyIe1TZJk3Hiv8Lnqm5ha8SMwv69Ow/Cp3724X1We10f17VW/
        8RIXEZFAFz8p2xqHDmtHpgYMYA==
X-Google-Smtp-Source: ABdhPJzfNkMM9pXrDCDtvMw7Kgtx23ax8AYGKOodRvZQWjpFqVa7Guf18rodtdePdV3ogG4NB9qR0Q==
X-Received: by 2002:a17:90a:4b8c:: with SMTP id i12mr6466937pjh.83.1596681683755;
        Wed, 05 Aug 2020 19:41:23 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a13sm5385530pfo.49.2020.08.05.19.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:23 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 04/11] perf mem: Only initialize memory event for recording
Date:   Thu,  6 Aug 2020 10:40:34 +0800
Message-Id: <20200806024041.27475-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needless to initialize memory events for perf reporting, so only
initialize memory event for perf recording.  This change allows to parse
perf data on cross platforms, e.g. perf tool can output reports even the
machine doesn't enable any memory events.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index bd4229ca3685..a7204634893c 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -78,6 +78,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	OPT_END()
 	};
 
+	if (perf_mem_events__init()) {
+		pr_err("failed: memory events not supported\n");
+		return -1;
+	}
+
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
@@ -436,11 +441,6 @@ int cmd_mem(int argc, const char **argv)
 		NULL
 	};
 
-	if (perf_mem_events__init()) {
-		pr_err("failed: memory events not supported\n");
-		return -1;
-	}
-
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
-- 
2.17.1


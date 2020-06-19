Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480AA208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZddSThi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgFSEex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgFSEeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87FC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o84so8849266ybg.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vw05Hr6gQMHkdgIxFDB0bOiYw6mRSy0yRyh3Egshj0w=;
        b=ZddSThi+qbrT7YkxNz4wUq09u5efYQVzacpmPUU5wXZvewpGwwvsBNBuCirRe91Pl/
         GTwjZZeNjoD1R9JzSCf/zpC7nayfMgEoSYcRBm4g0sygDxq48AsqiLbTpsuw/ZuhxUJj
         Agd3d730HeSJl6UpV/wiCV41SpWbUOGXFGnDWKvlKd2Owzv6NO3/TvEIw8PqTrViCfIE
         tQTr+ZyoTPQVBtAFS+yUDOguNd5gcuoijiiduoT0efPC4exk3CYwVmJ+pqTC1Pa5F5Bh
         zqWW3bXrFBXXLZIdw9c/AMwdrIrdsR3CrAlr8tDvBv6v/GhTPyp49cLcE4uyZUKolPf7
         7x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vw05Hr6gQMHkdgIxFDB0bOiYw6mRSy0yRyh3Egshj0w=;
        b=NWKUveCZZtlamB29WEKWEg+ZE3oNABvdTDxChK5yHw17FDdHidGjQaqrp4QNuiSIBf
         JGzJKYNH+H8+fozxjfoyR9w4QueuLyElmldnlZo/EvosJpS0dPWxsNxsmCjfP0e8DWQw
         es8VAoRBfQxZJZcp9/mBMd9WR+UBsEoHPEbKZRUfsx9HKitCoWuxe026rscx8VHOZdOu
         6MppvCmKS3Wz/dWOh3b622jxil43d2heTIDPJo6NpdQM7GO9bEFY9EdXjEqJFvLiV2bT
         7+2yOIOLrxcvo8j8AKegPZg1rucFKs4GsIQySXINZlcKG3MHHBLeB2jLPFhevn4QCbjj
         iWyQ==
X-Gm-Message-State: AOAM532yMDsyxgcEQdV4cyWcfuDlqc+B/Rokh93fBt9/krwPll2GbwUv
        +90F0TgDkdgxpLxRmVkbXM6I+SGUuvxr
X-Google-Smtp-Source: ABdhPJz2gzcoW6j04ojC5EmMo4415rURb8VGmSsabv1X5bkihuqmh+TIpgCID0kpVPAfOvnirS6HF9aL6lle
X-Received: by 2002:a25:a0c7:: with SMTP id i7mr3267724ybm.420.1592541249751;
 Thu, 18 Jun 2020 21:34:09 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:47 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-2-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 01/10] perf parse-events: Use automatic variable for flex input
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

This reduces the command line size slightly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d18380ecd10..66cf009f78d8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -193,7 +193,7 @@ CFLAGS_genelf_debug.o  += -Wno-packed
 
 $(OUTPUT)util/parse-events-flex.c: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) util/parse-events.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 	$(call rule_mkdir)
@@ -201,7 +201,7 @@ $(OUTPUT)util/parse-events-bison.c: util/parse-events.y
 
 $(OUTPUT)util/expr-flex.c: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) util/expr.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/expr-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/expr-bison.c: util/expr.y
 	$(call rule_mkdir)
@@ -209,7 +209,7 @@ $(OUTPUT)util/expr-bison.c: util/expr.y
 
 $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h util/pmu.l
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h $<
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-- 
2.27.0.111.gc72c7da667-goog


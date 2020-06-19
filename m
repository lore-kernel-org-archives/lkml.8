Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02FC20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdcZwvKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgFSEea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFSEeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:34:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B43AC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g72so6186670qke.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nxrqOXZ+VMn+w6eU8G8WeFCP1whWHo8wMYd7Py2GNyI=;
        b=IdcZwvKQaEdYfIitVD31eU/XI8+TENoIL0zpQuIlUTO8mbf0ms9m1AWXibz5GXKmtB
         dAQ+XROQ+OHfagItMbuqD/2GQp9dNY5gNMZmSADGSEEISPTZUXtoOcE8eBTyyLzaOhml
         NXoYD3SgzmDwOMZroisYqGXVaxGt2qk7Lfsjljw1kAqLUGTtT6PUrK7/vLKkC/Ec+QDQ
         mEou/l4WsfV0ayCSuLywwQtvASN+4+1CdEhPSkJvItEdpI0qN4EKWvZBakXpOdry/Osp
         ts6sL8zqO52L4cVrbpGsusOPfUMFEYofO2FF2HAvhxu3i7p6BUuIrqu99wPM8SsPeeYp
         tnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nxrqOXZ+VMn+w6eU8G8WeFCP1whWHo8wMYd7Py2GNyI=;
        b=GqZeteP0AmRU7E5M4AqvfG4tYTM4WoxRwR9e+w2QmqlT0hq+3CXi13MoTRVRwHowvT
         L0LF3c3QCCw85mVjZuUcBjwkPMR3jM1h4IzH7mnFaFy053ufqyhL+eSHCpEXNPINd9te
         725+Ixj8pM+NCRqlc+XRfX+NLr+UYmMkazrG1SukcHQZ65zIHqgoI1RZNyJhK4fwBhMf
         SyVWYGbrOT2HGF6JrZoLfQm41iCunN3fqHgV5LkrVDz0+4J0WIcfkliNNkuZBDhIlQpH
         823rfa4i3X5IaKCXtuAsL1CNU0yDZhCOdcx1jkMgvJPs0iiKJBxtAwrJbFYq35PbS+EP
         5Zcg==
X-Gm-Message-State: AOAM532KD4/itUHhd4x+9x+PkvhZmOeam6VZBLjrwiPli1xYt0YarNdZ
        K8yjeqdy7C79i+MkvLuw4+ejlkSeOfNa
X-Google-Smtp-Source: ABdhPJzv5r4jdAlXVMm5OExuwtfRcpOw80DxILzIYyCgI++juXu2bg+BxnIi00Q8fYnEY6Iijxu30R+zY80i
X-Received: by 2002:a0c:ec4b:: with SMTP id n11mr7069851qvq.103.1592541255460;
 Thu, 18 Jun 2020 21:34:15 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:33:50 -0700
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
Message-Id: <20200619043356.90024-5-irogers@google.com>
Mime-Version: 1.0
References: <20200619043356.90024-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 04/10] perf pmu: Add flex debug build flag
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

Allow pmu parser's flex to be debugged as the parse-events and
expr currently are. Enabling this requires the C code to call
perf_pmu__flex_debug.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3ae4adc8e966..e63bfc46d50f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -209,7 +209,7 @@ $(OUTPUT)util/expr-bison.c: util/expr.y
 
 $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h $<
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $@ --header-file=$(OUTPUT)util/pmu-flex.h $(PARSER_DEBUG_FLEX) $<
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-- 
2.27.0.111.gc72c7da667-goog


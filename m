Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137562072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggTVAYnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgFJVvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFJVvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BAC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y189so4081666ybc.14
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iJru6UJ9fMxoIzPqkwno8mMs/VcxhDdpDR0ieFttRFs=;
        b=ggTVAYnX7ME6YSPvz0icCvsvgw7VPJsuTHUvGv/CZxzsvzjcjKhiRaMoucTmbpXxTZ
         eNYheOZaKh0U+BUx7Hif4sSko8Hq5HdzEFngaCDofPLeGUWXeeVXVsU9HCupj5VKsIwf
         0hFYqyuIkLZDa1mfl3W4ld2+ULktMN7r+NLVXOsCoIVPIHJEUxshV3A11kZQOf3VxLwq
         KkYyizhJrQtYulrcQCUnhg7Wk4ku/GzHzvqy+58Buv4erWLBDepyr73dIS9fdDbcUJYO
         j9fyiVV4iB/J5zeTkTf/XFCwrwJvj++iwzInA1t7pjtXOF+oDAAqmdCeLRDiuVni7lLR
         714A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iJru6UJ9fMxoIzPqkwno8mMs/VcxhDdpDR0ieFttRFs=;
        b=q9jMKP2lWPdcqP7aXvNxyxfuMvgcvPHn8FpemrayMZGsCR+fCZwG2yR6NRlhByhmsf
         Rxrxoggeal7B7dH/o32a3QFdfPrx8yhU+9h7byzsJT+0H6K5sKBN1p+KfPq2yp02Oi3m
         Y83Nxh23p+Dhdiytb+OV5THBE+TFf/fkjaBNOBEH93qUHdaZKi7eZQ6Uc3AiV5QmSBex
         OymuJzGUArtJFLqLfB8f3Ytr1rHuEg561Z1iOyNCwJS5BKmYvOcuXjX4D0su3Y38HIF2
         BEK5Q8VLBGFoL1zLHlVBeehGt/KtzS3rsmzZa9uAaa3EdTjEMrBIh/I5rTfMWb7/kHtz
         /n9w==
X-Gm-Message-State: AOAM530yleJMuGMr7sXo0qsFrigI91HDKvdwjsK2bdhpiA51yypIPC+j
        Gl6CJ8mud4SLU3eAOsEURCuNNzNlK/ow
X-Google-Smtp-Source: ABdhPJyR/lQCFTWecLblcYm74/12e2bc3SZ9wCMKXsvLxSdoZDxuwO+iKFWafyVd+wjiWDpVrx05Fiwdk8Or
X-Received: by 2002:a25:3bd8:: with SMTP id i207mr8507683yba.167.1591825871689;
 Wed, 10 Jun 2020 14:51:11 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:54 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-5-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 04/10] perf pmu: Add flex debug build flag
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
2.27.0.278.ge193c7cf3a9-goog


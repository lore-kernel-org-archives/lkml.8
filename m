Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F94C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D7120801
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MG29QfOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgFJVvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgFJVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:10 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A630EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:10 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id u48so3097959qth.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cDfjeg5+t0Rlv3HSKhPGdbe5oEBffzQwmIpvMOsdFoU=;
        b=MG29QfOGgF4Kag361k647torOwEmsIkk0ONWaUD7+r+sF4PDQi+BbJKz1ti4XzgQRk
         yte5aLZlRqPS6vE9eBub1UMVy51ceKHnWGMQaQ4LbJWHVyPUHRE3jxc2SLBkSzzgFrtP
         /+7bHSAm7eV46t3otdOrj96kk1GQYeAJBXnYhVSy2/gORmjAwx0Q97iC6jN3RsWm95HY
         SStCd6NNliOvyuF/lgkQ7tMYvMrx101s0yDxFjb+pNKHSI/jut8lKlfABvl3M4bOHlCX
         DU0v0IK9NLjU4DwkI1I6jVV3f/RnQXo95B82IoSbSZGSWHMrIGauwmS7OB6aXc7PQo2t
         CsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cDfjeg5+t0Rlv3HSKhPGdbe5oEBffzQwmIpvMOsdFoU=;
        b=JFUrGlMv9zHNM/cktwU363SZd1CFw6yNGRvTQsuRJLVhfzq2l0SHnnre0uWYgVIHs9
         tGtTbXKUE0pSHNEhfLMp7g7+gTEj+zTPectGNC2MiChvWnufm05Ky37gkrcfBfDjjhl4
         LGMbriKM+61stD8WvLEaHjWqRC8qdv0n+7Oc17J4inesx5Kx5lDx31nhcXfmb2fBoEV/
         onNNe6YF0h2c1AGtWrb7ga/LnwwVKbalIj+ihwzkfKdEDDM12VhbbhY1+asyuBmG0rqK
         XHUKNKa1/dRs5noCyOQ2cOnDZ1SFY83JInFi+Z5ElzVLK7+fBg8CgjY7Ato69kzDzRml
         Krrw==
X-Gm-Message-State: AOAM530LYhlBHNcm513c8SCeRwJDw/2EuTmuypzZSh7Ir6IIid9CFgxC
        nNrJCnK1RANYO1MupA74J23RpjH8xgts
X-Google-Smtp-Source: ABdhPJzat9L6DI764/ixLN77hn9brAFRrTN5WO0bB84imcqecgDuX4I+HlvA2qqEMSCyTdSoPb31IhRquSa4
X-Received: by 2002:a05:6214:5a4:: with SMTP id by4mr5075824qvb.40.1591825869829;
 Wed, 10 Jun 2020 14:51:09 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:50:53 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-4-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 03/10] perf pmu: Add bison debug build flag
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

Allow pmu parser to be debugged as the parse-events and expr currently are.
Enabling this requires the C code to set perf_pmu_debug.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4e1aa52d75a8..3ae4adc8e966 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -213,7 +213,7 @@ $(OUTPUT)util/pmu-flex.c: util/pmu.l $(OUTPUT)util/pmu-bison.c
 
 $(OUTPUT)util/pmu-bison.c: util/pmu.y
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d -o $@ -p perf_pmu_
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) -o $@ -p perf_pmu_
 
 CFLAGS_parse-events-flex.o  += -w
 CFLAGS_pmu-flex.o           += -w
-- 
2.27.0.278.ge193c7cf3a9-goog


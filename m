Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953ECC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AAB2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BygGwKZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgFJVvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgFJVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:51:24 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30916C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d190so3317696qkc.20
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4dFkZP2Au0Kx1zBnayZQrTEyqU5l+wtyIesCoLSGDjM=;
        b=BygGwKZuudzSjpPdsYWTXVx4GGu9IRRAQ4OmhGdK8VRrUb54dvATxlIyLBPd/aoEcZ
         QfleYJ1oTKI1n4ypb6mvx/EJs6VMIdKsMaVRfmasruaDWI2+N6PTtMnp62bou39Atuy7
         W1f7JgYsopOhivEBWzYA+kjonOZNmcvQKWeMTHT4WA+d/b+FubJDBYGr5LxROnfuyvMc
         rDbFJo6IiNTqrC+MBgmC1SqMAk1NZ42QeyLLazQUz6RHONiejMGm/vDJydQvty5PeFaA
         tIcsbVk7h+Z8AJ+r/p4JTL67tA2WcwVdauaAKJ+XP+IqyLdpDj5boZnevaCLmG/aWnEd
         MpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4dFkZP2Au0Kx1zBnayZQrTEyqU5l+wtyIesCoLSGDjM=;
        b=R3T5Kc6PEnJ6bLKhrbzRGQRils/JfDRDpn2u5kup6b4fdMncDUPuRXLHBqz/SWQXW0
         rTiaEc3vCPm3OqeoFBNNcmFyBFitFZfHqh3UHSFv1hFZMv27kYQZ7MvgJJsaRTjWicGk
         S+kYntSgcGj96Dx8ZwZVTyF0vWiXMgAPSHScGeYy6hJaJcZ6z1x32vVPV4oDEXjnQgEu
         i0MLtOa9zcrkxZTheApPqX2nt2S6vtzvvRmjRGDUC4IvVQKaAxDIzMokgG3gGDhXvuAM
         p+8qKqb0dMLcoukt0AxgpOubJkFDm1cFSjTI/X9Hsd8Nil9vfgxoWjcVmR0hjeGcyuj+
         HQcw==
X-Gm-Message-State: AOAM532yNmg0Y0BuXfZOE748KBnV9xfCKSVe6UTTdlHSE2StPlQvAdr1
        Xv/Exo7N+Hy1IFKnuuM44jCg4wjfQh61
X-Google-Smtp-Source: ABdhPJx0PMvlLMdcGm8b5Y7pL3u9QE/q5aa1zkA7s//M0QVfkGTVEVU1H9ZTbev1QkXn4CA6MvvgRnuOzPw0
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr4990107qvf.247.1591825882381;
 Wed, 10 Jun 2020 14:51:22 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:51:00 -0700
In-Reply-To: <20200610215100.256599-1-irogers@google.com>
Message-Id: <20200610215100.256599-11-irogers@google.com>
Mime-Version: 1.0
References: <20200610215100.256599-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 10/10] perf parse-events: Disable a subset of bison warnings
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

Rather than disable all warnings with -w, disable specific warnings.
Tested with GCC 9.3.0 and clang 9.0.1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 68885bae466e..c1f872ab7748 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -229,9 +229,10 @@ flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-red
 CFLAGS_parse-events-flex.o  += $(flex_flags)
 CFLAGS_pmu-flex.o           += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
-CFLAGS_parse-events-bison.o += -DYYENABLE_NLS=0 -w
-CFLAGS_pmu-bison.o          += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
-CFLAGS_expr-bison.o         += -DYYENABLE_NLS=0 -DYYLTYPE_IS_TRIVIAL=0 -w
+bison_flags := -DYYENABLE_NLS=0 -Wno-unused-parameter -Wno-nested-externs
+CFLAGS_parse-events-bison.o += $(bison_flags)
+CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
+CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
 $(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/pmu.o: $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-bison.c
-- 
2.27.0.278.ge193c7cf3a9-goog


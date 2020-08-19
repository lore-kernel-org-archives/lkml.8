Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CB7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD8E207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqfYIi+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHSIs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHSIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:48:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:48:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j13so787951pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFi8zTtrImZDILchnlZzIR1IxDR1uqiy2tgSbT1x9s8=;
        b=OqfYIi+HkhrNDJaXoxGNw9xfIPQWaGQbceAbY/S48XEG94k3Imgo6Hg4slYsNTHK9K
         0LEXROlE6/nW7Nb6voPpSBVnaS1rIBBgsgz2QUNH2Mx/XCE2Ro7aG1lABGqAIxYKEL6b
         zsMxhkj/uz45O7VtOvSYZtAA+C4DdCu3QyOF4W+jWK86J5IJyVTVKBcrJ04Q/1M0pzGN
         mHsKp/LlUtNLllvRy55f3EMeXPCGLD/S1iH17joZJ8WE750GuyHkFICKI2GrHTlTKGNG
         B8jDLrhPhXTVqQ45EM1fw24MhpOrc/LicvB5y7Qp1sXQZaUaK/wG7//6nw1q0QQ/k7gf
         XVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yFi8zTtrImZDILchnlZzIR1IxDR1uqiy2tgSbT1x9s8=;
        b=po6uNIBBF0j+FkQhXacPBdvINXmL1M2Da1NFgdsjlrEI6IB7tN3f6Z2FZqazqG+mU6
         OvadRw9ZWCwCeDi4yLPruCdvLqrIi0f3xNmd7SwUmZnq4c5VxdKkIaWWpZcJeWdQRQUI
         xgsU5QwvT/Mu6BTL4H4XmFNMBKBAEuhS3i+vCbMHEWDWd98B3Dtfv1amwjhu6BfGF8WY
         JHzVg6kteEJetrasJJNdRneNHoGrLkRbY5SayeONE8Tk13iD5QQcll8SyY5YtLGUpL6t
         zvVfAdK9rE3GJnE0jip4PIcO3Flt2Z/xxaMmmo6xGWNeMKX0Wpc9qCoq3lhYvR4Tpfvq
         pLow==
X-Gm-Message-State: AOAM530JhAuIQ7gsfL5BrBBRExqvXAsowcCgOYcKiC9WSlBJXdQNHpTS
        9BGKLFbkCUs0KjVDKfwrODtwqw==
X-Google-Smtp-Source: ABdhPJwWbnU935IzaGsltr+HTXM80XTYPnZrgfrNRJD2kJjhKoPlGyc+WMVx87B7iNrVY/YI89PEbA==
X-Received: by 2002:a17:90a:ee8d:: with SMTP id i13mr3368081pjz.19.1597826906130;
        Wed, 19 Aug 2020 01:48:26 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z25sm28153492pfg.150.2020.08.19.01.48.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 01:48:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf intel-pt: Fix corrupt data after perf inject from
Date:   Wed, 19 Aug 2020 16:47:51 +0800
Message-Id: <20200819084751.17686-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819084751.17686-1-leo.yan@linaro.org>
References: <20200819084751.17686-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Grant <al.grant@arm.com>

Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
changed the format of branch stacks in perf samples. When samples use
this new format, a flag must be set in the corresponding event.
Synthesized branch stacks generated from Intel PT were using the new
format, but not setting the event attribute, leading to consumers
seeing corrupt data. This patch fixes the issue by setting the event
attribute to indicate use of the new format.

Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
Signed-off-by: Al Grant <al.grant@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/intel-pt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 2a8d245351e7..0af4e81c46e2 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3017,8 +3017,15 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 
 	if (pt->synth_opts.callchain)
 		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
-	if (pt->synth_opts.last_branch)
+	if (pt->synth_opts.last_branch) {
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		/*
+		 * We don't use the hardware index, but the sample generation
+		 * code uses the new format branch_stack with this field,
+		 * so the event attributes must indicate that it's present.
+		 */
+		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
 
 	if (pt->synth_opts.instructions) {
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
-- 
2.17.1


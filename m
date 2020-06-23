Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5DAC20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1/AqsCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgFWXtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbgFWXtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:49:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDECC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:49:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so208837qkn.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=L91sjcIPUiXFRY3kZBjWIFZ3Rmo9m3IlVJuhftDX/3w=;
        b=i1/AqsClIbSx/ctjq1bZpJG6zdCxn9EfKVGgjxOQjExpMbruBmfxThanjDNRBJsAcG
         n8sktsqfXgwT3HTM0AD1P24RWhLsluhZORp5jZ94yCf+dlv2/zx5foTD4ogoRt7RP9e3
         i0PAe6thRw3/CxVyV05qyJEZVCZmGceBfh9SgYurP9LcxVJS9xNtJWhD9iRo/tmTNnMu
         5FzGuDcTxY231n181zAVXx51YTyxBdTkkLg/Fzdibj140NvMqKEka5uUJev+xJpxBetp
         9LPzliMMSoxjIg4ypryvDjBgR2/GSrt6dsy+f5t5oWdqii/uZ9pve7ZcCZYuftbwwB7s
         Auyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=L91sjcIPUiXFRY3kZBjWIFZ3Rmo9m3IlVJuhftDX/3w=;
        b=ND9gs2djgZ/VtccoffBGvdqToZ21Qd3UjS78e44mK0wSKQCCGP5cgUtc1DZTDlJD6H
         65IFyZlkkliuIF1AS+UarRIlXOMF+DbRuuFfk7qPztHgEm2/Dlr84+eTENAJ9cQd9RIp
         0hb4aeg0L8FEjRiD8etPFnw7TmPWhsrmtdF2AAoV2Fm+rfxyZiivRco3CiZ4K+biz4iC
         wMue+cPOjUWyQORlG6ljXzgiFOTKz45wBFVlWQSOidTq18beNNyg5nfBgG2yXaN/i2Ak
         Jg5lreh0fXhOggW/h17UR2F42WJ37LmquyTmklTMDSMJfAuhEWGZfQ3tS/jz8NV98PIL
         Qvfw==
X-Gm-Message-State: AOAM533rYleX7ryD64E5NczsBGn/XvbzwMXVv7lu9UoM4NDUp1no61xG
        CpddtqNnupbmgTV8c8rB5B4=
X-Google-Smtp-Source: ABdhPJy3pmh6d9LoJ+ryJUzwvi0J7VoEI58swUxGudIUb6wlhWXIJFsscK3M1/p1p75aUZgdj94CfQ==
X-Received: by 2002:a05:620a:219c:: with SMTP id g28mr23274619qka.227.1592956153999;
        Tue, 23 Jun 2020 16:49:13 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:596e:7d49:a74:946e])
        by smtp.googlemail.com with ESMTPSA id o21sm2006501qtt.25.2020.06.23.16.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:49:13 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] [perf] intel_pt_recording_options: Remove redundant intel_pt_evsel null check
Date:   Tue, 23 Jun 2020 19:48:50 -0400
Message-Id: <20200623234905.18608-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_pt_evsel cannot be NULL here since its already being
dereferenced above. Remove this redundant check.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 839ef52c1ac2..8cc87fd2dc6f 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -836,19 +836,17 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
-	if (intel_pt_evsel) {
-		/*
-		 * To obtain the auxtrace buffer file descriptor, the auxtrace
-		 * event must come first.
-		 */
-		perf_evlist__to_front(evlist, intel_pt_evsel);
-		/*
-		 * In the case of per-cpu mmaps, we need the CPU on the
-		 * AUX event.
-		 */
-		if (!perf_cpu_map__empty(cpus))
-			evsel__set_sample_bit(intel_pt_evsel, CPU);
-	}
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace
+	 * event must come first.
+	 */
+	perf_evlist__to_front(evlist, intel_pt_evsel);
+	/*
+	 * In the case of per-cpu mmaps, we need the CPU on the
+	 * AUX event.
+	 */
+	if (!perf_cpu_map__empty(cpus))
+		evsel__set_sample_bit(intel_pt_evsel, CPU);
 
 	/* Add dummy event to keep tracking */
 	if (opts->full_auxtrace) {
-- 
2.17.1


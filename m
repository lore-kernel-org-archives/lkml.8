Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82749C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514E620810
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOSBRtRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgFIFgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIFgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:36:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B4C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:36:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y189so24351553ybc.14
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 22:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bpmUxX+SLHaFrqH8UEPqwWvKbtgfvTUgejS7Je16KRY=;
        b=FOSBRtREGH0Nqk0GuUIlJ6tktsdLLSRXxmXQv9T/IMUwkDiO16pO2KoGK1OAtSfMxm
         8ONasuVsybn5g5/mEugeWXJScqn8gWqji5Mabhtvili1idsLDLAyAVUNHw5h6/b2mUGx
         3I27u4L1E6o07++VYLVjdgyXm0RwgROjdBklAGVMdrdyfqrAMPlREotcz1yPt+OKWuGX
         S76dwpg8yz28XzZiHf5IbM3GC5ZUINzuweqKjTvDL0NMVpcipQMAQAI5XUx2e1wMdKaP
         KTxV9ytFI8IEIX5T38vimlcS1QEPSSo6BF8W4N0dyYrs4oFtgGzAkKtgbn0kkcNCVxlK
         9MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bpmUxX+SLHaFrqH8UEPqwWvKbtgfvTUgejS7Je16KRY=;
        b=H2z4AUdM1jeGC5UCP0Bowzq6czmyrrKJAbeMrbvJq8t86Gr8oPM5qFbu7RgnxxpwhF
         H+sssaq/dzsOYBMoxmoQZBIVh3WfGy64B1xrxdmRkZ6csnQSLSqZ7Es5KawpcitfNXqb
         UmGtQb0yEcBQdna1My/9kz5Kkc12TPzu/EN9I2mGhCgm8fG3REz3xgHaZl5ZYahOfPp+
         NHDwkcRPmXgMBOt4qKNfNYj9EqGKoTT3FAkz9fl1zgFTIZz9m7CWKPe9pxAcTpXWKVfJ
         dS4zLgrEd1pr398P0FKYNUgkVZ40Ji2/UzM/VSlN1vaTJHg+Iydp+CiyJiDBred12kdF
         8bJw==
X-Gm-Message-State: AOAM530fVrBiCFZwR6DICP9cjseaFP55Abq4hHXC8Mh04nhUKSmX/PRY
        5esK+GnW59EFSkqUxEZSwzsfPBVXy3ca
X-Google-Smtp-Source: ABdhPJz+d6CWXQpnEBfQ7Q+ZP1hzS2weRYwX7xdvHKdLgEl5ydoiUx6rspa6Cmtou/goYNxdd9SFI7ewWg/c
X-Received: by 2002:a25:73c7:: with SMTP id o190mr3570237ybc.117.1591680976692;
 Mon, 08 Jun 2020 22:36:16 -0700 (PDT)
Date:   Mon,  8 Jun 2020 22:36:09 -0700
Message-Id: <20200609053610.206588-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH 1/2] perf parse-events: fix an incompatible pointer
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrays are pointer types and don't need their address taking.
Fixes: 8255718f4bed (perf pmu: Expand PMU events by prefix match)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c4ca932d092d..d4e076c9c2ab 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -349,7 +349,7 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 	struct list_head *list;
 	char pmu_name[128];
 
-	snprintf(&pmu_name, 128, "%s-%s", $1, $3);
+	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
 	free($1);
 	free($3);
 	if (parse_events_multi_pmu_add(_parse_state, pmu_name, &list) < 0)
-- 
2.27.0.278.ge193c7cf3a9-goog


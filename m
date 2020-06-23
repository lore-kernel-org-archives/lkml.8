Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E61A2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943428;
	bh=cvw7AuHuLeoxtZ9XGO2H7QnE1hFtaPcEgksmMXgPXlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tw1Y8f+oIAVZ5UoH6hg0AtqazdMOdgV10qASiUAh76MPIQv2g98H9f3gUJDqRiWWv
	 +bJix3nd+1I2imvyKjDZhtqIor48dRxQwh9Xc+ELLmMJHnWa5uw55hHdk9ARLCblQy
	 VuFNV+FbJ37gkJIGufef4nYHX4cp0iwIfnGFwDCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbgFWURG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389487AbgFWURC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:17:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C6C2064B;
        Tue, 23 Jun 2020 20:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943422;
        bh=cvw7AuHuLeoxtZ9XGO2H7QnE1hFtaPcEgksmMXgPXlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRZOIU9VYCZgb8XJxbL6WP/dpQQypno67fpkWFz3D1n03Nm4y1RYH1L80d6E2Pq1v
         +wVXGNami62z0Quww6fddRM4i1UnB+DRTCwLjFdyPMj3lDCY7m+3zmb/8ELfJfskqK
         GxKErTIrTY2HKVbnZ3R5SwqRMGTzzV7Hkr5Vv42A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 386/477] perf parse-events: Fix an incompatible pointer
Date:   Tue, 23 Jun 2020 21:56:23 +0200
Message-Id: <20200623195425.773210031@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit c2412fae3f01725615b0de472095a9e16ed30ca9 ]

Arrays are pointer types and don't need their address taking.

Fixes: 8255718f4bed (perf pmu: Expand PMU events by prefix match)
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200609053610.206588-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 94f8bcd835826..9a41247c602ba 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -348,7 +348,7 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 	struct list_head *list;
 	char pmu_name[128];
 
-	snprintf(&pmu_name, 128, "%s-%s", $1, $3);
+	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
 	free($1);
 	free($3);
 	if (parse_events_multi_pmu_add(_parse_state, pmu_name, &list) < 0)
-- 
2.25.1




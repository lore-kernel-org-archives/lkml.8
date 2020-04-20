Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95556C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754F9218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383748;
	bh=EPJxrD7KUuHGqvdsNGSmsyKWjnbaIlI1xgBj6dkG7yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvD2PP0vA9ixgJpjSK0NGdLYVgXqtg+puh2XHUIEPNLA5bEGmnLBkUNM5kTmkukgj
	 9jthP2HfWFjUn22PrP0w4vpf87yYBz0HV1MGcJA/epAz6P3Jg/cfBDpDebLTOvbIh4
	 +XSt4fyfdtuctTOXkJMgDHSlPEyfaUDh/LdOgsb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgDTLzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgDTLzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A0521744;
        Mon, 20 Apr 2020 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383744;
        bh=EPJxrD7KUuHGqvdsNGSmsyKWjnbaIlI1xgBj6dkG7yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3zPBODld+uPpDI6QjFO9tMWBlrp6zjRUb8TuW87UXH6S55OBwRm20VUenpNEAbj0
         kq9EGtEIdNtQV7FvLBKKxioPv+W12sG6qSC0VsLpdjBIEbQAY1CHh42wOcgMGBcgxS
         +sajlXTDG4COli9mTxTIRPirZxKe7e2/EBUxZEII=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/60] perf arm-spe: Implement ->evsel_is_auxtrace() callback
Date:   Mon, 20 Apr 2020 08:52:44 -0300
Message-Id: <20200420115316.18781-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/arm-spe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 53be12b23ff4..875a0dd540e5 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -176,6 +176,14 @@ static void arm_spe_free(struct perf_session *session)
 	free(spe);
 }
 
+static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe, auxtrace);
+
+	return evsel->core.attr.type == spe->pmu_type;
+}
+
 static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 };
@@ -218,6 +226,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.flush_events = arm_spe_flush;
 	spe->auxtrace.free_events = arm_spe_free_events;
 	spe->auxtrace.free = arm_spe_free;
+	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
 	arm_spe_print_info(&auxtrace_info->priv[0]);
-- 
2.21.1


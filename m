Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D420C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BEC206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383775;
	bh=AqQD4sxd4DWZ99ZebKG5eBlkR+OUVebxgHrra1nrocQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQuhsH2ziGMXzdcgMvPZBCSEKzVA0lG0NVkRFTK18zJYRN1hsmkpdUh870ShC/k/8
	 LbbRxjfrllOLaqf84ZBIsXIs6CfaKKjQxLZ/wzdxPXfm0IOAqAwoA16VAavNkLzb1e
	 kLOOe2AmrfZE8bEG/i2wK9bHdNeFsEtpD5AvhfEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgDTL4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDTL4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E0021744;
        Mon, 20 Apr 2020 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383766;
        bh=AqQD4sxd4DWZ99ZebKG5eBlkR+OUVebxgHrra1nrocQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Wum3tJF8nB3BLdK01pGL0RBx77WmWY6WEkVswoMG+M0WvPhOHtFjRfpcw4ZXX3tE
         EqueuKKMkOH5ivJayI9L/Pzae8UTxfrnkxOu8Gu0QUp0IttRa7XBbf8Uvq1YkGe3WY
         Gg7id50GFEm7wx4bTg5gnDcEMAr44pEoYDzNuuu0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/60] perf evsel: Add support for synthesized sample type
Date:   Mon, 20 Apr 2020 08:52:51 -0300
Message-Id: <20200420115316.18781-36-acme@kernel.org>
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

For reporting purposes, an evsel sample can have a callchain synthesized
from AUX area data. Add support for keeping track of synthesized sample
types. Note, the recorded sample_type cannot be changed because it is
needed to continue to parse events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53187c501ee8..e64ed4202cab 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,14 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	/*
+	 * For reporting purposes, an evsel sample can have a callchain
+	 * synthesized from AUX area data. Keep track of synthesized sample
+	 * types here. Note, the recorded sample_type cannot be changed because
+	 * it is needed to continue to parse events.
+	 * See also evsel__has_callchain().
+	 */
+	__u64			synth_sample_type;
 };
 
 struct perf_missing_features {
@@ -398,7 +406,12 @@ static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
 
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
-	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded callchain
+	 * or a callchain synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
 struct perf_env *perf_evsel__env(struct evsel *evsel);
-- 
2.21.1


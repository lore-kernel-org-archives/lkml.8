Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FA8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C16214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383752;
	bh=nL1LeGOm8/WZgsO1KtQEkujWWsCxvxA5HwYdNWw6Wyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9EhS+Dr/M8Jk0STxe46KmZQ0kJQiCjS7cGGKMZtjBXp4sGUATFOZiVS9p152Pygr
	 eaC7baKYyzRB9l2a7B0R2IKvsnO59X/+giJ3JW79whxcoqiC0YAwS4BpCEabNUaW9D
	 pBbBqb4WFNUg6Bs2msW2Gc1Ps4wjB4To7mKv2+OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDTLzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgDTLzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7244D2071C;
        Mon, 20 Apr 2020 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383747;
        bh=nL1LeGOm8/WZgsO1KtQEkujWWsCxvxA5HwYdNWw6Wyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjPd3WKi8ZJ1kqyPYUDMB4we/fxbCzUEw33vDfJ3D4bBHmGLU/RkdP2Mi9vzmAs8s
         P+kuRB4kZOagMhPcgkPTo0aZug30HM48KckQc12t7mD1EPaqsMdFzwoE0nHp7n5QBG
         nJigeeAvfAKVARXq2mLV/0vtGZIKAYkYN1+Ju5WM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/60] perf cs-etm: Implement ->evsel_is_auxtrace() callback
Date:   Mon, 20 Apr 2020 08:52:45 -0300
Message-Id: <20200420115316.18781-30-acme@kernel.org>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 62d2f9b9ce1b..3c802fde4954 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -631,6 +631,16 @@ static void cs_etm__free(struct perf_session *session)
 	zfree(&aux);
 }
 
+static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	return evsel->core.attr.type == aux->pmu_type;
+}
+
 static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 {
 	struct machine *machine;
@@ -2618,6 +2628,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace.flush_events = cs_etm__flush_events;
 	etm->auxtrace.free_events = cs_etm__free_events;
 	etm->auxtrace.free = cs_etm__free;
+	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
-- 
2.21.1


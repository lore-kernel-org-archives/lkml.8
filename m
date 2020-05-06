Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FA8C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC482080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778933;
	bh=nzV5wZFnEo1oF076nwRGgp9QzjEaRg95ZgofEOFVtII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r2/dg8W2MtA0m8sXa4pcfPJ4FUJyDKgg1/ika3dmEe4SxqSnZdjdg1xVtZJHNfVCp
	 ndFPvE8Y9k3f6acm53TXyRmYdEzXtxIeJt9WouXkr0lOz9uhS9BXXSISWTGDXir5HF
	 sCUJozKO0Gio5NrnEzHECSWfQ2oaxg/YV6H2nChM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgEFPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgEFPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE2621744;
        Wed,  6 May 2020 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778747;
        bh=nzV5wZFnEo1oF076nwRGgp9QzjEaRg95ZgofEOFVtII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hg/yc3Dmpv/HS9EFzV9+hqR56rOA4Bb+8L0JB7bK+/cb6n651DHSRk7WGE+Hqafup
         Ih32CVvDhIMi07yOLevIIBgRBt7Ab8I4t70Wd5Ls6R/AWdqZE5gzHkUTFebF6Bd7TC
         iFrC3gr4HCyt+62cXnOfH78MO1LddNa/aN3l5Z3k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 53/91] perf evsel: Rename perf_evsel__exit() to evsel__exit()
Date:   Wed,  6 May 2020 12:21:56 -0300
Message-Id: <20200506152234.21977-54-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 4 ++--
 tools/perf/util/evsel.h  | 2 +-
 tools/perf/util/python.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index db6d2a5f9b3c..11e754746984 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1259,7 +1259,7 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 	}
 }
 
-void perf_evsel__exit(struct evsel *evsel)
+void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
@@ -1279,7 +1279,7 @@ void perf_evsel__exit(struct evsel *evsel)
 
 void evsel__delete(struct evsel *evsel)
 {
-	perf_evsel__exit(evsel);
+	evsel__exit(evsel);
 	free(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6187dba21298..2facb16e9f12 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -183,7 +183,7 @@ struct evsel *perf_evsel__new_cycles(bool precise);
 struct tep_event *event_format__new(const char *sys, const char *name);
 
 void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
-void perf_evsel__exit(struct evsel *evsel);
+void evsel__exit(struct evsel *evsel);
 void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 83212c65848b..67810d31f88d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -801,7 +801,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 
 static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 {
-	perf_evsel__exit(&pevsel->evsel);
+	evsel__exit(&pevsel->evsel);
 	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
 }
 
-- 
2.21.1


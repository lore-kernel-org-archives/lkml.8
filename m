Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE133C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC8520775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022412;
	bh=vBbi0nowizeJ2c+yPJoefqUWOWkrwQPoq9xrDyxOX6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1z7gZjygtkp6C4bXaVXfqfSq9kga2yFTXfkngolz0I89m4nLuOBctzPwEHfWXuXRd
	 NpxZpga4cyUg9oRFqzMPms1YQITKVlwl6glET/3WvX8Hb5FmKykzOU8XPRfdpXKnD+
	 BY4Nd3ntz7GEFd2eRLubq6SPexe6CrxtO66am0vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgD0VUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:20:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 838352072D;
        Mon, 27 Apr 2020 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022407;
        bh=vBbi0nowizeJ2c+yPJoefqUWOWkrwQPoq9xrDyxOX6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/jt6empqBs1eb1eEzpl0hcvdmnM8MkGb20z2wvovERzsspyty6MTJsTylBhShiky
         2z8fiGpjXar1VeIdh2jStDnSmxkqom0hjNyqiYwsa8k8Vk6nsqRLmIfMuO8bFGZisN
         BII8LE1AbPxDWFJGZnHgHj8cj4nxLE+JyazuTk+0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 6/7] perf evlist: Allow reusing the side band thread for more purposes
Date:   Mon, 27 Apr 2020 18:19:34 -0300
Message-Id: <20200427211935.25789-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. so far we had just one event in that side band thread, a dummy one
with attr.bpf_event set, so that 'perf record' can go ahead and ask the
kernel for further information about BPF programs being loaded.

Allow for more than one event to be there, so that we can use it as
well for the upcoming --switch-output-event feature.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 22 ++++++++++++++++++++++
 tools/perf/util/evlist.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1d0d36da223b..849058766757 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1777,6 +1777,19 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->core.attr.sample_id_all	  = 1;
+		evsel->core.attr.watermark	  = 1;
+		evsel->core.attr.wakeup_watermark = 1;
+		evsel->side_band.cb   = cb;
+		evsel->side_band.data = data;
+	}
+}
+
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target)
 {
@@ -1788,6 +1801,15 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 	if (perf_evlist__create_maps(evlist, target))
 		goto out_delete_evlist;
 
+	if (evlist->core.nr_entries > 1) {
+		bool can_sample_identifier = perf_can_sample_identifier();
+
+		evlist__for_each_entry(evlist, counter)
+			perf_evsel__set_sample_id(counter, can_sample_identifier);
+
+		perf_evlist__set_id_pos(evlist);
+	}
+
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__open(counter, evlist->core.cpus,
 				     evlist->core.threads) < 0)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0f02408fff3e..1a8a979ae137 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -111,6 +111,7 @@ int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
-- 
2.21.1


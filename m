Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A436EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C6E21532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599540172;
	bh=1VLB/RvnQha8CjbcwJCA39bUqNlzXx3CwWoF1+wVkQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NpfM+ajGT2LG7ny+go/PrbWg7MKU2Zeuk7MvvDmkZPUrmBxcgtiyS1BGa0I1NdERa
	 QMZ8wHf13FORG8BeHwdD4ypQbonInEhGEIYf7hRt+rbrYPsdB2Wr8quAXvi8+yzeHe
	 Op9IMFbYGkquAXxUZ9wWwoxbixwZToTc2pUAk1xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIHEms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIHEml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:42:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81006C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:42:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so9174385pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1X2wgdypEexLJoyJFvgbErcW6sFtqTXmvvhkdoCXtb4=;
        b=sYbEEV3aTFimo35fJALPnPZUfN6NziOkMW9HewicxlH9EijYn5xJP0zEM+7/XXeJm2
         ofZJKdvn4/FeZjJDBsKdA8Swqg5i95BXqRpGfAritJTcP+b1GrteWTk22dkgIG1QH9Gt
         yL8YIMeTFuu1yjBTT0unyElYzj8PgqFj8RlCVEA4nueF5fmTv1cWoNtgyZys6HlfayP4
         lbSv4k7TGo2DB6TAgLxj33QefPwlnBrfiObjgKMNDYdZ7R/C5apc1LoasPsRW2uVBAJx
         bxBpgYtayADl6Uy+jUAf9WbdFyE208LSyHJix9C9dq/9ReEbnqLUtSK/M9yBydJjOfmA
         zrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1X2wgdypEexLJoyJFvgbErcW6sFtqTXmvvhkdoCXtb4=;
        b=V5awRZ+MYOZ087WYzZKdTrxWq504DPih8N69XWLvjBkmN0CvNkEX0naKb8mE4JY6gQ
         eY3/26SAs2Lp6k7DFnyGrTB3BmO0R50j+rb0dgKuT2BpEv6E1SKgSPzofil4e0jq6NiE
         FOACLdC8mFGpT9PrX5cfRq8koksl5ci3pQBL9JTguqAgHvGK7T5OiC4gki+VYNi7sFhB
         Sre3jOaVCP8e1F8ZHOb4bL/xjfznJPkqGmgNKImkJt7FPfmsYodZCGxQi6ICuawSgYBN
         +Py2Fu/iYqOVLTDPTSVSWu830KbDaRIeMeO3bR2HEGmxz1J4GnTT4O15n/Kqi8Ve5iau
         2w8A==
X-Gm-Message-State: AOAM532DFkY/KQKCL52R6/paYbdgbalZRXdT7kVfe9TZApFlk0I+VzvD
        J66F8Jf9XX7HDxLgquVrCyg=
X-Google-Smtp-Source: ABdhPJyg+7zv4hQn+a1FLOaK80AMqwoFtSK0iBQIsy4P/v+w46/AUfId8KFZMSncZSXsuw6SDBed6A==
X-Received: by 2002:a17:902:7895:b029:d0:89f4:621c with SMTP id q21-20020a1709027895b02900d089f4621cmr20971171pll.4.1599540157761;
        Mon, 07 Sep 2020 21:42:37 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q5sm16777625pfn.109.2020.09.07.21.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 21:42:37 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/4] perf evsel: Add evsel__clone() function
Date:   Tue,  8 Sep 2020 13:42:25 +0900
Message-Id: <20200908044228.61197-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200908044228.61197-1-namhyung@kernel.org>
References: <20200908044228.61197-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evsel__clone() is to create an exactly same evsel from same
attributes.  Note that metric events will be handled by later patch.

It will be used by perf stat to generate separate events for each
cgroup.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 57 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 58 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fd865002cbbd..4f50f9499973 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -331,6 +331,63 @@ struct evsel *evsel__new_cycles(bool precise)
 	goto out;
 }
 
+/**
+ * evsel__clone - create a new evsel copied from @orig
+ * @orig: original evsel
+ *
+ * The assumption is that @orig is not configured nor opened yet.
+ * So we only care about the attributes that can be set while it's parsed.
+ */
+struct evsel *evsel__clone(struct evsel *orig)
+{
+	struct evsel *evsel;
+	struct evsel_config_term *pos, *tmp;
+
+	BUG_ON(orig->core.fd);
+
+	evsel = evsel__new(&orig->core.attr);
+	if (evsel == NULL)
+		return NULL;
+
+	*evsel = *orig;
+	evsel->evlist = NULL;
+	INIT_LIST_HEAD(&evsel->core.node);
+
+	evsel->core.cpus = perf_cpu_map__get(orig->core.cpus);
+	evsel->core.own_cpus = perf_cpu_map__get(orig->core.own_cpus);
+	evsel->core.threads = perf_thread_map__get(orig->core.threads);
+	if (orig->name)
+		evsel->name = strdup(orig->name);
+	if (orig->group_name)
+		evsel->group_name = strdup(orig->group_name);
+	if (orig->pmu_name)
+		evsel->pmu_name = strdup(orig->pmu_name);
+
+	INIT_LIST_HEAD(&evsel->config_terms);
+	list_for_each_entry(pos, &orig->config_terms, list) {
+		tmp = malloc(sizeof(*tmp));
+		if (tmp == NULL) {
+			evsel__delete(evsel);
+			evsel = NULL;
+			break;
+		}
+
+		*tmp = *pos;
+		if (tmp->free_str) {
+			tmp->val.str = strdup(pos->val.str);
+			if (tmp->val.str == NULL) {
+				evsel__delete(evsel);
+				evsel = NULL;
+				free(tmp);
+				break;
+			}
+		}
+		list_add_tail(&tmp->list, &evsel->config_terms);
+	}
+
+	return evsel;
+}
+
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35e3f6d66085..507c31d6a389 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -169,6 +169,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
+struct evsel *evsel__clone(struct evsel *orig);
 struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
 
 /*
-- 
2.28.0.526.ge36021eeef-goog


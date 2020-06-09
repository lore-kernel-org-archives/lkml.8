Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298712076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOygoqm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389249AbgFITbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgFITbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:31:07 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A59C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:31:05 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v1so17564512qvx.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cfTAn0LNYLU00F0dbUPQhyJJ5MG3nR6jD1nNWMRLG4c=;
        b=KOygoqm4n/oeoeWDMxxwFtlwF4dI09KSdKn+f3BkKwbwdL6FEbQmz6Lpk8ApcIb7my
         ARQ8IidmjNiSXnLDlJIFtDhPHwSVU0GgeE4H4gngouKcPoE8bMByuPt0mEY7seuqez1q
         ZIfuyJcZvbAC+TNv90ydLFoYMMBb4vdz4SGqxEPEGjp6ucOWqPVI8zoes8VfeSdP9k3v
         9BVKGFMMSiBRWyk4pHs5dj/d8jik3gjXJ1MzADzxhQjt08p/+lKE2ayXUVJU5k7xawYj
         AjB8bI8vdt8AOeyWD/KtRwljwSv3qA9q38b7gJyGWsikR/pO8RdJB0DHHnWiH0rAjn9H
         r7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cfTAn0LNYLU00F0dbUPQhyJJ5MG3nR6jD1nNWMRLG4c=;
        b=q7Ixdkx24Hu6QomaU8GJCwbuLCR3Bg6tOhN82McrnfNo4K0ojGK0kDOvKcS20bNHbU
         ZUzJnSbfIP6vmkCuJxFm/QM4xgvuHIOl3o5fCXezUxvyKKwy2AFAtTWz63fkP+o25zu3
         JbNbZrUoEDSwQiL/msMZJ1yeac2CU9h8SO8jihqYLUBtOcNYJaGsIhcyuWC4WvTzTxKQ
         rJSDO+a7I8VvlJ3dgA7ysnDe2pqKm6oLuD7/A+OjXaiEgeUI3hWcMDj++hLyGbSSwEm3
         lrswwg0LIFkyF3T5fSlczB4bFdGRjWexi8/V2GJGzWCumxH53fw/Bf0DtQMgPNp0Eo1k
         pE8g==
X-Gm-Message-State: AOAM531osRi55XILK7x+2PDVjOcy70zfOQ2BQyiSW49/BCWhgMLSfMpn
        QhXvvzG7r4F9yRuS6xut7JjXG66u1BIKHs76siHv4PlKmT4fNuynLT8fAQssToBccjmu941yZGh
        rY98+Al69xngQ9qnuQleEwBkkSNxtG6uoKe4SOODvRDfLYwo0PDtBnqOKkmZu7NtStiAbg+VR
X-Google-Smtp-Source: ABdhPJyRRZYy7Z3ysCyeZSbZ7tj/T2bu5LxSDMq7PqjsqpRaT8r9oqR5O9YPfY+cKK2TeKD2jQeGOxGcHZ+6
X-Received: by 2002:ad4:48c8:: with SMTP id v8mr5831900qvx.15.1591731064120;
 Tue, 09 Jun 2020 12:31:04 -0700 (PDT)
Date:   Tue,  9 Jun 2020 12:30:50 -0700
Message-Id: <20200609193050.241972-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2] perf headers: fix processing of pmu_mappings
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@elte.hu, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the handling of the env->pmu_mappings string.
It transforms the string from a \0 separated list of value:name pairs
into a space separated list of value:name pairs. This makes it much simpler
to parse looking for a particular value or name.

This version also updates print_pmu_mappings() to handle the new space
separator.

Before: printf(env->pmu_mappings);
14:amd_iommu_1

After: printf(env->pmu_mappings);
14:amd_iommu_1 7:uprobe 5:breakpoint 10:amd_l3 19:amd_iommu_6 8:power 4:cpu 17:amd_iommu_4 15:amd_iommu_2 1:software 6:kprobe 13:amd_iommu_0 9:amd_df 20:amd_iommu_7 18:amd_iommu_5 2:tracepoint 21:msr 12:ibs_op 16:amd_iommu_3 11:ibs_fetch

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/header.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 31a7f278036c..3649c0e1740b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1470,10 +1470,19 @@ static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 			goto error;
 
 		str = tmp + 1;
+
+		tmp = strchr(str, ' ');
+		if (tmp)
+			*tmp = '\0';
+
 		fprintf(fp, "%s%s = %" PRIu32, delimiter, str, type);
 
 		delimiter = ", ";
-		str += strlen(str) + 1;
+
+		if (tmp) {
+			*tmp = ' ';
+			str = tmp + 1;
+		}
 		pmu_num--;
 	}
 
@@ -1956,13 +1965,15 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 {
 	char *name;
-	u32 pmu_num;
+	u32 pmu_num, o_num;
 	u32 type;
 	struct strbuf sb;
 
 	if (do_read_u32(ff, &pmu_num))
 		return -1;
 
+	o_num = pmu_num;
+
 	if (!pmu_num) {
 		pr_debug("pmu mappings not available\n");
 		return 0;
@@ -1980,10 +1991,11 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		if (!name)
 			goto error;
 
-		if (strbuf_addf(&sb, "%u:%s", type, name) < 0)
+		/* add proper spacing between entries */
+		if (pmu_num < o_num && strbuf_add(&sb, " ", 1) < 0)
 			goto error;
-		/* include a NULL character at the end */
-		if (strbuf_add(&sb, "", 1) < 0)
+
+		if (strbuf_addf(&sb, "%u:%s", type, name) < 0)
 			goto error;
 
 		if (!strcmp(name, "msr"))
@@ -1992,6 +2004,9 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 		free(name);
 		pmu_num--;
 	}
+	/* include a NULL character at the end */
+	if (strbuf_add(&sb, "", 1) < 0)
+		goto error;
 	ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
 	return 0;
 
-- 
2.27.0.278.ge193c7cf3a9-goog


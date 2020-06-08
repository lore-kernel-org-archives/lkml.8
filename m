Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199DCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B102076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2f06wZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgFHQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:18:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CAC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 09:18:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d187so14796037qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=y5bwuBaAQKbefzvBkCWPNdTUUcrdGa8IJ8FFc0iT38o=;
        b=T2f06wZzn7hB1Kmqg3hBURN7FlYoJsg4ETQkjx2/TAhBbB/DMMiSqiGDZ0AnPCT0fQ
         dl9jnzv/hBMgPvkdAFd8tUX9kSHy1lxS4iizF78OzKzsQ6J3Nj32oooSyzRJ7ZBiQ3Zo
         YV5unLyj2odA5grHvJ6hnvq64u5Ps//p3cuAL1+U4ZSOlmlhk10gnvKIsjnHm2s5NkTi
         t2R0LMYoSGiMz9gF+9mPSiJgj8AHxL1DoqlkQFuwdypS1jiX/G4WZaYja0TuH0qQUiJp
         Iwl1Jl5jDQujgfFITAr8PQUCXKDDgnLHHTHH9p0EBaTfzWkaUu8Dh2IijxiCQtm8VTYN
         cxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=y5bwuBaAQKbefzvBkCWPNdTUUcrdGa8IJ8FFc0iT38o=;
        b=oiVuvri/Eczkpk8/I/eadtQTSou64Q2ccg1NV43hGbSwW8tZYxemDULtuIuYB58bxw
         zxmkZfcoTjiZCZMFRNWxlsStqwG/Dl/Gn+eotf5AvJIs80YbUT1kdZvbh0OiuYtuyIjH
         QgHco5FNSNW19+/O5rpLfrwE8eb7a2xZcU4iXQO3UJa6P/5fMBENoZAHFikWponjmtKU
         BwLveMdbXTKAYZEkO7Pn0pxm8o7Ob1h0oJJLP+PYR45vYYtOMCgWDR/d+SNAMFEDizHy
         KpS9EglLoTCoq0Q6OULzf47tPY6YgewpaYKw3iUrqez4k0MwMUjaE6Vrao+PO+YF2Vv5
         bGAQ==
X-Gm-Message-State: AOAM531VLQGEUK4lLq2KH2p5E+E7h/IdU8Ucc1vm/zTeOtGNiso2dIO9
        tPuziALUs0GtEt+VAiYXx/KytsV45cH79D+eelKklk9Jkx3xy33cXSt0TQIgp7CC1Hp/9FlduFS
        N5D/L7t2VaDGJ/IIWZWkx7xxFDVeyIv+BZfia/Z9zUzhI4oRJta14q11KRy3TSpzam5Bdkk4B
X-Google-Smtp-Source: ABdhPJzJ71/INV0ivShmKQoF0oR8tzl89XL+G1nuQSafFU3gWjMejH4vgXmn+FHRzXFZBvI+Tw51e20hmO46
X-Received: by 2002:a0c:e4d3:: with SMTP id g19mr23647362qvm.42.1591633103188;
 Mon, 08 Jun 2020 09:18:23 -0700 (PDT)
Date:   Mon,  8 Jun 2020 09:18:05 -0700
Message-Id: <20200608161805.65841-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] perf headers: fix processing of pmu_mappings
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@elte.hu, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in process_pmu_mappings() where the code
would not produce an env->pmu_mappings string that was easily parsable.
The function parses the PMU_MAPPING header information into a string
consisting of value:name pairs where value is the PMU type identifier
and name is the PMU name, e.g., 10:ibs_fetch. As it was, the code
was producing a truncated string with only the first pair showing
even though the rest was there but after the \0.
This patch fixes the problem byt adding a proper white space between
pairs and moving the \0 termination to the end. With this patch applied,
all pairs appear and are easily parsed.

Before:
14:amd_iommu_1

After:
14:amd_iommu_1 7:uprobe 5:breakpoint 10:amd_l3 19:amd_iommu_6 8:power 4:cpu 17:amd_iommu_4 15:amd_iommu_2 1:software 6:kprobe 13:amd_iommu_0 9:amd_df 20:amd_iommu_7 18:amd_iommu_5 2:tracepoint 21:msr 12:ibs_op 16:amd_iommu_3 11:ibs_fetch

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/header.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7a67d017d72c3..cf72124da9350 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2462,13 +2462,15 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2486,10 +2488,11 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2498,6 +2501,9 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
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

